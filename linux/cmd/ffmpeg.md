# ffmpeg常用命令

强制覆盖输出文件：
```bash
# -y用户强制覆盖输出文件，例如：
ffmpeg -i input_video.mp4 -y output_video.avi
ffmpeg -i input_img.jpg -vf scale=1024:-1 -y output_img.jpg
```

转换视频或图片大小：
```bash
# 指定转换之后的大小
ffmpeg -i input_img.jpg -vf scale=1024:720 output_img.jpg
# 指定一个维度，另一个维度自动计算
ffmpeg -i input_img.jpg -vf scale=1024:-1 output_img.jpg
```

提取视频中某一帧并保存到图片：
```bash
# -ss指定秒数
ffmpeg -ss 2 -i test.mp4 output_img.png
```

提取视频或者音频的一段：
```bash
# -ss指定起始时间，-t指定时长
ffmpeg -i input.mp4 -ss 00:00:30.0 -t 00:00:10.0 output.mp4
ffmpeg -i input.mp4 -ss 30 -t 10 output.mp4
```

转换视频格式：
```bash
ffmpeg -i input_video.mp4 output_video.avi
```

将多个图片合并为视频：
```bash
# 图片文件名需要满足一定的pattern
ffmpeg -framerate 15 -i img_%012d.png -vcodec libx264 -pix_fmt yuv420p -vf hflip output_video.mp4
```
