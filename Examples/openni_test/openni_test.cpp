#include <iostream>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;

int main()
{
    VideoCapture cam(CAP_OPENNI2);

    Mat color, depth, depC;

    while(true)
    {
        //Grab frames
        cout << cam.grab();
        cam.retrieve( depth, CV_CAP_OPENNI_DEPTH_MAP );
        cam.retrieve( color, CV_CAP_OPENNI_BGR_IMAGE );


        //Process depth -> colormap
        double min, max;
        minMaxIdx(depth, &min, &max);
        depth.convertTo(depth, CV_8UC1, 255./(max-min), -min);
        applyColorMap(depth, depC, COLORMAP_HOT);

        imwrite("color.png", color);
        imwrite("depth.png", depth);

        // //Show
        // imshow("Depth", depC);
        // imshow("Color", color);

        char c = waitKey(30);
        if (c == 'q')
            break;
    }
}