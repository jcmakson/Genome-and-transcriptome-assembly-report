#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=128G
#SBATCH --time=3-00:00:00
#SBATCH --job-name=QUAST
#SBATCH --mail-user=jean.makangara@unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jmakangara/assembly_annotation_course/errors/QUAST_%j.o
#SBATCH --error=/data/users/jmakangara/assembly_annotation_course/errors/error_QUAST_%j.e
#SBATCH --partition=pibu_el8


#Input parameters

WORKDIR=/data/users/jmakangara/assembly_annotation_course/assemblies/quast_input
OUTDIR=/data/users/jmakangara/assembly_annotation_course/QUAST/results/quast_without_ref_3

#Give permission to access files 
chmod u+r $WORKDIR/flye_assembly.fasta
chmod u+r $WORKDIR/ERR11437311.asm.bp.p_ctg.fa
chmod u+w $OUTDIR


mkdir -p $OUTDIR

# Run QUAST based on reference usage

cd $WORKDIR

apptainer exec --bind /data /containers/apptainer/quast_5.2.0.sif \
quast.py \
--eukaryote \
--large \
--threads 16 \
--labels Flye,Hifiasm,LJA  \
--est-ref-size 135000000 \
--threads $SLURM_CPUS_PER_TASK \
 $WORKDIR/flye_assembly.fasta \
 $WORKDIR/ERR11437311.asm.bp.p_ctg.fa \
 $WORKDIR/assembly.fasta \
-o $OUTDIR


