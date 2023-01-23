Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27298C38142
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 23 Jan 2023 07:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjAWHp1 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 23 Jan 2023 02:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjAWHp0 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 02:45:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD6FA5E3;
        Sun, 22 Jan 2023 23:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674459925; x=1705995925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KIyndeexdTHv4RNt0zG8sPiItU4fljUQ7URxmJcbYtE=;
  b=Nlfqa6uqejgMA3SOfxCjS8GvP2FhAcLK9tLfTzTSPSaTzoa+85c/z6Tu
   BJLyHFmJjYAxo/VQcBIVXSwzICBnXKi76ETvQH5eLpMiOWA2Z7tT7f+fB
   b4WFSOnJA0etXDXQaYA4NubxGqC/tx9m1geIBzNhIAQ3pFQew3WrmHblj
   nK4C5oKiRzmiJPLnv3LvxcVeOTLOXkAU92hKzal03kQdNnmF0bRKwMjtY
   YRvcphggNZvtO6bm8MHidgZIELxXOZ59llpWK4hCJx8HPYA4M20bn3QcA
   rtTopNfUKy4a921rqVsQo5+Fh82TQ+/LeUdpaL9tNkhDkYoekyU3a6+9z
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="390492209"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="390492209"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 23:45:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="785499743"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="785499743"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Jan 2023 23:45:00 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJrVk-0005VE-0k;
        Mon, 23 Jan 2023 07:45:00 +0000
Date:   Mon, 23 Jan 2023 15:44:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ajay Kaher <akaher@vmware.com>, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH 2/8] eventfs: adding eventfs dir add functions
Message-ID: <202301231550.WxxxHvcl-lkp@intel.com>
References: <1674407228-49109-2-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674407228-49109-2-git-send-email-akaher@vmware.com>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi Ajay,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.2-rc5 next-20230123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
patch link:    https://lore.kernel.org/r/1674407228-49109-2-git-send-email-akaher%40vmware.com
patch subject: [PATCH 2/8] eventfs: adding eventfs dir add functions
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20230123/202301231550.WxxxHvcl-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/db5e58a9349f39590a8fb39f0c3373c4c483e064
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
        git checkout db5e58a9349f39590a8fb39f0c3373c4c483e064
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/tracefs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> fs/tracefs/event_inode.c:27:31: sparse: sparse: symbol 'eventfs_root_dir_inode_operations' was not declared. Should it be static?

vim +/eventfs_root_dir_inode_operations +27 fs/tracefs/event_inode.c

    26	
  > 27	const struct inode_operations eventfs_root_dir_inode_operations = {
    28	};
    29	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
