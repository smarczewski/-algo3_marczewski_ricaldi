!classDefinition: #MarsRoverTest category: 'TDDMarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDMarsRover'!

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:48:38'!
test01TheMarsRoverStartsAtAnInitialPointInTheXYAxis
	
	self assert: marsRover currentPosition equals: 0@0! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:48:45'!
test02TheMarsRoverStartsPointingToACardinalPoint

	self assert: (marsRover currentDirection isNorth)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:48:48'!
test03IfTheRoverGoesForwardOnceItEndsUpOnePositionUp

	marsRover f.
	
	self assert: marsRover currentPosition equals: 0@1! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:48:54'!
test04IfTheRoverGoesBackwardsOnceItEndsUpOnePositionDown
	
	marsRover b.
	
	self assert: marsRover currentPosition equals: 0@-1! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:49:15'!
test05IfTheRoverRotatesToTheLeftOnceItEndsUpPointingWest

	marsRover l.
	
	self assert: (marsRover currentDirection isWest)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:49:18'!
test06IfTheRoverRotatesToTheRightOnceItEndsUpPointingEast

	marsRover r.
	
	self assert: (marsRover currentDirection isEast)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:49:22'!
test07IfTheRoverRotatesTwiceToTheLeftItEndsUpPointingSouth

	marsRover l.
	marsRover l.
		
	self assert: (marsRover currentDirection isSouth)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:49:26'!
test08IfTheRoverRotatesTwiceToTheRightItEndsUpPointingSouth

	marsRover r.
	marsRover r.
		
	self assert: (marsRover currentDirection isSouth)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:49:30'!
test09IfTheRoverRotatesOnceToTheLeftAndOnceBackToTheRightItEndsUpPointingNorthAgain

	marsRover l.
	marsRover r.
		
	self assert: (marsRover currentDirection isNorth)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:49:33'!
test10IfTheRoverRotatesOnceToTheRightAndOnceBackToTheLeftItEndsUpPointingNorthAgain

	marsRover r.
	marsRover l.
		
	self assert: (marsRover currentDirection isNorth)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:49:38'!
test11RotatingFullCircleToTheLeftLeftsTheRoverPointingNorth

	marsRover l.
	marsRover l.
	marsRover l.
	marsRover l.
					
	self assert: (marsRover currentDirection isNorth)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:49:42'!
test12RotatingFullCircleToTheRightLeftsTheRoverPointingNorth

	marsRover r.
	marsRover r.
	marsRover r.
	marsRover r.
					
	self assert: (marsRover currentDirection isNorth)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:49:46'!
test13IfTheRoverRotatesLeftAndThenGoesForwardsItEndsUpOnePositionFurtherWest

	marsRover l.
	marsRover f.
					
	self assert: marsRover currentPosition equals: -1@0! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:49:50'!
test14IfTheRoverRotatesRightAndThenGoesForwardsItEndsUpOnePositionFurtherEast
	
	marsRover r.
	marsRover f.
					
	self assert: marsRover currentPosition equals: 1@0! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:49:53'!
test15IfTheRoverRotatesRightTwiceAndThenGoesForwardsItEndsUpOnePositionFurtherSouth

	marsRover r.
	marsRover r.
	marsRover f.
					
	self assert: marsRover currentPosition equals: 0@-1! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:49:56'!
test16IfTheRoverRotatesLeftAndThenGoesBackwardsItEndsUpOnePositionFurtherEast

	marsRover l.
	marsRover b.
					
	self assert: marsRover currentPosition equals: 1@0! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:51:33'!
test17TheRoverIsAbleToReceiveAndHoldAnEmptyStringOfCommands

	| stringOfCommands |
	stringOfCommands := ''.
	
	marsRover receiveCommands: stringOfCommands.
					
	self assert: marsRover currentCommands equals: stringOfCommands! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:50:06'!
test18TheRoverIsAbleToReceiveASingleCommandAsStringAndExecuteIt

	| aSingleCommand |
	aSingleCommand := 'f'.
	
	marsRover receiveCommands: aSingleCommand.
					
	self assert: marsRover currentPosition equals: 0@1! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:50:10'!
test19TheRoverIsAbleToReceiveMultipleCommandsAsStringAndExecuteThem

	| stringOfCommands |
	stringOfCommands := 'bffllffr'.
	
	marsRover receiveCommands: stringOfCommands.
					
	self assert: marsRover currentPosition equals: 0@-1.
	self assert: (marsRover currentDirection isWest)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:50:14'!
