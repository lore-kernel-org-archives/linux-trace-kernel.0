Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5228B3FD;
	Wed,  6 Aug 2025 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493141; cv=none; b=dSL8/oWiqQ7dIIR3oMFljBmHp0NYFrI9LlY9K8dVqU7efkXnbMkf9/374eu2ZIAy9ZxhZvTMtTgt08IiupMG8LpnlndF/aEXiVyhTzsepRUEk5XbdEvPgnHuzMr4w+ZW8GBCg1WLjNJIY0Miu6PPqoYGlUVTytdXxkAVlydauRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493141; c=relaxed/simple;
	bh=z0GZ2itZ2i6se6vN/uwlmzSn0GLQ1L0gKV7qLJ9Ot0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amoykVMSj9xCLiykWDvTvQhfEq8x2E/qt0glfSnsfpniNU4B6UbwdKlgvm4KJIWiB1uiYxa2IUfzCpx9CQgBeTTLRyFjmEyZ2EJFH1yUVZpDeuqv91Z/1qWzSEm7vWgpC62/ksX0JCBARgKlvmUDXTCVVY6xmPVKqwkmk8V9zZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDyWJ/EU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDyWJ/EU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754493140; x=1786029140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z0GZ2itZ2i6se6vN/uwlmzSn0GLQ1L0gKV7qLJ9Ot0A=;
  b=YDyWJ/EUHadnsFym7//i1Uzp1v/i8Sp4VCu6DgGrSUiXGjhkclg59x7M
   QyEkmpVFbpZcPWb23+2mRp7VmZuiDTBYEGS1R7x68NqvuaLbUbqAf2QoM
   dDLZbfQW+kct0AyU+i23viehQsquKyn0wF57+0T4SkXLEFshE2hJZjVnI
   glKenjZCuAaORB710s1u83Nuj2xMlYBRA40U4JoIoTAyFBaUvM4+A0DqK
   F4E1mC+gQGG9jyvxVwn30/TJx/2f8J0nHqss7/gi/UPCxBoa6a7Fvo3s4
   BEtqrbG2poyiI7ZnwXzwIW/bn1xbIB9fu3OOMSB8l+P61yCceZPnK7QDo
   Q==;
X-CSE-ConnectionGUID: NxwLgabBR1uWaTv/vQHhwg==
X-CSE-MsgGUID: 3yIjg3NhS5+FctsJXBX8rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67510058"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="67510058"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 08:12:17 -0700
X-CSE-ConnectionGUID: BAtTOpw7R7mkNp+FPRptAA==
X-CSE-MsgGUID: ZjHK3kmaSZej6Qvc1WOpVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="201964384"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 06 Aug 2025 08:12:13 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujfoI-0001oO-2p;
	Wed, 06 Aug 2025 15:12:10 +0000
