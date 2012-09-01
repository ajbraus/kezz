class ReadingsController < ApplicationController

  # GET /readings/1
  # GET /readings/1.json
  def show
    @reading = Reading.find(params[:id])

    @reading_puzzle = reading_puzzle(@reading)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reading }
    end
  end

  # GET /readings/new
  # GET /readings/new.json
  def new
    @library = Library.find(params[:library_id])
    @reading = @library.readings.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reading }
    end
  end

  # GET /readings/1/edit
  def edit
    @reading = Reading.find(params[:id])
  end

  # POST /readings
  # POST /readings.json
  def create
    @library = Library.find(params[:library_id])
    @reading = @library.readings.build(params[:reading])
    if @reading.save
      @paragraphs = @reading.content.split(%r{\n\r}) #split on new line
      @paragraphs.each do |p| 
        @paragraph = @reading.paragraphs.build(reading_id: @reading.id)
        @paragraph.save
        @sentances = p.split(%r{.\|\?}) #split on periods and ?s
        @sentances.each do |s|
          @psentance = Paragraph.find_by_id(@paragraph.id)
          @sentance = @psentance.sentances.build()
          @sentance.save
          @phrases = s.split(%r{\,|\;|nor|or|yet|so|\(})
          @phrases.each do |ph|
            @sphrase = Sentance.find_by_id(@sentance.id)
            @phrase = @sphrase.phrases.build(text: ph)
            @phrase.save
          end
        end
      end
              binding.pry
      respond_to do |format| 
        format.html { redirect_to @library, notice: 'Reading was successfully created.' }
        format.json { render json: @reading, status: :created, location: @reading }
      end
    else
      respond_to do |format|
        format.html { render action: "new", notice: 'There was an error. Reading not created.' }
        format.json { render json: @reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /readings/1
  # PUT /readings/1.json
  def update
    @library = Library.find(params[:library_id])
    @reading = @library.readings.find(params[:id])

    respond_to do |format|
      if @reading.update_attributes(params[:reading])
        format.html { redirect_to @reading, notice: 'Reading was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /readings/1
  # DELETE /readings/1.json
  def destroy
    @library = Library.find(params[:library_id])
    @reading = @library.readings.find(params[:id])
    @reading.destroy

    respond_to do |format|
      format.html { redirect_to readings_url }
      format.json { head :no_content }
    end
  end

  def check
  #pass the position of each nested element and check it against @reading.paragraph.ids
  end

  def sort
    params[:paragraphs].each_with_index do |id, index|
      Paragraph.update_all(['position=?', index+1], ['id=?', id])
    end
    params[:sentances].each_with_index do |id, index|
      Sentance.update_all(['position=?', index+1], ['id=?', id])
    end
    params[:phrases].each_with_index do |id, index|
      Phrase.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
end
