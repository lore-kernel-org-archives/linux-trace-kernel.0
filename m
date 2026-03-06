Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B211736F43D;
	Fri,  6 Mar 2026 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823406; cv=none; b=LukkEBeZ18XpugroEor4SSnrhsunonwHzGBtes33E+d/zQYRsyGvqihvFoSgCrFvy8808SjdXOhfIU2wd/lT4fKeJiv0Vh949vWzpE8aCmlkhpRv8Wd8BcBgjux6AXq0eHX1V/a65O98AJiNQtoKs2WB0vllGbAkl/3z4W4awRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823406; c=relaxed/simple;
	bh=2soiy/JF0zlGYzhyb2qqRkZbTvqQ/i6pIDbQWYvPmlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4OYeBuL71GXZXqhBECUT54vfLU5ZWMLTDiNjIYtmUagpvf340VyjK4qLGWtZsz/jkynogyUHsMqbTsoYxOBd5Awk1ZvgzDT5T9J0yGM2P645cSzcrJTE8QqSnJUvhRwEE/N6vg9UmPRFHYLL7kpaTOaT99fPGPgic+G5wbo4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFQhypVD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFQhypVD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772823405; x=1804359405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2soiy/JF0zlGYzhyb2qqRkZbTvqQ/i6pIDbQWYvPmlw=;
  b=iFQhypVD+ldBkqK8Y9tmwr3lJwYebPVuCYTMmk/dg1jAbg93dIWSaazG
   DTMbDcK80/c/1TsH3x9xfItjMiA54wklhpkM+cAj6b2/CEh7B/qSbZAQR
   1IflwrBFpSuFe9FWLmbRY1kjBA3Kcp+tBYtn1onWbF9pdXzsFlhi3LPeg
   ShxPrWfghLCYiFsrv0YuPZMrHDG44AFQYSWkND/pcTq0+J99FmBZN01IS
   59a21ULyLPTvhAVSmM03exT4G20I8LGq6/PYQNJvpcG5862T8005ms9Dt
   SgH0t5+7FS9PNOAh99kC192NmoO7oQoQoLLC3+cfGTLt2wPBg6NkkYUBu
   Q==;
X-CSE-ConnectionGUID: k0sgwdJNT82FhG5Zlzn5VQ==
X-CSE-MsgGUID: azK6TlASTDmA6hxtV2iUVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="74127354"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="74127354"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 10:56:41 -0800
X-CSE-ConnectionGUID: RywaRXjVQ52GbjhSdQEIIA==
X-CSE-MsgGUID: SVeAGVxJSPyer/WREavCzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="249567524"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 Mar 2026 10:56:39 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyaLk-000000001HH-00Ig;
	Fri, 06 Mar 2026 18:56:36 +0000
Date: Sat, 7 Mar 2026 02:55:37 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Move snapshot code out of trace.c and into
 trace_snapshot.c
