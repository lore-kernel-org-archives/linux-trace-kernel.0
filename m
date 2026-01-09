Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5F2877FE;
	Fri,  9 Jan 2026 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972156; cv=none; b=XLVjJhP9OrD4eY+xaAt5tKci2P2s0YqJmx6HgMD2c5O1yQj9odM659kNgVyCoip2EfasCIw+mCpcaF2CrOjRSgtVqSMA2HGeAZbp3Nt8HQ5VO+Do7S/STsg1v/VgGsNOJIT7N/3zyl/ZVeDSA6YIORnLWStXd6RHwC0oIAPi6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972156; c=relaxed/simple;
	bh=l0K0iHQxhWpbfVeLEUJ7Fm+JtumcN7lMgtZ7tN4usXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbxbDvSwrwxrGxLjjMjlA3WWhnAbkCSSqIAErhGxDjhKtkx7L2ou6qfRzs2LeiBrWJDWh/2pHqwIRy55HNqUidrQZymjiA4R5wGNFwN5wls3WZg7T0a72A5NkKuFnq2PZM67utsB9R+xgjabIPcI0r/XSLNvAzwFszHCewl9/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 32F721398C3;
	Fri,  9 Jan 2026 15:22:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id D407020037;
	Fri,  9 Jan 2026 15:22:29 +0000 (UTC)
Date: Fri, 9 Jan 2026 10:23:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, lkp@intel.com,
 oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linux Memory Management List
 <linux-mm@kvack.org>
Subject: Re: [PATCH 3/5] tracing: Have tracer option be instance specific
Message-ID: <20260109102301.19daeb27@gandalf.local.home>
In-Reply-To: <202511071533.domGENBS-lkp@intel.com>
References: <20251105161935.545400234@kernel.org>
	<202511071533.domGENBS-lkp@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D407020037
X-Stat-Signature: jcuq6amaw9651isigmpghnke7jqeogp4
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19jdSeoFBztHLOMU/lMm14vAteYNKPwXT0=
X-HE-Tag: 1767972149-424104
X-HE-Meta: U2FsdGVkX19ilsxq7u3MRtKL3dJWwByiZPh/dNykQoGfoiGRpH0i/9tNzbovF3etCkRCiRnHo67ShzJFR/TraY0X0a9rM0tfe2y6bnDYxcu0iNSbLdNupEDNpoREIG8kiiV2i0pLDtLKSY8sKgGq0GEuZauFHyo4PITU50uRah6+FlLoS8w5Qyivk6Ee+beVybcCb7dexIMQy2UaVsru7qRMocTetT5YY+f2ZfBaBdn9FI0gDV25+4Mcn4mWhfr3Q/0CJd8HA68QvRB3EjoCMa9AX9JXcPu+3ezm/eGMG2WDkxQMuCckiyUEIvqbV3rrGoh9OFBNR6KXtvyT8FzvabHby38Ah4Wc3MGLKpJhF68+U9PWPpv6gwZpjzPdzv5Zhleh7hguR73jsagOpzzOhgaj25IoZY7Pf0i1lB3A5ROKNBONjkfzbHQXswos25UOP7DjiG+U+l55bw7GCXi+W7A6UTqnz/VcizWk5Q2JAFmq6RhP7PU6BaVhFOzmiM6zQwqiT3rbbzdHA/1gHeXNng==

On Mon, 5 Jan 2026 18:23:31 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Hi Steven,

Hi Dan,

> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Remove-dummy-options-and-flags/20251106-010511
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
> patch link:    https://lore.kernel.org/r/20251105161935.545400234%40kernel.org

This is an old patch (v1) and v3 fixed this issue:
   https://lore.kernel.org/all/20251110234341.767135255@kernel.org/

 and v4 was applied and is now in mainline.

The patch you are reporting on was sent Nov 5th, the fix was sent Nov 10th.

Why is this sending reports about an old patch that is obsolete? Is there
something wrong with your setup?

-- Steve

