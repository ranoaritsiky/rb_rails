# app/controllers/api/reporters_controller.rb
module Api
  class ReportersController < ApplicationController
    before_action :set_reporter, only: [:show, :update, :destroy]

    def index
      @reporters = Reporter.all
      render json: @reporters
    end

    def show
      render json: @reporter
    end

    def create
      @reporter = Reporter.new(reporter_params)
      if @reporter.save
        # Générez et envoyez le fichier CSV ici
        generate_csv(@reporter)
        render json: @reporter, status: :created
      else
        render json: @reporter.errors, status: :unprocessable_entity
      end
    end


    private

    def generate_csv(reporter)
      # Créer un objet CSV ou utiliser une gemme CSV pour générer le fichier
      csv_data = CSV.generate do |csv|
        csv << ["name", "email"]  # En-têtes de colonne
        csv << [reporter.name, reporter.email]  # Données du gardien
      end

      # Enregistrez le fichier CSV sur le serveur temporairement (ou stockez-le localement)
      File.open("reporter.csv", "w") { |file| file.write(csv_data) }

      # Appelez la méthode pour envoyer le fichier CSV au service externe de stockage
      send_csv_to_storage("reporter.csv")
    end

    def update
      if @reporter.update(reporter_params)
        render json: @reporter
      else
        render json: @reporter.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @reporter.destroy
      head :no_content
    end

    private

    def set_reporter
      @reporter = Reporter.find(params[:id])
    end

    def reporter_params
      params.require(:reporter).permit(:name, :email)
    end
  end
end
