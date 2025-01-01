x = input('Nhap ma tran gia : ');
cung = input('Nhap ma tran cung : ');
cau = input('Nhap ma tran cau : ');
y=x;
cungg=cung;
cauu=cau;

% Phuong phap Tay Bac
tong_cung = sum(cung);
tong_cau = sum(cau);

if tong_cung == tong_cau
    disp('Can bang cung va cau');
    
    [m, n] = size(x);
    matrix = zeros(m, n);
    count = 1;
    
    for i = 1:m
        for j = count:n
            matrix(i, j) = min(cung(i), cau(j));
            
            % Cap nhat cung va cau
            cung(i) = cung(i) - matrix(i, j);
            cau(j) = cau(j) - matrix(i, j);
            
            % Neu cau dat 0, chuyen sang hang tiep theo
            if cau(j) == 0
                count = count + 1;
            end
        end
    end
    disp('Ma tran phan phoi:');
    disp(matrix);
    
    % Tinh tong chi phi toi uu
    minTB = sum(sum(matrix .* x));
    disp('Chi phi toi uu theo phuong phap Tay Bac:');
    disp(minTB);
else
    disp('Tong cung khong bang tong cau. Vui long kiem tra lai dau vao.');
end

% Phuong Phap cuoc phi nho nhat

x = y;
cung = cungg;
cau = cauu;
tong_cung = sum(cung);
tong_cau = sum(cau);

if tong_cung == tong_cau
    [row, col] = size(x);
    copy = x;
    newmatrix = zeros(length(cung), length(cau)); % Khoi tao newmatrix

    while any(copy(:) ~= -1) % Kiem tra neu van con phan tu khac -1 trong ma tran copy
        mink = min(copy(copy ~= -1)); % Tim gia tri nho nhat trong ma tran copy

        [min_row, min_col] = find(copy == mink, 1); % Tim vi tri cua gia tri nho nhat
        min_val = min(cung(min_row), cau(min_col)); % Tinh gia tri cuoc phi nho nhat
        newmatrix(min_row, min_col) = min_val; % Cap nhat ma tran newmatrix

        if cung(min_row) == newmatrix(min_row, min_col)
            copy(min_row, :) = -1; % Danh dau hang da duoc phuc vu het
            cau(min_col) = cau(min_col) - min_val; % Cap nhat nhu cau con lai
            cung(min_row) = cung(min_row) - min_val; % Cap nhat cung con lai
        else
            copy(:, min_col) = -1; % Danh dau cot da duoc phuc vu het
            cau(min_col) = cau(min_col) - min_val; % Cap nhat nhu cau con lai
            cung(min_row) = cung(min_row) - min_val; % Cap nhat cung con lai
        end
    end

    minCP = sum(sum(newmatrix .* x)); % Tinh cuoc phi nho nhat
    disp('Ma tran phan phoi:');
    disp(newmatrix);
    disp('Cuoc phi nho nhat tinh theo phuong phap Cuoc Phi Nho Nhat la: ');
    disp(minCP);
else
    disp('Tong cung khong bang tong cau. Vui long kiem tra lai dau vao.');
end


% So sanh 2 phuong phap:
disp('---------------------------------------------------');
if(minTB<minCP)
    disp('Phuong Phap Tay Bac toi uu hon Phuong Phap Cuoc Phi Nho Nhat');
else
    disp('Phuong Phap Cuoc Phi Nho Nhat toi uu hon Phuong Phap Tay Bac');
end

% Phuong phap the vi: 

