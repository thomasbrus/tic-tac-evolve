---
name: code-quality
description: "Review code quality after implementation or refactoring, including mixed responsibilities, abstraction levels, and maintainability. Use after code changes or when asked to review code quality."
argument-hint: "Optional files or changes to review"
user-invocable: true
---

# Code quality review

1. Inspect the changed code and enough surrounding context to understand its purpose, existing patterns, and observable behavior. Include related tests and call sites where relevant.
2. Read each changed method or component for a clear purpose and consistent level of abstraction. Look for mixed responsibilities, implementation details obscuring the main flow, duplication, unclear names, and complexity that would make future changes or refactoring harder. Check that classes, including test classes, live in separate, predictably named files and that tests mirror the classes they exercise.
3. Judge complexity in context, not by an arbitrary line-count limit. A longer method can be appropriate; extract a meaningful responsibility when it clarifies intent, but avoid fragmented helpers or abstraction for its own sake.
4. Check that error handling, edge cases, and tests still cover the intended behavior. Fix issues caused by or tightly coupled to the change; avoid unrelated rewrites. Preserve behavior unless the task calls for a change.
5. Run the smallest relevant tests or checks after any changes. Report unresolved findings and verification failures explicitly; do not claim a clean review without examining the code.
