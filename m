Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B149215160;
	Fri, 10 Jan 2025 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736539142; cv=none; b=pdf6kpc6VY+IApifGRId5gBP7uXEiri2gjFrcRYXZSQIB+wmfbaYYAZeox+lFjn85lvLqCsO82BIqi3c0LHRbXh725eC1tbjUDU2yBjIe8jxjpu+MkWmJl0RyqvLJ/u2z1Md8a7qVTp4n3q3XSgCINz1qxMoFieWYE6+3oMldJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736539142; c=relaxed/simple;
	bh=l1whIIccZw9RwJGfk2f/RPM4K5voCB9m0pojCebFulc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6fm7REVI0ZMZLVIqzyhqhbYRGxy74AZlMAlbfwKw59WiSZ/HQj+Tc94I0NMW+XkwR8YKK/SfDUUQv8VkkqB0Dn0eHH93LnTYcft950skbE5HhOuhR3tuV2IsE2acoT02/6f9pjnYhCTpWOzFt6Y8LnVobdgDwjxmQ4txM91uSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRHsuvXo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRHsuvXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736539141; x=1768075141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l1whIIccZw9RwJGfk2f/RPM4K5voCB9m0pojCebFulc=;
  b=nRHsuvXo8FaWqz7aGsdxY/BGwFLtkVZqarUh3O45kPh86k7eEoCg+peS
   VKclo60MC7HRBwsA7a485c/aRGraP7U6gFSYHfUFeGd54e0KW5eGijo4H
   VFR3RvvqjBjKEW8mQzmHlYUdZJ6hbTFo58dlG+N1JfFpgv5sWxSDyJs0A
   GKtFB8OWRfXMe6P1rzcrrPPHSTspVG18k52rCeGId8KWuDM20PvtNIJ9G
   aVP7CYcKq6NNAULsLyNkYx/DEiU7xddDOe7pMCeaj8wh14aRFC4qbWH7u
   lmEpp6kl3Qv+1mosYwKE9gQizgr6HRP0f8zed5IepKFP2Z4fFpA4fc2V2
   Q==;
X-CSE-ConnectionGUID: ezQlN6UGRcy6P3Xkkp4SHg==
X-CSE-MsgGUID: 1v+6GyGDT+6QLgLQvp+VQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="36531277"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="36531277"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 11:59:01 -0800
X-CSE-ConnectionGUID: hAQkn7a3TJK27gieJiGP3g==
X-CSE-MsgGUID: RGjG7ftrRTyWalftZf6LFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="103634248"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Jan 2025 11:58:58 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWL9k-000Jgh-0P;
	Fri, 10 Jan 2025 19:58:56 +0000
Date: Sat, 11 Jan 2025 03:57:57 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jochensp@jochen.sprickerhof.de
Subject: Re: [PATCH] ftrace: Implement :mod: cache filtering on kernel
 command line
Message-ID: <202501110314.8tTxSS0N-lkp@intel.com>
References: <20250109174639.32e6f43a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109174639.32e6f43a@gandalf.local.home>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.13-rc6 next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/ftrace-Implement-mod-cache-filtering-on-kernel-command-line/20250110-064649
base:   linus/master
patch link:    https://lore.kernel.org/r/20250109174639.32e6f43a%40gandalf.local.home
patch subject: [PATCH] ftrace: Implement :mod: cache filtering on kernel command line
config: i386-randconfig-013-20250111 (https://download.01.org/0day-ci/archive/20250111/202501110314.8tTxSS0N-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250111/202501110314.8tTxSS0N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501110314.8tTxSS0N-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/ftrace.c:6232:6: warning: variable 'mod' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    6232 |         if (next) {
         |             ^~~~
   kernel/trace/ftrace.c:6246:67: note: uninitialized use occurs here
    6246 |         ret = ftrace_set_hash(ops, func, len, NULL, 0, 0, reset, enable, mod);
         |                                                                          ^~~
   kernel/trace/ftrace.c:6232:2: note: remove the 'if' if its condition is always true
    6232 |         if (next) {
         |         ^~~~~~~~~
   kernel/trace/ftrace.c:6224:11: note: initialize the variable 'mod' to silence this warning
    6224 |         char *mod, *func, *command, *next = buf;
         |                  ^
         |                   = NULL
   1 warning generated.


vim +6232 kernel/trace/ftrace.c

  6219	
  6220	static int
  6221	ftrace_set_regex(struct ftrace_ops *ops, unsigned char *buf, int len,
  6222			 int reset, int enable)
  6223	{
  6224		char *mod, *func, *command, *next = buf;
  6225		char *tmp __free(kfree) = NULL;
  6226		struct trace_array *tr = ops->private;
  6227		int ret;
  6228	
  6229		func = strsep(&next, ":");
  6230	
  6231		/* This can also handle :mod: parsing */
> 6232		if (next) {
  6233			if (!tr)
  6234				return -EINVAL;
  6235	
  6236			command = strsep(&next, ":");
  6237			if (strcmp(command, "mod") != 0)
  6238				return -EINVAL;
  6239	
  6240			mod = next;
  6241			len = command - func;
  6242			/* Save the original func as ftrace_set_hash() can modify it */
  6243			tmp = kstrdup(func, GFP_KERNEL);
  6244		}
  6245	
  6246		ret = ftrace_set_hash(ops, func, len, NULL, 0, 0, reset, enable, mod);
  6247	
  6248		if (tr && mod && ret < 0) {
  6249			/* Did tmp fail to allocate? */
  6250			if (!tmp)
  6251				return -ENOMEM;
  6252			ret = cache_mod(tr, tmp, mod, enable);
  6253		}
  6254	
  6255		return ret;
  6256	}
  6257	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
