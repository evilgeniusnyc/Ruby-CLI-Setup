class ATMlocator
  # here will be your CLI!
  # it is not an AR class so you need to add attr

  attr_accessor :prompt, :user

  def initialize
    @prompt = TTY::Prompt.new
  end

  def loading_animation
    puts "-----------------------------------------"
    print "Loading."
    sleep 0.2 
    print "."
    sleep 0.2 
    print "."
    sleep 0.2
    print "."
    sleep 0.2
    print "."
    sleep 0.2
    print "."
    sleep 0.2
    print "."
    sleep 0.2
    print "."
    sleep 0.2
    print "."
    sleep 0.2
    print "."
    sleep 0.2
    print "."
  end

  def loading_message
    prompt = TTY::Prompt.new
    prompt.ok(self.loading_animation)
  end

  def no_bank_message
    prompt = TTY::Prompt.new 
    prompt.warn("We don't have a list of banks to which you are a customer yet.")
  end

  def friendly_bank_list
    prompt = TTY::Prompt.new 
    prompt.ok("You are a customer at these banks --#{self.user.user_bank_list}--")
  end

  def welcome
    puts "-----------------------------------------"
    puts "Hi Friend, Welcome to our ATM locator app!"
  end

  def login_or_register
    user_choice = self.prompt.select("Logging in or Registering?",
    [
      "Logging-in",
      "Register"
    ]
    )

    if user_choice == "Logging-in"
      self.loading_message
      puts "\n\Alright, let's get you logged in!"
      User.user_logging_in
    elsif user_choice == "Register"
      self.loading_message
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
      self.no_bank_message
    end
    puts "-----------------------------------------"

    self.prompt.select("What would you like to accomplish today?") do |menu|
      menu.choice "Find banks by zipcode", -> { Bank.list_banks_by_zipcode }
      menu.choice "Add your bank to a list of banks to which you are a customer", -> { self.user.add_bank_to_list }
      menu.choice "Add/Update favorite bank location(s)", -> { puts "--method here to update userbank row 'user_fav attribute'--"}
      menu.choice "Delete a bank from your list", -> { puts "--Userbank find associated row and .destroy here to disassociate--" }
      menu.choice "Delete your user account", -> { puts "--Delete user instance and userbank rows associated with user here--" }
      menu.choice "Not what you are looking for? Click here for more.", -> { puts "--sub_menu here--"}
    end

  end

  def run
    self.welcome

    user_instance = self.login_or_register
    self.user = user_instance
    self.main_menu

    # wanna_see_favs?
    # get_joke(what_subject)
  end

  private


end

