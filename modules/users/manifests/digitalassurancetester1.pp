# Creates the digitalassurancetester1 user
class users::digitalassurancetester1 {
  govuk_user { 'digitalassurancetester1':
    fullname => 'digitalassurancetester1',
    email    => 'digitalassurancetester1@digital.cabinet-office.gov.uk',
    ssh_key  => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDeIl2Sb58lTghd1hok5z8CO9nfU1MRNuz7nsNnsGexuqXw/SjswL66sWHsr0FdrivrCO2aukt3528w2F7Q8pd3Ew4GddEZgGPirmjuY+ntZWbayUPI0RKxoCDEVOSI0ij1HGSOW13FVFd4iHpH+zb3F3RR+hjBZ0vyRsWqxrMfjeEanprZiFYzGC+nz0E6eDIZVB0HaMoWF+Hrht929YxqToN0gvmBpdkAYoA38lqTo5yMUPuV63KEbJpMgc7XoKcZTay59QkTfLVH66SadWVkVySj4Y/pb/PeCD3i3wKYz/VEqeLeUQ3Y5WGlGjaVD2PRDBXnC6YvH9uuze3typSVB4WuD3nXZUd5i3+T642PLd2NK6RP8zEd6+Qxe+Hp0Qp5IeSthKuzZhABkTg09zFjwpIBZ/XRvWVlrP9OnEqxm9k/0Z6hcPsRlwHupGTAVNoO0tAgPD56m18IGxMeXRmBa8y0bZ4qU3Pd1n1k4CpVqafEUsS5Lxsv/HTqih2rEzpMhVwGt1yXIBLr/Hwjcb+EqOGO4GuogAOQcdBTi20QI05GYwIHlQcG8FT+e6B8HBR4O/NWenBzYlrTpn+aFPi8H15McNXoQHV2GSQ79SyI4zBiqQVmB9jRb0vjTPW1f7/dAKqU3Z7RfkkUxCoNef6OiK4lspymCJ7UFpTU0a04qQ== root@mykali',
  }
}
