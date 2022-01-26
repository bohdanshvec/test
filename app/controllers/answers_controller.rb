class AnswersController < ApplicationController

  before_action :set_question!
  # before_action :set_answer!, except: :create

  def edit
    @answer = @question.answers.find params[:id]
  end

  def update
    @answer = @question.answers.find params[:id]
    if @answer.update answer_params
      flash[:success] = "Answer updated!"
      redirect_to question_path(@question, anchor: "answer-#{@answer.id}")
    else
      render :edit
    end
  end

  def create
    @answer = @question.answers.build answer_params

    if @answer.save
      flash[:success] = "Answer create!"
      redirect_to question_path(@question, anchor: "answer-#{@answer.id}")
    else
      @question = @question.decorate
      @answers = @question.answers.order created_at: :desc
      @answers = @answers.decorate
      render 'questions/show'
    end
  end

  def destroy
    answer = @question.answers.find params[:id]
    answer.destroy
    flash[:success] = "Answer deleted!"
    redirect_to questions_path
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question!
    @question = Question.find(params[:question_id])
  end

  # def set_answer!
  #   @answer = @question.answers.find params[:id]
  # end
  
end