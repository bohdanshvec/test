class QuestionsController < ApplicationController

  include QuestionsAnswers

  # before_action :set_question!, only: %i[show destroy edit update]

  before_action :fetch_tags, only: %i[new edit]

  def show
    load_question_answers

    # @answers = Answer.where(question: @question).limit(2).order(created_at: :desc)
    # @answers = @answers.decorate

  end

  def destroy
    @question = Question.find params[:id]
    @question.destroy
    flash[:success] = t('.success')
    redirect_to questions_path
  end

  def edit
    @question = Question.find params[:id]
  end

  def update
    @question = Question.find params[:id]
     if @question.update question_params
      flash[:success] = t('.success')
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def index
    @questions = Question.all_by_tags(params[:tag_ids])#.includes(:user, :question_tags, :tags).order(created_at: :desc).page(params[:page]).decorate

    @questions = @questions.page(params[:page]).decorate
    @tags = Tag.all
  end
  
  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build question_params
    if @question.save
      flash[:success] = "Question created!"
      redirect_to questions_path
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, tag_ids: [])
  end

  def fetch_tags
    @tags = Tag.all
  end

  # def set_question!
  #   @question = Question.find params[:id]
  # end

end