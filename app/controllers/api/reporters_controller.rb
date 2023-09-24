require 'csv'
require 'dropbox'

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
        file_url = generate_csv(@reporter) 
        dropbox_link = upload_to_dropbox(file_url) 
        render json: { reporter: @reporter, dropbox_link: dropbox_link }, status: :created
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
      csv_data = CSV.generate do |csv|
        csv << ["name", "email"]  # En-têtes de colonne
        csv << [reporter.name, reporter.email]  # Données du reporter
      end

      # Enregistrez le fichier CSV localement
      local_file_path = "reporter_#{reporter.id}.csv"
      File.open(local_file_path, "w") { |file| file.write(csv_data) }

      local_file_path
    end

    def upload_to_dropbox(file_path)
      # Configuration Dropbox
      access_token = 'sl.BmqVuFXigOLwaImKTk5ASwwW8QH9doS9Jn0ykSYrI7Ox3gnwCNBL6vOh5J-pETxKuFnqLC1xa69NuqeGPPo_7t10aeVT_6oFolCn6WFkynAejbpLB_A4lat8EuQmhq7Dr95B2Dm3Fn8P' 
      # Créez une instance DropboxClient
      client = Dropbox::Client.new(access_token)

      # Nom du dossier dans Dropbox où vous souhaitez téléverser les fichiers
      dropbox_folder = '/'

      # Nom du fichier sur Dropbox (utilisez le nom local du fichier)
      file_name = File.basename(file_path)

      # Chemin complet dans Dropbox (y compris le nom du dossier)
      dropbox_path = "#{dropbox_folder}/#{file_name}"

      # Téléversez le fichier vers Dropbox
      response = client.upload(dropbox_path, File.open(file_path, 'rb'))

      # Obtenez le lien partagé public vers le fichier téléversé
      shared_link = client.create_shared_link(dropbox_path)

      # Retournez le lien partagé public
      shared_link.url
    end


    def set_reporter
      @reporter = Reporter.find(params[:id])
    end

    def reporter_params
      params.require(:reporter).permit(:name, :email, :company_id)
    end
  end
end
