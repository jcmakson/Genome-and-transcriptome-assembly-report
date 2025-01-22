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

# load module BUSCO 

module load BUSCO/5.4.2-foss-2021a

# set a working directory 

WORKING_DIR=/data/users/jmakangara/assembly_annotation_course/BUSCO
cd $WORKING_DIR

# Set variables for common BUSCO parameters
#LINEAGE="brassicales_odb10"  # Change this to appropriate lineage
THREADS=$SLURM_CPUS_PER_TASK
CONTAINER_IMAGE="/containers/apptainer/busco_5.7.1.sif"  # Path to the BUSCO Apptainer image
OUTDIR_1=/data/users/jmakangara/assembly_annotation_course/BUSCO/flye_evaluation
OUTDIR_2=/data/users/jmakangara/assembly_annotation_course/BUSCO/hifiam_evalaution
OUTDIR_3=/data/users/jmakangara/assembly_annotation_course/BUSCO/lja_evalaution
OUTDIR_4=/data/users/jmakangara/assembly_annotation_course/BUSCO/trinity_evaluation


# Create output directory if not already present
mkdir -p $OUTDIR_1 $OUTDIR_2 $OUTDIR_3 $OUTDIR_4


# # Run BUSCO - comment this out when you need to run Busco for genome for lja

cd /data/users/jmakangara/assembly_annotation_course/assemblies/lja_assembly/
busco -i assembly.fasta --auto-lineage -o $OUTDIR_3 -m genome --cpu $THREADS -f