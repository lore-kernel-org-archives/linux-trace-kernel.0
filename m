Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFECEB64DC
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 14 Jul 2023 16:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbjGNQpo (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 14 Jul 2023 12:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjGNQpn (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:45:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A56E30FD
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689353142; x=1720889142;
  h=date:from:to:cc:subject:message-id;
  bh=xcVGswnD6I+8T/ksdeDJeVxVJFRlkTbHkPcxLWQ61zU=;
  b=a4imnQwPjUjUGU60Q/VJv8bu4IGx1X3v2kkKZXH2yj508N4qT7RcjIAO
   2cwn5uhIBALkrOKk8X+Z03ID5VwU/WntdjR18CM+tYjuJLMma6bq88flp
   gVcOtNVC1LNvL3iD9/6kj2e2pQfnMsSXvpSamiuFy249Zy7nUgzPcgsPk
   fjz26RElzu1DJZL6ze2w7u87wgNf1kbUbTxdH9wrSqeEvXkN29X99SIQV
   FKz46SB40OfSw1+UQEoZPwN2xMOXXBo2hnn8Pry6XJigTru1F8C9Af3V0
   agsvYdvrvjwWbGCv05CFgnel/udktfSfr2xkleNnlT4sg7NbGYlHKhX1z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="429278955"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="429278955"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 09:45:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="699737595"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="699737595"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2023 09:45:39 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKLvH-0007ZG-0T;
        Fri, 14 Jul 2023 16:45:39 +0000
Date:   Sat, 15 Jul 2023 00:44:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 7c2878be573282a9961c359b806ccf70afe1a6b6
Message-ID: <202307150046.Yvsvcm5y-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 7c2878be573282a9961c359b806ccf70afe1a6b6  Add linux-next specific files for 20230714

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306260401.qZlYQpV2-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/mfd/max77541.c:176:18: warning: cast to smaller integer type 'enum max7754x_ids' from 'const void *' [-Wvoid-pointer-to-enum-cast]

Unverified Error/Warning (likely false positive, please contact us if interested):

kernel/trace/trace_functions_graph.c:1012 print_graph_return() warn: bitwise AND condition is false here
kernel/trace/trace_functions_graph.c:726 print_graph_entry_leaf() warn: bitwise AND condition is false here
{standard input}: Error: local label `"2" (instance number 9 of a fb label)' is not defined

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021-20230713
|   |-- kernel-trace-trace_functions_graph.c-print_graph_entry_leaf()-warn:bitwise-AND-condition-is-false-here
|   `-- kernel-trace-trace_functions_graph.c-print_graph_return()-warn:bitwise-AND-condition-is-false-here
`-- sh-allmodconfig
    `-- standard-input:Error:local-label-(instance-number-of-a-fb-label)-is-not-defined
clang_recent_errors
|-- x86_64-randconfig-x001-20230714
|   `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void
|-- x86_64-randconfig-x002-20230714
|   `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void
`-- x86_64-randconfig-x004-20230714
    `-- drivers-mfd-max77541.c:warning:cast-to-smaller-integer-type-enum-max7754x_ids-from-const-void

elapsed time: 722m

configs tested: 140
configs skipped: 8

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r004-20230714   gcc  
arc                  randconfig-r043-20230714   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                            qcom_defconfig   gcc  
arm                  randconfig-r001-20230714   clang
arm                  randconfig-r046-20230714   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230714   gcc  
hexagon              randconfig-r021-20230714   clang
hexagon              randconfig-r041-20230714   clang
hexagon              randconfig-r045-20230714   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230714   gcc  
i386         buildonly-randconfig-r005-20230714   gcc  
i386         buildonly-randconfig-r006-20230714   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230714   gcc  
i386                 randconfig-i002-20230714   gcc  
i386                 randconfig-i003-20230714   gcc  
i386                 randconfig-i004-20230714   gcc  
i386                 randconfig-i005-20230714   gcc  
i386                 randconfig-i006-20230714   gcc  
i386                 randconfig-i011-20230714   clang
i386                 randconfig-i012-20230714   clang
i386                 randconfig-i013-20230714   clang
i386                 randconfig-i014-20230714   clang
i386                 randconfig-i015-20230714   clang
i386                 randconfig-i016-20230714   clang
i386                 randconfig-r003-20230714   gcc  
i386                 randconfig-r005-20230714   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230714   gcc  
loongarch            randconfig-r025-20230714   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230714   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                           ip28_defconfig   clang
mips                malta_qemu_32r6_defconfig   clang
mips                 randconfig-r006-20230714   clang
mips                 randconfig-r023-20230714   gcc  
mips                          rm200_defconfig   clang
mips                           rs90_defconfig   clang
mips                   sb1250_swarm_defconfig   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r036-20230714   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                      makalu_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                     ppa8548_defconfig   clang
powerpc              randconfig-r004-20230714   gcc  
powerpc              randconfig-r012-20230714   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r006-20230714   gcc  
riscv                randconfig-r042-20230714   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230714   gcc  
s390                 randconfig-r044-20230714   clang
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                   randconfig-r001-20230714   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r034-20230714   gcc  
sparc64              randconfig-r003-20230714   gcc  
sparc64              randconfig-r033-20230714   gcc  
sparc64              randconfig-r035-20230714   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r015-20230714   gcc  
um                   randconfig-r032-20230714   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230714   gcc  
x86_64       buildonly-randconfig-r002-20230714   gcc  
x86_64       buildonly-randconfig-r003-20230714   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230714   clang
x86_64               randconfig-x002-20230714   clang
x86_64               randconfig-x003-20230714   clang
x86_64               randconfig-x004-20230714   clang
x86_64               randconfig-x005-20230714   clang
x86_64               randconfig-x006-20230714   clang
x86_64               randconfig-x011-20230714   gcc  
x86_64               randconfig-x012-20230714   gcc  
x86_64               randconfig-x013-20230714   gcc  
x86_64               randconfig-x014-20230714   gcc  
x86_64               randconfig-x015-20230714   gcc  
x86_64               randconfig-x016-20230714   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r024-20230714   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
