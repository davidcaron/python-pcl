# -*- coding: utf-8 -*-
cimport pcl_segmentation_180 as pclseg
cimport pcl_defs as cpp
from libcpp.vector cimport vector

cdef class ApproximateProgressiveMorphologicalFilter:
    """
    ProgressiveMorphologicalFilter class for Sample Consensus methods and models
    """
    cdef pclseg.ApproximateProgressiveMorphologicalFilter_t *me
    def __cinit__(self):
        self.me = new pclseg.ApproximateProgressiveMorphologicalFilter_t()

    def __dealloc__(self):
        del self.me

    # def segment(self):
    #     cdef cpp.PointIndices ind
    #     cdef cpp.ModelCoefficients coeffs
    #
    #     self.me.segment (ind, coeffs)
    #     return [ind.indices[i] for i in range(ind.indices.size())], \
    #            [coeffs.values[i] for i in range(coeffs.values.size())]

    def set_InputCloud(self, PointCloud cloud):
        self.me.setInputCloud(cloud.thisptr_shared)

    def set_MaxWindowSize(self, size):
        self.me.setMaxWindowSize(size)

    def set_Slope(self, float param):
        self.me.setSlope (param)

    def set_CellSize(self, float cell_size):
        self.me.setCellSize(cell_size)

    def set_Base(self, float base):
        self.me.setBase(base)

    def set_InitialDistance(self, float d):
        self.me.setInitialDistance (d)

    def set_MaxDistance(self, float d):
        self.me.setMaxDistance (d)

    def extract(self):
        cdef vector[int] ind
        self.me.extract (ind)
        return ind




