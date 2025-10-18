Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5586A7263B;
	Sat, 18 Oct 2025 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807974; cv=none; b=jWqlgF9Z18UxmdphJKkeR+sjITEqHrpradp61zBXnOtrCkJEaRhduEQmx66zBbGSAc3mXiRtk3pMpBDA+o8vNAcav0YQBHPFIODJywcE7/XOxTE4ESxcg2wm9TLxuOKACezA+yeuqTDHpiE3feVnWDvabmiJQTb7pydIl1qRAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807974; c=relaxed/simple;
	bh=44ggbXI4Wg0CVRZ/kNQUDDaRKrHxyjz8crS0k6G7ULI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2T++czWGO8f4z5ADUhK2rTdlVXWL2UuxD6QmsJaLnhYeO7rjRH2igAbTGI7k8bsFczDD5NRcyw48GD2E1yBDMMTkMiveipwQ1euUTQgXO398FYsZFdsUPbTl+/Ftgg3gpGqPue7G/sx+Y+M5OY7rNewUxHyrFx/zsRM1r/MB6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQmrFy9I; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQmrFy9I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760807972; x=1792343972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=44ggbXI4Wg0CVRZ/kNQUDDaRKrHxyjz8crS0k6G7ULI=;
  b=bQmrFy9IZx+jit14m2FRMhyovKFVqQoV9lsxjATcjt7t8C7bJzUGyCyb
   sjDUuE3skKz/MLJOE3seI9L7C/XnKAUhL3Kvaprc8PXt4wfrT4Y7PeTgI
   RPfUQRd4QChc4PDdbMLmr5E1e+kYeYZXA0o60HeKiUHypjpUXXDkZbMYT
   t617yIMtx7grbOmcgLfJOEfvJ4xZtrkkE3E7gkdKkv/UgiVXw1wHajeSK
   Ox0lTwT5Yn/25OTxcpBvzRi/1XntPnkOVBIgOueeW7N6kSzEKmyxDp1ff
   C8tJ0JVC2vZ+3IuVatPHNoy69xQTYN2y+536r0EqfVKmzcsfP18JjwHPH
   A==;
X-CSE-ConnectionGUID: EImCxL+uQuCNVRLD7ZgJCg==
X-CSE-MsgGUID: o4udFhYBSgCl6PzAf+QchA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73277438"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="73277438"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:19:31 -0700
X-CSE-ConnectionGUID: dXXE3skNRtmY5S01UkibGw==
X-CSE-MsgGUID: lnZhR/dwRDiXmAGX9Hup6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="182804630"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 18 Oct 2025 10:19:30 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAAaV-0008Rz-1R;
	Sat, 18 Oct 2025 17:19:27 +0000
Date: Sun, 19 Oct 2025 01:19:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tracing: Allow tracer to add more than 32 options
Message-ID: <202510190117.rUh1e4k6-lkp@intel.com>
References: <176071774097.175601.10233017390618260565.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176071774097.175601.10233017390618260565.stgit@devnote2>

