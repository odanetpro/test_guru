# frozen_string_literal: true

class GistQuestionService
  ACCESS_TOKEN = ENV.fetch('GITHUB_GIST_TOKEN')
  CREATED = 201

  Result = Struct.new(:url, :status) do
    def success?
      status == CREATED
    end
  end

  def initialize(question, client = default_client)
    @question = question
    @test = @question.test
    @client = client
  end

  def call
    Result.new(@client.create_gist(gist_params).html_url, @client.last_response.status)
  rescue Octokit::Error => e
    Result.new(nil, e.response_status)
  end

  private

  def default_client
    Octokit::Client.new(access_token: ACCESS_TOKEN)
  end

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
    [@question.body, *@question.answers.pluck(:body)].join("\n")
  end
end
