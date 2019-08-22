function X = HSIReader(filename)
    [filepath, name, ~] = fileparts(filename);
    data_list = dir([filepath, filesep, name, '*']);

    if length(data_list) ~= 2
        error("Can't find the data file or there are more than one data file.");
    end

    for i = 1:2
        if ~strcmp(data_list(i).name(end-3:end), '.hdr')
            dataname = [data_list(i).folder, filesep, data_list(i).name];
            break;
        end
    end

    txt = fileread(filename);
    txt = split(txt, {newline, '='});
    
    datatype = {'uint8', 'int16', 'int32', ...
        'float', 'double', 'float',...
        '', '', 'double',...
        '', '', 'uint16',...
        'uint32', 'uint64', 'int64'};

    for i = 1:length(txt)
        if contains(char(txt(i)), 'samples', 'IgnoreCase', true)
            samples = str2num(char(txt(i+1)));
        elseif contains(char(txt(i)), 'lines', 'IgnoreCase', true)
            lines = str2num(char(txt(i+1)));
        elseif contains(char(txt(i)), 'bands', 'IgnoreCase', true)
            bands = str2num(char(txt(i+1)));
        elseif contains(char(txt(i)), 'header offset', 'IgnoreCase', true)
            offset = str2num(char(txt(i+1)));
        elseif contains(char(txt(i)), 'data type', 'IgnoreCase', true)
            precision = char(datatype(str2num(char(txt(i+1)))));
        elseif contains(char(txt(i)), 'interleave', 'IgnoreCase', true)
            if contains(char(txt(i+1)), 'bsq', 'IgnoreCase', true)
                interleave = 'bsq';
            elseif contains(char(txt(i+1)), 'bil', 'IgnoreCase', true)
                interleave = 'bil';
            elseif contains(char(txt(i+1)), 'bip', 'IgnoreCase', true)
                interleave = 'bip';
            else
                error('Unknown interleave type.');
            end
        elseif contains(char(txt(i)), 'byte order', 'IgnoreCase', true)
            if str2num(char(txt(i+1)))
                byteorder = 'ieee-be';
            else
                byteorder = 'ieee-le';
            end
        end
    end

    X = multibandread(dataname, [lines, samples, bands], ...
        precision, offset, interleave, byteorder);
end