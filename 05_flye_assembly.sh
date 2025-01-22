#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=512G
#SBATCH --time=3-00:00:00
#SBATCH --job-name=flye_assembly
#SBATCH --mail-user=jean.makangara@unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jmakangara/assembly_annotation_course/errors/flye_assembly_%j.o
#SBATCH --error=/data/users/jmakangara/assembly_annotation_course/errors/error_fly_assembly_%j.e
#SBATCH --partition=pibu_el8

#laod module for de novo assembly using flye

#module avail # to check the correct module 

module load Flye/2.9-GCC-10.3.0

#Input and output data

OUTPUT_DIR=/data/users/jmakangara/assembly_annotation_course/assemblies/flye
INPUT_DIR=/data/users/jmakangara/assembly_annotation_course/read_QC/fastp

# Create output directory if it does not exist

mkdir -p $OUTPUT_DIR

# run flye assembly 

flye --pacbio-hifi $INPUT_DIR/ERR11437311_trimmed.fastq.gz \
--out-dir $OUTPUT_DIR \
--genome-size 135M \
--threads 16 #\ # to rerun form the last step, unhache this if the program crashed and rerun the script
#--resume