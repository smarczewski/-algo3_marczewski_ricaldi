!classDefinition: #CarolinaLaCurandera category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #CarolinaLaCurandera
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CarolinaLaCurandera class' category: 'Ejercicio1-PNJ-Episodio2'!
CarolinaLaCurandera class
	instanceVariableNames: 'frasesDesconocido frasesPrometedor cantidadDeInteraccionesPorPersonaje'!

!CarolinaLaCurandera class methodsFor: 'interacciones' stamp: 'SDM 9/29/2021 18:54:13'!
interactuarCon: UnPersonajeJugador
	"Recuerda la interaccion, aumentando el contador de interacciones, y responde acordemente"
	
	self recordarInteraccionCon: UnPersonajeJugador.
	^ self responderSegunCantidadDeInteraccionesCon: UnPersonajeJugador.! !

!CarolinaLaCurandera class methodsFor: 'interacciones' stamp: 'SDM 9/29/2021 18:54:13'!
olvidar
	"Olvida las interacciones con todos los personajes, reseteando el diccionario de contadores"
	
	cantidadDeInteraccionesPorPersonaje := Dictionary new.! !

!CarolinaLaCurandera class methodsFor: 'interacciones' stamp: 'SDM 9/29/2021 21:38:21'!
olvidarInteraccionesCon: UnPersonajeJugador
	"Olvida las interacciones con un personaje especifico, reseteando su contador en el diccionario"
	
	cantidadDeInteraccionesPorPersonaje at: UnPersonajeJugador put: 0.! !


!CarolinaLaCurandera class methodsFor: 'interacciones - privado' stamp: 'SDM 9/29/2021 21:44:37'!
convertirAPrometedorYResetearConversacionesCon: UnPersonajeJugador
	"Convierte a un personaje jugador en prometedor y reinicia sus interacciones con los PNJ"

	self olvidarInteraccionesCon: UnPersonajeJugador.
	TreborElGuardiaDeSkyrim olvidarInteraccionesCon: UnPersonajeJugador.
	ElPuebloDeRiverwood verComoPrometedorA: UnPersonajeJugador.! !

!CarolinaLaCurandera class methodsFor: 'interacciones - privado' stamp: 'SDM 9/29/2021 18:54:13'!
devolverContadorDeInteraccionesDe: UnPersonajeJugador
	"Devuelve el contador de un personaje jugador en especifico, si no se encuentra en el diccionario devuelve 0"
	
	| cantidaddeInteracciones |
	cantidaddeInteracciones := cantidadDeInteraccionesPorPersonaje at: UnPersonajeJugador ifAbsent: [0].
	^ cantidaddeInteracciones.
! !

!CarolinaLaCurandera class methodsFor: 'interacciones - privado' stamp: 'SDM 9/29/2021 18:54:13'!
recordarInteraccionCon: UnPersonajeJugador
	"Recuerda interacciones con un personaje jugadore especifico mediante un diccionario de contadores"
	
	| cantidadDeInteracciones |
	cantidadDeInteracciones := self devolverContadorDeInteraccionesDe: 	UnPersonajeJugador.
	cantidadDeInteraccionesPorPersonaje at: UnPersonajeJugador put: cantidadDeInteracciones + 1.! !

!CarolinaLaCurandera class methodsFor: 'interacciones - privado' stamp: 'SDM 9/29/2021 21:46:57'!
responderSegunCantidadDeInteraccionesCon: UnPersonajeJugador
	"Responde acorde a la cantidad de interacciones de un personaje jugador especifico, si se completa el dialogo convierte
	al personaje jugador en prometedor y reinicia sus interacciones con todos los PNJ"
	
	| cantidadDeInteracciones |
	cantidadDeInteracciones := self devolverContadorDeInteraccionesDe: UnPersonajeJugador.
	
	(ElPuebloDeRiverwood elPuebloVeComoPrometedorA: UnPersonajeJugador) ifTrue: 
		[ ^ frasesPrometedor at: (cantidadDeInteracciones min: frasesPrometedor size). ] 
	ifFalse: 
		[ (cantidadDeInteracciones = 3) ifTrue: [ self convertirAPrometedorYResetearConversacionesCon: UnPersonajeJugador ].
		  ^ frasesDesconocido at: (cantidadDeInteracciones min: frasesDesconocido size). ]! !


