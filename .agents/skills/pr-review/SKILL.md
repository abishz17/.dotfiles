---
name: pr-review
description: Review the changes since a fixed point (commit, branch, tag, or merge-base) across three axes — Spec (does the code do what the ticket asked?), Standards (does it follow this repo's conventions?), and Quality (bugs, edge cases, missed approaches). Runs all three as parallel sub-agents. Use when the user wants to review a PR, a branch, WIP changes, or asks to "review since X". The spec can be pasted directly (Jira ticket, Linear issue, PRD text) — no MCP needed. Replaces the separate pr-review skill.
---

# Review

Three-axis review of the diff between `HEAD` and a fixed point:

- **Spec** — does the code do what was asked?
- **Standards** — does it follow this repo's conventions?
- **Quality** — bugs, edge cases, poor approaches, things that will cause pain later

All three run as **parallel sub-agents** so their contexts don't bleed into each other.

---

## Step 1 — Get the diff

The user must supply a fixed point — a commit SHA, branch name, tag, `main`, `HEAD~5`, etc.

If they didn't, ask once: *"Review against what — `main`, a branch, or a commit?"* Don't proceed until you have it.

```bash
git diff <fixed-point>...HEAD    # three-dot: against merge-base
git log <fixed-point>..HEAD --oneline
```

For large diffs (> 800 lines), list files first and ask the user if any should be skipped (generated files, vendored deps, migrations):

```bash
grep '^diff --git' /tmp/pr.diff | awk '{print $3}' | sed 's|a/||'
```

---

## Step 2 — Collect inputs for each axis

### Spec source

Accept in this priority order:

1. **Pasted text** — Jira ticket, Linear issue, PRD excerpt pasted directly into the prompt. Use as-is.
2. **Issue reference** — scan `git log` for `#123`, `Closes #45`, `Fixes #67`. Fetch if the tracker is accessible.
3. **File path** — user passed a path to a spec under `docs/`, `specs/`, `.scratch/`, or similar.
4. **Branch-name match** — spec file whose name matches the current branch.

If nothing is found, ask once: *"What's the spec — Jira ticket, issue number, or a file?"* If they say there isn't one, the Spec sub-agent skips and reports "no spec provided."

Do **not** infer a spec from the code. That's circular.

### Standards source

Scan for any file documenting how code should be written:

- `CLAUDE.md`, `AGENTS.md`, `CONTRIBUTING.md`
- `CONTEXT.md`, `CONTEXT-MAP.md`, per-directory `CONTEXT.md`
- `docs/adr/` (ADRs count as standards)
- `STYLE.md`, `STANDARDS.md`, `STYLEGUIDE.md`
- `.editorconfig`, `eslint.config.*`, `biome.json`, `prettier.config.*`, `tsconfig.json` — note existence but skip re-checking what tooling already enforces

**If no standards docs exist:** the Standards sub-agent infers conventions from the existing codebase — reads a representative sample of files outside the diff and derives the patterns actually in use (naming, error handling style, abstraction patterns, etc.). It reports these inferred conventions upfront so findings are traceable. This is more useful than skipping the axis.

---

## Step 3 — Spawn three sub-agents in parallel

One `Agent` tool call per axis, sent together.

---

**Spec sub-agent prompt:**

```
Your job: check whether the diff faithfully implements what was asked for.

Diff: git diff <fixed-point>...HEAD
Commits: <git log output>

Spec:
<pasted Jira ticket / issue body / PRD / file contents>

Instructions:
- Read the spec first, then the diff.
- Report:
  (a) Requirements the spec asked for that are missing or only partially done.
  (b) Behaviour in the diff that wasn't asked for — scope creep worth flagging.
  (c) Requirements that look implemented but where the implementation is wrong — quote the relevant spec line.
- Do not invent requirements. Only report against what the spec actually says.
- If no spec was provided, report "no spec provided" and stop.
- One short paragraph per finding. No filler. Length follows the findings.
- Confidence: if you're not certain a requirement is missing or wrong, say so explicitly — "worth verifying" vs "this is missing". Do not state findings with more confidence than you actually have.
```

---

**Standards sub-agent prompt:**

```
Your job: check whether the diff follows this repo's coding conventions.

Diff: git diff <fixed-point>...HEAD
Commits: <git log output>

Standards docs: <list of files, or "none found">

Instructions:
- If standards docs exist: read them, then read the diff. Report every violation. Cite the rule (doc file + rule text) and the location in the diff.
- If no standards docs exist: read a representative sample of existing files outside the diff to infer the conventions actually in use. State the inferred conventions upfront, then report where the diff deviates.
- Distinguish hard violations (clear breach) from judgement calls (debatable).
- Skip anything tooling already enforces (lint, format).
- One short paragraph per finding. No filler. Length follows the findings.
- Confidence: if you're unsure whether something violates a convention, say so — "possible violation, worth checking" vs "this breaks the rule". Never invent a rule to justify a finding. If you can't cite it, don't flag it.
```

---

**Quality sub-agent prompt:**

```
Your job: find bugs, missed edge cases, poor approaches, and things that will cause pain later.

Diff: git diff <fixed-point>...HEAD
Commits: <git log output>
Full codebase is checked out — use it to follow call chains and understand context beyond the diff.

Instructions:
- Read the diff. For anything non-trivial, read the surrounding code in the codebase to understand intent and usage.
- Look for:
  (a) Logic errors and incorrect assumptions
  (b) Unhandled edge cases and missing input validation
  (c) Missing or swallowed error handling
  (d) Concurrency issues (races, lock ordering, shared state)
  (e) Approaches that work but are fragile, hard to extend, or will hurt under load or at scale
  (f) Anything that made you pause — trust that instinct and explain why
- For each finding: state what you noticed, why it matters, file + rough line.
- Skip style/formatting. Skip things that are clearly intentional and fine.
- If the diff looks solid, say so — "no significant quality issues" is a valid output.
- Be direct. If something looks bad, say it. One short paragraph per finding. No filler.
- For each finding, briefly explain the *why* — what can go wrong, what scenario breaks it, why the alternative is better. Don't just flag; teach.
- Confidence: distinguish "this is a bug" from "this looks risky, worth verifying". If a pattern seems off but you lack enough context to be certain, say that — don't invent a failure scenario to justify the flag. Uncertain findings are still useful; false confident ones are noise.
```

---

## Step 4 — Aggregate

Present findings under three headings. Do **not** merge or rerank across axes.

```
## Spec
<sub-agent output>

## Standards
<sub-agent output>

## Quality
<sub-agent output>

## Summary
Spec:      N findings (worst: <one line or "none">)
Standards: N findings (worst: <one line or "none">)
Quality:   N findings (worst: <one line or "none">)
```

"No findings" on an axis is explicit signal, not silence.

---


## Why three axes

Each catches different things:

| Scenario | Spec | Standards | Quality |
|---|---|---|---|
| Right feature, wrong implementation | ✅ | ✅ | ❌ |
| Correct logic, breaks repo conventions | ✅ | ❌ | ✅ |
| Wrong feature implemented cleanly | ❌ | ✅ | ✅ |
| Works but fragile under load | ✅ | ✅ | ❌ |

Collapsing them into one report lets the noisier axis drown out the others.
