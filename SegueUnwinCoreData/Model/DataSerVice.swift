//
//  DataSerVice.swift
//  SegueUnwinCoreData
//
//  Created by dohien on 7/16/18.
//  Copyright © 2018 hiền hihi. All rights reserved.
//

import UIKit
import CoreData

class DataSerVice {
    static var shared: DataSerVice = DataSerVice()
    private var _arrays: [Entity]?
    var arrays: [Entity] {
        get {
            if _arrays == nil {
                loadEntity()
            }
            return _arrays ?? []
        }
        set {
            _arrays = newValue
        }
    }
    private func loadEntity() {
        _arrays = []
        do {
            _arrays = try AppDelegate.context.fetch(Entity.fetchRequest()) as [Entity]
        } catch  {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    func saveData() {
        AppDelegate.saveContext()
        loadEntity()
    }
    func remove(at indexPath : IndexPath) {
        guard let object = _arrays else { return }
        AppDelegate.context.delete(object[indexPath.row])
        saveData()
    }
}
