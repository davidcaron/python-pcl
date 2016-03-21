from libc.stddef cimport size_t

from libcpp.vector cimport vector
from libcpp.string cimport string
from libcpp cimport bool

# main
cimport pcl_defs as cpp

# boost
from boost_shared_ptr cimport shared_ptr

###############################################################################
# Types
###############################################################################

### base class ###

# keypoint.h
# template <typename PointInT, typename PointOutT>
# class Keypoint : public PCLBase<PointInT>
cdef extern from "pcl/keypoints/keypoint.h" namespace "pcl":
    cdef cppclass Keypoint[In, Out](cpp.PCLBase[In]):
        Keypoint ()
        # public:
        # brief Provide a pointer to the input dataset that we need to estimate features at every point for.
        # param cloud the const boost shared pointer to a PointCloud message
        # void setSearchSurface (const PointCloudInConstPtr &cloud)
        # brief Get a pointer to the surface point cloud dataset.
        # PointCloudInConstPtr getSearchSurface ()
        # brief Provide a pointer to the search object.
        # \param tree a pointer to the spatial search object.
        # void setSearchMethod (const KdTreePtr &tree)
        # \brief Get a pointer to the search method used.
        # KdTreePtr getSearchMethod ()
        # * \brief Get the internal search parameter.
        inline double getSearchParameter ()
        # * \brief Set the number of k nearest neighbors to use for the feature estimation.
        # * \param k the number of k-nearest neighbors
        inline void setKSearch (int k)
        # * \brief get the number of k nearest neighbors used for the feature estimation. */
        inline int getKSearch ()
        # * \brief Set the sphere radius that is to be used for determining the nearest neighbors used for the key point detection
        # * \param radius the sphere radius used as the maximum distance to consider a point a neighbor
        inline void setRadiusSearch (double radius)
        # /** \brief Get the sphere radius used for determining the neighbors. */
        inline double getRadiusSearch ()
        # * \brief Base method for key point detection for all points given in <setInputCloud (), setIndices ()> using
        # * the surface in setSearchSurface () and the spatial locator in setSearchMethod ()
        # * \param output the resultant point cloud model dataset containing the estimated features
        # inline void compute (PointCloudOut &output);
        # * \brief Search for k-nearest neighbors using the spatial locator from \a setSearchmethod, and the given surface
        # * from \a setSearchSurface.
        # * \param index the index of the query point
        # * \param parameter the search parameter (either k or radius)
        # * \param indices the resultant vector of indices representing the k-nearest neighbors
        # * \param distances the resultant vector of distances representing the distances from the query point to the
        # * k-nearest neighbors
        inline int searchForNeighbors (int index, double parameter, vector[int] &indices, vector[float] &distances)
        # protected:
        # using PCLBase<PointInT>::deinitCompute;
        # virtual bool initCompute ();
        # /** \brief The key point detection method's name. */
        # std::string name_;
        # /** \brief The search method template for indices. */
        # SearchMethod search_method_;
        # /** \brief The search method template for points. */
        # SearchMethodSurface search_method_surface_;
        # /** \brief An input point cloud describing the surface that is to be used for nearest neighbors estimation. */
        # PointCloudInConstPtr surface_;
        # /** \brief A pointer to the spatial search object. */
        # KdTreePtr tree_;
        # /** \brief The actual search parameter (casted from either \a search_radius_ or \a k_). */
        # double search_parameter_;
        # /** \brief The nearest neighbors search radius for each point. */
        # double search_radius_;
        # /** \brief The number of K nearest neighbors to use for each point. */
        # int k_;
        # /** \brief Get a string representation of the name of this class. */
        # string getClassName ()
        # /** \brief Abstract key point detection method. */
        # virtual void detectKeypoints (PointCloudOut &output) = 0;
###

