Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A019B5A7;
	Tue, 23 Sep 2025 02:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758594768; cv=none; b=P/rxOjnW28Aa3FgLByhbHhD8ISk/+J8cEzwMj5JMqxIIsfvC3OgbAJKQPt0sJD1f5glMoirAfeaudOhv69pY1PubZr7wNjSURidia2BshsfWkPQgeY6Gnfmu19o7b+VnCgCeH/vpAL5yB03tjp2+kW99tHDwceakbhvidq79W80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758594768; c=relaxed/simple;
	bh=zwnO3DFv/2ZlBbyBC/pvaBb8ZFlTIAr3kzKfA4XIrlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cs4VsX5NvRA00VQxyLHW+hfOCrIfvMb2al0TEtYt3LGzk0I1feYaiKkmWi/mYA2OrbKBf2E/rrZMCYkejNbCp6sfb7cfTpuO+MHW9p7EGYKVOyTtBbQKZKZNNyBJ5JckkK/WSKoU4fNuvUKQ8kBC6fBdZRimZ27aoGoWD1suXW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YodKgCd6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YodKgCd6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758594767; x=1790130767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zwnO3DFv/2ZlBbyBC/pvaBb8ZFlTIAr3kzKfA4XIrlQ=;
  b=YodKgCd6XAlM0ab+7vKZ0vlZMrLivmjZZHy2Ue7RegvXOo5ll2sDP98Z
   Uq4DFS9s+ZXGzQ38ev4/kzHRQPb370UewObyf5TdQLUxx1AQfFpI10Nxv
   lEzvj1MYyFUHcciVmSTN44x0xixYv1P3j2nzGQwrZDlpq2NqlwDjlOWte
   xIk+GIqAiVxEW9k4xiP47E/lEONfSOKIbXL3B04FjLPS2JxcM4/lAs0f3
   Fximarpo4jayOZGIVzp+8K/URiA8St8YsVJWcV02QN++NTsT5PjnwNPap
   X+VcQYNTQyngyKQ6+OGCm8+FJH3NDxLC7BHRQwHYVw6Jc1sXkyPUFKtf9
   A==;
X-CSE-ConnectionGUID: m4+lrco4T1S3fSUMxjMi+A==
X-CSE-MsgGUID: 7oioIr04S8C1ui2jQse/ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64671494"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64671494"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 19:32:46 -0700
X-CSE-ConnectionGUID: NHekpOXvQ9WB3yH0VTJW1Q==
X-CSE-MsgGUID: yLaRGaA2TXCbhciiVv/ImQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="176238466"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 22 Sep 2025 19:32:43 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0spd-0002g5-0q;
	Tue, 23 Sep 2025 02:32:41 +0000
Date: Tue, 23 Sep 2025 10:32:06 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tracing: Add an option to show symbols in
 _text+offset for function profiler
Message-ID: <202509231048.jmYoMkeW-lkp@intel.com>
References: <175854518099.353182.11090224112128363620.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175854518099.353182.11090224112128363620.stgit@devnote2>

