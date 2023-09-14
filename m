Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F7CEEAA4F
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 14 Sep 2023 14:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjINOlt (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 10:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240099AbjINOlt (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:41:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62DC1BE1;
        Thu, 14 Sep 2023 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694702504; x=1726238504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P5DXsd0TMGfqFd+C6H6RKHDA4+v0/d2EZ1KKD3WiMpE=;
  b=Z6opXE7KNk8Oxw2el547uDIenWNZJI7JKpFmc2MOecoYGOnFnuq+yZ61
   aUxkRByAr+K3kXaIvcYCt3k1Fj5MJ22AMgkklfHcqh6WopEwlN85dPMkW
   epbPmLvYD0y6r9XrUlRXxRmZ51+W0Ko/7RE4M5KBNWakxe9rw8Isjukdl
   ymohJe2JDS4Ks/uE34uBw5wUQf3IUQeTHZuzXtfkbjSmzfTZ1+nLY2UH2
   Oj7E9xOAHAlnr0W15DMHWoiRaT6XdwuHNDKj3rT02PiB2utrCqmBPhvV0
   bROcvCk++Bp8ovnMmEnLWDwCkzeBCpbhIJXNz4VqoL0uN+Ablv3ccjm2F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="443015659"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="443015659"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 07:30:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="991408227"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="991408227"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 14 Sep 2023 07:30:08 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgnM5-0001gx-35;
        Thu, 14 Sep 2023 14:30:05 +0000
Date:   Thu, 14 Sep 2023 22:29:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: Re: [PATCH 1/8] trace: add new DECLARE_EVENT_CLASS_PRINT_INIT class
 type
Message-ID: <202309142216.GwM6Q6l0-lkp@intel.com>
References: <20230914100302.30274-2-quic_linyyuan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914100302.30274-2-quic_linyyuan@quicinc.com>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi Linyu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.6-rc1 next-20230914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Linyu-Yuan/trace-add-new-DECLARE_EVENT_CLASS_PRINT_INIT-class-type/20230914-180924
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230914100302.30274-2-quic_linyyuan%40quicinc.com
patch subject: [PATCH 1/8] trace: add new DECLARE_EVENT_CLASS_PRINT_INIT class type
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230914/202309142216.GwM6Q6l0-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309142216.GwM6Q6l0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309142216.GwM6Q6l0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/trace/events/migrate.h:8,
                    from mm/rmap.c:83:
>> include/linux/tracepoint.h:554: warning: "DECLARE_EVENT_CLASS_PRINT_INIT" redefined
     554 | #define DECLARE_EVENT_CLASS_PRINT_INIT(name, proto, args, tstruct, assign, print, init)
         | 
   In file included from include/trace/define_trace.h:103,
                    from include/trace/events/tlb.h:62,
                    from mm/rmap.c:82:
   include/trace/perf.h:59: note: this is the location of the previous definition
      59 | #define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init) \
         | 
>> include/linux/tracepoint.h:580: warning: "TRACE_EVENT_PRINT_INIT" redefined
     580 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, struct, assign, print, init)  \
         | 
   In file included from include/trace/define_trace.h:102:
   include/trace/trace_events.h:49: note: this is the location of the previous definition
      49 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, tstruct, assign, print, init) \
         | 
--
   In file included from include/trace/events/net.h:12,
                    from net/core/net-traces.c:31:
>> include/linux/tracepoint.h:554: warning: "DECLARE_EVENT_CLASS_PRINT_INIT" redefined
     554 | #define DECLARE_EVENT_CLASS_PRINT_INIT(name, proto, args, tstruct, assign, print, init)
         | 
   In file included from include/trace/define_trace.h:103,
                    from include/trace/events/skb.h:95,
                    from net/core/net-traces.c:30:
   include/trace/perf.h:59: note: this is the location of the previous definition
      59 | #define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init) \
         | 
>> include/linux/tracepoint.h:580: warning: "TRACE_EVENT_PRINT_INIT" redefined
     580 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, struct, assign, print, init)  \
         | 
   In file included from include/trace/define_trace.h:102:
   include/trace/trace_events.h:49: note: this is the location of the previous definition
      49 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, tstruct, assign, print, init) \
         | 
   In file included from include/trace/events/napi.h:9,
                    from net/core/net-traces.c:32:
