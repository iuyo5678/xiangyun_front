#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Time-stamp: <2016-01-07 19:04:35 Thursday by zhangguhua>

################################################################################
#                                  _ooOoo_
#                                 o8888888o
#                                 88" . "88
#                                 (| -_- |)
#                                 O\  =  /O
#                              ____/`---'\____
#                            .'  \\|     |//  `.
#                           /  \\|||  z  |||//  \
#                          /  _||||| -g- |||||-  \
#                          |   | \\\  h  /// |   |
#                          | \_|  ''\---/''  |   |
#                          \  .-\__  `-`  ___/-. /
#                        ___`. .'  /--.--\  `. . __
#                     ."" '<  `.___\_<|>_/___.'  >'"".
#                    | | :  `- \`.;`\ _ /`;.`/ - ` : | |
#                    \  \ `-.   \_ __\ /__ _/   .-` /  /
#               ======`-.____`-.___\_____/___.-`____.-'======
#                                  `=---='
#               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#                        佛祖保佑       永无BUG
#                        只加工资       不改需求
###############################################################################
import os
import os
path = os.path.dirname(os.path.abspath(__file__))
print path
def main():
    print "hello world!"
    fp = open(path + "/test.txt", 'a')
    fp.close()
    return 0

if __name__ == "__main__":
    main()