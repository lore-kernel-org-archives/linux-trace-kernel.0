Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FEE2D8797;
	Sun,  8 Feb 2026 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770549787; cv=none; b=K5VWJuUdRONb2n12Bovw65N5LiLzKJzMjMaA0MERyNx4MRf1pYJuh7qq0qucjGPZd2XdCRxRLtn0ZusgTUdRiDq/lxZ9+mpcMPR7grgMiz1DITo1v6VZzNGfL80AXKXjPmwTEtX/QHcSSuNQiCqbkzsCneUAXY0mHW9RY5QXFwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770549787; c=relaxed/simple;
	bh=O1rI3X9boePrVvMy/+nxfcRsdeHQ46PH/jbTU906mF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fv+RUE3zpHdp99vinHYWp4o+nUIn1wrLiyG6MPvpRdwRJq0Fe2AIqbJhmQ4XB3UAooD1zapXx0i/CTvMYQDRbhHOLIqP0ppRGQ1dOz0UlUdSD0QuywTs/fe0nLxAxC9FOSnGn5T3IDjzl7k2/MFeN5Fkky7B3wfR3VplEG5xjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdu5pNcY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdu5pNcY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770549788; x=1802085788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O1rI3X9boePrVvMy/+nxfcRsdeHQ46PH/jbTU906mF0=;
  b=mdu5pNcYQTdn5EFRM5oFtU02nR2maRexBmhxREcpI7N4Rofj+RSL9P56
   X39iu2FMGm3LQbFBviG2C76KSo+zeEZ4qqmj7kBztzEpo0nweC1+VuRbP
   MFGyCXW0Xq83FCfES0RX1lfd6fpTL+f9sKIVSjmTy8asOn9UNIKAWVPEd
   zwuYgoZtwjbDUxHtYJmOn+RDJI1NdDv90uBNrySb2/QesCQ4yXlm+6Ssw
   g8EkfT10CN5Lqw/7wkckPiBLS23h51Uh4Ose458nAPCZcSFv7fxHMHhbs
   bvI6RXmyRWcev+fEbhera1hwErTK/LyFnbqEWKyFFNDhTI/8qJqYNtfNa
   g==;
X-CSE-ConnectionGUID: t9zIKEoERKaNQSNJB+Krsg==
X-CSE-MsgGUID: C14Lakc5RiO8Gxv3N1a5tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11694"; a="82007993"
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="82007993"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 03:23:07 -0800
X-CSE-ConnectionGUID: OeBIcGBORzGRfonZZ/1xsQ==
X-CSE-MsgGUID: 4hZfSrrfR92/MWxw2hVu0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="210619705"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 08 Feb 2026 03:23:04 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vp2sX-00000000m9s-3Ci3;
	Sun, 08 Feb 2026 11:23:01 +0000
Date: Sun, 8 Feb 2026 19:22:35 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/3] tracing: Add tracer_uses_snapshot() helper to
 remove #ifdefs
