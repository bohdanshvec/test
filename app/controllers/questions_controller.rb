class QuestionsController < ApplicationController

  # before_action :set_question!, only: %i[show destroy edit update]

  def show
    @question = Question.find(params[:id]).decorate
    # @question = @question.decorate
    @answer = @question.answers.build
    @answers = @question.answers.order(created_at: :desc).page(params[:page]).per(5).decorate
    # @answers = Answer.where(question: @question).limit(2).order(created_at: :desc)
    # @answers = @answers.decorate

  end

  def destroy
    @question = Question.find params[:id]
    @question.destroy
    flash[:success] = "Question deleted!"
    redirect_to questions_path
  end

  def edit
    @question = Question.find params[:id]
  end

  def update
    @question = Question.find params[:id]
     if @question.update question_params
      flash[:success] = "Question updated!"
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def index
    @questions = Question.order(created_at: :desc).page(params[:page]).decorate
    # @questions = @questions.decorate
  end
  
  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = "Question created!"
      redirect_to questions_path
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  # def set_question!
  #   @question = Question.find params[:id]
  # end

end