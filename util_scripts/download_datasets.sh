mkdir -p $BASE_PATH/datasets/  # create datasets folder if it does not exist
cd $BASE_PATH/datasets  # move to datasets folder


# ------- LAION-10k subset --------- #
# gdown --id 1lUUzhq9yK1YOWJePm12GeJgsUtCfpm_o  # images
# gdown --id 1svzxtGgJRtCyWNW6pQPNGSDkhuDifTzn  # captions
# gdown --id 1TAxFU_i102ZGuWm3LUrYM0nn_mX28Ab4  # precomputed LAION features
# unzip train.zip # unzip LAION images
# mkdir -p laion-10k # create dir
# mv train/images_large/* laion-10k/ # move to appropriate folder
# rm -rf train/ # clean files
# rm -rf train.zip # clean files


# wget https://github.com/NVlabs/edm/raw/main/dataset_tool.py
# echo "Resizing LAION-10k to 1024x1024"
# python dataset_tool.py --source=laion-10k --dest=laion-10k-resized --resolution=1024x1024
# mv laion-10k-resized/*/*.png laion-10k-resized/ # move all images to the same folder
# find laion-10k-resized/ -mindepth 1 -type d -exec rm -r {} +  # delete empty folders
# cd laion-10k-resized/
# for f in img000*.png; do mv "$f" "${f:5}"; done  # rename files to be consistent with laion-10k.
# cd ..


# ------- CelebA-HQ --------- #
# mkdir -p celeba_hq
# mkdir -p download_scripts
# cd download_scripts
# wget https://github.com/clovaai/stargan-v2/raw/master/download.sh

# bash download.sh celeba-hq-dataset
# mkdir -p celeba_hq_train_split
# mv data/celeba_hq/train/male/* celeba_hq_train_split/
# mv data/celeba_hq/train/female/* celeba_hq_train_split/
# mkdir -p celeba_hq_eval_split
# mv data/celeba_hq/val/male/* celeba_hq_eval_split/
# mv data/celeba_hq/val/female/* celeba_hq_eval_split/
# rm -rf data/
# mv celeba_hq_train_split ../celeba_hq/
# mv celeba_hq_eval_split ../celeba_hq
# cd ..


# # ------- FFHQ --------- #
# download ffhq from huggingface
wget -O FFHQ-1024-1.zip "https://huggingface.co/datasets/yangtao9009/FFHQ1024/resolve/main/FFHQ-1024-1.zip?download=true"
wget -O FFHQ-1024-2.zip "https://huggingface.co/datasets/yangtao9009/FFHQ1024/resolve/main/FFHQ-1024-2.zip?download=true"

echo "Exctracting FFHQ dataset..."
mkdir -p $FFHQ_RAW_DATA
n_files=$(unzip -l $BASE_PATH/datasets/FFHQ-1024-1.zip | tail -n 1 | awk '{print $2}')
unzip -o  $BASE_PATH/datasets/FFHQ-1024-1.zip -d $FFHQ_RAW_DATA | tqdm --desc "FFHQ-1024-1.zip extracted" --unit files --unit_scale --total $n_files > /dev/null

n_files=$(unzip -l $BASE_PATH/datasets/FFHQ-1024-2.zip | tail -n 1 | awk '{print $2}')
unzip -o  $BASE_PATH/datasets/FFHQ-1024-2.zip -d $FFHQ_RAW_DATA | tqdm --desc "FFHQ-1024-2.zip extracted" --unit files --unit_scale --total $n_files > /dev/null

echo "Flattening FFHQ directory structure..."
mv $FFHQ_RAW_DATA/FFHQ-1024-1/*.png $FFHQ_RAW_DATA/
mv $FFHQ_RAW_DATA/FFHQ-1024-1/*.txt $FFHQ_RAW_DATA/
mv $FFHQ_RAW_DATA/FFHQ-1024-2/*.png $FFHQ_RAW_DATA/
mv $FFHQ_RAW_DATA/FFHQ-1024-2/*.txt $FFHQ_RAW_DATA/
find $FFHQ_RAW_DATA -mindepth 1 -type d -empty -delete


