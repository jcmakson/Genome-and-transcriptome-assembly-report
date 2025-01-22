#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=kmer_count
#SBATCH --mail-user=jean.makangara@unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jmakangara/assembly_annotation_course/errors/kmer_count_%j.o
#SBATCH --error=/data/users/jmakangara/assembly_annotation_course/errors/error_kmer_count_%j.e
#SBATCH --partition=pibu_el8

#laod module for K-mer counting using Jellyfish 

#module avail # to check the correct module 

module load Jellyfish/2.3.0-GCC-10.3.0


#Input and output data

OUTPUT_DIR=/data/users/jmakangara/assembly_annotation_course/read_QC/kmer_counting
INPUT_DIR=/data/users/jmakangara/assembly_annotation_course/raw_data

# Create output directory if it does not exist

mkdir -p $OUTPUT_DIR

# Run Jellyfish k-mer counting for the first dataset (Mh-0)
jellyfish count -m 21 -s 5G -t 4 -C \
-o $OUTPUT_DIR/Mh-0.jf \
<(zcat $INPUT_DIR/Mh-0/*.fastq.gz)

# Create histogram from the Jellyfish output
jellyfish histo -t 10 $OUTPUT_DIR/Mh-0.jf > $OUTPUT_DIR/Mh-0.histo