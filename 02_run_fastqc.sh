#!/usr/bin/env apptainer

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=jean.makangara@unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jmakangara/assembly_annotation_course/errors/fastqc_%j.o
#SBATCH --error=/data/users/jmakangara/assembly_annotation_course/errors/error_fastqc_%j.e
#SBATCH --partition=pibu_el8

#laod module for quality control fastQC and MutliQC
#module avail # to check the correct module 

module load FastQC/0.11.9-Java-11;
module load MultiQC/1.11-foss-2021a

#variables
QUALITY_CONTROL_DIR=/data/users/jmakangara/assembly_annotation_course/read_QC/fastqc
INPUT_DIR=/data/users/jmakangara/assembly_annotation_course/raw_data

# create output directory if it does not exist 

mkdir $QUALITY_CONTROL_DIR

# run quality control using FastQC and summarize using MultiQC

fastqc  ${INPUT_DIR}/Mh-0/*.fastq.gz ${INPUT_DIR}/RNAseq_Sha/*.fastq.gz \
 --t 4 \
 --outdir $QUALITY_CONTROL_DIR

cd $QUALITY_CONTROL_DIR
multiqc .
