Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A61684B4;
	Tue, 23 Sep 2025 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758594330; cv=none; b=tNjTaIza3MVfaYe61RVVcG53Z/RfSSbG3MeKCMxLJtp8XVdSA5wDPqbQ3N6v3XdDACQ8xDh+knSxw1M+72i1q5K5pU7iGxf2pRhop/1+HcmCsn7ctSI9b5j/MgpJJH4XiBB28fcZ+MTpDtLG0Sb+ot3OSfQ9ikJm0WVeKQjsWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758594330; c=relaxed/simple;
	bh=2VGnNnCAmL0teskFFxGlZCDUBIAb+tq/O9WCXCj+Ccg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FsYGEQ1PMqvIwHxm/gYkzn3T6gmFdXR+EcPFN6FlTpQndvhDE567nl14R2K6zw2KzO19kYdWvx+7vPuXa6Pe4eG0jhEU1srZn6jsJBbr5MLrZsf8n1CqDlQ3zx/VW6QuKzJo6CeeW2m14WS41jtm3LVd1/2z5ygCb2sqLK7VeFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtRx85jG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtRx85jG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC4CC4CEF0;
	Tue, 23 Sep 2025 02:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758594330;
	bh=2VGnNnCAmL0teskFFxGlZCDUBIAb+tq/O9WCXCj+Ccg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BtRx85jGYdUbto7LsCJgzsg5ER13N/LzybgaQd5gs5d9O/N0BZWNqgD5F+u9F7zKK
	 CXPZ7YKi7ICDP9NhOoxswaaLw9u4Jky/UjhSkm4nQu0aEg816Xe0tbUY/L8/wTMjGK
	 GduMdKpjwdNo002a/EySfRQOVraLf4rNuOGwQ6UQXrSLzD86cpvaLgr3o41qBnOuut
	 eHSVl8BxsXEuBezsZh+NrpDSi9YI7vWAkBp+AG1y2293mBNwrHPbF9S7L32Vx/P57z
	 4i2222i/bfE59MAIYh3zi4lu1gkAXY1a4CdROx/NNtiflvPaCkrk7Qas/evUB/m8+q
	 6zj48vxcqETnw==
Date: Tue, 23 Sep 2025 11:25:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, oe-kbuild-all@lists.linux.dev,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: Allow tracer to add more than 32
 options
Message-Id: <20250923112526.020cd0768e19558ced4d9f76@kernel.org>
In-Reply-To: <202509230952.UvKzcDdq-lkp@intel.com>
References: <175854517136.353182.4018685864707176851.stgit@devnote2>
	<202509230952.UvKzcDdq-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 09:47:13 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on trace/for-next]
