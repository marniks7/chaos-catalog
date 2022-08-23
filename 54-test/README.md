# chaos-catalog

## Description
Catalog for all chaos resources

## Usage

### Fetch the package
`kpt pkg get https://github.com/marniks7/chaos-catalog chaos-catalog`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree chaos-catalog`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init chaos-catalog
kpt live apply chaos-catalog --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/
