#Create the waves db
database -open -shm waves -default

#Porbe the waves
probe -create -shm -all -depth all

#Run the simulation
run
