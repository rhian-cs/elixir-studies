defmodule Issues.GithubIssues do
  require Logger

  @user_agent [{"User-agent", "Elixir rhian.luis.cs+github@gmail.com"}]

  def fetch(user, project) do
    Logger.info("Fecthing #{user}'s project #{project}")

    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  @github_url Application.get_env(:issues, :github_url)
  defp issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  defp handle_response({_, %{status_code: status_code, body: body}}) do
    Logger.info("Got response, status code: #{status_code}")
    Logger.debug(fn -> inspect(body) end)

    {
      status_code |> check_status_for_error(),
      body |> Poison.Parser.parse!()
    }
  end

  defp check_status_for_error(200), do: :ok
  defp check_status_for_error(_), do: :error
end
