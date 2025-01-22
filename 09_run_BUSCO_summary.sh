#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=256G
#SBATCH --time=3-00:00:00
#SBATCH --job-name=BUSCO_summary
#SBATCH --mail-user=jean.makangara@unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jmakangara/assembly_annotation_course/errors/BUSCO_summ_%j.o
#SBATCH --error=/data/users/jmakangara/assembly_annotation_course/errors/error_BUSCO_summ_%j.e
#SBATCH --partition=pibu_el8

# set a working directory 

WORKING_DIR=/data/users/jmakangara/assembly_annotation_course/BUSCO
cd $WORKING_DIR

# Load BUSCO container
CONTAINER=/containers/apptainer/busco_5.7.1.sif

# run BUSCO summary with existing file

apptainer exec --bind /data $CONTAINER python3 /usr/local/bin/generate_plot.py -wd $WORKING_DIR