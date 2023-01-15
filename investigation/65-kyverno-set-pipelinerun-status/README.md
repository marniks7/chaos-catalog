# Set PipelineRunPending

Goal: for all `PipelineRun`'s with empty `spec.status` set `spec.status` = `PipelineRunPending`
Maybe filter by some specifal label.

Result: **failed**

## Reason
https://github.com/kyverno/kyverno/issues/2843