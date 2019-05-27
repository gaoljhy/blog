try:
    with open("all.txt" ,"r+") as fp :
        with open("record.md","w+") as wp:
            for alp in fp:
                if alp == "":
                    break
                alp=alp.replace('\n',"")
                wp.write("["+alp+"]("+alp+")\n")
                # wp.flush()
except EOFerror:
    print("get all")