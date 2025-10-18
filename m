Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F31285C8C;
	Sat, 18 Oct 2025 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760782215; cv=none; b=GJQF1Fa5D/91fa/adZmQ3TpXuFJGJJmaqC1DtVtyVOsfeSz13el2s8UU6CJiKGJbrqlQqsAAAKf03mr1wAXqOBaD8u0hmaZOM2x2cW6PsIl5BCK4AMsmU3GrfzaQMDf9mSWsMO+hu/HOuYmcc2QQn6bHJhPMmKqrYiC0u2skkBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760782215; c=relaxed/simple;
	bh=9GBDpmBli+4dcWpzmocu7ImRqmP28MXZDVF3ALI9+KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQNilGMgLU31ZgbkQhPBl+SBXvFtwYGSRalrIHKpCQ9sbQ2jIiQKRpLIyerY9tijnfN07ZuEVjyQOH3Oil6sLOtSuz/sjNndxZLqO6ch0AHIYGK9cfR4iL2fj0voYjS7q4mlDyx7BzurbU9T3cefV/8pVLopLIwvck6yFY0cuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUA8iLUP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUA8iLUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760782212; x=1792318212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9GBDpmBli+4dcWpzmocu7ImRqmP28MXZDVF3ALI9+KA=;
  b=UUA8iLUP0B7j3Z9RzaXfMLd41V4dJ/q9G8qtYG8lk1GCaJmMYhSXfSW0
   1m/o+LUiHQIkptumv57Bl+rGf1gKG43m3pAUsmPBkdNoiJBwp/PUGWF3k
   Fgx9f/cVPvZj74gHpD+9ftHgdkeHKVxBjnlxG9Nv0kbdzlRt7vlIlydQO
   F5T5oCHkOhiQwk6/bL8v+WoPE9FEc+yv/H639hekNXgr1xePlswKIn8ua
   H2UV59zPt8dq345IfQpzEI2updf7qEwPcimkJGSc577mS2LgQiLS68Dhj
   V8zcmD2XS6bAEP0Pk8WztnILVHNZ9TM5D5S7DuOT7O5/pzEiz5BnbbsOK
   A==;
X-CSE-ConnectionGUID: GL+2bkMHTWOr/MKo5okJAQ==
X-CSE-MsgGUID: 9NU55yt2S/amoHluJyh1hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="88454461"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="88454461"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 03:10:11 -0700
X-CSE-ConnectionGUID: UbMZ9dhURbW2f9VQVxfeMw==
X-CSE-MsgGUID: +Qkb8nJXR9eb6S0mUfIq2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="206649296"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 18 Oct 2025 03:10:11 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vA3t3-0008D7-0D;
	Sat, 18 Oct 2025 10:10:09 +0000
