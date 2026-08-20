Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D807342A179;
	Thu, 20 Aug 2026 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225205; cv=none; b=BBYuvRbOash+FZEGxWOT1m21F8TYDbHF35LouorTp8AsdvEh1T1heAu5L6lP+Gs1GjepV+lLOOBzs8ABMWCxNbnhF2vIDVDfyBPE28muFH7I5rE2oB3UMgIJjHdhF2YHyFxcilpMaiwJsqIjY9B7R/8jY0i+Bt+imH9MdtW/qxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225205; c=relaxed/simple;
	bh=RnEVAyO3fZbxn2usfvwOSgGAYa6AXEOJc0x8HTbo96s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLhMUyxKqAhcMlJwZmioiG1/MmT+6SIPuUjpEWe1t9U1iHssuVszSou58aJyziWsAIUnUGqi+FfAXWOtVNVCU8RtIWEphclwGf9QGn9Wx+EpX4/KNmJQlargDeB7GGCCVmK5cEbsSSBCD3dTrtVo/OAv66xVfaecN1tko1W8msc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cseTX6em; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cseTX6em"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787225203; x=1818761203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RnEVAyO3fZbxn2usfvwOSgGAYa6AXEOJc0x8HTbo96s=;
  b=cseTX6emByO+9faGfA0yOIxOM4tLkOlvmDzgfK1eJC4mdO7ln8jYgunS
   BbSlAkG4LNHyL2gTvf+Z4vqHV8hBB4hopw6ae4lybuormopHQOFQ0wixl
   GeeTWSpD5Qb1GTsbRviPI2mRUA/wkhJOAwkEqCYYze+nhWqY5BEkP9L6i
   tmPOU0L7rgVrm2OBrD84bI7TdVx591LnTNbo1v/TpZntD5k7LErcZ59KO
   1p9/MgCJ2Pb4aZEQ923b8k4PIk5DIE6R+LgOS7wd183uSJmORTH3DfjFe
   3Fb3K6sHdzYNAouYKh0KVNHv+FQp9Dz2Ir9jrX1C0Hsolqo3shq7pN3j3
   w==;
X-CSE-ConnectionGUID: jaXCdLuJQDmARrkU0mzAmg==
X-CSE-MsgGUID: JEA2vqSmQ4ehV2u/PnBVrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="75289086"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="75289086"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 04:26:40 -0700
X-CSE-ConnectionGUID: BRZJeUzHQna/IO9H0wSuXg==
X-CSE-MsgGUID: m3u0VzXmTrO5nsAdAX0Rqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="270226539"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 20 Aug 2026 04:26:38 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wx0up-00000000iol-2p44;
	Thu, 20 Aug 2026 11:26:35 +0000
Date: Thu, 20 Aug 2026 19:25:46 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Anubhav Shelat <ashelat@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Fuad Tabba <tabba@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v3] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Message-ID: <202608201957.NHoAQjoy-lkp@intel.com>
References: <20260810160708.3460a2fd@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810160708.3460a2fd@gandalf.local.home>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on v7.2]
[also build test ERROR on next-20260819]
[cannot apply to trace/for-next linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracefs-Add-read-only-eventfs-filesystem-at-sys-kernel-events/20260810-160708
base:   v7.2
patch link:    https://lore.kernel.org/r/20260810160708.3460a2fd%40gandalf.local.home
patch subject: [PATCH v3] tracefs: Add read-only eventfs filesystem at /sys/kernel/events
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260820/202608201957.NHoAQjoy-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608201957.NHoAQjoy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608201957.NHoAQjoy-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/tracefs/event_inode.c:38:16: error: use of undeclared identifier 'EVENTFS_SUPER_MAGIC'
      38 |         sb->s_magic = EVENTFS_SUPER_MAGIC;
         |                       ^~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +/EVENTFS_SUPER_MAGIC +38 fs/tracefs/event_inode.c

    30	
    31	static int eventfs_ro_fill_super(struct super_block *sb, struct fs_context *fc)
    32	{
    33		struct inode *inode;
    34		struct dentry *root;
    35	
    36		sb->s_blocksize = PAGE_SIZE;
    37		sb->s_blocksize_bits = PAGE_SHIFT;
  > 38		sb->s_magic = EVENTFS_SUPER_MAGIC;
    39		sb->s_op = &eventfs_ro_super_operations;
    40		sb->s_time_gran = 1;
    41		sb->s_flags |= SB_RDONLY;
    42	
    43		inode = new_inode(sb);
    44		if (!inode)
    45			return -ENOMEM;
    46	
    47		inode->i_ino = 1;
    48		inode->i_mode = S_IFDIR | 0555;
    49		simple_inode_init_ts(inode);
    50		inode->i_op = &simple_dir_inode_operations;
    51		inode->i_fop = &simple_dir_operations;
    52		set_nlink(inode, 2);
    53	
    54		set_default_d_op(sb, &tracefs_dentry_operations);
    55	
    56		root = d_make_root(inode);
    57		if (!root)
    58			return -ENOMEM;
    59	
    60		sb->s_root = root;
    61	
    62		return 0;
    63	}
    64	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
