//
//  NetworkService.swift
// Pokedex
//
//  Created by Omar Huchin on 03/17/21.
//  Copyright © 2020 Omar.Huchin. All rights reserved.
//

import Foundation
import Networking
import Promises
class NetworkService: INetwork{
    private let baseUrl: String
    private let configuration: URLSessionConfiguration
    let networking: Networking
    static var host = "https://pokeapi.co/api"
    static var apiVersion = "v2"
    static var imageHost = "https://pokeres.bastionbot.org/images/pokemon/"
    static var _baseUrl: String{
        return "\(NetworkService.host)/\(NetworkService.apiVersion)/"
    }
    static let shared: NetworkService =  NetworkService(baseURL: _baseUrl, enableLog: true)
    init(baseURL: String, configuration: URLSessionConfiguration = .default){
        self.networking = Networking(baseURL: baseURL, configuration: configuration, cache: nil)
        self.baseUrl = baseURL
        self.configuration = configuration
    }
    init(baseURL: String, enableLog: Bool, configuration: URLSessionConfiguration = .default){
        self.networking = Networking(baseURL: baseURL, configuration: configuration, cache: nil)
        self.networking.isErrorLoggingEnabled = enableLog
        self.baseUrl = baseURL
        self.configuration = configuration
    }
    func request<T: Codable>(_ request: INetworkRouter, type: T.Type) -> Promise<T> {
        return _request(request, type: type)
    }
   
    private func _request<T: Codable>(_ request: INetworkRouter, type: T.Type) -> Promise<T> {
        return Promise<JSONResult>.init(on: request.thread) { (fulfill,reject) in
            let networking = self.getNetworking(request)
            let parameterEncoding = request.task.parameterType
            let parameters = request.task.parameters
            networking.headerFields = request.headers
            switch request.method {
            case .post:
                networking.post(request.path, parameterType: parameterEncoding, parameters: parameters, completion: {fulfill($0)})
                break
            case .get:
                networking.get(request.path, parameters: parameters, completion: {fulfill($0)})
            
                break
            case .put:
                networking.put(request.path, parameterType: parameterEncoding, parameters: parameters, completion: {fulfill($0)})
                break
            case .upload:
                guard let data = request.task.data else {
                    throw ServiceError.incompleteFields
                }
                networking.post(request.path, parts: data, completion: {fulfill($0)})
                break
            }
        }.then(on: request.thread) { (jsonResult) -> T in
            switch jsonResult{
            case .success(let value):
                let decodeValue = try JSONDecoder().decode(type, from: value.data)
                return decodeValue
            case .failure(let fail):
                print(fail.error)
                print(fail.statusCode)
                throw fail.error
            }
        }
       
        
    }
    private func _request2<T: Codable>(_ request: INetworkRouter, type: T.Type) -> Promise<T> {
        let promise = Promise<T>.pending()
        let networking = getNetworking(request)
        let parameterEncoding = request.task.parameterType
        let parameters = request.task.parameters
        networking.headerFields = request.headers
        switch request.method {
            
        case .post:
            networking.post(request.path, parameterType: parameterEncoding, parameters: parameters, completion: { self.process(result: $0, promise: promise, type: type)})
            //networking.post(request.path, parameters: request.parameters, completion:{ self.process(result: $0, promise: promise, type: type)})
            break
        case .get:
            networking.get(request.path, parameters: parameters, completion: { self.process(result: $0, promise: promise, type: type)})
            //networking.get(request.path, parameters: request.parameters, completion:{ self.process(result: $0, promise: promise, type: type)})
            break
        case .put:
            networking.put(request.path, parameterType: parameterEncoding, parameters: parameters, completion: { self.process(result: $0, promise: promise, type: type)})
            //networking.put(request.path, parameters: request.parameters, completion:{ self.process(result: $0, promise: promise, type: type)})
            break
        case .upload:
            guard let data = request.task.data else {
                return Promise<T>{
                    throw ServiceError.incompleteFields
                }
            }
            networking.post(request.path, parts: data, completion: { self.process(result: $0, promise: promise, type: type)})
            //networking.post(request.path, parameters: request.parameters, completion:{ self.process(result: $0, promise: promise, type: type)})
            break
        }
        return promise
    }
    private func process<T: Codable>(result: JSONResult, promise: Promise<T>, type: T.Type){
        switch result{
            
        case .success(let value):
            do {
                let dataDecode = try JSONDecoder().decode(type, from: value.data)
                promise.fulfill(dataDecode)
            } catch {
                print(error)
                promise.reject(ServiceError.unableParse)
            }
            break
        case .failure(let fail):
            print(fail.error)
            print(fail.statusCode)
            promise.reject(fail.error)
            break
        }
    }
    private func getNetworking(_ request: INetworkRouter)->Networking{
        print(request.baseURL?.absoluteString)
        print(request.baseURL?.relativeString)
        networking.headerFields = request.headers
        if request.baseURL != nil && (request.baseURL?.absoluteString != baseUrl || configuration.timeoutIntervalForRequest != request.timeOut){
            let urlSession = URLSessionConfiguration.default
            urlSession.timeoutIntervalForRequest = request.timeOut
            urlSession.timeoutIntervalForResource =  request.timeOut
            return Networking(baseURL: request.baseURL!.absoluteString, configuration: urlSession, cache: nil)
        }
        return networking
    }
}
