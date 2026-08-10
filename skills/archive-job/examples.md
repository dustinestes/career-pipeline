# archive-job Examples

## Example 1: Rejection after application

**Input:** Company: Files.com, Role: Infrastructure Engineer

**Before:**
```
3 - Applications/Files.com/Infrastructure Engineer/
  assessment.md
  cover-letter-filescom.html
  ...
```

**Command:**
```bash
.cursor/skills/archive-job/scripts/archive-job.sh "Files.com" "Infrastructure Engineer" "Rejected — no response after 3 weeks"
```

**After:**
```
3 - Applications/# - Archive/Files.com/Infrastructure Engineer/
  notes.md
  assessment.md
  ...
```

If `Files.com` had no other active roles, `3 - Applications/Files.com/` is removed.

## Example 2: User withdrew

**Input:** User says "archive the DoorDash application, I withdrew"

Agent confirms path, runs script with reason "Withdrew — accepted another offer", offers commit.

## Edge cases

- **Destination exists:** Script exits with error; do not overwrite
- **Legacy folder names in archive:** Do not rename (e.g. old `1 - Emails` vs `0 - Email`)
- **Multiple roles same company:** Only remove company folder when zero roles remain under `3 - Applications/<Company>/`
