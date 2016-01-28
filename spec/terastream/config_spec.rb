require 'spec_helper'

describe Terastream::Config do
  context 'can take an options hash at initialization' do
    let(:hostname) { "somehost.someplace" }
    let(:username) { "ghostface" }
    let(:password) { "starkenterprises" }
    let(:timeout)  { 3000 }

    let(:options)  {
      {
        hostname: hostname,
        username: username,
        password: password,
        timeout: timeout,
      }
    }

    subject{ Terastream::Config.new(options) }

    it 'is allows hostname to be set' do
      expect(subject.hostname).to eq(hostname)
    end

    it 'is allows username to be set' do
      expect(subject.username).to eq(username)
    end

    it 'is allows password to be set' do
      expect(subject.password).to eq(password)
    end
  end

  context 'can set options as accessors' do
    it 'is allows hostname to be set' do
      subject.hostname = "another.location"
      expect(subject.hostname).to eq("another.location")
    end

    it 'is allows username to be set' do
      subject.username = "another-user"
      expect(subject.username).to eq("another-user")
    end

    it 'is allows password to be set' do
      subject.password = "123password"
      expect(subject.password).to eq("123password")
    end
  end

  describe '@timeout' do
    it 'defaults to 240 if no options are set' do
      expect(subject.timeout).to eq(240)
    end
  end
end
