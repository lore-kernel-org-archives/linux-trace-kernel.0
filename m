Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7D33C507;
	Wed,  3 Jun 2026 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449664; cv=none; b=CZqv3Mnsbxx5GSOHSxlfgREhBDTIBTL5J89zUo9IneBZyz3+uCKkNo9Eh9rMXUXvabPijktCqskBEfz6uJVuYlU9tRobx2oG0FOAMCHAA6mbHDUah66VZUcJ0e4j9hdbWnGmXR7H9wjdDU6QJDYTHTAZhbni43gGlLs6qv3itYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449664; c=relaxed/simple;
	bh=8vixmOuT3LIAXcCvcIoXDTdEI3JVjvXuSoPkQqs0Xoc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Zj3wtr5PSbwuIog61F0CaojFdXXjxaZSuFFYVJ80v299Zt2ruHRg9Ek0N3L/qEQVOlRSkVDzptunqTlqDAZKIklEifyU7OPnmQodpIxSRzaWwehjhfzRLHxd7aHck2v9Nz8/WLU7hqzZsBPkNnIWQKSr7bMEYPpt3G43WFFcNug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euhkND3O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euhkND3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F461F00893;
	Wed,  3 Jun 2026 01:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780449660;
	bh=jaDw0gn3gT9HcVtufl402mihixaE+qh+yT/WCpNOLwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=euhkND3Ob1K0sLstL/rcWgvqDNMX5Z+eHl2P4tnIoDk1a9DR/mTiCGrY1u2/FLgsE
	 tsYtz6hEqg5sBj+DO7icxbHFQc4uaWKrcUVAF5vXbcSGXpc9+V24DirUKvUCMsBVte
	 Dm1MoGLrZH33pk5Tk7kR1wsv41hfNiWcgiSjdcViVwxWXd8NRd0RAfvMY+fCTwi1UG
	 MQGl1GB5qZtIdjDuBb0SqrauJXdOms1MlDYlVkBSFIB6EhO9NvC/mvZKn8U7D9oJy7
	 nfBjTv+35stutj+0nBqTFNJNPfyp0oW4NYB9CBiXQmUxRWT16Ug1Z0WCmRQRAiqr8x
	 Wo1d8VkyLDLrw==
Date: Wed, 3 Jun 2026 10:20:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Eva Kurchatova <eva.kurchatova@virtuozzo.com>, mhiramat@kernel.org,
 rostedt@goodmis.org, oe-kbuild-all@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, peterz@infradead.org, jpoimboe@kernel.org,
 samitolvanen@google.com
Subject: Re: [PATCH v2] tracing: fix CFI violation in probestub test
Message-Id: <20260603102055.182fb82e837842e059862096@kernel.org>
In-Reply-To: <202606022312.7cKiQBmg-lkp@intel.com>
References: <20260602135425.542073-1-eva.kurchatova@virtuozzo.com>
	<202606022312.7cKiQBmg-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 23:40:51 +0200
kernel test robot <lkp@intel.com> wrote:

