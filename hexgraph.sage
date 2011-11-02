import itertools

def HexGraph(rows, cols, *args, **kwds):
    hexgraph = Graph()
    
    for pt in itertools.product(xrange(rows), xrange(cols)):
        hexgraph.add_vertex(pt)

    for pt in itertools.product(xrange(rows), xrange(cols)):
        #Go up-left
        if kwds.get('toroidal', False) or (pt[0] > 0 and (pt[1] > 0 or pt[0] % 2 == 1)):
        	hexgraph.add_edge(pt, ((pt[0]-1) % rows, (pt[1]-1) % cols if pt[0] % 2 == 0 else pt[1]))
        #Go up-right
        if kwds.get('toroidal', False) or (pt[0] < rows-1 and (pt[1] > 0 or pt[0] % 2 == 1)):
        	hexgraph.add_edge(pt, ((pt[0]+1) % rows, (pt[1]-1) % cols if pt[0] % 2 == 0 else pt[1]))
        #Go up
        if kwds.get('toroidal', False) or pt[1] > 0:
        	hexgraph.add_edge(pt, (pt[0], (pt[1]-1) % cols))
        
    posdict = posdict = dict([(pt, (pt[0] * 30, -1 * pt[1] * 30 if pt[0] % 2 == 0 else -1 * pt[1] * 30 - 15)) for pt in hexgraph.vertices()])    
    hexgraph.set_pos(posdict)
        
    return hexgraph

def ToroidalHexGraph(rows, cols, *args, **kwds):
    kwds['toroidal'] = True
    return HexGraph(rows,cols,*args,**kwds)