Message-ID: <202602081945.dguj4FF6-lkp@intel.com>
References: <20260208040221.900653834@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208040221.900653834@kernel.org>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.19-rc8 next-20260205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Rename-trace_array-field-max_buffer-to-snapshot_buffer/20260208-120355
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20260208040221.900653834%40kernel.org
patch subject: [PATCH v2 2/3] tracing: Add tracer_uses_snapshot() helper to remove #ifdefs
config: sh-defconfig (https://download.01.org/0day-ci/archive/20260208/202602081945.dguj4FF6-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260208/202602081945.dguj4FF6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602081945.dguj4FF6-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'tracing_set_tracer':
>> kernel/trace/trace.c:6337:25: error: 'struct trace_array' has no member named 'cond_snapshot'
    6337 |                 ret = tr->cond_snapshot ? -EBUSY : 0;
         |                         ^~
   kernel/trace/trace.c:6366:9: error: 'had_max_tr' undeclared (first use in this function)
    6366 |         had_max_tr = tracer_uses_snapshot(tr->current_trace);
         |         ^~~~~~~~~~
   kernel/trace/trace.c:6366:9: note: each undeclared identifier is reported only once for each function it appears in


vim +6337 kernel/trace/trace.c

ef9188bcc6ca1d Mark-PK Tsai             2022-04-26  6300  
9c5b9d3d65e485 Masami Hiramatsu         2020-01-11  6301  int tracing_set_tracer(struct trace_array *tr, const char *buf)
09d23a1d8a82e8 Steven Rostedt (Red Hat  2015-02-03  6302) {
428add559b6923 Steven Rostedt           2025-11-11  6303  	struct tracer *trace = NULL;
428add559b6923 Steven Rostedt           2025-11-11  6304  	struct tracers *t;
12883efb670c28 Steven Rostedt (Red Hat  2013-03-05  6305) #ifdef CONFIG_TRACER_MAX_TRACE
34600f0e9c33c9 Steven Rostedt           2013-01-22  6306  	bool had_max_tr;
12883efb670c28 Steven Rostedt (Red Hat  2013-03-05  6307) #endif
d33b10c0c73adc Steven Rostedt           2024-12-24  6308  	int ret;
bc0c38d139ec7f Steven Rostedt           2008-05-12  6309  
d33b10c0c73adc Steven Rostedt           2024-12-24  6310  	guard(mutex)(&trace_types_lock);
1027fcb206a0fb Steven Rostedt           2009-03-12  6311  
7a1d1e4b9639ff Steven Rostedt (Google   2024-06-12  6312) 	update_last_data(tr);
7a1d1e4b9639ff Steven Rostedt (Google   2024-06-12  6313) 
a1f157c7a3bb34 Zheng Yejian             2023-09-06  6314  	if (!tr->ring_buffer_expanded) {
2b6080f28c7cc3 Steven Rostedt           2012-05-11  6315  		ret = __tracing_resize_ring_buffer(tr, trace_buf_size,
438ced1720b584 Vaibhav Nagarnaik        2012-02-02  6316  						RING_BUFFER_ALL_CPUS);
73c5162aa362a5 Steven Rostedt           2009-03-11  6317  		if (ret < 0)
d33b10c0c73adc Steven Rostedt           2024-12-24  6318  			return ret;
73c5162aa362a5 Steven Rostedt           2009-03-11  6319  		ret = 0;
73c5162aa362a5 Steven Rostedt           2009-03-11  6320  	}
73c5162aa362a5 Steven Rostedt           2009-03-11  6321  
428add559b6923 Steven Rostedt           2025-11-11  6322  	list_for_each_entry(t, &tr->tracers, list) {
428add559b6923 Steven Rostedt           2025-11-11  6323  		if (strcmp(t->tracer->name, buf) == 0) {
428add559b6923 Steven Rostedt           2025-11-11  6324  			trace = t->tracer;
bc0c38d139ec7f Steven Rostedt           2008-05-12  6325  			break;
bc0c38d139ec7f Steven Rostedt           2008-05-12  6326  		}
428add559b6923 Steven Rostedt           2025-11-11  6327  	}
428add559b6923 Steven Rostedt           2025-11-11  6328  	if (!trace)
d33b10c0c73adc Steven Rostedt           2024-12-24  6329  		return -EINVAL;
d33b10c0c73adc Steven Rostedt           2024-12-24  6330  
428add559b6923 Steven Rostedt           2025-11-11  6331  	if (trace == tr->current_trace)
d33b10c0c73adc Steven Rostedt           2024-12-24  6332  		return 0;
bc0c38d139ec7f Steven Rostedt           2008-05-12  6333  
b1e5d74d04bbcf Steven Rostedt           2026-02-07  6334  	if (tracer_uses_snapshot(trace)) {
c0a581d7126c0b Waiman Long              2022-09-22  6335  		local_irq_disable();
a35873a0993b4d Tom Zanussi              2019-02-13  6336  		arch_spin_lock(&tr->max_lock);
22bec11a569983 Steven Rostedt           2025-01-06 @6337  		ret = tr->cond_snapshot ? -EBUSY : 0;
a35873a0993b4d Tom Zanussi              2019-02-13  6338  		arch_spin_unlock(&tr->max_lock);
c0a581d7126c0b Waiman Long              2022-09-22  6339  		local_irq_enable();
a35873a0993b4d Tom Zanussi              2019-02-13  6340  		if (ret)
d33b10c0c73adc Steven Rostedt           2024-12-24  6341  			return ret;
a35873a0993b4d Tom Zanussi              2019-02-13  6342  	}
b1e5d74d04bbcf Steven Rostedt           2026-02-07  6343  
c7b3ae0bd2ca65 Ziqian SUN (Zamir        2017-09-11  6344) 	/* Some tracers won't work on kernel command line */
428add559b6923 Steven Rostedt           2025-11-11  6345  	if (system_state < SYSTEM_RUNNING && trace->noboot) {
c7b3ae0bd2ca65 Ziqian SUN (Zamir        2017-09-11  6346) 		pr_warn("Tracer '%s' is not allowed on command line, ignored\n",
428add559b6923 Steven Rostedt           2025-11-11  6347  			trace->name);
d1e27ee9c6f21c Steven Rostedt           2024-12-19  6348  		return -EINVAL;
c7b3ae0bd2ca65 Ziqian SUN (Zamir        2017-09-11  6349) 	}
c7b3ae0bd2ca65 Ziqian SUN (Zamir        2017-09-11  6350) 
607e2ea167e56d Steven Rostedt (Red Hat  2013-11-06  6351) 	/* Some tracers are only allowed for the top level buffer */
428add559b6923 Steven Rostedt           2025-11-11  6352  	if (!trace_ok_for_array(trace, tr))
d33b10c0c73adc Steven Rostedt           2024-12-24  6353  		return -EINVAL;
607e2ea167e56d Steven Rostedt (Red Hat  2013-11-06  6354) 
cf6ab6d9143b15 Steven Rostedt (Red Hat  2014-12-15  6355) 	/* If trace pipe files are being read, we can't change the tracer */
d33b10c0c73adc Steven Rostedt           2024-12-24  6356  	if (tr->trace_ref)
d33b10c0c73adc Steven Rostedt           2024-12-24  6357  		return -EBUSY;
cf6ab6d9143b15 Steven Rostedt (Red Hat  2014-12-15  6358) 
9f029e83e968e5 Steven Rostedt           2008-11-12  6359  	trace_branch_disable();
613f04a0f51e6e Steven Rostedt (Red Hat  2013-03-14  6360) 
50512ab576e1ce Steven Rostedt (Red Hat  2014-01-14  6361) 	tr->current_trace->enabled--;
613f04a0f51e6e Steven Rostedt (Red Hat  2013-03-14  6362) 
2b6080f28c7cc3 Steven Rostedt           2012-05-11  6363  	if (tr->current_trace->reset)
2b6080f28c7cc3 Steven Rostedt           2012-05-11  6364  		tr->current_trace->reset(tr);
613f04a0f51e6e Steven Rostedt (Red Hat  2013-03-14  6365) 
b1e5d74d04bbcf Steven Rostedt           2026-02-07  6366  	had_max_tr = tracer_uses_snapshot(tr->current_trace);
a541a9559bb0a8 Steven Rostedt (Google   2022-10-05  6367) 
7440172974e85b Paul E. McKenney         2018-11-06  6368  	/* Current trace needs to be nop_trace before synchronize_rcu */
2b6080f28c7cc3 Steven Rostedt           2012-05-11  6369  	tr->current_trace = &nop_trace;
428add559b6923 Steven Rostedt           2025-11-11  6370  	tr->current_trace_flags = nop_trace.flags;
34600f0e9c33c9 Steven Rostedt           2013-01-22  6371  
b1e5d74d04bbcf Steven Rostedt           2026-02-07  6372  	if (had_max_tr && !tracer_uses_snapshot(trace)) {
34600f0e9c33c9 Steven Rostedt           2013-01-22  6373  		/*
34600f0e9c33c9 Steven Rostedt           2013-01-22  6374  		 * We need to make sure that the update_max_tr sees that
34600f0e9c33c9 Steven Rostedt           2013-01-22  6375  		 * current_trace changed to nop_trace to keep it from
34600f0e9c33c9 Steven Rostedt           2013-01-22  6376  		 * swapping the buffers after we resize it.
34600f0e9c33c9 Steven Rostedt           2013-01-22  6377  		 * The update_max_tr is called from interrupts disabled
34600f0e9c33c9 Steven Rostedt           2013-01-22  6378  		 * so a synchronized_sched() is sufficient.
34600f0e9c33c9 Steven Rostedt           2013-01-22  6379  		 */
7440172974e85b Paul E. McKenney         2018-11-06  6380  		synchronize_rcu();
3209cff4490bee Steven Rostedt (Red Hat  2013-03-12  6381) 		free_snapshot(tr);
180e4e390978af Vincent Donnefort        2024-02-20  6382  		tracing_disarm_snapshot(tr);
ef710e100c1068 KOSAKI Motohiro          2010-07-01  6383  	}
12883efb670c28 Steven Rostedt (Red Hat  2013-03-05  6384) 
b1e5d74d04bbcf Steven Rostedt           2026-02-07  6385  	if (!had_max_tr && tracer_uses_snapshot(trace)) {
180e4e390978af Vincent Donnefort        2024-02-20  6386  		ret = tracing_arm_snapshot_locked(tr);
180e4e390978af Vincent Donnefort        2024-02-20  6387  		if (ret)
d33b10c0c73adc Steven Rostedt           2024-12-24  6388  			return ret;
ef710e100c1068 KOSAKI Motohiro          2010-07-01  6389  	}
577b785f55168d Steven Rostedt           2009-02-26  6390  
428add559b6923 Steven Rostedt           2025-11-11  6391  	tr->current_trace_flags = t->flags ? : t->tracer->flags;
428add559b6923 Steven Rostedt           2025-11-11  6392  
428add559b6923 Steven Rostedt           2025-11-11  6393  	if (trace->init) {
428add559b6923 Steven Rostedt           2025-11-11  6394  		ret = tracer_init(trace, tr);
180e4e390978af Vincent Donnefort        2024-02-20  6395  		if (ret) {
b1e5d74d04bbcf Steven Rostedt           2026-02-07  6396  			if (tracer_uses_snapshot(trace))
180e4e390978af Vincent Donnefort        2024-02-20  6397  				tracing_disarm_snapshot(tr);
428add559b6923 Steven Rostedt           2025-11-11  6398  			tr->current_trace_flags = nop_trace.flags;
d33b10c0c73adc Steven Rostedt           2024-12-24  6399  			return ret;
1c80025a49855b Frederic Weisbecker      2008-11-16  6400  		}
180e4e390978af Vincent Donnefort        2024-02-20  6401  	}
bc0c38d139ec7f Steven Rostedt           2008-05-12  6402  
428add559b6923 Steven Rostedt           2025-11-11  6403  	tr->current_trace = trace;
50512ab576e1ce Steven Rostedt (Red Hat  2014-01-14  6404) 	tr->current_trace->enabled++;
9f029e83e968e5 Steven Rostedt           2008-11-12  6405  	trace_branch_enable(tr);
bc0c38d139ec7f Steven Rostedt           2008-05-12  6406  
d33b10c0c73adc Steven Rostedt           2024-12-24  6407  	return 0;
d9e540762f5cdd Peter Zijlstra           2008-11-01  6408  }
d9e540762f5cdd Peter Zijlstra           2008-11-01  6409  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