test20TheRoverIsAbleToReceiveAndExecuteMultipleConsecutiveStringsOfCommands

	| stringOfCommands1 stringOfCommands2 |
	stringOfCommands1 := 'bffllffr'.
	stringOfCommands2 := 'frlllffbf'.
		
	marsRover receiveCommands: stringOfCommands1.
	
	marsRover receiveCommands: stringOfCommands2.
					
	self assert: marsRover currentPosition equals: 1@-1.
	self assert: (marsRover currentDirection isEast)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:50:20'!
test21TheRoverReturnsAnErrorMessageWhenTheCommandIsNotRecognized

	| stringOfCommands1 stringOfCommands2 |
	stringOfCommands1 := 'bffllffr'.
	stringOfCommands2 := 'frlllffbf'.
		
	marsRover receiveCommands: stringOfCommands1.
	
	marsRover receiveCommands: stringOfCommands2.
					
	self assert: marsRover currentPosition equals: 1@-1.
	self assert: (marsRover currentDirection isEast)! !

!MarsRoverTest methodsFor: 'testing' stamp: 'SDM 11/18/2021 18:50:24'!
test22TheRoverExecutesAStringOfCommandsUntilFindingAnInvalidOne
	
	| stringOfCommands |
	stringOfCommands := 'bffllffrkfrlllffbf'.
	
	marsRover receiveCommands: stringOfCommands.
					
	self assert: marsRover currentPosition equals: 0@-1.
	self assert: (marsRover currentDirection isWest)! !


!MarsRoverTest methodsFor: 'setup' stamp: 'SDM 11/18/2021 12:59:36'!
setUp

	marsRover := MarsRover new! !


!classDefinition: #MarsRover category: 'TDDMarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction commands commandsIndex validCommands'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDMarsRover'!

!MarsRover methodsFor: 'accessing' stamp: 'SDM 11/18/2021 11:14:53'!
currentCommands
	
	^commands! !

!MarsRover methodsFor: 'accessing' stamp: 'SDM 11/18/2021 11:15:41'!
currentDirection
	
	^direction! !

!MarsRover methodsFor: 'accessing' stamp: 'SDM 11/18/2021 11:15:59'!
currentPosition
	
	^position! !

!MarsRover methodsFor: 'accessing' stamp: 'SDM 11/18/2021 12:45:57'!
nextCommandToBeExecuted

	| aCommandToBePotentiallyExecuted |
	aCommandToBePotentiallyExecuted := (commands at: commandsIndex) asSymbol.
	
	^aCommandToBePotentiallyExecuted! !

!MarsRover methodsFor: 'accessing' stamp: 'SDM 11/18/2021 11:49:35'!
numberOfCommands
	
	^(commands size)! !


