//
//  HomeViewModel.swift
//  MockPosts
//
//  Created by Ruyther Costa on 28/01/23.
//

import RxRelay
import RxSwift
import RxCocoa
import UIKit
import XCoordinator

protocol HomeViewModelProtocol {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}

protocol HomeViewModelInput {

}

protocol HomeViewModelOutput {

}

extension HomeViewModelProtocol where Self: HomeViewModelInput & HomeViewModelOutput {
    var input: HomeViewModelInput { return self }
    var output: HomeViewModelOutput { return self }
}

final class HomeViewModel: HomeViewModelProtocol, HomeViewModelInput, HomeViewModelOutput {

}
