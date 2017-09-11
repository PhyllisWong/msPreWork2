//
//  GameOfLifeSimulation.swift
//  Grid-Simulations
//
//  Created by Yujin Ariza on 3/21/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation

public class GameOfLifeSimulation: Simulation {

    public var liveChar: Character = "👾"
    
    public override func update() {
        
    }

    func getAlive(grid: [[Character?]], column x: Int, row y: Int) -> Int {
        return 1
    }
    
    func countNeighbors(grid: [[Character?]], column x: Int, row y: Int) -> Int {
        return 1
    }
}
