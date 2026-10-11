function sys = system(name)
%SYSTEM Descriptor registry. Unknown names are an error.
if string(name) == "chua"
    sys = chua.system();
else
    error('studies:system', 'неизвестная система: %s', char(string(name)));
end
end
