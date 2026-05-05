---
name: pr-review
description: "Use this skill when the user wants a quick AI-opinion first-pass on a pull request using local diff and metadata files, before doing their own human review. Triggers include: 'review this PR', 'first pass on this PR', 'what does AI think of this diff', or any request to get AI feedback from local files (/tmp/pr.diff, /tmp/pr-meta.txt, or similar). The goal is a fast, opinionated scan that surfaces things worth a second look — not a comprehensive audit. Do NOT use for live GitHub API interactions, posting review comments, or approving/merging PRs."
---

# PR Review — AI First-Pass Opinion

## Purpose

Get a fast, opinionated AI read on a PR *before* your own review. The goal is to surface
things worth a second look — not to replace your judgment. Treat findings as leads, not verdicts.

---

## Step 0 — Dump PR data locally

```bash
PR=<PR_NUMBER>

gh pr diff "$PR"     > /tmp/pr.diff
gh pr view "$PR"     > /tmp/pr-meta.txt
gh pr checkout "$PR"   # full codebase context for following call chains
```

---

## Step 1 — Prompt template




```


Give me your honest first-pass opinion on this PR.

- Diff: /tmp/pr.diff
- PR description: /tmp/pr-meta.txt
- Full codebase is checked out in the current directory — use it for context


Before reviewing the diff, read /tmp/pr-meta.txt to understand
what the author intended. Use that intent to judge whether the
implementation actually does what it claims.

I want your actual opinion, not a checklist. Focus on:
- Anything that looks wrong or risky
- Logic that seems off given how the rest of the codebase works
- Edge cases or error paths the author likely didn't consider
- Anything surprising or that made you pause

For each finding, tell me:
1. What you noticed
2. Why it matters
3. What to look at (file + line)

Skip style/formatting nits. Skip things that look intentional and fine.
Be direct. If something looks bad, say so. If the PR looks solid, say that too.

Output to terminal only. No GitHub API calls, no comments, no actions.
```

---

## Step 2 — Expected output shape

```
## First-pass: <PR title>

**Overall impression:** [1–2 sentence gut read — risky, straightforward, needs scrutiny in one area, etc.]

---

**Things worth a second look:**

[auth/middleware.go:112]
Token expiry is checked after the DB query, not before. If the DB is slow,
an expired token can complete a write. Probably worth inverting the check.

[worker/queue.go:58]
The retry loop has no backoff and no max-retry cap. Under load this will
hammer the downstream service. Intentional?

---

**Looks fine:**
- Migration is additive only.
- The new cache layer correctly invalidates on write.
```

---

## Step 3 — Handling large diffs

```bash
# Check size first
wc -l /tmp/pr.diff

# List files touched — skip generated/vendored ones
grep '^diff --git' /tmp/pr.diff | awk '{print $3}' | sed 's|a/||'

# Pull a single file's diff if you want to focus
sed -n '/^diff --git a\/path\/to\/file/,/^diff --git/p' /tmp/pr.diff
```

For diffs > 800 lines, tell the model which files matter:

```
Focus on src/core/ and internal/api/. Skip anything under vendor/ or *.pb.go.
```

---

## Tips

- `git log --oneline origin/main..HEAD` gives you the commit breakdown — useful context to paste in for multi-commit PRs.
- If a finding seems wrong, it often means there's context the model didn't have. That's useful signal too — add a comment explaining the intent.
- Generated files (protobuf, mocks, bindata): skip unless the generator config itself changed.
