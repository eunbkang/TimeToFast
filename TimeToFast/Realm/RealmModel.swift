//
//  RealmModel.swift
//  TimeToFast
//
//  Created by Eunbee Kang on 2023/10/12.
//

import Foundation
import RealmSwift

class FastingRecordTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var date: Date
    @Persisted var fastingPlan: String
    @Persisted var fastingStartTime: Date
    @Persisted var fastingEndTime: Date
    @Persisted var note: String
    @Persisted var fastingDuration: Int
    @Persisted var eatingDuration: Int
    @Persisted var isGoalAchieved: Bool
    
    convenience init(date: Date, fastingPlan: String, fastingStartTime: Date, fastingEndTime: Date, note: String, fastingDuration: Int, eatingDuration: Int, isGoalAchieved: Bool) {
        self.init()
        
        self.date = date
        self.fastingPlan = fastingPlan
        self.fastingStartTime = fastingStartTime
        self.fastingEndTime = fastingEndTime
        self.note = note
        self.fastingDuration = fastingDuration
        self.eatingDuration = eatingDuration
        self.isGoalAchieved = isGoalAchieved
    }
}