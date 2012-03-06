f = open('wfs-getfeature.csv')
for line in f:
  split = line.split(";")
  bbox = split[1].strip().split(',')

  print "%s;%s,%s,%s,%s" % (split[0], bbox[1],bbox[0],bbox[3],bbox[2])

