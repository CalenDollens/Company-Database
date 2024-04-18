class Person
    attr_accessor :name, :email, :phone
  
    def initialize(name, email, phone)
      @name = name
      @email = email
      @phone = phone
    end
  
    # Operator overloads for IO operations
    def to_s
      "Name: #{@name} Email: #{@email} Phone: #{@phone}"
    end
  
    def save_to_file(file_path)
      File.open(file_path, 'w') do |file|
        file.puts(@name)
        file.puts(@email)
        file.puts(@phone)
      end
    end
  
    def self.load_from_file(file_path)
      lines = File.readlines(file_path).map(&:chomp)
      Person.new(lines[0], lines[1], lines[2])
    end
  end