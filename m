Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2698239BC4;
	Wed, 11 Dec 2024 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914491; cv=none; b=Au7j6ekknkBA/W0p+zZo+1IHy8C3WC9r5QJMRYW1DqrQIX5T7HcLPD6FRkt0EJdD2z4a2AiuAGMnFeb+UdgYVKo0Wrrmxte06BCy6KUSTWI/4JrCRiNhfRZ0nUtzjBm9H2mP+cahHpf4Zx6Zlg96mJB3vNjCR7iSzNftVPzTGiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914491; c=relaxed/simple;
	bh=88xhvCZVVQ7MMWEjV5gF/Jgx9nuJ7UiTlfm2nIm28bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxeEbi+F5qdKcT8st/d0+REuIReA7/BEKmwtM1ME6XJO/7Ll/FglKfG74ktUHZVi8wMeBz1QH1K3RhV43jfDhpHp0d9Ot6yR7eoO/LMTAynWRltUox5Gd7V+aXuP0ltmcxxsPpfDac/lixQPvAtaL994s5XBVjD3m4r9oAZqiD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VO/SKcbh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VO/SKcbh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733914490; x=1765450490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=88xhvCZVVQ7MMWEjV5gF/Jgx9nuJ7UiTlfm2nIm28bs=;
  b=VO/SKcbhDw6+vzifQrfvORGLpxQl1z32IEcxZxK1Vefhy2sJTuY8sAHR
   vs1Nb0BDQhAVBHbSv9YH+zedro+ujoPoNDH/aPAyT5EnHBc+cJs+hVPN7
   Mq+evMTTDaGP3g1Wg+oRsrC7vlRqpEKohNCT9mWaeiLEH/honitDGNMtc
   9gV1gggrWUAuUqdT146qy56NRJmYlhNSm93D58W+NjJKPm6782hJxC6i4
   wlrMYBS4bI7QKx0oUcig28E5Z22xW/0Zjks/WIhBte1EtAoae7RSBLd16
   +mjp8iUX8/SBpidFjgCIZXrsQnA/VKsyncArKJmEX5uYTbDb05BUCouPB
   Q==;
X-CSE-ConnectionGUID: d/ciWB+JSLiOjr2G7WqVEg==
X-CSE-MsgGUID: WGL3Imu8R4KkEsj5b2R6YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33608787"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="33608787"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 02:54:49 -0800
X-CSE-ConnectionGUID: BHu3gHueTVi+j0VZZSIKLQ==
X-CSE-MsgGUID: rOeH2C9eSM2PphypSv/M2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95591184"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Dec 2024 02:54:46 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLKMe-0006ZB-2i;
	Wed, 11 Dec 2024 10:54:44 +0000
