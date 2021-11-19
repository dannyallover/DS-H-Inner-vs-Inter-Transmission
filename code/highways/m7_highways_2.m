(* ::Package:: *)

(* ::Title:: *)
(*Highways-2*)


(* ::Section:: *)
(*Now that each transmission is placed in space, we can connect transmissions to form highways. For example, if a->b happened in X and b->c happened in Y (and they share a taraf), then we say that a->b->c constitutes the movement of a hadith from X to Y (or X->Y).*)
(*This notebook connects the transmissions as such (only up to a length of 2).*)


(* ::Input:: *)
(*(** set directory **)*)


(* ::Input:: *)
(*SetDirectory[ParentDirectory[ParentDirectory[NotebookDirectory[]]]];*)


(* ::Input:: *)
(*Directory[];*)


(* ::Input:: *)
(*(*edges in our city-network*)*)


(* ::Input:: *)
(*edges=Flatten[ToExpression[Import["data/base/xxx_city_network_edges.csv","CSV"]]];*)


(* ::Input:: *)
(*edges[[1]]*)


(* ::Input:: *)
(*(*transmission to taraf count*)*)


(* ::Input::SemiBold:: *)
(*edgeToCounts=ToExpression[Import["data/base/xxx_edge_to_isnad_count_hadith_count_taraf_count.csv","CSV"]];*)


(* ::Input::SemiBold:: *)
(*edgeToCounts[[1]]*)


(* ::Input::SemiBold:: *)
(*edgeToTarafCount=Association[Table[edgeToCounts[[i,1]]->edgeToCounts[[i,2,3]],{i,1,Length[edgeToCounts],1}]];*)


(* ::Input:: *)
(*edgeToTarafCount[edges[[1]]]*)


(* ::Input:: *)
(*(** the edges in each isnad **)*)


(* ::Input:: *)
(*isnadsEdges=ToExpression[Import["data/base/xxx_isnad_edges.csv"]];*)


(* ::Input:: *)
(*isnadsEdges[[1]]*)


(* ::Input:: *)
(*(** edge to taraf ids **)*)


(* ::Input:: *)
(*edgesToTarafs=ToExpression[Import["data/base/xxx_edges_taraf_ids.csv","CSV"]];*)


(* ::Input:: *)
(*edgesToTarafs[[1]]*)


(* ::Input:: *)
(*edgesToTarafs=Association[Table[edgesToTarafs[[i,1]]->edgesToTarafs[[i,2]],{i,1,Length[edgesToTarafs],1}]];*)


(* ::Input:: *)
(*edgesToTarafs[edges[[1]]]*)


(* ::Input:: *)
(*(** highways length 2 **)*)


(* ::Input:: *)
(*highways2=Reap[For[i=1,i<=Length[isnadsEdges],i++,*)
(*Sow[Partition[isnadsEdges[[i]],2,1]];*)
(*]][[2]][[1]];*)


(* ::Input:: *)
(*highways2=Flatten[highways2,1];*)


(* ::Input:: *)
(*highways2[[1]]*)


(* ::Input:: *)
(*Length[highways2]*)


(* ::Input:: *)
(*highways2=DeleteDuplicates[highways2];*)


(* ::Input:: *)
(*Length[highways2]*)


(* ::Input:: *)
(*(** take out all the highways that have edges that are not apart of the city network **)*)


(* ::Input:: *)
(*highways2=Reap[For[i=1,i<=Length[highways2],i++,*)
(*If[!KeyExistsQ[edgesToTarafs,highways2[[i,1]]],Continue[];];*)
(*If[!KeyExistsQ[edgesToTarafs,highways2[[i,2]]],Continue[];];*)
(*Sow[highways2[[i]]];*)
(*]][[2]][[1]];*)


(* ::Input:: *)
(*highways2[[1]]*)


(* ::Input:: *)
(*Length[highways2]*)


(* ::Input:: *)
(*(** highways-2 with taraf count **)*)


