#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=128G
#SBATCH --time=3-00:00:00
#SBATCH --job-name=Merqury
#SBATCH --mail-user=jean.makangara@unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jmakangara/assembly_annotation_course/errors/Merqury_%j.o
#SBATCH --error=/data/users/jmakangara/assembly_annotation_course/errors/error_Merqury_%j.e
#SBATCH --partition=pibu_el8

#input and output parameters 

WORKDIR=/data/users/jmakangara/assembly_annotation_course
OUTDIR=$WORKDIR/mercury
FLYE=$WORKDIR/assemblies/flye/flye_assembly.fasta
HIFIASM=$WORKDIR/assemblies/hifiasm/hifiasm_2/ERR11437311.asm.bp.p_ctg.fa
LJA=$WORKDIR/assemblies/lja_assembly/assembly.fasta 
FLYERES=$OUTDIR/flye
HIFIRES=$OUTDIR/hifiasm
LJARES=$OUTDIR/LJA

mkdir -p $OUTDIR $FLYERES $HIFIRES $LJARES

export MERQURY="/usr/local/share/merqury"

# find best kmer size
# apptainer exec \
# --bind $WORKDIR \
# /containers/apptainer/merqury_1.3.sif \
# $MERQURY/best_k.sh 135000000
# k = 18.4864
k=19

# build kmer dbs
apptainer exec \
--bind $WORKDIR \
/containers/apptainer/merqury_1.3.sif \
meryl k=$k count /data/users/jmakangara/assembly_annotation_course/read_QC/fastp/ERR11437311_trimmed.fastq.gz output $OUTDIR/meryl
#done

#run merqury
#flye
cd /data/users/jmakangara/assembly_annotation_course/mercury/flye
apptainer exec \
--bind /data \
/containers/apptainer/merqury_1.3.sif \
merqury.sh /data/users/jmakangara/assembly_annotation_course/mercury/meryl $FLYE eval_flye  

#hifiasm
cd /data/users/jmakangara/assembly_annotation_course/mercury/hifiasm
apptainer exec \
--bind /data \
/containers/apptainer/merqury_1.3.sif \
merqury.sh /data/users/jmakangara/assembly_annotation_course/mercury/meryl $HIFIASM eval_hifiasm  

#lja
cd /data/users/jmakangara/assembly_annotation_course/mercury/LJA
apptainer exec \
--bind /data \
/containers/apptainer/merqury_1.3.sif \
merqury.sh /data/users/jmakangara/assembly_annotation_course/mercury/meryl $LJA eval_lja