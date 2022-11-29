(* ::Package:: *)

(* ::Title:: *)
(*Inner-city vs Intercity Transmission in Cities (15 year change)*)


(* ::Section:: *)
(*This notebook deduces the ratio of inner-city to total transmission and intercity to total transmission in the cities across 15 year windows.*)


(* ::Input:: *)
(*(** set directory **)*)


(* ::Input:: *)
(*SetDirectory[ParentDirectory[ParentDirectory[NotebookDirectory[]]]];*)


(* ::Input:: *)
(*Directory[];*)


(* ::Input:: *)
(*(** cities of interest **)*)


(* ::Input:: *)
(*cits=ToExpression[Flatten[Import["data/cities/xxx_cities_to_study.csv","CSV"]]];*)


(* ::Input:: *)
(*cits[[1]]*)


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
(*(** cities to inner and inter city transmission **)*)


(* ::Input:: *)
(*innerbuckets=Table[0,{i,1,maxYear+Abs[minYear]+1,1}];*)
(*interbuckets=Table[0,{i,1,maxYear+Abs[minYear]+1,1}];*)


(* ::Input:: *)
(*citsToInner=Association[Table[cits[[i]]->innerbuckets,{i,1,Length[cits],1}]];*)
(*citsToInter=Association[Table[cits[[i]]->interbuckets,{i,1,Length[cits],1}]];*)


(* ::Input:: *)
(*citsToInner[\:0628\:0635\:0631\:0629][[;;10]]*)


(* ::Input:: *)
(*citsToInter[\:0628\:0635\:0631\:0629][[;;10]]*)


(* ::Input:: *)
(*(** place transmissions in buckets for each year **)*)


(* ::Input:: *)
(*Monitor[For[i=1,i<=Length[h2],i++,*)
(*cit1=h2[[i,3]];*)
(*If[!MemberQ[cits,cit1],Continue[]];*)
(*cit2=h2[[i,4]];*)
(*start=h2[[i,5]];*)
(*end=h2[[i,6]];*)
(*percent=1/(end-start+1);*)
(*count=h2[[i,7]];*)
(*offset=Abs[minYear]+1;*)
(*For[j=start+offset,j<=end+offset,j++,*)
(*inner=citsToInner[cit1];*)
(*inter=citsToInter[cit1];*)
(*If[ToString[cit1]==ToString[cit2],inner[[j]]+=count*percent;];*)
(*If[ToString[cit1]!=ToString[cit2],inter[[j]]+=count*percent;];*)
(*citsToInner[cit1]=inner;*)
(*citsToInter[cit1]=inter;*)
(*];*)
(*];,i]*)


(* ::Input:: *)
(*citsToInner[\:0628\:0635\:0631\:0629][[;;10]]*)


(* ::Input:: *)
(*citsToInter[\:0628\:0635\:0631\:0629][[;;10]]*)


(* ::Input:: *)
(*(** map inner and inter 1 year buckets to 15 year buckets **)*)


(* ::Input:: *)
(*(** determine beginning and end offset ***)*)


(* ::Input:: *)
(*minYear*)


(* ::Input:: *)
(*maxYear*)


(* ::Input:: *)
(*(*** first bucket will be years -11 to 0 (12 years) and last bucket will be year 841 (1 year) ***)*)


(* ::Input:: *)
(*begOffset=12;*)
(*endOffset=1;*)
(*numOffsets=2;*)


(* ::Input:: *)
(*innerbuckets15=Table[0,{i,1,Floor[Length[interbuckets]/15]+numOffsets,1}]; *)
(*interbuckets15=Table[0,{i,1,Floor[Length[innerbuckets]/15]+numOffsets,1}];*)


(* ::Input:: *)
(*citsToInner15=Association[Table[cits[[i]]->innerbuckets15,{i,1,Length[cits],1}]];*)
(*citsToInter15=Association[Table[cits[[i]]->interbuckets15,{i,1,Length[cits],1}]];*)


(* ::Input:: *)
(*(*** manual setting of first and last bucket ***)*)


(* ::Input:: *)
(*For[z=1,z<=Length[cits],z++,*)
(*cit=cits[[z]];*)
(*inner=citsToInner[cit];*)
(*inter=citsToInter[cit];*)
(*inner15=citsToInner15[cit];*)
(*inter15=citsToInter15[cit];*)
(*For[i=1,i<=begOffset,i++,*)
(*inner15[[1]]+=inner[[i]];*)
(*inter15[[1]]+=inter[[i]];*)
(*];*)
(*citsToInner15[cit]=inner15;*)
(*citsToInter15[cit]=inter15;*)
(*];*)