> patch subject: [PATCH 3/5] tracing: Have tracer option be instance specific
> config: i386-randconfig-r072-20251107 (https://download.01.org/0day-ci/archive/20251107/202511071533.domGENBS-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202511071533.domGENBS-lkp@intel.com/
> 
> smatch warnings:
> kernel/trace/trace.c:6313 tracing_set_tracer() warn: iterator used outside loop: 't'
> 
> vim +/t +6313 kernel/trace/trace.c
> 
> 9c5b9d3d65e4858 Masami Hiramatsu         2020-01-11  6285  int tracing_set_tracer(struct trace_array *tr, const char *buf)
> 09d23a1d8a82e81 Steven Rostedt (Red Hat  2015-02-03  6286) {
> 4699bbb369ba1d3 Steven Rostedt           2025-11-05  6287  	struct tracer *trace;
> 4699bbb369ba1d3 Steven Rostedt           2025-11-05  6288  	struct tracers *t;
> 12883efb670c28d Steven Rostedt (Red Hat  2013-03-05  6289) #ifdef CONFIG_TRACER_MAX_TRACE
> 34600f0e9c33c9c Steven Rostedt           2013-01-22  6290  	bool had_max_tr;
> 12883efb670c28d Steven Rostedt (Red Hat  2013-03-05  6291) #endif
> d33b10c0c73adca Steven Rostedt           2024-12-24  6292  	int ret;
> bc0c38d139ec7fc Steven Rostedt           2008-05-12  6293  
> d33b10c0c73adca Steven Rostedt           2024-12-24  6294  	guard(mutex)(&trace_types_lock);
> 1027fcb206a0fb8 Steven Rostedt           2009-03-12  6295  
> 7a1d1e4b9639ff0 Steven Rostedt (Google   2024-06-12  6296) 	update_last_data(tr);
> 7a1d1e4b9639ff0 Steven Rostedt (Google   2024-06-12  6297) 
> a1f157c7a3bb342 Zheng Yejian             2023-09-06  6298  	if (!tr->ring_buffer_expanded) {
> 2b6080f28c7cc3e Steven Rostedt           2012-05-11  6299  		ret = __tracing_resize_ring_buffer(tr, trace_buf_size,
> 438ced1720b5840 Vaibhav Nagarnaik        2012-02-02  6300  						RING_BUFFER_ALL_CPUS);
> 73c5162aa362a54 Steven Rostedt           2009-03-11  6301  		if (ret < 0)
> d33b10c0c73adca Steven Rostedt           2024-12-24  6302  			return ret;
> 73c5162aa362a54 Steven Rostedt           2009-03-11  6303  		ret = 0;
> 73c5162aa362a54 Steven Rostedt           2009-03-11  6304  	}
> 73c5162aa362a54 Steven Rostedt           2009-03-11  6305  
> 4699bbb369ba1d3 Steven Rostedt           2025-11-05  6306  	list_for_each_entry(t, &tr->tracers, list) {
> 4699bbb369ba1d3 Steven Rostedt           2025-11-05  6307  		if (strcmp(t->tracer->name, buf) == 0)
> bc0c38d139ec7fc Steven Rostedt           2008-05-12  6308  			break;
> bc0c38d139ec7fc Steven Rostedt           2008-05-12  6309  	}
> d33b10c0c73adca Steven Rostedt           2024-12-24  6310  	if (!t)
> 
> t can't be NULL here.  It needs to be if (list_entry_is_head()) return;
> 
> d33b10c0c73adca Steven Rostedt           2024-12-24  6311  		return -EINVAL;
> d33b10c0c73adca Steven Rostedt           2024-12-24  6312  
> 4699bbb369ba1d3 Steven Rostedt           2025-11-05 @6313  	if (t->tracer == tr->current_trace)
> d33b10c0c73adca Steven Rostedt           2024-12-24  6314  		return 0;
> bc0c38d139ec7fc Steven Rostedt           2008-05-12  6315  
> 4699bbb369ba1d3 Steven Rostedt           2025-11-05  6316  	trace = t->tracer;
> 4699bbb369ba1d3 Steven Rostedt           2025-11-05  6317  
> 

