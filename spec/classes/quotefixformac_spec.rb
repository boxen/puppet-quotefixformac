require "spec_helper"

describe "quotefixformac" do
  let(:facts) { {:boxen_user => "sr"} }
  let(:params) { {:version => "1" } }

  it do
    should contain_boxen__osx_defaults("Enable Mail.app plugin support").
      with({
      :domain => "com.apple.mail",
      :key => "EnableBundles",
      :type => "bool",
      :value => "true"
    })
  end

  it do
    should contain_boxen__osx_defaults("Set Mail.app Bundle Compatibility Version").
      with({
        :domain => "com.apple.mail",
        :key => "BundleCompatibilityVersion",
        :type => "string",
        :value => "3"
    })
  end

  it do
    should contain_file("/Users/sr/Library/Mail/Bundles").
      with(:ensure => :directory)
  end

  it do
    should contain_exec("quotefixformac-download").
      with({
        :creates => "/tmp/QuoteFix-1.zip",
      })
  end

  it do
    should contain_exec("quotefixformac-extract").
      with({
        :creates => "/tmp/QuoteFix-1",
        :refreshonly => true,
      }).
      that_requires("Exec[quotefixformac-download]")
  end

  it do
    should contain_file("/Users/sr/Library/Mail/Bundles/QuoteFix.mailbundle").
      with({
        :ensure => "present",
        :source => "/tmp/QuoteFix-1/QuoteFix.mailbundle",
        :replace => true,
      }).
      that_requires("Exec[quotefixformac-extract]")
  end
end
