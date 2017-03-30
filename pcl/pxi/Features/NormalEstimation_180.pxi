# -*- coding: utf-8 -*-
cimport _pcl
from libcpp.vector cimport vector
from libcpp cimport bool

cimport pcl_defs as cpp
cimport pcl_features_180 as pclftr


cdef class NormalEstimation:
    """
    NormalEstimation class for
    """
    cdef pclftr.NormalEstimation_t *me

    def __cinit__(self):
        self.me = new pclftr.NormalEstimation_t()

    def __dealloc__(self):
        del self.me

    def set_SearchMethod(self, _pcl.KdTree kdtree):
        self.me.setSearchMethod(kdtree.thisptr_shared)

    def set_RadiusSearch(self, double param):
        self.me.setRadiusSearch(param)

    def set_KSearch (self, int param):
        self.me.setKSearch (param)

    def compute(self):
        normal = PointCloud_Normal()
        cdef cpp.PointCloud_Normal_t *cNormal = <cpp.PointCloud_Normal_t*>normal.thisptr()
        self.me.compute (deref(cNormal))
        return normal

cdef class NormalEstimationOMP:
    """
    NormalEstimation class for
    """
    cdef pclftr.NormalEstimationOMP_t *me

    def __cinit__(self):
        self.me = new pclftr.NormalEstimationOMP_t()

    def __init__(self, nr_threads=0):
        if nr_threads:
            self.me.setNumberOfThreads(nr_threads)

    def __dealloc__(self):
        del self.me

    def set_SearchMethod(self, _pcl.KdTree kdtree):
        self.me.setSearchMethod(kdtree.thisptr_shared)

    def set_RadiusSearch(self, double param):
        self.me.setRadiusSearch(param)

    def set_KSearch (self, int param):
        self.me.setKSearch (param)

    def set_NumberOfThreads (self, unsigned int nr_threads=0):
        self.me.setNumberOfThreads(nr_threads)

    def compute(self):
        normal = PointCloud_Normal()
        cdef cpp.PointCloud_Normal_t *cNormal = <cpp.PointCloud_Normal_t*>normal.thisptr()
        with nogil:
            self.me.compute (deref(cNormal))
        return normal
