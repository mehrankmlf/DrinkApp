//
//  DrinkDetailUseCase.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation
import Combine

protocol DrinkDetailProtocol : AnyObject {
    func getDrinkDetailService(i: String) -> AnyPublisher<BaseResponse<[DrinkDetail_Response]>?, APIError>
}

final class DrinkDetail_Request : BaseAPI<DrinkDetailNetworking>, DrinkDetailProtocol {
    
    func getDrinkDetailService(i: String) -> AnyPublisher <BaseResponse<[DrinkDetail_Response]>?, APIError> {
        self.fetchData(target: .drinkDetail(i: i), responseClass: BaseResponse<[DrinkDetail_Response]>.self)
    }
}
