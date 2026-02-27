Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B197A36EA83;
	Fri, 27 Feb 2026 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772178245; cv=none; b=DTNieu8TwSQZfU7glKAk81pFlsg729lZHgXxpRvFoCispF+JHf46usv83BWC4jG0wEz60/ucUSJjAYkNccXAdclhsouTFu4oCDoYKKdtH+I+WLICfpHcRGwnqhKmC2UE8ZRMGU5WT0RAeYJ+ucov7u99LHwmFkMaB4/ujUxI2Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772178245; c=relaxed/simple;
	bh=7Nxw0eSNeEjIVxbS8tqkJXhH7vZE92ayhWGdRZaFasw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fK5MaoTGrRU4u82BwlPQC/ziGvtfXuxMqG4YDGKCuTVZqBDJloP1CIO3iI8CRpHrksjob7goEGlq/FMPAHo6pdGVNLTCkqCv85z/uhKsT16Wnyy/7XKF3K4stK5pBu1PHYVhZerpwqCtql0shiHCKXVPYluIvypKWzwmbYA3J1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kibvgiyD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kibvgiyD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F499C116C6;
	Fri, 27 Feb 2026 07:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772178245;
	bh=7Nxw0eSNeEjIVxbS8tqkJXhH7vZE92ayhWGdRZaFasw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kibvgiyD8Qvj/PPszwdNEaE2mzVHl8iqPMyvQeKiUMVVPI8EAn8EID6Ef3dth4S6j
	 kTXznodVBqcVUfEKz896bjHkzwxSH5kJWJ3Pv8tA3j/TxOSmcTBBh/l4F0Z2Yo91Gz
	 jOUxba8AUgwYE/xuINvTr8qvvPbM0vqGKKouUq1ETF11/v1nKWU/h/WK03oGUADCLz
	 YLb/m4wMkC143LuW7AGvhURqiu2Msk0yKwa8veqH8oGWH56G7EkAKaABLL7ilmA6xL
	 kbYDNtu0qTEqJQfWYjq+tFZIwTS3FecWWcn8GVV8gtpU/AKpca4f6m6DVBm1iD0QWs
	 9NayNrNasCXjw==
Date: Fri, 27 Feb 2026 16:44:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, oe-kbuild-all@lists.linux.dev,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] ring-buffer: Flush and stop persistent ring
 buffer on panic
Message-Id: <20260227164402.31a1b987c3fba13d25439a92@kernel.org>
In-Reply-To: <202602270244.3JWhusi4-lkp@intel.com>
References: <177211311593.419230.2212568977306190482.stgit@mhiramat.tok.corp.google.com>
	<202602270244.3JWhusi4-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 02:48:26 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v7.0-rc1 next-20260226]
> [cannot apply to trace/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/ring-buffer-Flush-and-stop-persistent-ring-buffer-on-panic/20260226-222418
> base:   linus/master
> patch link:    https://lore.kernel.org/r/177211311593.419230.2212568977306190482.stgit%40mhiramat.tok.corp.google.com
> patch subject: [PATCH v5 1/3] ring-buffer: Flush and stop persistent ring buffer on panic
> config: sparc-randconfig-001-20260227 (https://download.01.org/0day-ci/archive/20260227/202602270244.3JWhusi4-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 11.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260227/202602270244.3JWhusi4-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602270244.3JWhusi4-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/trace/ring_buffer.c: In function 'rb_flush_buffer_cb':
> >> kernel/trace/ring_buffer.c:2481:9: error: implicit declaration of function 'flush_cache_all'; did you mean 'flush_cache_page'? [-Werror=implicit-function-declaration]
>     2481 |         flush_cache_all();
>          |         ^~~~~~~~~~~~~~~
>          |         flush_cache_page
>    cc1: some warnings being treated as errors

I guess this is a miss of the sparc. Anyway, I will add asm/ring_buffer.h
to define a wrapper macro. At least I need to sync the cache on arm64 but
flush_cache_all() is a dummy on arm64. I would like to use dcache_clear_pop()
instead.

Thanks,

> 
> 
> vim +2481 kernel/trace/ring_buffer.c
> 
>   2475	
>   2476	static int rb_flush_buffer_cb(struct notifier_block *nb, unsigned long event, void *data)
>   2477	{
>   2478		struct trace_buffer *buffer = container_of(nb, struct trace_buffer, flush_nb);
>   2479	
>   2480		ring_buffer_record_off(buffer);
> > 2481		flush_cache_all();
>   2482		return NOTIFY_DONE;
>   2483	}
>   2484	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
