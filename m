Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5D92E542B;
	Mon, 10 Nov 2025 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762750851; cv=none; b=ZAgDCzWAWzEOitrvPTz2QDFxNLsPErscfQ1z1DSSmmfu65oAnv2p1xTMfQRwVup7nWkcrH4I2XkZr/u86jssI64zGlJrZix6u5mQ+kRWs0H2h2rGzzZ3XoYmlIhR9IOWbH0CTKyLQCW038MkEX4wTiaob+ri8j7E/rxfmQdlNSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762750851; c=relaxed/simple;
	bh=Zihc7hWYZQ5PyKsrvTu7dvnZV4LROwLSC+EosXzLTkg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=usDeCNzd7B835WxynCVCTqfIJ1+2t+jktT0vg9oXjGH7ckTAkZiRhdz6XtV7GpvNKC9DO7sREZq0n7H2klYWRCuuPDAx1xfAdHTLuR4CouhF1y3qMb22dbUpalX6dzTTJq6eHo89Wg9oXai/F2Ht5aj22xznsxK3J84CH8EjN00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXRf8yzd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXRf8yzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4986C4CEFB;
	Mon, 10 Nov 2025 05:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762750850;
	bh=Zihc7hWYZQ5PyKsrvTu7dvnZV4LROwLSC+EosXzLTkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jXRf8yzdb7xe0Hx6zRVAuaecivybs7i3kxbZIk1UTs2KoHs91e+ZxJxp9NyiG9Udc
	 Mpb5AAlUStuKXn3dEff7/a9Mulsyw3bdQbs0K9UC0tDttOhp2CFtc0QIMYc9C3eolf
	 w/G7P04A8JLSfnB8BR/6+lbkvVQrJfG1xBD2yny9omGXnb7/P0Lv0nm6zl2DdriDLQ
	 ZG56m4BWXlNwnkVMYaxTS92hYKRhqmwt7aCwnLv5tAJvfkOyTTvUw2RXpR0IOoWYID
	 mJCmQh4g71ai2SK48A9/l0LEb3zRCF9aCYp5ib26xjJT14hXnbTK7GInDcV0GN4imu
	 DvujI/SMX9Ssg==
Date: Mon, 10 Nov 2025 14:00:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, oe-kbuild-all@lists.linux.dev,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Report wrong dynamic event command
Message-Id: <20251110140048.4b2f93e0d5d93a12b030d550@kernel.org>
In-Reply-To: <202511092149.N375MBPu-lkp@intel.com>
References: <176259938768.261465.10714633393722227911.stgit@devnote2>
	<202511092149.N375MBPu-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Nov 2025 21:27:50 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on trace/for-next]
> [also build test ERROR on next-20251107]
> [cannot apply to linus/master v6.18-rc4]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-Report-wrong-dynamic-event-command/20251108-185823
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
> patch link:    https://lore.kernel.org/r/176259938768.261465.10714633393722227911.stgit%40devnote2
> patch subject: [PATCH] tracing: Report wrong dynamic event command
> config: s390-randconfig-002-20251109 (https://download.01.org/0day-ci/archive/20251109/202511092149.N375MBPu-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511092149.N375MBPu-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511092149.N375MBPu-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    s390-linux-ld: kernel/trace/trace_dynevent.o: in function `create_dyn_event':
> >> kernel/trace/trace_dynevent.c:150: undefined reference to `trace_probe_log_init'
> >> s390-linux-ld: kernel/trace/trace_dynevent.c:151: undefined reference to `__trace_probe_log_err'
> >> s390-linux-ld: kernel/trace/trace_dynevent.c:152: undefined reference to `trace_probe_log_clear'

Oops, it is because CONFIG_DYNAMIC_EVENTS=y but CONFIG_PROBE_EVENTS=n.
Hmm, it seems better to make "trace_probe_log.{c,h}" for this purpose.

Thank you,

> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for I2C_K1
>    Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && OF [=n]
>    Selected by [y]:
>    - MFD_SPACEMIT_P1 [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && I2C [=y]
> 
> 
> vim +150 kernel/trace/trace_dynevent.c
> 
>    133	
>    134	static int create_dyn_event(const char *raw_command)
>    135	{
>    136		struct dyn_event_operations *ops;
>    137		int ret = -ENODEV;
>    138	
>    139		if (raw_command[0] == '-' || raw_command[0] == '!')
>    140			return dyn_event_release(raw_command, NULL);
>    141	
>    142		mutex_lock(&dyn_event_ops_mutex);
>    143		list_for_each_entry(ops, &dyn_event_ops_list, list) {
>    144			ret = ops->create(raw_command);
>    145			if (!ret || ret != -ECANCELED)
>    146				break;
>    147		}
>    148		if (ret == -ECANCELED) {
>    149			/* Wrong dynamic event. Leave an error message. */
>  > 150			trace_probe_log_init("dynevent", 1, &raw_command);
>  > 151			trace_probe_log_err(0, BAD_DYN_EVENT);
>  > 152			trace_probe_log_clear();
>    153			ret = -EINVAL;
>    154		}
>    155	
>    156		mutex_unlock(&dyn_event_ops_mutex);
>    157	
>    158		return ret;
>    159	}
>    160	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
