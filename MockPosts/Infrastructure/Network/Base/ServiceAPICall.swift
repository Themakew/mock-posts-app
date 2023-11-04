//
//  ServiceAPICall.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

import Alamofire
import Foundation
import RxAlamofire
import RxSwift

protocol ServiceAPICallProtocol {
    func request<T: Decodable>(request: APIRequest, type: T.Type, parameters: Parameters?) -> Observable<Result<T, NetworkError>>
}

extension ServiceAPICallProtocol {
    func request<T: Decodable>(request: APIRequest, type: T.Type, parameters: Parameters? = nil) -> Observable<Result<T, NetworkError>> {
        self.request(request: request, type: type, parameters: parameters)
    }
}

final class ServiceAPICall: ServiceAPICallProtocol {

    // MARK: - Private Methods

    private let session: Session

    // MARK: - Initializer

    init(session: Session = .default) {
        self.session = session
    }

    // MARK: - Internal Methods

    func request<T: Decodable>(request: APIRequest, type: T.Type, parameters: Parameters?) -> Observable<Result<T, NetworkError>> {
        return session.rx.request(request.method, request.url, parameters: parameters)
            .responseData()
            .flatMapLatest { response, data -> Observable<Result<T, NetworkError>> in
                do {
                    return Observable<Result<T, NetworkError>>.create { observer in
                        debugPrint()
                        debugPrint("####################################################")
                        debugPrint(" 🌐 URL: \(response.url?.description ?? "-")")
                        debugPrint(" 📣 STATUS CODE: \(response.statusCode)")
                        debugPrint(" 🚀 METHOD: \(request.method.rawValue)")

                        guard (200..<400).contains(response.statusCode) else {
                            let error = NetworkError.httpResponseError(statusCode: response.statusCode)
                            debugPrint(" ❌ Finished With Error: \(error.localizedDescription)")
                            debugPrint(error.localizedDescription)

                            observer.onNext(.failure(error))
                            observer.onCompleted()
                            return Disposables.create()
                        }

                        do {
                            let decodedObject = try JSONDecoder().decode(type.self, from: data)
                            debugPrint(" ✅ Finished With Success")
                            debugPrint(" ✅ JSON OBJECT: \(decodedObject)")
                            debugPrint()

                            observer.onNext(.success(decodedObject))
                        } catch let errorDescription {
                            let error = NetworkError.decodeError
                            debugPrint(" ❌ Finished With Error:")
                            debugPrint("\(error.localizedDescription):")
                            debugPrint(errorDescription)
                            debugPrint()

                            observer.onNext(.failure(error))
                        }

                        observer.onCompleted()
                        return Disposables.create()
                    }
                }
            }
    }
}
