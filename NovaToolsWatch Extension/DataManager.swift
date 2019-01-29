//
//  DataManager.swift
//  NovaToolsWatch Extension
//
//  Created by Clayton Oliveira on 28/09/18.
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
    
   
    private static let basePath = "https://fplusapi20180813114855.azurewebsites.net/api/"
    
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
    
    class func reiniciaTerminais(token: String, onComplete: @escaping (String) -> Void, onError: @escaping (Bool) -> Void){
        
        guard let url = URL(string: basePath + "manager/restart/\(token)/") else {return}
        
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
                        //let pedidos = try JSONDecoder().decode([ComprasItensModel].self, from: data)
                        onComplete("")
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
    
    
    
}

