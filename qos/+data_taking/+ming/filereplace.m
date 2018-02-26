function filereplace(oldtag,newtag,filepath)
if nargin<3
    QS = qes.qSettings.GetInstance();
    filepath=fullfile(QS.root,QS.user,QS.session);
end
files=dir(filepath);
for ii=3:numel(files)
    if files(ii).isdir && strcmp(files(ii).name(1),'q')
        cfolder=fullfile(files(ii).folder, files(ii).name);
        replacefile(oldtag,newtag,cfolder)
        data_taking.ming.filereplace(oldtag,newtag,cfolder)
    end
end
end


function replacefile(oldtag,newtag,folder)
if ~isempty(oldtag)
    files=dir(fullfile(folder,['*',oldtag,'*.*']));
    if numel(files)~=0
        if ~isempty(newtag)
            for ii=1:numel(files)
                oldfile=fullfile(files(ii).folder, files(ii).name);
                newfile=fullfile(files(ii).folder, replace(files(ii).name,oldtag,newtag));
                movefile(oldfile,newfile)
            end
        elseif isempty(newtag)
            for ii=1:numel(files)
                oldfile=fullfile(files(ii).folder, files(ii).name);
                delete(oldfile)
            end
        end
    end
elseif ~isempty(newtag)
    files=(fullfile(folder,[newtag,'.key']));
    fid = fopen(files,'w');
    fid = fclose(fid);
end
end
