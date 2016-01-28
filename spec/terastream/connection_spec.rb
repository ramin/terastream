require 'spec_helper'

describe Terastream::Connection do
  describe '.initialize' do
    it 'creates a config object' do
      expect(subject.config).to be_an_instance_of(Terastream::Config)
    end

    it 'creates will pass an options hash to the config object' do
      instance = Terastream::Connection.new(username: "yeah-son")
      expect(instance.config.username).to eq("yeah-son")
    end

    it 'has a nil connection until a query is executed' do
      expect(subject.instance_variable_get(:@connection)).to eq(nil)
    end

    it 'has a nil output' do
      expect(subject.instance_variable_get(:@output)).to eq(nil)
    end

    it 'defaults to the record formatter' do
      expect(subject.instance_variable_get(:@formatter)).to be_an_instance_of(Terastream::Query::RecordsBuilder)
    end
  end

  describe '#connection_string' do
    it 'builds a string using the configured hostname' do
      hostname = "placefullofdata.location"
      subject.hostname = hostname
      expected = "jdbc:teradata://#{hostname}/tmode=TERA,autocommit=on,charset=UTF8,sessions=1"
      expect(subject.send(:connection_string)).to eq(expected)
    end
  end

  context 'allows setting config through connection instane' do
    it 'passes username to the config' do
      subject.username = "i-pass-through"
      expect(subject.config.username).to eq("i-pass-through")
    end

    it 'passes password to the config' do
      subject.password = "i-pass-through"
      expect(subject.config.password).to eq("i-pass-through")
    end

    it 'passes hostname to the config' do
      subject.hostname = "i-pass-through"
      expect(subject.config.hostname).to eq("i-pass-through")
    end

    it 'passes timeout to the config' do
      subject.timeout = "i-pass-through"
      expect(subject.config.timeout).to eq("i-pass-through")
    end
  end
end
