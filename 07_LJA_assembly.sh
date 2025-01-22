#!/usr/bin/env bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=512G
#SBATCH --time=3-00:00:00
#SBATCH --job-name=LJA
#SBATCH --mail-user=jean.makangara@unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/jmakangara/assembly_annotation_course/errors/LJA_%j.o
#SBATCH --error=/data/users/jmakangara/assembly_annotation_course/errors/LJA_%j.e
#SBATCH --partition=pibu_el8

# Define directories
WORKDIR=/data/users/jmakangara/assembly_annotation_course
INPUT_DIR=${WORKDIR}/read_QC/fastp
OUTPUT_DIR=${WORKDIR}/assemblies/lja_assembly_2  # Changed to a results directory
CONTAINER=/containers/apptainer/lja-0.2.sif

# Create output directory
mkdir -p $OUTPUT_DIR

# Print directory information for debugging
echo "Working directory: $WORKDIR"
echo "Input directory: $INPUT_DIR"
echo "Output directory: $OUTPUT_DIR"

# Check if input file exists
if [ ! -f "${INPUT_DIR}/ERR11437311_trimmed.fastq.gz" ]; then
    echo "Error: Input file not found: ${INPUT_DIR}/ERR11437311_trimmed.fastq.gz"
    exit 1
fi

# Move to working directory
cd $WORKDIR

# Run LJA assembly
echo "Starting LJA assembly..."
apptainer exec $CONTAINER \
    lja \
    -o $OUTPUT_DIR \
    --reads ${INPUT_DIR}/ERR11437311_trimmed.fastq.gz \
    --diploid \
    --threads $SLURM_CPUS_PER_TASK

echo "LJA assembly completed"