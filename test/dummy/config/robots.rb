disallow_tree admin_path

googlebot do
  disallow product_path("one")
end

bingbot do
  disallow :all
end