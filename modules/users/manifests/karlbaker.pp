# Creates the user scheme for Karl Baker
class users::karlbaker {
  govuk_user { 'karlbaker':
    fullname => 'Karl Baker',
    email    => 'karl.baker@digital.cabinet-office.gov.uk',
    ssh_key  => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHFbzqpfGmgWsnpaPG6kOw9yuB/jwV3ve+9OBqPfN3hSg92HSPdbQF2un37mv6LOli9mSAXioMm1GXaPyNMcCg2C/NFsehpVJjoUXkuho/xsui8b7WDCs3zjVi/ko7T1aH4wbZf1mUR3CRY88VeX2UiVyqG7pGbvMzTOG7uoJvvh/7gxPdAxB8pzfRTdrD65ohVkJggRDDT1CZjBcTg2dnZc5xsMnhDhMVtSLUZ/AqczhSFwfFCczy6wbgCTO7RtrRABd5bmr6WZ3LFWrLwF0pJ3wTrhMz94Ak3mVIOqJSGJKMRsdWVKRx0Ja6IUlKDzGuq3Bb8qFdSSI92Nd7eoaF cardno:000610162345',
  }
}
