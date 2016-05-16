module WebmockHelper
  def api_stub(file)
    File.read("spec/support/api_responses/#{file}")
  end
end
