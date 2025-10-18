Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09B42065;
	Sat, 18 Oct 2025 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760789842; cv=none; b=K2J6bGpg7gf2PnBuPx9qjFjhijqPBmKKE3lV9GTfWu0iZF8idvbexUiHEz6dcCzhZgut8AY5oUbmteT0IgMGh5+9rj/rfn9S+IHlntkpMYLuNNHBRCrjzng/JeCHGdHZgJwntB+MmkrXBeHibFvojT4+s4gSavK0nLP0H+T6AMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760789842; c=relaxed/simple;
	bh=NVgGAPwwrLSCwbHx+kIcEztaGnNRLWNphzvMd9GtKb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMwXh8wpY+iSs7uVpjskDJkz0TXi3ZAl5LY4lcJea85a2tOghiGjCmPwdLpADeOD5p2bft0Ph/h4Fowx0Qp6a3A+XtSXcOEzNrqi1PgOkjmJ2r+6z1JOIcxoOvdw9C1TOA+nMmyldh29HQ0SOXdvWXTtihdRkuMHUGUsxwd/9sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EsBoq2FC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EsBoq2FC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760789841; x=1792325841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NVgGAPwwrLSCwbHx+kIcEztaGnNRLWNphzvMd9GtKb4=;
  b=EsBoq2FCNNWf4NbWJC2fTHdjPA1KmmbioRKD/Cvn07AzB2U+TUyMyuyQ
   4w2t+MdBLhoKLWJCDWqVIdTKr/dKr8EykXACyXMC9Kpj6X4k4dWOtaj+C
   pDAwLfhfHaXoIS4Fa8ROJnXhvL7mhiypRsHCnyPc95MoEotZG/qhOUn/C
   +fOxn+EP4BlLfnFy8FfyW/IiYi3X27cZpHfg1WEjYRkNjK/8GZSw7nVzu
   YaR1tLc4XI1mt0cV2E5l4POAbwzVbDj2siM0AFFlm5R1G8jw6DluVgTQ1
   NL6dxPuKdB6mbWUEAcf1HqvgeO5O64Edb4Zo3NU3mgGz0cmID1TmzPQlX
   w==;
X-CSE-ConnectionGUID: DGVCFJP7RqSJl1CoBmf1HQ==
X-CSE-MsgGUID: NpRGHkLOSVOPcvfIFS771g==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="73589141"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="73589141"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 05:17:20 -0700
X-CSE-ConnectionGUID: 7pe2GAzGR+qZ0MPAOZtUHA==
X-CSE-MsgGUID: 9nY2xmu0SZWwn7mBDZKc5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="188253747"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 18 Oct 2025 05:17:18 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vA5rZ-0008Gv-2C;
	Sat, 18 Oct 2025 12:16:49 +0000
Date: Sat, 18 Oct 2025 20:16:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] tracing: Add an option to show symbols in
 _text+offset for function profiler
Message-ID: <202510181934.DYd8mdHX-lkp@intel.com>
References: <176071775059.175601.3827350589430991963.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176071775059.175601.3827350589430991963.stgit@devnote2>

Hi Masami,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.18-rc1 next-20251017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-Allow-tracer-to-add-more-than-32-options/20251018-004104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/176071775059.175601.3827350589430991963.stgit%40devnote2
patch subject: [PATCH v4 2/2] tracing: Add an option to show symbols in _text+offset for function profiler
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251018/202510181934.DYd8mdHX-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251018/202510181934.DYd8mdHX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510181934.DYd8mdHX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/trace/trace_output.h:6,
                    from kernel/trace/ftrace.c:45:
