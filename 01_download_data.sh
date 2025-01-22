#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=01:00:00
#SBATCH --job-name=raw_reads
#SBATCH --mail-user=jean.makangara@unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jmakangara/assembly_annotation_course/errors/raw_reads_%j.o
#SBATCH --error=/data/users/jmakangara/assembly_annotation_course/errors/error_raw_reads_%j.e
#SBATCH --partition=pibu_el8

# genrate a link to the directory with reads

cd /data/users/jmakangara/assembly_annotation_course/raw_data
ln -s /data/courses/assembly-annotation-course/raw_data/Mh-0/ ./
ln -s /data/courses/assembly-annotation-course/raw_data/RNAseq_Sha ./