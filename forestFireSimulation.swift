//
//  forestFireSimulation.swift
//  Grid-Simulations
//
//  Created by djchai on 9/11/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation

public class ForestFireSimulation: Simulation {
	// instance variable to hold temporary grid
	var newGrid: [[Character?]] = []
	var lighteningGrid: [[Character?]] = []
	
	// set up the palette - grid
	public override func setup() {
		
		grid = [[Character?]](repeating: [Character?](repeating: nil, count: 10), count: 10)
		
		for x in 0..<8 {
			for y in 0..<10 {
				// hold randomZeroToOne method in a constant
				let randomNum = randomZeroToOne()
				
				if randomNum <= 0.24 {
					grid[x][y] = "🌲"
				} else if (randomNum >= 0.25 && randomNum <= 0.5) {
					grid[x][y] = "🔥"
				}
			}
		}
	}
	
	
	// ~~~~~~~~~~~~~~~Spawning Trees~~~~~~~~~~~~~~ //
	public override func update() {
		 thunderboltAndLightning()
//		aTinyForest()
	}
	
	func thunderboltAndLightning() {
		lighteningGrid = grid
		
		for x in 0..<grid.count {
			for y in 0..<grid[x].count {
				let cell = grid[x][y]
				
				if (cell == nil) {
					if randomZeroToOne() <= 0.003 {
						lighteningGrid[x][y] = "🌲"
					}
					// check if the cell is a tree
				} else if (cell == "🌲") {
					// get coordinates of neighborCells
					let neighborCoords = getNeighborPositions(x: x, y: y)
					
				// ~~~~~ iterate thru each neighbor ~~~~~ //
					for neighborCord in neighborCoords {
						let neighbor = grid[neighborCord.x][neighborCord.y]
						// ~~~~~~~~~ check for fire ~~~~~~~~ //
						if (neighbor == "🔥") {
							lighteningGrid[x][y] = "🔥"
							
							// if neighbor is a tree .01% chance of becomming fire
						} else if (neighbor == "🌲") {
							if randomZeroToOne() <= 0.001 {
								lighteningGrid[x][y] = "🔥"
							}
						}
					}
				} else if (cell == "🔥") {
					lighteningGrid[x][y] = nil
				}
				
			}
		}
		grid = lighteningGrid
	}
	
	func aTinyForest() {
		newGrid = grid
		
		for x in 0..<grid.count {
			for y in 0..<grid[x].count {
				let cell = grid[x][y]
				
				if (cell == nil) {
					if randomZeroToOne() < 0.01 {
						newGrid[x][y] = "🌲"
					}
				} else if (cell == "🌲") {
					// ~~~~~ check for fire ~~~~~~~~//
					let neighborCoords = getNeighborPositions(x: x, y: y)
					
					for neighborCord in neighborCoords {
						let neighbor = grid[neighborCord.x][neighborCord.y]
						if neighbor == "🔥" {
							newGrid[x][y] = "🔥"
						}
					}
				} else if (cell == "🔥") {
					newGrid[x][y] = nil
				}
			}
		}
		grid = newGrid
		
	}
	
	
	func isLegalPosition(x: Int, y: Int) -> Bool {
		if (x >= 0 && y >= 0) && (x < grid.count && y < grid[x].count){
			return true
		} else {
			return false
		}
	}
	
	func getNeighborPositions(x originX: Int, y originY: Int) -> [(x: Int, y: Int)] {
		var neighbors: [(x: Int, y: Int)] = []
		
		for x in (originX-1)...(originX+1) {
			for y in (originY-1)...(originY+1) {
				if isLegalPosition(x: x, y: y) {
					if !(x == originX && y == originY) {
						neighbors.append((x, y))
					}
				}
			}
		}
		return neighbors
	}
}














