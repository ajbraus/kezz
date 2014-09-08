class ReadingsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :check_order]
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
    @library = Library.find(params[:library_id])
    @reading = @library.readings.find(params[:id])
  end

  # POST /readings
  # POST /readings.json
  def create
    @library = Library.find(params[:library_id])
    @reading = @library.readings.build(params[:reading])
    if @reading.save
      if @reading.scramble
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
  end

  # PUT /readings/1
  # PUT /readings/1.json
  def update
    @reading = Reading.find(params[:id])
    @library = @reading.library
    @reading.paragraphs.each { |p| p.destroy }

    if @reading.update_attributes(params[:reading])
      if @reading.scramble
        respond_to do |format| 
          format.html { redirect_to library_path(@library), notice: 'Reading was successfully created.' }
          format.json { render json: @reading, status: :created, location: @reading }
        end
      else
        respond_to do |format|
          format.html { render action: "edit", notice: 'There was an error. Reading not updated.' }
          format.json { render json: @reading.errors, status: :unprocessable_entity }
        end
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
      format.html { redirect_to @library }
      format.json { head :no_content }
    end
  end

  def check_order
    @reading = Reading.find(params[:reading_id])
    @relative_ids = params[:relative_ids] #e.g. { 1 => { 1 => [1,2,3], 2 => [3,4,5] }, 2 => { 1 => [6,7,8], 2 => [1] } }  
    @absolute_ids = params[:absolute_ids] #e.g. [1,1,1,2,3,2,4,5,2,1,6]
    
    # @reading.check_relative_order(@relative_ids) #Orange IDs
    # @reading.check_absolute_order(@absolute_ids) #Green IDS

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
      if @absolute_ids[i].to_i == @absolute_order[i]
        @green_ids.push(@absolute_ids[i])
      else
        @red_ids.push(@absolute_ids[i])
      end
    end

    @yellow_ids = []
    @relative_ids.each_with_index do |(r_paragraph_id, sentences), p_index| 
      if r_paragraph_id.to_i == @reading.paragraphs[p_index].id
        @yellow_ids << r_paragraph_id 
      end
      sentences.each_with_index do |(r_sentence_id, phrases), s_index| 
        if r_sentence_id.to_i == @reading.paragraphs[p_index].sentences[s_index].id
          @yellow_ids << r_sentence_id 
        end
        phrases.each_with_index do |r_phrase_id, ph_index|
          if r_phrase_id.to_i == @reading.paragraphs[p_index].sentences[s_index].phrases[ph_index].id
            @yellow_ids << r_phrase_id 
          end
        end
      end
    end
    
    #remove green_ids from yellow_ids bc their 'more' in order already
    @yellow_ids = @yellow_ids - @green_ids
    @red_ids = @red_ids - @yellow_ids

    #return complex array of ids to client:
    @ids = { "red_ids" => @red_ids, "yellow_ids" => @yellow_ids, "green_ids" => @green_ids }
    # @ids = @ids.push(@red_ids) 
    # @ids = @ids.push(@yellow_ids)
    # @ids = @ids.push(@green_ids)

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
