require_relative '../views/sessions_view'
class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionsView.new
  end


  def login
    # 1. Perguntar o username e senha
    username = @view.ask_for_username
    password = @view.ask_for_password

    # 2. Verificar se o usuário existe e a senha está correta
    employee = @employee_repository.find_by_username(username)
    if employee && employee.password == password
      # 3. Se sim, logar o usuário
      @view.welcome(employee)
    else
      # 4. Se não, mostrar uma mensagem de erro e voltar para o login
      @view.wrong_credentials
      login
    end
    employee
  end
end
