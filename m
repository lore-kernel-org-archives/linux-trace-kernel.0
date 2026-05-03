Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9F323909C;
	Sun,  3 May 2026 03:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777778762; cv=none; b=pTZM2WKKkUH1Y3mvZWVFSVijj+HFBg/LkOms0qyFqT/o10pRFR+A0rPvz6d3d/OZXznMt0+IR5o/qfe/W07Kk83Balv17b/Tz7rUYZJ00+iKo4kicY5BWdduqUAQ2KndRyr9a8YfdMQFQGx4KeB/1r9OIDBIKLRgOB6Lgw1nhq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777778762; c=relaxed/simple;
	bh=j1/kIBcHZUMOudByREv8j4jr2E27O77zrId0Of7mnQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPysYliXEq6dORcLGjhMJU8blSQFnLUhl7JtPNzzmM3lifAFFGgFXYpdGIveMMytuzuIoNPx0u1wG1uPaoB9O2YoF+zSg/5Rw4jPhSL32GT5xUKDDsm98wTmvGuHOZVIKMWETUWULRQpuiO9jo3n7ifijuM+uoXmloJSk/xI3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1ykKIvf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1ykKIvf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777778759; x=1809314759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j1/kIBcHZUMOudByREv8j4jr2E27O77zrId0Of7mnQg=;
  b=e1ykKIvfLEIsINyo7STzAGrK/pDeA+OZhebpD83hPLqRb/4T7Apbb9nA
   YZTwHuIQl7GQrpITKRokuPtsXb9u1s+3PgUPGUvMNsi72pkDm6obBNZ6o
   rIW+jKDNms7RQ/EzarTXWPM4iyB2J+vOVtRiqs8Sj6a1HUUdXZubKujRk
   2GhXL7wZaMO23Kzcpvsa7RATYtV+JSumu48sHYSe9mmpd11a7ZrkvkrDd
   WsauT1SCJbcmqjj3w/ZylWMfBEShhFJzimRhK/gHpb+lWWhfYXec9S4ap
   DKIH2Dq4PhU1lQ7mGp1LiT6ES5L1jk5kZvaugJ344OTl4QcthHLg5GiU4
   Q==;
X-CSE-ConnectionGUID: aaDHLy/ARS+wOu8E01NJOw==
X-CSE-MsgGUID: uWdP7HgyQ+q/9DbOdktXaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="82293743"
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="82293743"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 20:25:59 -0700
X-CSE-ConnectionGUID: oyxP96lmT5unJUI6aquoVg==
X-CSE-MsgGUID: EgBcMGlfSRG4Wrkl1x+AZA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 02 May 2026 20:25:57 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJNSs-0000000025Z-1pHI;
	Sun, 03 May 2026 03:25:54 +0000
Date: Sun, 3 May 2026 11:25:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fprobe: Add unregister_fprobe_sync() for synchronous
 unregistration
Message-ID: <202605031133.LJkoT4xo-lkp@intel.com>
References: <177729179863.401400.6063130067239479972.stgit@mhiramat.tok.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177729179863.401400.6063130067239479972.stgit@mhiramat.tok.corp.google.com>

Hi Masami,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[cannot apply to linus/master v7.1-rc1 next-20260430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/fprobe-Add-unregister_fprobe_sync-for-synchronous-unregistration/20260427-214258
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/177729179863.401400.6063130067239479972.stgit%40mhiramat.tok.corp.google.com
patch subject: [PATCH] fprobe: Add unregister_fprobe_sync() for synchronous unregistration
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260503/202605031133.LJkoT4xo-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260503/202605031133.LJkoT4xo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605031133.LJkoT4xo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/fprobe.c:983:14: error: call to undeclared function 'fprobe_registered'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     983 |         if (!fp || !fprobe_registered(fp))
         |                     ^
>> kernel/trace/fprobe.c:986:8: error: call to undeclared function 'unregister_fprobe_nolock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     986 |         ret = unregister_fprobe_nolock(fp);
         |               ^
   kernel/trace/fprobe.c:986:8: note: did you mean 'unregister_fprobe_sync'?
   kernel/trace/fprobe.c:978:5: note: 'unregister_fprobe_sync' declared here
     978 | int unregister_fprobe_sync(struct fprobe *fp)
         |     ^
     979 | {
     980 |         int ret;
     981 | 
     982 |         guard(mutex)(&fprobe_mutex);
     983 |         if (!fp || !fprobe_registered(fp))
     984 |                 return -EINVAL;
     985 | 
     986 |         ret = unregister_fprobe_nolock(fp);
         |               ~~~~~~~~~~~~~~~~~~~~~~~~
         |               unregister_fprobe_sync
   2 errors generated.


vim +/fprobe_registered +983 kernel/trace/fprobe.c

   967	
   968	/**
   969	 * unregister_fprobe_sync() - Unregister fprobe synchronously with RCU grace period.
   970	 * @fp: A fprobe data structure to be unregistered.
   971	 *
   972	 * Unregister fprobe (and remove ftrace hooks from the function entries) and
   973	 * wait for the RCU grace period to finish. This is useful for preventing
   974	 * the fprobe from being used after it is unregistered.
   975	 *
   976	 * Return 0 if @fp is unregistered successfully, -errno if not.
   977	 */
   978	int unregister_fprobe_sync(struct fprobe *fp)
   979	{
   980		int ret;
   981	
   982		guard(mutex)(&fprobe_mutex);
 > 983		if (!fp || !fprobe_registered(fp))
   984			return -EINVAL;
   985	
 > 986		ret = unregister_fprobe_nolock(fp);
   987		if (ret)
   988			return ret;
   989	
   990		synchronize_rcu();
   991		return 0;
   992	}
   993	EXPORT_SYMBOL_GPL(unregister_fprobe_sync);
   994	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
