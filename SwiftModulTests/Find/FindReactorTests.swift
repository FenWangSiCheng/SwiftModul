//
//  FindReactorTests.swift
//  SwiftModulTests
//
//  Created by wangsicheng on 2019/9/2.
//  Copyright © 2019 fenrir-cd. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import Moya
@testable import SwiftModul

class FindReactorTests: XCTestCase {

    var reactor: FindReactor!
    var refreshStatus: BehaviorRelay<RefreshStatus> = .init(value: .none)

    override func setUp() {
        super.setUp()

        reactor = FindReactor(refreshStatus: refreshStatus)
        reactor.action.onNext(.downRefresh(searchName: ""))
    }

    override func tearDown() {
        super.tearDown()
    }

    func testAllProductItems_dataCount() {

        XCTAssertEqual(reactor.currentState.allItemsInfo[0].data.count, 10)

    }

    func testAllProductItems_name() {

        XCTAssertEqual(reactor.currentState.allItemsInfo[0].data[0].goodName, "黑巧克力")

    }

    func testAllProductItems_info() {

        XCTAssertEqual(reactor.currentState.allItemsInfo[0].data[0].goodInfo, "好吃又好玩")

    }

    func testAllProductItems_salePrice() {

        XCTAssertEqual(reactor.currentState.allItemsInfo[0].data[0].goodSalePrice, "售价:20.1")

    }

    func testAllProductItems_originalPrice() {

        let original = CommonTools.shareInstance.addlineToLabelText(text: "原价:30.1")
        XCTAssertEqual(reactor.currentState.allItemsInfo[0].data[0].goodOriginalPrice, original)

    }

    func testAllProductItems_repertory() {

        XCTAssertEqual(reactor.currentState.allItemsInfo[0].data[0].goodRepertory, "库存:20")

    }

    func testAllProductItems_image() {

        XCTAssertEqual(reactor.currentState.allItemsInfo[0].data[0].goodImageUrl, "https://s2.ax1x.com/2019/04/19/Epj1HI.png")

    }

}
