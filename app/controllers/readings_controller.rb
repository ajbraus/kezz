class ReadingsController < ApplicationController

  # GET /readings/1
  # GET /readings/1.json
  def show
    @reading = Reading.find(params[:id])
    @reading_puzzle = @reading.paragraphs

    # if @reading.paragraphly == true && @reading.sentancely == false && @reading.phrasely == false
    #   @reading_puzzle = @reading.paragraphs.shuffle 
    # elsif @reading.sentancely && @reading.paragraphly == false && @reading.phrasely == false
    #   @reading_puzzle = @reading.paragraphs.sentances.shuffle
    # elsif @reading.phrasely && @reading.sentancely == false && @reading.paragraphly == false
    #   @reading_puzzle = @reading.paragraphs.sentances.phrases.shuffle
    # elsif @reading.paragraphly && @reading.sentancely && @reading.phrasely == false
    #   @reading_puzzle = @reading.shuffle_p_and_s(@reading)
    # elsif @reading.paragraphly && @reading.phrasely && @reading.sentancely == false
    #   @reading_puzzle = @reading.shuffle_p_and_ph(@reading)
    # elsif @reading.sentancely && @reading.phrasely && @reading.paragraphly == false
    #   @reading_puzzle = @reading.scramble_s_and_ph(@reading)
    # elsif @reading.paragraphly && @reading.sentancely && @reading.phrasely 
    #   @reading_puzzle = @reading.shuffle_all(@reading)
    # end

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
      @paragraphs = @reading.content.split(/\n\r/) #split on new line
      @paragraphs.each do |p| 
        @paragraph = @reading.paragraphs.build(reading_id: @reading.id)
        if @paragraph.save
        else
          respond_to do |format|
            format.html { render action: "new", notice: 'There was an error. Reading not created.' }
            format.json { render json: @paragraph.errors, status: :unprocessable_entity }
          end
        end
        @sentances = p.split(/(?<=\.  )|(?<=\. )|(?<=\?  )|(?<=\? )|(?<=\!  )|(?<=\! )|(?<=\" )/)
        # reverse.split(/(?=(?:\A|\s+)[.!?])/).map { |ps| ps.reverse }.reverse #split on periods and ?s
        @sentances.each do |s|
          @psentance = Paragraph.find_by_id(@paragraph.id)
          @sentance = @psentance.sentances.build(paragraph_id: @psentance.id)
          if @sentance.save
          else
            respond_to do |format|
              format.html { render action: "new", notice: 'There was an error. Reading not created.' }
              format.json { render json: @sentance.errors, status: :unprocessable_entity }
            end
          end
          @phrases = s.split(/(?<=\, )|(?<=\; )|(?<=\- )|(?<=\: )/)
            binding.pry
          @phrases[0].uncapitalize
          @phrases.each do |ph|
            @sphrase = Sentance.find_by_id(@sentance.id)
            @phrase = @sphrase.phrases.build(text: ph, sentance_id: @sphrase.id)
            if @phrase.save
            else
              respond_to do |format|
                format.html { render action: "new", notice: 'There was an error. Reading not created.' }
                format.json { render json: @phrase.errors, status: :unprocessable_entity }
              end
            end
          end
        end
      end

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

    if @reading.save
      @paragraphs = @reading.content.split(/\n\r/) #split on new line
      @paragraphs.each do |p| 
        @paragraph = @reading.paragraphs.build(reading_id: @reading.id)
        if @paragraph.save
        else
          respond_to do |format|
            format.html { render action: "new", notice: 'There was an error. Reading not created.' }
            format.json { render json: @paragraph.errors, status: :unprocessable_entity }
          end
        end
        @sentances = p.scan /.*?[.!?](?:\s|$)/
        # reverse.split(/(?=(?:\A|\s+)[.!?])/).map { |ps| ps.reverse }.reverse #split on periods and ?s
        @sentances.each do |s|
          @psentance = Paragraph.find_by_id(@paragraph.id)
          @sentance = @psentance.sentances.build(paragraph_id: @psentance.id)
          if @sentance.save
          else
            respond_to do |format|
              format.html { render action: "new", notice: 'There was an error. Reading not created.' }
              format.json { render json: @sentance.errors, status: :unprocessable_entity }
            end
          end
          @phrases = s.split(/\,|\;|\:|\bnor\b|\bor\b|\, and\b|\(/)
          @phrases.each do |ph|
            @sphrase = Sentance.find_by_id(@sentance.id)
            @phrase = @sphrase.phrases.build(text: ph, sentance_id: @sphrase.id)
            if @phrase.save
            else
              respond_to do |format|
                format.html { render action: "new", notice: 'There was an error. Reading not created.' }
                format.json { render json: @phrase.errors, status: :unprocessable_entity }
              end
            end
          end
        end
      end
    else
      format.html { render action: "edit" }
      format.json { render json: @reading.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /readings/1
  # DELETE /readings/1.json
  def destroy
    @library = Library.find(params[:library_id])
    @reading = @library.readings.find(params[:id])
    @reading.destroy

    respond_to do |format|
      format.html { redirect_to @library }
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