Message-ID: <202603070253.0Z0n4vtm-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on v7.0-rc2]
[cannot apply to trace/for-next linus/master next-20260305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Move-snapshot-code-out-of-trace-c-and-into-trace_snapshot-c/20260306-102714
base:   v7.0-rc2
patch link:    https://lore.kernel.org/r/20260305211810.3f48aa07%40robin
patch subject: [PATCH] tracing: Move snapshot code out of trace.c and into trace_snapshot.c
config: sh-defconfig (https://download.01.org/0day-ci/archive/20260307/202603070253.0Z0n4vtm-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603070253.0Z0n4vtm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603070253.0Z0n4vtm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace.c:820:5: warning: no previous prototype for 'tracing_alloc_snapshot' [-Wmissing-prototypes]
     820 | int tracing_alloc_snapshot(void)
         |     ^~~~~~~~~~~~~~~~~~~~~~


vim +/tracing_alloc_snapshot +820 kernel/trace/trace.c

ad909e21bbe69f1 Steven Rostedt (Red Hat  2013-03-06  792) 
93e31ffbf417a84 Tom Zanussi              2013-10-24  793  /**
93e31ffbf417a84 Tom Zanussi              2013-10-24  794   * tracing_alloc_snapshot - allocate snapshot buffer.
93e31ffbf417a84 Tom Zanussi              2013-10-24  795   *
93e31ffbf417a84 Tom Zanussi              2013-10-24  796   * This only allocates the snapshot buffer if it isn't already
93e31ffbf417a84 Tom Zanussi              2013-10-24  797   * allocated - it doesn't also take a snapshot.
93e31ffbf417a84 Tom Zanussi              2013-10-24  798   *
93e31ffbf417a84 Tom Zanussi              2013-10-24  799   * This is meant to be used in cases where the snapshot buffer needs
93e31ffbf417a84 Tom Zanussi              2013-10-24  800   * to be set up for events that can't sleep but need to be able to
93e31ffbf417a84 Tom Zanussi              2013-10-24  801   * trigger a snapshot.
93e31ffbf417a84 Tom Zanussi              2013-10-24  802   */
93e31ffbf417a84 Tom Zanussi              2013-10-24  803  int tracing_alloc_snapshot(void)
93e31ffbf417a84 Tom Zanussi              2013-10-24  804  {
93e31ffbf417a84 Tom Zanussi              2013-10-24  805  	struct trace_array *tr = &global_trace;
93e31ffbf417a84 Tom Zanussi              2013-10-24  806  	int ret;
93e31ffbf417a84 Tom Zanussi              2013-10-24  807  
2824f5033248600 Steven Rostedt (VMware   2018-05-28  808) 	ret = tracing_alloc_snapshot_instance(tr);
93e31ffbf417a84 Tom Zanussi              2013-10-24  809  	WARN_ON(ret < 0);
93e31ffbf417a84 Tom Zanussi              2013-10-24  810  
93e31ffbf417a84 Tom Zanussi              2013-10-24  811  	return ret;
93e31ffbf417a84 Tom Zanussi              2013-10-24  812  }
93e31ffbf417a84 Tom Zanussi              2013-10-24  813  EXPORT_SYMBOL_GPL(tracing_alloc_snapshot);
ad909e21bbe69f1 Steven Rostedt (Red Hat  2013-03-06  814) #else
ad909e21bbe69f1 Steven Rostedt (Red Hat  2013-03-06  815) void tracing_snapshot(void)
ad909e21bbe69f1 Steven Rostedt (Red Hat  2013-03-06  816) {
ad909e21bbe69f1 Steven Rostedt (Red Hat  2013-03-06  817) 	WARN_ONCE(1, "Snapshot feature not enabled, but internal snapshot used");
ad909e21bbe69f1 Steven Rostedt (Red Hat  2013-03-06  818) }
1b22e382ab40b0e Steven Rostedt (Red Hat  2013-03-09  819) EXPORT_SYMBOL_GPL(tracing_snapshot);
93e31ffbf417a84 Tom Zanussi              2013-10-24 @820  int tracing_alloc_snapshot(void)
93e31ffbf417a84 Tom Zanussi              2013-10-24  821  {
93e31ffbf417a84 Tom Zanussi              2013-10-24  822  	WARN_ONCE(1, "Snapshot feature not enabled, but snapshot allocation used");
93e31ffbf417a84 Tom Zanussi              2013-10-24  823  	return -ENODEV;
93e31ffbf417a84 Tom Zanussi              2013-10-24  824  }
93e31ffbf417a84 Tom Zanussi              2013-10-24  825  EXPORT_SYMBOL_GPL(tracing_alloc_snapshot);
ad909e21bbe69f1 Steven Rostedt (Red Hat  2013-03-06  826) void tracing_snapshot_alloc(void)
ad909e21bbe69f1 Steven Rostedt (Red Hat  2013-03-06  827) {
ad909e21bbe69f1 Steven Rostedt (Red Hat  2013-03-06  828) 	/* Give warning */
ad909e21bbe69f1 Steven Rostedt (Red Hat  2013-03-06  829) 	tracing_snapshot();
ad909e21bbe69f1 Steven Rostedt (Red Hat  2013-03-06  830) }
1b22e382ab40b0e Steven Rostedt (Red Hat  2013-03-09  831) EXPORT_SYMBOL_GPL(tracing_snapshot_alloc);
ad909e21bbe69f1 Steven Rostedt (Red Hat  2013-03-06  832) #endif /* CONFIG_TRACER_SNAPSHOT */
ad909e21bbe69f1 Steven Rostedt (Red Hat  2013-03-06  833) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
