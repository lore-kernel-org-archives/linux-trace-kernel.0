Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB321C5D55;
	Sat, 18 Oct 2025 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760785321; cv=none; b=mMQx4yJ/tIg+JXHoPtg6VrxZMgctkrKebrQtlSxGS8piE6l+XmV9og43ZGUbG5LtTYHnImwG3/ZgCE0LsBHJTvdhVpHAhVBrFudzCgu+m7AUQUlOX4YslLg8LJilYKQh7CDLxlU3dAiQNg3i18C1fUTAxGi3uiqqpoOlK5sPVgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760785321; c=relaxed/simple;
	bh=RLAaTmnfd4qDaSZjwspLJ0Th8IfreYiAcDPtvl8mnCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGttRDvQ0ylrLSzYPSn+rX3NfRnBPq48pHx12o/OO8XOa/3OB6FeUkkoqnVk+3dDT8d7A15ckTFabeh9JMZXNgFmJlSjAT9xRk+53XSycZy20+vdRMU3L8LozPP48lXIM6ZMBJxF2zHBfvKdaC14beXfpx5XnRE3HDCDJeD4R8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UE5Qsdhg; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UE5Qsdhg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760785316; x=1792321316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RLAaTmnfd4qDaSZjwspLJ0Th8IfreYiAcDPtvl8mnCA=;
  b=UE5QsdhgY99beeBbSEeSguk4lSCyUo8MF9guktnM/LDynS8/ydybxySG
   yOenzW1f+ODaY0C48LaPUDg8TiC81DWXrtrhsoN6K1eCPNm3Qma8Hn6Z9
   fDpz6dLrZeNu7TtLzUy8SF6ea6uAyFhFhXNTPx3zg1LeJ0mc1J+y84j/7
   HJsT9y37PqntKntiJe2u5ie+sKLUEuJ6ctLz9Z5G9748IGIagCJF1FixB
   SBh6AkyMfYSlRuxUwLTbUle+jUEB7G0dV3V0WIPBiWR/aAuZI8sc5oEbk
   Gbx5ETisgVeQBEm7XNjG0COdAH67RLyC6HL1tydsNFTStfBMniM+/A0Tv
   Q==;
X-CSE-ConnectionGUID: NVFKU4JeTa2tgeVZ2BqmGA==
X-CSE-MsgGUID: LWMqmOpGSji9FQCwDu/q2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="85605469"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="85605469"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 04:01:56 -0700
X-CSE-ConnectionGUID: Zcbjl+pYSwaT3gWropW00g==
X-CSE-MsgGUID: vf3+PPDtQ3yNnXIlauYXJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="183700213"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 18 Oct 2025 04:01:55 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vA4h4-0008F7-1v;
	Sat, 18 Oct 2025 11:01:52 +0000
