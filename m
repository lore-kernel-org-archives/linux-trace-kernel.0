Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E09E43DA49;
	Wed, 16 Sep 2026 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543665; cv=none; b=hrNgIJAPAdASOBMWVjxAGuxDO/ceGw17JX6ZgHtVNSabhndwpHKalXmznp/JFiXcmZUyQy39fuArTmtDEZiAa4yVd7+V/Eht34iSncF4C+kC/sIH2UXYXZ3GFRjlmdgMR9utoXomWLSbWFLihsLmSHX0Aog5DivtoihHRPPRqZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543665; c=relaxed/simple;
	bh=NlHbsIISrVqqkiOZSbzxcM1TieM8nE/MqIpNBMGixMM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NfQAOwsVBqNEUuO53fmiyYy3hDFg2Ci4psqBFX+k3i8sdgftynnJh1Wc5/jffduJjdt4KUaOoDYSbVFKpVRiWdTVx7aa8f2B/g1X5N5/Plxze/OtqGkGVN1V4bstEC7a8qpfCjlUeRG1Lve6cp47Hu7bH8tqC/GD+iVBtCdPjlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YH5/d1WH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YH5/d1WH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789543653; x=1821079653;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=NlHbsIISrVqqkiOZSbzxcM1TieM8nE/MqIpNBMGixMM=;
  b=YH5/d1WHM4Vegsc5uZ1UGGpOxlSmpNI6FmqhFJBwpZhdPealvUiZa6MS
   9dChZE0R9oXlIwCNCjQUbBvb0T5evV45X9S2rr/b0Gz/380CfswGUMhet
   KNg6nfzlvT62d1oliql6b5UvVDym/WvaIbJAtTGQPDumB4ubWD6zaBhDn
   o6O/gL++9CnbUv2WLfHmQ61aKEwjXbAZb5HON7x7ydQJSE4oqjkLk262r
   Y0XMwaDMCAKJV21sIBYwGOYS0ZiqpEcx3B+Xs3BVZNbZN/YBEbHoJiWvY
   X7Yg60aliNzpwXOmGXwpFaYpwX/WUOW5ZWsceqa+mUnWDeSrKQsu4dYAz
   Q==;
X-CSE-ConnectionGUID: Msmpl3M2SWOZ0vc1G6Fgxg==
X-CSE-MsgGUID: wYo0OVRZS3ClLcPGg0M2FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93786463"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93786463"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 00:27:28 -0700
X-CSE-ConnectionGUID: 5OaAvg2DR9GkL2KbPhQr+g==
X-CSE-MsgGUID: nWKT0oB5TWWLgr2HL4AUSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="303143619"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 00:27:26 -0700
Date: Wed, 16 Sep 2026 15:27:22 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: [linux-next:master] [workqueue]  a4d1cdc435:
 stress-ng.stack.ops_per_sec 18.5% improvement
Message-ID: <202609161514.be6a4fae-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Hello,

kernel test robot noticed a 18.5% improvement of stress-ng.stack.ops_per_sec on:

commit: a4d1cdc4356de4325b0a9c6fb09afa6e121407b5 ("workqueue: Add workqueue_cpu_intensive tracepoint") https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 256 threads 2 sockets Intel(R) Xeon(R) 6768P  CPU @ 2.4GHz (Granite Rapids) with 64G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: stack
	cpufreq_governor: performance

Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260916/202609161514.be6a4fae-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-gnr-2sp4/stack/stress-ng/60s

commit: 
  ab85b68e63 ("workqueue: rename the pwq slot helpers shared with percpu")
  a4d1cdc435 ("workqueue: Add workqueue_cpu_intensive tracepoint")

ab85b68e630e8a4d a4d1cdc4356de4325b0a9c6fb09
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  2.09e+08 ±  2%     +18.4%  2.475e+08        stress-ng.stack.ops
   3493402 ±  2%     +18.5%    4138262        stress-ng.stack.ops_per_sec
     92.39 ±  3%     +17.4%     108.49        stress-ng.time.user_time


Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


