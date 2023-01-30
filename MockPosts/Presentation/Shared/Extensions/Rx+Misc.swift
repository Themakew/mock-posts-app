//
//  Rx+Misc.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

import RxSwift

extension ObservableType {
    func flatMap<A: AnyObject, O: ObservableType>(weak scope: A, selector: @escaping (A, Self.Element) throws -> O) -> Observable<O.Element> {
        return flatMap { [weak scope] value -> Observable<O.Element> in
            try scope.map { try selector($0, value).asObservable() } ?? .empty()
        }
    }

    func filterNotNil<T>() -> Observable<T> where Element == T? {
        return self.filter { $0 != nil }.flatMap { Observable.from(optional: $0) }
    }
}
