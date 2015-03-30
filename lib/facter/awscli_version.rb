require 'facter'
osfamily = Facter.value(:osfamily)
case osfamily
  when RedHat
    awscli_version = Facter::Core::Execution.exec("/usr/bin/aws --version")
  when Debian
    awscli_version = Facter::Core::Execution.exec("/usr/local/bin/aws --version")
end
Facter.add(awscli_version) do
  setcode do
    Facter.value(awscli_version)
  end
end
