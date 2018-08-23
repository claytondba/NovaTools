//
//  DataManager.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 10/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import Foundation


class DataManager {
    
    public static var UserToken: String = Configuration.shared.TokenAPI
    
    private static let basePath = "https://fplusapi20180813114855.azurewebsites.net/api/"
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true;
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 10
        
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    class func getUserToken(user: UserModel, onComplete: @escaping (UserModel?) -> Void ) {
        
        guard let url = URL(string: basePath + "user") else {
            onComplete(nil)
            return
        }
        let semaphore = DispatchSemaphore(value: 0)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let json = try? JSONEncoder().encode(user) else {
            return
        }
        
        request.httpBody = json
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                    onComplete(nil)
                    semaphore.signal()
                    return
                    
                }
                do
                {
                    let user = try JSONDecoder().decode(UserModel.self, from: data)
                    onComplete(user)
                    semaphore.signal()
                }
                catch
                {
                    onComplete(nil)
                    print(error.localizedDescription)
                    semaphore.signal()
                }
            } else {
                onComplete(nil)
                semaphore.signal()
                return
            }
        }
        
        dataTask.resume()
        semaphore.wait()
                
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
                guard let response = response as? HTTPURLResponse else {return}
                
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
    
    class func loadPecas(prefix: String, onComplete: @escaping ([Peca]) -> Void){
        guard let url = URL(string: basePath + "pecas/" + prefix) else {return}
        
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
