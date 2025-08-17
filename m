Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79EF41760;
	Sun, 17 Aug 2025 04:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755404916; cv=none; b=cm7BuUY7Nsxr5Xpf80G1FG/cS51wtVhFP6F7voIoayaRfgQL7Df3h5RvbJFWfmlHQ7+gZbOtiaVvlmkqbQXe7LAlKxzCtJAGG4ASKK6HXb2+9uIfz/DdLamKG3lqCBGpKjmBneo/QiIoKdMKmlyp0iSFwd/9jwpVvDE+cY4yx5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755404916; c=relaxed/simple;
	bh=roBsXTXGnXLtqkdQMkwjW74wVTodWks6KmfOvZGXISw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doRVRO6hNyIi2YLDdqrlawXd6eq5kMJo2di28kZJXSlwjR4MlxcjpIpsOcM1XZhgQlSkPajNCBm4/+S0gW/LWICoT7qNvDvbT81I1S3VQB88ocdy2RLQWmcEPCUtxM3VvF2SCjEoL4CTBGkJN0DU5yrycwu8WYcxN8rqSTjNY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFKeloyh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFKeloyh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755404914; x=1786940914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=roBsXTXGnXLtqkdQMkwjW74wVTodWks6KmfOvZGXISw=;
  b=XFKeloyhlwb8irfoyvgo7Pg+t6KTdTlk+STFtsP+c0JYse5ajNu50EGJ
   wm68Vl/+1knApzLIn/88eye328LCPhIDknc9dqmD7qU5YIfgR9SzZlRFm
   c4J5MbXgUC3UDJY7exAMGgwjqWNZwqw/bkiN+zcg51bc1ZlPm8d6esN8/
   6rB5EmzdZvD74atveiw4CPgHhjCLWyxK+4LFHK8UBi9lCQgUit2MryEUa
   LK4ltWhNDo9v9Sip37TPPQUlq5qqSE/H+9AKv8JaNlivoOhn6A4Mxyzx3
   sVRYY9NXpWxuwxH8/eYjPE1JXmfHKwgAzHrCuKw1voIXjCRby8UGgqX2z
   A==;
X-CSE-ConnectionGUID: vlZRdxvsRxmgV9anzTiMPg==
X-CSE-MsgGUID: Xtlx70LnQrKZvoQeaKMzRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57578211"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57578211"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2025 21:28:33 -0700
X-CSE-ConnectionGUID: fy5oHdMkTVKdVnTF/IvgEg==
X-CSE-MsgGUID: ThgxVKmvQRGwUvrdBbVe8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="171505443"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 16 Aug 2025 21:28:31 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unV0O-000DMB-2Y;
	Sun, 17 Aug 2025 04:28:28 +0000
Date: Sun, 17 Aug 2025 12:28:09 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chung <seokwoo.chung130@gmail.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyer@efficios.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Ryan Chung <seokwoo.chung130@gmail.com>
Subject: Re: [PATCH] trace/trace_fprobe.c: TODO: handle filter, nofilter or
 symbol list
