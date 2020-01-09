###########################################################
# Usage : For extracting the reaction and gene details using reaction name. 
#Author : sreenath

#########################################################



infile = open('main.txt', 'r')

important = []
keep_phrases = open('reactions_shikimate.txt', 'r')

main = set(infile)
sub = set(keep_phrases)

for line in main:
  for aim in sub:
    if line.startswith(aim.rstrip()):
      important.append(line)
      
      


with open('output_shikimate.txt', 'w') as file_out:
    for line in important:
        file_out.write(line)
        
