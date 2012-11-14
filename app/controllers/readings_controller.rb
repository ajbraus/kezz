class ReadingsController < ApplicationController

  # GET /readings/1
  # GET /readings/1.json
  def show
    @reading = Reading.find(params[:id])

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
      @paragraphs = @reading.content.split(/\n/) #split on new line
      @paragraphs.each do |p| 
        p.chomp
        @paragraph = @reading.paragraphs.build(reading_id: @reading.id)
        if @paragraph.save
        else
          respond_to do |format|
            format.html { render action: "new", notice: 'There was an error. Reading not created.' }
            format.json { render json: @paragraph.errors, status: :unprocessable_entity }
          end
        end
        @sentences = p.split(/(?<=\. )|(?<=\? )|(?<=\! )|(?<=\" )/)
        @sentences.each do |s|
          @psentence = Paragraph.find_by_id(@paragraph.id)
          @sentence = @psentence.sentences.build(paragraph_id: @psentence.id)
          if @sentence.save
          else
            respond_to do |format|
              format.html { render action: "new", notice: 'There was an error. Reading not created.' }
              format.json { render json: @sentence.errors, status: :unprocessable_entity }
            end
          end
          @phrases = s.split(/(?<=\, )|(?<=\; )|(?<=\- )|(?<=\: )/)
          @phrases.each do |ph|
            while ph.start_with?(' ') do
              ph = ph[1..-1]
            end
            ph[0] = ph[0].downcase
            ph.chomp
            @sphrase = Sentence.find_by_id(@sentence.id)
            @phrase = @sphrase.phrases.build(text: ph, sentence_id: @sphrase.id)
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
        @sentences = p.scan /.*?[.!?](?:\s|$)/
        # reverse.split(/(?=(?:\A|\s+)[.!?])/).map { |ps| ps.reverse }.reverse #split on periods and ?s
        @sentences.each do |s|
          @psentence = Paragraph.find_by_id(@paragraph.id)
          @sentence = @psentence.sentences.build(paragraph_id: @psentence.id)
          if @sentence.save
          else
            respond_to do |format|
              format.html { render action: "new", notice: 'There was an error. Reading not created.' }
              format.json { render json: @sentence.errors, status: :unprocessable_entity }
            end
          end
          @phrases = s.split(/\,|\;|\:|\bnor\b|\bor\b|\, and\b|\(/)
          @phrases.each do |ph|
            @sphrase = sentence.find_by_id(@sentence.id)
            @phrase = @sphrase.phrases.build(text: ph, sentence_id: @sphrase.id)
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
    params[:sentences].each_with_index do |id, index|
      sentence.update_all(['position=?', index+1], ['id=?', id])
    end
    params[:phrases].each_with_index do |id, index|
      Phrase.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
end