>> include/linux/tracepoint.h:554: warning: "DECLARE_EVENT_CLASS_PRINT_INIT" redefined
     554 | #define DECLARE_EVENT_CLASS_PRINT_INIT(name, proto, args, tstruct, assign, print, init)
         | 
   In file included from include/trace/define_trace.h:103,
                    from include/trace/events/net.h:319:
   include/trace/perf.h:59: note: this is the location of the previous definition
      59 | #define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init) \
         | 
>> include/linux/tracepoint.h:580: warning: "TRACE_EVENT_PRINT_INIT" redefined
     580 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, struct, assign, print, init)  \
         | 
   In file included from include/trace/define_trace.h:102:
   include/trace/trace_events.h:49: note: this is the location of the previous definition
      49 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, tstruct, assign, print, init) \
         | 
   In file included from include/trace/events/sock.h:10,
                    from net/core/net-traces.c:33:
>> include/linux/tracepoint.h:554: warning: "DECLARE_EVENT_CLASS_PRINT_INIT" redefined
     554 | #define DECLARE_EVENT_CLASS_PRINT_INIT(name, proto, args, tstruct, assign, print, init)
         | 
   In file included from include/trace/define_trace.h:103,
                    from include/trace/events/napi.h:44:
   include/trace/perf.h:59: note: this is the location of the previous definition
      59 | #define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init) \
         | 
>> include/linux/tracepoint.h:580: warning: "TRACE_EVENT_PRINT_INIT" redefined
     580 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, struct, assign, print, init)  \
         | 
   In file included from include/trace/define_trace.h:102:
   include/trace/trace_events.h:49: note: this is the location of the previous definition
      49 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, tstruct, assign, print, init) \
         | 
   In file included from include/trace/events/udp.h:9,
                    from net/core/net-traces.c:34:
>> include/linux/tracepoint.h:554: warning: "DECLARE_EVENT_CLASS_PRINT_INIT" redefined
     554 | #define DECLARE_EVENT_CLASS_PRINT_INIT(name, proto, args, tstruct, assign, print, init)
         | 
   In file included from include/trace/define_trace.h:103,
                    from include/trace/events/sock.h:338:
   include/trace/perf.h:59: note: this is the location of the previous definition
      59 | #define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init) \
         | 
>> include/linux/tracepoint.h:580: warning: "TRACE_EVENT_PRINT_INIT" redefined
     580 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, struct, assign, print, init)  \
         | 
   In file included from include/trace/define_trace.h:102:
   include/trace/trace_events.h:49: note: this is the location of the previous definition
      49 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, tstruct, assign, print, init) \
         | 
   In file included from include/trace/events/tcp.h:10,
                    from net/core/net-traces.c:35:
>> include/linux/tracepoint.h:554: warning: "DECLARE_EVENT_CLASS_PRINT_INIT" redefined
     554 | #define DECLARE_EVENT_CLASS_PRINT_INIT(name, proto, args, tstruct, assign, print, init)
         | 
   In file included from include/trace/define_trace.h:103,
                    from include/trace/events/udp.h:33:
   include/trace/perf.h:59: note: this is the location of the previous definition
      59 | #define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init) \
         | 
>> include/linux/tracepoint.h:580: warning: "TRACE_EVENT_PRINT_INIT" redefined
     580 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, struct, assign, print, init)  \
         | 
   In file included from include/trace/define_trace.h:102:
   include/trace/trace_events.h:49: note: this is the location of the previous definition
      49 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, tstruct, assign, print, init) \
         | 
   In file included from include/trace/events/fib.h:11,
                    from net/core/net-traces.c:36:
>> include/linux/tracepoint.h:554: warning: "DECLARE_EVENT_CLASS_PRINT_INIT" redefined
     554 | #define DECLARE_EVENT_CLASS_PRINT_INIT(name, proto, args, tstruct, assign, print, init)
         | 
   In file included from include/trace/define_trace.h:103,
                    from include/trace/events/tcp.h:425:
   include/trace/perf.h:59: note: this is the location of the previous definition
      59 | #define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init) \
         | 
