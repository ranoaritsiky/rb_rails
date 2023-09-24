# test/models/reporter_test.rb
require 'test_helper'

class ReporterTest < ActiveSupport::TestCase
  def setup
    @company = Company.create(name: "Example Company")
    @reporter = Reporter.new(name: "John Doe", email: "john@example.com")
    @reporter.company = @company
  end

  test "should be valid" do
    assert @reporter.valid?
  end

  test "should belong to a company" do
    assert_equal @company, @reporter.company
  end
end
