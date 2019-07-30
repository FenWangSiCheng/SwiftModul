//
//  FindReactor.swift
//  SwiftModul
//
//  Created by wangsicheng on 2019/3/12.
//  Copyright © 2019 fenrir-cd. All rights reserved.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift

final class FindReactor: Reactor {
    
    enum Action {
        case getTestModel
    }
    
    enum Mutation {
        case setTestModel(testModel: [TestSectionModel])
    }
    
    struct State {
       var testModel = [TestSectionModel]()
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(
            testModel: []
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case .getTestModel:
                return serviceManager.findService.getTestModel().asObservable().map{_ in Mutation.setTestModel(testModel: [TestSectionModel(data:[])])}.catchErrorJustReturn(Mutation.setTestModel(testModel: []))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
            case let .setTestModel(testModel: testModel):
                state.testModel = testModel
        }
        return state
    }
    
}
