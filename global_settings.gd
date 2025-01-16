extends Node

var pixel_limit:int = 144

var palette_color

var cur_palette

var palettes_white = [Color(0.796, 0.569, 0.451), Color(0.796, 0.796, 0.796), Color(0.918, 0.77, 0.493), Color(0.957, 0.753, 0.584), Color(0.714,0.827,0.867), Color(0.831,0.824,0.608)]
var palettes_light = [Color(0.557, 0.267, 0.239), Color(0.533, 0.533, 0.533), Color(0.67, 0.555, 0.141), Color(0.404, 0.573, 0.537), Color(0.471,0.49,0.702), Color(0.471,0.643,0.416)]
var palettes_dark = [Color(0.318, 0.09, 0.188), Color(0.408, 0.408, 0.408), Color(0.545, 0.373, 0.102), Color(0.114, 0.471, 0.455), Color(0.314,0.239,0.4), Color(0.369,0.522,0.286)]
var palettes_black = [Color(0.196, 0.039, 0.157), Color(0.187, 0.187, 0.187), Color(0.094, 0.077, 0.005), Color(0.027, 0.118, 0.133), Color(0.165,0.094,0.173), Color(0.345,0.267,0.133)]
