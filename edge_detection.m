function [output1 output2] = edge_detection(input_im)

    [rows col] = size(input_im);
    new_dilated_output_im = dilation(input_im,3,3);     %Diltion by 3x3 mask
    new_eroded_output_im = erosion(input_im,3,3);       %Erosion by 3x3 mask
    output1 = new_dilated_output_im - new_eroded_output_im;  %Boundary detection
    output2 = double(input_im) - new_eroded_output_im;
end

