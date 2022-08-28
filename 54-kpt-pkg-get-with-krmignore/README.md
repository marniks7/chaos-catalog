# .krmignore

Goal: exclude certain files from `kpt pkg get` with [.krmignore](.krmignore), so client should not receive them

Result: **failed**

Reason: .krmignore doesn't help with that. no idea if it should


## Execution
```
kpt pkg get https://github.com/marniks7/chaos-catalog/54-kpt-pkg-get-with-krmignore
```