Date: Wed, 6 Aug 2025 23:12:02 +0800
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
Subject: Re: [PATCH 5/7] tracing: Display some syscall arrays as strings
Message-ID: <202508062215.aRvDXrBA-lkp@intel.com>
References: <20250805193235.416382557@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805193235.416382557@kernel.org>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.16 next-20250806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Replace-syscall-RCU-pointer-assignment-with-READ-WRITE_ONCE/20250806-122312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250805193235.416382557%40kernel.org
patch subject: [PATCH 5/7] tracing: Display some syscall arrays as strings
config: i386-randconfig-141-20250806 (https://download.01.org/0day-ci/archive/20250806/202508062215.aRvDXrBA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508062215.aRvDXrBA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508062215.aRvDXrBA-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace_syscalls.c: In function 'check_faultable_syscall':
>> kernel/trace/trace_syscalls.c:883:14: error: '__NR_kexec_file_load' undeclared (first use in this function)
     883 |         case __NR_kexec_file_load:
         |              ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_syscalls.c:883:14: note: each undeclared identifier is reported only once for each function it appears in
   kernel/trace/trace_syscalls.c:957:14: error: '__NR_newfstatat' undeclared (first use in this function)
     957 |         case __NR_newfstatat:
         |              ^~~~~~~~~~~~~~~


vim +/__NR_kexec_file_load +883 kernel/trace/trace_syscalls.c

   851	
   852	/*
   853	 * For system calls that reference user space memory that can
   854	 * be recorded into the event, set the system call meta data's user_mask
   855	 * to the "args" index that points to the user space memory to retrieve.
   856	 */
   857	static void check_faultable_syscall(struct trace_event_call *call, int nr)
   858	{
   859		struct syscall_metadata *sys_data = call->data;
   860	
   861		/* Only work on entry */
   862		if (sys_data->enter_event != call)
   863			return;
   864	
   865		sys_data->user_arg_size = -1;
   866	
   867		switch (nr) {
   868		/* user arg 1 with size arg at 2 */
   869		case __NR_write:
   870		case __NR_mq_timedsend:
   871		case __NR_pwrite64:
   872			sys_data->user_mask = BIT(1);
   873			sys_data->user_arg_size = 2;
   874			break;
   875		/* user arg 0 with size arg at 1 as string */
   876		case __NR_setdomainname:
   877		case __NR_sethostname:
   878			sys_data->user_mask = BIT(0);
   879			sys_data->user_arg_size = 1;
   880			sys_data->user_arg_is_str = 1;
   881			break;
   882		/* user arg 4 with size arg at 3 as string */
 > 883		case __NR_kexec_file_load:
   884			sys_data->user_mask = BIT(4);
   885			sys_data->user_arg_size = 3;
   886			sys_data->user_arg_is_str = 1;
   887			break;
   888		/* user arg at position 0 */
   889		case __NR_access:
   890		case __NR_acct:
   891		case __NR_add_key: /* Just _type. TODO add _description */
   892		case __NR_chdir:
   893		case __NR_chown:
   894		case __NR_chmod:
   895		case __NR_chroot:
   896		case __NR_creat:
   897		case __NR_delete_module:
   898		case __NR_execve:
   899		case __NR_fsopen:
   900		case __NR_getxattr: /* Just pathname, TODO add name */
   901		case __NR_lchown:
   902		case __NR_lgetxattr: /* Just pathname, TODO add name */
   903		case __NR_lremovexattr: /* Just pathname, TODO add name */
   904		case __NR_link: /* Just oldname. TODO add newname */
   905		case __NR_listxattr: /* Just pathname, TODO add list */
   906		case __NR_llistxattr: /* Just pathname, TODO add list */
   907		case __NR_lsetxattr: /* Just pathname, TODO add list */
   908		case __NR_open:
   909		case __NR_memfd_create:
   910		case __NR_mount: /* Just dev_name, TODO add dir_name and type */
   911		case __NR_mkdir:
   912		case __NR_mknod:
   913		case __NR_mq_open:
   914		case __NR_mq_unlink:
   915		case __NR_pivot_root: /* Just new_root, TODO add old_root */
   916		case __NR_readlink:
   917		case __NR_removexattr: /* Just pathname, TODO add name */
   918		case __NR_rename: /* Just oldname. TODO add newname */
   919		case __NR_request_key: /* Just _type. TODO add _description */
   920		case __NR_rmdir:
   921		case __NR_setxattr: /* Just pathname, TODO add list */
   922		case __NR_shmdt:
   923		case __NR_statfs:
   924		case __NR_swapon:
   925		case __NR_swapoff:
   926		case __NR_symlink: /* Just oldname. TODO add newname */
   927		case __NR_truncate:
   928		case __NR_unlink:
   929		case __NR_umount2:
   930		case __NR_utime:
   931		case __NR_utimes:
   932			sys_data->user_mask = BIT(0);
   933			break;
   934		/* user arg at position 1 */
   935		case __NR_execveat:
   936		case __NR_faccessat:
   937		case __NR_faccessat2:
   938		case __NR_finit_module:
   939		case __NR_fchmodat:
   940		case __NR_fchmodat2:
   941		case __NR_fchownat:
   942		case __NR_fgetxattr:
   943		case __NR_flistxattr:
   944		case __NR_fsetxattr:
   945		case __NR_fspick:
   946		case __NR_fremovexattr:
   947		case __NR_futimesat:
   948		case __NR_getxattrat: /* Just pathname, TODO add name */
   949		case __NR_inotify_add_watch:
   950		case __NR_linkat: /* Just oldname. TODO add newname */
   951		case __NR_listxattrat: /* Just pathname, TODO add list */
   952		case __NR_mkdirat:
   953		case __NR_mknodat:
   954		case __NR_mount_setattr:
   955		case __NR_move_mount: /* Just from_pathname, TODO add to_pathname */
   956		case __NR_name_to_handle_at:
   957		case __NR_newfstatat:
   958		case __NR_openat:
   959		case __NR_openat2:
   960		case __NR_open_tree:
   961		case __NR_open_tree_attr:
   962		case __NR_readlinkat:
   963		case __NR_renameat: /* Just oldname. TODO add newname */
   964		case __NR_renameat2: /* Just oldname. TODO add newname */
   965		case __NR_removexattrat: /* Just pathname, TODO add name */
   966		case __NR_quotactl:
   967		case __NR_setxattrat: /* Just pathname, TODO add list */
   968		case __NR_syslog:
   969		case __NR_symlinkat: /* Just oldname. TODO add newname */
   970		case __NR_statx:
   971		case __NR_unlinkat:
   972		case __NR_utimensat:
   973			sys_data->user_mask = BIT(1);
   974			break;
   975		/* user arg at position 2 */
   976		case __NR_init_module:
   977		case __NR_fsconfig:
   978			sys_data->user_mask = BIT(2);
   979			break;
   980		/* user arg at position 4 */
   981		case __NR_fanotify_mark:
   982			sys_data->user_mask = BIT(4);
   983			break;
   984		default:
   985			sys_data->user_mask = 0;
   986		}
   987	}
   988	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
