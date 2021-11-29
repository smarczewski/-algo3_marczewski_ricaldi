!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'account anotherAccount portfolio anotherPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:17'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:17'!
test02DepositIncreasesBalanceOnTransactionValue 

	OneWayDeposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:17'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	OneWayDeposit register: 100 * peso on: account.
	OneWayWithdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:17'!
test04WithdrawValueMustBePositive 

	| withdrawValue |
	
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (OneWayWithdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:17'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| deposit withdraw |
	
	deposit := OneWayDeposit register: 100 * peso on: account.
	withdraw := OneWayWithdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:17'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw |
	
	deposit :=  OneWayDeposit for: 100 * peso.
	withdraw := OneWayWithdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:17'!
test07AccountKnowsItsTransactions 

	| deposit |

	deposit := OneWayDeposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:43'!
test08EmptyPortfolioHasZeroBalance 
	
	self assert: (0 * peso) equals: portfolio balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:43'!
test09PortfolioWithASingleAccountHasTheSameBalanceAsTheAccount 

	portfolio add: account.
	
	OneWayDeposit register: 100 * peso on: account.
	
	self assert: (100 * peso) equals: portfolio balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:43'!
test10PortfolioKnowsIfItsContainedAccountsHaveRegisteredATransaction

	| deposit withdraw |
	
	portfolio add: account.
	deposit := OneWayDeposit register: 100 * peso on: account.
	withdraw := OneWayWithdraw register: 50 * peso on: account.
		
	self assert: (portfolio hasRegistered: deposit).
	self assert: (portfolio hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:43'!
test11PortfolioKnowsAllTheTransactionsRegisteredByTheirAccounts

	| deposit withdraw |
	
	portfolio add: account.
	portfolio add: anotherAccount.
		
	deposit := OneWayDeposit register: 50 * peso on: account.
	withdraw := OneWayWithdraw register: 100 * peso on: anotherAccount .		
	
	self assert: 2 equals: portfolio transactions size.
	self assert: (portfolio transactions includes: deposit).
	self assert: (portfolio transactions includes: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:43'!
test12PortfolioThatContainsASinglePortfolioHasTheSameBalanceAsIt

	portfolio add: account.
	portfolio add: anotherAccount.
		
	OneWayDeposit register: 50 * peso on: account.
	
	anotherPortfolio add: portfolio.
	
	self assert: (50 * peso) equals: anotherPortfolio balance.
	
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:43'!
test13PortfolioThatContainsAPortfolioKnowsIfMultipleTransactionHaveBeenRegistered

	| deposit withdraw |
	
	portfolio add: account.
	
	deposit := OneWayDeposit register: 100 * peso on: account.
	withdraw := OneWayWithdraw register: 50 * peso on: account.
	
	anotherPortfolio add: portfolio.
		
	self assert: (anotherPortfolio hasRegistered: deposit).
	self assert: (anotherPortfolio hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:43'!
test14PortfolioThatContainsAPortfolioAndAnAccountKnowsIfMultipleTransactionHaveBeenRegistered

	| deposit withdraw anotherDeposit anotherWithdraw |
	
	portfolio add: account.
	
	deposit := OneWayDeposit register: 100 * peso on: account.
	withdraw := OneWayWithdraw register: 50 * peso on: account.
	
	anotherDeposit := OneWayDeposit register: 100 * peso on: anotherAccount.
	anotherWithdraw := OneWayWithdraw register: 100 * peso on: anotherAccount.	
	
	anotherPortfolio add: portfolio.
	anotherPortfolio add: anotherAccount.
		
	self assert: (anotherPortfolio hasRegistered: deposit).
	self assert: (anotherPortfolio hasRegistered: withdraw).
	self assert: (anotherPortfolio hasRegistered: anotherDeposit).
	self assert: (anotherPortfolio hasRegistered: anotherWithdraw).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:43'!
test15PortfolioThatContainsAPortfolioKnowsAllTheCombinedTransactions

	| deposit withdraw |
	
	portfolio add: account.
	portfolio add: anotherAccount.
		
	deposit := OneWayDeposit register: 50 * peso on: account.
	withdraw := OneWayWithdraw register: 100 * peso on: account.		
	
	anotherPortfolio add: portfolio.
	
	self assert: 2 equals: anotherPortfolio transactions size.
	self assert: (anotherPortfolio transactions includes: deposit).
	self assert: (anotherPortfolio transactions includes: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:43'!
test16PortfolioCannotContainItself
	
	self
		should: [ portfolio add: portfolio ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio portfolioCannotContainItselfErrorDescription]! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:43'!
test17PortfolioCannotContainDuplicateAccounts

	portfolio add: account.
	
	self
		should: [ portfolio add: account ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio portfolioCannotContainDuplicateAccountsErrorDescription]
		
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:43'!
test18PortfolioCannotAddAnAccountThatAlreadyHasBeenAddedToAContainedPortfolio

	portfolio add: account.
	anotherPortfolio add: portfolio.	
	
	self
		should: [ anotherPortfolio add: account ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio portfolioCannotContainDuplicateAccountsErrorDescription]
		
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:43'!
test19APortfolioThatHasBeenAddedToAnotherOneKnowsItsParentPortfolio

	anotherPortfolio add: portfolio.	
	
	self assert: (portfolio isSonOf: anotherPortfolio)
		
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:43'!
test20CannotAddAnAccountToAPortfolioIfItHasAlreadyBeenAddedToItsParentPortfolio

	anotherPortfolio add: portfolio.	
	anotherPortfolio add: account.
	
	self
		should: [ portfolio add: account ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio portfolioCannotContainDuplicateAccountsErrorDescription]
	
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'SDM 11/29/2021 18:55:43'!
test21CannotAddAPortfolioToAnotherPortfolioIfBothContainTheSameAccount
	
	portfolio add: account.
	anotherPortfolio add: account.	
	
	self
		should: [ portfolio add: anotherPortfolio ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio portfolioCannotContainDuplicateAccountsErrorDescription]
	
	! !


!ReceptiveAccountTest methodsFor: 'setup' stamp: 'SDM 11/29/2021 18:55:43'!
setUp
	
	account := SingleAccount new.
	anotherAccount := SingleAccount new.
	
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'SDM 11/28/2021 19:34:27'!
test01MakingATransferAffectsTheBalanceOfTheTwoAccountsInvolved

	| originAccount destinationAccount |
	originAccount := SingleAccount new.
	destinationAccount := SingleAccount new.
	
	Transfer from: originAccount to: destinationAccount for: (100 * peso).
	
	self assert: (-100 * peso) equals: originAccount balance.
	self assert: (100 * peso) equals: destinationAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'SDM 11/28/2021 19:34:31'!
test02ATransferKnowsItsOwnValue

	| originAccount destinationAccount transfer |
	originAccount := SingleAccount new.
	destinationAccount := SingleAccount new.
	
	transfer := Transfer from: originAccount to: destinationAccount for: (100 * peso).
	
	self assert: (100 * peso) equals: transfer value.! !

!TransferTest methodsFor: 'tests' stamp: 'SDM 11/28/2021 19:34:35'!
test03ATransferLegKnowsItsCounterpart

	| originAccount destinationAccount transfer originLeg destinationLeg |
	originAccount := SingleAccount new.
	destinationAccount := SingleAccount new.
	
	transfer := Transfer from: originAccount to: destinationAccount for: (100 * peso).
	
	originLeg := transfer withdrawLeg.
	destinationLeg := transfer depositLeg.
	
	self assert: originLeg equals: destinationLeg counterpart.
	self assert: destinationLeg equals: originLeg counterpart.! !

!TransferTest methodsFor: 'tests' stamp: 'SDM 11/28/2021 19:34:39'!
test04ATransferValueCannotBeZeroOrNegative

	| originAccount destinationAccount |
	originAccount := SingleAccount new.
	destinationAccount := SingleAccount new.
	
	self
		should: [ Transfer from: originAccount to: destinationAccount for: (0 * peso) ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Transfer invalidTransferValueErrorDescription ]
		! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'SDM 11/28/2021 00:26:16'!
changeInBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'SDM 11/28/2021 00:15:23'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #OneWayDeposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #OneWayDeposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!OneWayDeposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!OneWayDeposit methodsFor: 'value' stamp: 'SDM 11/28/2021 00:26:23'!
changeInBalance

	^ value! !

!OneWayDeposit methodsFor: 'value' stamp: 'SDM 11/28/2021 00:15:23'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OneWayDeposit class' category: 'ServiciosFinancieros-Ejercicio'!
OneWayDeposit class
	instanceVariableNames: ''!

!OneWayDeposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #OneWayWithdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #OneWayWithdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!OneWayWithdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!OneWayWithdraw methodsFor: 'value' stamp: 'SDM 11/28/2021 00:26:32'!
changeInBalance

	^ value negated! !

!OneWayWithdraw methodsFor: 'value' stamp: 'SDM 11/28/2021 00:15:23'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OneWayWithdraw class' category: 'ServiciosFinancieros-Ejercicio'!
OneWayWithdraw class
	instanceVariableNames: ''!

!OneWayWithdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferDeposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'value transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDeposit methodsFor: 'initialization' stamp: 'SDM 11/28/2021 14:54:29'!
initializeFor: aValue asPartOf: aTransfer

	value := aValue.
	transfer  := aTransfer! !


!TransferDeposit methodsFor: 'value' stamp: 'SDM 11/28/2021 14:34:50'!
changeInBalance

	^ value! !

!TransferDeposit methodsFor: 'value' stamp: 'SDM 11/28/2021 14:56:42'!
counterpart

	^transfer withdrawLeg! !

!TransferDeposit methodsFor: 'value' stamp: 'SDM 11/28/2021 14:34:50'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'ServiciosFinancieros-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'SDM 11/28/2021 14:53:39'!
for: aValue asPartOf: aTransfer

	^ self new initializeFor: aValue asPartOf: aTransfer! !

!TransferDeposit class methodsFor: 'instance creation' stamp: 'SDM 11/28/2021 14:55:58'!
register: aValue on: account asPartOf: aTransfer

	| transaction |
	
	transaction := self for: aValue asPartOf: aTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'value transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdraw methodsFor: 'initialization' stamp: 'SDM 11/28/2021 14:54:39'!
initializeFor: aValue asPartOf: aTransfer

	value := aValue.
	transfer  := aTransfer! !


!TransferWithdraw methodsFor: 'value' stamp: 'SDM 11/28/2021 14:34:40'!
changeInBalance

	^ value negated! !

!TransferWithdraw methodsFor: 'value' stamp: 'SDM 11/28/2021 14:56:55'!
counterpart

	^transfer depositLeg! !

!TransferWithdraw methodsFor: 'value' stamp: 'SDM 11/28/2021 14:34:40'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'ServiciosFinancieros-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'SDM 11/28/2021 14:55:00'!
for: aValue asPartOf: aTransfer

	^ self new initializeFor: aValue asPartOf: aTransfer! !

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'SDM 11/28/2021 14:55:49'!
register: aValue on: account asPartOf: aTransfer

	| transaction |
	
	transaction := self for: aValue asPartOf: aTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'SDM 11/28/2021 19:29:09'!
initialize

	self subclassResponsibility.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'SDM 11/28/2021 22:50:34'!
addParent: aParentPortfolio

	parents add: aParentPortfolio ! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'SDM 11/28/2021 19:28:35'!
balance

	self subclassResponsibility.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'SDM 11/28/2021 22:25:26'!
contains: anAccountOrPortfolio

	self subclassResponsibility.
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'SDM 11/28/2021 19:28:42'!
hasRegistered: aTransaction

	self subclassResponsibility.
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'SDM 11/28/2021 19:28:55'!
transactions 

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
ReceptiveAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'SDM 11/28/2021 22:46:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.	! !


!Portfolio methodsFor: 'private' stamp: 'SDM 11/28/2021 22:59:18'!
anyParentContains: anAccountOrPortfolio

	^parents anySatisfy: [:aParentAccount | aParentAccount contains: anAccountOrPortfolio ]
! !

!Portfolio methodsFor: 'private' stamp: 'SDM 11/28/2021 22:28:21'!
contains: anAccountOrPortfolio

	accounts do: [:anAccount | (anAccount == anAccountOrPortfolio) ifTrue: [^true].
				(anAccount contains: anAccountOrPortfolio) ifTrue: [^true]].
				^false.
! !


!Portfolio methodsFor: 'main protocol' stamp: 'SDM 11/29/2021 18:34:28'!
add: anAccountOrAPortfolio

	(anAccountOrAPortfolio == self) ifTrue: [self error: Portfolio portfolioCannotContainItselfErrorDescription].
	(self contains: anAccountOrAPortfolio) ifTrue: [self error: Portfolio portfolioCannotContainDuplicateAccountsErrorDescription].
	(self anyParentContains: anAccountOrAPortfolio) ifTrue: [self error: Portfolio portfolioCannotContainDuplicateAccountsErrorDescription].
	(self anySonContains: anAccountOrAPortfolio) ifTrue: [self error: Portfolio portfolioCannotContainDuplicateAccountsErrorDescription].

	anAccountOrAPortfolio addParent: self.
	accounts add: anAccountOrAPortfolio 
! !

!Portfolio methodsFor: 'main protocol' stamp: 'SDM 11/29/2021 18:35:08'!
anySonContains: anAccountOrPortfolio

	accounts do: [:anAccount | (anAccount == anAccountOrPortfolio) ifTrue: [^true].
			(anAccount contains: anAccountOrPortfolio) ifTrue: [^true].
			(anAccountOrPortfolio anySonContains: anAccount) ifTrue: [^true]].
			^false.
! !

!Portfolio methodsFor: 'main protocol' stamp: 'SDM 11/28/2021 19:37:24'!
balance

	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'SDM 11/28/2021 19:54:39'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]
! !

!Portfolio methodsFor: 'main protocol' stamp: 'SDM 11/28/2021 22:46:02'!
isSonOf: aPortfolio

	^parents includes: aPortfolio
! !

!Portfolio methodsFor: 'main protocol' stamp: 'SDM 11/28/2021 22:45:10'!
parent

	^parents! !

!Portfolio methodsFor: 'main protocol' stamp: 'SDM 11/28/2021 20:13:15'!
transactions 

	| combinedTransactions |
	combinedTransactions := OrderedCollection new.
	
	accounts do: [ :anAccount | combinedTransactions addAll: anAccount transactions ].
	
	^combinedTransactions! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'SDM 11/28/2021 22:06:57'!
portfolioCannotContainDuplicateAccountsErrorDescription

	^'Portfolio cannot contain duplicate accounts'! !

!Portfolio class methodsFor: 'error description' stamp: 'SDM 11/28/2021 21:56:08'!
portfolioCannotContainItselfErrorDescription

	^'Portfolio cannot contain itself'! !


!classDefinition: #SingleAccount category: 'ServiciosFinancieros-Ejercicio'!
ReceptiveAccount subclass: #SingleAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!SingleAccount methodsFor: 'initialization' stamp: 'SDM 11/28/2021 22:50:58'!
initialize

	transactions := OrderedCollection new.
	parents := OrderedCollection new.! !


!SingleAccount methodsFor: 'main protocol' stamp: 'SDM 11/28/2021 19:27:44'!
balance

	^transactions sum: [ :aTransaction | aTransaction changeInBalance ] ifEmpty: [ 0 ]! !

!SingleAccount methodsFor: 'main protocol' stamp: 'SDM 11/29/2021 18:36:17'!
hasRegistered: aTransaction

	^transactions includes: aTransaction 
! !

!SingleAccount methodsFor: 'main protocol' stamp: 'SDM 11/28/2021 19:27:44'!
register: aTransaction

	transactions add: aTransaction 
! !

!SingleAccount methodsFor: 'main protocol' stamp: 'SDM 11/29/2021 18:36:08'!
transactions 

	^transactions copy! !


!SingleAccount methodsFor: 'private' stamp: 'SDM 11/29/2021 18:34:28'!
anySonContains: anAccountOrPortfolio

	^false
! !

!SingleAccount methodsFor: 'private' stamp: 'SDM 11/28/2021 22:24:44'!
contains: anAccountOrPortfolio

	^false
! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value originLeg destinationLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'value' stamp: 'SDM 11/28/2021 14:09:47'!
depositLeg

	^destinationLeg ! !

!Transfer methodsFor: 'value' stamp: 'SDM 11/28/2021 02:15:03'!
value

	^value! !

!Transfer methodsFor: 'value' stamp: 'SDM 11/28/2021 14:09:26'!
withdrawLeg

	^originLeg ! !


!Transfer methodsFor: 'initialization' stamp: 'SDM 11/29/2021 18:35:47'!
initializeFrom: anOriginAccount to: aDestinationAccount for: aTransferAmount 

	originLeg := anOriginAccount.
	destinationLeg := aDestinationAccount.
	value := aTransferAmount

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'transfer' stamp: 'SDM 11/28/2021 15:18:13'!
from: anOriginAccount to: aDestintionAccount for: anAmountToTransfer 
	| transfer originLeg destinationLeg |
	
	(anAmountToTransfer <= 0) ifTrue: [^self error: Transfer invalidTransferValueErrorDescription].
	
	transfer := self new.
	originLeg := TransferWithdraw register: anAmountToTransfer on: anOriginAccount asPartOf: transfer.
	destinationLeg := TransferDeposit register: anAmountToTransfer on: aDestintionAccount asPartOf: transfer.
	
	transfer initializeFrom: originLeg to: destinationLeg for: anAmountToTransfer.
	
	^transfer! !


!Transfer class methodsFor: 'error description' stamp: 'SDM 11/28/2021 15:20:44'!
invalidTransferValueErrorDescription
	
	^ 'Transfer value has to be greater than zero'! !
