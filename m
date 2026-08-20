Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5BB3839B7;
	Thu, 20 Aug 2026 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787203987; cv=none; b=rDqxI8IK1KFbtoSvuO8+ODV3+Cd/+U5tHk6gvxVR6A4KraygbGy7R8UtM1MmYYdeLmYscxkDj06jnNmszXAV753gjBvQC7EsqmXCwi50Bgh1mV2m04od+kcC9O2sVGKJpiscJcaUnTkMgnkhiopfzusZLyJnt4rTNN74jfv7LTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787203987; c=relaxed/simple;
	bh=3S1bSnlBhWx4HK5AwtWT7IpvRgMAbGMSQk5Azw7D0/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqIWBAQYPVlzQIKqj5XAJUosPylB44n34gQlKJljnkJTHaVs3VnLKfq/EUQPn7bO+dt2DASc6bpy9lhKx64jcJM3e0U0CYQNqEwqU60gvZ4sXcJTkI12SFWmA0JPX2FInJ1Mk+CN4jCRTzMyxoIU4hQXh13s050FJESc6kklcSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWat4R3G; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWat4R3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787203985; x=1818739985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3S1bSnlBhWx4HK5AwtWT7IpvRgMAbGMSQk5Azw7D0/Q=;
  b=OWat4R3GlSmMhLBnzpj1bJWf/+uPX7maVdzxpezdMANUC2OLa4hCvJ+E
   +eOaGgRtZP1ZyEUoelvZfqjNCMCR6bKEbAjQSRuw3wuKimykw5c2N5gZf
   AGyNvuL0MZdgnj7Dtcg8ynwgpI0QYk4YymorqzaB8VVXBr9HWl5cov31r
   Os7T/OQllaqtQWfAIzKUsiNFA3vYtaXfVgjMoh5C6/4n6POOMMmQ9nYmp
   BKzSRRQ8Osf/CIxtaax8b4Nz5OhLzw6ekFH3SIc/u1C9znwKfLTw7/u5o
   VMffzqgl/bggKb+8VrUzBRavmR57QWJnVsuZJnQd7iTpMTo+jlSr3//gg
   g==;
X-CSE-ConnectionGUID: ZktltSYxSIG/pNmfsvOAng==
X-CSE-MsgGUID: xE/x0W2iTVKnjCA8z/x+5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87850297"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="87850297"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 22:33:04 -0700
X-CSE-ConnectionGUID: 7cZX4p2jQnu1irIj4tXWwQ==
X-CSE-MsgGUID: jgjBOSHGQgqyiWsPptTYkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="262055988"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 19 Aug 2026 22:33:01 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwvOc-00000000hx3-2mfN;
	Thu, 20 Aug 2026 05:32:58 +0000
Date: Thu, 20 Aug 2026 13:32:21 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Anubhav Shelat <ashelat@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Fuad Tabba <tabba@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v3] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Message-ID: <202608201306.OB6m5zzX-lkp@intel.com>
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
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260820/202608201306.OB6m5zzX-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608201306.OB6m5zzX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608201306.OB6m5zzX-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/tracefs/event_inode.c: In function 'eventfs_ro_fill_super':
>> fs/tracefs/event_inode.c:38:23: error: 'EVENTFS_SUPER_MAGIC' undeclared (first use in this function)
      38 |         sb->s_magic = EVENTFS_SUPER_MAGIC;
         |                       ^~~~~~~~~~~~~~~~~~~
   fs/tracefs/event_inode.c:38:23: note: each undeclared identifier is reported only once for each function it appears in


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