>> include/linux/tracepoint.h:580: warning: "TRACE_EVENT_PRINT_INIT" redefined
     580 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, struct, assign, print, init)  \
         | 
   In file included from include/trace/define_trace.h:102:
   include/trace/trace_events.h:49: note: this is the location of the previous definition
      49 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, tstruct, assign, print, init) \
         | 
   In file included from include/trace/events/qdisc.h:9,
                    from net/core/net-traces.c:37:
>> include/linux/tracepoint.h:554: warning: "DECLARE_EVENT_CLASS_PRINT_INIT" redefined
     554 | #define DECLARE_EVENT_CLASS_PRINT_INIT(name, proto, args, tstruct, assign, print, init)
         | 
   In file included from include/trace/define_trace.h:103,
                    from include/trace/events/fib.h:102:
   include/trace/perf.h:59: note: this is the location of the previous definition
      59 | #define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init) \
         | 
>> include/linux/tracepoint.h:580: warning: "TRACE_EVENT_PRINT_INIT" redefined
     580 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, struct, assign, print, init)  \
         | 
   In file included from include/trace/define_trace.h:102:
   include/trace/trace_events.h:49: note: this is the location of the previous definition
      49 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, tstruct, assign, print, init) \
         | 
   In file included from include/trace/events/page_pool.h:9,
                    from net/core/net-traces.c:48:
>> include/linux/tracepoint.h:554: warning: "DECLARE_EVENT_CLASS_PRINT_INIT" redefined
     554 | #define DECLARE_EVENT_CLASS_PRINT_INIT(name, proto, args, tstruct, assign, print, init)
         | 
   In file included from include/trace/define_trace.h:103,
                    from include/trace/events/qdisc.h:153:
   include/trace/perf.h:59: note: this is the location of the previous definition
      59 | #define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init) \
         | 
>> include/linux/tracepoint.h:580: warning: "TRACE_EVENT_PRINT_INIT" redefined
     580 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, struct, assign, print, init)  \
         | 
   In file included from include/trace/define_trace.h:102:
   include/trace/trace_events.h:49: note: this is the location of the previous definition
      49 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, tstruct, assign, print, init) \
         | 
   In file included from include/trace/events/neigh.h:9,
                    from net/core/net-traces.c:51:
>> include/linux/tracepoint.h:554: warning: "DECLARE_EVENT_CLASS_PRINT_INIT" redefined
     554 | #define DECLARE_EVENT_CLASS_PRINT_INIT(name, proto, args, tstruct, assign, print, init)
         | 
   In file included from include/trace/define_trace.h:103,
                    from include/trace/events/page_pool.h:117:
   include/trace/perf.h:59: note: this is the location of the previous definition
      59 | #define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init) \
         | 
>> include/linux/tracepoint.h:580: warning: "TRACE_EVENT_PRINT_INIT" redefined
     580 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, struct, assign, print, init)  \
         | 
   In file included from include/trace/define_trace.h:102:
   include/trace/trace_events.h:49: note: this is the location of the previous definition
      49 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, tstruct, assign, print, init) \
         | 
--
   In file included from include/trace/events/ipi.h:8,
                    from kernel/sched/core.c:83:
>> include/linux/tracepoint.h:554: warning: "DECLARE_EVENT_CLASS_PRINT_INIT" redefined
     554 | #define DECLARE_EVENT_CLASS_PRINT_INIT(name, proto, args, tstruct, assign, print, init)
         | 
   In file included from include/trace/define_trace.h:103,
                    from include/trace/events/sched.h:741,
                    from kernel/sched/core.c:82:
   include/trace/perf.h:59: note: this is the location of the previous definition
      59 | #define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init) \
         | 
>> include/linux/tracepoint.h:580: warning: "TRACE_EVENT_PRINT_INIT" redefined
     580 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, struct, assign, print, init)  \
         | 
   In file included from include/trace/define_trace.h:102:
   include/trace/trace_events.h:49: note: this is the location of the previous definition
      49 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, tstruct, assign, print, init) \
         | 
   In file included from include/trace/events/power.h:11,
                    from kernel/sched/sched.h:72,
                    from kernel/sched/core.c:86:
