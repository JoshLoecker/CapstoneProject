"""
This file will compare the MD5 sum files generated between snakemake and bash
Things to compare
1 - Sums between bash/snakemake
    a) Bash core 1 vs Snakemake core 1
    b) Bash core 2 vs Snakemake core 2

2 - Sums within program
    a) Snakemake core 1 vs Snakemake core 2
    b) Snakemake core 1 vs Snakemake core 3
    c) Snakemake core 2 vs Snakemake core 3
    d) Bash Core 1 vs Bash core 2
    e) Bash core 1 vs Bash core 3
    f) Bash core 2 vs Bash core 3


Sum files have the following format
[SUM] [FILE_NAME]

Splitting by 'space' and taking first result will allow for sum only to be taken
"""

import filecmp
import hashlib

lines = open("/Users/joshl/PycharmProjects/CapstoneProject/results/snakemake/md5/bam/core.count.1", "r").readlines()
x = ""
x.join(lines)
print(hashlib.md5(x.encode('utf-8')).hexdigest())

