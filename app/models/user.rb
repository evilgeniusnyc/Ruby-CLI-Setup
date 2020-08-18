class User < ActiveRecord::Base
    has_many :userbanks
    has_many :banks, through: :userbanks

    def self.user_logging_in
        prompt =  TTY::Prompt.new
        user_name = prompt.ask("Please input your username -->", required: true)
        found_user = User.find_by(user_name: user_name) # change to find_by "unique id" later 
        if found_user 
            found_user
        else
            puts "Sorry, you aren't registered with us yet."
        end
    end

    def self.register_user
        prompt =  TTY::Prompt.new
        user_name = prompt.ask("Please input your username -->", required: true)

        sleep 1

        puts "You are registered!"
        puts "-----------------------------------------"
        puts "Your user id is unique to you and it's --#{User.create_unique_id}--."
        puts "Please commit it to your memory."

        User.create(user_name: user_name)
        # thinking about adding another column to users table just for fun, assigning a 6 digit "unique_id" to each user.
    end

    def self.create_unique_id
        rand.to_s[2..7]
    end

    def user_bank_list
        self.banks.map { |bank_instance| "#{bank_instance.bank_name}" }.uniq 
    end

    def add_bank_to_list
        prompt = TTY::Prompt.new
        bank_instance_id = prompt.ask("Please add a bank by their bank id number =] -->", required: true) { |q| q.in("1-5612") }

        new_bank = Userbank.create(user_id: self.id, bank_id: bank_instance_id)

        sleep 1

        new_bank = Bank.find(new_bank.bank_id)
        if !self.user_bank_list.include? new_bank.bank_name 
            puts "Here's the updated bank list for you --> #{self.user_bank_list.uniq << new_bank.bank_name}"
        else
            Userbank.last.destroy #destroys the newly created Userbank isntance instead of implementing conditional
            puts "Duplication breh."
        end
    end

    
end
