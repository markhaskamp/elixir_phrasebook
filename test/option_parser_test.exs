defmodule OptionParserTest do
  use ExUnit.Case

  import OptionParser

  test "parse_args parses argv into a keywords list" do
    parsed = parse(["--foo", "--bar"])
    kw = elem(parsed, 0)
    assert kw == [{:foo, true}, {:bar, true}]
    assert kw == [foo: true, bar: true]   # keyword syntactic sugar
  end

  test "parse_args returns a 3 element tuple" do
    parsed = parse(["--name=foo"])
    assert tuple_size(parsed) == 3
  end

  test "given parse_args returns a tuple, the first element is the keyword element" do
    parsed =  parse(["--foo", "--bar"])
    kw = elem(parsed, 0)
    assert kw == [{:foo, true}, {:bar, true}]
  end

  test "given parse_args returns a tuple, the second element is the remaining arguments" do
    parsed =  parse(["--verbose=y", "path/and/file"])
    kw = elem(parsed, 1)
    assert kw == ["path/and/file"]
  end

  test "given parse_args returns a tuple, the third element is errors" do
    parsed = parse(["--verbose","--n=yes"])
    kw = elem(parsed,2)
    assert kw != nil
  end

  test "use 'switches' to parse an arg as a boolean" do
    parsed = parse(["--verbose"], switches: [verbose: :boolean])
    assert (
    case parsed do
      {[verbose: true], _, _} -> true
      _ -> false
    end
    )
  end

  test "switching to boolean is the default when nothing follows the arg" do
    parsed = parse(["--verbose"])
    assert (
    case parsed do
      {[verbose: true], _, _} -> true
      _ -> false
    end
    )
  end

  test "arg values are cast to strings by default" do
    parsed = parse(["--verbose=42"])
    assert (
    case parsed do
      {[verbose: 42], _, _} -> false
      {[verbose: "42"], _, _} -> true
      _ -> false
    end
    )
  end

  test "arg values can be switched to integer" do
    parsed = parse(["--n=42"], switches: [n: :integer])
    assert (
    case parsed do
      {[n: "42"], _, _} -> false
      {[n: 42], _, _} -> true
      _ -> false
    end
    )
  end

  test "= signs are optional" do
    parsed = parse(["--n", "42"], switches: [n: :integer])
    assert (
    case parsed do
      {[n: "42"], _, _} -> false
      {[n: 42], _, _} -> true
      _ -> false
    end
    )
  end

  test "aliases ....." do
    parsed = parse(["-v"], aliases: [v: :verbose])
    assert (
    case parsed do
      {[verbose: true], _, _} -> true
      _ -> false
    end
    )
  end

end
