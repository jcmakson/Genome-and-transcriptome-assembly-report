#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastP
#SBATCH --mail-user=jean.makangara@unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jmakangara/assembly_annotation_course/errors/fastp_%j.o
#SBATCH --error=/data/users/jmakangara/assembly_annotation_course/errors/error_fastp_%j.e
#SBATCH --partition=pibu_el8

#laod module for quality control using fastp filter
#module avail # to check the correct module 

module load fastp/0.23.4-GCC-10.3.0


#Input and output data

OUTPUT_DIR=/data/users/jmakangara/assembly_annotation_course/read_QC/fastp
INPUT_DIR=/data/users/jmakangara/assembly_annotation_course/raw_data

# Create output directory if it does not exist 

mkdir -p $OUTPUT_DIR

# run fastp script for the two datasets 

# Run fastp for the two datasets

# First dataset (Mh-0)
fastp -i $INPUT_DIR/Mh-0/*.fastq.gz \
      -o $OUTPUT_DIR/ERR11437311_trimmed.fastq.gz \
      -h $OUTPUT_DIR/ERR11437311_fastp.html \
      -j $OUTPUT_DIR/ERR11437311_fastp.json

# Second dataset (RNAseq_Sha)
fastp -i $INPUT_DIR/RNAseq_Sha/ERR754081_1.fastq.gz \
      -I $INPUT_DIR/RNAseq_Sha/ERR754081_2.fastq.gz \
      -o $OUTPUT_DIR/ERR754081_1_trimmed.fastq.gz \
      -O $OUTPUT_DIR/ERR754081_2_trimmed.fastq.gz \
      -h $OUTPUT_DIR/ERR754081_fastp.html \
      -j $OUTPUT_DIR/ERR754081_fastp.json