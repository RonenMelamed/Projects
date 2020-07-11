function [dataNewLog,dataNewLin,dataMel,origin,vect] = IterateSilliblesSub(dirStr)
%Input: 
%       directory string which contains folders and files in each folder
%       Objective: iterate 1st level subfolders, and for each subfolder - read all
%       audio file, and store them and their relevant data.
%Output:
%       data:store all audio files in 'data' matrix. 
%       vect: cotains (by index ,corresponding to the 'data' matrix) each group affiliation into 'vect'.
%       origin: the "truth" vector.
%       dataNewLog:
%       dataNew:
%Usage: 
%       if no arguments in - there is a defult directory. i.e: [data,melData,vect,original]=IterateSillibles;
%Otherwise: 
%       [data,melData,vect,original]=IterateSillibles('your directory string');
%       x-axis freq scale freqHz = (0:1:length(fft(x))-1)*Fs/N; N is fft length

tic
if nargin<1  
    dirStr=strcat( pwd ,'All syllables - devideD' );
    files = dir(dirStr);
else
    files = dir(dirStr); 
    %[maxAudioLen,~,fCount]= getMaxFileLen(dirStr); activate if not known 
end

%%% setting up the data 
c1=1; c2=1; c3=1;
filesRegx='\w'; audioRegx='.*wav'; melF=12; %initiate vars and regex    
melAvg=zeros(1,melF);                       % for mean purpuses
melAvgN=zeros(1,melF);                      % for mean purpuses
melAvgNlog=zeros(1,melF);                   % for mean purpuses
data=importdata('call catalog - 3.xlsx');   %get excel data
dataNewLin=data.data.Sheet1;                %get excel data
dim=size(dataNewLin);                     

% %%% normalizing data
% for i=1:dim(2)                              
%     minC=min(dataNewLin(:,i));
%     maxC=max(dataNewLin(:,i));
%     dataNewLin(:,i)=(dataNewLin(:,i)-minC)/(maxC-minC);
% end


%%% Setting up data
dataNewLin(:,1:7)=[];                     %remove unnecesarry columns
dataNewLin(isnan(dataNewLin))=0;          %chaneg NaN to 0
origin=dataNewLin;                        %save raw excel data
dim=size(dataNewLin);                     %dim 
vect=zeros(1,dim(1));                     %real affiliations - "truth" allocation
dataNewLin(:,(dim(2)+1):(dim(2)+melF))=zeros(dim(1),melF);     %memory allocation for mel data
dataMel=dataNewLin;                                         
dataMel(:,(dim(2)+1):(dim(2)+melF))=zeros(dim(1),melF); 	   %memory allocation for mel data
dataNewLog=dataNewLin;                                     %memory allocation for log new mel data


%%% starting iterations
for file = files'                                         %iterate different calls
    %tic                                                  file iteration, performance timer
    if regexp(file.name,filesRegx)                        %enter if legal folder name
        files2=dir(strcat(file.folder,'\',file.name));    %getting folders's content names list
            
        for file2=files2'                                 %iterate words of certain call         
            if regexp(file2.name,filesRegx)
                wavFiles = (dir(strcat(file2.folder,'\',file2.name)));
                
                for wavFile=wavFiles'                     %iterate syllibles of a certain word
                    if regexp(wavFile.name,audioRegx)     %assert file name legallity
                        
                        currWavDir=strcat(wavFile.folder,'\',wavFile.name);         %get current file - syllible dir
                        [csv,fs] = audioread(currWavDir);                           %read audio
                        melAvgN=melAvgN+newFilters(csv,fs,melF);                    %new mel - linear spacings calc mean
                        melAvg=melAvg+v_melcepst(csv,fs,'Mt',12,melF,length(csv));  %standard mel calc mean
                        melAvgNlog=melAvgNlog+newMel(csv,fs,melF);                  %new mel - log spacings calc mean
                        c2=c2+1;                                                    %sillibles counter
                        
                    end
                end
                if(c2==1), c2=c2+1; end
                
                melAvg=melAvg./(c2-1);                         %calculate avg - std mel
                dataMel(c1,(dim(2)+1):dim(2)+12)=melAvg;       %save it in corresponding place in Mel data
                melAvg=0;
                
                melAvgN=melAvgN./(c2-1);                        %calculate avg - newMel linear spacings 
                dataNewLin(c1,(dim(2)+1):dim(2)+12)=melAvgN;    %save it in corresponding place in dataNew
                melAvgN=0;
                
                melAvgNlog=melAvgNlog./(c2-1);                  %calculate avg - newMel Log spacings
                dataNewLog(c1,(dim(2)+1):dim(2)+12)=melAvgNlog; %save it in corresponding place in dataNewLog
                melAvgNlog=0;
                
                c2=0; 
                vect(c1)=c3;
                c1=c1+1;
                
            end
            
        end
        c3=c3+1;
    end
    
end

dataNewLog = normalizeMat(dataNewLog);    
dataNewLin = normalizeMat(dataNewLin);   
dataMel = normalizeMat(dataMel);   
origin = normalizeMat(origin);   
       
toc
end