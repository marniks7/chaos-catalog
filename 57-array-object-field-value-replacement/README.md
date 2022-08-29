# Replace field value in array of objects

Example:
```
params:
  - name: namespace
    value: nnnn
  - name: test
    value: tttt
```
`nnnn` should be replaced to something else based on `name: namespace`

Result: **passed**, see [.result](.result)

Command: `kpt fn source . | kpt fn sink .result && kpt fn render .result`