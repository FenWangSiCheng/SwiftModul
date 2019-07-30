//
//  TestModel.swift
//  SwiftModul
//
//  Created by wangsicheng on 2018/7/4.
//  Copyright © 2018年 fenrir-cd. All rights reserved.
//

import UIKit
import ObjectMapper
import RxDataSources

struct TestSectionModel: Equatable {
    var data: [TestModel]

    public static func == (lhs: TestSectionModel, rhs: TestSectionModel) -> Bool {
        return lhs.data == rhs.data
    }
}

extension TestSectionModel: SectionModelType {

    typealias Item = TestModel
    var items: [TestModel] {
        return data
    }
    init(original: TestSectionModel, items: [TestModel]) {
        self = original
        data = items
    }
}

struct TestModelArrayModel: Mappable, Equatable {

    var anchors: [TestModel]?

    init?(map: Map) {

        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        anchors <- map["anchors"]
    }

    public static func == (lhs: TestModelArrayModel, rhs: TestModelArrayModel) -> Bool {
        return lhs.anchors == rhs.anchors
    }
}

struct TestModel: Mappable, Equatable {

    var name: String = ""
    var pic51: String = ""

    init?(map: Map) {

        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        name <- map["name"]
        pic51 <- map["pic51"]
    }

    public static func == (lhs: TestModel, rhs: TestModel) -> Bool {
        return lhs.name == rhs.name && lhs.pic51 == rhs.pic51
    }

}
