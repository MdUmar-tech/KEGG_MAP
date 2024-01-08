import pandas as pd
import re

# Read the data from the file
with open('ko00001.keg', 'r') as file:
    data = file.read()

lines = data.split('\n')

result = []

ko = None
unique_ko_hierarchy = {}

current_hierarchy = []
current_group = None

for line in lines:
    parts = line.strip().split()
    if parts:
        if parts[0].startswith('A'):
            current_group = " ".join(parts[1:])
        elif parts[0].startswith('B'):
            current_hierarchy = [current_group, " ".join(parts[2:])]
        elif parts[0] == 'K':
            ko = parts[1]
            description = " ".join(parts[2:])
            if ko in unique_ko_hierarchy:
                unique_ko_hierarchy[ko]["metadata_KEGG_Pathways"].append(";".join(current_hierarchy))
            else:
                unique_ko_hierarchy[ko] = {
                    "metadata_KEGG_Description": description,
                    "metadata_KEGG_Pathways": [";".join(current_hierarchy)],
                }
        elif parts[0] == 'D' and len(parts) >= 3:
            ko = parts[1]
            description = " ".join(parts[2:])
            if ko in unique_ko_hierarchy:
                unique_ko_hierarchy[ko]["metadata_KEGG_Pathways"].append(";".join(current_hierarchy))
            else:
                unique_ko_hierarchy[ko] = {
                    "metadata_KEGG_Description": description,
                    "metadata_KEGG_Pathways": [";".join(current_hierarchy)],
                }
        else:
            current_hierarchy.append(" ".join(parts[2:]))

# Add the header row
result.append(["KO", "metadata_KEGG_Description", "metadata_KEGG_Pathways", "clean_KEGG_Pathways"])

# Add the header row
result.append(["KO", "metadata_KEGG_Description", "metadata_KEGG_Pathways", "clean_KEGG_Pathways"])

for ko, data in unique_ko_hierarchy.items():
    # Remove "00010" and "[PATH:ko00010]" from the pathway string
    pathways = [pathway.replace("00010", "").split('[PATH:')[0] for pathway in data["metadata_KEGG_Pathways"]]
    
    # Split the pathways into categories and create a nested list
    categories = [pathway.split(";") for pathway in pathways]
    #print(categories)
    result.append([ko, data["metadata_KEGG_Description"], "|".join(pathways), categories])

#print(result)

tsv_filename = "output_data_with_formatted_pathways.tsv"

with open(tsv_filename, 'w') as tsv_file:
    for row in result[1:]: 
        # Create a separate list for writing to the TSV file
        write_row = row[:3]  # The first three elements of the original 'row' list
        
        # Get the categories list from row[3]
        categories_list = row[3]
        
        # Convert the categories_list into the desired format
        categories_str = str(categories_list)
        write_row.append(categories_str)
        
        tsv_file.write("\t".join(map(str, write_row)) + "\n")

print(f"Data saved to {tsv_filename}")
