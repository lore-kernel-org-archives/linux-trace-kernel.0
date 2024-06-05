Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892A128370;
	Wed,  5 Jun 2024 05:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564538; cv=none; b=KOv9li5Z0jqWk3cTlCKb4azkITqwpU4WGgiq3NV6f0Wn3nU3YQrZHnBvpNVTN/Kt1KKkc4pY/Ijc11f0DnY2CDBAhByOD3vG0sUE4vHmkbK6aAIRb68qqVvtlEPIzZ58aHvNeEgJDPI59afMfMyc9ZFR83Oj+1jMeGMS7lSP+j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564538; c=relaxed/simple;
	bh=8yQ6W/oD6gbHM62049CRaNAqHQbwa8dZ8raBK0FrkvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDd2+SzUEj2ANuNM6u/nRAcg+BG+CNKSarft7HmmEyvcQXvwM4uOZ8iL/I66gqvoYkH0Y0445OEJWD7p9Jz7kvSzFyEgmA/bnqSTDit/IJjEAVlLUoTpodNHWbRreXpUJvZ1FKZcjxGz7K8g6DjDP7xiteUFDErzIpoddEQfX8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPfGpBg/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPfGpBg/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717564536; x=1749100536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8yQ6W/oD6gbHM62049CRaNAqHQbwa8dZ8raBK0FrkvA=;
  b=OPfGpBg/CYlSztGL1Z2sDGY29H1kIxLDqUntbn/6Sg4tOaRomHDACm/4
   jAXIg7RtGtP4UzqfLa876sBDltYMogWUXsIfoTBxse08gEVDcA3AJu+3p
   tqo1AMbzjmZbFhoHJyTS3PqHFRyumnfLbWavVmu33cX9/PErXqw7jaiUe
   Z5qETohV1kb5DHfzjVmNVh8DoHhdQXfsLH4zAbySQ/c9zRB2de0V1x6Rz
   xT6uhojQtxlIEOOtzaGN+E/cjM3kxHLu1NJnePgtjSyp21p3TGNTLUmPi
   FfPx7tBY+d+ayUW9CPMr08wh82/QO5yazib4IrttRIPvCcnZbujBzdKV3
   A==;
X-CSE-ConnectionGUID: f8zwwxLGQpunMhlfSFFYTw==
X-CSE-MsgGUID: Mab3GvW6QRaOdcQFS2sYtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14367859"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="14367859"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 22:15:36 -0700
X-CSE-ConnectionGUID: FeJbkbX4ReOZTEkWdyy3VA==
X-CSE-MsgGUID: FL18j427Q6+VPA/k+idD6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="38034183"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 04 Jun 2024 22:15:33 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEizj-0000wl-0H;
	Wed, 05 Jun 2024 05:15:31 +0000
Date: Wed, 5 Jun 2024 13:15:04 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 4/5] ftrace: Convert "filter_hash" and "inc" to bool in
 ftrace_hash_rec_update_modify()
Message-ID: <202406051211.TA5OOyjM-lkp@intel.com>
References: <20240604212855.046127611@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604212855.046127611@goodmis.org>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.10-rc2 next-20240604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/ftrace-Rename-dup_hash-and-comment-it/20240605-053138
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240604212855.046127611%40goodmis.org
patch subject: [PATCH 4/5] ftrace: Convert "filter_hash" and "inc" to bool in ftrace_hash_rec_update_modify()
config: i386-buildonly-randconfig-004-20240605 (https://download.01.org/0day-ci/archive/20240605/202406051211.TA5OOyjM-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406051211.TA5OOyjM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406051211.TA5OOyjM-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> kernel/trace/ftrace.c:1961:13: error: conflicting types for 'ftrace_hash_rec_disable_modify'; have 'void(struct ftrace_ops *, bool)' {aka 'void(struct ftrace_ops *, _Bool)'}
    1961 | static void ftrace_hash_rec_disable_modify(struct ftrace_ops *ops,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:1384:1: note: previous declaration of 'ftrace_hash_rec_disable_modify' with type 'void(struct ftrace_ops *, int)'
    1384 | ftrace_hash_rec_disable_modify(struct ftrace_ops *ops, int filter_hash);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:1967:13: error: conflicting types for 'ftrace_hash_rec_enable_modify'; have 'void(struct ftrace_ops *, bool)' {aka 'void(struct ftrace_ops *, _Bool)'}
    1967 | static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:1386:1: note: previous declaration of 'ftrace_hash_rec_enable_modify' with type 'void(struct ftrace_ops *, int)'
    1386 | ftrace_hash_rec_enable_modify(struct ftrace_ops *ops, int filter_hash);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:1384:1: warning: 'ftrace_hash_rec_disable_modify' used but never defined
    1384 | ftrace_hash_rec_disable_modify(struct ftrace_ops *ops, int filter_hash);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:1386:1: warning: 'ftrace_hash_rec_enable_modify' used but never defined
    1386 | ftrace_hash_rec_enable_modify(struct ftrace_ops *ops, int filter_hash);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:1967:13: warning: 'ftrace_hash_rec_enable_modify' defined but not used [-Wunused-function]
    1967 | static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:1961:13: warning: 'ftrace_hash_rec_disable_modify' defined but not used [-Wunused-function]
    1961 | static void ftrace_hash_rec_disable_modify(struct ftrace_ops *ops,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1961 kernel/trace/ftrace.c

84261912ebee41 Steven Rostedt (Red Hat  2014-08-18  1960) 
84261912ebee41 Steven Rostedt (Red Hat  2014-08-18 @1961) static void ftrace_hash_rec_disable_modify(struct ftrace_ops *ops,
5177364f840058 Steven Rostedt (Google   2024-06-04  1962) 					   bool filter_hash)
84261912ebee41 Steven Rostedt (Red Hat  2014-08-18  1963) {
5177364f840058 Steven Rostedt (Google   2024-06-04  1964) 	ftrace_hash_rec_update_modify(ops, filter_hash, false);
84261912ebee41 Steven Rostedt (Red Hat  2014-08-18  1965) }
84261912ebee41 Steven Rostedt (Red Hat  2014-08-18  1966) 
84261912ebee41 Steven Rostedt (Red Hat  2014-08-18 @1967) static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops,
5177364f840058 Steven Rostedt (Google   2024-06-04  1968) 					  bool filter_hash)
84261912ebee41 Steven Rostedt (Red Hat  2014-08-18  1969) {
5177364f840058 Steven Rostedt (Google   2024-06-04  1970) 	ftrace_hash_rec_update_modify(ops, filter_hash, true);
84261912ebee41 Steven Rostedt (Red Hat  2014-08-18  1971) }
84261912ebee41 Steven Rostedt (Red Hat  2014-08-18  1972) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
