
require Logger

defmodule Streamer.Binance do
	use WebSockex

	@stream_endpoint "wss://stream.binance.com:9443/ws/"

  def start_link(symbol) do
  	symbol = String.downcase(symbol)


    WebSockex.start_link(
    	"#{@stream_endpoint}#{symbol}@trade",
    	__MODULE__,
    	nil
    	)
  end

  def handle_frame({type, msg}, state) do
  	case Jason.decode(msg) do
  		{:ok, event} -> process_event(event)
  		{:error, _} -> Logger.error("Unable to parse msg: #{msg}")
  	end
    {:ok, state}
  end

  
end