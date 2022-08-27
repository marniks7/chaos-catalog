# Set Field

Goal: all `PipelineRun` should have `Cancelled` status by default.

Reason:
1. During deploy process `PipelineRun` should not be executed
2. In order to be able to deploy them to environment with **predefined parameters** and then **Re-Run**

Result: **passed**