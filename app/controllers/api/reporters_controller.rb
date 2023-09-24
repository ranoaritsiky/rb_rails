require 'csv'
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
        generate_csv(@reporter)
        render json: @reporter, status: :created
      else
        render json: @reporter.errors, status: :unprocessable_entity
      end
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



    private

    def generate_csv(reporter)
      # Créez un objet CSV ou utilisez une gemme CSV pour générer le fichier
      csv_data = CSV.generate do |csv|
        csv << ["name", "email"]  # En-têtes de colonne
        csv << [reporter.name, reporter.email]  # Données du reporter
      end

      # Enregistrez le fichier CSV localement
      File.open("reporter_#{reporter.id}.csv", "w") { |file| file.write(csv_data) }
    end

    def set_reporter
      @reporter = Reporter.find(params[:id])
    end

    def reporter_params
      params.require(:reporter).permit(:name, :email, :company_id)
    end
  end
end
