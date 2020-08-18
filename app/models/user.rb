class User < ActiveRecord::Base
    has_many :userbanks
    has_many :banks, through: :userbanks

    def self.user_logging_in
        prompt =  TTY::Prompt.new
        user_name = prompt.ask("Please input your username -->")
        found_user = User.find_by(user_name: user_name) # change to find_by "unique id" later 
        if found_user 
            found_user
        else
            puts "Sorry, you aren't registered with us yet."
        end
    end

    def self.register_user
        prompt =  TTY::Prompt.new
        user_name = prompt.ask("Please input your username -->")

        sleep 1

        puts "You are registered!"
        puts "Your user id is unique to you and it's --#{User.create_unique_id}--."
        puts "Please commit it to your memory."

        User.create(user_name: user_name)
        # thinking about adding another column to users table just for fun, assigning a 6 digit "unique_id" to each user.
    end

    def self.create_unique_id
        rand.to_s[2..7]
    end

    def user_bank_list
        self.banks.map { |bank_instance| "#{bank_instance.bank_name}" } 
    end

    def add_bank_to_list(bank_instance_id)
        Userbank.create(user_id: self.id, bank_id: bank_instance_id)
    end
    
end
