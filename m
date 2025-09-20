Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D53B221FC6;
	Sat, 20 Sep 2025 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758359216; cv=none; b=jnL5r8/gf0TbpKWCgk5VPNbt89PWLD/y7uvZinleLWTLaGMVbyEkK/upmSn18mlqMKoAZ0wlHPVNuJlZQ/CVYFMKo8tmZS3FQ8CeLeNGyH9pv0mRP39HRHrjeI/jR20VMKvLshRCiwl35xlfD6Dergn7unLYG/XL6yCXDNmBRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758359216; c=relaxed/simple;
	bh=adOKBhDT5s5o8PdZzlj1YMH0SYwmlznoPvinIas8Cec=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IIsY5mLv421IRCgbj78wjc9wwaxaJ0aciXE9FPGuGN1PYrpSDBUy6S4wv7CJRdltkZ5PhRG7lztyumClfJINa2fiw/Om3cq8h45VpkOACfnsVtO4P9aGt4TaY5S27Ry2J0/AWvNPI1beOYb6y+5WwMNeryeS/GACoJAAe27ypzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddRoUQXO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddRoUQXO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FA8C4CEEB;
	Sat, 20 Sep 2025 09:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758359215;
	bh=adOKBhDT5s5o8PdZzlj1YMH0SYwmlznoPvinIas8Cec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ddRoUQXO3K7bdiMadtZUpOFC5/g4pkE5xPR3f1We76HOVkt2fBWsaaYeJ0m3KuVNx
	 HDTSS07QfBGWb3iwys+2zR8KBVGnXMz1Rq4AQrqRMN0unkVlMmSAp05hHsV7WhwVPf
	 oPpPHhxquMKj9ekM0nu6j2ThY+T9SNZol2IcDrWn5Jfysvsf8fNhXSZV6+eBTusNsf
	 PGInrDs0bftgG43yp9W6UXSnwGkZk0l4kxUzLcAUqJ4PpN0+D0qglpCaUtWBC3ACJi
	 mvzlSca2lVuXjx2cmisLaX5HIv81ZCimYTsD4EopPDaMSbq+OMkTYn2TVSWRZsuBcQ
	 /6G17KEclnI8g==
Date: Sat, 20 Sep 2025 18:06:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, oe-kbuild-all@lists.linux.dev,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Add an option to show symbols in _text+offset
 for function profiler
Message-Id: <20250920180651.fc561283df65b51a0c570793@kernel.org>
In-Reply-To: <202509200025.UH0WU2Qw-lkp@intel.com>
References: <175826135058.101165.7219957344129610147.stgit@devnote2>
	<202509200025.UH0WU2Qw-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Sep 2025 01:09:42 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on trace/for-next]
> [also build test ERROR on linus/master v6.17-rc6 next-20250918]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-Add-an-option-to-show-symbols-in-_text-offset-for-function-profiler/20250919-135733
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
> patch link:    https://lore.kernel.org/r/175826135058.101165.7219957344129610147.stgit%40devnote2
> patch subject: [PATCH] tracing: Add an option to show symbols in _text+offset for function profiler
> config: arc-randconfig-001-20250919 (https://download.01.org/0day-ci/archive/20250920/202509200025.UH0WU2Qw-lkp@intel.com/config)
> compiler: arc-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509200025.UH0WU2Qw-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509200025.UH0WU2Qw-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/trace/trace.c: In function 'create_trace_options_dir':
> >> kernel/trace/trace.c:526:16: error: 'TRACE_ITER_PROF_TEXT_OFFSET' undeclared (first use in this function); did you mean 'TRACE_ITER_CONTEXT_INFO'?
>      526 |                TRACE_ITER_PROF_TEXT_OFFSET)
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Aah, it should be defined always. OK, let me fix that in the next version.

Thanks!


>    kernel/trace/trace.c:9316:34: note: in expansion of macro 'TOP_LEVEL_TRACE_FLAGS'
>     9316 |                     !((1 << i) & TOP_LEVEL_TRACE_FLAGS))
>          |                                  ^~~~~~~~~~~~~~~~~~~~~
>    kernel/trace/trace.c:526:16: note: each undeclared identifier is reported only once for each function it appears in
>      526 |                TRACE_ITER_PROF_TEXT_OFFSET)
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/trace/trace.c:9316:34: note: in expansion of macro 'TOP_LEVEL_TRACE_FLAGS'
>     9316 |                     !((1 << i) & TOP_LEVEL_TRACE_FLAGS))
>          |                                  ^~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +526 kernel/trace/trace.c
> 
>    512	
>    513	/* trace_flags holds trace_options default values */
>    514	#define TRACE_DEFAULT_FLAGS						\
>    515		(FUNCTION_DEFAULT_FLAGS |					\
>    516		 TRACE_ITER_PRINT_PARENT | TRACE_ITER_PRINTK |			\
>    517		 TRACE_ITER_ANNOTATE | TRACE_ITER_CONTEXT_INFO |		\
>    518		 TRACE_ITER_RECORD_CMD | TRACE_ITER_OVERWRITE |			\
>    519		 TRACE_ITER_IRQ_INFO | TRACE_ITER_MARKERS |			\
>    520		 TRACE_ITER_HASH_PTR | TRACE_ITER_TRACE_PRINTK |		\
>    521		 TRACE_ITER_COPY_MARKER)
>    522	
>    523	/* trace_options that are only supported by global_trace */
>    524	#define TOP_LEVEL_TRACE_FLAGS (TRACE_ITER_PRINTK |			\
>    525		       TRACE_ITER_PRINTK_MSGONLY | TRACE_ITER_RECORD_CMD |	\
>  > 526		       TRACE_ITER_PROF_TEXT_OFFSET)
>    527	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
