!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'aFinder aStack aPrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'SDM 11/4/2021 15:09:37'!
setUp

	aStack := OOStack new.
	aFinder := SentenceFinderByPrefix with: aStack.! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SDM 11/4/2021 14:36:18'!
test01CantFindSentencesInAnEmptyStack

	| aPrefix1 aPrefix2 aPrefix3 |
	
	aPrefix1 := 'a'.
	aPrefix2 := 'b'.
	aPrefix3 := 'c'.
	
	self assert: 0 equals: (aFinder find: aPrefix1) size.
	self assert: 0 equals: (aFinder find: aPrefix2) size.
	self assert: 0 equals: (aFinder find: aPrefix3) size.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SDM 11/4/2021 15:13:05'!
test02CanFindOnlyOneSentence

	| sentence aPrefix1 aPrefix2 aPrefix3 |
	
	sentence := 'hola'.
	aPrefix1 := 'ho'.
	aPrefix2 := 'la'.
	aPrefix3 := 'abc'.
	
	aStack push: sentence.
	
	self assert: 1 equals: (aFinder find: aPrefix1) size.
	self assert: 0 equals: (aFinder find: aPrefix2) size.
	self assert: 0 equals: (aFinder find: aPrefix3) size.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SDM 11/4/2021 15:12:58'!
test03CanFindTwoSentences

	| sentence aPrefix1 aPrefix2 aPrefix3 |
	
	sentence := 'hola como estas'.
	aPrefix1 := 'hola'.
	aPrefix2 := 'ho'.
	aPrefix3 := 'holacomo'.
	
	aStack push: sentence.
	
	self assert: 1 equals: (aFinder find: aPrefix1) size.
	self assert: 1 equals: (aFinder find: aPrefix2) size.
	self assert: 0 equals: (aFinder find: aPrefix3) size.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SDM 11/4/2021 15:12:51'!
test04StackRemainsUnchangedAfterSearching

	| sentence1 sentence2 sentence3 aPrefix1 |
	
	sentence1 := 'Hola como estas'.
	sentence2 := 'Buen dia. Hola'.
	sentence3 := 'Algoritmos y programacion 3'.
	
	aPrefix1 := 'Hola'.

	aStack push: sentence1.
	aStack push: sentence2.
	aStack push: sentence3.
	aFinder find: aPrefix1.
	
	self assert: 3 equals: aStack size.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SDM 11/4/2021 15:13:15'!
test05SearchingIsCaseSensitive

	| sentence aPrefix1 aPrefix2 aPrefix3 |
	
	sentence := 'juan Pepito Lucas'.
	aPrefix1 := 'Juan'.
	aPrefix2 := 'juan'.
	aPrefix3 := 'JUAN'.
	
	aStack push: sentence.
	
	self assert: 0 equals: (aFinder find: aPrefix1) size.
	self assert: 1 equals: (aFinder find: aPrefix2) size.
	self assert: 0 equals: (aFinder find: aPrefix3) size.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SDM 11/4/2021 14:42:52'!
