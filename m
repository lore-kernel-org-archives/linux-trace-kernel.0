Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3F215F4A;
	Wed,  6 Aug 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491207; cv=none; b=VqeONS2O1Yh/OpxipQqoI+rCJUkkY9WCnwH6MchRMxnzUSbEvunGE4y2JArzF0dgEXhn1Pz0QmAMYqXmAOKscvwWO4GwND51IAHiN+/UjC/48XzZrrbWQ+j/mQzen/yN6h8/VvJr7BMD7+4x+Axkb6LwiMN3jbHNmd4ZzvgKGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491207; c=relaxed/simple;
	bh=aLheObBNOVd5wWcfX/UlmeZiWYAW9l+I+b/18Y/UWsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuYgWD5AsC/tOoecV/T202QcV6MQsKe+XV7EJVGGVfXHeMzjHn4uH0sLMOHDGf5r0yYN7rzgHGSxrP2MrjFqKFrMj2/1i1P511OKujrX8KDgJH7Ik6plTIk4nLEIVQfmewyMKrmrgHB0ZkD5x2qtruMRYbm6Iqa3TI58LkVtaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUiBI2+G; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUiBI2+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754491205; x=1786027205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aLheObBNOVd5wWcfX/UlmeZiWYAW9l+I+b/18Y/UWsk=;
  b=HUiBI2+GTtL5ii4QgrJl1fixrXv4ZSM8MoKJAgt0DhJemkSflUOAVlzx
   Ac790g17R8dltPS1plVJTGNYTQSNje/zcOR1dFaF56mqdfJWXy2WehOGG
   VwzNjwQxrROslM/M4fToNowlqec+YYKNIVd4Z0R01uYhxbev41Jgr/9Pc
   jNCZk846/4Pgybjb+yGPmJH2A3bs8u4bAftRMIPOyiOAeYAE2qu2lvCd/
   u0nMtGdUI8yFlhzs9zrENHGcYianQAmmEtN7yuGTARIWnCszABcbseoFA
   f5tOf/Gz9pqubY1GJlQuEaB5Ffnn6C6QotlkOz+KJKCNUxApePcGpaDIj
   Q==;
X-CSE-ConnectionGUID: oj9t9v83RgWRNJarMe+YPg==
X-CSE-MsgGUID: mrjFQZDJQXqzSUGh4qjm8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56889862"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56889862"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 07:40:04 -0700
X-CSE-ConnectionGUID: 5NGPTsi5QaGcZR7dOLyoKw==
X-CSE-MsgGUID: shcTRVviTBSO32SyPM8lpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="188461741"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 06 Aug 2025 07:40:01 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujfJ3-0001m2-0O;
	Wed, 06 Aug 2025 14:39:54 +0000
Date: Wed, 6 Aug 2025 22:39:48 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Takaya Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ian Rogers <irogers@google.com>, aahringo@redhat.com,
	Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [PATCH 3/7] tracing: Have syscall trace events read user space
 string