!MarsRover methodsFor: 'initialization' stamp: 'SDM 11/18/2021 18:46:00'!
initialize	

	position := 0@0.	
	direction := PointingNorth new.
	commandsIndex := 1.
	validCommands := {#f. #b. #l. #r.}
! !


!MarsRover methodsFor: 'commands' stamp: 'SDM 11/17/2021 17:29:40'!
b

	| pointToBeSubstracted |
	pointToBeSubstracted := direction correspondingDistance.
	
	position := position - pointToBeSubstracted! !

!MarsRover methodsFor: 'commands' stamp: 'SDM 11/18/2021 12:18:52'!
executeAllTheCommands

	self numberOfCommands timesRepeat: [self executeCurrentCommandInLine].
	self resetCommands.! !

!MarsRover methodsFor: 'commands' stamp: 'SDM 11/18/2021 12:48:27'!
executeCurrentCommandInLine

	| commandToBeExecuted |
	commandToBeExecuted := self nextCommandToBeExecuted.
	
	(self isValidCommand: commandToBeExecuted) 
		ifTrue: [	commandsIndex := commandsIndex + 1.
				commandToBeExecuted sendTo: self]! !

!MarsRover methodsFor: 'commands' stamp: 'SDM 11/17/2021 17:29:45'!
f

	| pointToBeAdded |
	pointToBeAdded := direction correspondingDistance.
		
	position := position + pointToBeAdded! !

!MarsRover methodsFor: 'commands' stamp: 'SDM 11/18/2021 12:37:06'!
isValidCommand: aCommandToBePotentiallyExecuted
	
	^(validCommands includes: aCommandToBePotentiallyExecuted)! !

!MarsRover methodsFor: 'commands' stamp: 'SDM 11/17/2021 17:29:48'!
l

	| newDirection |
	newDirection := direction l.
	
	direction := newDirection! !

!MarsRover methodsFor: 'commands' stamp: 'SDM 11/17/2021 17:29:54'!
r

	| newDirection |
	newDirection := direction r.
	
	direction := newDirection! !

!MarsRover methodsFor: 'commands' stamp: 'SDM 11/18/2021 18:47:10'!
receiveCommands: aStringOfCommands
	
	commands := aStringOfCommands.
	self executeAllTheCommands.! !

!MarsRover methodsFor: 'commands' stamp: 'SDM 11/18/2021 12:19:14'!
resetCommands
	
	commands :=  ''.
	commandsIndex := 1.! !


!classDefinition: #NavigationSystem category: 'TDDMarsRover'!
Object subclass: #NavigationSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDMarsRover'!

!NavigationSystem methodsFor: 'adjacent points' stamp: 'SDM 11/17/2021 17:30:08'!
l

	self subclassResponsibility! !

!NavigationSystem methodsFor: 'adjacent points' stamp: 'SDM 11/17/2021 17:30:13'!
r

	self subclassResponsibility! !


!NavigationSystem methodsFor: 'accessing' stamp: 'SDM 11/17/2021 17:30:03'!
correspondingDistance

	self subclassResponsibility! !


!NavigationSystem methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:37:35'!
isEast

	self subclassResponsibility! !

!NavigationSystem methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:37:19'!
isNorth

	self subclassResponsibility! !

!NavigationSystem methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:37:29'!
isSouth

	self subclassResponsibility! !

!NavigationSystem methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:37:38'!
isWest

	self subclassResponsibility! !


!classDefinition: #PointingEast category: 'TDDMarsRover'!
NavigationSystem subclass: #PointingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDMarsRover'!

!PointingEast methodsFor: 'accessing' stamp: 'SDM 11/17/2021 17:16:55'!
correspondingDistance

	^(1@0)
	! !


!PointingEast methodsFor: 'adjacent points' stamp: 'SDM 11/18/2021 18:46:00'!
l

	^PointingNorth new! !

!PointingEast methodsFor: 'adjacent points' stamp: 'SDM 11/18/2021 18:46:09'!
r

	^PointingSouth new! !


!PointingEast methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:38:57'!
isEast

	^true! !

!PointingEast methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:39:24'!
isNorth

	^false! !

!PointingEast methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:39:18'!
isSouth

	^false! !

!PointingEast methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:39:11'!
isWest

	^false! !


!classDefinition: #PointingNorth category: 'TDDMarsRover'!
NavigationSystem subclass: #PointingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDMarsRover'!

!PointingNorth methodsFor: 'accessing' stamp: 'SDM 11/17/2021 17:16:55'!
correspondingDistance

	^(0@1)! !


!PointingNorth methodsFor: 'adjacent points' stamp: 'SDM 11/18/2021 18:46:19'!
l

	^PointingWest new! !

!PointingNorth methodsFor: 'adjacent points' stamp: 'SDM 11/18/2021 18:45:44'!
r

	^PointingEast new! !


!PointingNorth methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:40:09'!
isEast
	
	^false! !

!PointingNorth methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:39:56'!
isNorth
	
	^true! !

!PointingNorth methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:40:05'!
isSouth
	
	^false! !

!PointingNorth methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:40:12'!
isWest
	
	^false! !


!classDefinition: #PointingSouth category: 'TDDMarsRover'!
NavigationSystem subclass: #PointingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDMarsRover'!

!PointingSouth methodsFor: 'accessing' stamp: 'SDM 11/17/2021 17:16:55'!
correspondingDistance

	^(0@-1)! !


!PointingSouth methodsFor: 'adjacent points' stamp: 'SDM 11/18/2021 18:45:44'!
l

	^PointingEast new! !

!PointingSouth methodsFor: 'adjacent points' stamp: 'SDM 11/18/2021 18:46:19'!
r

	^PointingWest new! !


!PointingSouth methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:40:47'!
isEast

	^false! !

!PointingSouth methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:40:43'!
isNorth

	^false! !

!PointingSouth methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:40:33'!
isSouth

	^true! !

!PointingSouth methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:40:49'!
isWest

	^false! !


!classDefinition: #PointingWest category: 'TDDMarsRover'!
NavigationSystem subclass: #PointingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDMarsRover'!

!PointingWest methodsFor: 'accessing' stamp: 'SDM 11/17/2021 17:16:55'!
correspondingDistance

	^(-1@0)! !


!PointingWest methodsFor: 'adjacent points' stamp: 'SDM 11/18/2021 18:46:09'!
l

	^PointingSouth new! !

!PointingWest methodsFor: 'adjacent points' stamp: 'SDM 11/18/2021 18:46:00'!
r

	^PointingNorth new! !


!PointingWest methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:41:11'!
isEast

	^false! !

!PointingWest methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:41:17'!
isNorth

	^false! !

!PointingWest methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:41:14'!
isSouth

	^false! !

!PointingWest methodsFor: 'evaluating' stamp: 'SDM 11/18/2021 10:41:04'!
isWest

	^true! !
