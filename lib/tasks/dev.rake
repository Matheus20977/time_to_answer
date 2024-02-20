namespace :dev do
  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, "lib", "tmp") # Mesma coisa que time_to_answer/lib/tmp, File.join é responsável por colocar as barras corretas

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando o BD") { %x(rails db:drop) }
      show_spinner("Criando o BD") { %x(rails db:create) }
      show_spinner("Migrando o BD") { %x(rails db:migrate) }
      show_spinner("Cadastrando o administrador padrão") { %x(rails dev:add_default_admin) }
      show_spinner("Cadastrando administradores extras") { %x(rails dev:add_extra_admins) }
      show_spinner("Cadastrando o usuário padrão") { %x(rails dev:add_default_user) }
      show_spinner("Cadastrando assuntos padrão") { %x(rails dev:add_subjects) }
      show_spinner("Cadastrando perguntas e respostas") { %x(rails dev:add_answers_and_questions) }
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: "admin@admin.com",
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona administradores extras"
  task add_extra_admins: :environment do
    10.times do
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
      email: "user@user.com",
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona assuntos padrão"
  task add_subjects: :environment do
    file_name = "subjects.txt"
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, "r").each do |line|
      Subject.find_or_create_by!(description: line.strip)
    end
  end

  desc "Adiciona perguntas e respostas"
  task add_answers_and_questions: :environment do
    Subject.all.each do |subject|
      rand(5..10).times do |i|
        params = create_question_params(subject)
        answers_array = params[:question][:answers_attributes]

        add_answers(answers_array)
        define_correct_answer(answers_array)

        Question.create!(params[:question])
      end
    end
  end

  private
  
  def create_question_params(subject = Subject.all.sample)
    { question: {
        description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
        subject: subject,
        answers_attributes: []
      }
    }
  end

  def create_answer_params
    { description: Faker::Lorem.sentence, correct: false }
  end

  def add_answers(answers_array = [])
    # Cria entre 4 e 5 respostas para cada pergunta
    rand(4..5).times do |j|
      answers_array.push(
        create_answer_params
      )
    end
  end

  def define_correct_answer(answers_array = [])
    # Define, de forma aleatória, uma das respostas como correta
    selected_index = rand(answers_array.size)
    answers_array[selected_index][:correct] = true
  end

  def show_spinner(start_msg, end_msg = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{start_msg}...")
    spinner.auto_spin
    yield
    spinner.success("#{end_msg}")
  end

end
