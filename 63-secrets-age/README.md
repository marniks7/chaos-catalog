# Age

https://github.com/FiloSottile/age

1. encrypt: `age -p unsealed-secret.yaml > .result/unsealed-secret.yaml.age`
   * passphrase: `firm-squeeze-annual-noise-cute-practice-wise-one-summer-document` (! should be secured ! published only as an example)
2. decrypt: `age -d .result/unsealed-secret.yaml.age > unsealed-secret.yaml`
   * passphrare: the same as above