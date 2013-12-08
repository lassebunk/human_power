HumanPower::Rails::Engine.routes.draw do
  root to: "human_power/rails/robots#robots", format: :text
end