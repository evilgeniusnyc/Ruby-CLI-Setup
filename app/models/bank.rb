class Bank < ActiveRecord::Base
  has_many :userbanks
  has_many :users, through: :userbanks

  def self.list_banks_by_zipcode
    prompt = TTY::Prompt.new
    zipcode_input = prompt.ask("What zipcode do you want to look into?", required: true)

    puts "-----------------------------------------"

    bank_result_array = self.where(zipcode: zipcode_input)

    bank_result_array.each do |bank|
      puts bank.id.to_s + "--" + bank.bank_name + ", " + bank.street_address + ", " + bank.city + ", " + bank.zipcode
    end

    
  end
end
