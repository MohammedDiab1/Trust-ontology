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
 who_has_belief(r,r),
 find_task_with_human(r,r),
 find_human_belief(r,r),
 find_goal(r,r),
 find_intention(r,r,r,r,r),
 find_robot_capability(r,r),
 which_robot_has_capability(r,r),
 find_vulnerability(r,r),
 find_threat(r,r),
 find_vul_from_threat(r,r,r,r),
 find_vulnerability(r,r,r,r),
 find_user_robot_experience(r,r),
 risky_situation(r,r),
 trust(r,r).

%Parsing the pmk ontology [to be modified by the user to access his/her ontology].

:- rdf_load('/home/kinova/trust_ws/src/Trust-ontology/owl/organizing_table.owl').

:- rdf_db:rdf_register_ns(prl_tak, 'http://www.ease-crc.org/ont/organizing_table.owl#', [keep(true)]).

%%%%%%%%%%%%% PROLOG FEATURES %%%%%%%%%%%%

   find_subclass(Class, SubClass):- %question
   rdfs_subclass_of(SubClass, Class), %answer
   SubClass \= Class.

%Removing unnecessary string in literal when reading data values in order to extract only value.

 literal_type_conv(literal(type(_, V)), Value):- atom_to_term(V, Value, _), !.
 literal_type_conv(Value, Value).

%%%%%%%%%%%% REASONING OVER THE OWL KNOWLEDGE %%%%%%%%%%%%%

%%%%%%%%%%%% Belief, Goal and Intention %%%%%%%%%%%%%%%%%%%%

who_has_belief(Human, Belief):-
    rdf_has(Belief, prl_tak:'hasBelief', R),

    	literal_type_conv(R, Human).


find_task_with_human(Task, Human):-
    rdf_has(Human, prl_tak:'hasSubTask', T),

	literal_type_conv(T, Task).

find_human_belief(Human, Belief):-
    rdf_has(Human, prl_tak:'belief', B),

	literal_type_conv(B, Belief).

find_goal(Robot, Goal):-
    rdf_has(Robot, prl_tak:'goal', G),

	literal_type_conv(G, Goal).


find_intention(Intention, BeliefOf, Belief, Goal, Type):-
    (rdf_has(Intention, prl_tak:'isIntentionOf', R) -> literal_type_conv(R, BeliefOf); true),
    (rdf_has(Intention, prl_tak:'hasBelief', B) -> literal_type_conv(B, Belief); true),
    (rdf_has(Intention, prl_tak:'hasConGoal', V) -> literal_type_conv(V, Goal); true),
     rdf_has(Intention, rdf:type, T),

	literal_type_conv(T, Type).
  	
%%%%%%%%%%%%%%%%%% ROBOT CAPABILITY %%%%%%%%%%%%%%%%%%%%
find_robot_capability(Robot, Capability):-
    rdf_has(Robot, prl_tak:'capability', A),

	literal_type_conv(A, Capability).


which_robot_has_capability(Robot, CapabilityOf):-
    rdf_has(Robot, prl_tak:'hasCapability', C),

	literal_type_conv(C, CapabilityOf).

%%%%%%%%%%%%%%%%%% Threat, Vulnerability and Risk %%%%%%%%%%%%%%%%%%%%
%which Event has threat?
find_threat(Event, Threat):-
    rdf_has(Event, prl_tak:'threat', Th),
	
	literal_type_conv(Th, Threat).

%does this threat leads to vulnerability?
find_vul_from_threat(Event, Threat, Agent, Type):-
    (rdf_has(Event, prl_tak:'threat', Th) -> literal_type_conv(Th, Threat); true),
    (rdf_has(Event, prl_tak:'hasNoCapability', Ca) -> literal_type_conv(Ca, Agent); true),
     rdf_has(Event, rdf:type, T),

	literal_type_conv(T, Type).



find_vulnerability(Vulnerability, Agent, Threat, Type):-
    (rdf_has(Vulnerability, prl_tak:'isIntroducedBy', Th) -> literal_type_conv(Th, Threat); true),
    

    (rdf_has(Agent, prl_tak:'vulnerability', Vu) -> literal_type_conv(Vu, Vulnerability); true),
     rdf_has(Agent, rdf:type, Ty),
	
	literal_type_conv(Ty, Type).



