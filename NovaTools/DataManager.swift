//
//  DataManager.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 10/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import Foundation

enum ErrorManager: String {
    case CredentialError = "Credenciais incorretas"
    case NetworkError = "Rede de dados com problemas"
    case TimeOut = "Tempo de resposta do servidor"
    case JSONConvert = "Erro lendo os dados recebidos"
    case Not200 = "Status diferente de 200"
    case Exception = "Erro desconhecido..."
}

class DataManager {
    
    public static var UserToken: String = Configuration.shared.TokenAPI
    
    private static let basePath = "http://app.devplus.com.br:8081/api/"
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true;
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 10.0
        config.httpMaximumConnectionsPerHost = 20
        config.shouldUseExtendedBackgroundIdleMode = true
        
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    //Recupera token do usuario, verificação para poder efetuar o login no sistema
    class func getUserToken(user: UserModel, onComplete: @escaping (UserModel?) -> Void, onError:@escaping (ErrorManager) -> Void) {
        
        guard let url = URL(string: basePath + "user") else {
            onError(ErrorManager.NetworkError)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let json = try? JSONEncoder().encode(user) else {
            onError(ErrorManager.JSONConvert)
            return
        }
        
        request.httpBody = json
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                    onError(ErrorManager.Exception)
                    //print(error.localizedDescription)
                    return
                    
                }
                do
                {
                    let user = try JSONDecoder().decode(UserModel.self, from: data)
                    onComplete(user)
                }
                catch
                {
                    onError(ErrorManager.Exception)
                    print(error.localizedDescription)
                }
            } else {
                onError(ErrorManager.Exception)
                return
            }
        }
        
        dataTask.resume()
        //semaphore.wait()
                
    }
    
    class func aprovaPedido(token: String, pedido: CompraModel, onComplete: @escaping (Bool) -> Void) {
        guard let url = URL(string: basePath + "compras/aprovacao/" + token) else {
            onComplete(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let json = try? JSONEncoder().encode(pedido) else {
            return
        }
        
        request.httpBody = json
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let _ = data else {
                    onComplete(false)
                    return
                }
                
                onComplete(true)
                
            } else {
                onComplete(false)
                return
            }
        }
        
        dataTask.resume()
    }
    
    class func loadItensCompras(pedido: String, tipo: String, onComplete: @escaping ([ComprasItensModel]) -> Void, onError: @escaping (Bool) -> Void){
        
        guard let url = URL(string: basePath + "compras/consulta/\(pedido)/\(tipo)") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([ComprasItensModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    
    class func loadCompras(token: String, onComplete: @escaping ([CompraModel]) -> Void, onError: @escaping (Bool) -> Void){
        
        guard let url = URL(string: basePath + "compras/" + token) else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do
                    {
                        let pedidos = try JSONDecoder().decode([CompraModel].self, from: data)
                        onComplete(pedidos)
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    
    
    class func loadPedidoPeca(peca: String, onComplete: @escaping ([PedidosModel]) -> Void, onError: @escaping (Bool) -> Void){
        
        guard let url = URL(string: basePath + "pecas/pedidos/\(peca)") else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    
                    guard let data = data else {return}
                    //print(data)
                    do {
                        
                        let pedidos = try JSONDecoder().decode([PedidosModel].self, from: data)
                        onComplete(pedidos)
                   
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    
    class func loadPecaComplete(peca: String, onComplete: @escaping (Peca) -> Void, onError: @escaping (Bool) -> Void){
        
        guard let url = URL(string: basePath + "pecas/image/\(peca)") else {return}

        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {
                    onError(true)
                    return
                }
                
                if response.statusCode == 200
                {
                    
                    guard let data = data else {return}
                    //print(data)
                    do {
                        
                        let pec = try JSONDecoder().decode(Peca.self, from: data)
                        onComplete(pec)
                        
                        if pec.image == nil {
                            onError(true)
                        }
                        
                    }
                    catch
                    {
                        onError(true)
                        print(error.localizedDescription)
                    }
                }
                else
                {
                    onError(true)
                }
                
            }
            else
            {
                onError(true)
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    
    class func loadPecas(prefix: String, onComplete: @escaping ([Peca]) -> Void, onError: @escaping (ErrorManager) -> Void){
        guard let url = URL(string: basePath + "pecas/" + prefix) else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {
                    onError(ErrorManager.NetworkError)
                    return
                }
                
                if response.statusCode == 200
                {
                    guard let data = data else {return}
                    //print(data)
                    do {
                        let pecas = try JSONDecoder().decode([Peca].self, from: data)
                        onComplete(pecas)
                    }
                    catch
                    {
                        onError(ErrorManager.JSONConvert)
                        print(error.localizedDescription)
                    }
                }
                else {
                    print(response.statusCode)
                    onError(ErrorManager.Not200)
                    return
                }
                
            }
            else
            {
                onError(ErrorManager.Exception)
                print(error!.localizedDescription)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    class func loadPecasDescricao(descricao: String = "", page: Int = 0, onComplete: @escaping ([Peca]) -> Void){
        
        var baseUrl = ""
        
        if descricao == ""{
            baseUrl = basePath + "pecas/descricao/-/\(page)"
        }
        else
        {
            baseUrl = basePath + "pecas/descricao/\(descricao)/\(page)"
        }
        guard let url = URL(string: baseUrl) else {return}
        
        //No get nao precisa de objeto de request.... padrao GET
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil
            {
                guard let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200
                {
                    
                    guard let data = data else {return}
                    print(data)
                    do {
                        let pecas = try JSONDecoder().decode([Peca].self, from: data)
                        onComplete(pecas)
                    }
                    catch
                    {
                        print(error.localizedDescription)
                    }
                }
                
            }
            else
            {
                print(error!)
            }
            
        }
        //Executa
        dataTask.resume()
    }
    
}
