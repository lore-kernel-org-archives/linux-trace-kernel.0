Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79DC1B3930;
	Thu,  5 Jun 2025 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749110962; cv=none; b=jDHAJd1sMhH0rO+kTC9NPDhGhQEID4xqhn9sBQn4QjZJlPtrTaRpb2giwN6W/kMw+2+Tzfo8FFmRYaKtGJRpwQh1mc7qilXXtUt7d/NUwUS9TkGaLdono3miaSbSJYW9PhCXmYbwz6tyDNe7mYAtD1oC4BN09GDMsZwkB8ttDkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749110962; c=relaxed/simple;
	bh=7ctOve892niXXx61nUp7hxjrKzmnA5TgLsp5VDWIwe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAW+3x2lzlpiVMUB5bGKOdKsCYB8iMnA81WeEt93Xcy9UHW/YZzogMVclkHbrcwERZb5y6Hc9LpB+5VjyS75v+JWcNwA998GhAXaNx/pX14cYV4cA/CkN/gA26a9kzR9pOotfNL8msDtRROvWz+5ZQbODH92FPFMIS2Zv3ThAuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V042KT67; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V042KT67"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749110961; x=1780646961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7ctOve892niXXx61nUp7hxjrKzmnA5TgLsp5VDWIwe0=;
  b=V042KT67HLSXwqJ09VAxLmb0BvhK9V/7J7FHccL1oWICZQ2t1YCIFrLu
   h7s/grlfJPtTqP528naQhR3+p6mhGF+pAhlAL5azzaI3CFJK6HSDGlOmT
   uECqqY09FmrLp6Do3JEfp+kRruUq5dTm1Y/SFGPtD1EkZdvDPktdMDViu
   /GlQ3bw9uyf2+RHZDHs7/6AQv1RKdwP6D1YTE4N1D2rq6qA3s/L8LwSHD
   Pxa+dumoyXlo+3fRWO+LXBJKVspXkUoZLEhkVESZi8l3v3N23+VFhQmmt
   P2LE/3Z5Oq4CckvuAiaTIsXMMj8oiBl3ClAoRio5O/N6LpysDH3eveWpV
   g==;
X-CSE-ConnectionGUID: i8+h4ARUT8y1NefBDxV0lg==
X-CSE-MsgGUID: XzgKkrf8QgCnRBo2NXQ2/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51133736"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="51133736"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 01:09:20 -0700
X-CSE-ConnectionGUID: J6Ht4pXdQHaJzIrlltn1Lg==
X-CSE-MsgGUID: dZhUEi/fScSGRqD1Cqr2Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="150313400"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Jun 2025 01:09:18 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uN5f2-0003t7-0U;
	Thu, 05 Jun 2025 08:09:16 +0000
