#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=512G
#SBATCH --time=3-00:00:00
#SBATCH --job-name=comparing_genome
#SBATCH --mail-user=jean.makangara@unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jmakangara/assembly_annotation_course/errors/comparing_genome_%j.o
#SBATCH --error=/data/users/jmakangara/assembly_annotation_course/errors/error_comparing_genome_%j.e
#SBATCH --partition=pibu_el8

# Input parameters as arguments

WORKDIR=/data/users/jmakangara/assembly_annotation_course
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
OUTDIR=$WORKDIR/genomes_comparative
FLYE=$WORKDIR/assemblies/flye/flye_assembly.fasta
HIFIASM=$WORKDIR/assemblies/hifiasm/hifiasm_2/ERR11437311.asm.bp.p_ctg.fa
LJA=$WORKDIR/assemblies/lja_assembly/assembly.fasta

mkdir -p $OUTDIR


# run nucmer
flye
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
nucmer --prefix genome_flye --breaklen 1000 --mincluster 1000 --threads $SLURM_CPUS_PER_TASK $REF $FLYE 

# hifiasm
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
nucmer --prefix genome_hifiasm --breaklen 1000 --mincluster 1000 --threads $SLURM_CPUS_PER_TASK $REF $HIFIASM 

# lja
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
nucmer --prefix genome_LJA --breaklen 1000 --mincluster 1000 --threads $SLURM_CPUS_PER_TASK $REF $LJA 


## run mummer
# flye
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
mummerplot -R $REF -Q $FLYE -breaklen 1000 --filter -t png --large --layout --fat -p $OUTDIR/flye  genome_flye.delta

# hifiasm
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
mummerplot -R $REF -Q $HIFIASM -breaklen 1000 --filter -t png --large --layout --fat -p $OUTDIR/hifiasm  genome_hifiasm.delta

# lja
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
mummerplot -R $REF -Q $LJA -breaklen 1000 --filter -t png --large --layout --fat -p $OUTDIR/LJA  genome_LJA.delta