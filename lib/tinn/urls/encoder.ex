defmodule Tinn.Urls.Encoder do
  use CustomBase, '_~0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

  @doc """
  Encode base 10 integer to an url hash.
  """
  def encode(integer)

  @doc """
  Decode an url hash to base 10 integer.

  Returns tuple `{:ok, number}` if binary can be converted using alphabet,
  `:error` instead.
  """
  def decode(binary)
end