>> kernel/trace/trace.h:1434:34: error: enumerator value outside the range of underlying type
    1434 | #define C(a, b) TRACE_ITER_##a = (1 << TRACE_ITER_##a##_BIT)
         |                                  ^
   kernel/trace/trace.h:1369:17: note: in expansion of macro 'C'
    1369 |                 C(PROF_TEXT_OFFSET,     "prof-text-offset"),
         |                 ^
   kernel/trace/trace.h:1414:17: note: in expansion of macro 'PROFILER_FLAGS'
    1414 |                 PROFILER_FLAGS
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1436:40: note: in expansion of macro 'TRACE_FLAGS'
    1436 | enum trace_iterator_flags : uint64_t { TRACE_FLAGS };
         |                                        ^~~~~~~~~~~
--
   In file included from kernel/trace/trace_probe.h:31,
                    from kernel/trace/bpf_trace.c:35:
>> kernel/trace/trace.h:1434:34: error: enumerator value outside the range of underlying type
    1434 | #define C(a, b) TRACE_ITER_##a = (1 << TRACE_ITER_##a##_BIT)
         |                                  ^
   kernel/trace/trace.h:1369:17: note: in expansion of macro 'C'
    1369 |                 C(PROF_TEXT_OFFSET,     "prof-text-offset"),
         |                 ^
   kernel/trace/trace.h:1414:17: note: in expansion of macro 'PROFILER_FLAGS'
    1414 |                 PROFILER_FLAGS
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1436:40: note: in expansion of macro 'TRACE_FLAGS'
    1436 | enum trace_iterator_flags : uint64_t { TRACE_FLAGS };
         |                                        ^~~~~~~~~~~
   kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
   kernel/trace/bpf_trace.c:378:9: warning: function '____bpf_trace_printk' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     378 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
         |         ^~~
   kernel/trace/bpf_trace.c: In function '____bpf_trace_vprintk':
   kernel/trace/bpf_trace.c:434:9: warning: function '____bpf_trace_vprintk' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     434 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
         |         ^~~
   kernel/trace/bpf_trace.c: In function '____bpf_seq_printf':
   kernel/trace/bpf_trace.c:476:9: warning: function '____bpf_seq_printf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     476 |         seq_bprintf(m, fmt, data.bin_args);
         |         ^~~~~~~~~~~
--
   In file included from kernel/trace/rv/rv.h:9,
                    from kernel/trace/rv/rv.c:151:
>> kernel/trace/rv/../trace.h:1434:34: error: enumerator value outside the range of underlying type
    1434 | #define C(a, b) TRACE_ITER_##a = (1 << TRACE_ITER_##a##_BIT)
         |                                  ^
   kernel/trace/rv/../trace.h:1369:17: note: in expansion of macro 'C'
    1369 |                 C(PROF_TEXT_OFFSET,     "prof-text-offset"),
         |                 ^
   kernel/trace/rv/../trace.h:1414:17: note: in expansion of macro 'PROFILER_FLAGS'
    1414 |                 PROFILER_FLAGS
         |                 ^~~~~~~~~~~~~~
   kernel/trace/rv/../trace.h:1436:40: note: in expansion of macro 'TRACE_FLAGS'
    1436 | enum trace_iterator_flags : uint64_t { TRACE_FLAGS };
         |                                        ^~~~~~~~~~~


vim +1434 kernel/trace/trace.h

a3418a364ec3c8 Steven Rostedt (Red Hat  2015-09-29  1428) 
a3418a364ec3c8 Steven Rostedt (Red Hat  2015-09-29  1429) /*
a3418a364ec3c8 Steven Rostedt (Red Hat  2015-09-29  1430)  * By redefining C, we can make TRACE_FLAGS a list of masks that
a3418a364ec3c8 Steven Rostedt (Red Hat  2015-09-29  1431)  * use the bits as defined above.
a3418a364ec3c8 Steven Rostedt (Red Hat  2015-09-29  1432)  */
a3418a364ec3c8 Steven Rostedt (Red Hat  2015-09-29  1433) #undef C
a3418a364ec3c8 Steven Rostedt (Red Hat  2015-09-29 @1434) #define C(a, b) TRACE_ITER_##a = (1 << TRACE_ITER_##a##_BIT)
a3418a364ec3c8 Steven Rostedt (Red Hat  2015-09-29  1435) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
