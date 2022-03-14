;;; PDDL Problem  file for murder mystery mansion project
;Love connection between gardner, cook, heiress and duke leads to her death
;the gardner is the killer since he sent the posioned mangoes for the duke and accidentaly killed heiress
; Solvable


(define (problem solvable-love-quadrilateral-problem)
    (:domain murder-mansion)
    (:objects cook gardner heiress duke - person
              mango - weapon
              diningroom - room
              conservatory - room
              kitchen - room
              kitchenkey - key)
    (:init
        ;;detective's location
        (detectiveCurrentlyInRoom diningroom)
        
        ;;person interrogated
        (interrogatedPerson gardner) ;; explicitly mentioning here since there are multiple people 
        
        ;;relationships between characters
        (loves heiress duke)
        (loves cook duke)
	    (loves gardner cook)
    	(hates gardner duke)
    	
    	;;item exchange between characters
    	(itemGivenTo duke gardner)
    	(itemAccess heiress)
    	
    	;;current state of characters
        (dead heiress)
        (worried cook)
	    (sad duke)
	    (scared gardner)
	    	    
	    ;;location of characters
	    (personCurrentlyInRoom heiress diningroom)
	    (personCurrentlyInRoom duke diningroom)
	    (personCurrentlyInRoom cook kitchen)
	    (personCurrentlyInRoom gardner conservatory)
	    (personInRoomDuringMurder duke diningroom)
	    
	    ;;room access that characters have
	    (ownsKey cook kitchenkey)
	    (keyUnlocksRoom kitchenkey kitchen)
	    
	    ;;character alibis
	    (personInDifferentRoomAlibi gardner conservatory)
	    (personInDifferentRoomAlibi cook kitchen)
	    (noCorroborationAlibi gardner)
	    (noLocationAlibi duke)
	    
	    ;;about the weapon
	    (objectInRoom mango diningroom)
	    (poisoned mango)
	    (fingerprintsOnWeapon mango gardner)
        
    )
    
    (:goal (solved))
    
)