Hi Masami,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v6.18-rc1 next-20251017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-Allow-tracer-to-add-more-than-32-options/20251018-004104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/176071774097.175601.10233017390618260565.stgit%40devnote2
patch subject: [PATCH v4 1/2] tracing: Allow tracer to add more than 32 options
config: arm-randconfig-r112-20251018 (https://download.01.org/0day-ci/archive/20251019/202510190117.rUh1e4k6-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 754ebc6ebb9fb9fbee7aef33478c74ea74949853)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251019/202510190117.rUh1e4k6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510190117.rUh1e4k6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/ftrace.c: note: in included file (through kernel/trace/trace_output.h):
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
   kernel/trace/ftrace.c:1501:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/ftrace.c:1501:9: sparse:    struct ftrace_hash [noderef] __rcu *
   kernel/trace/ftrace.c:1501:9: sparse:    struct ftrace_hash *
   kernel/trace/ftrace.c:7839:36: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/ftrace.c:7839:36: sparse:    struct ftrace_ops [noderef] __rcu *
   kernel/trace/ftrace.c:7839:36: sparse:    struct ftrace_ops *
--
   kernel/trace/trace_functions.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/trace_printk.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/trace_preemptirq.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/trace_stat.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/pid_list.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/trace_stack.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/trace_output.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
   kernel/trace/trace_output.c:423:34: sparse: sparse: undefined identifier 'TRACE_ITER_SYM_ADDR'
   kernel/trace/trace_output.c:436:48: sparse: sparse: undefined identifier 'TRACE_ITER_SYM_OFFSET'
   kernel/trace/trace_output.c:438:25: sparse: sparse: undefined identifier 'TRACE_ITER_SYM_ADDR'
   kernel/trace/trace_output.c:572:51: sparse: sparse: undefined identifier 'TRACE_ITER_VERBOSE'
   kernel/trace/trace_output.c:639:31: sparse: sparse: undefined identifier 'TRACE_ITER_RECORD_TGID'
   kernel/trace/trace_output.c:650:31: sparse: sparse: undefined identifier 'TRACE_ITER_IRQ_INFO'
   kernel/trace/trace_output.c:664:52: sparse: sparse: undefined identifier 'TRACE_ITER_VERBOSE'
   kernel/trace/trace_output.c:1130:22: sparse: sparse: undefined identifier 'TRACE_ITER_PRINT_PARENT'
   kernel/trace/trace_output.c:1420:31: sparse: sparse: undefined identifier 'TRACE_ITER_SYM_USEROBJ'
--
   kernel/trace/trace_nop.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/trace_irqsoff.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
   kernel/trace/trace_irqsoff.c:492:62: sparse: sparse: undefined identifier 'TRACE_ITER_FUNCTION'
   kernel/trace/trace_irqsoff.c:521:22: sparse: sparse: undefined identifier 'TRACE_ITER_FUNCTION'
   kernel/trace/trace_irqsoff.c:588:29: sparse: sparse: undefined identifier 'TRACE_ITER_OVERWRITE'
   kernel/trace/trace_irqsoff.c:589:29: sparse: sparse: undefined identifier 'TRACE_ITER_LATENCY_FMT'
   kernel/trace/trace_irqsoff.c:591:29: sparse: sparse: undefined identifier 'TRACE_ITER_PAUSE_ON_TRACE'
   kernel/trace/trace_irqsoff.c:611:37: sparse: sparse: undefined identifier 'TRACE_ITER_LATENCY_FMT'
   kernel/trace/trace_irqsoff.c:612:43: sparse: sparse: undefined identifier 'TRACE_ITER_OVERWRITE'
   kernel/trace/trace_irqsoff.c:613:39: sparse: sparse: undefined identifier 'TRACE_ITER_PAUSE_ON_TRACE'
   kernel/trace/trace_irqsoff.c:617:29: sparse: sparse: undefined identifier 'TRACE_ITER_LATENCY_FMT'
   kernel/trace/trace_irqsoff.c:618:29: sparse: sparse: undefined identifier 'TRACE_ITER_OVERWRITE'
   kernel/trace/trace_irqsoff.c:619:29: sparse: sparse: undefined identifier 'TRACE_ITER_PAUSE_ON_TRACE'
--
   kernel/trace/trace_sched_switch.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/trace_branch.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/trace_export.c: note: in included file (through kernel/trace/trace_output.h):
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/trace_dynevent.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/ring_buffer.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/trace_boot.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/blktrace.c: note: in included file (through kernel/trace/trace_output.h):
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
   kernel/trace/blktrace.c:1455:43: sparse: sparse: undefined identifier 'TRACE_ITER_VERBOSE'
   kernel/trace/blktrace.c:1520:45: sparse: sparse: undefined identifier 'TRACE_ITER_CONTEXT_INFO'
   kernel/trace/blktrace.c:1522:44: sparse: sparse: undefined identifier 'TRACE_ITER_CONTEXT_INFO'
--
   kernel/trace/trace_kdb.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
   kernel/trace/trace_kdb.c:34:29: sparse: sparse: undefined identifier 'TRACE_ITER_SYM_USEROBJ'
--
   kernel/trace/trace_kprobe.c: note: in included file (through kernel/trace/trace_dynevent.h):
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
   kernel/trace/trace_kprobe.c:1587:53: sparse: sparse: undefined identifier 'TRACE_ITER_SYM_OFFSET'
   kernel/trace/trace_kprobe.c:1617:57: sparse: sparse: undefined identifier 'TRACE_ITER_SYM_OFFSET'
   kernel/trace/trace_kprobe.c:1622:56: sparse: sparse: undefined identifier 'TRACE_ITER_SYM_OFFSET'
--
   kernel/trace/trace_events_trigger.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/trace_osnoise.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/trace_probe.c: note: in included file (through kernel/trace/trace_probe.h):
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/trace_events_filter.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
--
   kernel/trace/trace_events.c: note: in included file (through kernel/trace/trace_output.h):
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
   kernel/trace/trace_events.c:848:47: sparse: sparse: undefined identifier 'TRACE_ITER_RECORD_CMD'
   kernel/trace/trace_events.c:854:47: sparse: sparse: undefined identifier 'TRACE_ITER_RECORD_TGID'
--
   kernel/trace/trace.c: note: in included file:
>> kernel/trace/trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/trace.h:1427:27: sparse: sparse: got :
   kernel/trace/trace.c:537:24: sparse: sparse: undefined identifier 'TRACE_ITER_FUNCTION'
   kernel/trace/trace.c:537:24: sparse: sparse: undefined identifier 'TRACE_ITER_PRINT_PARENT'
   kernel/trace/trace.c:537:24: sparse: sparse: undefined identifier 'TRACE_ITER_PRINTK'
   kernel/trace/trace.c:537:24: sparse: sparse: undefined identifier 'TRACE_ITER_ANNOTATE'
   kernel/trace/trace.c:537:24: sparse: sparse: undefined identifier 'TRACE_ITER_CONTEXT_INFO'
   kernel/trace/trace.c:537:24: sparse: sparse: undefined identifier 'TRACE_ITER_RECORD_CMD'
   kernel/trace/trace.c:537:24: sparse: sparse: undefined identifier 'TRACE_ITER_OVERWRITE'
   kernel/trace/trace.c:537:24: sparse: sparse: undefined identifier 'TRACE_ITER_IRQ_INFO'
   kernel/trace/trace.c:537:24: sparse: sparse: undefined identifier 'TRACE_ITER_MARKERS'
   kernel/trace/trace.c:537:24: sparse: sparse: undefined identifier 'TRACE_ITER_HASH_PTR'
   kernel/trace/trace.c:537:24: sparse: sparse: undefined identifier 'TRACE_ITER_TRACE_PRINTK'
   kernel/trace/trace.c:537:24: sparse: sparse: undefined identifier 'TRACE_ITER_COPY_MARKER'
   kernel/trace/trace.c:561:39: sparse: sparse: undefined identifier 'TRACE_ITER_TRACE_PRINTK'
   kernel/trace/trace.c:563:28: sparse: sparse: undefined identifier 'TRACE_ITER_TRACE_PRINTK'
   kernel/trace/trace.c:576:36: sparse: sparse: undefined identifier 'TRACE_ITER_COPY_MARKER'
   kernel/trace/trace.c:584:29: sparse: sparse: undefined identifier 'TRACE_ITER_COPY_MARKER'
   kernel/trace/trace.c:1142:33: sparse: sparse: undefined identifier 'TRACE_ITER_PRINTK'
   kernel/trace/trace.c:1208:33: sparse: sparse: undefined identifier 'TRACE_ITER_PRINTK'
   kernel/trace/trace.c:3487:33: sparse: sparse: undefined identifier 'TRACE_ITER_PRINTK'
   kernel/trace/trace.c:3524:43: sparse: sparse: undefined identifier 'TRACE_ITER_PRINTK'
   kernel/trace/trace.c:3794:50: sparse: sparse: undefined identifier 'TRACE_ITER_HASH_PTR'
   kernel/trace/trace.c:4116:29: sparse: sparse: undefined identifier 'TRACE_ITER_RECORD_TGID'
   kernel/trace/trace.c:4127:29: sparse: sparse: undefined identifier 'TRACE_ITER_RECORD_TGID'
   kernel/trace/trace.c:4146:63: sparse: sparse: undefined identifier 'TRACE_ITER_PRINT_PARENT'
   kernel/trace/trace.c:4146:63: sparse: sparse: undefined identifier 'TRACE_ITER_SYM_OFFSET'
   kernel/trace/trace.c:4146:63: sparse: sparse: undefined identifier 'TRACE_ITER_SYM_ADDR'
   kernel/trace/trace.c:4200:33: sparse: sparse: undefined identifier 'TRACE_ITER_ANNOTATE'
   kernel/trace/trace.c:4226:54: sparse: sparse: undefined identifier 'TRACE_ITER_PRINT_PARENT'
   kernel/trace/trace.c:4226:54: sparse: sparse: undefined identifier 'TRACE_ITER_SYM_OFFSET'
   kernel/trace/trace.c:4226:54: sparse: sparse: undefined identifier 'TRACE_ITER_SYM_ADDR'
   kernel/trace/trace.c:4236:31: sparse: sparse: undefined identifier 'TRACE_ITER_CONTEXT_INFO'
   kernel/trace/trace.c:4247:39: sparse: sparse: undefined identifier 'TRACE_ITER_FIELDS'
   kernel/trace/trace.c:4275:31: sparse: sparse: undefined identifier 'TRACE_ITER_CONTEXT_INFO'
   kernel/trace/trace.c:4301:31: sparse: sparse: undefined identifier 'TRACE_ITER_CONTEXT_INFO'
   kernel/trace/trace.c:4330:31: sparse: sparse: undefined identifier 'TRACE_ITER_CONTEXT_INFO'
   kernel/trace/trace.c:4401:39: sparse: sparse: undefined identifier 'TRACE_ITER_PRINTK'
   kernel/trace/trace.c:4406:39: sparse: sparse: undefined identifier 'TRACE_ITER_PRINTK'
   kernel/trace/trace.c:4411:39: sparse: sparse: undefined identifier 'TRACE_ITER_PRINTK'
   kernel/trace/trace.c:4415:27: sparse: sparse: undefined identifier 'TRACE_ITER_BIN'
   kernel/trace/trace.c:4418:27: sparse: sparse: undefined identifier 'TRACE_ITER_HEX'
   kernel/trace/trace.c:4421:27: sparse: sparse: undefined identifier 'TRACE_ITER_RAW'
   kernel/trace/trace.c:4439:33: sparse: sparse: undefined identifier 'TRACE_ITER_VERBOSE'
   kernel/trace/trace.c:4449:29: sparse: sparse: undefined identifier 'TRACE_ITER_CONTEXT_INFO'
   kernel/trace/trace.c:4457:37: sparse: sparse: undefined identifier 'TRACE_ITER_VERBOSE'
   kernel/trace/trace.c:4460:37: sparse: sparse: undefined identifier 'TRACE_ITER_VERBOSE'
   kernel/trace/trace.c:4461:43: sparse: sparse: undefined identifier 'TRACE_ITER_IRQ_INFO'
   kernel/trace/trace.c:4685:51: sparse: sparse: undefined identifier 'TRACE_ITER_PAUSE_ON_TRACE'
   kernel/trace/trace.c:4885:44: sparse: sparse: undefined identifier 'TRACE_ITER_LATENCY_FMT'
   kernel/trace/trace.c:5212:40: sparse: sparse: undefined identifier 'TRACE_ITER_OVERWRITE'
   kernel/trace/trace.c:5220:22: sparse: sparse: undefined identifier 'TRACE_ITER_RECORD_TGID'
   kernel/trace/trace.c:5235:21: sparse: sparse: undefined identifier 'TRACE_ITER_TRACE_PRINTK'
   kernel/trace/trace.c:5254:21: sparse: sparse: undefined identifier 'TRACE_ITER_COPY_MARKER'
   kernel/trace/trace.c:5262:21: sparse: sparse: undefined identifier 'TRACE_ITER_RECORD_CMD'
   kernel/trace/trace.c:5265:21: sparse: sparse: undefined identifier 'TRACE_ITER_RECORD_TGID'
   kernel/trace/trace.c:5268:45: sparse: sparse: undefined identifier 'TRACE_ITER_RECORD_TGID'
   kernel/trace/trace.c:5275:21: sparse: sparse: undefined identifier 'TRACE_ITER_EVENT_FORK'
   kernel/trace/trace.c:5278:21: sparse: sparse: undefined identifier 'TRACE_ITER_FUNC_FORK'
   kernel/trace/trace.c:5281:21: sparse: sparse: undefined identifier 'TRACE_ITER_OVERWRITE'
   kernel/trace/trace.c:5288:21: sparse: sparse: undefined identifier 'TRACE_ITER_PRINTK'
   kernel/trace/trace.c:6548:31: sparse: sparse: undefined identifier 'TRACE_ITER_LATENCY_FMT'
   kernel/trace/trace.c:6609:31: sparse: sparse: undefined identifier 'TRACE_ITER_BLOCK'
   kernel/trace/trace.c:7161:31: sparse: sparse: undefined identifier 'TRACE_ITER_STOP_ON_FREE'
   kernel/trace/trace.c:7264:33: sparse: sparse: undefined identifier 'TRACE_ITER_MARKERS'
   kernel/trace/trace.c:7345:33: sparse: sparse: undefined identifier 'TRACE_ITER_MARKERS'
   kernel/trace/trace.c:9332:37: sparse: sparse: undefined identifier 'TRACE_ITER_PRINTK'
   kernel/trace/trace.c:9332:37: sparse: sparse: undefined identifier 'TRACE_ITER_PRINTK_MSGONLY'
   kernel/trace/trace.c:9332:37: sparse: sparse: undefined identifier 'TRACE_ITER_RECORD_CMD'
   kernel/trace/trace.c:9655:38: sparse: sparse: undefined identifier 'TRACE_ITER_OVERWRITE'
   kernel/trace/trace.c:9848:55: sparse: sparse: undefined identifier 'TRACE_ITER_EVENT_FORK'
   kernel/trace/trace.c:9848:55: sparse: sparse: undefined identifier 'TRACE_ITER_FUNC_FORK'
   kernel/trace/trace.c:9848:55: sparse: sparse: undefined identifier 'TRACE_ITER_TRACE_PRINTK'
   kernel/trace/trace.c:9848:55: sparse: sparse: undefined identifier 'TRACE_ITER_COPY_MARKER'
   kernel/trace/trace.c:10017:32: sparse: sparse: undefined identifier 'TRACE_ITER_EVENT_FORK'
   kernel/trace/trace.c:10017:32: sparse: sparse: undefined identifier 'TRACE_ITER_FUNC_FORK'
   kernel/trace/trace.c:10017:32: sparse: sparse: undefined identifier 'TRACE_ITER_TRACE_PRINTK'
   kernel/trace/trace.c:10017:32: sparse: sparse: undefined identifier 'TRACE_ITER_COPY_MARKER'
   kernel/trace/trace.c:10609:41: sparse: sparse: undefined identifier 'TRACE_ITER_SYM_USEROBJ'
   kernel/trace/trace.c:10612:29: sparse: sparse: undefined identifier 'TRACE_ITER_SYM_USEROBJ'
   kernel/trace/trace.c:454:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:454:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:454:9: sparse:    struct trace_export *
   kernel/trace/trace.c:469:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:469:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:469:9: sparse:    struct trace_export *
   kernel/trace/trace.c:3081:33: sparse: sparse: undefined identifier 'TRACE_ITER_STACKTRACE'

vim +1427 kernel/trace/trace.h

  1426	
> 1427	enum trace_iterator_flags : uint64_t { TRACE_FLAGS };
  1428	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
