print("hello world")
#this is a comment, it will be ignored by the computer
print("comments are very useful")
print("hello\nworld") #\n splits the line
#a short DNA sequence in the varaible my_dna
my_dna= "ATGCGTA"
print(my_dna)
my_dna= "AATT" + "GGCC" #concatenate two strings using +
print(my_dna)
upstream= "AAA"
my_dna= upstream + "ATGC" #my_dna is now "AAAATGC"
print(my_dna)
upstream= "AAA"
downstream= "GGG"
my_dna= upstream + downstream + "ATGC"
print(my_dna)
#finding the length of a string
#this line doesnt produce any output
len("ATCG")
dna_length=len("ATCG")
print(dna_length) #calculates the length of charecter strings in a variable
#the function str() turns a number into a string so that we can print it
my_dna="ATGCGAGT"
dna_length= len(my_dna)
print("the length of my dna is " + str(dna_length))
#int() turn string into a number
number=3 +int('4')
#lower() is a string type
my_dna= "ATGC"
#print my_dna in lower case: variable.method()
print(my_dna.lower())
my_dna= "ATGC"
print("before: " + my_dna)
lowercase_dna= my_dna.lower()
print("after: " + my_dna)
#replace() another string type
protein= "vlspadktnv"
#replace valine with tyrosine
print(protein.replace("v","y"))
#replacing more than one charecter
print(protein.replace("vls", "ymt"))
#original var is not affected
print(protein)
#substrings
protein= "vlspadktnv"
print(protein[3:5]) #print positions 3-5
print(protein[0:6]) #print positons 0 to 6
print(protein[2:])
#counting and finding substrings
#couting the amount of times a substring occurs in a string using count()
protein= "vlspadktnv"
#count amino acid residues
valine_count=protein.count('v')
lsp_count= protein.count('lsp')
tryptophan_count= protein.count('w')
print("valines: " + str(valine_count))
print("lsp: " + str(lsp_count))
print("tryptophan: " + str(tryptophan_count))
#find() finds substrings in a string; the index of a substring
protein= "vlspadktnv"
print(str(protein.find('p')))
print(str(protein.find('kt'))) #requires at least two strings to work
print(str(protein.find('w'))) #doesnt exist

# Calculating AT content

dna = "ACTGATCGATTACGTATAGTATTTGCTATCATACATATATATCGATGCGTTCAT"
dna_length= len(dna)
print("length: " + str(dna_length))
a_count= dna.count("A")
print("A content: " + str(a_count))
t_count= dna.count("T")
print("T content: " + str(t_count))
AT_content= a_count + t_count/ dna_length
print("AT content is: " + str(AT_content))

print("length: " + str(dna_length))
c_count= dna.count("C")
print("C content: " + str(c_count))
g_count= dna.count("G")
print("G content: " + str(g_count))
GC_content= g_count + c_count/ dna_length
print("GC content is: " + str(GC_content))


# Complementing DNA

dna = "ACTGATCGATTACGTATAGTATTTGCTATCATACATATATATCGATGCGTTCAT"






# Restriction fragment lengths

dna = "ACTGATCGATTACGTATAGTAGAATTCTATCATACATATATATCGATGCGTTCAT"

# Splicing out introns

genomic_dna = "ATCGATCGATCGATCGACTGACTAGTCATAGCTATGCATGTAGCTACTCGATCGATCGATCGATCGATCGATCGATCGATCGATCATGCTATCATCGATCGATATCGATGCATCGACTACTAT"







import gzip
import csv
f = gzip.open('GSE71562_E14R012_raw_counts.gz', mode='rt')
csvobj = csv.reader(f,delimiter = ',',quotechar="'")


print(csvobj)







