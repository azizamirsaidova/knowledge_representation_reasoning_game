;;; PDDL Problem  file for murder mystery mansion project
; The maid in the ballroom killed the heiress in the dining room
; illogical.

(define (problem maid-problem)
    (:domain murder-mansion)
    (:objects 
        maid heiress - person
        mango - weapon
        diningroom - room
        ballroom - room)
    
    (:init
        ;;detective's location
        (detectiveCurrentlyInRoom diningroom)
        
        ;person interrogated
        (interrogatedPerson maid)
        
        ;;relationships between characters
        (loyal maid heiress)
        
        ;;current state of characters
        (dead heiress)
        (worried maid)
	    
	    ;;location of characters
	    (personCurrentlyInRoom heiress diningroom)
	    (personCurrentlyInRoom maid ballroom)
	    
	    ;;character alibis
	    (personInDifferentRoomAlibi maid ballroom)
	    
	    ;;about the weapon
	    (objectInRoom mango diningroom)
	    (poisoned mango)
	    
    )
    
    (:goal (illogical))
)