;;; PDDL Domain file for murder mystery project


(define (domain murder-mansion)
 (:requirements :strips :typing)
  
 (:types weapon key - object
         person - agent
         room - location)
    
 (:predicates
    ;; Knowledge about killing and victims
    (dead ?victim - person)
    (motive ?suspect - person)
    (means ?suspect - person)
    (suspicious ?suspect - person)
    (accident ?suspect - person)
  
    ;;Details of weapon used to kill the victim
    (knownWeapon ?w - weapon)
    (weaponIsMurderWeapon ?w - weapon) 
    (ownsWeapon ?owner - person ?w - weapon)
    (poisoned ?w - weapon) ;;  added to describe that the weapon has poison 
    (fingerprintsOnWeapon ?w - weapon ?p - person) ;; fingerprints on weapon(murderer fingerprints)
    
    ;;In case of any exchange between characters that could potentially lead to murder (in our case mango)
    (itemGivenTo ?intendedtargetofmurder - person ?suspect - person)
    (itemAccess ?accidentalvictim - person)
    
    ;;Reasoning About Locations
    (objectInRoom ?o - object ?r - room)
    (knownObjectInRoom ?o - object ?r - room)
    (personTypicallyFoundInRoom ?p - person ?r - room)
    (personCurrentlyInRoom ?p - person ?r - room)
    (personInRoomDuringMurder ?p - person ?r - room)
    
    ;;Movement and connectedness of rooms
    (detectiveCurrentlyInRoom ?r - room)
    (roomConnected ?r1 - room ?r2 - room)
    
    ;;Lock and Key puzzles
    (keyUnlocksRoom ?k - key ?r - room)
    (ownsKey ?owner - person ?k - key)
    
    ;;Types of Alibis
    (interrogatedPerson ?p - person) 
    (personInDifferentRoomAlibi ?p - person ?r - room)
    (personWithDifferentPersonAlibi ?p - person ?corroborator - person)
    (noLocationAlibi ?p - person) 
    (noCorroborationAlibi ?p - person)
    
    ;;Moods
   	(happy ?p - person)
    (sad ?p - person)
	(calm ?p - person)
    (worried ?p - person)
    (angry ?p - person)
    (scared ?p - person) ;;this is also required as scared shows that this person could have done something which is why he is scared
    
    ;;Interpersonal Relationships
    (hates ?hater - person ?hated - person)
    (loves ?lover - person ?loved - person)
    (envies ?envier - person ?envied - person)
    (loyal ?loyal - person ?loyalized - person)
    
    ;;Different end states indicating certainty
    (solved) ; The crime is solved beyond a reasonable doubt (means+motive+suspicious)
    (probable) ; There is some degree of certainty that the crime is solved (any 2 conditions match)
    (hunch) ; We have a hunch that the murder can be solved, but we might be wrong (only 1 condition matches)
    (illogical) ;The hypothesis is illogical since there are no means, no motive and no suspicion involved. It makes no logical sense.
 )


(:action MoveBetweenRooms
   :parameters (?currentroom - room ?nextroom - room)
   :precondition (and (detectiveCurrentlyInRoom ?currentroom)
                      (roomConnected ?currentroom ?nextroom))
   :effect (and (not (detectiveCurrentlyInRoom ?currentroom))
                (detectiveCurrentlyInRoom ?nextroom))
 )


;; Access to the murder weapon gives means
;; Specifies murder weapon
;; Mango has the poison thus making mango a murder weapon
(:action PoisonedMangoIsMurderWeapon
    :parameters (?w - weapon)
    :precondition (and (poisoned ?w) (knownWeapon ?w)) 
    :effect (weaponIsMurderWeapon ?w)
 )


;;;Defining means of murder


;; specifies owner of murder weapon and his/her means
(:action OwningMurderWeaponGivesMeans
    :parameters (?owner - person ?w - weapon)
    :precondition (and (ownsWeapon ?owner ?w)
                       (weaponIsMurderWeapon ?w))
    :effect (means ?owner)
 )

;;Specifies who out of all has the access to the weapon
(:action ProximityToWeaponGivesMeans
    :parameters (?p - person ?r - room ?w - weapon)
    :precondition (and (personTypicallyFoundInRoom ?p ?r)
                       (weaponIsMurderWeapon ?w)
                       (knownObjectInRoom ?w ?r))
    :effect (means ?p)
 )

;;Specifies Fingerprint on weapon 
(:action FingerPrintsOnWeaponGivesMeans
    :parameters (?p - person ?w - weapon)
    :precondition (and (weaponIsMurderWeapon ?w)
                       (fingerprintsOnWeapon ?w ?p))
    :effect (means ?p)
 )


;;;Defining suspicion for murder


;; Misleading or false alibis raise suspicion
 (:action LocationAlibiDoesNotCorroborateIsSuspicious
    :parameters (?p1 - person ?p2 - person)
    :precondition (and (interrogatedPerson ?p1) 
                       (interrogatedPerson ?p2)
                       (personWithDifferentPersonAlibi ?p1 ?p2)
                       (not (personWithDifferentPersonAlibi ?p2 ?p1)))
    :effect (and (suspicious ?p1) (suspicious ?p2))
 )

;;Having no location alibi raises suspicion
(:action NoLocationAlibiIsSuspicious
    :parameters (?p1 - person)
    :precondition (and (interrogatedPerson ?p1)
                       (noLocationAlibi ?p1))
    :effect (suspicious ?p1)
 )
 
;;Being present at the murder location raises suspicion
 ( :action personInRoomDuringMurderIsSuspicious
        :parameters (?p1 - person ?r - room)
        :precondition (and (personInRoomDuringMurder ?p1 ?r) 
                (interrogatedPerson ?p1))
        :effect (suspicious ?p1)
 )

;;specifies that being scared during interrogation raises suspicion
(:action ScaredDuringInterrogationIsSuspicious
    :parameters (?p - person)
    :precondition (and (interrogatedPerson ?p)
                       (scared ?p))
    :effect (suspicious ?p)
 )


;; Investigating Actions. 
;; Necessary for establishing the logical flow of the actions
 (:action InvestigateRoom
           :parameters (?o - object ?r - room)
           :precondition (and (detectiveCurrentlyInRoom ?r)
                              (objectInRoom ?o ?r))
           :effect (knownObjectInRoom ?o ?r)
 )

 (:action InterrogatePerson
           :parameters (?p - person ?r - room)
           :precondition (and (not (interrogatedPerson ?p))
                                (not(dead ?p))
                              (personCurrentlyInRoom ?p ?r)
                              (detectiveCurrentlyInRoom ?r))
           :effect (interrogatedPerson ?p)
 )   
 
 (:action IdentifyWeapon
   :parameters (?w - weapon ?r - room)
   :precondition (knownObjectInRoom ?w ?r)
   :effect (knownWeapon ?w)
 )

;;If the murder happens in a room accessed with key then discovering the key owner would frame them as a murder suspect
(:action DiscoverKeyOwnerIsKiller
           :parameters (?keyowner - person ?victim - person ?k - key ?r - room)
           :precondition (and (personCurrentlyInRoom ?victim ?r)
                              (dead ?victim)
                              (keyUnlocksRoom ?k ?r)
                              (ownsKey ?keyowner ?k))
           :effect (suspicious ?keyowner)
)


  ;;added one for LoveQuadrilateralCausesHatred
  
   (:action LoveTriangleCausesHatred
           :parameters (?p1 - person ?p2 - person ?p3 - person)
           :precondition (and (loves ?p1 ?p2)
                              (loves ?p3 ?p2))

           :effect (and (hates ?p1 ?p3)
                   (hates ?p3 ?p1)
                   (envies ?p3 ?p1)
                   (envies ?p1 ?p3))
  )
   (:action LoveQuadrilateralCausesHatred
           :parameters (?p1 - person ?p2 - person ?p3 - person ?p4 - person)
           :precondition (and (loves ?p1 ?p2)
                              (loves ?p3 ?p2)
                              (loves ?p4 ?p3)
                              (hates ?p4 ?p2))

           :effect (and (hates ?p2 ?p4)
                   (hates ?p4 ?p2) (hates ?p1 ?p3) (hates ?p3 ?p1) )
  )
  
  
;;; Defining motive for murder


  (:action HateIsAMotive
    :parameters (?hater - person ?hated - person)
    :precondition (and (hates ?hater ?hated) 
                       (dead ?hated)
                       (interrogatedPerson ?hater))
    :effect (motive ?hater)
  )
  
  (:action EnvyIsAMotive
    :parameters (?envier - person ?envied - person)
    :precondition (and (envies ?envier ?envied)
                       (dead ?envied)
                       (interrogatedPerson ?envier))
    :effect (motive ?envier)
  )
  
  (:action LoveTriangleIsAMotive
    :parameters (?envier - person ?envied - person)
    :precondition (and (envies ?envier ?envied)
                       (dead ?envied)
                       (interrogatedPerson ?envier))
    :effect (motive ?envier)
  )
  
  ;;; if person is loyal, he/she wouldn't have kany motive to kill
 (:action LoyalNoMotive
    :parameters (?loyal - person ?loyalized - person)
    :precondition (and (loyal ?loyal ?loyalized)
                       (dead ?loyalized)
                       (interrogatedPerson ?loyal))
    :effect (not(motive ?loyal))
    )
    

    ;;; Defining accident
     (:action accidentalDeath
    :parameters (?suspect - person ?intendedtargetofmurder - person ?accidentalvictim - person)
    :precondition (and (hates ?suspect ?intendedtargetofmurder)
                       (dead ?accidentalvictim)
                       (itemGivenTo ?intendedtargetofmurder ?suspect)
                       (itemAccess ?accidentalvictim)
                       (interrogatedPerson ?suspect))
    :effect (accident ?suspect)
    )
    
    
;;; Defining goal states of investigation- Solutions

  (:action MeansMotiveSuspiciousImpliesGuilt
    :parameters (?suspect - person)
    :precondition (and (means ?suspect) (or (motive ?suspect) (accident ?suspect)) (suspicious ?suspect))
    :effect (solved)
  )
  
  
  (:action MeansMotiveImpliesProbable
    :parameters (?suspect - person)
    :precondition (and (means ?suspect) (motive ?suspect))
    :effect (probable)
  )
  
  (:action MeansSuspiciousImpliesProbable
    :parameters (?suspect - person)
    :precondition (and (means ?suspect) (suspicious ?suspect))
    :effect (probable)
  )
  
  (:action SuspiciousMotiveImpliesProbable
    :parameters (?suspect - person)
    :precondition (and (motive ?suspect) (suspicious ?suspect))
    :effect (probable)
  )
  
    (:action AnyClueImpliesHunch
    :parameters (?suspect - person)
    :precondition (or (means ?suspect) (motive ?suspect) (suspicious ?suspect))
    :effect (hunch)
  )
  
  (:action NoClueImpliesIllogical
    :parameters (?suspect - person)
    :precondition (and (not(means ?suspect)) (not(motive ?suspect)) (not(suspicious ?suspect)))
    :effect (illogical)
  )
  
 
)