Date: Sat, 18 Oct 2025 19:01:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tracing: Allow tracer to add more than 32 options
Message-ID: <202510181829.4FNFzdXV-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.18-rc1 next-20251017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-Allow-tracer-to-add-more-than-32-options/20251018-004104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/176071774097.175601.10233017390618260565.stgit%40devnote2
patch subject: [PATCH v4 1/2] tracing: Allow tracer to add more than 32 options
config: arc-randconfig-002-20251018 (https://download.01.org/0day-ci/archive/20251018/202510181829.4FNFzdXV-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251018/202510181829.4FNFzdXV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510181829.4FNFzdXV-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/trace/trace_events_filter.c:15:
>> kernel/trace/trace.h:1427:27: error: expected identifier or '(' before ':' token
    enum trace_iterator_flags : uint64_t { TRACE_FLAGS };
                              ^
--
   In file included from kernel/trace/trace_output.c:8:
>> kernel/trace/trace.h:1427:27: error: expected identifier or '(' before ':' token
    enum trace_iterator_flags : uint64_t { TRACE_FLAGS };
                              ^
   kernel/trace/trace_output.c: In function 'seq_print_user_ip':
>> kernel/trace/trace_output.c:423:27: error: 'TRACE_ITER_SYM_ADDR' undeclared (first use in this function); did you mean 'TRACE_ITER_SYM_ADDR_BIT'?
     if (ret && ((sym_flags & TRACE_ITER_SYM_ADDR) || !file))
                              ^~~~~~~~~~~~~~~~~~~
                              TRACE_ITER_SYM_ADDR_BIT
   kernel/trace/trace_output.c:423:27: note: each undeclared identifier is reported only once for each function it appears in
   kernel/trace/trace_output.c: In function 'seq_print_ip_sym':
>> kernel/trace/trace_output.c:436:41: error: 'TRACE_ITER_SYM_OFFSET' undeclared (first use in this function); did you mean 'TRACE_ITER_SYM_OFFSET_BIT'?
     trace_seq_print_sym(s, ip, sym_flags & TRACE_ITER_SYM_OFFSET);
                                            ^~~~~~~~~~~~~~~~~~~~~
                                            TRACE_ITER_SYM_OFFSET_BIT
   kernel/trace/trace_output.c:438:18: error: 'TRACE_ITER_SYM_ADDR' undeclared (first use in this function); did you mean 'TRACE_ITER_SYM_ADDR_BIT'?
     if (sym_flags & TRACE_ITER_SYM_ADDR)
                     ^~~~~~~~~~~~~~~~~~~
                     TRACE_ITER_SYM_ADDR_BIT
   kernel/trace/trace_output.c: In function 'lat_print_timestamp':
>> kernel/trace/trace_output.c:572:44: error: 'TRACE_ITER_VERBOSE' undeclared (first use in this function); did you mean 'TRACE_ITER_VERBOSE_BIT'?
     unsigned long verbose = tr->trace_flags & TRACE_ITER_VERBOSE;
                                               ^~~~~~~~~~~~~~~~~~
                                               TRACE_ITER_VERBOSE_BIT
   kernel/trace/trace_output.c: In function 'trace_print_context':
>> kernel/trace/trace_output.c:639:24: error: 'TRACE_ITER_RECORD_TGID' undeclared (first use in this function); did you mean 'TRACE_ITER_RECORD_TGID_BIT'?
     if (tr->trace_flags & TRACE_ITER_RECORD_TGID) {
                           ^~~~~~~~~~~~~~~~~~~~~~
                           TRACE_ITER_RECORD_TGID_BIT
>> kernel/trace/trace_output.c:650:24: error: 'TRACE_ITER_IRQ_INFO' undeclared (first use in this function); did you mean 'TRACE_ITER_IRQ_INFO_BIT'?
     if (tr->trace_flags & TRACE_ITER_IRQ_INFO)
                           ^~~~~~~~~~~~~~~~~~~
                           TRACE_ITER_IRQ_INFO_BIT
   kernel/trace/trace_output.c: In function 'trace_print_lat_context':
   kernel/trace/trace_output.c:664:45: error: 'TRACE_ITER_VERBOSE' undeclared (first use in this function); did you mean 'TRACE_ITER_VERBOSE_BIT'?
     unsigned long verbose = (tr->trace_flags & TRACE_ITER_VERBOSE);
                                                ^~~~~~~~~~~~~~~~~~
                                                TRACE_ITER_VERBOSE_BIT
   kernel/trace/trace_output.c: In function 'print_fn_trace':
>> kernel/trace/trace_output.c:1130:15: error: 'TRACE_ITER_PRINT_PARENT' undeclared (first use in this function); did you mean 'TRACE_ITER_PRINT_PARENT_BIT'?
     if ((flags & TRACE_ITER_PRINT_PARENT) && parent_ip) {
                  ^~~~~~~~~~~~~~~~~~~~~~~
                  TRACE_ITER_PRINT_PARENT_BIT
   kernel/trace/trace_output.c: In function 'trace_user_stack_print':
>> kernel/trace/trace_output.c:1420:24: error: 'TRACE_ITER_SYM_USEROBJ' undeclared (first use in this function); did you mean 'TRACE_ITER_SYM_USEROBJ_BIT'?
     if (tr->trace_flags & TRACE_ITER_SYM_USEROBJ) {
                           ^~~~~~~~~~~~~~~~~~~~~~
                           TRACE_ITER_SYM_USEROBJ_BIT
--
   In file included from kernel/trace/trace_output.h:6,
                    from kernel/trace/trace_syscalls.c:13:
>> kernel/trace/trace.h:1427:27: error: expected identifier or '(' before ':' token
    enum trace_iterator_flags : uint64_t { TRACE_FLAGS };
                              ^
   kernel/trace/trace_syscalls.c: In function 'print_syscall_enter':
>> kernel/trace/trace_syscalls.c:160:31: error: 'TRACE_ITER_VERBOSE' undeclared (first use in this function); did you mean 'TRACE_ITER_VERBOSE_BIT'?
      if (tr && tr->trace_flags & TRACE_ITER_VERBOSE)
                                  ^~~~~~~~~~~~~~~~~~
                                  TRACE_ITER_VERBOSE_BIT
   kernel/trace/trace_syscalls.c:160:31: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from kernel/trace/trace_output.h:6,
                    from kernel/trace/trace_events.c:31:
>> kernel/trace/trace.h:1427:27: error: expected identifier or '(' before ':' token
    enum trace_iterator_flags : uint64_t { TRACE_FLAGS };
                              ^
   kernel/trace/trace_events.c: In function '__ftrace_event_enable_disable':
>> kernel/trace/trace_events.c:848:26: error: 'TRACE_ITER_RECORD_CMD' undeclared (first use in this function); did you mean 'TRACE_ITER_RECORD_CMD_BIT'?
       if (tr->trace_flags & TRACE_ITER_RECORD_CMD) {
                             ^~~~~~~~~~~~~~~~~~~~~
                             TRACE_ITER_RECORD_CMD_BIT
   kernel/trace/trace_events.c:848:26: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/trace/trace_events.c:854:26: error: 'TRACE_ITER_RECORD_TGID' undeclared (first use in this function); did you mean 'TRACE_ITER_RECORD_TGID_BIT'?
       if (tr->trace_flags & TRACE_ITER_RECORD_TGID) {
                             ^~~~~~~~~~~~~~~~~~~~~~
                             TRACE_ITER_RECORD_TGID_BIT
--
   In file included from kernel/trace/trace.c:58:
>> kernel/trace/trace.h:1427:27: error: expected identifier or '(' before ':' token
    enum trace_iterator_flags : uint64_t { TRACE_FLAGS };
                              ^
>> kernel/trace/trace.c:516:3: error: 'TRACE_ITER_PRINT_PARENT' undeclared here (not in a function); did you mean 'TRACE_ITER_PRINT_PARENT_BIT'?
      TRACE_ITER_PRINT_PARENT | TRACE_ITER_PRINTK |   \
      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:537:17: note: in expansion of macro 'TRACE_DEFAULT_FLAGS'
     .trace_flags = TRACE_DEFAULT_FLAGS,
                    ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace.c:516:29: error: 'TRACE_ITER_PRINTK' undeclared here (not in a function); did you mean 'TRACE_ITER_PRINTK_BIT'?
      TRACE_ITER_PRINT_PARENT | TRACE_ITER_PRINTK |   \
                                ^~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:537:17: note: in expansion of macro 'TRACE_DEFAULT_FLAGS'
     .trace_flags = TRACE_DEFAULT_FLAGS,
                    ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace.c:517:3: error: 'TRACE_ITER_ANNOTATE' undeclared here (not in a function); did you mean 'TRACE_FILE_ANNOTATE'?
      TRACE_ITER_ANNOTATE | TRACE_ITER_CONTEXT_INFO |  \
      ^~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:537:17: note: in expansion of macro 'TRACE_DEFAULT_FLAGS'
     .trace_flags = TRACE_DEFAULT_FLAGS,
                    ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace.c:517:25: error: 'TRACE_ITER_CONTEXT_INFO' undeclared here (not in a function); did you mean 'TRACE_ITER_CONTEXT_INFO_BIT'?
      TRACE_ITER_ANNOTATE | TRACE_ITER_CONTEXT_INFO |  \
                            ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:537:17: note: in expansion of macro 'TRACE_DEFAULT_FLAGS'
     .trace_flags = TRACE_DEFAULT_FLAGS,
                    ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace.c:518:3: error: 'TRACE_ITER_RECORD_CMD' undeclared here (not in a function); did you mean 'TRACE_ITER_RECORD_CMD_BIT'?
      TRACE_ITER_RECORD_CMD | TRACE_ITER_OVERWRITE |   \
      ^~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:537:17: note: in expansion of macro 'TRACE_DEFAULT_FLAGS'
     .trace_flags = TRACE_DEFAULT_FLAGS,
                    ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace.c:518:27: error: 'TRACE_ITER_OVERWRITE' undeclared here (not in a function); did you mean 'TRACE_ITER_OVERWRITE_BIT'?
      TRACE_ITER_RECORD_CMD | TRACE_ITER_OVERWRITE |   \
                              ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:537:17: note: in expansion of macro 'TRACE_DEFAULT_FLAGS'
     .trace_flags = TRACE_DEFAULT_FLAGS,
                    ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace.c:519:3: error: 'TRACE_ITER_IRQ_INFO' undeclared here (not in a function); did you mean 'TRACE_ITER_IRQ_INFO_BIT'?
      TRACE_ITER_IRQ_INFO | TRACE_ITER_MARKERS |   \
      ^~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:537:17: note: in expansion of macro 'TRACE_DEFAULT_FLAGS'
     .trace_flags = TRACE_DEFAULT_FLAGS,
                    ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace.c:519:25: error: 'TRACE_ITER_MARKERS' undeclared here (not in a function); did you mean 'TRACE_ITER_MARKERS_BIT'?
      TRACE_ITER_IRQ_INFO | TRACE_ITER_MARKERS |   \
                            ^~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:537:17: note: in expansion of macro 'TRACE_DEFAULT_FLAGS'
     .trace_flags = TRACE_DEFAULT_FLAGS,
                    ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace.c:520:3: error: 'TRACE_ITER_HASH_PTR' undeclared here (not in a function); did you mean 'TRACE_ITER_HASH_PTR_BIT'?
      TRACE_ITER_HASH_PTR | TRACE_ITER_TRACE_PRINTK |  \
      ^~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:537:17: note: in expansion of macro 'TRACE_DEFAULT_FLAGS'
     .trace_flags = TRACE_DEFAULT_FLAGS,
                    ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace.c:520:25: error: 'TRACE_ITER_TRACE_PRINTK' undeclared here (not in a function); did you mean 'TRACE_ITER_TRACE_PRINTK_BIT'?
      TRACE_ITER_HASH_PTR | TRACE_ITER_TRACE_PRINTK |  \
                            ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:537:17: note: in expansion of macro 'TRACE_DEFAULT_FLAGS'
     .trace_flags = TRACE_DEFAULT_FLAGS,
                    ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace.c:521:3: error: 'TRACE_ITER_COPY_MARKER' undeclared here (not in a function); did you mean 'TRACE_ITER_COPY_MARKER_BIT'?
      TRACE_ITER_COPY_MARKER)
      ^~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:537:17: note: in expansion of macro 'TRACE_DEFAULT_FLAGS'
     .trace_flags = TRACE_DEFAULT_FLAGS,
                    ^~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c: In function 'ftrace_trace_stack':
>> kernel/trace/trace.c:3081:26: error: 'TRACE_ITER_STACKTRACE' undeclared (first use in this function); did you mean 'TRACE_ITER_STACKTRACE_BIT'?
     if (!(tr->trace_flags & TRACE_ITER_STACKTRACE))
                             ^~~~~~~~~~~~~~~~~~~~~
                             TRACE_ITER_STACKTRACE_BIT
   kernel/trace/trace.c:3081:26: note: each undeclared identifier is reported only once for each function it appears in
   kernel/trace/trace.c: In function 'print_func_help_header':
>> kernel/trace/trace.c:4116:22: error: 'TRACE_ITER_RECORD_TGID' undeclared (first use in this function); did you mean 'TRACE_ITER_RECORD_TGID_BIT'?
     bool tgid = flags & TRACE_ITER_RECORD_TGID;
                         ^~~~~~~~~~~~~~~~~~~~~~
                         TRACE_ITER_RECORD_TGID_BIT
   kernel/trace/trace.c: In function 'print_func_help_header_irq':
   kernel/trace/trace.c:4127:22: error: 'TRACE_ITER_RECORD_TGID' undeclared (first use in this function); did you mean 'TRACE_ITER_RECORD_TGID_BIT'?
     bool tgid = flags & TRACE_ITER_RECORD_TGID;
                         ^~~~~~~~~~~~~~~~~~~~~~
                         TRACE_ITER_RECORD_TGID_BIT
   In file included from kernel/trace/trace.c:58:
   kernel/trace/trace.c: In function 'print_trace_header':
>> kernel/trace/trace.h:1434:27: error: 'TRACE_ITER_SYM_OFFSET' undeclared (first use in this function); did you mean 'TRACE_ITER_SYM_OFFSET_BIT'?
     (TRACE_ITER_PRINT_PARENT|TRACE_ITER_SYM_OFFSET|TRACE_ITER_SYM_ADDR)
                              ^~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:4146:56: note: in expansion of macro 'TRACE_ITER_SYM_MASK'
     unsigned long sym_flags = (global_trace.trace_flags & TRACE_ITER_SYM_MASK);
                                                           ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace.h:1434:49: error: 'TRACE_ITER_SYM_ADDR' undeclared (first use in this function); did you mean 'TRACE_ITER_SYM_ADDR_BIT'?
     (TRACE_ITER_PRINT_PARENT|TRACE_ITER_SYM_OFFSET|TRACE_ITER_SYM_ADDR)
                                                    ^~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:4146:56: note: in expansion of macro 'TRACE_ITER_SYM_MASK'
     unsigned long sym_flags = (global_trace.trace_flags & TRACE_ITER_SYM_MASK);
                                                           ^~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c: In function 'print_trace_fmt':
>> kernel/trace/trace.h:1434:27: error: 'TRACE_ITER_SYM_OFFSET' undeclared (first use in this function); did you mean 'TRACE_ITER_SYM_OFFSET_BIT'?
     (TRACE_ITER_PRINT_PARENT|TRACE_ITER_SYM_OFFSET|TRACE_ITER_SYM_ADDR)
                              ^~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:4226:47: note: in expansion of macro 'TRACE_ITER_SYM_MASK'
     unsigned long sym_flags = (tr->trace_flags & TRACE_ITER_SYM_MASK);
                                                  ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace.h:1434:49: error: 'TRACE_ITER_SYM_ADDR' undeclared (first use in this function); did you mean 'TRACE_ITER_SYM_ADDR_BIT'?
     (TRACE_ITER_PRINT_PARENT|TRACE_ITER_SYM_OFFSET|TRACE_ITER_SYM_ADDR)
                                                    ^~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:4226:47: note: in expansion of macro 'TRACE_ITER_SYM_MASK'
     unsigned long sym_flags = (tr->trace_flags & TRACE_ITER_SYM_MASK);
                                                  ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/trace.c:4247:25: error: 'TRACE_ITER_FIELDS' undeclared (first use in this function); did you mean 'TRACE_ITER_FIELDS_BIT'?
      if (tr->trace_flags & TRACE_ITER_FIELDS)
                            ^~~~~~~~~~~~~~~~~
                            TRACE_ITER_FIELDS_BIT
   kernel/trace/trace.c: In function 'print_trace_line':
>> kernel/trace/trace.c:4402:18: error: 'TRACE_ITER_PRINTK_MSGONLY' undeclared (first use in this function); did you mean 'TRACE_ITER_PRINTK_MSGONLY_BIT'?
       trace_flags & TRACE_ITER_PRINTK_MSGONLY)
                     ^~~~~~~~~~~~~~~~~~~~~~~~~
                     TRACE_ITER_PRINTK_MSGONLY_BIT
   kernel/trace/trace.c:4415:20: error: 'TRACE_ITER_BIN' undeclared (first use in this function); did you mean 'TRACE_ITER_BIN_BIT'?
     if (trace_flags & TRACE_ITER_BIN)
                       ^~~~~~~~~~~~~~
                       TRACE_ITER_BIN_BIT
   kernel/trace/trace.c:4418:20: error: 'TRACE_ITER_HEX' undeclared (first use in this function); did you mean 'TRACE_ITER_HEX_BIT'?
     if (trace_flags & TRACE_ITER_HEX)
                       ^~~~~~~~~~~~~~
                       TRACE_ITER_HEX_BIT
   kernel/trace/trace.c:4421:20: error: 'TRACE_ITER_RAW' undeclared (first use in this function); did you mean 'TRACE_ITER_RAW_BIT'?
     if (trace_flags & TRACE_ITER_RAW)
                       ^~~~~~~~~~~~~~
                       TRACE_ITER_RAW_BIT
   kernel/trace/trace.c: In function 'trace_latency_header':
   kernel/trace/trace.c:4439:26: error: 'TRACE_ITER_VERBOSE' undeclared (first use in this function); did you mean 'TRACE_ITER_VERBOSE_BIT'?
     if (!(tr->trace_flags & TRACE_ITER_VERBOSE))
                             ^~~~~~~~~~~~~~~~~~
                             TRACE_ITER_VERBOSE_BIT
   kernel/trace/trace.c: In function 'trace_default_header':
   kernel/trace/trace.c:4457:23: error: 'TRACE_ITER_VERBOSE' undeclared (first use in this function); did you mean 'TRACE_ITER_VERBOSE_BIT'?
      if (!(trace_flags & TRACE_ITER_VERBOSE))
                          ^~~~~~~~~~~~~~~~~~
                          TRACE_ITER_VERBOSE_BIT
   kernel/trace/trace.c: In function '__tracing_open':
   kernel/trace/trace.c:4685:44: error: 'TRACE_ITER_PAUSE_ON_TRACE' undeclared (first use in this function); did you mean 'TRACE_ITER_PAUSE_ON_TRACE_BIT'?
     if (!iter->snapshot && (tr->trace_flags & TRACE_ITER_PAUSE_ON_TRACE))
                                               ^~~~~~~~~~~~~~~~~~~~~~~~~
                                               TRACE_ITER_PAUSE_ON_TRACE_BIT
   kernel/trace/trace.c: In function 'tracing_open':
   kernel/trace/trace.c:4885:30: error: 'TRACE_ITER_LATENCY_FMT' undeclared (first use in this function); did you mean 'TRACE_ITER_LATENCY_FMT_BIT'?
      else if (tr->trace_flags & TRACE_ITER_LATENCY_FMT)
                                 ^~~~~~~~~~~~~~~~~~~~~~
                                 TRACE_ITER_LATENCY_FMT_BIT
   kernel/trace/trace.c: In function 'set_tracer_flag':
   kernel/trace/trace.c:5220:15: error: 'TRACE_ITER_RECORD_TGID' undeclared (first use in this function); did you mean 'TRACE_ITER_RECORD_TGID_BIT'?
     if ((mask == TRACE_ITER_RECORD_TGID) ||
                  ^~~~~~~~~~~~~~~~~~~~~~
                  TRACE_ITER_RECORD_TGID_BIT
   kernel/trace/trace.c:5275:14: error: 'TRACE_ITER_EVENT_FORK' undeclared (first use in this function); did you mean 'TRACE_ITER_EVENT_FORK_BIT'?
     if (mask == TRACE_ITER_EVENT_FORK)
                 ^~~~~~~~~~~~~~~~~~~~~
                 TRACE_ITER_EVENT_FORK_BIT
   kernel/trace/trace.c: In function 'tracing_open_pipe':
   kernel/trace/trace.c:6548:24: error: 'TRACE_ITER_LATENCY_FMT' undeclared (first use in this function); did you mean 'TRACE_ITER_LATENCY_FMT_BIT'?
     if (tr->trace_flags & TRACE_ITER_LATENCY_FMT)
                           ^~~~~~~~~~~~~~~~~~~~~~
                           TRACE_ITER_LATENCY_FMT_BIT
   kernel/trace/trace.c: In function 'trace_poll':
   kernel/trace/trace.c:6609:24: error: 'TRACE_ITER_BLOCK' undeclared (first use in this function); did you mean 'TRACE_ITER_BLOCK_BIT'?
     if (tr->trace_flags & TRACE_ITER_BLOCK)
                           ^~~~~~~~~~~~~~~~
                           TRACE_ITER_BLOCK_BIT
   kernel/trace/trace.c: In function 'tracing_free_buffer_release':
   kernel/trace/trace.c:7161:24: error: 'TRACE_ITER_STOP_ON_FREE' undeclared (first use in this function); did you mean 'TRACE_ITER_STOP_ON_FREE_BIT'?
     if (tr->trace_flags & TRACE_ITER_STOP_ON_FREE)
                           ^~~~~~~~~~~~~~~~~~~~~~~
                           TRACE_ITER_STOP_ON_FREE_BIT
   kernel/trace/trace.c: In function 'create_trace_options_dir':
   kernel/trace/trace.c:525:9: error: 'TRACE_ITER_PRINTK_MSGONLY' undeclared (first use in this function); did you mean 'TRACE_ITER_PRINTK_MSGONLY_BIT'?
            TRACE_ITER_PRINTK_MSGONLY | TRACE_ITER_RECORD_CMD)
            ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:9332:23: note: in expansion of macro 'TOP_LEVEL_TRACE_FLAGS'
          !((1ULL << i) & TOP_LEVEL_TRACE_FLAGS)) {
                          ^~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c: In function 'trace_array_create_systems':
   kernel/trace/trace.c:529:3: error: 'TRACE_ITER_EVENT_FORK' undeclared (first use in this function); did you mean 'TRACE_ITER_EVENT_FORK_BIT'?
     (TRACE_ITER_EVENT_FORK | TRACE_ITER_FUNC_FORK | TRACE_ITER_TRACE_PRINTK | \
      ^~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:9848:48: note: in expansion of macro 'ZEROED_TRACE_FLAGS'
     tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
                                                   ^~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c: In function '__remove_instance':
   kernel/trace/trace.c:529:3: error: 'TRACE_ITER_EVENT_FORK' undeclared (first use in this function); did you mean 'TRACE_ITER_EVENT_FORK_BIT'?
     (TRACE_ITER_EVENT_FORK | TRACE_ITER_FUNC_FORK | TRACE_ITER_TRACE_PRINTK | \
      ^~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:10017:18: note: in expansion of macro 'ZEROED_TRACE_FLAGS'
      if ((1 << i) & ZEROED_TRACE_FLAGS)
                     ^~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c: In function 'ftrace_dump_one':
   kernel/trace/trace.c:10609:34: error: 'TRACE_ITER_SYM_USEROBJ' undeclared (first use in this function); did you mean 'TRACE_ITER_SYM_USEROBJ_BIT'?
     old_userobj = tr->trace_flags & TRACE_ITER_SYM_USEROBJ;
                                     ^~~~~~~~~~~~~~~~~~~~~~
                                     TRACE_ITER_SYM_USEROBJ_BIT
   kernel/trace/trace.c: In function 'trace_poll':
   kernel/trace/trace.c:6617:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
--
   In file included from kernel/trace/trace_sched_wakeup.c:20:
>> kernel/trace/trace.h:1427:27: error: expected identifier or '(' before ':' token
    enum trace_iterator_flags : uint64_t { TRACE_FLAGS };
                              ^
   kernel/trace/trace_sched_wakeup.c: In function '__wakeup_tracer_init':
>> kernel/trace/trace_sched_wakeup.c:688:22: error: 'TRACE_ITER_OVERWRITE' undeclared (first use in this function); did you mean 'TRACE_ITER_OVERWRITE_BIT'?
     set_tracer_flag(tr, TRACE_ITER_OVERWRITE, 1);
                         ^~~~~~~~~~~~~~~~~~~~
                         TRACE_ITER_OVERWRITE_BIT
   kernel/trace/trace_sched_wakeup.c:688:22: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/trace/trace_sched_wakeup.c:689:22: error: 'TRACE_ITER_LATENCY_FMT' undeclared (first use in this function); did you mean 'TRACE_ITER_LATENCY_FMT_BIT'?
     set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, 1);
                         ^~~~~~~~~~~~~~~~~~~~~~
                         TRACE_ITER_LATENCY_FMT_BIT
   kernel/trace/trace_sched_wakeup.c: In function 'wakeup_tracer_reset':
   kernel/trace/trace_sched_wakeup.c:732:30: error: 'TRACE_ITER_LATENCY_FMT' undeclared (first use in this function); did you mean 'TRACE_ITER_LATENCY_FMT_BIT'?
     int lat_flag = save_flags & TRACE_ITER_LATENCY_FMT;
                                 ^~~~~~~~~~~~~~~~~~~~~~
                                 TRACE_ITER_LATENCY_FMT_BIT
   kernel/trace/trace_sched_wakeup.c:733:36: error: 'TRACE_ITER_OVERWRITE' undeclared (first use in this function); did you mean 'TRACE_ITER_OVERWRITE_BIT'?
     int overwrite_flag = save_flags & TRACE_ITER_OVERWRITE;
                                       ^~~~~~~~~~~~~~~~~~~~
                                       TRACE_ITER_OVERWRITE_BIT
..


vim +1427 kernel/trace/trace.h

  1426	
> 1427	enum trace_iterator_flags : uint64_t { TRACE_FLAGS };
  1428	
  1429	/*
  1430	 * TRACE_ITER_SYM_MASK masks the options in trace_flags that
  1431	 * control the output of kernel symbols.
  1432	 */
  1433	#define TRACE_ITER_SYM_MASK \
> 1434		(TRACE_ITER_PRINT_PARENT|TRACE_ITER_SYM_OFFSET|TRACE_ITER_SYM_ADDR)
  1435	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
