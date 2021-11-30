# TrustOntology
Copyright © 2021 by Imperial College London (ICL), Personal Robotics Lab (PRL). The ontology model represents ontological knowledge for Trust in order to provide better assessment/evaluation for domains that include humans and robots interacting with each other.
# Installation
1.  Create a virtual environment (this will create /pyswip_env in the current directory):  
    `python3 -m venv pyswip_env`
1.  Activate the virtual environment (activation is necessary for every new terminal):  
    `source pyswip_env/bin/activate`
1.  Install swi-prolog:  
    `sudo apt install swi-prolog`
1.  After installation, clone pmk_python_interface repository into the same directory where /pyswip_env is placed:  
    `git clone https://gitioc.upc.edu/fatma.nur/pmk_python_interface.git`
1.  Go inside /pmk_python_interface and Install PySWIP:  
    `pip install pyswip` 
    
# Parsing the ontology
    You need to parse the directory of the owl by adapting the current location of the owl file in the prolog file. For instance, to adapt the trust_architecture.owl file into the trust.pl file, you can parse the owl link or to locally set the package directory as shown in the following figure.
       

![prl_tak](https://user-images.githubusercontent.com/36643532/144042836-c6b52aa1-e360-427f-b442-93bd8d738d95.png)

and then, in the in the python wrapper we can set the directory of the owl file

![python_wrapper](https://user-images.githubusercontent.com/36643532/144042993-4d72914a-31c1-45d4-b353-7cb71013567b.png)

# Trust ontology registration
In order to have a registered name to query over the trust ontology, the registration name `prl_tak` is established.

`:- rdf_db:rdf_register_ns(prl_tak, 'https://juicer.ee.imperial.ac.uk:8443/trust.owl#', [keep(true)]).`

prl stands for Personal Robotics Lab, and the tak stands for Trust Architecture Knowledge.

# How to use Trust predicates?
1. Go to the directory of prolog folder 
2. Call the SWI-Prolog library `swipl`
3. Call the file that contains the predicates `[trust].`

# How to retrieve/reason over the trust ontology?
Simply, you can use one of the simple predicates implemented in the trust.pl file to retrieve information regarding the robot and its capability, object and the risky objects.
For instance, to reason on which robot exist in the current room, you can type this predicate in the terminal: 

`find_robot(Room, Robot).`


# Links of the dependancies


Link for INSTALLATION of PySWIP steps: https://github.com/yuce/pyswip/blob/master/INSTALL.md

GitHub repository link for PySWIP package: https://github.com/yuce/pyswip This link provides more example python codes and .pl files