Message-ID: <202508062230.puMRaDdE-lkp@intel.com>
References: <20250805193235.080757106@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805193235.080757106@kernel.org>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.16 next-20250806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Replace-syscall-RCU-pointer-assignment-with-READ-WRITE_ONCE/20250806-122312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250805193235.080757106%40kernel.org
patch subject: [PATCH 3/7] tracing: Have syscall trace events read user space string
config: parisc-randconfig-r071-20250806 (https://download.01.org/0day-ci/archive/20250806/202508062230.puMRaDdE-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508062230.puMRaDdE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508062230.puMRaDdE-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace_syscalls.c: In function 'check_faultable_syscall':
>> kernel/trace/trace_syscalls.c:886:14: error: '__NR_newfstatat' undeclared (first use in this function); did you mean 'sys_newfstatat'?
     886 |         case __NR_newfstatat:
         |              ^~~~~~~~~~~~~~~
         |              sys_newfstatat
   kernel/trace/trace_syscalls.c:886:14: note: each undeclared identifier is reported only once for each function it appears in


vim +886 kernel/trace/trace_syscalls.c

   802	
   803	/*
   804	 * For system calls that reference user space memory that can
   805	 * be recorded into the event, set the system call meta data's user_mask
   806	 * to the "args" index that points to the user space memory to retrieve.
   807	 */
   808	static void check_faultable_syscall(struct trace_event_call *call, int nr)
   809	{
   810		struct syscall_metadata *sys_data = call->data;
   811	
   812		/* Only work on entry */
   813		if (sys_data->enter_event != call)
   814			return;
   815	
   816		switch (nr) {
   817		/* user arg at position 0 */
   818		case __NR_access:
   819		case __NR_acct:
   820		case __NR_add_key: /* Just _type. TODO add _description */
   821		case __NR_chdir:
   822		case __NR_chown:
   823		case __NR_chmod:
   824		case __NR_chroot:
   825		case __NR_creat:
   826		case __NR_delete_module:
   827		case __NR_execve:
   828		case __NR_fsopen:
   829		case __NR_getxattr: /* Just pathname, TODO add name */
   830		case __NR_lchown:
   831		case __NR_lgetxattr: /* Just pathname, TODO add name */
   832		case __NR_lremovexattr: /* Just pathname, TODO add name */
   833		case __NR_link: /* Just oldname. TODO add newname */
   834		case __NR_listxattr: /* Just pathname, TODO add list */
   835		case __NR_llistxattr: /* Just pathname, TODO add list */
   836		case __NR_lsetxattr: /* Just pathname, TODO add list */
   837		case __NR_open:
   838		case __NR_memfd_create:
   839		case __NR_mount: /* Just dev_name, TODO add dir_name and type */
   840		case __NR_mkdir:
   841		case __NR_mknod:
   842		case __NR_mq_open:
   843		case __NR_mq_unlink:
   844		case __NR_pivot_root: /* Just new_root, TODO add old_root */
   845		case __NR_readlink:
   846		case __NR_removexattr: /* Just pathname, TODO add name */
   847		case __NR_rename: /* Just oldname. TODO add newname */
   848		case __NR_request_key: /* Just _type. TODO add _description */
   849		case __NR_rmdir:
   850		case __NR_setxattr: /* Just pathname, TODO add list */
   851		case __NR_shmdt:
   852		case __NR_statfs:
   853		case __NR_swapon:
   854		case __NR_swapoff:
   855		case __NR_symlink: /* Just oldname. TODO add newname */
   856		case __NR_truncate:
   857		case __NR_unlink:
   858		case __NR_umount2:
   859		case __NR_utime:
   860		case __NR_utimes:
   861			sys_data->user_mask = BIT(0);
   862			break;
   863		/* user arg at position 1 */
   864		case __NR_execveat:
   865		case __NR_faccessat:
   866		case __NR_faccessat2:
   867		case __NR_finit_module:
   868		case __NR_fchmodat:
   869		case __NR_fchmodat2:
   870		case __NR_fchownat:
   871		case __NR_fgetxattr:
   872		case __NR_flistxattr:
   873		case __NR_fsetxattr:
   874		case __NR_fspick:
   875		case __NR_fremovexattr:
   876		case __NR_futimesat:
   877		case __NR_getxattrat: /* Just pathname, TODO add name */
   878		case __NR_inotify_add_watch:
   879		case __NR_linkat: /* Just oldname. TODO add newname */
   880		case __NR_listxattrat: /* Just pathname, TODO add list */
   881		case __NR_mkdirat:
   882		case __NR_mknodat:
   883		case __NR_mount_setattr:
   884		case __NR_move_mount: /* Just from_pathname, TODO add to_pathname */
   885		case __NR_name_to_handle_at:
 > 886		case __NR_newfstatat:
   887		case __NR_openat:
   888		case __NR_openat2:
   889		case __NR_open_tree:
   890		case __NR_open_tree_attr:
   891		case __NR_readlinkat:
   892		case __NR_renameat: /* Just oldname. TODO add newname */
   893		case __NR_renameat2: /* Just oldname. TODO add newname */
   894		case __NR_removexattrat: /* Just pathname, TODO add name */
   895		case __NR_quotactl:
   896		case __NR_setxattrat: /* Just pathname, TODO add list */
   897		case __NR_syslog:
   898		case __NR_symlinkat: /* Just oldname. TODO add newname */
   899		case __NR_statx:
   900		case __NR_unlinkat:
   901		case __NR_utimensat:
   902			sys_data->user_mask = BIT(1);
   903			break;
   904		/* user arg at position 2 */
   905		case __NR_init_module:
   906		case __NR_fsconfig:
   907			sys_data->user_mask = BIT(2);
   908			break;
   909		/* user arg at position 4 */
   910		case __NR_fanotify_mark:
   911			sys_data->user_mask = BIT(4);
   912			break;
   913		default:
   914			sys_data->user_mask = 0;
   915		}
   916	}
   917	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
