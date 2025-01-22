#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=256G
#SBATCH --time=3-00:00:00
#SBATCH --job-name=BUSCO
#SBATCH --mail-user=jean.makangara@unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jmakangara/assembly_annotation_course/errors/BUSCO_%j.o
#SBATCH --error=/data/users/jmakangara/assembly_annotation_course/errors/error_BUSCO_%j.e
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

# This script runs BUSCO evaluation on a specified assembly file and outputs to a given directory.
# Usage: sbatch run_busco.sh /path/to/assembly.fasta /path/to/output_folder

# Load BUSCO container
CONTAINER=/containers/apptainer/busco_5.7.1.sif

# Create output directory if not already present
mkdir -p $OUTDIR_1 $OUTDIR_2 $OUTDIR_3 $OUTDIR_4


## Run BUSCO - comment this out when you need to run Busco for genome for flye

cd /data/users/jmakangara/assembly_annotation_course/assemblies/flye
apptainer exec --bind/data $CONTAINER busco -i flye_assembly.fasta --auto-lineage -o $OUTDIR_1 -m genome --cpu $THREADS -f

# # Run BUSCO - comment this out when you need to run Busco for genome for hifiasm

cd /data/users/jmakangara/assembly_annotation_course/assemblies/hifiasm/hifiasm_2
apptainer exec --bind /data $CONTAINER busco -i ERR11437311.asm.bp.p_ctg.fa --auto-lineage -o $OUTDIR_2 -m genome --cpu $THREADS -f


# # Run BUSCO - comment this out when you need to run Busco for genome for lja

cd /data/users/jmakangara/assembly_annotation_course/assemblies/lja_assembly/k5001
apptainer exec --bind /data $CONTAINER busco -i final_dbg.fasta --auto-lineage -o $OUTDIR_3 -m genome --cpu $THREADS -f

# Run BUSCO transcriptome for trinity

cd /data/users/jmakangara/assembly_annotation_course/assemblies/trinity
apptainer exec --bind /data $CONTAINER busco -i trinity_assembly.fasta --auto-lineage -o $OUTDIR_4 -m transcriptome --cpu $THREADS -f