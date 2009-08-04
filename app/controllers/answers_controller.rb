class AnswersController < ApplicationController
  before_filter :require_user
  
  # GET /answers
  # GET /answers.xml
  def index
    @answers = current_user.answers.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @answers }
    end
  end

  # GET /answers/1
  # GET /answers/1.xml
  def show
    @answer = current_user.answers.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/new
  # GET /answers/new.xml
  def new
    @questions = Question.paginate :page => params[:page], :per_page => 5
    @answer = current_user.answers.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/1/edit
  def edit
    @answer = Answer.find(params[:id])
  end

  # POST /answers
  # POST /answers.xml
  def create

    @answers = params[:answer].values.collect do |answer| 
      unless answer["id"].blank?
        answered = Answer.find_by_id(answer["id"])
        answered.attributes = answer
        answered
      else
        current_user.answers.build(answer)
      end
    end

    if @answers.all?(&:valid?)
      @answers.each(&:save!)
      build_dna
      flash[:notice] = 'Answer was successfully created.'
      redirect_to :action => "index"
    else
      flash[:notice] = 'An error occured.'
      redirect_to :action => "new"
    end
    # 
    # respond_to do |format|
    #   if @answer.save
    #     flash[:notice] = 'Answer was successfully created.'
    #     format.html { redirect_to(@answer) }
    #     format.xml  { render :xml => @answer, :status => :created, :location => @answer }
    #   else
    #     format.html { render :action => "new" }
    #     format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
    #   end
    # end
  end

  # PUT /answers/1
  # PUT /answers/1.xml
  def update
    @answer = Answer.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        flash[:notice] = 'Answer was successfully updated.'
        format.html { redirect_to(@answer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.xml
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to(answers_url) }
      format.xml  { head :ok }
    end
  end
  
  private
    
    def build_dna
      @questions = Question.all
      @answers = @questions.collect {|question| question.answer(current_user) && question.answer(current_user).answer ? question.answer(current_user).answer : 0 }.to_s
      current_user.update_attribute("dna",@answers)
    end
end