Message-ID: <202508171256.CSm9DAkb-lkp@intel.com>
References: <20250812162101.5981-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812162101.5981-1-seokwoo.chung130@gmail.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.16]
[also build test WARNING on linus/master next-20250815]
[cannot apply to trace/for-next v6.17-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chung/trace-trace_fprobe-c-TODO-handle-filter-nofilter-or-symbol-list/20250813-002748
base:   v6.16
patch link:    https://lore.kernel.org/r/20250812162101.5981-1-seokwoo.chung130%40gmail.com
patch subject: [PATCH] trace/trace_fprobe.c: TODO: handle filter, nofilter or symbol list
config: s390-randconfig-r073-20250817 (https://download.01.org/0day-ci/archive/20250817/202508171256.CSm9DAkb-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508171256.CSm9DAkb-lkp@intel.com/

smatch warnings:
kernel/trace/trace_fprobe.c:768 __register_trace_fprobe() warn: inconsistent indenting

vim +768 kernel/trace/trace_fprobe.c

   732	
   733	/* Internal register function - just handle fprobe and flags */
   734	static int __register_trace_fprobe(struct trace_fprobe *tf)
   735	{
   736		int i, ret;
   737	
   738		/* Should we need new LOCKDOWN flag for fprobe? */
   739		ret = security_locked_down(LOCKDOWN_KPROBES);
   740		if (ret)
   741			return ret;
   742	
   743		if (trace_fprobe_is_registered(tf))
   744			return -EINVAL;
   745	
   746		for (i = 0; i < tf->tp.nr_args; i++) {
   747			ret = traceprobe_update_arg(&tf->tp.args[i]);
   748			if (ret)
   749				return ret;
   750		}
   751	
   752		/* Set/clear disabled flag according to tp->flag */
   753		if (trace_probe_is_enabled(&tf->tp))
   754			tf->fp.flags &= ~FPROBE_FL_DISABLED;
   755		else
   756			tf->fp.flags |= FPROBE_FL_DISABLED;
   757	
   758		if (trace_fprobe_is_tracepoint(tf)) {
   759	
   760			/* This tracepoint is not loaded yet */
   761			if (tf->tpoint == TRACEPOINT_STUB)
   762				return 0;
   763	
   764			return __regsiter_tracepoint_fprobe(tf);
   765		}
   766	
   767	    /* Parse tf->symbol */
 > 768	    {
   769	        char *spec, *bang, *p;
   770	        int n = 0, w = 0, j, rc;
   771	        char **syms = NULL;
   772	
   773	        spec = kstrdup(tf->symbol, GFP_KERNEL);
   774	        if (!spec)
   775	            return -ENOMEM;
   776	
   777	        /* If a '!' exists, treat it as single symbol + filter */
   778	        bang = strchr(spec, '!');
   779	        if (bang) {
   780	            char *sym, *flt;
   781	
   782	            *bang = '\0';
   783	            sym = strim(spec);
   784	            flt = strim(bang + 1);
   785	
   786	            if (!*sym || !*flt) {
   787	                kfree(spec);
   788	                return -EINVAL; /* reject empty symbol/filter */
   789	            }
   790	
   791	            rc = register_fprobe(&tf->fp, sym, flt);
   792	            kfree(spec);
   793	            return rc;
   794	        }
   795	
   796	        /* Comma list (or single symbol without '!') */
   797	        /* First pass: count non-empty tokens */
   798	        p = spec;
   799	        while (p) {
   800	            char *tok = strsep(&p, ",");
   801	            if (tok && *strim(tok))
   802	                n++;
   803	        }
   804	
   805	        if (n == 0){
   806	            kfree(spec);
   807	            return -EINVAL;
   808	        }
   809	
   810	        /* Allocate array for pointers into spec (callee copies/consumes) */
   811	        syms = kcalloc(n, sizeof(*syms), GFP_KERNEL);
   812	        if (!syms) {
   813	            kfree(spec);
   814	            return -ENOMEM;
   815	        }
   816	
   817	        /* Second pass: fill, skipping empties */
   818	        p = spec;
   819	        while (p) {
   820	            char *tok = strsep(&p, ",");
   821	            char *s;
   822	
   823	            if (!tok)
   824	                break;
   825	            s = strim(tok);
   826	            if (!*s)
   827	                continue;
   828	            syms[w++] = s; 
   829	        }
   830	        
   831	        /* Dedup in-place */
   832	        for (i = 0; i < w; i++){
   833	            if (!syms[i])
   834	                continue;
   835	            for (j = i + 1; j < w; j++) {
   836	                if (syms[j] && !strcmp(syms[i], syms[j]))
   837	                    syms[j] = NULL;
   838	            }
   839	        }
   840	
   841	        /* Compact */
   842	        for (i = 0, j = 0; i < w; i++) {
   843	            if (syms[i])
   844	                syms[j++] = syms[i];
   845	        }
   846	        w = j;
   847	
   848	        /* After dedup, ensure we still have at least one symbol */
   849	        if (w == 0){
   850	            kfree(syms);
   851	            kfree(spec);
   852	            return -EINVAL;
   853	        }
   854	
   855	        /* Register list or single symbol, using the existing bulk API */
   856	        if (w == 1)
   857	            rc = register_fprobe(&tf->fp, syms[0], NULL);
   858	        else
   859	            rc = register_fprobe_syms(&tf->fp, (const char **)syms, w);
   860	
   861	        kfree(syms);
   862	        kfree(spec);
   863	        return rc;
   864	    }
   865	}
   866	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
