//
//  TransformationsRepositoryProtocol.swift
//  DragonBallRocio
//
//  Created by Rocio Martos on 19/3/24.
//

import Foundation
protocol TransformationsRepositoryProtocol{
    func getTransformation(filter: UUID?) async -> [Transformacione]
}
