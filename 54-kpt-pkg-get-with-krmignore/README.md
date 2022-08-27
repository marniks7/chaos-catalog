# .krmignore

Goal: exclude certain files from `kpt pkg get`, so client should no receive them

Result: **failed**


## Execution
```
kpt pkg get https://github.com/marniks7/chaos-catalog/54-kpt-pkg-get-with-krmignore
```