//
//  ImageEntity+CoreDataProperties.swift
//  CleverTestCoreData
//
//
//

import Foundation
import CoreData


extension ImageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageEntity> {
        return NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
    }

    @NSManaged public var index: Int64
    @NSManaged public var imageData: Data?
}

extension ImageEntity : Identifiable {

}
