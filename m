Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9DE429CD8;
	Thu, 20 Aug 2026 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225204; cv=none; b=sHtW/QRe61FLM8j7uTAF7E+XW5yGwJlp3sKe39rpvuACiNEGDBj9d4YygwiVK+JfMJVLsr+sTuYTSDWWGJxthk0gSG5vRURv3t3IRissbIchnAFHurdJF5eqNkfiylM4tq+LKsbc8FzBQRNapUq14iI6FWoO/FaViwZ3JTEjb/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225204; c=relaxed/simple;
	bh=PUmSV99hYtfvOHmqI3ut+VfA/zR/1i+aLOG4Zq41QpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ihy0IU+hWqFlUdM1pCl8jp/DW4eCxrbyFjGjf4I/Ibno+tq6SI0kX+98bcIuTfCWjf6vqBEilH5XKd36Qsw7uvAyFYpdByeRvTYrg2sobgz4fde9hLvzSlcDHs2JhwELg+Elnr1de981yavea1PLqmvQX/bwBpfgcucKhTNjkBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jg0MfDsT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jg0MfDsT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787225202; x=1818761202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PUmSV99hYtfvOHmqI3ut+VfA/zR/1i+aLOG4Zq41QpE=;
  b=Jg0MfDsTNXeVsgIsgwvtmERlB7zAZDs1e5NfVforayVDaqbwJDvad3yH
   Yjvd+G+i4CP92uopswtj5VwioSrMyTNmXgK7Tddsar1/P3+qxguwx9djI
   l641R1adlxgHorrdnvPYgde788SLKHPw0pgCJdL7WZ3wmzSx5NEsPJL8V
   vTVyVo9I40WWHmcoEc0766T0Uo+YtiE8aqQItkSHBopZWaPxj1X9e00TJ
   6gHJDDdOAVYEs4e+sDRXkJoB0dfVluwGexCWCGA8rKJK9tyJXjzxo1GQj
   Cpql9fSeuE4E3UYj/i1Xqv1ggfQNXf/6JmSOdA3em3Grj/himPdrxLNcr
   Q==;
X-CSE-ConnectionGUID: rVf29uzWTOOXpbtXsKm7tw==
X-CSE-MsgGUID: xmJZk5IjSXOSc3ii+RMfSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="75289076"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="75289076"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 04:26:40 -0700
X-CSE-ConnectionGUID: UxLXTPOBRDOpSJXj4iqylg==
X-CSE-MsgGUID: 83JFPhYiSXqUl0YE2xMRMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="270226535"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 20 Aug 2026 04:26:37 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wx0up-00000000ioh-0FyX;
	Thu, 20 Aug 2026 11:26:35 +0000
Date: Thu, 20 Aug 2026 19:25:45 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Anubhav Shelat <ashelat@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Fuad Tabba <tabba@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v3] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Message-ID: <202608201958.Dlhk7OGz-lkp@intel.com>
References: <20260810160708.3460a2fd@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810160708.3460a2fd@gandalf.local.home>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v7.2]
[also build test WARNING on next-20260819]
[cannot apply to trace/for-next linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracefs-Add-read-only-eventfs-filesystem-at-sys-kernel-events/20260810-160708
base:   v7.2
patch link:    https://lore.kernel.org/r/20260810160708.3460a2fd%40gandalf.local.home
patch subject: [PATCH v3] tracefs: Add read-only eventfs filesystem at /sys/kernel/events
config: x86_64-randconfig-013-20260820 (https://download.01.org/0day-ci/archive/20260820/202608201958.Dlhk7OGz-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608201958.Dlhk7OGz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608201958.Dlhk7OGz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/tracefs/event_inode.c:501 function parameter 'ro' not described in 'lookup_dir_entry'
>> Warning: fs/tracefs/event_inode.c:621 function parameter 'ro' not described in '__eventfs_root_lookup'
>> Warning: fs/tracefs/event_inode.c:621 expecting prototype for eventfs_root_lookup(). Prototype was for __eventfs_root_lookup() instead
>> Warning: fs/tracefs/event_inode.c:977 function parameter 'ei' not described in 'eventfs_create_events_ro_copy'
>> Warning: fs/tracefs/event_inode.c:977 expecting prototype for eventfs_create_events_dir_ro(). Prototype was for eventfs_create_events_ro_copy() instead
>> Warning: fs/tracefs/event_inode.c:501 function parameter 'ro' not described in 'lookup_dir_entry'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
