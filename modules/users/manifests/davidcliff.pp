# Creates davidcliff user
class users::davidcliff {
  govuk_user { 'davidcliff':
    fullname => 'David Cliff',
    email    => 'david.cliff@digital.cabinet-office.gov.uk',
    ssh_key  => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6kTpy2KaYo/Ai7xOWuKMnpi+a68Ur2fRVXuOWw+mkHH4RDPLJbU6rH19vwTg8rKRemQy8f4haenB9fyGE9VLgHXEJPsnpjTiS6dREweh8P+V3/JyjIlmznZbGLgJt6cFy4T2L5PRtEZVvmLFQw48sLOvR4fmP7qTUNuYlBf+sjbrpM2PcTMMG/QQJHBZlZQhNqJQf/1OFMVdGJ83VsxPfj9VZNFPnaWRylAJY48JscFHrPIOUVuR0yzQSrbE071N3m8NopqMc2KJgLTRRLP8puBDtsF7yPvYGmTX64LBAuV2gzl182utRP2RBa3Tzl/f0vuRAgUhO7dkHBbp2BoRmzZAtjgXgaHvzFAg/2U91oj0ceEYCLZ3nXdc/lgs6QVfDRTjJIpfdnQDJz66SE7lxLJoJ5t1b4DeWqfBbaikN3qQb4PfuSrafWCS5Z81qHjZ9L2eV22IPmGoOBfQq5ynJ2CeIapesOLTxfFXDUKoabvp30BqYpc2FtdNUSbzvlpU=',
  }
}
