//
//  ProductInfoModel.swift
//  SwiftModul
//
//  Created by wangsicheng on 2019/8/29.
//  Copyright © 2019 fenrir-cd. All rights reserved.
//

import UIKit
import ObjectMapper
import RxDataSources

//server data
struct ProductInfoModel: Equatable, Mappable {
    /** 商品名字 */
    public var name: String?
    /** 商品图片地址 */
    public var imageUrl: String?
    /** 商品ID */
    public var itemCode: String?
    /** 售价 */
    public var salePrice: Double?
    /** 原价 */
    public var costPrice: Double?
    /** 库存 */
    public var count: Int?
    /** 备注 */
    public var note: String?
    /** 分类 */
    public var category: String?
    
    static func == (lhs: ProductInfoModel, rhs: ProductInfoModel) -> Bool {
        return lhs.name == rhs.name
            && lhs.imageUrl == rhs.imageUrl
            && lhs.itemCode == rhs.itemCode
            && lhs.salePrice == rhs.salePrice
            && lhs.costPrice == rhs.costPrice
            && lhs.count == rhs.count
            && lhs.note == rhs.note
            && lhs.category == rhs.category
    }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        imageUrl <- map["image_url"]
        itemCode <- map["item_code"]
        salePrice <- map["sale_price"]
        costPrice <- map["cost_price"]
        count <- map["count"]
        note <- map["note"]
        category <- map["category"]
    }
}

//UI data
struct ProductInfoModelUI: Equatable {
    
    var name: String?
    var imageUrl: String?
    var info: String?
    var salePrice: String?
    var repertory: String?
    var originalPrice: NSAttributedString?
    
    static func == (lhs: ProductInfoModelUI, rhs: ProductInfoModelUI) -> Bool {
        return lhs.name == rhs.name
            && lhs.imageUrl == rhs.imageUrl
            && lhs.info == rhs.info
            && lhs.salePrice == rhs.salePrice
            && lhs.repertory == rhs.repertory
            && lhs.originalPrice == rhs.originalPrice
    }
}

extension ProductInfoModelUI: ProductInfoProtocal {}

//DataSourceSectionModel
struct ProductInfoSectionModel: Equatable {
    var data: [ProductInfoModelUI]
    var header: String
    
    static func == (lhs: ProductInfoSectionModel, rhs: ProductInfoSectionModel) -> Bool {
        return lhs.data == rhs.data && lhs.header == rhs.header
    }
}

extension ProductInfoSectionModel: SectionModelType {
    
    typealias Item = ProductInfoModelUI
    var items: [ProductInfoModelUI] {
        return data
    }
    init(original: ProductInfoSectionModel, items: [ProductInfoModelUI]) {
        self = original
        data = items
    }
}

//modelProtocal
protocol ProductInfoProtocal {
    
    var name: String? { get }
    var imageUrl: String? { get }
    var info: String? { get }
    var salePrice: String? { get }
    var originalPrice: NSAttributedString? { get }
    var repertory: String? { get }
    
}
