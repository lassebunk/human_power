# Allow access to the whole site
disallow :none

# Examples:
# 
# Disallow everything:
# 
#   disallow :all
#
# Disallow everything inside /admin:
# 
#   disallow_tree admin_path
# 
# For Googlebot:
# 
#   googlebot do
#     disallow login_path
#   end
#
# For Bingbot:
# 
#   bingbot do
#     disallow some_path
#   end
# 
# Custom user agent:
# 
#   user_agent "My Custom User Agent" do
#     disallow some_path
#   end
# 
# Same rules for multiple user agents:
# 
#   user_agent [:googlebot, :bingbot, "My Custom User Agent"] do
#     disallow some_path
#   end
# 
# Please see the readme (https://github.com/lassebunk/human_power/blob/master/README.md)
# for details on the built-in user agents/crawlers.