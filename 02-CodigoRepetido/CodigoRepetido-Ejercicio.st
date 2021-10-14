!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'testingCustomerBook johnLennon paulMcCartney ringoStarr'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'private' stamp: 'SDM 10/13/2021 22:03:31'!
checkThatACostumerBookContainsOnlyJohnLennon: aCustomerBook

	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: 'John Lennon').! !

!CustomerBookTest methodsFor: 'private' stamp: 'SDM 10/13/2021 22:16:30'!
measureRunningTimeOfABlockOfCode: aBlockOfCode
	
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlockOfCode value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.

	^millisecondsAfterRunning - millisecondsBeforeRunning.! !

!CustomerBookTest methodsFor: 'private' stamp: 'SDM 10/14/2021 16:46:41'!
setUp

	testingCustomerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	paulMcCartney := 'Paul McCartney'.
	ringoStarr := 'Ringo Starr'.! !

!CustomerBookTest methodsFor: 'private' stamp: 'SDM 10/13/2021 22:03:31'!
tryInvalidAction: anAction on: aCustomer in: aCustomerBook
	
	[ aCustomerBook perform: anAction with: aCustomer.
	self fail ]
		on: CantSuspend
		do: [ :anError | self checkThatACostumerBookContainsOnlyJohnLennon: aCustomerBook ]	
		
		on: NotFound
		do: [ :anError | self checkThatACostumerBookContainsOnlyJohnLennon: aCustomerBook ]	
		
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: aCustomerBook isEmpty ]
! !

!CustomerBookTest methodsFor: 'private' stamp: 'SDM 10/13/2021 22:16:06'!
validateCurrentCustomerNumbers: aCustomerBook expectedTotalCustomers: n1 expectedActiveCustomers: n2 expectedSuspendedCustomers: n3

	| validation01 validation02 validation03 |
	
	validation01 := n2 = testingCustomerBook numberOfActiveCustomers.
	validation02 := n3 = testingCustomerBook  numberOfSuspendedCustomers.
	validation03 := n1 = testingCustomerBook  numberOfCustomers.
	
	^validation01 and: validation02 and: validation03. 
	
	! !


!CustomerBookTest methodsFor: 'tests' stamp: 'SDM 10/14/2021 16:46:59'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| aBlockOfCode |
	
	aBlockOfCode := [ testingCustomerBook addCustomerNamed: johnLennon ].
	
	self assert: (self measureRunningTimeOfABlockOfCode: aBlockOfCode) < (50 * millisecond).


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'SDM 10/14/2021 16:47:31'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| aBlockOfCode |
		
	testingCustomerBook addCustomerNamed: paulMcCartney.
	aBlockOfCode := [ testingCustomerBook removeCustomerNamed: paulMcCartney ].
	
	self assert: (self measureRunningTimeOfABlockOfCode: aBlockOfCode ) < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'SDM 10/13/2021 18:54:42'!
test03CanNotAddACustomerWithEmptyName 

	^self tryInvalidAction: #addCustomerNamed: on: '' in: testingCustomerBook.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'SDM 10/14/2021 16:48:05'!
test04CanNotRemoveAnInvalidCustomer
	
	testingCustomerBook addCustomerNamed: johnLennon.
	
	^self tryInvalidAction: #removeCustomerNamed: on: paulMcCartney in: testingCustomerBook.
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'SDM 10/14/2021 16:50:10'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	testingCustomerBook addCustomerNamed: paulMcCartney.
	testingCustomerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: (self validateCurrentCustomerNumbers: testingCustomerBook expectedTotalCustomers: 1  expectedActiveCustomers: 0  expectedSuspendedCustomers: 1).
	self assert: (testingCustomerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'SDM 10/14/2021 16:50:35'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	testingCustomerBook addCustomerNamed: paulMcCartney.
	testingCustomerBook suspendCustomerNamed: paulMcCartney.
	testingCustomerBook removeCustomerNamed: paulMcCartney.
	
	self assert: (self validateCurrentCustomerNumbers: testingCustomerBook expectedTotalCustomers: 0  expectedActiveCustomers: 0  expectedSuspendedCustomers: 0).
	self deny: (testingCustomerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'SDM 10/14/2021 16:49:25'!
test07CanNotSuspendAnInvalidCustomer

	testingCustomerBook addCustomerNamed: johnLennon.
	
	^self tryInvalidAction: #suspendCustomerNamed: on: ringoStarr in: testingCustomerBook.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'SDM 10/14/2021 16:49:40'!
test08CanNotSuspendAnAlreadySuspendedCustomer

	testingCustomerBook addCustomerNamed: johnLennon.
	testingCustomerBook suspendCustomerNamed: johnLennon.
	
	^self tryInvalidAction: #suspendCustomerNamed: on: johnLennon in: testingCustomerBook.! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'LL 10/30/2020 12:22:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'SDM 10/13/2021 19:39:38'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'SDM 10/13/2021 22:29:04'!
removeCustomerNamed: aName 
 
	(self removeCustomerNamed: aName fromACategory: active) ifTrue: [^aName]. 
	(self removeCustomerNamed: aName fromACategory: suspended) ifTrue: [^aName]. 
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'SDM 10/13/2021 22:25:34'!
removeCustomerNamed: aCustomer fromACategory: aCustomerBookCategory

	aCustomerBookCategory remove: aCustomer ifAbsent: [^false].
	^true.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
