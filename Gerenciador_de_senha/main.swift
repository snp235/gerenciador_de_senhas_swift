import Foundation

struct User : Codable {
    var name: [String] = []
    var password: [String] = []
    var url : [String] = []
}

class ViewModel {
    // protocolo é conjunto de regras que indica que quem assina o protocolo tem que implementar as regras
    static let fileManager = FileManager.default
    // static é pra acessar sem instanciar ("acesso global") n muda com instancia
    static  var documentsDirectory: URL {
        return ViewModel.fileManager.urls(for: .documentDirectory, in: .allDomainsMask).first!
    }
    static var jsonURL: URL {
        return ViewModel.documentsDirectory.appendingPathComponent("senhas.json")
    }
    
    var user: User
    
    init() {
        self.user = User()
    }
    
    func decodar () {
        let decoder = JSONDecoder()
        do {
            
            let dado = try Data(contentsOf: ViewModel.jsonURL)
            let objectDecode = try decoder.decode(User.self, from: dado)
            self.user.name = objectDecode.name
            self.user.password = objectDecode.password
            self.user.url = objectDecode.url
        } catch{
            print("Não deu para converter")
        }
    }
    
    func cadastro() {
        print("Cadastre seu nome de usuário")
        if let user_name = readLine(){
            user.name.append(user_name)
            
            print("Cadastre sua senha")
            if let password = readLine(){
                user.password.append(password)
                
                print("Cadastre a URL")
                if let user_url = readLine(){
                    user.url.append(user_url)
                    print("Usuário cadastrado com sucesso!")
                }else {
                    print("Erro ao cadastrar usuário!")
                }
            }
        }
    }
    
    func listar() {
        if ((user.name.isEmpty) || (user.password.isEmpty) || (user.url.isEmpty)) {
            print("Nenhum usuário encontrado!")
        } else {
            print("Users cadastrados:")
                for i in 0..<user.name.count{
                    print("User \(i+1): ")
                    print("User name : ",user.name[i])
                    print("Password: ",user.password[i])
                    print("Url: ",user.url[i])
                }
            }
        }
    
    func excluir() {
        if ((user.name.isEmpty) || (user.password.isEmpty) || (user.url.isEmpty)) {
            print("Nenhum usuário encontrado!")
        } else {
            print("Digite o user name que você deseja editar a senha: ")
            if let busca_username_excluir = readLine(){
                for i in 0..<user.name.count{
                    if busca_username_excluir == user.name[i] {
                        user.name.remove(at: i)
                        user.password.remove(at: i)
                        user.url.remove(at: i)
                    }
                }
            }
            else {
                print("User name inválido")
            }
        }
    }
    
    func editar_password() {
        if (user.password.isEmpty) {
            print("Nenhuma senha cadastrada!")
        }
        else{
            print("Digite o user name que você deseja editar a senha")
            if let busca_username = readLine() {
                for i in 0..<user.name.count {
                    if busca_username == user.name[i] {
                        print("Digite uma nva senha: ")
                        if let new_password = readLine() {
                            user.password[i] = new_password
                            print("Senha editada com sucesso!")
                        }
                    }
                }
            } else {
                print("User name inválido")
            }
        }
    }
    
    func editar_url() {
        if (user.url.isEmpty) {
            print("Nenhuma senha cadastrada!")
        }
        
        else{
            print("Digite o user name que você deseja editar a senha")
            if let busca_username = readLine() {
                for i in 0..<user.name.count {
                    if busca_username == user.name[i] {
                        print("Digite uma nova url: ")
                        if let new_url = readLine() {
                            user.url[i] = new_url
                            print("Url editada com sucesso!")
                        }
                    }
                }
            } else {
                print("User name inválido")
            }
        }
    }
    
    func menu(){
            var userInput: String?
            print("Escolha uma opção:")
            print("1. Cadastrar novo usuário")
            print("2. Editar password")
            print("3. Editar Url")
            print("4. Listar usuários")
            print("5. Excluir usuários")
            print("6. Sair")
            
            userInput = readLine()
            if let input = userInput, let choice = Int(input){
                switch choice {
                case 1:
                    cadastro()
                    break
                case 2:
                    editar_password()
                    break
                case 3:
                    editar_url()
                    break
                case 4:
                    listar()
                case 5:
                    excluir()
                case 6:
                    print("Encerrando")
                    exit(0)
                default:
                    print("Opção inválida.")
                }
            }
        }
    
    func encodeAndSave() {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                
                do {
                    let data = try encoder.encode(user)
                    try data.write(to: ViewModel.jsonURL)
                } catch {
                    print("Não foi possível salvar os dados.")
                }
            }
        }
    let viewModel = ViewModel()
    viewModel.decodar()
        
        while true{
            viewModel.menu()
            viewModel.encodeAndSave()
        }
    
    
    