(* ::Input:: *)
(*highways2T=Monitor[Reap[For[i=1,i<=Length[highways2],i++,*)
(*edge1=highways2[[i,1]];*)
(*edge2=highways2[[i,2]];*)
(*Sow[{edge1,edge2,Length[Intersection[edgesToTarafs[edge1],edgesToTarafs[edge2]]]}];*)
(*]][[2]][[1]],i];*)


(* ::Input:: *)
(*highways2T[[1]]*)


(* ::Input:: *)
(*(** edge to place with ratio **)*)


(* ::Input:: *)
(*edgeSpaceRatio=ToExpression[Import["data/space/m5_edge_to_space_assignment.csv","CSV"]];*)


(* ::Input:: *)
(*edgeSpaceRatio[[1]]*)


(* ::Input:: *)
(*(** edge to list of space and list of ratios **)*)


(* ::Input:: *)
(*edgeToSpaceRatio=Association[Table[edges[[i]]->{{},{}},{i,1,Length[edges],1}]];*)


(* ::Input:: *)
(*edgeToSpaceRatio[edges[[1]]]*)


(* ::Input:: *)
(*For[i=1,i<=Length[edgeSpaceRatio],i++,*)
(*edge=edgeSpaceRatio[[i,1]];*)
(*space=edgeSpaceRatio[[i,2]];*)
(*ratio=edgeSpaceRatio[[i,3]];*)
(*edgeToSpaceRatio[edge]={Append[edgeToSpaceRatio[edge][[1]],space],Append[edgeToSpaceRatio[edge][[2]],ratio]};*)
(*]*)


(* ::Input:: *)
(*edgeToSpaceRatio[edges[[1]]]*)


(* ::Input:: *)
(*(*edge to time span*)*)


(* ::Input:: *)
(*edgeTimeSpan=ToExpression[Import["data/time/m1_edge_to_transmission_span.csv","CSV"]];*)


(* ::Input:: *)
(*edgeTimeSpan[[1]]*)


(* ::Input:: *)
(*edgeToTimeSpan=Association[Table[edgeTimeSpan[[i,1]]->{edgeTimeSpan[[i,2]],edgeTimeSpan[[i,3]]},{i,1,Length[edgeTimeSpan],1}]];*)


(* ::Input:: *)
(*edgeToTimeSpan[edges[[1]]]*)


(* ::Input:: *)
(*(** desired data: {edge 1, edge 2, place 1, place 2, time 1, time 2, count} **)*)


(* ::Input:: *)
(*f[x_,y_]:={x,y}*)


(* ::Input:: *)
(*Outer[f,{a,b},{l,r,z}]*)


(* ::Input:: *)
(*h2=Monitor[Reap[For[i=1,i<=Length[highways2T],i++,*)
(*edge1=highways2T[[i,1]];*)
(*edge2=highways2T[[i,2]];*)
(*tc=highways2T[[i,3]];*)
(*edge1Space=edgeToSpaceRatio[edge1][[1]];*)
(*edge1Ratios=edgeToSpaceRatio[edge1][[2]];*)
(*edge2Space=edgeToSpaceRatio[edge2][[1]];*)
(*edge2Ratios=edgeToSpaceRatio[edge2][[2]];*)
(*edge1Start=edgeToTimeSpan[edge1][[1]];*)
(*edge2End=edgeToTimeSpan[edge2][[2]];*)
(*combinationsSpace=Outer[f,edge1Space,edge2Space][[1]];*)
(*combinationsRatios=Outer[f, edge1Ratios,edge2Ratios][[1]];*)
(*For[j=1,j<=Length[combinationsSpace],j++,*)
(*place1=combinationsSpace[[j]][[1]];*)
(*place2=combinationsSpace[[j]][[2]];*)
(*ratio=combinationsRatios[[j]][[1]]*combinationsRatios[[j]][[2]];*)
(*Sow[{edge1,edge2,place1,place2,edge1Start,edge2End,tc*ratio}];*)
(*]*)
(*]][[2]][[1]],i];*)


(* ::Input:: *)
(*h2[[1]]*)


(* ::Input:: *)
(*(*Export["data/highways/m7_highways_2_time_count.csv",h2];*)*)
