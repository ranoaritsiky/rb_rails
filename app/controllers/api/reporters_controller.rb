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
      access_token = "sl.BmtkBrtOz87rLSk_G_s-WfzEeB80VsViQ3CkKnW3PUfPKK5e7yJGfM6j1K15LCRvv1_wiP_eTqrvr0Ot2JzXxGAgKSXCkY9RpjALz1tO3UtgOBvl9DefsJG-ViU08D0Y01tD50a8SQMbvUc"

      # Initialize Dropbox client
      client = Dropbox::Client.new(access_token)

      # Specify the destination folder in Dropbox where you want to upload the files
      dropbox_folder = '/sowell'

      # Get the file name from the local file path
      file_name = File.basename(file_path)

      # Create the full Dropbox path (including the folder name)
      dropbox_path = "#{dropbox_folder}/#{file_name}"

      # Upload the file to Dropbox
      begin
        response = client.upload(dropbox_path, File.open(file_path))
        
        # Get the shared link to the uploaded file
        shared_link = client.create_shared_link_with_settings(dropbox_path)
        
        # Extract the URL from the shared link
        shared_link_url = shared_link.url
        return shared_link_url
      rescue Dropbox::Errors::UploadError => e
        # Handle upload errors here
        puts "Error uploading file: #{e.message}"
        return nil
      end
    end


    def set_reporter
      @reporter = Reporter.find(params[:id])
    end

    def reporter_params
      params.require(:reporter).permit(:name, :email, :company_id)
    end
  end
end