c=y;
row = -1;
col = -1;
n = length(cung);
m = length(cau);
while 1
    minn = 0;
    % Khai bao the vi u cua nguon cung
    u = -999.5 * ones(1, n);
    u(1)=0;
    % Khai bao the vi v cua nguon cap
    v = -999.5 * ones(1, m);
    delta = -9999.5 * ones(n, m);
    
    % 4 vong lap duoi dung de xac dinh gia tri cua the vi u va v 
    dk1 = 1;
    while 1
        for i = 1:n
            for j = 1:m
                if newmatrix(i,j) > 0
                    if u(i) ~= -999.5
                    v(j) = c(i,j) - u(i);
                    elseif v(j) ~= -999.5
                        u(i) = c(i,j) - v(j);
                    end
                end
            end
        end
    for i = 1:n
        for j = m:-1:1
            if newmatrix(i,j) > 0
                if u(i) ~= -999.5
                    v(j) = c(i,j) - u(i);
                elseif v(j) ~= -999.5
                    u(i) = c(i,j) - v(j);
                end
            end
        end
    end
    for i = n:-1:1
        for j = 1:m
            if newmatrix(i,j) > 0
                if u(i) ~= -999.5
                    v(j) = c(i,j) - u(i);
                elseif v(j) ~= -999.5
                    u(i) = c(i,j) - v(j);
                end
            end
        end
    end
    for i = n:-1:1
        for j = m:-1:1
            if newmatrix(i,j) > 0
                if u(i) ~= -999.5
                    v(j) = c(i,j) - u(i);
                elseif v(j) ~= -999.5
                    u(i) = c(i,j) - v(j);
                end
            end
        end
    end
        for i = 1:n
            for j = 1:m
                if u(i) == -999.5 || v(j) == -999.5
                    dk1 = 0;
                end
            end
        end
        if (dk1) 
            break;
        end
        dk1 = 1;
    end
    
    % Tinh he so uoc luong Delta va tim gia tri lon nhat trong cac he so
    for i = 1:n
        for j = 1:m
            if newmatrix(i,j) <= 0
                delta(i,j) = u(i) + v(j) - c(i,j);
                if minn < delta(i,j)
                    minn = delta(i,j);
                    row = i;
                    col = j;
                end
            end
        end
    end
    % Thuat toan dung lai khi gia tri lon nhat cua he so uoc luong la 0
    if minn <= 0
        break;
    end
    % Neu khong thuat toan tiep tuc thuc hien viec dieu chinh bang
    for i = 1:n
        for j = 1:m
            if i ~= row && j ~= col
            % Xac dinh chu trinh chua o co he so uoc luong duong lon nhat
                if newmatrix(i,j) > 0 && newmatrix(row,j) > 0 && newmatrix(i,col) > 0
                    % Xac dinh o danh dau tru co gia tri nho nhat
                    mincheo = min(newmatrix(row,j), newmatrix(i,col));
                    % Thuc hien dieu chinh bang
                    newmatrix(row,j) = newmatrix(row,j) - mincheo;
                    newmatrix(i,col) = newmatrix(i,col) - mincheo;
                    newmatrix(i,j) = newmatrix(i,j) + mincheo;
                    newmatrix(row,col) = newmatrix(row,col) + mincheo;
                    if newmatrix(row,j) == 0 && newmatrix(i,col) == 0
                        % Buoc rut ngan thuat toan, so sanh cuoc phi
                        if c(row,j) < c(i,col)
                            newmatrix(i,col) = -999;
                        else
                            newmatrix(row,j) = -999;
                        end
                    end
                    if newmatrix(row,j) == 0 && newmatrix(i,col) ~= 0
                        newmatrix(row,j) = -999;
                    end
                    if newmatrix(row,j) ~= 0 && newmatrix(i,col) == 0
                        newmatrix(i,col) = -999;
                    end
                end
            end
        end
    end
    if minn <= 0
        break;
    end
end
sum = 0;
    for i = 1:n
        for j = 1:m
            if newmatrix(i,j) < 0
                newmatrix(i,j) = 0;
            end
            if newmatrix(i,j) > 0
                % Tinh tong cac gia tri 
                sum = sum + newmatrix(i,j) * c(i,j);
            end
        end
    end
disp('Ma tran phan phoi');
disp(newmatrix);
disp('Chi phi toi uu hoa theo thuat toan the vi la');
disp(sum);
disp('Thuat toan the vi la thuat toan dua ra dap an toi uu nhat');


