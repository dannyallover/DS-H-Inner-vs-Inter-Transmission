(* ::Package:: *)

(* ::Title:: *)
(*Inner-city vs Intercity Transmission (5 Year Change)*)


(* ::Section:: *)
(*This notebook deduces the ratio of inner-city to total transmission and intercity to total transmission across 5 year windows.*)


(* ::Input:: *)
(*(** set directory **)*)


(* ::Input:: *)
(*SetDirectory[ParentDirectory[ParentDirectory[NotebookDirectory[]]]];*)


(* ::Input:: *)
(*Directory[];*)


(* ::Input:: *)
(*(** highways 2 data **)*)


(* ::Input:: *)
(*h2=ToExpression[Import["data/highways/m7_highways_2_time_count.csv","CSV"]];*)


(* ::Input:: *)
(*h2[[1]]*)


(* ::Input:: *)
(*(** get min and max year **)*)


(* ::Input:: *)
(*minYear=Min[h2[[;;,5]]]*)


(* ::Input:: *)
(*maxYear=Max[h2[[;;,6]]]*)


(* ::Input:: *)
(*(** map highways to inner or inter buckets **)*)


(* ::Input:: *)
(*innerbuckets=Table[0,{i,1,maxYear+Abs[minYear]+1,1}];*)
(*interbuckets=Table[0,{i,1,maxYear+Abs[minYear]+1,1}];*)


(* ::Input:: *)
(*Monitor[For[i=1,i<=Length[h2],i++,*)
(*cit1=h2[[i,3]];*)
(*cit2=h2[[i,4]];*)
(*start=h2[[i,5]];*)
(*end=h2[[i,6]];*)
(*percent=1/(end-start+1);*)
(*count=h2[[i,7]];*)
(*offset=Abs[minYear]+1;*)
(*For[j=start+offset,j<=end+offset,j++,*)
(*If[ToString[cit1]==ToString[cit2],innerbuckets[[j]]+=count*percent;];*)
(*If[ToString[cit1]!=ToString[cit2],interbuckets[[j]]+=count*percent;];*)
(*];*)
(*];,i]*)


(* ::Input:: *)
(*innerbuckets[[;;10]]*)


(* ::Input:: *)
(*interbuckets[[;;10]]*)


(* ::Input:: *)
(*(** map inner and inter 1 year buckets to 5 year buckets **)*)


(* ::Input:: *)
(*(** determine beginning and end offset ***)*)


(* ::Input:: *)
(*minYear*)


(* ::Input:: *)
(*maxYear*)


(* ::Input:: *)
(*(*** first bucket will be years -11 and -10 and last bucket will be year 841 ***)*)


(* ::Input:: *)
(*begOffset=2;*)
(*endOffset=1;*)
(*numOffsets=2;*)


(* ::Input:: *)
(*innerbuckets5=Table[0,{i,1,Floor[Length[interbuckets]/5]+numOffsets,1}]; *)
(*interbuckets5=Table[0,{i,1,Floor[Length[innerbuckets]/5]+numOffsets,1}];*)


(* ::Input:: *)
(*(*** manual setting of first and last bucket ***)*)


(* ::Input:: *)
(*For[i=1,i<=begOffset,i++,*)
(*innerbuckets5[[1]]+=innerbuckets[[i]];*)
(*interbuckets5[[1]]+=interbuckets[[i]];*)
(*];*)
(*For[i=Length[innerbuckets],i>Length[innerbuckets]-endOffset,i--,*)
(*innerbuckets5[[Length[innerbuckets5]]]+=innerbuckets[[i]];*)
(*interbuckets5[[Length[interbuckets5]]]+=interbuckets[[i]];*)
(*];*)


(* ::Input:: *)
(*(*** manually deduce start and end ***)*)


(* ::Input:: *)
(*index=2;count = 1;*)
(*For[i=begOffset+1,i<=Length[innerbuckets]-endOffset,i++,*)
(*innerbuckets5[[index]]+=innerbuckets[[i]];*)
(*interbuckets5[[index]]+=interbuckets[[i]];*)
(*If[count==5,index++;count=0;];*)
(*count++;*)
(*]*)


(* ::Input:: *)
(*innerbuckets5[[;;10]]*)


(* ::Input:: *)
(*interbuckets5[[;;10]]*)


(* ::Input:: *)
(*(** normalize to get ratios **)*)


(* ::Input:: *)
(*innerbuckets5N=innerbuckets5;*)
(*interbuckets5N=interbuckets5;*)


(* ::Input:: *)
(*For[i=1,i<=Length[innerbuckets5],i++,*)
(*bucketTotal=innerbuckets5[[i]]+interbuckets5[[i]];*)
(*innerbuckets5N[[i]]=innerbuckets5N[[i]]/bucketTotal;*)
(*interbuckets5N[[i]]=interbuckets5N[[i]]/bucketTotal;*)
(*]*)


(* ::Input:: *)
(*innerbuckets5N[[;;10]]*)


(* ::Input:: *)
(*interbuckets5N[[;;10]]*)


(* ::Input:: *)
(*(** add years **)*)


(* ::Input:: *)
(*innerbuckets5NY=Table[{(i-4)*5,innerbuckets5N[[i]]},{i,2,Length[innerbuckets5N]-1,1}];*)


(* ::Input:: *)
(*innerbuckets5NY=Insert[innerbuckets5NY,{-11,innerbuckets5N[[1]]},1];*)
(*innerbuckets5NY=Append[innerbuckets5NY,{840,innerbuckets5N[[Length[innerbuckets5N]]]}];*)


(* ::Input:: *)
(*interbuckets5NY=Table[{(i-4)*5,interbuckets5N[[i]]},{i,2,Length[interbuckets5N]-1,1}];*)


(* ::Input:: *)
(*interbuckets5NY=Insert[interbuckets5NY,{-11,interbuckets5N[[1]]},1];*)
(*interbuckets5NY=Append[interbuckets5NY,{840,interbuckets5N[[Length[interbuckets5N]]]}];*)


(* ::Input:: *)
(*(** add header**)*)


(* ::Input:: *)
(*innerbuckets5Final=Insert[innerbuckets5NY,{year,ratio},1];*)
(*interbuckets5Final=Insert[interbuckets5NY,{year,ratio},1];*)


(* ::Input:: *)
(*innerbuckets5Final[[;;10]]*)


(* ::Input:: *)
(*interbuckets5Final[[;;10]]*)


(* ::Input:: *)
(*(**first 350 years **)*)


(* ::Input:: *)
(*Export["data/analysis/a1_inner_transmission_over_total_transmission_5_year_buckets_350_years.csv",innerbuckets5Final[[;;75]]];*)


(* ::Input:: *)
(*Export["data/analysis/a1_inter_transmission_over_total_transmission_5_year_buckets_350_years.csv",interbuckets5Final[[;;75]]];*)


(* ::Input:: *)
(*(** first 600 years **)*)


(* ::Input:: *)
(*Export["data/analysis/a1_inner_transmission_over_total_transmission_5_year_buckets_600_years.csv",innerbuckets5Final[[;;125]]];*)


(* ::Input:: *)
(*Export["data/analysis/a1_inter_transmission_over_total_transmission_5_year_buckets_600_years.csv",interbuckets5Final[[;;125]]];*)