test06CanNotSearchPrefixThatContainsEmptySpaces

	| sentence aPrefix1 |
	
	aPrefix1 := 'hola como'.
	sentence := 'hola como estas'.
	aStack push: sentence.
	
	self
		should: [aFinder find: aPrefix1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix chosenPrefixIncludesEmptySpacesErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SDM 11/4/2021 14:49:08'!
test07CanNotSearchEmptyPrefix

	| sentence aPrefix1 |
	
	aPrefix1 := ''.
	sentence := 'hola como estas'.
	aStack push: sentence.
	
	self
		should: [aFinder find: aPrefix1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix chosenPrefixIsEmptyErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SDM 11/4/2021 15:08:30'!
test08WintExampleTestWorksAsExpected

	| sentence1 sentence2 sentence3 sentence4 aPrefix1 foundSentences |
	
	sentence1 := 'winter is coming'.
	sentence2 := 'winning is everything'.
	sentence3 := 'The winds of Winter'.
	sentence4 := 'Winter is here'.
	aPrefix1 := 'Wint'.
	
	aStack push: sentence1.
	aStack push: sentence2.
	aStack push: sentence3.
	aStack push: sentence4.
	
	foundSentences := (aFinder find: aPrefix1).
	
	self assert: sentence4 equals: (foundSentences at: 1).! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'state' stamp: 'SDM 11/4/2021 13:39:59'!
isEmpty

	^stack isEmpty ! !

!OOStack methodsFor: 'state' stamp: 'SDM 11/4/2021 13:40:10'!
size

	^stack size! !


!OOStack methodsFor: 'initialization' stamp: 'Br 11/4/2021 17:12:59'!
initialize

	stack := OOStackEmpty new.! !


!OOStack methodsFor: 'adding' stamp: 'SDM 11/4/2021 13:40:25'!
push: anElement

	stack := stack push: anElement ! !


!OOStack methodsFor: 'accessing' stamp: 'SDM 11/4/2021 15:14:35'!
top

	^stack top! !


!OOStack methodsFor: 'removing' stamp: 'SDM 11/4/2021 15:05:20'!
pop

	|element|
	
	element := stack top.
	stack := stack pop.
	
	^element! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackStates category: 'Stack-Exercise'!
Object subclass: #OOStackStates
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStates methodsFor: 'state' stamp: 'SDM 11/4/2021 13:40:57'!
isEmpty

	self subclassResponsibility ! !

!OOStackStates methodsFor: 'state' stamp: 'SDM 11/4/2021 13:41:01'!
size

	self subclassResponsibility ! !


!OOStackStates methodsFor: 'initialization' stamp: 'SDM 11/4/2021 13:40:49'!
initialize

	elements := OrderedCollection new.! !


!OOStackStates methodsFor: 'adding' stamp: 'SDM 11/4/2021 13:41:18'!
push: anElement

	self subclassResponsibility ! !


!OOStackStates methodsFor: 'accessing' stamp: 'SDM 11/4/2021 13:41:35'!
top

	self subclassResponsibility! !


!OOStackStates methodsFor: 'removing' stamp: 'SDM 11/4/2021 13:41:13'!
pop

	self subclassResponsibility ! !


!classDefinition: #OOStackEmpty category: 'Stack-Exercise'!
OOStackStates subclass: #OOStackEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmpty methodsFor: 'state' stamp: 'SDM 11/4/2021 13:41:44'!
isEmpty

	^true! !

!OOStackEmpty methodsFor: 'state' stamp: 'SDM 11/4/2021 13:41:55'!
size

	^0! !


!OOStackEmpty methodsFor: 'adding' stamp: 'SDM 11/4/2021 13:42:15'!
push: anElement

	|stack|
	
	stack := OOStackWithElements new.
	stack push: anElement.
	
	^stack! !


!OOStackEmpty methodsFor: 'accessing' stamp: 'SDM 11/4/2021 13:42:21'!
top

	self error: OOStack stackEmptyErrorDescription! !


!OOStackEmpty methodsFor: 'removing' stamp: 'SDM 11/4/2021 13:42:27'!
pop

	self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #OOStackWithElements category: 'Stack-Exercise'!
OOStackStates subclass: #OOStackWithElements
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackWithElements methodsFor: 'state' stamp: 'SDM 11/4/2021 13:42:43'!
isEmpty

	^false! !

!OOStackWithElements methodsFor: 'state' stamp: 'SDM 11/4/2021 13:42:50'!
size

	^elements size! !


!OOStackWithElements methodsFor: 'adding' stamp: 'SDM 11/4/2021 13:42:57'!
push: anElement

	elements add: anElement.
	^self! !


!OOStackWithElements methodsFor: 'accessing' stamp: 'SDM 11/4/2021 13:44:28'!
top

	^elements at: self size! !


!OOStackWithElements methodsFor: 'removing' stamp: 'SDM 11/4/2021 15:07:56'!
pop

	|stack|
	
	elements removeAt: self size.
	stack := OOStackEmpty new.
	elements do: [:e| 
		stack := stack push: e].
	
	^stack! !


!classDefinition: #Prefix category: 'Stack-Exercise'!
Object subclass: #Prefix
	instanceVariableNames: 'prefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Prefix methodsFor: 'initialization' stamp: 'SDM 11/4/2021 18:36:28'!
initalizeWith: aString

	self subclassResponsibility ! !


!Prefix methodsFor: 'comparing' stamp: 'SDM 11/4/2021 18:37:42'!
isContainedIn: aString

	^aString beginsWith: prefix! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Prefix class' category: 'Stack-Exercise'!
Prefix class
	instanceVariableNames: ''!

!Prefix class methodsFor: 'as yet unclassified' stamp: 'Br 11/4/2021 18:07:13'!
canInstantianteWith: aString
	self subclassResponsibility! !

!Prefix class methodsFor: 'as yet unclassified' stamp: 'Br 11/4/2021 18:12:13'!
with: aString
	Prefix  subclasses do: [:subclass | (subclass canInstantianteWith: aString) ifTrue:[^subclass new
			initalizeWith: aString ]] ! !


!classDefinition: #PrefixEmpty category: 'Stack-Exercise'!
Prefix subclass: #PrefixEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixEmpty methodsFor: 'initialization' stamp: 'SDM 11/4/2021 18:39:16'!
initalizeWith: aString

	self error: SentenceFinderByPrefix chosenPrefixIsEmptyErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrefixEmpty class' category: 'Stack-Exercise'!
PrefixEmpty class
	instanceVariableNames: ''!

!PrefixEmpty class methodsFor: 'as yet unclassified' stamp: 'Br 11/4/2021 18:02:51'!
canInstantianteWith: aString
	^ aString sameAs: ''.! !


!classDefinition: #PrefixSpace category: 'Stack-Exercise'!
Prefix subclass: #PrefixSpace
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixSpace methodsFor: 'initialization' stamp: 'SDM 11/4/2021 18:39:36'!
initalizeWith: aString

	self error: SentenceFinderByPrefix chosenPrefixIncludesEmptySpacesErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrefixSpace class' category: 'Stack-Exercise'!
PrefixSpace class
	instanceVariableNames: ''!

!PrefixSpace class methodsFor: 'as yet unclassified' stamp: 'Br 11/4/2021 18:02:33'!
canInstantianteWith: aString
	^ aString includesSubString: ' '.! !


!classDefinition: #PrefixValid category: 'Stack-Exercise'!
Prefix subclass: #PrefixValid
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixValid methodsFor: 'initialization' stamp: 'SDM 11/4/2021 18:39:48'!
initalizeWith: aString

	prefix := aString ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrefixValid class' category: 'Stack-Exercise'!
PrefixValid class
	instanceVariableNames: ''!

!PrefixValid class methodsFor: 'as yet unclassified' stamp: 'Br 11/4/2021 18:04:45'!
canInstantianteWith: aString
	^ (PrefixEmpty canInstantianteWith: aString ) not and: (PrefixSpace canInstantianteWith: aString) not.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'SDM 11/4/2021 14:27:29'!
initializeStack: aStack

	stack := aStack! !


!SentenceFinderByPrefix methodsFor: 'finder' stamp: 'SDM 11/4/2021 18:43:20'!
find: aString

	| wantedSentences auxStack prefix |
	wantedSentences := OrderedCollection new.	
	auxStack :=OOStack new.
	
	prefix := Prefix with: aString.
	
	self reverseStack: stack to: auxStack withCondition: [:aSentence| prefix isContainedIn: aSentence ] AndPerformOperation: [:aSentence| wantedSentences add: aSentence].
	
	self reverseStack: auxStack to: stack withCondition: [:aSentence| false] AndPerformOperation: [:aSentence| false].

	^wantedSentences! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'SDM 11/4/2021 18:42:44'!
reverseStack: aStack to: anAuxStack withCondition: aCondition AndPerformOperation: anOperation

	| aSentence |
	
	1 to: aStack size do: [:x | 
		aSentence := aStack pop.
		(aCondition value: aSentence) ifTrue: [anOperation value: aSentence] .
		anAuxStack push: aSentence.
		].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'SDM 11/4/2021 14:26:29'!
chosenPrefixIncludesEmptySpacesErrorDescription
	
	^ 'The chosen prefix is, or contains empty spaces'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'SDM 11/4/2021 14:43:59'!
chosenPrefixIsEmptyErrorDescription
	
	^ 'The chosen prefix is empty'! !


!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'Br 11/4/2021 08:59:34'!
with: aStack
	^SentenceFinderByPrefix new initializeStack: aStack.! !
