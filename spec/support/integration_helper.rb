require "open3"

module IntegrationHelpers
  def run_wsdirector(scenario_path, chdir: nil, success: true, failure: false, options: "", env: {})
    cli_path = File.expand_path("../../../bin/wsdirector", __FILE__)

    output, status = Open3.capture2(
      env,
      "bundle exec #{cli_path} #{EchoServer.url} #{scenario_path} #{options}",
      chdir: chdir || File.expand_path("../../fixtures", __FILE__)
    )
    expect(status).to be_success, "Test #{scenario_path} #{options} failed with: #{output}" if success
    expect(status).not_to be_success, "Test #{scenario_path} #{options} succeed with: #{output}" if failure
    output
  end

  def test_script(name = "__test__")
    File.expand_path("../../fixtures/#{name}.yml", __FILE__)
  end
end
