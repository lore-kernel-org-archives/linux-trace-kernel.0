Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455211C862D;
	Sat, 24 May 2025 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049235; cv=none; b=MXI9gpEAkVpdgKfTV3SFfiNHYI7/w97t9doG3jsRgqYWDfNuBvR5x5as3qQ/9hgs8epzhCzYC1k1cDKcbXKzeRjyQXDqdd4Wtkee3Ns2e62dRQWk01f1DqmeOCBcYIQ7sVGPX63lpHsO3mGKX5P44SefqBgN6QPBDJVrCSMBG8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049235; c=relaxed/simple;
	bh=DcRHlwSA2+s3xYX3BAXgtlItCgPVhGyTrbfO54P/d5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azMaW7O2ghVFz6trdP2P881QWc2Qaz1xQKSOMRt1fP6g97B/AJZruI/1vQ9s/U8TLkhwphGfEsJ76lxqdsgBQfUa3KILrlwwnMS1HJ9Z6As+I60ibEEwbN7HdzZpFEu/Cw/bIaaSioHVWjaEb7cy4egO2TONXmVuiddDxiWthTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDgOZqm9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDgOZqm9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748049235; x=1779585235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DcRHlwSA2+s3xYX3BAXgtlItCgPVhGyTrbfO54P/d5I=;
  b=BDgOZqm9a5i2I0WIjUOW+zazIWe/u/GaXqK0FFuLgsWs8fBI8Y5hbdBX
   F2hGR0ry1PWxgQzVDquAhy249LwL0vvPd8hIL20qS9mt1u+akHRLEDpd5
   VXvF7+vZ2hxVjPy/r6GOUa0t0sWveY6Zs041dnXgcPiIqZ3Fkw9tpwcxA
   vIJ8SRXZ1/XB9GakjswiPNk4j7u4qgDyCrHp3veuvabOx9PuN775zfgcI
   KAr6W81DkNsL+QrHTbZjyBSytKqhImNgP6Qz78SGwMEqVIn/fSzKqfePy
   4MWtWLSS6mzJGKdOInXuc1KrGpn6nR4EbZ3z5505X61bF3J6ElbDDirDJ
   Q==;
X-CSE-ConnectionGUID: ZmJWGFo+TTqJxEOs3aVykg==
X-CSE-MsgGUID: JpArZTQUSrK7ktw49CzkNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61517176"
X-IronPort-AV: E=Sophos;i="6.15,310,1739865600"; 
   d="scan'208";a="61517176"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 18:13:54 -0700
X-CSE-ConnectionGUID: Ay/9QGA9QCG27gyR0MUNtw==
X-CSE-MsgGUID: cYxAC2IPQlu3YCG6GvZrsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,310,1739865600"; 
   d="scan'208";a="142391928"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 23 May 2025 18:13:50 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIdSO-000Qqi-1o;
	Sat, 24 May 2025 01:13:48 +0000
Date: Sat, 24 May 2025 09:13:27 +0800
From: kernel test robot <lkp@intel.com>
To: Ye Bin <yebin@huaweicloud.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com, linux-trace-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, yebin10@huawei.com
Subject: Re: [PATCH 2/2] ftrace: don't allocate  ftrace module map
Message-ID: <202505240845.ACz1UFaT-lkp@intel.com>
References: <20250523083945.3390587-3-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523083945.3390587-3-yebin@huaweicloud.com>

Hi Ye,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.15-rc7 next-20250523]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ye-Bin/ftrace-fix-UAF-when-lookup-kallsym-after-ftrace-disabled/20250523-164234
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250523083945.3390587-3-yebin%40huaweicloud.com
patch subject: [PATCH 2/2] ftrace: don't allocate  ftrace module map
config: s390-randconfig-001-20250524 (https://download.01.org/0day-ci/archive/20250524/202505240845.ACz1UFaT-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250524/202505240845.ACz1UFaT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505240845.ACz1UFaT-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/ftrace.c:7825:37: error: incomplete definition of type 'struct module'
    7825 |         if (ftrace_disabled || (mod && !mod->num_ftrace_callsites)) {
         |                                         ~~~^
   include/linux/printk.h:400:8: note: forward declaration of 'struct module'
     400 | struct module;
         |        ^
   1 error generated.


vim +7825 kernel/trace/ftrace.c

  7806	
  7807	void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
  7808	{
  7809		unsigned long start = (unsigned long)(start_ptr);
  7810		unsigned long end = (unsigned long)(end_ptr);
  7811		struct ftrace_page **last_pg = &ftrace_pages_start;
  7812		struct ftrace_page *tmp_page = NULL;
  7813		struct ftrace_page *pg;
  7814		struct dyn_ftrace *rec;
  7815		struct dyn_ftrace key;
  7816		struct ftrace_mod_map *mod_map = NULL;
  7817		struct ftrace_init_func *func, *func_next;
  7818		LIST_HEAD(clear_hash);
  7819	
  7820		key.ip = start;
  7821		key.flags = end;	/* overload flags, as it is unsigned long */
  7822	
  7823		mutex_lock(&ftrace_lock);
  7824	
> 7825		if (ftrace_disabled || (mod && !mod->num_ftrace_callsites)) {
  7826			mutex_unlock(&ftrace_lock);
  7827			return;
  7828		}
  7829	
  7830		/*
  7831		 * If we are freeing module init memory, then check if
  7832		 * any tracer is active. If so, we need to save a mapping of
  7833		 * the module functions being freed with the address.
  7834		 */
  7835		if (mod && ftrace_ops_list != &ftrace_list_end)
  7836			mod_map = allocate_ftrace_mod_map(mod, start, end);
  7837	
  7838		for (pg = ftrace_pages_start; pg; last_pg = &pg->next, pg = *last_pg) {
  7839			if (end < pg->records[0].ip ||
  7840			    start >= (pg->records[pg->index - 1].ip + MCOUNT_INSN_SIZE))
  7841				continue;
  7842	 again:
  7843			rec = bsearch(&key, pg->records, pg->index,
  7844				      sizeof(struct dyn_ftrace),
  7845				      ftrace_cmp_recs);
  7846			if (!rec)
  7847				continue;
  7848	
  7849			/* rec will be cleared from hashes after ftrace_lock unlock */
  7850			add_to_clear_hash_list(&clear_hash, rec);
  7851	
  7852			if (mod_map)
  7853				save_ftrace_mod_rec(mod_map, rec);
  7854	
  7855			pg->index--;
  7856			ftrace_update_tot_cnt--;
  7857			if (!pg->index) {
  7858				*last_pg = pg->next;
  7859				pg->next = tmp_page;
  7860				tmp_page = pg;
  7861				pg = container_of(last_pg, struct ftrace_page, next);
  7862				if (!(*last_pg))
  7863					ftrace_pages = pg;
  7864				continue;
  7865			}
  7866			memmove(rec, rec + 1,
  7867				(pg->index - (rec - pg->records)) * sizeof(*rec));
  7868			/* More than one function may be in this block */
  7869			goto again;
  7870		}
  7871		mutex_unlock(&ftrace_lock);
  7872	
  7873		list_for_each_entry_safe(func, func_next, &clear_hash, list) {
  7874			clear_func_from_hashes(func);
  7875			kfree(func);
  7876		}
  7877		/* Need to synchronize with ftrace_location_range() */
  7878		if (tmp_page) {
  7879			synchronize_rcu();
  7880			ftrace_free_pages(tmp_page);
  7881		}
  7882	}
  7883	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
