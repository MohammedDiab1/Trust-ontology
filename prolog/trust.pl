/* Copyright © 2021 by Imperial College London (ICL), Personal Robotics Lab (PRL). 
The ontology model represents ontological knowledge for Trust in order to provide better assessment and evaluation for domains that include humans and robots interacting with each other.
Author: Mohammed Diab 
email: m.diab.phd@gmail.com
       m.diab@imperial.ac.uk */

/* Predicates */
%:- use_module(library('semweb/rdf11')).
:- use_module(library('semweb/rdf_db')).
:- use_module(library('semweb/rdf_db.pl')).
:- use_module(library('semweb/rdf_edit.pl')).
:- use_module(library('semweb/rdfs.pl')).
:- use_module(library('semweb/rdf_portray')).
:- use_module(library('url.pl')).
:- use_module(library('http/http_open.pl')).
:- use_module(library('error')).

%Setting resources for predicates.
:-  rdf_meta
 find_subclass(r,r),
find_human_intention(r,r),
 find_robot_capability(r,r),
 find_user_robot_experience(r,r),
 risky_situation(r,r),
 trust(r,r).

%Parsing the pmk ontology [to be modified by the user to access his/her ontology].

:- rdf_load('/home/kinova/trust_ws/src/Trust-ontology/owl/trust.owl').

:- rdf_db:rdf_register_ns(prl_tak, 'https://juicer.ee.imperial.ac.uk:8443/trust.owl#', [keep(true)]).

%%%%%%%%%%%%% PROLOG FEATURES %%%%%%%%%%%%

   find_subclass(Class, SubClass):- %question
   rdfs_subclass_of(SubClass, Class), %answer
   SubClass \= Class.

%Removing unnecessary string in literal when reading data values in order to extract only value.

 literal_type_conv(literal(type(_, V)), Value):- atom_to_term(V, Value, _), !.
 literal_type_conv(Value, Value).

%%%%%%%%%%%% READING DATA PROPERTIES FROM THE OWL %%%%%%%%%%%%%

find_

%Infer intention of trustor (Human)
find_human_intention(Human, Intention):-
 rdf_has(Intention, prl_tak:'hasIntention', R),

	literal_type_conv(R, Robot).

%Infer human belief about a robot (a set of composed belief regarding robot Capability, robot behaviour, vulnerability belief)
find_robot_capability(Robot, Capability):-
  rdf_has(Robot, prl_tak:'hasCapability', C),

	literal_type_conv(C, Capability).

find_human_vulnerability_belief(Human, VulnerabilityBelief):-
  rdf_has(VulnerabilityBelief, prl_tak:'hasVulnerabilityBelief', V),

  	literal_type_conv(V, VulnerabilityBelief).


find_user_robot_experience(Human, Robot):-
  rdf_has(Human, prl_tak:'hasExpWith', H),
     
	literal_type_conv(H, Robot).


risky_situation(Artifact, Situation):-

  rdf_has(Situation, prl_tak:'hasRiskyPart', S),

	literal_type_conv(S, Artifact).


