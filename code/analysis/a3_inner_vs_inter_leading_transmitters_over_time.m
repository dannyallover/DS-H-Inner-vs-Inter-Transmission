(* ::Package:: *)

(* ::Title:: *)
(*Inner-city vs Intercity Transmission Transmitter Drivers (15 year change)*)


(* ::Section:: *)
(*This notebook deduces which the transmitters responsible for driving inter transmission trends and inner transmission trends in each 15 year period window.*)


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
(*(** transmitters to [inner ratio, inner transmissions, inter ratio, inter transmissions, total volume] **)*)


(* ::Input:: *)
(*transmitters=h2[[;;,1]][[;;,2]];*)


(* ::Input:: *)
(*transmitters=DeleteDuplicates[transmitters];*)


(* ::Input:: *)
(*transmitters[[1]]*)


(* ::Input:: *)
(*(*** we say inner and inter start out at 1 ***)*)


(* ::Input:: *)
(*transmitterToIIVolume=Association[Table[transmitters[[i]]->{1,1,1,1,2},{i,1,Length[transmitters],1}]];*)


(* ::Input:: *)
(*transmitterToIIVolume[4883]*)


(* ::Input:: *)
(*Monitor[For[i=1,i<=Length[h2],i++,*)
(*cit1=h2[[i,3]];*)
(*If[!MemberQ[cits,cit1],Continue[]];*)
(*cit2=h2[[i,4]];*)
(*transmitter=h2[[i,1,2]];*)
(*count=h2[[i,7]];*)
(*buckets=transmitterToIIVolume[transmitter];*)
(*If[ToString[cit1]==ToString[cit2],buckets[[1]]+=count;buckets[[2]]+=count;];*)
(*If[ToString[cit1]!=ToString[cit2],buckets[[3]]+=count;buckets[[4]]+=count;];*)
(*buckets[[5]]+=count;*)
(*transmitterToIIVolume[transmitter]=buckets;*)
(*];,i]*)


(* ::Input:: *)
(*transmitterToIIVolume[4883]*)


(* ::Input:: *)
(*(** normalize inter and inner **)*)


(* ::Input:: *)
(*For[i=1,i<=Length[transmitters],i++,*)
(*t=transmitters[[i]];*)
(*buckets=transmitterToIIVolume[t];*)
(*buckets[[1]]/=buckets[[5]];*)
(*buckets[[3]]/=buckets[[5]];*)
(*transmitterToIIVolume[t]=buckets;*)
(*]*)


(* ::Input:: *)
(*transmitterToIIVolume[4883]*)


(* ::Input:: *)
(*m=Max[Values[transmitterToIIVolume][[;;,2]]]*)


(* ::Input:: *)
(*Position[Values[transmitterToIIVolume][[;;,1]],m]*)


(* ::Input:: *)
(*Values[transmitterToIIVolume][[4]]*)


(* ::Input:: *)
(*(** transmitter to transmission years **)*)


(* ::Input:: *)
(*transmitterToTYears=Association[Table[transmitters[[i]]->{0,0},{i,1,Length[transmitters],1}]];*)


(* ::Input:: *)
(*transmitterToTYears[4883]*)


(* ::Input:: *)
(*Monitor[For[i=1,i<=Length[h2],i++,*)
(*year1=h2[[i,5]];*)
(*year2=h2[[i,6]];*)
(*transmitter=h2[[i,1,2]];*)
(*years=transmitterToTYears[transmitter];*)
(*years[[1]]=Min[years[[1]],year1];*)
(*years[[2]]=Max[years[[2]],year2];*)
(*transmitterToTYears[transmitter]=years;*)
(*];,i]*)


(* ::Input:: *)
(*transmitterToTYears[4883]*)


(* ::Input:: *)
(*(** [highest inner ratio transmitter, their inner volume, their inner volume, their inner ratio, highest inner volume transmitter, their inner volume,their inter volume, their inner ratio, highest inter ratio transmitter, their inter volume, their inter volume, their inter ratio, highest inter volume transmitter, their inter volume, their inter volume, their inter ratio] for each 15 year bucket **)*)


(* ::Input:: *)
(*numBuckets=2+(840/15);*)


(* ::Input:: *)
(*yearbuckets=Table[{Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null,Null},{i,1,numBuckets,1}];*)


