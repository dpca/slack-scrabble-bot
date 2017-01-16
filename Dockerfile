FROM elixir:1.4

RUN mkdir -p /app
COPY . /app
WORKDIR /app
RUN mix local.rebar --force
RUN mix local.hex --force
RUN mix do deps.get, compile

CMD ["mix", "run", "--no-halt"]
