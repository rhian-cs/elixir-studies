defmodule TableFormatterTest do
  use ExUnit.Case
  doctest Issues

  test "shows the table correctly given two issues" do
    issue_list = [
      # %{"number" => 123, "title" => "Please fix it!", "created_at" => ~N{2013-03-16T22:03:13Z}},
      # %{"number" => 4567, "title" => "Short name", "created_at" => ~N{2013-03-16T22:03:13Z}}
      %{"number" => "123", "title" => "Please fix it!", "created_at" => "2013-03-16T22:03:13Z"},
      %{"number" => "4567", "title" => "Short name", "created_at" => "2013-03-16T22:03:13Z"}
    ]

    formatted_table = """
    #    | created_at           | title
    -----+----------------------+---------------
    123  | 2013-03-16T22:03:13Z | Please fix it!
    4567 | 2013-03-16T22:03:13Z | Short name
    """

    assert TableFormatter.format(issue_list) == formatted_table
  end
end