# harris_keypoint3D.h (1.6.0)
# harris_3d.h (1.7.2)
# template <typename PointInT, typename PointOutT, typename NormalT = pcl::Normal>
# class HarrisKeypoint3D : public Keypoint<PointInT, PointOutT>
# cdef extern from "pcl/keypoints/harris_keypoint3D.h" namespace "pcl":
#     cdef cppclass HarrisKeypoint3D[In, Out, NormalT](Keypoint[In, Out]):
#         HarrisKeypoint3D ()
#         # HarrisKeypoint3D (ResponseMethod method = HARRIS, float radius = 0.01f, float threshold = 0.0f)
#         # typedef typename Keypoint<PointInT, PointOutT>::PointCloudIn PointCloudIn;
#         # typedef typename Keypoint<PointInT, PointOutT>::PointCloudOut PointCloudOut;
#         # typedef typename Keypoint<PointInT, PointOutT>::KdTree KdTree;
#         # typedef typename PointCloudIn::ConstPtr PointCloudInConstPtr;
#         # typedef typename pcl::PointCloud<NormalT> PointCloudN;
#         # typedef typename PointCloudN::Ptr PointCloudNPtr;
#         # typedef typename PointCloudN::ConstPtr PointCloudNConstPtr;
#         # using Keypoint<PointInT, PointOutT>::name_;
#         # using Keypoint<PointInT, PointOutT>::input_;
#         # using Keypoint<PointInT, PointOutT>::indices_;
#         # using Keypoint<PointInT, PointOutT>::surface_;
#         # using Keypoint<PointInT, PointOutT>::tree_;
#         # using Keypoint<PointInT, PointOutT>::k_;
#         # using Keypoint<PointInT, PointOutT>::search_radius_;
#         # using Keypoint<PointInT, PointOutT>::search_parameter_;
#         # using Keypoint<PointInT, PointOutT>::initCompute;
#         # typedef enum {HARRIS = 1, NOBLE, LOWE, TOMASI, CURVATURE} ResponseMethod;
#         # * \brief Set the method of the response to be calculated.
#         # * \param[in] type
#         # void setMethod (ResponseMethod type)
#         # * \brief Set the radius for normal estimation and non maxima supression.
#         # * \param[in] radius
#         void setRadius (float radius)
#         # * \brief Set the threshold value for detecting corners. This is only evaluated if non maxima suppression is turned on.
#         # * \brief note non maxima suppression needs to be activated in order to use this feature.
#         # * \param[in] threshold
#         void setThreshold (float threshold)
#         # * \brief Whether non maxima suppression should be applied or the response for each point should be returned
#         # * \note this value needs to be turned on in order to apply thresholding and refinement
#         # * \param[in] nonmax default is false
#         void setNonMaxSupression (bool = false)
#         # * \brief Whether the detected key points should be refined or not. If turned of, the key points are a subset of the original point cloud. Otherwise the key points may be arbitrary.
#         # * \brief note non maxima supression needs to be on in order to use this feature.
#         # * \param[in] do_refine
#         void setRefine (bool do_refine)
#         # * \brief Set normals if precalculated normals are available.
#         # * \param normals
#         # void setNormals (const PointCloudNPtr &normals)
#         # * \brief Provide a pointer to a dataset to add additional information
#         # * to estimate the features for every point in the input dataset.  This
#         # * is optional, if this is not set, it will only use the data in the
#         # * input cloud to estimate the features.  This is useful when you only
#         # * need to compute the features for a downsampled cloud.
#         # * \param[in] cloud a pointer to a PointCloud message
#         # virtual void setSearchSurface (const PointCloudInConstPtr &cloud)
#         # * \brief Initialize the scheduler and set the number of threads to use.
#         # * \param nr_threads the number of hardware threads to use (-1 sets the value back to automatic)
#         inline void setNumberOfThreads (int nr_threads)
#         # protected:
#         # bool initCompute ();
#         # void detectKeypoints (PointCloudOut &output);
#         # /** \brief gets the corner response for valid input points*/
#         # void responseHarris (PointCloudOut &output) const;
#         # void responseNoble (PointCloudOut &output) const;
#         # void responseLowe (PointCloudOut &output) const;
#         # void responseTomasi (PointCloudOut &output) const;
#         # void responseCurvature (PointCloudOut &output) const;
#         # void refineCorners (PointCloudOut &corners) const;
#         # /** \brief calculates the upper triangular part of unnormalized covariance matrix over the normals given by the indices.*/
#         # void calculateNormalCovar (const std::vector<int>& neighbors, float* coefficients) const;
###

