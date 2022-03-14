;;; PDDL Problem  file for murder mystery mansion project
;Love connection between cook, heiress and duke leads to her death
;the duke killed the heiress to get rid of her
; Probable


(define (problem love-quadrilateral-problem)
    (:domain murder-mansion)
    (:objects cook heiress duke - person
              mango - weapon
              diningroom - room
              kitchen - room
              kitchenkey - key)
    (:init
        ;;detective's location
        (detectiveCurrentlyInRoom diningroom)
        
        ;;relationships between characters
        (loves heiress duke)
        (loves cook duke)
        
        ;;current state of characters
        (dead heiress)
        (sad duke)
        (worried cook)
        
	    ;;location of characters
	    (personCurrentlyInRoom heiress diningroom)
	    (personCurrentlyInRoom duke diningroom)
	    (personCurrentlyInRoom cook kitchen)
	    (personInRoomDuringMurder duke diningroom)
	    (personTypicallyFoundInRoom duke diningroom)
	    
	    ;;room access that characters have
	    (ownsKey cook kitchenkey)
	    (keyUnlocksRoom kitchenkey kitchen)
	    
	    ;;character alibis
	    (personInDifferentRoomAlibi cook kitchen)
	    (noLocationAlibi duke)
	    
         ;;about the object in the room
	    (objectInRoom mango diningroom)
	    (poisoned mango)
        
    )
    
    (:goal (probable))

)