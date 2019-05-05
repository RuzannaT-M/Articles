//
//  DataBaseAdapter.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 5/5/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

typealias DBSuccesBlock  = (_ result: Results<Article>?,  _ error:Error?) -> Void

class DataBaseAdapter {
    
    private var notificationToken: NotificationToken?
    private var realm: Realm
    
    //MARK: - Initialization
    init() {
        do {
            realm = try Realm.init()
        } catch let error as NSError {
            print("\nError:   code === \(error._code) " + "\(error.localizedDescription)\n")
            realm = try! Realm.init()
        }
    }
    
    //MARK: Public methods
    func getObjects(completion: @escaping DBSuccesBlock) {
        let objects: Results<Article> = realm.objects(Article.self).sorted(byKeyPath: "date", ascending: false)
        self.notificationToken = objects.observe { changes in
            switch changes {
            case .initial:
                completion(objects, nil)
                print(objects.count)
            case .update(_, let deletions, let insertions, let modifications):
                completion(nil, nil)
                print(deletions, insertions, modifications)
            case .error(let error):
                completion(nil, error)
                print("\nError:   code === \(error._code) " + "\(error.localizedDescription)\n")
            }
        }
    }
    
    func saveObjects(objects: [Article]) {
        DispatchQueue.global(qos: .background).async {
            let realm = try! Realm()
            do {
                try realm.write {
                    realm.add(objects, update: true)
                }
            } catch let error as NSError {
                print("\nError:   code === \(error._code) " + "\(error.localizedDescription)\n")
            }
        }
    }
    
    //MARK: - Deinitialization
    deinit {
        notificationToken?.invalidate()
    }
}