!CarolinaLaCurandera class methodsFor: 'as yet unclassified' stamp: 'SDM 10/4/2021 16:46:28'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	frasesDesconocido := #('¿Estás enfermo forastero?' 'Ah, solo quieres conversar' 'Cuando tengas una aflicción, ven a verme' ).
	frasesPrometedor := #('Salud aventurero!!' 'Toma esta pócima que te hará crecer el pelo. Y cuando tengas una aflicción, ven a verme' ).
	cantidadDeInteraccionesPorPersonaje := ((Dictionary new) add: (#Hamilton->0); yourself).! !


!classDefinition: #ElPuebloDeRiverwood category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #ElPuebloDeRiverwood
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElPuebloDeRiverwood class' category: 'Ejercicio1-PNJ-Episodio2'!
ElPuebloDeRiverwood class
	instanceVariableNames: 'personajesJugadoresPrometedores'!

!ElPuebloDeRiverwood class methodsFor: 'interacciones' stamp: 'SDM 9/29/2021 21:19:20'!
elPuebloVeComoPrometedorA: UnPersonajeJugador
	"Devuelve true si el pueblo ve como prometedor a un personaje jugador, false si lo ve como desconocido"
	
	^ personajesJugadoresPrometedores includes: UnPersonajeJugador.! !

!ElPuebloDeRiverwood class methodsFor: 'interacciones' stamp: 'SDM 9/29/2021 18:43:59'!
olvidarOpiniones
	"Olvida las opiniones de todos los personajes, reseteando la coleccion de jugadores prometedores"
	
	personajesJugadoresPrometedores := OrderedCollection new.! !

!ElPuebloDeRiverwood class methodsFor: 'interacciones' stamp: 'SDM 9/29/2021 18:43:10'!
verComoPrometedorA: UnPersonajeJugador
	"Cambia la opinion del pueblo de Riverwood sobre un personaje jugador a prometedor"
	
	personajesJugadoresPrometedores add: UnPersonajeJugador.! !


!ElPuebloDeRiverwood class methodsFor: 'as yet unclassified' stamp: 'SDM 10/4/2021 16:46:28'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	personajesJugadoresPrometedores := ((OrderedCollection new) add: #Hamilton; yourself).! !


!classDefinition: #PruebasInteracionesConCarolinaLaCurandera category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #PruebasInteracionesConCarolinaLaCurandera
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasInteracionesConCarolinaLaCurandera class' category: 'Ejercicio1-PNJ-Episodio2'!
PruebasInteracionesConCarolinaLaCurandera class
	instanceVariableNames: ''!

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 12:48:36'!
test01CuandoLaCuranderaInteractuaPorPrimeraVezConUnPersonajeLeRespondeConSuPrimerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: '¿Estás enfermo forastero?'.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 12:48:37'!
test02CuandoLaCuranderaInteractuaPorSegundaVezConUnPersonajeLeRespondeConSuSegundaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self carolinaLaCurandera interactuarCon: self hamilton.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Ah, solo quieres conversar'.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 12:49:16'!
test03CuandoLaCuranderaInteractuaPorTerceraVezConUnPersonajeLeRespondeConSuTercerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self carolinaLaCurandera interactuarCon: self hamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Cuando tengas una aflicción, ven a verme'.! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con mas de un personaje' stamp: 'JMB 9/25/2021 12:50:11'!
test04LaCuranderaMantieneDosInteraccionesConDiferentesPersonajes
	self olvidarInteraccionesYOpiniones.
	
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: '¿Estás enfermo forastero?'.
	Assert that: (self carolinaLaCurandera interactuarCon: self tirion) isEqualTo: '¿Estás enfermo forastero?'.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con mas de un personaje' stamp: 'JMB 9/25/2021 12:50:18'!
test05LaCuranderaMantieneDosInteraccionesCompletasConDiferentesPersonajes
	self olvidarInteraccionesYOpiniones.
	
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: '¿Estás enfermo forastero?'.
	
	Assert that: (self carolinaLaCurandera interactuarCon: self tirion) isEqualTo: '¿Estás enfermo forastero?'.
	Assert that: (self carolinaLaCurandera interactuarCon: self tirion) isEqualTo: 'Ah, solo quieres conversar'.
	Assert that: (self carolinaLaCurandera interactuarCon: self tirion) isEqualTo: 'Cuando tengas una aflicción, ven a verme'.
	
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: 'Ah, solo quieres conversar'.
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: 'Cuando tengas una aflicción, ven a verme'.
	! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con personajes prometedores' stamp: 'JMB 9/25/2021 12:50:32'!
test06CuandoLaCuranderaInteractuaPorPrimeraVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuPrimerFrase
	| mensaje |	
	self olvidarInteraccionesYOpiniones.
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Salud aventurero!!'.
! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con personajes prometedores' stamp: 'JMB 9/25/2021 12:50:39'!
test07CuandoLaCuranderaInteractuaPorSegundaVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuSegundaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Toma esta pócima que te hará crecer el pelo. Y cuando tengas una aflicción, ven a verme'.
! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'cambio de opiniones' stamp: 'JMB 9/25/2021 12:50:52'!
test08CuandoLaCuranderaTerminaSuRepertorioDeFrasesConUnPersonajeCambiaLaOpinionDelPuebloSobreElPersonajeAPrometedor
	self olvidarInteraccionesYOpiniones.
	self carolinaLaCurandera interactuarCon: self hamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.	
	self carolinaLaCurandera interactuarCon: self hamilton.	
	
	Assert isTrue: (self esVistoPorElPuebloComoPrometedor: self hamilton).! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'cambio de opiniones' stamp: 'SDM 9/29/2021 21:27:42'!
test09CuandoLaCuranderaCambiaLaOpinionDelPuebloSobreElPersonajeAPrometedorReiniciaSuHiloDeDialogoConElPersonaje
	self olvidarInteraccionesYOpiniones.
	self carolinaLaCurandera interactuarCon: self hamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.	
	self carolinaLaCurandera interactuarCon: self hamilton.	
	
	Assert that: 'Salud aventurero!!' isEqualTo: (self carolinaLaCurandera interactuarCon: self hamilton)! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'cambio de opiniones' stamp: 'SDM 9/29/2021 21:28:09'!
test10CuandoLaCuranderaCambiaLaOpinionDelPuebloSobreElPersonajeAPrometedorReiniciaElHiloDeDialogoDelGuardiaConElPersonaje
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	
	self carolinaLaCurandera interactuarCon: self hamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.	
	self carolinaLaCurandera interactuarCon: self hamilton.	

	Assert that: 'Bienvenido aventurero!!' isEqualTo: (self treborElGuardia interactuarCon: self hamilton)! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'personajes' stamp: 'SDM 9/29/2021 18:58:02'!
carolinaLaCurandera
	^ CarolinaLaCurandera.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'personajes' stamp: 'SDM 9/29/2021 18:58:58'!
hamilton
	^ #Hamilton.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'personajes' stamp: 'SDM 9/29/2021 18:59:08'!
tirion
	^ #Tirion! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'personajes' stamp: 'JMB 9/21/2021 20:52:20'!
treborElGuardia
	^ TreborElGuardiaDeSkyrim ! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'SDM 9/29/2021 21:22:31'!
esVistoPorElPuebloComoPrometedor: unPersonaje
	^ ElPuebloDeRiverwood elPuebloVeComoPrometedorA: unPersonaje.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'SDM 9/29/2021 19:00:08'!
hacerQueLaCuranderaOlvideSusInteracciones
	CarolinaLaCurandera olvidar.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'SDM 9/29/2021 19:00:24'!
hacerQueRiverwoodOlvideTodasSusCalificaciones
	ElPuebloDeRiverwood olvidarOpiniones.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'SDM 9/29/2021 19:00:44'!
hacerQueRiverwoodVeaPrometedorAHamilton
	ElPuebloDeRiverwood verComoPrometedorA: self hamilton.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'JMB 9/25/2021 12:48:36'!
olvidarInteraccionesYOpiniones
	self hacerQueLaCuranderaOlvideSusInteracciones.	
	self hacerQueRiverwoodOlvideTodasSusCalificaciones.
! !


!classDefinition: #PruebasInteracionesConTreborElGuardia category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #PruebasInteracionesConTreborElGuardia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasInteracionesConTreborElGuardia class' category: 'Ejercicio1-PNJ-Episodio2'!
PruebasInteracionesConTreborElGuardia class
	instanceVariableNames: ''!

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:03:53'!
test01CuandoElGuardiaInteractuaPorPrimeraVezConUnPersonajeLeRespondeConSuPrimerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Hola forastero'.
! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:04:08'!
test02CuandoElGuardiaInteractuaPorSegundaVezConUnPersonajeLeRespondeConSuSegundaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: '¿Todo bien?'.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:04:25'!
test03CuandoElGuardiaOlvidaInteraccionesPreviasConUnPersonajeAlVolverAInteractuarLeRespondeConSuPrimerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	self treborElGuardia olvidar.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Hola forastero'.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:04:35'!
test04CuandoElGuardiaInteractuaPorTerceraVezConUnPersonajeLeRespondeConSuTercerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	self treborElGuardia interactuarCon: self hamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: '¿Algún problema?'.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:04:44'!
test05CuandoElGuardiaInterctuaYTerminoSuRepertorioDeFrasesConUnPersonajeLeRespondeConSuUltimaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	self treborElGuardia interactuarCon: self hamilton.
	self treborElGuardia interactuarCon: self hamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: '¿Algún problema?'.! !


!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con mas de un personaje' stamp: 'JMB 9/25/2021 12:53:36'!
test06ElGuardiaMantieneDosInteraccionesConDiferentesPersonajes
	self olvidarInteraccionesYOpiniones.

	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: 'Hola forastero'.
	Assert that: (self treborElGuardia interactuarCon: self tirion) isEqualTo: 'Hola forastero'.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con mas de un personaje' stamp: 'JMB 9/25/2021 12:53:43'!
test07ElGuardiaMantieneDosInteraccionesCompletasConDiferentesPersonajes
	self olvidarInteraccionesYOpiniones.
	
	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: 'Hola forastero'.
	
	Assert that: (self treborElGuardia interactuarCon: self tirion) isEqualTo: 'Hola forastero'.
	Assert that: (self treborElGuardia interactuarCon: self tirion) isEqualTo: '¿Todo bien?'.
	Assert that: (self treborElGuardia interactuarCon: self tirion) isEqualTo: '¿Algún problema?'.
	
	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: '¿Todo bien?'.
	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: '¿Algún problema?'.
	! !


!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con personajes prometedores' stamp: 'JMB 9/25/2021 12:54:46'!
test08CuandoElGuardiaInteractuaPorPrimeraVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuPrimerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Bienvenido aventurero!!'.
! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con personajes prometedores' stamp: 'JMB 9/25/2021 12:55:02'!
test09CuandoElGuardiaInteractuaPorSegundaVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuSegundaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	self treborElGuardia interactuarCon: self hamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Espero que tengas una buena estadia en Riverwood'.
! !


!PruebasInteracionesConTreborElGuardia class methodsFor: 'personajes' stamp: 'SDM 9/27/2021 21:19:39'!
hamilton
	^ #Hamilton! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'personajes' stamp: 'SDM 9/27/2021 21:23:35'!
tirion
	^ #Tirion! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'personajes' stamp: 'JMB 9/21/2021 20:42:44'!
treborElGuardia
	^ TreborElGuardiaDeSkyrim ! !


!PruebasInteracionesConTreborElGuardia class methodsFor: 'opiniones e interacciones' stamp: 'JMB 9/21/2021 20:49:11'!
hacerQueElGuardiaOlvideSusInteracciones
	TreborElGuardiaDeSkyrim olvidar.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'opiniones e interacciones' stamp: 'SDM 9/29/2021 18:22:20'!
hacerQueRiverwoodOlvideTodasSusCalificaciones
	ElPuebloDeRiverwood olvidarOpiniones.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'opiniones e interacciones' stamp: 'SDM 9/29/2021 11:50:04'!
hacerQueRiverwoodVeaPrometedorAHamilton
	ElPuebloDeRiverwood verComoPrometedorA: self hamilton.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'opiniones e interacciones' stamp: 'JMB 9/25/2021 12:52:12'!
olvidarInteraccionesYOpiniones
	self hacerQueElGuardiaOlvideSusInteracciones. 	
	self hacerQueRiverwoodOlvideTodasSusCalificaciones.
! !


!classDefinition: #TreborElGuardiaDeSkyrim category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #TreborElGuardiaDeSkyrim
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TreborElGuardiaDeSkyrim class' category: 'Ejercicio1-PNJ-Episodio2'!
TreborElGuardiaDeSkyrim class
	instanceVariableNames: 'frasesDesconocido frasesPrometedor cantidadDeInteraccionesPorPersonaje'!

!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones' stamp: 'SDM 9/29/2021 11:12:26'!
interactuarCon: UnPersonajeJugador
	"Recuerda la interaccion, aumentando el contador de interacciones, y responde acordemente"
	
	self recordarInteraccionCon: UnPersonajeJugador.
	^ self responderSegunCantidadDeInteraccionesCon: UnPersonajeJugador.! !

!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones' stamp: 'SDM 9/29/2021 11:31:42'!
olvidar
	"Olvida las interacciones con todos los personajes, reseteando el diccionario de contadores"
	
	cantidadDeInteraccionesPorPersonaje := Dictionary new.! !

!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones' stamp: 'SDM 9/29/2021 21:39:03'!
olvidarInteraccionesCon: UnPersonajeJugador
	"Olvida las interacciones con un personaje especifico, reseteando su contador en el diccionario"
	
	cantidadDeInteraccionesPorPersonaje at: UnPersonajeJugador put: 0.! !


!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones - privado' stamp: 'SDM 9/29/2021 11:19:13'!
devolverContadorDeInteraccionesDe: UnPersonajeJugador
	"Devuelve el contador de un personaje jugador en especifico, si no se encuentra en el diccionario devuelve 0"
	
	| cantidaddeInteracciones |
	cantidaddeInteracciones := cantidadDeInteraccionesPorPersonaje at: UnPersonajeJugador ifAbsent: [0].
	^ cantidaddeInteracciones.
! !

!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones - privado' stamp: 'SDM 9/29/2021 11:41:41'!
recordarInteraccionCon: UnPersonajeJugador
	"Recuerda interacciones con un personaje jugadore especifico mediante un diccionario de contadores"
	
	| cantidadDeInteracciones |
	cantidadDeInteracciones := self devolverContadorDeInteraccionesDe: 	UnPersonajeJugador.
	cantidadDeInteraccionesPorPersonaje at: UnPersonajeJugador put: cantidadDeInteracciones + 1.! !

!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones - privado' stamp: 'SDM 9/29/2021 18:52:52'!
responderSegunCantidadDeInteraccionesCon: UnPersonajeJugador
	"Responde acorde a la cantidad de interacciones de un personaje jugador especifico"
	
	| cantidadDeInteracciones |
	cantidadDeInteracciones := self devolverContadorDeInteraccionesDe: UnPersonajeJugador.
	
	(ElPuebloDeRiverwood elPuebloVeComoPrometedorA: UnPersonajeJugador) ifTrue: 
		[ ^ frasesPrometedor at: (cantidadDeInteracciones min: frasesPrometedor size). ] 
	ifFalse: 
		[ ^ frasesDesconocido at: (cantidadDeInteracciones min: frasesDesconocido size).  ]! !


!TreborElGuardiaDeSkyrim class methodsFor: 'as yet unclassified' stamp: 'SDM 10/4/2021 16:46:28'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	frasesDesconocido := #('Hola forastero' '¿Todo bien?' '¿Algún problema?' ).
	frasesPrometedor := #('Bienvenido aventurero!!' 'Espero que tengas una buena estadia en Riverwood' ).
	cantidadDeInteraccionesPorPersonaje := ((Dictionary new) add: (#Hamilton->2); yourself).! !

CarolinaLaCurandera initializeAfterFileIn!
ElPuebloDeRiverwood initializeAfterFileIn!
TreborElGuardiaDeSkyrim initializeAfterFileIn!