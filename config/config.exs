import Config
import System

config :friends, Friends.Repo,
  database: get_env("DB_NAME"),
  username: get_env("DB_USERNAME"),
  password: get_env("DB_PASSWORD"),
  hostname: get_env("DB_HOST")

config :friends, ecto_repos: [Friends.Repo]
