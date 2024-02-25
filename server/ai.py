import cv2
import numpy as np

# Load the images
img1 = cv2.imread('a.jpg',0)
img2 = cv2.imread('c.jpg',0)

# Initialize the ORB detector
orb = cv2.ORB_create()

# Detect keypoints and compute descriptors
kp1, des1 = orb.detectAndCompute(img1, None)
kp2, des2 = orb.detectAndCompute(img2, None)

# Initialize the BFMatcher
bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)

# Match the descriptors
matches = bf.match(des1, des2)

# Sort the matches by distance
matches = sorted(matches, key=lambda x:x.distance)

# Compute the homography matrix
src_pts = np.float32([ kp1[m.queryIdx].pt for m in matches ]).reshape(-1,1,2)
dst_pts = np.float32([ kp2[m.trainIdx].pt for m in matches ]).reshape(-1,1,2)
M, mask = cv2.findHomography(src_pts, dst_pts, cv2.RANSAC,5.0)

# Check if the homography matrix is close to the identity matrix
if np.allclose(M, np.eye(3), atol=0.1):
    print("The images were taken from the same location and camera angle.")
else:
    print("The images were taken from different locations or camera angles.")