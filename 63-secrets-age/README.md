# Age

https://github.com/FiloSottile/age

## Simple case
1. encrypt: `age -p unsealed-secret.yaml > .result/sealed-secret.yaml.age`
   * passphrase: (! should be secured ! published only as an example) `firm-squeeze-annual-noise-cute-practice-wise-one-summer-document` 
2. decrypt: `age -d .result/sealed-secret.yaml.age > unsealed-secret.yaml`
   * passphrase: the same as above

## Recipient case
1. generate public \ private keys or in other words recipient \ identity keys: `age-keygen`
   * public key: `age16jes4v5d3mj7m5zw9suhc05v4xhc7dg2us9f0tk704vfsv7lhv0qj0gpsl`
   * private key: (! should be secured ! published only as an example) `AGE-SECRET-KEY-1E8C3P7G7Z5R4RJ9HU9YE6FVMXWEU2S2382C6QKG43L5W077DT4MQCRQYYX`
2. store private key `touch identity.txt` (store somewhere safe, not in repo) and put private key from above
3. encrypt: `age -o .result/sealed-secret.yaml.recipient.age -r age16jes4v5d3mj7m5zw9suhc05v4xhc7dg2us9f0tk704vfsv7lhv0qj0gpsl unsealed-secret.yaml`
4. decrypt: `age --decrypt -o unsealed-secret.yaml -i identity.txt .result/sealed-secret.yaml.recipient.age`