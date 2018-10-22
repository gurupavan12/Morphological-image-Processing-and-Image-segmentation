%This function takes the image that has to be dilated as the first input
%argument, and the size of the mask with which it needs to be dilated as the second and
%third argument. 

%input_image is th input image. 
%x is the number of rows of the mask
%y is the number of coloumns of the mask


function output = dilation(input_image,x,y)
    
    [rows col] = size(input_image);
    output = zeros(rows, col);
    a=zeros(3,3);                   %Temp matrix
    %Algorithm for dilation for any odd indices
    for i=1+floor(x/2):1:rows-floor(x/2)
        for j=1+floor(y/2):1:col-floor(y/2)
            for m=round(x/2)-x:1:round(x/2)-1
                for n=round(y/2)-y:1:round(y/2)-1
                    a(m+round(x/2),n+round(y/2))=input_image(i+m,j+n);
                end
            end
            output(i,j) = max(max(a));      %For dilation, max of x*y mask(a) is taken.
        end
    end
    
%     imshow(output);     
    output;
end
