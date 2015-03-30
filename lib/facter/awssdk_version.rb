require 'facter'
awssdk_version = Facter::Core::Execution.exec(gem list aws-sdk |cut -f2 -d\( | sed 's/)$//' | uniq)
if awssdk_verion(defined) then 
  facter.add("awssdk_version") do
    setcode do
      Facter.value(awssdk_version)
    end
  end
end