(* ::Input:: *)
(*For[z=1,z<=Length[cits],z++,*)
(*cit=cits[[z]];*)
(*inner=citsToInner[cit];*)
(*inter=citsToInter[cit];*)
(*inner15=citsToInner15[cit];*)
(*inter15=citsToInter15[cit];For[i=Length[innerbuckets],i>Length[innerbuckets]-endOffset,i--,*)
(*inner15[[Length[inner15]]]+=inner[[i]];*)
(*inter15[[Length[inter15]]]+=inter[[i]];*)
(*];*)
(*citsToInner15[cit]=inner15;*)
(*citsToInter15[cit]=inter15;*)
(*];*)


(* ::Input:: *)
(*citsToInner15[\:0628\:0635\:0631\:0629][[;;10]]*)


(* ::Input:: *)
(*citsToInter15[\:0628\:0635\:0631\:0629][[;;10]]*)


(* ::Input:: *)
(*(*** fill in the rest ***)*)


(* ::Input:: *)
(*For[z=1,z<=Length[cits],z++,*)
(*cit=cits[[z]];*)
(*inner=citsToInner[cit];*)
(*inter=citsToInter[cit];*)
(*inner15=citsToInner15[cit];*)
(*inter15=citsToInter15[cit];*)
(*index=2;count = 1;*)
(*For[i=begOffset+1,i<=Length[innerbuckets]-endOffset,i++,*)
(*inner15[[index]]+=inner[[i]];*)
(*inter15[[index]]+=inter[[i]];*)
(*If[count==15,index++;count=0;];*)
(*count++;*)
(*];*)
(*citsToInner15[cit]=inner15;*)
(*citsToInter15[cit]=inter15;*)
(*];*)


(* ::Input:: *)
(*citsToInner15[\:0628\:0635\:0631\:0629][[;;10]]*)


(* ::Input:: *)
(*citsToInter15[\:0628\:0635\:0631\:0629][[;;10]]*)


(* ::Input:: *)
(*(** normalize to get ratios **)*)


(* ::Input:: *)
(*citsToInner15N=citsToInner15;*)
(*citsToInter15N=citsToInter15;*)


(* ::Input:: *)
(*For[z=1,z<=Length[cits],z++,*)
(*cit=cits[[z]];*)
(*inner15=citsToInner15N[cit];*)
(*inter15=citsToInter15N[cit];*)
(*For[i=1,i<=Length[inner15],i++,*)
(*bucketTotal=inner15[[i]]+inter15[[i]];*)
(*If[bucketTotal!=0,*)
(*inner15[[i]]=inner15[[i]]/bucketTotal;*)
(*inter15[[i]]=inter15[[i]]/bucketTotal;,*)
(*inner15[[i]]=Null;*)
(*inter15[[i]]=Null;*)
(*];*)
(*];*)
(*citsToInner15N[cit]=inner15;*)
(*citsToInter15N[cit]=inter15;*)
(*];*)


(* ::Input:: *)
(*citsToInner15N[\:0628\:0635\:0631\:0629][[;;10]]*)


(* ::Input:: *)
(*citsToInter15N[\:0628\:0635\:0631\:0629][[;;10]]*)


(* ::Input:: *)
(*(** turn into list and limit to 500 years**)*)


(* ::Input:: *)
(*inner15=Reap[For[z=1,z<=Length[cits],z++,*)
(*cit=cits[[z]];*)
(*Sow[citsToInner15N[cit][[;;35]]]]][[2]][[1]];*)


(* ::Input:: *)
(*inter15=Reap[For[z=1,z<=Length[cits],z++,*)
(*cit=cits[[z]];*)
(*Sow[citsToInter15N[cit]][[;;35]];]][[2]][[1]];*)


(* ::Input:: *)
(*inner15[[1]]*)


(* ::Input:: *)
(*inter15[[1]]*)


(* ::Input:: *)
(*(*Export["data/analysis/a2_inner_transmission_over_total_transmission_in_cities_15_year_buckets_500_years.csv",inner15];*)*)


(* ::Input:: *)
(*(*Export["data/analysis/a2_inter_transmission_over_total_transmission_in_cities_15_year_buckets_500_years.csv",inter15];*)*)


(* ::Input:: *)
(*(** format data for hinton diagram **)*)


(* ::Input:: *)
(*(*** only need to use inner to get both inner and inter ***)*)


(* ::Input:: *)
(*dat15=Transpose[inner15];*)


(* ::Input:: *)
(*For[i=1,i<=Length[dat15],i++,*)
(*row=dat15[[i]];*)
(*For[j=1,j<=Length[row],j++,*)
(*If[row[[j]]==Null,row[[j]]=Null;Continue[];];*)
(*If[row[[j]]>=0.5,row[[j]]=row[[j]]-0.5;Continue[];];*)
(*If[row[[j]]<0.5,row[[j]]=-1*(0.5-row[[j]])];*)
(*];*)
(*dat15[[i]]=row;*)
(*]*)


(* ::Input:: *)
(*dat15[[1]]*)


(* ::Input:: *)
(*(*Export["data/analysis/a2_inner_vs_inter_transmission_over_total_transmission_in_cities_15_year_buckets_500_years_formatted.csv",dat15];*)*)