# narf_keypoint.h
# class PCL_EXPORTS NarfKeypoint : public Keypoint<PointWithRange, int>
# cdef extern from "pcl/keypoints/narf_keypoint.h" namespace "pcl":
#        cdef cppclass NarfKeypoint(Keypoint[PointWithRange, int]):
#           NarfKeypoint ()
#           # NarfKeypoint (RangeImageBorderExtractor* range_image_border_extractor=NULL, float support_size=-1.0f);
#           public:
#           // =====TYPEDEFS=====
#           typedef Keypoint<PointWithRange, int> BaseClass;
#           typedef Keypoint<PointWithRange, int>::PointCloudOut PointCloudOut;
#           // =====PUBLIC STRUCTS=====
#           //! Parameters used in this class
#           cdef struct Parameters
#               Parameters() : support_size(-1.0f), max_no_of_interest_points(-1), min_distance_between_interest_points(0.25f),
#                      optimal_distance_to_high_surface_change(0.25), min_interest_value(0.45f),
#                      min_surface_change_score(0.2f), optimal_range_image_patch_size(10),
#                      distance_for_additional_points(0.0f), add_points_on_straight_edges(false),
#                      do_non_maximum_suppression(true), no_of_polynomial_approximations_per_point(0),
#                      max_no_of_threads(1), use_recursive_scale_reduction(false),
#                      calculate_sparse_interest_image(true) {}
#       
#               float support_size;  //!< This defines the area 'covered' by an interest point (in meters)
#               int max_no_of_interest_points;  //!< The maximum number of interest points that will be returned
#               float min_distance_between_interest_points;  /**< Minimum distance between maximas
#                                                      *  (this is a factor for support_size, i.e. the distance is
#                                                      *  min_distance_between_interest_points*support_size) */
#               float optimal_distance_to_high_surface_change;  /**< The distance we want keep between keypoints and areas
#                                                         *  of high surface change
#                                                         *  (this is a factor for support_size, i.e., the distance is
#                                                         *  optimal_distance_to_high_surface_change*support_size) */
#               float min_interest_value;  //!< The minimum value to consider a point as an interest point
#               float min_surface_change_score;  //!< The minimum value  of the surface change score to consider a point
#               int optimal_range_image_patch_size;  /**< The size (in pixels) of the image patches from which the interest value
#                                              *  should be computed. This influences, which range image is selected from
#                                              *  the scale space to compute the interest value of a pixel at a certain
#                                              *  distance. */
#               // TODO:
#               float distance_for_additional_points;  /**< All points in this distance to a found maximum, that
#                                                *  are above min_interest_value are also added as interest points
#                                                *  (this is a factor for support_size, i.e. the distance is
#                                                *  distance_for_additional_points*support_size) */
#               bool add_points_on_straight_edges;  /**< If this is set to true, there will also be interest points on
#                                             *   straight edges, e.g., just indicating an area of high surface change */
#               bool do_non_maximum_suppression;  /**< If this is set to false there will be much more points
#                                           *  (can be used to spread points over the whole scene
#                                           *  (combined with a low min_interest_value)) */
#               bool no_of_polynomial_approximations_per_point; /**< If this is >0, the exact position of the interest point is
#                                                            determined using bivariate polynomial approximations of the
#                                                            interest values of the area. */
#               int max_no_of_threads;  //!< The maximum number of threads this code is allowed to use with OPNEMP
#               bool use_recursive_scale_reduction;  /**< Try to decrease runtime by extracting interest points at lower reolution
#                                              *  in areas that contain enough points, i.e., have lower range. */
#               bool calculate_sparse_interest_image;  /**< Use some heuristics to decide which areas of the interest image
#                                                   can be left out to improve the runtime. */
#           };
# 
#     		// =====PUBLIC METHODS=====
#     		//! Erase all data calculated for the current range image
#     		void clearData ();
#     		//! Set the RangeImageBorderExtractor member (required)
#     		void setRangeImageBorderExtractor (RangeImageBorderExtractor* range_image_border_extractor);
#     		//! Get the RangeImageBorderExtractor member
#     		RangeImageBorderExtractor* getRangeImageBorderExtractor ()
#     		//! Set the RangeImage member of the RangeImageBorderExtractor
#     		void setRangeImage (const RangeImage* range_image)
#     		/** Extract interest value per image point */
#     		float* getInterestImage () { calculateInterestImage(); return interest_image_;}
#     		//! Extract maxima from an interest image
#     		const ::pcl::PointCloud<InterestPoint>& getInterestPoints () { calculateInterestPoints(); return *interest_points_;}
#     		//! Set all points in the image that are interest points to true, the rest to false
#     		const std::vector<bool>& getIsInterestPointImage ()
#     		//! Getter for the parameter struct
#     		Parameters& getParameters ()
#     		//! Getter for the range image of range_image_border_extractor_
#     		const RangeImage& getRangeImage ();
#     		//! Overwrite the compute function of the base class
#     		void compute (PointCloudOut& output);
#			
#     		protected:
#     		void calculateScaleSpace ();
#     		void calculateInterestImage ();
#     		void calculateCompleteInterestImage ();
#     		void calculateSparseInterestImage ();
#     		void calculateInterestPoints ();
#     		virtual void detectKeypoints (PointCloudOut& output);
#     		using BaseClass::name_;
#     		RangeImageBorderExtractor* range_image_border_extractor_;
#     		Parameters parameters_;
#     		float* interest_image_;
#     		::pcl::PointCloud<InterestPoint>* interest_points_;
#     		std::vector<bool> is_interest_point_image_;
#     		std::vector<RangeImage*> range_image_scale_space_;
#     		std::vector<RangeImageBorderExtractor*> border_extractor_scale_space_;
#     		std::vector<float*> interest_image_scale_space_;
#
# ingroup keypoints
# inline std::ostream& operator << (std::ostream& os, const NarfKeypoint::Parameters& p)
# 
###

