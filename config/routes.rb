Rails.application.routes.draw do
  get "robots.txt" => "human_power/rails/robots#robots", format: :text, as: :robotstxt
end