> [also build test WARNING on linus/master v6.17-rc7 next-20250922]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-Allow-tracer-to-add-more-than-32-options/20250922-204945
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
> patch link:    https://lore.kernel.org/r/175854517136.353182.4018685864707176851.stgit%40devnote2
> patch subject: [PATCH v2 1/2] tracing: Allow tracer to add more than 32 options
> config: sh-randconfig-001-20250923 (https://download.01.org/0day-ci/archive/20250923/202509230952.UvKzcDdq-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250923/202509230952.UvKzcDdq-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509230952.UvKzcDdq-lkp@intel.com/
> 

Hmm, even if it is 'static const', if it is not used, we will get warning.

Maybe 

#undef C(a, b)
#define C(a, b) TRACE_ITER_##a |
static const u64 trace_flags_defined =
	TRACE_FLAGS 0;

And use this mask in the set_tracer_flag() to check given
bit mask is correct.

Thank you,

> All warnings (new ones prefixed by >>):
> 
>    In file included from kernel/trace/fgraph.c:20:
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_STACKTRACE' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1351:17: note: in expansion of macro 'C'
>     1351 |                 C(STACKTRACE,           "stacktrace")
>          |                 ^
>    kernel/trace/trace.h:1393:17: note: in expansion of macro 'STACK_FLAGS'
>     1393 |                 STACK_FLAGS                                     \
>          |                 ^~~~~~~~~~~
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
> >> kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_DISPLAY_GRAPH' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1326:17: note: in expansion of macro 'C'
>     1326 |                 C(DISPLAY_GRAPH,        "display-graph")
>          |                 ^
>    kernel/trace/trace.h:1392:17: note: in expansion of macro 'FGRAPH_FLAGS'
>     1392 |                 FGRAPH_FLAGS                                    \
>          |                 ^~~~~~~~~~~~
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_FUNC_FORK' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1341:17: note: in expansion of macro 'C'
>     1341 |                 C(FUNC_FORK,            "function-fork")
>          |                 ^
>    kernel/trace/trace.h:1391:17: note: in expansion of macro 'FUNCTION_FLAGS'
>     1391 |                 FUNCTION_FLAGS                                  \
>          |                 ^~~~~~~~~~~~~~
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_FUNCTION' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1340:17: note: in expansion of macro 'C'
>     1340 |                 C(FUNCTION,             "function-trace")       \
>          |                 ^
>    kernel/trace/trace.h:1391:17: note: in expansion of macro 'FUNCTION_FLAGS'
>     1391 |                 FUNCTION_FLAGS                                  \
>          |                 ^~~~~~~~~~~~~~
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_HASH_PTR' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1390:17: note: in expansion of macro 'C'
>     1390 |                 C(HASH_PTR,             "hash-ptr")     /* Print hashed pointer */ \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_PAUSE_ON_TRACE' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1389:17: note: in expansion of macro 'C'
>     1389 |                 C(PAUSE_ON_TRACE,       "pause-on-trace")       \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_COPY_MARKER' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1388:17: note: in expansion of macro 'C'
>     1388 |                 C(COPY_MARKER,          "copy_trace_marker")\
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_TRACE_PRINTK' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1387:17: note: in expansion of macro 'C'
>     1387 |                 C(TRACE_PRINTK,         "trace_printk_dest")    \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_EVENT_FORK' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1386:17: note: in expansion of macro 'C'
>     1386 |                 C(EVENT_FORK,           "event-fork")           \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_MARKERS' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1385:17: note: in expansion of macro 'C'
>     1385 |                 C(MARKERS,              "markers")              \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_IRQ_INFO' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1384:17: note: in expansion of macro 'C'
>     1384 |                 C(IRQ_INFO,             "irq-info")             \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_STOP_ON_FREE' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
> --
>    In file included from kernel/trace/trace.c:58:
> >> kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_DISPLAY_GRAPH' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1326:17: note: in expansion of macro 'C'
>     1326 |                 C(DISPLAY_GRAPH,        "display-graph")
>          |                 ^
>    kernel/trace/trace.h:1392:17: note: in expansion of macro 'FGRAPH_FLAGS'
>     1392 |                 FGRAPH_FLAGS                                    \
>          |                 ^~~~~~~~~~~~
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_USERSTACKTRACE' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1375:17: note: in expansion of macro 'C'
>     1375 |                 C(USERSTACKTRACE,       "userstacktrace")       \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    {standard input}: Assembler messages:
>    {standard input}:6792: Error: offset to unaligned destination
>    {standard input}:24045: Error: offset to unaligned destination
>    {standard input}:24422: Error: offset to unaligned destination
>    {standard input}:32500: Error: offset to unaligned destination
> --
>    In file included from kernel/trace/trace_output.h:6,
>                     from kernel/trace/trace_events.c:31:
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_STACKTRACE' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1351:17: note: in expansion of macro 'C'
>     1351 |                 C(STACKTRACE,           "stacktrace")
>          |                 ^
>    kernel/trace/trace.h:1393:17: note: in expansion of macro 'STACK_FLAGS'
>     1393 |                 STACK_FLAGS                                     \
>          |                 ^~~~~~~~~~~
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
> >> kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_DISPLAY_GRAPH' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1326:17: note: in expansion of macro 'C'
>     1326 |                 C(DISPLAY_GRAPH,        "display-graph")
>          |                 ^
>    kernel/trace/trace.h:1392:17: note: in expansion of macro 'FGRAPH_FLAGS'
>     1392 |                 FGRAPH_FLAGS                                    \
>          |                 ^~~~~~~~~~~~
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_FUNC_FORK' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1341:17: note: in expansion of macro 'C'
>     1341 |                 C(FUNC_FORK,            "function-fork")
>          |                 ^
>    kernel/trace/trace.h:1391:17: note: in expansion of macro 'FUNCTION_FLAGS'
>     1391 |                 FUNCTION_FLAGS                                  \
>          |                 ^~~~~~~~~~~~~~
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_FUNCTION' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1340:17: note: in expansion of macro 'C'
>     1340 |                 C(FUNCTION,             "function-trace")       \
>          |                 ^
>    kernel/trace/trace.h:1391:17: note: in expansion of macro 'FUNCTION_FLAGS'
>     1391 |                 FUNCTION_FLAGS                                  \
>          |                 ^~~~~~~~~~~~~~
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_HASH_PTR' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1390:17: note: in expansion of macro 'C'
>     1390 |                 C(HASH_PTR,             "hash-ptr")     /* Print hashed pointer */ \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_PAUSE_ON_TRACE' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1389:17: note: in expansion of macro 'C'
>     1389 |                 C(PAUSE_ON_TRACE,       "pause-on-trace")       \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_COPY_MARKER' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1388:17: note: in expansion of macro 'C'
>     1388 |                 C(COPY_MARKER,          "copy_trace_marker")\
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_TRACE_PRINTK' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1387:17: note: in expansion of macro 'C'
>     1387 |                 C(TRACE_PRINTK,         "trace_printk_dest")    \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_EVENT_FORK' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1386:17: note: in expansion of macro 'C'
>     1386 |                 C(EVENT_FORK,           "event-fork")           \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_MARKERS' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1385:17: note: in expansion of macro 'C'
>     1385 |                 C(MARKERS,              "markers")              \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_IRQ_INFO' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1384:17: note: in expansion of macro 'C'
>     1384 |                 C(IRQ_INFO,             "irq-info")             \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_STOP_ON_FREE' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
> --
>    In file included from kernel/trace/ring_buffer.c:36:
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_STACKTRACE' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1351:17: note: in expansion of macro 'C'
>     1351 |                 C(STACKTRACE,           "stacktrace")
>          |                 ^
>    kernel/trace/trace.h:1393:17: note: in expansion of macro 'STACK_FLAGS'
>     1393 |                 STACK_FLAGS                                     \
>          |                 ^~~~~~~~~~~
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
> >> kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_DISPLAY_GRAPH' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1326:17: note: in expansion of macro 'C'
>     1326 |                 C(DISPLAY_GRAPH,        "display-graph")
>          |                 ^
>    kernel/trace/trace.h:1392:17: note: in expansion of macro 'FGRAPH_FLAGS'
>     1392 |                 FGRAPH_FLAGS                                    \
>          |                 ^~~~~~~~~~~~
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_FUNC_FORK' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1341:17: note: in expansion of macro 'C'
>     1341 |                 C(FUNC_FORK,            "function-fork")
>          |                 ^
>    kernel/trace/trace.h:1391:17: note: in expansion of macro 'FUNCTION_FLAGS'
>     1391 |                 FUNCTION_FLAGS                                  \
>          |                 ^~~~~~~~~~~~~~
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_FUNCTION' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1340:17: note: in expansion of macro 'C'
>     1340 |                 C(FUNCTION,             "function-trace")       \
>          |                 ^
>    kernel/trace/trace.h:1391:17: note: in expansion of macro 'FUNCTION_FLAGS'
>     1391 |                 FUNCTION_FLAGS                                  \
>          |                 ^~~~~~~~~~~~~~
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_HASH_PTR' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1390:17: note: in expansion of macro 'C'
>     1390 |                 C(HASH_PTR,             "hash-ptr")     /* Print hashed pointer */ \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_PAUSE_ON_TRACE' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1389:17: note: in expansion of macro 'C'
>     1389 |                 C(PAUSE_ON_TRACE,       "pause-on-trace")       \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_COPY_MARKER' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1388:17: note: in expansion of macro 'C'
>     1388 |                 C(COPY_MARKER,          "copy_trace_marker")\
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_TRACE_PRINTK' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1387:17: note: in expansion of macro 'C'
>     1387 |                 C(TRACE_PRINTK,         "trace_printk_dest")    \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_EVENT_FORK' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1386:17: note: in expansion of macro 'C'
>     1386 |                 C(EVENT_FORK,           "event-fork")           \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_MARKERS' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1385:17: note: in expansion of macro 'C'
>     1385 |                 C(MARKERS,              "markers")              \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_IRQ_INFO' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>          |                                  ^~~~~~~~~~~
>    kernel/trace/trace.h:1384:17: note: in expansion of macro 'C'
>     1384 |                 C(IRQ_INFO,             "irq-info")             \
>          |                 ^
>    kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
>     1416 | TRACE_FLAGS
>          | ^~~~~~~~~~~
>    kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_STOP_ON_FREE' defined but not used [-Wunused-const-variable=]
>     1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
> ..
> 
> 
> vim +/TRACE_ITER_DISPLAY_GRAPH +1414 kernel/trace/trace.h
> 
>   1348	
>   1349	#ifdef CONFIG_STACKTRACE
>   1350	# define STACK_FLAGS				\
> > 1351			C(STACKTRACE,		"stacktrace")
>   1352	#else
>   1353	# define STACK_FLAGS
>   1354	#endif
>   1355	
>   1356	/*
>   1357	 * trace_iterator_flags is an enumeration that defines bit
>   1358	 * positions into trace_flags that controls the output.
>   1359	 *
>   1360	 * NOTE: These bits must match the trace_options array in
>   1361	 *       trace.c (this macro guarantees it).
>   1362	 */
>   1363	#define TRACE_FLAGS						\
>   1364			C(PRINT_PARENT,		"print-parent")		\
>   1365			C(SYM_OFFSET,		"sym-offset")		\
>   1366			C(SYM_ADDR,		"sym-addr")		\
>   1367			C(VERBOSE,		"verbose")		\
>   1368			C(RAW,			"raw")			\
>   1369			C(HEX,			"hex")			\
>   1370			C(BIN,			"bin")			\
>   1371			C(BLOCK,		"block")		\
>   1372			C(FIELDS,		"fields")		\
>   1373			C(PRINTK,		"trace_printk")	\
>   1374			C(ANNOTATE,		"annotate")		\
>   1375			C(USERSTACKTRACE,	"userstacktrace")	\
>   1376			C(SYM_USEROBJ,		"sym-userobj")		\
>   1377			C(PRINTK_MSGONLY,	"printk-msg-only")	\
>   1378			C(CONTEXT_INFO,		"context-info")   /* Print pid/cpu/time */ \
>   1379			C(LATENCY_FMT,		"latency-format")	\
>   1380			C(RECORD_CMD,		"record-cmd")		\
>   1381			C(RECORD_TGID,		"record-tgid")		\
>   1382			C(OVERWRITE,		"overwrite")		\
>   1383			C(STOP_ON_FREE,		"disable_on_free")	\
>   1384			C(IRQ_INFO,		"irq-info")		\
>   1385			C(MARKERS,		"markers")		\
>   1386			C(EVENT_FORK,		"event-fork")		\
>   1387			C(TRACE_PRINTK,		"trace_printk_dest")	\
>   1388			C(COPY_MARKER,		"copy_trace_marker")\
>   1389			C(PAUSE_ON_TRACE,	"pause-on-trace")	\
>   1390			C(HASH_PTR,		"hash-ptr")	/* Print hashed pointer */ \
>   1391			FUNCTION_FLAGS					\
>   1392			FGRAPH_FLAGS					\
>   1393			STACK_FLAGS					\
>   1394			BRANCH_FLAGS
>   1395	
>   1396	/*
>   1397	 * By defining C, we can make TRACE_FLAGS a list of bit names
>   1398	 * that will define the bits for the flag masks.
>   1399	 */
>   1400	#undef C
>   1401	#define C(a, b) TRACE_ITER_##a##_BIT,
>   1402	
>   1403	enum trace_iterator_bits {
>   1404		TRACE_FLAGS
>   1405		/* Make sure we don't go more than we have bits for */
>   1406		TRACE_ITER_LAST_BIT
>   1407	};
>   1408	
>   1409	/*
>   1410	 * By redefining C, we can make TRACE_FLAGS a list of masks that
>   1411	 * use the bits as defined above.
>   1412	 */
>   1413	#undef C
> > 1414	#define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
>   1415	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
