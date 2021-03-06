from libc.stddef cimport size_t

from libcpp.vector cimport vector
from libcpp.string cimport string
from libcpp cimport bool

# main
cimport pcl_defs as cpp

# boost
from boost_shared_ptr cimport shared_ptr


cdef extern from "sensor_msgs/Header.h" namespace "std_msgs":
    cdef struct Header
        Header ()
        # pcl::uint32_t seq
        # pcl::uint64_t stamp
        string frame_id

ctypedef sharedptr[Header] HeaderPtr;
ctypedef sharedptr[Header*] HeaderConstPtr;

# inline std::ostream& operator << (std::ostream& out, const Header &h)
