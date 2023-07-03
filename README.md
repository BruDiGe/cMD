# cMD
Scripts to run conventional MD simulations in AMBER. Includes: 
1.tleap.in file to generate topology and coordinates. 
2.cMD.sh to submit conventional MD. The protocol includes minimization, heating, equilibration, and production. Use change.sh to adjust your number of non-solute residues. Adjust the number of steps and md.in the file for your desired simulated time. Also you can NMR-restraints and PLUMED file.
3. Includes different scripts to analyze the trajectories (includes MM-ISMSA script).
4. Python scripts to plot RMSD and lie analysis.

