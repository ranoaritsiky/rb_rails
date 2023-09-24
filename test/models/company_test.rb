require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  def setup
    @company = Company.new(name: "Example Company")
  end

  test "should be valid" do
    assert @company.valid?
  end

  test "name should be present" do
    @company.name = "Example Company"  # Nom présent
    assert @company.valid?
  end

  # Test pour créer une nouvelle entreprise
  test "should create a new company" do
    assert_difference('Company.count') do
      @company.save
    end
  end

  # Nouveau test pour récupérer une entreprise par ID
  test "should retrieve company by id" do
    @company.save  # Sauvegarde l'entreprise dans la base de données pour obtenir un ID
    retrieved_company = Company.find_by(id: @company.id)
    assert_equal @company, retrieved_company
  end

  # Test pour mettre à jour les informations d'une entreprise existante
  test "should update an existing company" do
    @company.save  # Sauvegarde l'entreprise dans la base de données pour obtenir un ID
    updated_name = "Updated Company Name"
    
    assert_no_difference('Company.count') do
      @company.update(name: updated_name)
    end
    
    assert_equal updated_name, @company.reload.name
  end

  # Test pour supprimer une entreprise existante
  test "should delete an existing company" do
    @company.save  # Sauvegarde l'entreprise dans la base de données pour obtenir un ID

    assert_difference('Company.count', -1) do
      @company.destroy
    end
  end

  # test "the truth" do
  #   assert true
  # end
end
