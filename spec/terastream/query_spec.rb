require 'spec_helper'

describe Terastream::Query do
  let(:statement)  { double("statement", setQueryTimeout: true) }
  let(:config)     { double("config", timeout: 120) }
  let(:connection) { double("connection", create_statement: statement,
                            config: config, formatter: nil, output: nil) }

  describe '.build' do
    subject { Terastream::Query }

    before do
      expect(subject).to receive(:new).with(connection)
    end

    it 'builds a Query instance' do
      subject.build(connection)
    end
  end

  describe '#execute' do
    subject { Terastream::Query.build(connection) }

    let(:query_string) { "select count(*) from sometable" }

    before :each do
      expect(Terastream::Query::ResultSet).to receive(:new).and_return([])
      expect(statement).to receive(:execute_query).with(query_string).and_return([])
    end

    it 'sets executed to true' do
      expect(subject.executed?).to eq(false)
      subject.execute(query_string)
      expect(subject.executed?).to eq(true)
    end
  end
end
