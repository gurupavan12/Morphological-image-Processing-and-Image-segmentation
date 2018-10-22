function output = reconstruct(marker_im,original_im)
    
    [rows col] = size(original_im);
    flag=1;       %Since the number of iterations is unknown, flag is used to control the loop
    count=1;      %Obtain the total number of iterations
    
    %Two temporary images are used in order to dilate and compare with the
    %previous image. These two images are accessed by the same variable
    %name and they are new_im(:,:,1) and new_im(:,:,2)
    
    temp_im(:,:,1) = uint8(marker_im);   

    while flag
        
        temp_im(:,:,2) = dilation(temp_im(:,:,1),3,3);      %Dilation by a 3x3 mask
        temp_im(:,:,2) = uint8(temp_im(:,:,2) & original_im);   %Intersecting the dilated image
                                                                %with the clean image
       
        if (temp_im(:,:,2) == temp_im(:,:,1))           
            flag=0;
            fprintf('Completed with %d number of iterations \n',count)
        else
            imshow(255*uint8(temp_im(:,:,2)));
            temp_im(:,:,1) = temp_im(:,:,2);            %Updating the temp variables
            count=count+1;                              %Number of iterations
        end
    end
    output = temp_im(:,:,2);
end
