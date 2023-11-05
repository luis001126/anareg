function ValSal=Valida_AnaReg_V1(Param,Selec)
% Esta funci�n es para validar los par�metros del Modelo.
% En Param se pasa el valor del par�metro
% En Selec para par�metros no negativos (Selec=0)
% para par�metros no nulos (Selec=1)
% para par�metros num�ricos cualquiera (Selec=2)
% En ValSal si es 0 todo bien, si es 1 algo incorrecto.
ValSal=0;
if isnan(Param)
    ValSal=1;
    errordlg({'El valor del par�metro debe ser num�rico' 'Ejemplo: 0.5'},...
        'ERROR!!!');
end
if isempty(Param)
    ValSal=1;
    errordlg({'El valor del par�metro debe ser num�rico' 'Ejemplo: 0.5'},...
        'ERROR!!!');
end
if isnumeric(Param) && ~isreal(Param)
    ValSal=1;
    errordlg({'El valor del par�metro debe ser real' 'Ejemplo: 1'},...
        'ERROR!!!');
end
switch Selec
    case 0
        if Param < 0
            errordlg({'El valor del par�metro debe ser no negativo' 'Ejemplo: 0.5'},...
                'ERROR!!!');
            ValSal=1;
        end
    case 1
        if Param == 0
            errordlg({'El valor del par�metro debe ser diferente de cero' 'Ejemplo: 5'},...
                'ERROR!!!');
            ValSal=1;
        end
end            