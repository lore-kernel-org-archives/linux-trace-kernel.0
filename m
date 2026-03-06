Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A373D34AD;
	Fri,  6 Mar 2026 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823404; cv=none; b=mOSptgJlmMSaDGIOvRbafuqLg83Bf6t6svS63LyTfBaJaOWizQi1Uafn4NCC+UX3jovK0Y5c8NazK/sxSdfnAyALY/acxQtT+7ZQ7tIt1DaVZI8agmMJCK+hqUZNY6ZPF2/EgVmo+k01qYoI9BCNPCtafti70ZrRwR19ThHt9sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823404; c=relaxed/simple;
	bh=+sL/nNc32KPHAuimiXJR4EGH70CEqm3gqqPUSTHD3AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk630Ggi231wj5W4uPne8KEn0HDZlqP9zZfn5mG+1j9oLBKjNTRoRwm9cij8q2Ls2gUL7BuWvUnM7n1GXvsdnc8FyunAyGE5BphCv2fiZF8UAXOS+slQ1R34wkZPQhBaTmyJpqK5eVtNWNDXyvpD76LnvGCDfWt7eU+y9bkT4w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUeaaWcb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUeaaWcb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772823401; x=1804359401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+sL/nNc32KPHAuimiXJR4EGH70CEqm3gqqPUSTHD3AE=;
  b=eUeaaWcbWBDLB6faFap2JazthFGwQsLXYh/W1CglTXVnU8oTw+ivUsYG
   uGK3+XEI6HvYpsq1y1dYs8DLlH+P7HQChgEXtSDa1rjML3iAtYhsDOIg2
   EhJtW4614JecJ+8yCnfwCCOzxUFUs+/E49pm1f/LtH+DGSGh4vwEJjLhv
   PZO5T4+XcotlLkP6mDcLT/Zyj21K7QYpb80TmF+iS+ji/al+yr+IQ194g
   wgv1a45qOGGjHT5t/4Cxqri/wwI3qrQgsu3R9WHa6sTamwJWzjah+lgBG
   O+NnxMghIhBsttRJIIiYcuu/yWc3o5HNTPSvFruMRWPLmp9xhbSZ+MhLq
   g==;
X-CSE-ConnectionGUID: xtzl1229S5OuiLMBqJITpQ==
X-CSE-MsgGUID: 3pfyTx48QZ+DmsL4NFfa/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="74127350"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="74127350"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 10:56:41 -0800
X-CSE-ConnectionGUID: ii7h00ngQHmS7if1Fjlcdw==
X-CSE-MsgGUID: wiLElopwR7e+6gtjsBy2Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="249567521"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 Mar 2026 10:56:39 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyaLj-000000001HF-47zg;
	Fri, 06 Mar 2026 18:56:35 +0000
Date: Sat, 7 Mar 2026 02:55:36 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Move snapshot code out of trace.c and into
 trace_snapshot.c
Message-ID: <202603070206.u4DPFtuW-lkp@intel.com>
References: <20260305211810.3f48aa07@robin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305211810.3f48aa07@robin>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on v7.0-rc2]
[cannot apply to trace/for-next linus/master next-20260306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Move-snapshot-code-out-of-trace-c-and-into-trace_snapshot-c/20260306-102714
base:   v7.0-rc2
patch link:    https://lore.kernel.org/r/20260305211810.3f48aa07%40robin
patch subject: [PATCH] tracing: Move snapshot code out of trace.c and into trace_snapshot.c
config: arc-randconfig-002-20260307 (https://download.01.org/0day-ci/archive/20260307/202603070206.u4DPFtuW-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603070206.u4DPFtuW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603070206.u4DPFtuW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/trace_snapshot.c:395:20: error: redefinition of 'latency_fsnotify'
     395 | static inline void latency_fsnotify(struct trace_array *tr) { }
         |                    ^~~~~~~~~~~~~~~~
   In file included from kernel/trace/trace_snapshot.c:6:
   kernel/trace/trace.h:852:20: note: previous definition of 'latency_fsnotify' with type 'void(struct trace_array *)'
     852 | static inline void latency_fsnotify(struct trace_array *tr) { }
         |                    ^~~~~~~~~~~~~~~~


vim +/latency_fsnotify +395 kernel/trace/trace_snapshot.c

   382	
   383	void latency_fsnotify(struct trace_array *tr)
   384	{
   385		if (!fsnotify_wq)
   386			return;
   387		/*
   388		 * We cannot call queue_work(&tr->fsnotify_work) from here because it's
   389		 * possible that we are called from __schedule() or do_idle(), which
   390		 * could cause a deadlock.
   391		 */
   392		irq_work_queue(&tr->fsnotify_irqwork);
   393	}
   394	#else
 > 395	static inline void latency_fsnotify(struct trace_array *tr) { }
   396	#endif /* LATENCY_FS_NOTIFY */
   397	static const struct file_operations tracing_max_lat_fops;
   398	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
