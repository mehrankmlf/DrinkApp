//
//  DrinkListUseCase.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation
import Combine

protocol DrinkListProtocol : AnyObject {
    func getDrinkListService(a: String) -> AnyPublisher<BaseResponse<[DrinkList_Response]>?, APIError>
}

final class DrinkList_Request : BaseAPI<DrinkListNetworking>, DrinkListProtocol {
    
    func getDrinkListService(a: String) -> AnyPublisher <BaseResponse<[DrinkList_Response]>?, APIError> {
        self.fetchData(target: .drinkList(a: a), responseClass: BaseResponse<[DrinkList_Response]>.self)
    }
}