> Hi Eva,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on trace/for-next]
> [also build test ERROR on linus/master v6.16-rc1 next-20260602]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Eva-Kurchatova/tracing-fix-CFI-violation-in-probestub-test/20260602-222302
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
> patch link:    https://lore.kernel.org/r/20260602135425.542073-1-eva.kurchatova%40virtuozzo.com
> patch subject: [PATCH v2] tracing: fix CFI violation in probestub test
> config: x86_64-rhel-9.4-kselftests (https://download.01.org/0day-ci/archive/20260602/202606022312.7cKiQBmg-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260602/202606022312.7cKiQBmg-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202606022312.7cKiQBmg-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/dma-buf/sync_trace.h:10,
>                     from drivers/dma-buf/sw_sync.c:18:
>    include/linux/tracepoint.h:403:9: warning: data definition has no type or storage class
>      403 |         CFI_NOSEAL(__probestub_##_name);                                \
>          |         ^~~~~~~~~~

Hmm, it seems that this macro is not defined in this build
configuration? Maybe we need:

#include <linux/cfi.h>

instead of asm/cfi.h?

Thanks,

>    include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
>      424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
>          |         ^~~~~~~~~~~~~~~~~~
>    include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
>       28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>          |         ^~~~~~~~~~~~
>    include/trace/../../drivers/dma-buf/sync_trace.h:12:1: note: in expansion of macro 'TRACE_EVENT'
>       12 | TRACE_EVENT(sync_timeline,
>          | ^~~~~~~~~~~
>    include/linux/tracepoint.h:403:9: error: type defaults to 'int' in declaration of 'CFI_NOSEAL' [-Wimplicit-int]
>      403 |         CFI_NOSEAL(__probestub_##_name);                                \
>          |         ^~~~~~~~~~
>    include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
>      424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
>          |         ^~~~~~~~~~~~~~~~~~
>    include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
>       28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>          |         ^~~~~~~~~~~~
>    include/trace/../../drivers/dma-buf/sync_trace.h:12:1: note: in expansion of macro 'TRACE_EVENT'
>       12 | TRACE_EVENT(sync_timeline,
>          | ^~~~~~~~~~~
> >> include/trace/../../drivers/dma-buf/sync_trace.h:13:25: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
>       13 |         TP_PROTO(struct sync_timeline *timeline),
>          |                         ^~~~~~~~~~~~~
>    include/linux/tracepoint.h:394:48: note: in definition of macro '__DEFINE_TRACE_EXT'
>      394 |         void __probestub_##_name(void *__data, proto)                   \
>          |                                                ^~~~~
>    include/linux/tracepoint.h:424:41: note: in expansion of macro 'PARAMS'
>      424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
>          |                                         ^~~~~~
>    include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
>       28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>          |         ^~~~~~~~~~~~
>    include/trace/define_trace.h:28:28: note: in expansion of macro 'PARAMS'
>       28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>          |                            ^~~~~~
>    include/trace/../../drivers/dma-buf/sync_trace.h:12:1: note: in expansion of macro 'TRACE_EVENT'
>       12 | TRACE_EVENT(sync_timeline,
>          | ^~~~~~~~~~~
>    include/trace/../../drivers/dma-buf/sync_trace.h:13:9: note: in expansion of macro 'TP_PROTO'
>       13 |         TP_PROTO(struct sync_timeline *timeline),
>          |         ^~~~~~~~
> --
>    In file included from include/trace/events/lock.h:9,
>                     from kernel/locking/mutex.c:35:
>    include/linux/tracepoint.h:403:9: warning: data definition has no type or storage class
>      403 |         CFI_NOSEAL(__probestub_##_name);                                \
>          |         ^~~~~~~~~~
>    include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
>      424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
>          |         ^~~~~~~~~~~~~~~~~~
>    include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
>       28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>          |         ^~~~~~~~~~~~
>    include/trace/events/lock.h:24:1: note: in expansion of macro 'TRACE_EVENT'
>       24 | TRACE_EVENT(lock_acquire,
>          | ^~~~~~~~~~~
>    include/linux/tracepoint.h:403:9: error: type defaults to 'int' in declaration of 'CFI_NOSEAL' [-Wimplicit-int]
>      403 |         CFI_NOSEAL(__probestub_##_name);                                \
>          |         ^~~~~~~~~~
>    include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
>      424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
>          |         ^~~~~~~~~~~~~~~~~~
>    include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
>       28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>          |         ^~~~~~~~~~~~
>    include/trace/events/lock.h:24:1: note: in expansion of macro 'TRACE_EVENT'
>       24 | TRACE_EVENT(lock_acquire,
>          | ^~~~~~~~~~~
> >> include/trace/events/lock.h:28:24: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
>       28 |                 struct lockdep_map *next_lock, unsigned long ip),
>          |                        ^~~~~~~~~~~
>    include/linux/tracepoint.h:394:48: note: in definition of macro '__DEFINE_TRACE_EXT'
>      394 |         void __probestub_##_name(void *__data, proto)                   \
>          |                                                ^~~~~
>    include/linux/tracepoint.h:424:41: note: in expansion of macro 'PARAMS'
>      424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
>          |                                         ^~~~~~
>    include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
>       28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>          |         ^~~~~~~~~~~~
>    include/trace/define_trace.h:28:28: note: in expansion of macro 'PARAMS'
>       28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>          |                            ^~~~~~
>    include/trace/events/lock.h:24:1: note: in expansion of macro 'TRACE_EVENT'
>       24 | TRACE_EVENT(lock_acquire,
>          | ^~~~~~~~~~~
>    include/trace/events/lock.h:26:9: note: in expansion of macro 'TP_PROTO'
>       26 |         TP_PROTO(struct lockdep_map *lock, unsigned int subclass,
>          |         ^~~~~~~~
>    include/linux/tracepoint.h:403:9: warning: data definition has no type or storage class
>      403 |         CFI_NOSEAL(__probestub_##_name);                                \
>          |         ^~~~~~~~~~
>    include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
>      424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
>          |         ^~~~~~~~~~~~~~~~~~
>    include/trace/define_trace.h:61:9: note: in expansion of macro 'DEFINE_TRACE'
>       61 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>          |         ^~~~~~~~~~~~
>    include/trace/events/lock.h:69:1: note: in expansion of macro 'DEFINE_EVENT'
>       69 | DEFINE_EVENT(lock, lock_release,
>          | ^~~~~~~~~~~~
>    include/linux/tracepoint.h:403:9: error: type defaults to 'int' in declaration of 'CFI_NOSEAL' [-Wimplicit-int]
>      403 |         CFI_NOSEAL(__probestub_##_name);                                \
>          |         ^~~~~~~~~~
>    include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
>      424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
>          |         ^~~~~~~~~~~~~~~~~~
>    include/trace/define_trace.h:61:9: note: in expansion of macro 'DEFINE_TRACE'
>       61 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>          |         ^~~~~~~~~~~~
>    include/trace/events/lock.h:69:1: note: in expansion of macro 'DEFINE_EVENT'
>       69 | DEFINE_EVENT(lock, lock_release,
>          | ^~~~~~~~~~~~
>    include/trace/events/lock.h:71:25: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
>       71 |         TP_PROTO(struct lockdep_map *lock, unsigned long ip),
>          |                         ^~~~~~~~~~~
>    include/linux/tracepoint.h:394:48: note: in definition of macro '__DEFINE_TRACE_EXT'
>      394 |         void __probestub_##_name(void *__data, proto)                   \
>          |                                                ^~~~~
>    include/linux/tracepoint.h:424:41: note: in expansion of macro 'PARAMS'
>      424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
>          |                                         ^~~~~~
>    include/trace/define_trace.h:61:9: note: in expansion of macro 'DEFINE_TRACE'
>       61 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>          |         ^~~~~~~~~~~~
>    include/trace/define_trace.h:61:28: note: in expansion of macro 'PARAMS'
>       61 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>          |                            ^~~~~~
>    include/trace/events/lock.h:69:1: note: in expansion of macro 'DEFINE_EVENT'
>       69 | DEFINE_EVENT(lock, lock_release,
>          | ^~~~~~~~~~~~
>    include/trace/events/lock.h:71:9: note: in expansion of macro 'TP_PROTO'
>       71 |         TP_PROTO(struct lockdep_map *lock, unsigned long ip),
>          |         ^~~~~~~~
>    include/linux/tracepoint.h:403:9: warning: data definition has no type or storage class
>      403 |         CFI_NOSEAL(__probestub_##_name);                                \
>          |         ^~~~~~~~~~
>    include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
>      424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
>          |         ^~~~~~~~~~~~~~~~~~
>    include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
>       28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>          |         ^~~~~~~~~~~~
>    include/trace/events/lock.h:95:1: note: in expansion of macro 'TRACE_EVENT'
>       95 | TRACE_EVENT(contention_begin,
>          | ^~~~~~~~~~~
>    include/linux/tracepoint.h:403:9: error: type defaults to 'int' in declaration of 'CFI_NOSEAL' [-Wimplicit-int]
>      403 |         CFI_NOSEAL(__probestub_##_name);                                \
>          |         ^~~~~~~~~~
>    include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
>      424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
>          |         ^~~~~~~~~~~~~~~~~~
>    include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
>       28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>          |         ^~~~~~~~~~~~
>    include/trace/events/lock.h:95:1: note: in expansion of macro 'TRACE_EVENT'
>       95 | TRACE_EVENT(contention_begin,
>          | ^~~~~~~~~~~
>    include/linux/tracepoint.h:380:24: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
>      380 |                 struct tracepoint_func *it_func_ptr;                    \
>          |                        ^~~~~~~~~~~~~~~
>    include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
>      424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
>          |         ^~~~~~~~~~~~~~~~~~
>    include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
>       28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>          |         ^~~~~~~~~~~~
>    include/trace/events/lock.h:95:1: note: in expansion of macro 'TRACE_EVENT'
>       95 | TRACE_EVENT(contention_begin,
> 
> 
> vim +13 include/trace/../../drivers/dma-buf/sync_trace.h
> 
> b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  11  
> b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  12  TRACE_EVENT(sync_timeline,
> b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28 @13  	TP_PROTO(struct sync_timeline *timeline),
> b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  14  
> b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  15  	TP_ARGS(timeline),
> b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  16  
> b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  17  	TP_STRUCT__entry(
> b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  18  			__string(name, timeline->name)
> 5c1401f83a16b7e drivers/staging/android/trace/sync.h Gustavo Padovan         2016-05-31  19  			__field(u32, value)
> b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  20  	),
> b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  21  
> b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  22  	TP_fast_assign(
> 2c92ca849fcc6ee drivers/dma-buf/sync_trace.h         Steven Rostedt (Google  2024-05-16  23) 			__assign_str(name);
> 5c1401f83a16b7e drivers/staging/android/trace/sync.h Gustavo Padovan         2016-05-31  24  			__entry->value = timeline->value;
> b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  25  	),
> b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  26  
> 5c1401f83a16b7e drivers/staging/android/trace/sync.h Gustavo Padovan         2016-05-31  27  	TP_printk("name=%s value=%d", __get_str(name), __entry->value)
> b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  28  );
> b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  29  
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
