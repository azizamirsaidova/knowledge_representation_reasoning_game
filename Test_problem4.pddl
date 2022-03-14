;;; PDDL Problem  file for murder mystery mansion project
;The heiress killed herself
;illogical


(define (problem heiress-bedroom-problem)
    (:domain murder-mansion)
    (:objects 
        heiress - person
        diningroom - room
        mango - weapon)
    
    (:init
        ;;current state of characters
        (dead heiress)
        (sad heiress) ;;;to define her potential mood state before death (which is the case for suicides)
	    
	    ;;person interrogated
        (interrogatedPerson heiress) ;;have to explicitly mention here since the heiress is dead
        
        ;;location of characters
	    (personCurrentlyInRoom heiress diningroom)
	    	     
	    ;;about the object in the room
	    (objectInRoom mango diningroom)
	    (poisoned mango)
	    
	)
    (:goal (illogical))
)

