data nl;

length STUDYID $10 SITEID $5 SUBJID $5 
       LOC1 LOC2 LOC3 $20 
       METHOD1 METHOD2 METHOD3 $20
       DATE1 DATE2 DATE3 $10;

input STUDYID $ SITEID $ SUBJID $
      LOC1 $ LOC2 $ LOC3 $
      METHOD1 $ METHOD2 $ METHOD3 $
      DATE1 $ DATE2 $ DATE3 $;

datalines;
STUDY1 101 001 LIVER LUNG . CT MRI . 2024-01-01 2024-01-05 .
STUDY1 101 002 BRAIN . . MRI . . 2024-02-01 . .
;
run;


data tu_nl;
set nl;

DOMAIN = "TU";

USUBJID = catx("-", STUDYID, SITEID, SUBJID);

array loc{3} LOC1 LOC2 LOC3;
array meth{3} METHOD1 METHOD2 METHOD3;
array dt{3} DATE1 DATE2 DATE3;

do i = 1 to 3;

    if loc{i} ne "" then do;

        TULOC    = loc{i};
        TUMETHOD = meth{i};
        TUDTC    = dt{i};

        TUTESTCD = "TUMOR";
        TUTEST   = "Tumor Identification";
        TUTYPE   = "NEW";

        output;

    end;

end;

drop i LOC1 LOC2 LOC3 METHOD1 METHOD2 METHOD3 DATE1 DATE2 DATE3;

run;
