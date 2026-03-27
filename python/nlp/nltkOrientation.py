for line in open("transvestiaCopy.txt"):
     for word in line.split():
        if word.endswith('ing'):
            print(word)
            
