Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D35B375ABE;
	Wed, 11 Mar 2026 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773214922; cv=none; b=LMmj+p/ieOzvhEaD+FiTwIuqUlLlbnjMLo7m3PBPOtet/Rzq5enrqF6ZXcR+3vI/x+wl/4aO32a6QbuelE9tww8ZovovtXnqa2epjuyo4Wzm71JOkwsdmpyBPalIS8NDYwa9SK+r9rZRUyfYSN4Mmfp4so/oPhREHNPyx/Y33D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773214922; c=relaxed/simple;
	bh=VOyzQxkiOrYyQ5++xZdWU53tYlT+cG5P+BjBAxzOJqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K501UXzwFhTAzTERAaaUDOf7Ttu9iBnngbkV07vkHe/N1lQmoig217KwfWRNcaaCTHdsDr7/e3bg97PD7aHzKg2miZg+xPYBHKIWB1/ejxc+zb/nklRPTmEOn72C1LaCX8RfH3Ru6A5zDdmYSCmzgMX0+UQmP56PABAOE5I+0kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/g98Z3v; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/g98Z3v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773214917; x=1804750917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VOyzQxkiOrYyQ5++xZdWU53tYlT+cG5P+BjBAxzOJqE=;
  b=i/g98Z3vlJUCba4TEfFE0CQ9+ibaatvxbeMrkE2JeMoxVjlpRMzTdSgv
   MZ6FFOQ6S7ry2rfu0Vhb82yqXGCq7mbKZN1vvl4C7UTwvbutnep0QOw9l
   rYfDI4HAcA2H7xTOJT9UA2jDfHOfqwpHX7Djm/QaPHVN5b/tmvhKb3Skp
   cVSO4JJd256RyYpH9JB96yYq48OCSDDg36x1jMZ43MsZ9VIZtDpIOYttd
   utVgOaOVaEo+Tkye334EjYQAoM8FyIJ5vXqCpUTeYhzITkF1JUZFlW4Dv
   rvgtidV2qrGzhcEq54bA0YfR/5YjNJLaeWgEON1Bd3GYytzX+JcbIzTW8
   w==;
X-CSE-ConnectionGUID: l2XIoVuhQLqkK978cd4EmQ==
X-CSE-MsgGUID: rZqaJT5AT429v1lqpXk+7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74394421"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74394421"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 00:41:55 -0700
X-CSE-ConnectionGUID: /X5V1c6LS9+3qp302cC7lw==
X-CSE-MsgGUID: l2aL8VOtTrCZh90fqg3DCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="243391357"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 11 Mar 2026 00:41:51 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0ECT-000000003HV-28cV;
	Wed, 11 Mar 2026 07:41:49 +0000
Date: Wed, 11 Mar 2026 08:41:35 +0100
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Brian Geffon <bgeffon@google.com>, John Stultz <jstultz@google.com>,
	Ian Rogers <irogers@google.com>,
	Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH v2 1/3] tracing: Have futex syscall trace event show
 specific user data
Message-ID: <202603110841.Pxedg2y4-lkp@intel.com>
References: <20260310201036.542627924@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310201036.542627924@kernel.org>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on trace/for-next akpm-mm/mm-everything linus/master v7.0-rc3 next-20260310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Have-futex-syscall-trace-event-show-specific-user-data/20260311-041422
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20260310201036.542627924%40kernel.org
patch subject: [PATCH v2 1/3] tracing: Have futex syscall trace event show specific user data
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260311/202603110841.Pxedg2y4-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260311/202603110841.Pxedg2y4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603110841.Pxedg2y4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/trace_syscalls.c: In function 'syscall_get_futex':
>> kernel/trace/trace_syscalls.c:807:15: warning: variable 'buf' set but not used [-Wunused-but-set-variable]
     807 |         char *buf;
         |               ^~~


vim +/buf +807 kernel/trace/trace_syscalls.c

   801	
   802	static int
   803	syscall_get_futex(unsigned long *args, char **buffer, int *size, int buf_size)
   804	{
   805		struct syscall_user_buffer *sbuf;
   806		const char __user *ptr;
 > 807		char *buf;
   808	
   809		/* buf_size of zero means user doesn't want user space read */
   810		if (!buf_size)
   811			return -1;
   812	
   813		/* If the syscall_buffer is NULL, tracing is being shutdown */
   814		sbuf = READ_ONCE(syscall_buffer);
   815		if (!sbuf)
   816			return -1;
   817	
   818		ptr = (char __user *)args[0];
   819	
   820		*buffer = trace_user_fault_read(&sbuf->buf, ptr, 4, NULL, NULL);
   821		if (!*buffer)
   822			return -1;
   823	
   824		/* Add room for the value */
   825		*size += 4;
   826	
   827		buf = *buffer;
   828	
   829		return 0;
   830	}
   831	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
