
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
 find_robot(r,r),
 find_robot_cap(r,r),
 find_user_robot_experience(r,r),
 risky_situation(r,r),
 trust(r,r).

%Parsing the pmk ontology [to be modified by the user to access his/her ontology].

:- rdf_load('/home/diab/trust_ws/src/pmk_python_interface/ontologies/trust.owl').

:- rdf_db:rdf_register_ns(sir_pmk, 'https://juicer.ee.imperial.ac.uk:8443/trust.owl#', [keep(true)]).

%%%%%%%%%%%%% PROLOG FEATURES %%%%%%%%%%%%

   find_subclass(Class, SubClass):- %question
   rdfs_subclass_of(SubClass, Class), %answer
   SubClass \= Class.

%Removing unnecessary string in literal when reading data values in order to extract only value.

 literal_type_conv(literal(type(_, V)), Value):- atom_to_term(V, Value, _), !.
 literal_type_conv(Value, Value).

%%%%%%%%%%%% READING DATA PROPERTIES FROM THE OWL %%%%%%%%%%%%%

find_robot(Room, Robot):-
 rdf_has(Room, sir_pmk:'hasRobot', R),

	literal_type_conv(R, Robot).

find_robot_cap(Robot, Capability):-
  rdf_has(Robot, sir_pmk:'hasCapability', C),

	literal_type_conv(C, Capability).


find_user_robot_experience(Human, Robot):-
  rdf_has(Human, sir_pmk:'hasExpWith', H),
     
	literal_type_conv(H, Robot).


risky_situation(Artifact, Situation):-

  rdf_has(Situation, sir_pmk:'hasRiskyPart', S),

	literal_type_conv(S, Artifact).