Date: Sat, 18 Oct 2025 18:10:01 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tracing: Allow tracer to add more than 32 options
Message-ID: <202510181711.rxbGAQu7-lkp@intel.com>
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
config: parisc-randconfig-001-20251018 (https://download.01.org/0day-ci/archive/20251018/202510181711.rxbGAQu7-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251018/202510181711.rxbGAQu7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510181711.rxbGAQu7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/trace/trace_probe.h:31,
                    from kernel/trace/trace_events_synth.c:20:
   kernel/trace/trace.h:1427:27: error: expected identifier or '(' before ':' token
    1427 | enum trace_iterator_flags : uint64_t { TRACE_FLAGS };
         |                           ^
   kernel/trace/trace_events_synth.c: In function 'print_synth_event':
>> kernel/trace/trace_events_synth.c:362:31: error: 'TRACE_ITER_VERBOSE' undeclared (first use in this function); did you mean 'TRACE_ITER_VERBOSE_BIT'?
     362 |   if (tr && tr->trace_flags & TRACE_ITER_VERBOSE)
         |                               ^~~~~~~~~~~~~~~~~~
         |                               TRACE_ITER_VERBOSE_BIT
   kernel/trace/trace_events_synth.c:362:31: note: each undeclared identifier is reported only once for each function it appears in


vim +362 kernel/trace/trace_events_synth.c

726721a51838e3 Tom Zanussi             2020-05-28  337  
726721a51838e3 Tom Zanussi             2020-05-28  338  static enum print_line_t print_synth_event(struct trace_iterator *iter,
726721a51838e3 Tom Zanussi             2020-05-28  339  					   int flags,
726721a51838e3 Tom Zanussi             2020-05-28  340  					   struct trace_event *event)
726721a51838e3 Tom Zanussi             2020-05-28  341  {
726721a51838e3 Tom Zanussi             2020-05-28  342  	struct trace_array *tr = iter->tr;
726721a51838e3 Tom Zanussi             2020-05-28  343  	struct trace_seq *s = &iter->seq;
726721a51838e3 Tom Zanussi             2020-05-28  344  	struct synth_trace_event *entry;
726721a51838e3 Tom Zanussi             2020-05-28  345  	struct synth_event *se;
887f92e09ef34a Sven Schnelle           2023-08-16  346  	unsigned int i, j, n_u64;
726721a51838e3 Tom Zanussi             2020-05-28  347  	char print_fmt[32];
726721a51838e3 Tom Zanussi             2020-05-28  348  	const char *fmt;
726721a51838e3 Tom Zanussi             2020-05-28  349  
726721a51838e3 Tom Zanussi             2020-05-28  350  	entry = (struct synth_trace_event *)iter->ent;
726721a51838e3 Tom Zanussi             2020-05-28  351  	se = container_of(event, struct synth_event, call.event);
726721a51838e3 Tom Zanussi             2020-05-28  352  
726721a51838e3 Tom Zanussi             2020-05-28  353  	trace_seq_printf(s, "%s: ", se->name);
726721a51838e3 Tom Zanussi             2020-05-28  354  
726721a51838e3 Tom Zanussi             2020-05-28  355  	for (i = 0, n_u64 = 0; i < se->n_fields; i++) {
726721a51838e3 Tom Zanussi             2020-05-28  356  		if (trace_seq_has_overflowed(s))
726721a51838e3 Tom Zanussi             2020-05-28  357  			goto end;
726721a51838e3 Tom Zanussi             2020-05-28  358  
726721a51838e3 Tom Zanussi             2020-05-28  359  		fmt = synth_field_fmt(se->fields[i]->type);
726721a51838e3 Tom Zanussi             2020-05-28  360  
726721a51838e3 Tom Zanussi             2020-05-28  361  		/* parameter types */
726721a51838e3 Tom Zanussi             2020-05-28 @362  		if (tr && tr->trace_flags & TRACE_ITER_VERBOSE)
726721a51838e3 Tom Zanussi             2020-05-28  363  			trace_seq_printf(s, "%s ", fmt);
726721a51838e3 Tom Zanussi             2020-05-28  364  
726721a51838e3 Tom Zanussi             2020-05-28  365  		snprintf(print_fmt, sizeof(print_fmt), "%%s=%s%%s", fmt);
726721a51838e3 Tom Zanussi             2020-05-28  366  
726721a51838e3 Tom Zanussi             2020-05-28  367  		/* parameter values */
726721a51838e3 Tom Zanussi             2020-05-28  368  		if (se->fields[i]->is_string) {
bd82631d7ccdc8 Tom Zanussi             2020-10-04  369  			if (se->fields[i]->is_dynamic) {
ddeea494a16f32 Sven Schnelle           2023-08-16  370  				union trace_synth_field *data = &entry->fields[n_u64];
bd82631d7ccdc8 Tom Zanussi             2020-10-04  371  
bd82631d7ccdc8 Tom Zanussi             2020-10-04  372  				trace_seq_printf(s, print_fmt, se->fields[i]->name,
ddeea494a16f32 Sven Schnelle           2023-08-16  373  						 (char *)entry + data->as_dynamic.offset,
bd82631d7ccdc8 Tom Zanussi             2020-10-04  374  						 i == se->n_fields - 1 ? "" : " ");
bd82631d7ccdc8 Tom Zanussi             2020-10-04  375  				n_u64++;
bd82631d7ccdc8 Tom Zanussi             2020-10-04  376  			} else {
726721a51838e3 Tom Zanussi             2020-05-28  377  				trace_seq_printf(s, print_fmt, se->fields[i]->name,
8db4d6bfbbf920 Steven Rostedt (VMware  2020-10-04  378) 						 STR_VAR_LEN_MAX,
ddeea494a16f32 Sven Schnelle           2023-08-16  379  						 (char *)&entry->fields[n_u64].as_u64,
726721a51838e3 Tom Zanussi             2020-05-28  380  						 i == se->n_fields - 1 ? "" : " ");
726721a51838e3 Tom Zanussi             2020-05-28  381  				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
bd82631d7ccdc8 Tom Zanussi             2020-10-04  382  			}
00cf3d672a9dd4 Steven Rostedt (Google  2023-01-17  383) 		} else if (se->fields[i]->is_stack) {
ddeea494a16f32 Sven Schnelle           2023-08-16  384  			union trace_synth_field *data = &entry->fields[n_u64];
887f92e09ef34a Sven Schnelle           2023-08-16  385  			unsigned long *p = (void *)entry + data->as_dynamic.offset;
00cf3d672a9dd4 Steven Rostedt (Google  2023-01-17  386) 
00cf3d672a9dd4 Steven Rostedt (Google  2023-01-17  387) 			trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
887f92e09ef34a Sven Schnelle           2023-08-16  388  			for (j = 1; j < data->as_dynamic.len / sizeof(long); j++)
887f92e09ef34a Sven Schnelle           2023-08-16  389  				trace_seq_printf(s, "=> %pS\n", (void *)p[j]);
00cf3d672a9dd4 Steven Rostedt (Google  2023-01-17  390) 			n_u64++;
726721a51838e3 Tom Zanussi             2020-05-28  391  		} else {
726721a51838e3 Tom Zanussi             2020-05-28  392  			struct trace_print_flags __flags[] = {
726721a51838e3 Tom Zanussi             2020-05-28  393  			    __def_gfpflag_names, {-1, NULL} };
726721a51838e3 Tom Zanussi             2020-05-28  394  			char *space = (i == se->n_fields - 1 ? "" : " ");
726721a51838e3 Tom Zanussi             2020-05-28  395  
726721a51838e3 Tom Zanussi             2020-05-28  396  			print_synth_event_num_val(s, print_fmt,
726721a51838e3 Tom Zanussi             2020-05-28  397  						  se->fields[i]->name,
726721a51838e3 Tom Zanussi             2020-05-28  398  						  se->fields[i]->size,
ddeea494a16f32 Sven Schnelle           2023-08-16  399  						  &entry->fields[n_u64],
726721a51838e3 Tom Zanussi             2020-05-28  400  						  space);
726721a51838e3 Tom Zanussi             2020-05-28  401  
726721a51838e3 Tom Zanussi             2020-05-28  402  			if (strcmp(se->fields[i]->type, "gfp_t") == 0) {
726721a51838e3 Tom Zanussi             2020-05-28  403  				trace_seq_puts(s, " (");
726721a51838e3 Tom Zanussi             2020-05-28  404  				trace_print_flags_seq(s, "|",
ddeea494a16f32 Sven Schnelle           2023-08-16  405  						      entry->fields[n_u64].as_u64,
726721a51838e3 Tom Zanussi             2020-05-28  406  						      __flags);
726721a51838e3 Tom Zanussi             2020-05-28  407  				trace_seq_putc(s, ')');
726721a51838e3 Tom Zanussi             2020-05-28  408  			}
726721a51838e3 Tom Zanussi             2020-05-28  409  			n_u64++;
726721a51838e3 Tom Zanussi             2020-05-28  410  		}
726721a51838e3 Tom Zanussi             2020-05-28  411  	}
726721a51838e3 Tom Zanussi             2020-05-28  412  end:
726721a51838e3 Tom Zanussi             2020-05-28  413  	trace_seq_putc(s, '\n');
726721a51838e3 Tom Zanussi             2020-05-28  414  
726721a51838e3 Tom Zanussi             2020-05-28  415  	return trace_handle_return(s);
726721a51838e3 Tom Zanussi             2020-05-28  416  }
726721a51838e3 Tom Zanussi             2020-05-28  417  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
