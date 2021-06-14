//
//  HistoryManager.swift
//  SimCalc
//
//  Created by 위대연 on 2021/06/10.
//

import Foundation
import CoreData

struct CalcLog {
    var date:Date
    var log:String
}

class NSCustomPersistentContainer: NSPersistentContainer {
    override open class func defaultDirectoryURL() -> URL {
      return URL.storeURL(for: "com.dy.SimCalc", databaseName: "HistoryModel")
    }
}

class HistoryManager: NSObject {
    static var shared: HistoryManager = HistoryManager()
    var persistentContainer:NSPersistentContainer = {
      let container = NSCustomPersistentContainer(name: "HistoryModel")
      
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        do {
            let fetchResult = try self.context.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    @discardableResult
    func insertLog(log: CalcLog) -> Bool {
        let entity = NSEntityDescription.entity(forEntityName: "History", in: self.context)
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)
            
            managedObject.setValue(log.date, forKey: "date")
            managedObject.setValue(log.log, forKey: "log")

            do {
                try self.context.save()
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } else {
            return false
        }
    }
    
    @discardableResult
    func delete(object: NSManagedObject) -> Bool {
        self.context.delete(object)
        do{
            try self.context.save()
            return true
        } catch {
            return false
        }
    }
    
    func count<T: NSManagedObject>(request: NSFetchRequest<T>) -> Int? {
        do {
            let count = try self.context.count(for: request)
            return count
        } catch {
            return nil
        }
    }
    
    @discardableResult
    func deleteAll<T: NSManagedObject>(request: NSFetchRequest<T>) -> Bool {
        let request: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try self.context.execute(delete)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}

public extension URL {
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }

        return fileContainer.appendingPathComponent("\(databaseName).xcdatamodeld")
    }
}
