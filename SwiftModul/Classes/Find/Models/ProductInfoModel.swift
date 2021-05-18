//
//  ProductInfoModel.swift
//  SwiftModul
//
//  Created by wangsicheng on 2019/8/29.
//  Copyright © 2019 fenrir-cd. All rights reserved.
//

import UIKit
import RxDataSources

struct ProductInfoModel: Equatable, Codable {
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

     private enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image_url"
        case itemCode = "item_code"
        case salePrice = "sale_price"
        case costPrice = "cost_price"
        case count
        case note
        case category
    }
    
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

}

extension ProductInfoModel: ProductInfoProtocal {
    var goodName: String? {

        return self.name
    }

    var goodImageUrl: String? {

        return self.imageUrl
    }

    var goodInfo: String? {

        return self.note
    }

    var goodSalePrice: String? {

        return "售价:\(self.salePrice ?? 0)"
    }

    var goodOriginalPrice: NSAttributedString? {

        return CommonTools.shareInstance.addlineToLabelText(text: "原价:\(self.costPrice ?? 0)")
    }

    var goodRepertory: String? {

        return "库存:\(self.count ?? 0)"
    }
}

struct ProductInfoSectionModel: Equatable {
    var data: [ProductInfoModel]
    var header: String
    
    static func == (lhs: ProductInfoSectionModel, rhs: ProductInfoSectionModel) -> Bool {
        return lhs.data == rhs.data && lhs.header == rhs.header
    }
}

extension ProductInfoSectionModel: SectionModelType {
    
    typealias Item = ProductInfoModel
    var items: [ProductInfoModel] {
        return data
    }
    init(original: ProductInfoSectionModel, items: [ProductInfoModel]) {
        self = original
        data = items
    }
}

protocol ProductInfoProtocal {
    
    var goodName: String? { get }
    var goodImageUrl: String? { get }
    var goodInfo: String? { get }
    var goodSalePrice: String? { get }
    var goodOriginalPrice: NSAttributedString? { get }
    var goodRepertory: String? { get }
    
}
