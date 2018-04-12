defmodule Tinn.Service do
  @moduledoc """
  Service behaviour
  """

  @callback run(map | String.t()) ::
              {:ok, struct | map | String.t() | list}
              | {:error, any()}

  defmacro __using__(_) do
    quote do
      @behaviour Tinn.Service
      import Tinn.Repo, only: [transaction: 1, rollback: 1]

      def call(params) do
        transaction(fn ->
          with {:ok, response} <- run(params) do
            response
          else
            {:error, reason} -> rollback(reason)
          end
        end)
      end
    end
  end
end
