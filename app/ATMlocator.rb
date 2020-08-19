class ATMlocator

  attr_accessor :prompt, :user

  def initialize
    @prompt = TTY::Prompt.new
  end


  def friendly_bank_list
    prompt = TTY::Prompt.new 
    prompt.ok("You are a customer at these banks --#{self.user_bank_list}--" )
    puts "Bank list takes a day to update =/"
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
    system "clear"
    puts "-----------------------------------------"
    puts "Hello #{self.user.user_name}, this is the main menu."

    if self.user_bank_list.length != 0
      self.friendly_bank_list
      puts "Bank list takes a day to update =/"
    else
      Messages.no_bank_message
      puts "*Bank list takes a day to update to ensure accuracy =/*"
    end
    puts "-----------------------------------------"

    self.prompt.select("What would you like to accomplish today?") do |menu|
      menu.choice "Find banks by zipcode", -> { self.list_banks_by_zipcode }
      menu.choice "Add your bank to a list of banks to which you are a customer", -> { self.add_bank_to_list }
      menu.choice "Delete a bank from your list", -> { puts "--Userbank find associated row and .destroy here to disassociate--" }
      menu.choice "Not what you are looking for? Click here for more.".yellow, -> { puts "--sub_menu here--"}
      menu.choice "Log off".red, -> { puts "--Have a nice day!--"}
    end
  end


  def list_banks_by_zipcode
    system "clear"
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


  def user_bank_list
    self.user.banks.map { |bank_instance| "#{bank_instance.bank_name}" }.uniq 
  end #returns an array of uniq bank names associated with user


  def add_bank_to_list
    prompt = TTY::Prompt.new
    bank_instance_id = prompt.ask("Please add a bank by their bank id number =] -->", required: true) { |q| q.in("1-5612") }

    new_userbank = Userbank.create(user_id: self.user.id, bank_id: bank_instance_id)

    sleep 1

    new_bank = Bank.find(new_userbank.bank_id)
    if !self.user_bank_list.include? new_bank.bank_name 
        puts "Here's the updated bank list for you --> #{self.user_bank_list.uniq << new_bank.bank_name}".green
    else
        Userbank.last.destroy #destroys the newly created Userbank isntance instead of implementing conditional
        puts "Duplication breh."
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

