defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Identicon.hello()
      :world

  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

    @doc """
  `mirror_row` creates new list, with some elements appended in mirror fashion

  ## Examples

      row_example = [145, 46, 200]
      iex> Identicon.mirror_row(row_example)
      [145, 46, 200, 46, 145]

  """
  def mirror_row(row) do
    # [145, 46, 200]

    [first, second | _tail] = row

    row ++ [second, first]

  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    hex
    |> Enum.chunk(3)
    |> mirror_row

  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    # Pattern maching to get the hex list
    # acknowledge more values in the list, but avoid in the pattern matching
    # Move pattern matching statement to the function input
    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
  `hash_input` creates a binary list of the hash

  ## Examples

      iex> Identicon.main("banana")
      [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]

  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

end
