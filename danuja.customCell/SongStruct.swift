//
//  SongStruct.swift
//  danuja.customCell
//
//  Created by danuja Jayasuriya on 4/28/23.
//

import Foundation
import UIKit

struct Song: Hashable, Codable {
    let name: String
    let genre: String
    let image: String
}
