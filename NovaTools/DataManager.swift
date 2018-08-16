//
//  DataManager.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 10/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import Foundation


class DataManager {
    
    private static let basePath = "https://fplusapi20180813114855.azurewebsites.net/api/pecas/"
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true;
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 10
        
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    class func loadPedidoPeca(peca: String, onComplete: @escaping ([PedidosModel]) -> Void, onError: @escaping (Bool) -> Void){
        
        guard let url = URL(string: basePath + "pedidos/\(peca)") else {return}
        
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
        
        guard let url = URL(string: basePath + "image/\(peca)") else {return}

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
        guard let url = URL(string: basePath + prefix) else {return}
        
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