>> include/linux/tracepoint.h:554: warning: "DECLARE_EVENT_CLASS_PRINT_INIT" redefined
     554 | #define DECLARE_EVENT_CLASS_PRINT_INIT(name, proto, args, tstruct, assign, print, init)
         | 
   In file included from include/trace/define_trace.h:103,
                    from include/trace/events/ipi.h:134:
   include/trace/perf.h:59: note: this is the location of the previous definition
      59 | #define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init) \
         | 
>> include/linux/tracepoint.h:580: warning: "TRACE_EVENT_PRINT_INIT" redefined
     580 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, struct, assign, print, init)  \
         | 
   In file included from include/trace/define_trace.h:102:
   include/trace/trace_events.h:49: note: this is the location of the previous definition
      49 | #define TRACE_EVENT_PRINT_INIT(name, proto, args, tstruct, assign, print, init) \
         | 


vim +/DECLARE_EVENT_CLASS_PRINT_INIT +554 include/linux/tracepoint.h

   446	
   447	#ifndef TRACE_EVENT
   448	/*
   449	 * For use with the TRACE_EVENT macro:
   450	 *
   451	 * We define a tracepoint, its arguments, its printk format
   452	 * and its 'fast binary record' layout.
   453	 *
   454	 * Firstly, name your tracepoint via TRACE_EVENT(name : the
   455	 * 'subsystem_event' notation is fine.
   456	 *
   457	 * Think about this whole construct as the
   458	 * 'trace_sched_switch() function' from now on.
   459	 *
   460	 *
   461	 *  TRACE_EVENT(sched_switch,
   462	 *
   463	 *	*
   464	 *	* A function has a regular function arguments
   465	 *	* prototype, declare it via TP_PROTO():
   466	 *	*
   467	 *
   468	 *	TP_PROTO(struct rq *rq, struct task_struct *prev,
   469	 *		 struct task_struct *next),
   470	 *
   471	 *	*
   472	 *	* Define the call signature of the 'function'.
   473	 *	* (Design sidenote: we use this instead of a
   474	 *	*  TP_PROTO1/TP_PROTO2/TP_PROTO3 ugliness.)
   475	 *	*
   476	 *
   477	 *	TP_ARGS(rq, prev, next),
   478	 *
   479	 *	*
   480	 *	* Fast binary tracing: define the trace record via
   481	 *	* TP_STRUCT__entry(). You can think about it like a
   482	 *	* regular C structure local variable definition.
   483	 *	*
   484	 *	* This is how the trace record is structured and will
   485	 *	* be saved into the ring buffer. These are the fields
   486	 *	* that will be exposed to user-space in
   487	 *	* /sys/kernel/tracing/events/<*>/format.
   488	 *	*
   489	 *	* The declared 'local variable' is called '__entry'
   490	 *	*
   491	 *	* __field(pid_t, prev_pid) is equivalent to a standard declaration:
   492	 *	*
   493	 *	*	pid_t	prev_pid;
   494	 *	*
   495	 *	* __array(char, prev_comm, TASK_COMM_LEN) is equivalent to:
   496	 *	*
   497	 *	*	char	prev_comm[TASK_COMM_LEN];
   498	 *	*
   499	 *
   500	 *	TP_STRUCT__entry(
   501	 *		__array(	char,	prev_comm,	TASK_COMM_LEN	)
   502	 *		__field(	pid_t,	prev_pid			)
   503	 *		__field(	int,	prev_prio			)
   504	 *		__array(	char,	next_comm,	TASK_COMM_LEN	)
   505	 *		__field(	pid_t,	next_pid			)
   506	 *		__field(	int,	next_prio			)
   507	 *	),
   508	 *
   509	 *	*
   510	 *	* Assign the entry into the trace record, by embedding
   511	 *	* a full C statement block into TP_fast_assign(). You
   512	 *	* can refer to the trace record as '__entry' -
   513	 *	* otherwise you can put arbitrary C code in here.
   514	 *	*
   515	 *	* Note: this C code will execute every time a trace event
   516	 *	* happens, on an active tracepoint.
   517	 *	*
   518	 *
   519	 *	TP_fast_assign(
   520	 *		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
   521	 *		__entry->prev_pid	= prev->pid;
   522	 *		__entry->prev_prio	= prev->prio;
   523	 *		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
   524	 *		__entry->next_pid	= next->pid;
   525	 *		__entry->next_prio	= next->prio;
   526	 *	),
   527	 *
   528	 *	*
   529	 *	* Formatted output of a trace record via TP_printk().
   530	 *	* This is how the tracepoint will appear under ftrace
   531	 *	* plugins that make use of this tracepoint.
   532	 *	*
   533	 *	* (raw-binary tracing wont actually perform this step.)
   534	 *	*
   535	 *
   536	 *	TP_printk("task %s:%d [%d] ==> %s:%d [%d]",
   537	 *		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
   538	 *		__entry->next_comm, __entry->next_pid, __entry->next_prio),
   539	 *
   540	 * );
   541	 *
   542	 * This macro construct is thus used for the regular printk format
   543	 * tracing setup, it is used to construct a function pointer based
   544	 * tracepoint callback (this is used by programmatic plugins and
   545	 * can also by used by generic instrumentation like SystemTap), and
   546	 * it is also used to expose a structured trace record in
   547	 * /sys/kernel/tracing/events/.
   548	 *
   549	 * A set of (un)registration functions can be passed to the variant
   550	 * TRACE_EVENT_FN to perform any (un)registration work.
   551	 */
   552	
   553	#define DECLARE_EVENT_CLASS(name, proto, args, tstruct, assign, print)
 > 554	#define DECLARE_EVENT_CLASS_PRINT_INIT(name, proto, args, tstruct, assign, print, init)
   555	#define DEFINE_EVENT(template, name, proto, args)		\
   556		DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
   557	#define DEFINE_EVENT_FN(template, name, proto, args, reg, unreg)\
   558		DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
   559	#define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
   560		DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
   561	#define DEFINE_EVENT_CONDITION(template, name, proto,		\
   562				       args, cond)			\
   563		DECLARE_TRACE_CONDITION(name, PARAMS(proto),		\
   564					PARAMS(args), PARAMS(cond))
   565	
   566	#define TRACE_EVENT(name, proto, args, struct, assign, print)	\
   567		DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
   568	#define TRACE_EVENT_FN(name, proto, args, struct,		\
   569			assign, print, reg, unreg)			\
   570		DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
   571	#define TRACE_EVENT_FN_COND(name, proto, args, cond, struct,		\
   572			assign, print, reg, unreg)			\
   573		DECLARE_TRACE_CONDITION(name, PARAMS(proto),	\
   574				PARAMS(args), PARAMS(cond))
   575	#define TRACE_EVENT_CONDITION(name, proto, args, cond,		\
   576				      struct, assign, print)		\
   577		DECLARE_TRACE_CONDITION(name, PARAMS(proto),		\
   578					PARAMS(args), PARAMS(cond))
   579	
 > 580	#define TRACE_EVENT_PRINT_INIT(name, proto, args, struct, assign, print, init)	\
   581		DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
   582	#define TRACE_EVENT_FN_PRINT_INIT(name, proto, args, struct,		\
   583			assign, print, reg, unreg, init)			\
   584		DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
   585	#define TRACE_EVENT_FN_COND_PRINT_INIT(name, proto, args, cond, struct,		\
   586			assign, print, reg, unreg, init)			\
   587		DECLARE_TRACE_CONDITION(name, PARAMS(proto),	\
   588				PARAMS(args), PARAMS(cond))
   589	#define TRACE_EVENT_CONDITION_PRINT_INIT(name, proto, args, cond,		\
   590				      struct, assign, print, init)		\
   591		DECLARE_TRACE_CONDITION(name, PARAMS(proto),		\
   592					PARAMS(args), PARAMS(cond))
   593	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
