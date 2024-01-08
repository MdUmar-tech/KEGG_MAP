#these two line changed from main code 
#current_c_line = re.sub(r'^C\s+\d\s+', '', line) #extra plus is there
#ko = ko.split()[0]  # Split "KO" to get the first part


import pandas as pd
import re

# Read the data from the file
with open('ko00001.keg', 'r') as file:
    data = file.read()

# Split the data into lines
lines = data.split('\n')

in_list = False
data_dict = {"Group": [], "Section": [], "C_Line": [], "KO": [], "Description": []}
current_group = ""
current_section = ""
current_c_line = ""
current_d_lines = []

for line in lines:
    line = line.strip()
    if line.endswith('['):
        in_list = True
    elif line.endswith(']') or line.endswith('],'):
        in_list = False
    if in_list:
        line += ','
    if line.startswith("A"):
        current_group = re.sub(r'^A\d+\s+', '', line)
    elif line.startswith("B"):
        current_section = re.sub(r'^B\s+\d+\s+', '', line)
    elif line.startswith("C"):
        current_c_line = re.sub(r'^C\s+\d\s+', '', line)  # Remove 'C', numbers, and spaces from the beginning
        current_c_line = re.sub(r'\[.*\]$', '', current_c_line)  # Remove square brackets and their content
    elif line.startswith("D"):
        d_line = re.sub(r'^D\s+', '', line)
        m = re.match(r'^\s*(K\d+)\s+(.*?)(?:\s+\[EC:(.*?)\])?$', d_line)
        if m:
            ko, description, ec = m.groups()
            ko = ko.split()[0]  # Split "KO" to get the first part
            data_dict["Group"].append(current_group)
            data_dict["Section"].append(current_section)
            data_dict["C_Line"].append(current_c_line)
            data_dict["KO"].append(ko)
            data_dict["Description"].append(description)

df = pd.DataFrame(data_dict)
print(df)
df.to_csv('data.tsv', sep='\t', index=False)
