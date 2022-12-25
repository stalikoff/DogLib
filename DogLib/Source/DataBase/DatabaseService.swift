//
//  DatabaseManager.swift
//  CleverTestCoreData
//
//

import UIKit
import CoreData

private enum Constants {
    static let databaseName = "CoreDataModel"
    static let bundleName = "DogLib"
    static let entityName = "ImageEntity"
}

final class DatabaseService {
    private var managedObjectContext: NSManagedObjectContext?

    private lazy var persistentContainer: NSPersistentContainer? = {
        let modelURL = Bundle(for: Self.self).url(forResource: Constants.databaseName, withExtension: "momd")
        guard let model = modelURL.flatMap(NSManagedObjectModel.init) else {
            print("Fail to load the trigger model!")
            return nil
        }
        var container = NSPersistentContainer(name: Constants.bundleName, managedObjectModel: model)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    public init() {
        managedObjectContext = persistentContainer?.viewContext
    }
}

// MARK: - DatabaseManager
extension DatabaseService: DatabaseServiceProtocol {
    func saveImageDatas(_ imageDataArray: [Data], startIndex: Int) {
        guard let managedObjectContext = self.managedObjectContext else { return }

        for i in 0 ... imageDataArray.count - 1  {
            let imageEntity = ImageEntity(context: managedObjectContext)
            imageEntity.imageData = imageDataArray[i]
            imageEntity.index = Int64(startIndex + i)
        }

        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func removeAll() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try persistentContainer?.viewContext.execute(deleteRequest)
        } catch {
            print(error.localizedDescription)
        }
    }

    func saveImageData(_ imageData: Data, atIndex: Int) {
        guard let managedObjectContext = self.managedObjectContext //,
        else { return }

        let imageEntity = ImageEntity(context: managedObjectContext)

        imageEntity.imageData = imageData
        imageEntity.index = Int64(atIndex)

        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func getImage(atIndex: Int, completion: @escaping (Data?) -> ()) {
        let request = NSFetchRequest<ImageEntity>()
        guard let managedObjectContext = self.managedObjectContext,
              let entityDescription = NSEntityDescription.entity(forEntityName: Constants.entityName, in: managedObjectContext) else {
            completion(nil)
            return
        }
        request.entity = entityDescription
        request.predicate = NSPredicate(format: "index = %i", atIndex)

        do {
            let objects = try managedObjectContext.fetch(request)
            let imageData = objects.first?.imageData
            completion(imageData)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            completion(nil)
        }
    }
}
