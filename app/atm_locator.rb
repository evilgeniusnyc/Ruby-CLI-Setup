class Atm_locator 
  # here will be your CLI!
  # it is not an AR class so you need to add attr (keeps track of user and CRUDS information)

  # Deliverables:
  # - User sign in.
  # - User create defaults:
  # - > (1)preferred bank
  # - > (2)zipcode 

  # result = prompt.collect do
  #   key(:name).ask("Name?")
  
  #   key(:user_bank).ask("Bank?")
  # prompt.select("Which bank do you prefer?") do |menu|
  #   menu.choice "Applae Bank"
  #   menu.choice "Banco Popular North America"
  #   menu.choice "Bank of America NA"
  #   menu.choice "JP Morgan Chase"
  # end
  
  #   key(:address) do
  #     key(:street).ask("Street?", required: true)
  #     key(:city).ask("City?")
  #     key(:zip).ask("Zip?", validate: /\A\d{3}\Z/)
  #   end
  # end


  # =>
  # {:name => "Sylwia", :Bank => "Bank", :address => {:street => "Street", :city => "City", :zip => "123"}}

  # Welcome_user: ""
  
  attr_reader :prompt
  
  def initialize 
    @prompt = TTY::Prompt.new 
  end  


  def welcome 
    # implicit return 'self' --> instance of atm_locator 

    #method defaults to choice # 3 'Search ATMs by Bank and ZIP code'.

  prompt.select("Welcome to ATM Locator?  What would you like to do?") do |menu|
    menu.default 3
  
    menu.choice "Search ATMs by Bank?", 1
    menu.choice "Search ATMs by Bank and ZIP code?", 2
    menu.choice "Search ATMs by Bank and ZIP code?", 3
  end
end 
end 

  