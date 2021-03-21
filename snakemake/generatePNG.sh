# This script is simply for generating a SVG/PNG of the rules snakemake will perform
#!/bin/bash
snakemake --dag -n | dot -Tsvg > dag.svg
rsvg-convert -h 1000 dag.svg > icon.png
rm dag.svg
