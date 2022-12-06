# frozen_string_literal: true

class GistQuestionService
  ACCESS_TOKEN = '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'

  def initialize(question, client: nil)
    @question = question
    @test = @question.test

    @client = client || Octokit::Client.new(access_token: ACCESS_TOKEN)
  end

  def call
    @client.create_gist(gist_params)
  end

  private

  def gist_params
    {
      description: I18n.t('services.gist.description', test_title: @test.title).to_s,
      public: false,
      files: {
        'test_guru_question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end
