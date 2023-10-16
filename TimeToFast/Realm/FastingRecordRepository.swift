//
//  FastingRecordRepository.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/14.
//

import Foundation
import RealmSwift

final class FastingRecordRepository {
    static let shared = FastingRecordRepository()
    
    private let realm: Realm
    
    var recordList: Results<FastingRecordTable>?
    
    private init?() {
        guard let realm = try? Realm() else { return nil }
        self.realm = realm
    }
    
    func create(_ record: FastingRecordTable) throws {
        try realm.write {
            realm.add(record)
        }
    }
    
    func fetch() -> Results<FastingRecordTable>? {
        let records = realm.objects(FastingRecordTable.self).sorted(byKeyPath: "date", ascending: false)
        return records
    }
    
    func update(_ record: FastingRecordTable) throws {
        try realm.write {
            realm.add(record, update: .modified)
        }
    }
    
    func delete(_ record: FastingRecordTable) throws {
        try realm.write {
            realm.delete(record)
        }
    }
    
    func readFileUrl() {
        print(realm.configuration.fileURL)
    }
}
