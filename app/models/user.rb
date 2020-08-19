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

        User.create(user_name: user_name)
    end
    
end
