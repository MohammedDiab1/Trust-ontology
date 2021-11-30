from __future__ import print_function
from pyswip.prolog import Prolog
import os
from pathlib import Path
import csv

path = Path(os.path.abspath(os.getcwd()))
directory_path = path.parent.absolute()

testPath = os.path.join(directory_path, "tests")
prologPath = os.path.join(directory_path, "prolog")



path = "/home/diab/trust_ws/perception.csv"
file = open(path, newline='')
reader = csv.reader(file)
header = next(reader)
#data = [row for row in reader]

print (header)
#header[1].strip().split(',')

def main():
    #a Prolog class instance is created
    prolog = Prolog()

    #an existing prolog file is consulted
    prolog.consult(prologPath + "/trust.pl")

    # When using SWIPL in the terminal we were calling the individuals or classes as sir_pmk:'Room_A'
    # In this case we should replace sir_pmk with the ontology URL and add the individual or the class name after the '#' character like below
    sir_pmk = "'https://juicer.ee.imperial.ac.uk:8443/trust.owl#"
    room = sir_pmk + "Room_B'"

    # Print all the query returns for the chosen predicate, which is find_robot() in this case
    # We are providing an input to the predicate, which is the room variable created above, the return is the existing robot in the given room
    print(list(prolog.query('find_robot(%s,Robot).' % room)))

    # We can also retrieve only the individual name from the response, the following code piece splits the response and prints only the robot name
    for i,soln in enumerate(prolog.query('find_robot(%s,Robot).' % room)):
         robot = soln["Robot"]
         out = robot.split("#")
         print(i, end=" ")
         print("The robot %s is in the roomB" % out[1])

    Robot = sir_pmk + "icub'"

   # Print all the query returns for the chosen predicate, which is find_robot() in this case
    # We are providing an input to the predicate, which is the room variable created above, the return is the existing robot in the given room
    print(list(prolog.query('find_robot_cap(%s, Capability).' % Robot)))

   # We can also retrieve only the individual name from the response, the following code piece splits the response and prints only the robot name
    for i,soln in enumerate(prolog.query('find_robot_cap(%s, Capability).' % Robot)):
         Robot = soln["Capability"]
         out = Robot.split("#")
         print(i, end=" ")
         print("Robot can execute %s" % out[1])


    User = sir_pmk + "mohammed'"

   # Print all the query returns for the chosen predicate, which is find_robot() in this case
    # We are providing an input to the predicate, which is the room variable created above, the return is the existing robot in the given room
    print(list(prolog.query('find_user_robot_experience(%s, Robot).' % User)))

   # We can also retrieve only the individual name from the response, the following code piece splits the response and prints only the robot name
    for i,soln in enumerate(prolog.query('find_user_robot_experience(%s, Robot).' % User)):
         User = soln["Robot"]
         out = User.split("#")
         print(i, end=" ")
         print("Mohammed has experience with %s" % out[1])

    		
    Artifact = print (header[1])
   # Print all the query returns for the chosen predicate, which is find_robot() in this case
    # We are providing an input to the predicate, which is the room variable created above, the return is the existing robot in the given room
    print(list(prolog.query('risky_situation(%s, Situation).' % Artifact)))

   # We can also retrieve only the individual name from the response, the following code piece splits the response and prints only the robot name
    for i,soln in enumerate(prolog.query('risky_situation(%s, Situation).' % Artifact)):
         x = soln["Situation"]
         out = x.split("#")
         print(i, end=" ")
         print("Situation %s is a risky situation" % out[1])


if __name__ == "__main__":
    main()
