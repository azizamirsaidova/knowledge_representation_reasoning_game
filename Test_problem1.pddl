;;; PDDL Problem  file for murder mystery mansion project
;Love triangle between cook, duke and heiress leads to heiress's death
;cook tries to poison the heiress 
;hunch


(define (problem love-triangle-problem)
    (:domain murder-mansion)
    (:objects cook duke heiress - person
              mango - weapon
              kitchen - room
              diningroom - room
              kitchenkey - key)
    (:init
        ;;detective's location
        (detectiveCurrentlyInRoom diningroom)
        
        ;;person interrogated
        (interrogatedPerson cook) ;; explicitly mentioning here since there are multiple people 
        
        ;;relationships between characters
        (loves heiress duke)
        (loves cook duke)
        
        ;;current state of characters
        (dead heiress)
        (worried cook)
	    (sad duke)
        
        ;;location of characters
	    (personCurrentlyInRoom heiress diningroom)
	    (personCurrentlyInRoom duke diningroom)
	    (personCurrentlyInRoom cook kitchen)
	    (personInRoomDuringMurder duke diningroom)
	    
	    ;;character alibis
	    (personInDifferentRoomAlibi cook kitchen)
	    (noLocationAlibi duke)
	    
	    ;;room access that characters have
	    (ownsKey cook kitchenkey)
	    (keyUnlocksRoom kitchenkey kitchen)
	    
	    ;;about the object in the room
	    (objectInRoom mango diningroom)
	    (poisoned mango)
	    
	 )
    
    (:goal (hunch))
)