# sift_keypoint.h
# template <typename PointInT, typename PointOutT>
# class SIFTKeypoint : public Keypoint<PointInT, PointOutT>
cdef extern from "pcl/keypoints/sift_keypoint.h" namespace "pcl":
    cdef cppclass SIFTKeypoint[In, Out](Keypoint[In, Out]):
        SIFTKeypoint ()
        # public:
        # /** \brief Specify the range of scales over which to search for keypoints
        # * \param min_scale the standard deviation of the smallest scale in the scale space
        # * \param nr_octaves the number of octaves (i.e. doublings of scale) to compute 
        # * \param nr_scales_per_octave the number of scales to compute within each octave
        void setScales (float min_scale, int nr_octaves, int nr_scales_per_octave)
        # /** \brief Provide a threshold to limit detection of keypoints without sufficient contrast
        # * \param min_contrast the minimum contrast required for detection
        void setMinimumContrast (float min_contrast)
        # protected:
        # bool initCompute ();
        # /** \brief Detect the SIFT keypoints for a set of points given in setInputCloud () using the spatial locator in 
        # * setSearchMethod ().
        # * \param output the resultant cloud of keypoints
        # void detectKeypoints (PointCloudOut &output);
###

# smoothed_surfaces_keypoint.h
# template <typename PointT, typename PointNT>
# class SmoothedSurfacesKeypoint : public Keypoint <PointT, PointT>
cdef extern from "pcl/keypoints/smoothed_surfaces_keypoint.h" namespace "pcl":
    cdef cppclass SmoothedSurfacesKeypoint[In, Out](Keypoint[In, Out]):
        SmoothedSurfacesKeypoint ()
        # public:
        # void addSmoothedPointCloud (const PointCloudTConstPtr &cloud,
        #                      const PointCloudNTConstPtr &normals,
        #                      KdTreePtr &kdtree,
        #                      float &scale);
        void resetClouds ()
        # inline void setNeighborhoodConstant (float neighborhood_constant)
        # inline float getNeighborhoodConstant ()
        # inline void setInputNormals (const PointCloudNTConstPtr &normals)
        # inline void setInputScale (float input_scale)
        # void detectKeypoints (PointCloudT &output);
        # protected:
        # bool initCompute ();
###

# uniform_sampling.h
# template <typename PointInT>
# class UniformSampling: public Keypoint<PointInT, int>
cdef extern from "pcl/keypoints/uniform_sampling.h" namespace "pcl":
    cdef cppclass UniformSampling[In](Keypoint[In, int]):
        UniformSampling ()
        # public:
        # /** \brief Set the 3D grid leaf size.
        # * \param radius the 3D grid leaf size
        void setRadiusSearch (double radius)
        # protected:
        # brief Simple structure to hold an nD centroid and the number of points in a leaf.
        # struct Leaf
        # {
        #   Leaf () : idx (-1) { }
        #   int idx;
        # };
        # /** \brief The 3D grid leaves. */
        # boost::unordered_map<size_t, Leaf> leaves_;
        # /** \brief The size of a leaf. */
        # Eigen::Vector4f leaf_size_;
        # /** \brief Internal leaf sizes stored as 1/leaf_size_ for efficiency reasons. */ 
        # Eigen::Array4f inverse_leaf_size_;
        # /** \brief The minimum and maximum bin coordinates, the number of divisions, and the division multiplier. */
        # Eigen::Vector4i min_b_, max_b_, div_b_, divb_mul_;
        # /** \brief Downsample a Point Cloud using a voxelized grid approach
        # * \param output the resultant point cloud message
        # */
        # void detectKeypoints (PointCloudOut &output);

ctypedef UniformSampling[cpp.PointXYZ] UniformSampling_t
ctypedef UniformSampling[cpp.PointXYZI] UniformSampling_PointXYZI_t
ctypedef UniformSampling[cpp.PointXYZRGB] UniformSampling_PointXYZRGB_t
ctypedef UniformSampling[cpp.PointXYZRGBA] UniformSampling_PointXYZRGBA_t
ctypedef shared_ptr[UniformSampling[cpp.PointXYZ]] UniformSamplingPtr_t
ctypedef shared_ptr[UniformSampling[cpp.PointXYZI]] UniformSampling_PointXYZI_Ptr_t
ctypedef shared_ptr[UniformSampling[cpp.PointXYZRGB]] UniformSampling_PointXYZRGB_Ptr_t
ctypedef shared_ptr[UniformSampling[cpp.PointXYZRGBA]] UniformSampling_PointXYZRGBA_Ptr_t
###
