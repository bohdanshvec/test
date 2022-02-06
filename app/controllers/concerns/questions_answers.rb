module QuestionsAnswers
  extend ActiveSupport::Concern

  included do
    def load_question_answers(do_render: false)
      @question = Question.find(params[:id]).decorate
      # @question = @question.decorate
      @answer ||= @question.answers.build
      @answers = @question.answers.includes(:user).order(created_at: :desc).page(params[:page]).per(5).decorate
      render('questions/show') if do_render
    end

  end
end