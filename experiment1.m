file = 'Hangpai_2_req_1.png';
a = 1;
b = 1;
for i = 0.01:0.01:1
    b = 1;
    for j = 0.01:0.01:1
        [nearest(a,b), bilinear(a,b), bicubic(a,b)] = MSE(file, 45, -45, -45, 45, i, j);
        b = b + 1;
    end
    a = a + 1;
end