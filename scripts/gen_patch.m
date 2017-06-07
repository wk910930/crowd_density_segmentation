clear

d = dir('./data/frames/');
isub = [d(:).isdir];
ids = {d(isub).name};
ids(1:2) = [];

density_scale = 10000;
seg_threshold = 0.0001;
max_per_frame = 10;
crop_size = 256;

mkdir('./subframes');
mkdir('./sublabels');
mkdir('./subsegs');

symbols = ['a':'z' '0':'9'];
MAX_ST_LENGTH = 10;
rng(0, 'twister');

total_num = 0;

for index = 1:numel(ids)
  select_id = ids{index};
  name_list = dir(['./data/frames/' select_id '/*.jpg']);
  for i = 1:numel(name_list)
    [~, basename, ~] = fileparts(name_list(i).name);
    total_num = total_num + 1;
     fprintf('%d: %s\n', total_num, basename);
    % load image
    img = imread(['./data/frames/' select_id '/' basename '.jpg']);
    [height, width, channels] = size(img);
    % load density map
    load(['./data/density_map/' select_id '/' basename '.mat']);
    % generate segment mask
    segment = (density_map > seg_threshold);
    % load point
    load(['./data/point_map/' select_id '/' basename '.mat']);
 
    for k = 1:max_per_frame
      x = randi([1 (width - crop_size)]);
      y = randi([1 (height - crop_size)]);
      % crop
      crop_img = imcrop(img, [x y crop_size - 1 crop_size - 1]);
      crop_seg = imcrop(segment, [x y crop_size - 1 crop_size - 1]);
      crop_dens = imcrop(density_map, [x y crop_size - 1 crop_size - 1]);
      crop_dens = crop_dens * density_scale;
      crop_point = imcrop(point_map, [x y crop_size - 1 crop_size - 1]);
   
      % flip
      if rand > .5
        crop_img = flip(crop_img, 2);
        crop_seg = flip(crop_seg, 2);
        crop_dens = flip(crop_dens, 2);
        crop_point = flip(crop_point, 2);
      end
   
      nums = randi(numel(symbols), [1 MAX_ST_LENGTH]);
      filename = symbols(nums);
      imwrite(crop_img, ['./subframes/' filename '.jpg']);
      imwrite(crop_seg, ['./subsegs/' filename '.png']);
      save(['./sublabels/' filename '.mat'], 'filename', 'crop_dens');
    end
  end
end
