;;; PDDL Problem  file for murder mystery mansion project
;The butler murders the heiress with the wine he brought from the cellar
; hunch


(define (problem butler-problem)
    (:domain murder-mansion)
    (:objects 
        heiress butler - person
        mango - weapon
        wine - weapon
        diningroom - room
        cellar - room
        cellarkey - key)
    
    (:init
        ;;detective's location
        (detectiveCurrentlyInRoom cellar)
        (roomConnected cellar diningroom)
        
        ;;relationships between characters
        (loyal butler heiress)
        
        ;;current state of characters
        (dead heiress)
        (sad butler)
	    
	    ;;location of characters
	    (personCurrentlyInRoom heiress diningroom)
	    (personCurrentlyInRoom butler diningroom)
	    (personInRoomDuringMurder butler diningroom)
	    
	     ;;room access that characters have
	    (ownsKey butler cellarkey)
	    (keyUnlocksRoom cellarkey cellar)
	    
	    ;;character alibis
	    (noLocationAlibi butler)
	    
	    ;;about the weapon
	    (objectInRoom mango diningroom)
	    (objectInRoom wine diningroom)
	    (poisoned mango)
	    
    )
    
    (:goal (hunch))
)