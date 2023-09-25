# test/models/reporter_test.rb
require 'test_helper'

class ReporterTest < ActiveSupport::TestCase
  def setup
    @company = Company.create(name: "Example Company")
    @reporter = Reporter.new(name: "John Doe", email: "john@example.com", company_id: 2)
    @reporter.company = @company
  end

  test "should be valid" do
    assert @reporter.valid?
  end

  test "should belong to a reporter" do
    assert_equal @company, @reporter.company
  end

  # Test pour créer une nouvelle entreprise
  test "should create a new reporter" do
    assert_difference('Reporter.count') do
      @reporter.save
    end
  end

  test "should retrieve reporter by id" do
    @reporter.save  
    retrieved_reporter = Reporter.find_by(id: @reporter.id)
    assert_equal @reporter, retrieved_reporter
  end


  # Test pour mettre à jour les informations d'un gardien existante
  test "should update an existing reporter" do
    @reporter.save  
    updated_name = "Updated reporter Name"
    updated_email = "rakoto@gmail.com"
    
    assert_no_difference('Company.count') do
      @reporter.update(name: updated_name)
      @reporter.update(email: updated_email)
    end
    
    assert_equal updated_name, @reporter.reload.name
  end


  # Test pour supprimer une entreprise existante
  test "should delete an existing reporter" do
    @reporter.save  # Sauvegarde l'entreprise dans la base de données pour obtenir un ID

    assert_difference('Reporter.count', -1) do
      @reporter.destroy
    end
  end
end
