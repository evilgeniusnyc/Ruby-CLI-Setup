class Messages 

    def self.welcome
        puts "-----------------------------------------"
        puts "Hi Friend, Welcome to our ATM locator app!"
    end

    def self.loading_animation
        print "Loading.".green
        sleep 0.2 
        print ".".green
        sleep 0.2 
        print ".".green
        sleep 0.2
        print ".".green
        sleep 0.2
        print ".".green
        sleep 0.2
        print ".".green
        sleep 0.2
        print ".".green
        sleep 0.2
        print ".".green
        sleep 0.2
        print ".".green
        sleep 0.2
        print ".".green
        sleep 0.2
        print ".".green
    end

    def self.loading_message
        prompt = TTY::Prompt.new
        prompt.ok(self.loading_animation)
    end

    def self.no_bank_message
        prompt = TTY::Prompt.new 
        prompt.warn("We don't have a list of banks to which you are a customer yet.")
    end

end