Date: Wed, 11 Dec 2024 18:53:44 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Fix trace output when pointer hash is disabled
Message-ID: <202412111800.LkbDgOfH-lkp@intel.com>
References: <20241210172533.04bcd5f7@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210172533.04bcd5f7@batman.local.home>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.13-rc2 next-20241211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Fix-trace-output-when-pointer-hash-is-disabled/20241211-062827
base:   linus/master
patch link:    https://lore.kernel.org/r/20241210172533.04bcd5f7%40batman.local.home
patch subject: [PATCH] tracing: Fix trace output when pointer hash is disabled
config: i386-buildonly-randconfig-003-20241211 (https://download.01.org/0day-ci/archive/20241211/202412111800.LkbDgOfH-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241211/202412111800.LkbDgOfH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412111800.LkbDgOfH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/trace/trace.c:15:
   In file included from include/linux/ring_buffer.h:5:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> kernel/trace/trace.c:3749:8: warning: variable 'p' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    3749 |                         if (!trace_iter_expand_format(iter))
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:3900:7: note: uninitialized use occurs here
    3900 |         if (*p)
         |              ^
   kernel/trace/trace.c:3749:4: note: remove the 'if' if its condition is always false
    3749 |                         if (!trace_iter_expand_format(iter))
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3750 |                                 goto print;
         |                                 ~~~~~~~~~~
   kernel/trace/trace.c:3739:6: warning: variable 'p' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    3739 |         if (iter->fmt == static_fmt_buf)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:3900:7: note: uninitialized use occurs here
    3900 |         if (*p)
         |              ^
   kernel/trace/trace.c:3739:2: note: remove the 'if' if its condition is always false
    3739 |         if (iter->fmt == static_fmt_buf)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3740 |                 goto print;
         |                 ~~~~~~~~~~
   kernel/trace/trace.c:3724:6: warning: variable 'p' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    3724 |         if (static_branch_unlikely(&trace_no_verify))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/jump_label.h:497:40: note: expanded from macro 'static_branch_unlikely'
     497 | #define static_branch_unlikely(x)                                               \
         |                                                                                 ^
     498 | ({                                                                              \
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     499 |         bool branch;                                                            \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     500 |         if (__builtin_types_compatible_p(typeof(*x), struct static_key_true))   \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     501 |                 branch = arch_static_branch_jump(&(x)->key, false);             \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     502 |         else if (__builtin_types_compatible_p(typeof(*x), struct static_key_false)) \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     503 |                 branch = arch_static_branch(&(x)->key, false);                  \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     504 |         else                                                                    \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     505 |                 branch = ____wrong_branch_error();                              \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     506 |         unlikely_notrace(branch);                                                       \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     507 | })
         | ~~
   kernel/trace/trace.c:3900:7: note: uninitialized use occurs here
    3900 |         if (*p)
         |              ^
   kernel/trace/trace.c:3724:2: note: remove the 'if' if its condition is always false
    3724 |         if (static_branch_unlikely(&trace_no_verify))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3725 |                 goto print;
         |                 ~~~~~~~~~~
   kernel/trace/trace.c:3715:9: note: initialize the variable 'p' to silence this warning
    3715 |         char *p;
         |                ^
         |                 = NULL
   4 warnings generated.


vim +3749 kernel/trace/trace.c

  3696	
  3697	/**
  3698	 * trace_check_vprintf - Check dereferenced strings while writing to the seq buffer
  3699	 * @iter: The iterator that holds the seq buffer and the event being printed
  3700	 * @fmt: The format used to print the event
  3701	 * @ap: The va_list holding the data to print from @fmt.
  3702	 *
  3703	 * This writes the data into the @iter->seq buffer using the data from
  3704	 * @fmt and @ap. If the format has a %s, then the source of the string
  3705	 * is examined to make sure it is safe to print, otherwise it will
  3706	 * warn and print "[UNSAFE MEMORY]" in place of the dereferenced string
  3707	 * pointer.
  3708	 */
  3709	void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
  3710				 va_list ap)
  3711	{
  3712		long text_delta = 0;
  3713		long data_delta = 0;
  3714		const char *str;
  3715		char *p;
  3716		char save_ch;
  3717		char *buf = NULL;
  3718		bool good;
  3719		int i, j;
  3720	
  3721		if (WARN_ON_ONCE(!fmt))
  3722			return;
  3723	
  3724		if (static_branch_unlikely(&trace_no_verify))
  3725			goto print;
  3726	
  3727		/*
  3728		 * When the kernel is booted with the tp_printk command line
  3729		 * parameter, trace events go directly through to printk().
  3730		 * It also is checked by this function, but it does not
  3731		 * have an associated trace_array (tr) for it.
  3732		 */
  3733		if (iter->tr) {
  3734			text_delta = iter->tr->text_delta;
  3735			data_delta = iter->tr->data_delta;
  3736		}
  3737	
  3738		/* Don't bother checking when doing a ftrace_dump() */
  3739		if (iter->fmt == static_fmt_buf)
  3740			goto print;
  3741	
  3742		if (fmt != iter->fmt) {
  3743			int len = strlen(fmt);
  3744			while (iter->fmt_size < len + 1) {
  3745				/*
  3746				 * If we can't expand the copy buffer,
  3747				 * just print it.
  3748				 */
> 3749				if (!trace_iter_expand_format(iter))
  3750					goto print;
  3751			}
  3752			strscpy(iter->fmt, fmt, iter->fmt_size);
  3753		}
  3754		p = iter->fmt;
  3755		while (*p) {
  3756			bool star = false;
  3757			int len = 0;
  3758	
  3759			j = 0;
  3760	
  3761			/*
  3762			 * We only care about %s and variants
  3763			 * as well as %p[sS] if delta is non-zero
  3764			 */
  3765			for (i = 0; p[i]; i++) {
  3766	
  3767				if (p[i] == '\\' && p[i+1]) {
  3768					i++;
  3769					continue;
  3770				}
  3771				if (p[i] == '%') {
  3772					/* Need to test cases like %08.*s */
  3773					for (j = 1; p[i+j]; j++) {
  3774						if (isdigit(p[i+j]) ||
  3775						    p[i+j] == '.')
  3776							continue;
  3777						if (p[i+j] == '*') {
  3778							star = true;
  3779							continue;
  3780						}
  3781						break;
  3782					}
  3783					if (p[i+j] == 's')
  3784						break;
  3785	
  3786					if (text_delta && p[i+1] == 'p' &&
  3787					    ((p[i+2] == 's' || p[i+2] == 'S')))
  3788						break;
  3789	
  3790					star = false;
  3791				}
  3792				j = 0;
  3793			}
  3794			/* If no %s found then just print normally */
  3795			if (!p[i])
  3796				break;
  3797	
  3798			/* Print up to the %s */
  3799			save_ch = p[i];
  3800			p[i] = '\0';
  3801			trace_seq_vprintf(&iter->seq, p, ap);
  3802			p[i] = save_ch;
  3803	
  3804			/* Add delta to %pS pointers */
  3805			if (p[i+1] == 'p') {
  3806				unsigned long addr;
  3807				char fmt[4];
  3808	
  3809				fmt[0] = '%';
  3810				fmt[1] = 'p';
  3811				fmt[2] = p[i+2]; /* Either %ps or %pS */
  3812				fmt[3] = '\0';
  3813	
  3814				addr = va_arg(ap, unsigned long);
  3815				addr += text_delta;
  3816				trace_seq_printf(&iter->seq, fmt, (void *)addr);
  3817	
  3818				p += i + 3;
  3819				continue;
  3820			}
  3821	
  3822			/*
  3823			 * If iter->seq is full, the above call no longer guarantees
  3824			 * that ap is in sync with fmt processing, and further calls
  3825			 * to va_arg() can return wrong positional arguments.
  3826			 *
  3827			 * Ensure that ap is no longer used in this case.
  3828			 */
  3829			if (iter->seq.full) {
  3830				p = "";
  3831				break;
  3832			}
  3833	
  3834			if (star)
  3835				len = va_arg(ap, int);
  3836	
  3837			/* The ap now points to the string data of the %s */
  3838			str = va_arg(ap, const char *);
  3839	
  3840			good = trace_safe_str(iter, str, star, len);
  3841	
  3842			/* Could be from the last boot */
  3843			if (data_delta && !good) {
  3844				str += data_delta;
  3845				good = trace_safe_str(iter, str, star, len);
  3846			}
  3847	
  3848			p += i;
  3849	
  3850			/*
  3851			 * If you hit this warning, it is likely that the
  3852			 * trace event in question used %s on a string that
  3853			 * was saved at the time of the event, but may not be
  3854			 * around when the trace is read. Use __string(),
  3855			 * __assign_str() and __get_str() helpers in the TRACE_EVENT()
  3856			 * instead. See samples/trace_events/trace-events-sample.h
  3857			 * for reference.
  3858			 */
  3859			if (WARN_ONCE(!good, "fmt: '%s' current_buffer: '%s'",
  3860				      fmt, seq_buf_str(&iter->seq.seq))) {
  3861				int ret;
  3862	#define TEMP_BUFSIZ 1024
  3863	
  3864				if (!buf) {
  3865					char *buf = kmalloc(TEMP_BUFSIZ, GFP_KERNEL);
  3866					if (!buf) {
  3867						/* Need buffer to read address */
  3868						trace_seq_printf(&iter->seq, "(0x%px)[UNSAFE-MEMORY]", str);
  3869						goto print;
  3870					}
  3871				}
  3872				if (len >= TEMP_BUFSIZ)
  3873					len = TEMP_BUFSIZ - 1;
  3874	
  3875				/* Try to safely read the string */
  3876				if (star) {
  3877					ret = copy_from_kernel_nofault(buf, str, len);
  3878					buf[len] = 0;
  3879				} else {
  3880					ret = strncpy_from_kernel_nofault(buf, str, 1024);
  3881				}
  3882				if (ret < 0)
  3883					trace_seq_printf(&iter->seq, "(0x%px)", str);
  3884				else
  3885					trace_seq_printf(&iter->seq, "(0x%px:%s)", str, buf);
  3886				trace_seq_puts(&iter->seq, "[UNSAFE-MEMORY]");
  3887			} else {
  3888				save_ch = p[j + 1];
  3889				p[j + 1] = '\0';
  3890				if (star)
  3891					trace_seq_printf(&iter->seq, p, len, str);
  3892				else
  3893					trace_seq_printf(&iter->seq, p, str);
  3894				p[j + 1] = save_ch;
  3895			}
  3896	
  3897			p += j + 1;
  3898		}
  3899	 print:
  3900		if (*p)
  3901			trace_seq_vprintf(&iter->seq, p, ap);
  3902		kfree(buf);
  3903	}
  3904	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