Hi Masami,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v6.17-rc7 next-20250922]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-Allow-tracer-to-add-more-than-32-options/20250922-204945
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/175854518099.353182.11090224112128363620.stgit%40devnote2
patch subject: [PATCH v2 2/2] tracing: Add an option to show symbols in _text+offset for function profiler
config: i386-randconfig-014-20250923 (https://download.01.org/0day-ci/archive/20250923/202509231048.jmYoMkeW-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250923/202509231048.jmYoMkeW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509231048.jmYoMkeW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/trace/trace_output.h:6,
                    from kernel/trace/trace_export.c:15:
>> kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_PROF_TEXT_OFFSET' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1358:17: note: in expansion of macro 'C'
    1358 |                 C(PROF_TEXT_OFFSET,     "prof-text-offset")
         |                 ^
   kernel/trace/trace.h:1403:17: note: in expansion of macro 'PROFILER_FLAGS'
    1403 |                 PROFILER_FLAGS
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_STACKTRACE' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1351:17: note: in expansion of macro 'C'
    1351 |                 C(STACKTRACE,           "stacktrace")
         |                 ^
   kernel/trace/trace.h:1401:17: note: in expansion of macro 'STACK_FLAGS'
    1401 |                 STACK_FLAGS                                     \
         |                 ^~~~~~~~~~~
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_FUNC_FORK' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1341:17: note: in expansion of macro 'C'
    1341 |                 C(FUNC_FORK,            "function-fork")
         |                 ^
   kernel/trace/trace.h:1399:17: note: in expansion of macro 'FUNCTION_FLAGS'
    1399 |                 FUNCTION_FLAGS                                  \
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_FUNCTION' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1340:17: note: in expansion of macro 'C'
    1340 |                 C(FUNCTION,             "function-trace")       \
         |                 ^
   kernel/trace/trace.h:1399:17: note: in expansion of macro 'FUNCTION_FLAGS'
    1399 |                 FUNCTION_FLAGS                                  \
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_HASH_PTR' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1398:17: note: in expansion of macro 'C'
    1398 |                 C(HASH_PTR,             "hash-ptr")     /* Print hashed pointer */ \
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_PAUSE_ON_TRACE' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1397:17: note: in expansion of macro 'C'
    1397 |                 C(PAUSE_ON_TRACE,       "pause-on-trace")       \
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_COPY_MARKER' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1396:17: note: in expansion of macro 'C'
    1396 |                 C(COPY_MARKER,          "copy_trace_marker")\
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_TRACE_PRINTK' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1395:17: note: in expansion of macro 'C'
    1395 |                 C(TRACE_PRINTK,         "trace_printk_dest")    \
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_EVENT_FORK' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1394:17: note: in expansion of macro 'C'
    1394 |                 C(EVENT_FORK,           "event-fork")           \
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_MARKERS' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1393:17: note: in expansion of macro 'C'
    1393 |                 C(MARKERS,              "markers")              \
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
--
   In file included from kernel/trace/trace_output.h:6,
                    from kernel/trace/trace_events.c:31:
>> kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_PROF_TEXT_OFFSET' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1358:17: note: in expansion of macro 'C'
    1358 |                 C(PROF_TEXT_OFFSET,     "prof-text-offset")
         |                 ^
   kernel/trace/trace.h:1403:17: note: in expansion of macro 'PROFILER_FLAGS'
    1403 |                 PROFILER_FLAGS
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_STACKTRACE' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1351:17: note: in expansion of macro 'C'
    1351 |                 C(STACKTRACE,           "stacktrace")
         |                 ^
   kernel/trace/trace.h:1401:17: note: in expansion of macro 'STACK_FLAGS'
    1401 |                 STACK_FLAGS                                     \
         |                 ^~~~~~~~~~~
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_FUNC_FORK' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1341:17: note: in expansion of macro 'C'
    1341 |                 C(FUNC_FORK,            "function-fork")
         |                 ^
   kernel/trace/trace.h:1399:17: note: in expansion of macro 'FUNCTION_FLAGS'
    1399 |                 FUNCTION_FLAGS                                  \
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_FUNCTION' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1340:17: note: in expansion of macro 'C'
    1340 |                 C(FUNCTION,             "function-trace")       \
         |                 ^
   kernel/trace/trace.h:1399:17: note: in expansion of macro 'FUNCTION_FLAGS'
    1399 |                 FUNCTION_FLAGS                                  \
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_HASH_PTR' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1398:17: note: in expansion of macro 'C'
    1398 |                 C(HASH_PTR,             "hash-ptr")     /* Print hashed pointer */ \
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_PAUSE_ON_TRACE' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1397:17: note: in expansion of macro 'C'
    1397 |                 C(PAUSE_ON_TRACE,       "pause-on-trace")       \
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_COPY_MARKER' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1396:17: note: in expansion of macro 'C'
    1396 |                 C(COPY_MARKER,          "copy_trace_marker")\
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_TRACE_PRINTK' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1395:17: note: in expansion of macro 'C'
    1395 |                 C(TRACE_PRINTK,         "trace_printk_dest")    \
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_EVENT_FORK' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1394:17: note: in expansion of macro 'C'
    1394 |                 C(EVENT_FORK,           "event-fork")           \
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_MARKERS' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1393:17: note: in expansion of macro 'C'
    1393 |                 C(MARKERS,              "markers")              \
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
--
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
   In file included from kernel/trace/trace_probe.h:31,
                    from kernel/trace/bpf_trace.c:35:
   kernel/trace/trace.h: At top level:
>> kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_PROF_TEXT_OFFSET' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1358:17: note: in expansion of macro 'C'
    1358 |                 C(PROF_TEXT_OFFSET,     "prof-text-offset")
         |                 ^
   kernel/trace/trace.h:1403:17: note: in expansion of macro 'PROFILER_FLAGS'
    1403 |                 PROFILER_FLAGS
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_STACKTRACE' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1351:17: note: in expansion of macro 'C'
    1351 |                 C(STACKTRACE,           "stacktrace")
         |                 ^
   kernel/trace/trace.h:1401:17: note: in expansion of macro 'STACK_FLAGS'
    1401 |                 STACK_FLAGS                                     \
         |                 ^~~~~~~~~~~
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_FUNC_FORK' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1341:17: note: in expansion of macro 'C'
    1341 |                 C(FUNC_FORK,            "function-fork")
         |                 ^
   kernel/trace/trace.h:1399:17: note: in expansion of macro 'FUNCTION_FLAGS'
    1399 |                 FUNCTION_FLAGS                                  \
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_FUNCTION' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1340:17: note: in expansion of macro 'C'
    1340 |                 C(FUNCTION,             "function-trace")       \
         |                 ^
   kernel/trace/trace.h:1399:17: note: in expansion of macro 'FUNCTION_FLAGS'
    1399 |                 FUNCTION_FLAGS                                  \
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_HASH_PTR' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1398:17: note: in expansion of macro 'C'
    1398 |                 C(HASH_PTR,             "hash-ptr")     /* Print hashed pointer */ \
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_PAUSE_ON_TRACE' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1397:17: note: in expansion of macro 'C'
    1397 |                 C(PAUSE_ON_TRACE,       "pause-on-trace")       \
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_COPY_MARKER' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1396:17: note: in expansion of macro 'C'
    1396 |                 C(COPY_MARKER,          "copy_trace_marker")\
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_TRACE_PRINTK' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1395:17: note: in expansion of macro 'C'
    1395 |                 C(TRACE_PRINTK,         "trace_printk_dest")    \
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_EVENT_FORK' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1394:17: note: in expansion of macro 'C'
    1394 |                 C(EVENT_FORK,           "event-fork")           \
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1423:34: warning: 'TRACE_ITER_MARKERS' defined but not used [-Wunused-const-variable=]
    1423 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1393:17: note: in expansion of macro 'C'
    1393 |                 C(MARKERS,              "markers")              \
         |                 ^
   kernel/trace/trace.h:1425:1: note: in expansion of macro 'TRACE_FLAGS'
    1425 | TRACE_FLAGS
..


vim +/TRACE_ITER_PROF_TEXT_OFFSET +1423 kernel/trace/trace.h

a3418a364ec3c8 Steven Rostedt (Red Hat   2015-09-29  1417) 
a3418a364ec3c8 Steven Rostedt (Red Hat   2015-09-29  1418) /*
a3418a364ec3c8 Steven Rostedt (Red Hat   2015-09-29  1419)  * By redefining C, we can make TRACE_FLAGS a list of masks that
a3418a364ec3c8 Steven Rostedt (Red Hat   2015-09-29  1420)  * use the bits as defined above.
a3418a364ec3c8 Steven Rostedt (Red Hat   2015-09-29  1421)  */
a3418a364ec3c8 Steven Rostedt (Red Hat   2015-09-29  1422) #undef C
7e017e0772184c Masami Hiramatsu (Google  2025-09-22 @1423) #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
a3418a364ec3c8 Steven Rostedt (Red Hat   2015-09-29  1424) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
