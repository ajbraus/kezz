class LibrariesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  
  # GET /libraries
  # GET /libraries.json
  def index
    if user_signed_in?
      @in_progress_libraries = Library.limit(5)
    end
    @headerTitle = "Kezz Readings"
    @reading = Reading.first
    @libraries = Library.all
    @trending_libraries = Library.limit(5)
    @recent_libraries = Library.limit(5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @libraries }
    end
  end

  # GET /libraries/1
  # GET /libraries/1.json
  def show
    @library = Library.find(params[:id])
    @readings = @library.readings

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @library }
    end
  end

  # GET /libraries/new
  # GET /libraries/new.json
  def new
    @library = Library.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @library }
    end
  end

  # GET /libraries/1/edit
  def edit
    @library = Library.find(params[:id])
  end

  # POST /libraries
  # POST /libraries.json
  def create
    @creator = current_user
    @library = @creator.libraries.build(params[:library])

    respond_to do |format|
      if @library.save
        format.html { redirect_to @library, notice: 'Library was successfully created.' }
        format.json { render json: @library, status: :created, location: @library }
      else
        format.html { render action: "new" }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /libraries/1
  # PUT /libraries/1.json
  def update
    @creator = current_user
    @library = @creator.libraries.find(params[:id])

    respond_to do |format|
      if @library.update_attributes(params[:library])
        format.html { redirect_to @library, notice: 'Library was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /libraries/1
  # DELETE /libraries/1.json
  def destroy
    @creator = current_user
    @library = @creator.libraries.find(params[:id])
    @library.destroy

    respond_to do |format|
      format.html { redirect_to home_url }
      format.json { head :no_content }
    end
  end
end
