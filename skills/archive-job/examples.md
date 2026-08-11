# archive-job Examples

## Example 1: Rejection after application

**Input:** Company: Files.com, Role: Infrastructure Engineer

**Before:**
```
submissions/Files.com/Infrastructure Engineer/
  assessment.md
  cover-letter-filescom.html
  ...
```

**Command:**
```bash
bash "<path-to-archive-job-skill>/scripts/archive-job.sh" "Files.com" "Infrastructure Engineer" "Rejected — no response after 3 weeks"
```
(cwd = job-search workspace root)
**After:**
```
submissions/.archive/Files.com/Infrastructure Engineer/
  notes.md
  assessment.md
  ...
```

If `Files.com` had no other active roles, `submissions/Files.com/` is removed.

## Example 2: User withdrew

**Input:** User says "archive the DoorDash application, I withdrew"

Agent confirms path, runs script with reason "Withdrew — accepted another offer", offers commit.

## Edge cases

- **Destination exists:** Script exits with error; do not overwrite
- **Legacy folder names in archive:** Do not rename (e.g. old `1 - Emails` vs `0 - Email`)
- **Multiple roles same company:** Only remove company folder when zero roles remain under `submissions/<Company>/`