Date: Thu, 5 Jun 2025 16:09:10 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] eventfs: Simplify code using guard()s
Message-ID: <202506051521.4YOBbYuj-lkp@intel.com>
References: <20250604151625.250d13e1@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604151625.250d13e1@gandalf.local.home>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v6.15 next-20250605]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/eventfs-Simplify-code-using-guard-s/20250605-035636
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250604151625.250d13e1%40gandalf.local.home
patch subject: [PATCH] eventfs: Simplify code using guard()s
config: csky-randconfig-001-20250605 (https://download.01.org/0day-ci/archive/20250605/202506051521.4YOBbYuj-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250605/202506051521.4YOBbYuj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506051521.4YOBbYuj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/tracefs/event_inode.c: In function 'eventfs_iterate':
>> fs/tracefs/event_inode.c:577:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     577 |  int ret = -EINVAL;
         |      ^~~


vim +/ret +577 fs/tracefs/event_inode.c

63940449555e79 Ajay Kaher              2023-07-28  563  
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  564) /*
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  565)  * Walk the children of a eventfs_inode to fill in getdents().
63940449555e79 Ajay Kaher              2023-07-28  566   */
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  567) static int eventfs_iterate(struct file *file, struct dir_context *ctx)
63940449555e79 Ajay Kaher              2023-07-28  568  {
5790b1fb3d672d Steven Rostedt (Google  2023-10-04  569) 	const struct file_operations *fops;
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  570) 	struct inode *f_inode = file_inode(file);
5790b1fb3d672d Steven Rostedt (Google  2023-10-04  571) 	const struct eventfs_entry *entry;
5790b1fb3d672d Steven Rostedt (Google  2023-10-04  572) 	struct eventfs_inode *ei_child;
63940449555e79 Ajay Kaher              2023-07-28  573  	struct tracefs_inode *ti;
63940449555e79 Ajay Kaher              2023-07-28  574  	struct eventfs_inode *ei;
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  575) 	const char *name;
5790b1fb3d672d Steven Rostedt (Google  2023-10-04  576) 	umode_t mode;
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03 @577) 	int ret = -EINVAL;
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  578) 	int ino;
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  579) 	int i, r, c;
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  580) 
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  581) 	if (!dir_emit_dots(file, ctx))
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  582) 		return 0;
63940449555e79 Ajay Kaher              2023-07-28  583  
63940449555e79 Ajay Kaher              2023-07-28  584  	ti = get_tracefs(f_inode);
63940449555e79 Ajay Kaher              2023-07-28  585  	if (!(ti->flags & TRACEFS_EVENT_INODE))
63940449555e79 Ajay Kaher              2023-07-28  586  		return -EINVAL;
63940449555e79 Ajay Kaher              2023-07-28  587  
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  588) 	c = ctx->pos - 2;
ef36b4f92868d6 Steven Rostedt (Google  2023-09-22  589) 
97aa2be4ff039f Steven Rostedt          2025-06-04  590  	guard(srcu)(&eventfs_srcu);
5790b1fb3d672d Steven Rostedt (Google  2023-10-04  591) 
97aa2be4ff039f Steven Rostedt          2025-06-04  592  	scoped_guard(mutex, &eventfs_mutex) {
5790b1fb3d672d Steven Rostedt (Google  2023-10-04  593) 		ei = READ_ONCE(ti->private);
97aa2be4ff039f Steven Rostedt          2025-06-04  594  		if (!ei || ei->is_freed)
97aa2be4ff039f Steven Rostedt          2025-06-04  595  			return -EINVAL;
97aa2be4ff039f Steven Rostedt          2025-06-04  596  	}
5790b1fb3d672d Steven Rostedt (Google  2023-10-04  597) 
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  598) 	/*
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  599) 	 * Need to create the dentries and inodes to have a consistent
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  600) 	 * inode number.
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  601) 	 */
1de94b52d5e8d8 Steven Rostedt (Google  2024-01-04  602) 	ret = 0;
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  603) 
1de94b52d5e8d8 Steven Rostedt (Google  2024-01-04  604) 	/* Start at 'c' to jump over already read entries */
1de94b52d5e8d8 Steven Rostedt (Google  2024-01-04  605) 	for (i = c; i < ei->nr_entries; i++, ctx->pos++) {
1de94b52d5e8d8 Steven Rostedt (Google  2024-01-04  606) 		void *cdata = ei->data;
1e4624eb5a0eca Steven Rostedt (Google  2024-01-04  607) 
704f960dbee2f1 Steven Rostedt (Google  2024-01-04  608) 		entry = &ei->entries[i];
704f960dbee2f1 Steven Rostedt (Google  2024-01-04  609) 		name = entry->name;
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  610) 
704f960dbee2f1 Steven Rostedt (Google  2024-01-04  611) 		/* If ei->is_freed then just bail here, nothing more to do */
97aa2be4ff039f Steven Rostedt          2025-06-04  612  		scoped_guard(mutex, &eventfs_mutex) {
97aa2be4ff039f Steven Rostedt          2025-06-04  613  			if (ei->is_freed)
97aa2be4ff039f Steven Rostedt          2025-06-04  614  				return -EINVAL;
704f960dbee2f1 Steven Rostedt (Google  2024-01-04  615) 			r = entry->callback(name, &mode, &cdata, &fops);
97aa2be4ff039f Steven Rostedt          2025-06-04  616  		}
704f960dbee2f1 Steven Rostedt (Google  2024-01-04  617) 		if (r <= 0)
704f960dbee2f1 Steven Rostedt (Google  2024-01-04  618) 			continue;
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  619) 
852e46e239ee6d Steven Rostedt (Google  2024-01-16  620) 		ino = EVENTFS_FILE_INODE_INO;
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  621) 
704f960dbee2f1 Steven Rostedt (Google  2024-01-04  622) 		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
97aa2be4ff039f Steven Rostedt          2025-06-04  623  			return -EINVAL;
5790b1fb3d672d Steven Rostedt (Google  2023-10-04  624) 	}
ef36b4f92868d6 Steven Rostedt (Google  2023-09-22  625) 
1de94b52d5e8d8 Steven Rostedt (Google  2024-01-04  626) 	/* Subtract the skipped entries above */
1de94b52d5e8d8 Steven Rostedt (Google  2024-01-04  627) 	c -= min((unsigned int)c, (unsigned int)ei->nr_entries);
1de94b52d5e8d8 Steven Rostedt (Google  2024-01-04  628) 
704f960dbee2f1 Steven Rostedt (Google  2024-01-04  629) 	list_for_each_entry_srcu(ei_child, &ei->children, list,
704f960dbee2f1 Steven Rostedt (Google  2024-01-04  630) 				 srcu_read_lock_held(&eventfs_srcu)) {
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  631) 
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  632) 		if (c > 0) {
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  633) 			c--;
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  634) 			continue;
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  635) 		}
493ec81a8fb8e4 Steven Rostedt (Google  2024-01-03  636) 
1e4624eb5a0eca Steven Rostedt (Google  2024-01-04  637) 		ctx->pos++;
1e4624eb5a0eca Steven Rostedt (Google  2024-01-04  638) 
704f960dbee2f1 Steven Rostedt (Google  2024-01-04  639) 		if (ei_child->is_freed)
5790b1fb3d672d Steven Rostedt (Google  2023-10-04  640) 			continue;
ef36b4f92868d6 Steven Rostedt (Google  2023-09-22  641) 
704f960dbee2f1 Steven Rostedt (Google  2024-01-04  642) 		name = ei_child->name;
704f960dbee2f1 Steven Rostedt (Google  2024-01-04  643) 
834bf76add3e61 Steven Rostedt (Google  2024-01-22  644) 		ino = eventfs_dir_ino(ei_child);
ef36b4f92868d6 Steven Rostedt (Google  2023-09-22  645) 
97aa2be4ff039f Steven Rostedt          2025-06-04  646  		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR)) {
1e4624eb5a0eca Steven Rostedt (Google  2024-01-04  647) 			/* Incremented ctx->pos without adding something, reset it */
1e4624eb5a0eca Steven Rostedt (Google  2024-01-04  648) 			ctx->pos--;
97aa2be4ff039f Steven Rostedt          2025-06-04  649  			return -EINVAL;
97aa2be4ff039f Steven Rostedt          2025-06-04  650  		}
97aa2be4ff039f Steven Rostedt          2025-06-04  651  	}
97aa2be4ff039f Steven Rostedt          2025-06-04  652  	return 1;
63940449555e79 Ajay Kaher              2023-07-28  653  }
63940449555e79 Ajay Kaher              2023-07-28  654  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
