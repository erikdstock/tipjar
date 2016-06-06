module WebmockHelper
  def api_stub(file)
    File.read("spec/support/api_responses/#{file}")
  end

  # Turn object into json string for easier stubbing
  # Not sure this will work without some janky requiring
  # maybe: module Stub; def get; return {foobar: 'stub'}; end; end
  #
  # def json_stub(file)
  #   require_relative "api_responses/#{file}"
  #   stub = Stub.get
  #   JSON.generate(stub)
  # end
end
