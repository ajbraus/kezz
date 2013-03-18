class ReadingsController < ApplicationController

  # GET /readings/1
  # GET /readings/1.json
  def show
    @reading = Reading.find(params[:id])

    @id_array = []
      @reading.paragraphs.each do |p| 
        @id_array.push(p.id)
        p.sentences.each do |s| 
          @id_array.push(s.id)
          s.phrases.each do |ph|
            @id_array.push(ph.id)
          end
        end
      end

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
    @paragraphs = @reading.content.split(/\n/) #split on new line
    if @reading.save
      @paragraphs.each do |p| 
        if p.length > 1
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
    @reading = @library.readings.build(params[:reading])
    if @reading.save
      @paragraphs = @reading.content.split(/\n/) #split on new line
      @paragraphs.each do |p| 
        if p.length > 1
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
                  format.html { render action: "edit", notice: 'There was an error. Reading not created.' }
                  format.json { render json: @phrase.errors, status: :unprocessable_entity }
                end
              end
            end
          end
        end
      end

      respond_to do |format| 
        format.html { redirect_to library_path(@library), notice: 'Reading was successfully created.' }
        format.json { render json: @reading, status: :created, location: @reading }
      end
    else
      format.html { render action: "edit", notice: 'There was an error. Reading not updated.' }
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

  def check_order
    @reading = Reading.find_by_id(params[:reading_id])
    @relative_ids = params[:relative_ids] #e.g. {1 => {1 => [1,2,3] }, {2 => [3,4,5] }, {2, => {1 => [6,7,8]}, {2 => [1] } }  
    @absolute_ids = params[:absolute_ids] #e.g. [1,1,1,2,3,2,4,5,2,1,6]
    
    @relative_order = []
    @reading.paragraphs.each do |p|
      @relative_order.push(p.id)
      @sentence_ids = []
      p.sentences.each do |s|
        @sentence_ids.push(s.id)
        @phrase_ids = []
        s.phrases.each do |ph|
          @phrase_ids.push(ph.id)
        end
        @sentence_ids.push(@phrase_ids)
      end
      @relative_order.push(@sentence_ids)
    end

    @absolute_order = []
    @reading.paragraphs.each do |p| 
      @absolute_order.push(p.id)
      p.sentences.each do |s| 
        @absolute_order.push(s.id)
        s.phrases.each do |ph|
          @absolute_order.push(ph.id)
        end
      end
    end

    @red_ids = []
    @green_ids = []
    for i in 0..@absolute_ids.count do
      if @absolute_ids[i] == "#{@absolute_order[i]}"
        @green_ids.push(@absolute_ids[i])
      else
        @red_ids.push(@absolute_ids[i])
      end
    end

    @yellow_ids = []
    #ignore relative paragraph order bc only absolute
    #now find each paragraph in the array
    @relative_ids.each_pair do |paragraph, sentences|
      for p in 0..@reading.paragraphs.count
        @paragraph = Paragraph.find_by_id(paragraph)
        for s in 0..@paragraph.sentences.count
          sentences.each_pair do |sentence, phrases|
            @sentence = Sentence.find_by_id(@relative_order[p+1][s])
            unless @sentence.blank?
              if "#{@sentence.id}" == sentence
                @yellow_ids.push(sentence)
              end
              phrases.each do |phrase|
                for ph in 0..@sentence.phrases.count
                  @phrase = Phrase.find_by_id(@relative_order[p+1][s+1][ph]) 
                  unless @phrase.blank?
                    if "#{@phrase.id}" == phrase
                      @yellow_ids.push(phrase)
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    
    #remove green_ids from yellow_ids bc their 'more' in order already
    @yellow_ids = @yellow_ids - @green_ids

    #return complex array of ids to client:
    @ids = []
    @ids = @ids.push(@red_ids) 
    @ids = @ids.push(@yellow_ids)
    @ids = @ids.push(@green_ids)

    return @ids

    respond_to do |format|
      format.html { redirect_to :back }
      format.js 
    end

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