(* ::Input:: *)
(*For[i=1,i<=numBuckets,i++,*)
(*(*** condition for first (-11 to 0) and last bucket (841) ***)*)
(*bucket=15*(i-1);*)
(*If[i==1,bucket=0];*)
(*If[i==numBuckets,bucket=855];*)
(*filtered={};*)
(*For[j=1,j<=Length[transmitters],j++,*)
(*t=transmitters[[j]];*)
(*year1=transmitterToTYears[t][[1]];*)
(*year2=transmitterToTYears[t][[2]];*)
(*If[(year1>bucket-15&&year1<=bucket)||(year2>bucket-15&&year2<bucket),filtered=Append[filtered,{t,transmitterToIIVolume[t]}]*)
(*];*)
(*];*)
(*l11=filtered[[;;,2,1]];*)
(*l12=filtered[[;;,2,2]];*)
(*l21=filtered[[;;,2,3]];*)
(*l22=filtered[[;;,2,4]];*)
(**)
(*m1=Max[l11];*)
(*p1=Position[filtered[[;;,2,1]],m1][[1,1]];*)
(*t1=filtered[[p1]][[1]];*)
(*t1Inner=filtered[[p1]][[2,2]];*)
(*t1Inter=filtered[[p1]][[2,4]];*)
(*t1R=filtered[[p1]][[2,1]];*)
(**)
(*m2=Max[l12];*)
(*p2=Position[filtered[[;;,2,2]],m2][[1,1]];*)
(*t2=filtered[[p2]][[1]];*)
(*t2Inner=filtered[[p2]][[2,2]];*)
(*t2Inter=filtered[[p2]][[2,4]];*)
(*t2R=filtered[[p2]][[2,1]];*)
(**)
(*m3=Max[l21];*)
(*p3=Position[filtered[[;;,2,3]],m3][[1,1]];*)
(*t3=filtered[[p3]][[1]];*)
(*t3Inner=filtered[[p3]][[2,2]];*)
(*t3Inter=filtered[[p3]][[2,4]];*)
(*t3R=filtered[[p3]][[2,3]];*)
(**)
(*m4=Max[l22];*)
(*p4=Position[filtered[[;;,2,4]],m4][[1,1]];*)
(*t4=filtered[[p4]][[1]];*)
(*t4Inner=filtered[[p4]][[2,2]];*)
(*t4Inter=filtered[[p4]][[2,4]];*)
(*t4R=filtered[[p4]][[2,3]];*)
(**)
(**)
(*yearbuckets[[i]]={t1,t1Inner,t1Inter,t1R,t2,t2Inner,t2Inter,t2R,t3,t3Inner,t3Inter,t3R,t4,t4Inner,t4Inter,t4R};*)
(*];*)


(* ::Input:: *)
(*yearbuckets[[1]]*)


(* ::Input:: *)
(*(** seperate and add years explicitly **)*)


(* ::Input:: *)
(*inner=Table[{(i-2)*15,(i-1)*15,yearbuckets[[i,1]],Floor[yearbuckets[[i,2]]],Floor[yearbuckets[[i,3]]],NumberForm[1.0*yearbuckets[[i,4]],4],yearbuckets[[i,5]],Floor[yearbuckets[[i,6]]],Floor[yearbuckets[[i,7]]],NumberForm[1.0*yearbuckets[[i,8]],4]},{i,1,Length[yearbuckets],1}];*)


(* ::Input:: *)
(*inter=Table[{(i-2)*15,(i-1)*15,yearbuckets[[i,9]],Floor[yearbuckets[[i,10]]],Floor[yearbuckets[[i,11]]],NumberForm[1.0*yearbuckets[[i,12]],4],yearbuckets[[i,13]],Floor[yearbuckets[[i,14]]],Floor[yearbuckets[[i,15]]],NumberForm[1.0*yearbuckets[[i,16]],4]},{i,1,Length[yearbuckets],1}];*)


(* ::Input:: *)
(*(*** fix boundaries **)*)


(* ::Input:: *)
(*inner[[1,1]]=-11;*)
(*inter[[1,1]]=-11;*)
(*inner[[numBuckets,2]]=841;*)
(*inter[[numBuckets,2]]=841;*)


(* ::Input:: *)
(*inner[[1]]*)


(* ::Input:: *)
(*inter[[1]]*)


(* ::Input:: *)
(*(** add years explicitly **)*)


(* ::Input:: *)
(*(*Export["data/analysis/a3_inner_leading_transmitters_by_ratio_and_volume_15_year_buckets.csv",inner];*)*)


(* ::Input:: *)
(*(*Export["data/analysis/a3_inter_leading_transmitters_by_ratio_and_volume_15_year_buckets.csv",inter];*)*)
