class SessionsView
  def ask_for_username
    puts "Username?"
    print "> "
    gets.chomp
  end

  def ask_for_password
    puts "Password?"
    print "> "
    gets.chomp
  end

  def wrong_credentials
    puts "Wrong credentials... Try again!"
  end

  def welcome(employee)
    puts "Welcome #{employee.username}! You are a #{employee.role}"
  end
end
