# -*- coding: utf-8 -*-
cimport _pcl
cimport pcl_segmentation_180 as pclseg
cimport pcl_kdtree_180 as pclkdtree
cimport pcl_defs as cpp

from boost_shared_ptr cimport sp_assign


cdef class RegionGrowing:
    """
    Segmentation class for Sample Consensus methods and models
    """
    cdef pclseg.RegionGrowing_t *me
    def __cinit__(self):
        self.me = new pclseg.RegionGrowing_t()
    def __dealloc__(self):
        del self.me

    def get_min_cluster_size(self):
        return self.me.getMinClusterSize()

    def set_min_cluster_size(self, int min_size):
        self.me.setMinClusterSize(min_size)

    def get_max_cluster_size(self):
        return self.me.getMaxClusterSize()

    def set_max_cluster_size(self, int max_size):
        self.me.setMaxClusterSize(max_size)

    def get_smoothness_threshold(self):
        return self.me.getSmoothnessThreshold()

    def set_smoothness_threshold(self, float threshold):
        self.me.setSmoothnessThreshold(threshold)

    def get_curvature_threshold(self):
        return self.me.getCurvatureThreshold()

    def set_curvature_threshold(self, float threshold):
        self.me.setCurvatureThreshold(threshold)

    def get_number_of_neighbors(self):
        return self.me.getNumberOfNeighbours()

    def set_number_of_neighbors(self, unsigned int nn):
        self.me.setNumberOfNeighbours(nn)

    def set_search_method(self, _pcl.KdTree kdtree):
       self.me.setSearchMethod(kdtree.thisptr_shared)

    def set_input_normals(self, _pcl.PointCloud_Normal pcn):
       self.me.setInputNormals(pcn.thisptr_shared)

    def extract(self):
        cdef vector[cpp.PointIndices_t] clusters = vector[cpp.PointIndices_t]()
        self.me.extract(clusters)
        cdef vector[vector[int]] result
        cdef int i

        for i in range(clusters.size()):
            result.push_back(clusters[i].indices)

        return result

    def get_segment_from_point(self, int index):
        cdef cpp.PointIndices_t cluster
        self.me.getSegmentFromPoint(index, cluster)
        return cluster.indices

    def get_colored_cloud(self):
        cdef _pcl.PointCloud_PointXYZRGB cloud = _pcl.PointCloud_PointXYZRGB()
        cloud.thisptr_shared = self.me.getColoredCloud()
        return cloud

    def get_colored_cloud_rgba(self):
        cdef _pcl.PointCloud_PointXYZRGBA cloud = _pcl.PointCloud_PointXYZRGBA()
        cloud.thisptr_shared = self.me.getColoredCloudRGBA()
        return cloud
