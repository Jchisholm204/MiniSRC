import csv

# This file modifies the intel pin_assignments file to make it how I like it
# Some exeptions:
#     Buttons are still an array so that sucks
#     I only wrote this for one program
#     Some assignments may needed to be deleted out of quartus afterwards

with open('miniSRC_pins.csv', 'w', newline='') as wfile:
    writer  = csv.writer(wfile)
    writer.writerow(['To', 'Location'])
    with open('DE2_pin_assignments.csv', 'r', newline='') as file:
        reader = csv.reader(file, delimiter=' ', quotechar='|')
        for row in reader:
            assignment = row[0].split(',')
            if assignment[0].startswith("HEX") or assignment[0].startswith("LED"):
                assignment[0] = f"o{assignment[0]}"
                writer.writerow([assignment[0], assignment[1]])
            if assignment[0].startswith("KEY") or assignment[0].startswith("SW"):
                assignment[0] = f"i{assignment[0]}"
                writer.writerow([assignment[0], assignment[1]])
            if assignment[0].startswith("CLOCK"):
                assignment[0] = assignment[0].replace("CLOCK", "iCLK")
                # assignment[0] = f"i{assignment[0]}"
                writer.writerow([assignment[0], assignment[1]])
            if assignment[0].startswith("VGA") or assignment[0].startswith("LCD"):
                assignment[0] = f"{assignment[0]}"
                writer.writerow([assignment[0], assignment[1]])