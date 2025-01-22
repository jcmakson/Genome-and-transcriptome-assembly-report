#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=512G
#SBATCH --time=3-00:00:00
#SBATCH --job-name=Trinity_assembly
#SBATCH --mail-user=jean.makangara@unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jmakangara/assembly_annotation_course/errors/Trinity_assembly_%j.o
#SBATCH --error=/data/users/jmakangara/assembly_annotation_course/errors/error_Trinity_assembly_%j.e
#SBATCH --partition=pibu_el8

# Load Trinity module 

module load Trinity/2.15.1-foss-2021a

#Input and output data

OUTPUT_DIR=/data/users/jmakangara/assembly_annotation_course/assemblies/Trinity
INPUT_DIR=/data/users/jmakangara/assembly_annotation_course/read_QC/fastp

# Create output directory if it does not exist

mkdir -p $OUTPUT_DIR


 Trinity --seqType fq --left ${INPUT_DIR}/ERR754081_1_trimmed.fastq.gz --right ${INPUT_DIR}/ERR754081_2_trimmed.fastq.gz  \
         --genome_guided_max_intron 10000 \
         --max_memory 256G --CPU 16 \
         --output $OUTPUT_DIR