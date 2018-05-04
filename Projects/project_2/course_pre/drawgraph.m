function [graph] = drawgraph( m_digraph )
    % Draws a graph using its digraph 
    nNodes = numnodes(m_digraph);
    adj_mat = zeros(nNodes);
    for e = 1:size(m_digraph.Edges,1)
        [nodeA,nodeB] = findedge(m_digraph,e);
        adj_mat(nodeA,nodeB) = m_digraph.Edges.Weight(e);
    end
            
    graph = biograph(adj_mat);    
    graph.EdgeType = 'straight';
    graph.NodeAutoSize = 'on';    
    graph.EdgeType = 'curved';
    graph.ShowWeights = 'on';
    nodes = get(graph, 'Nodes');
    
    
    for i = 1:nNodes        
        nodes(i).ID = cell2mat(m_digraph.Nodes.Name(i));
        nodes(i).Label = cell2mat(m_digraph.Nodes.Name(i));
        nodes(i).Shape = 'circle';        
        nodes(i).Color = [1 1 1];        
        nodes(i).LineColor = [0 0 0];
        nodes(i).TextColor = [0 0 1];
        nodes(i).LineWidth = 2;        
    end

    edges = get(graph, 'Edges');
    for i = 1:length(edges)
        edges(i).LineColor = [0 0 0];
    end
    view(graph);
end
