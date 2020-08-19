class ATMlocator

  attr_accessor :prompt, :user

  def initialize
    @prompt = TTY::Prompt.new
  end

  def friendly_bank_list
    prompt = TTY::Prompt.new 
    prompt.ok("You are a customer at these banks --#{self.user.user_bank_list}--")
  end

  def login_or_register
    user_choice = self.prompt.select("Logging in or Registering?",
    [
      "Logging-in",
      "Register"
    ]
    )

    if user_choice == "Logging-in"
      Messages.loading_message
      puts "\n\Alright, let's get you logged in!"
      User.user_logging_in
    elsif user_choice == "Register"
      Messages.loading_message
      puts "\n\Alright, let's get you registered!"
      User.register_user
    end
  end

  def main_menu
    puts "-----------------------------------------"
    puts "Hello #{self.user.user_name}, this is the main menu."

    if self.user.user_bank_list.length != 0
      self.friendly_bank_list
    else
      Messages.no_bank_message
    end
    puts "-----------------------------------------"

    self.prompt.select("What would you like to accomplish today?") do |menu|
      menu.choice "Find banks by zipcode", -> { self.list_banks_by_zipcode }
      menu.choice "Add your bank to a list of banks to which you are a customer", -> { self.user.add_bank_to_list }
      menu.choice "Add/Update favorite bank location(s)", -> { puts "--method here to update userbank row 'user_fav attribute'--"}
      menu.choice "Delete a bank from your list", -> { puts "--Userbank find associated row and .destroy here to disassociate--" }
      menu.choice "Not what you are looking for? Click here for more.", -> { puts "--sub_menu here--"}
      menu.choice "Log off".red, -> { puts "--Have a nice day!--"}
    end
  end

  def list_banks_by_zipcode
    prompt = TTY::Prompt.new
    zipcode_input = prompt.ask("What zipcode do you want to look into?", required: true)

    puts "-----------------------------------------"

    bank_result_array = Bank.where(zipcode: zipcode_input)

    bank_result_array.each do |bank|
      puts bank.id.to_s + "--" + bank.bank_name + ", " + bank.street_address + ", " + bank.city + ", " + bank.zipcode
    end

    keypress = prompt.keypress("***Press enter to go back to main menu***".yellow, keys: [:return])

    self.main_menu if keypress

  end

  def run
    Messages.welcome

    user_instance = self.login_or_register
    self.user = user_instance
    self.main_menu
  end

  private


end

