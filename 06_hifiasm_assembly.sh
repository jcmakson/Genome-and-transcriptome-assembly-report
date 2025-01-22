#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=256G
#SBATCH --time=3-00:00:00
#SBATCH --job-name=hifiasm_assembly
#SBATCH --mail-user=jean.makangara@unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jmakangara/assembly_annotation_course/errors/hifiasm_assembly_%j.o
#SBATCH --error=/data/users/jmakangara/assembly_annotation_course/errors/error_hifiasm_assembly_%j.e
#SBATCH --partition=pibu_el8

#laod module for de novo assembly using hifiasm

#module avail # to check the correct module 

module load hifiasm/0.16.1-GCCcore-10.3.0

#Input and output data

OUTPUT_DIR=/data/users/jmakangara/assembly_annotation_course/assemblies/hifiasm/hifiasm_2
INPUT_DIR=/data/users/jmakangara/assembly_annotation_course/read_QC/fastp

# Create output directory if it does not exist

mkdir -p $OUTPUT_DIR

# run hifiasm assembly 

hifiasm -o $OUTPUT_DIR/ERR11437311.asm -t 16 $INPUT_DIR/ERR11437311_trimmed.fastq.gz 

# Convert the GFA files to Fasta format

cd $OUTPUT_DIR

for file in *.gfa; do
    awk '/^S/{print ">"$2; print $3}' "$file" > "${file%.gfa}.fa"
done