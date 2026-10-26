Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039737;
	b=2fX4IdCkzXFaziSL/qfRp/798p6lohmc1l6Wjw9YO7P8PYkg3nbKN5M/O4xG2bcu7va8
	 9YifmU/REPcVqHUaip8OB4YxMS1X9dINPIHQH4guxFiqJbtW4qYi7ktabQuiIrsfi4WxQ
	 rLaQIG0sGJ7uX0bDePCjLFY3JZ8iSBqFI4INH3VdCS34Mikidg49zMr4s9ouH+/gO2wpz
	 kvbbvydkpF8KxHiEgkeeAlZbBQaDd43gZE0PQ4FUX7MGAVWIBBSqo8hbym+LjH65dZF22
	 oO/m2UsM3lFQfyVfaB7UhgytYLZpIsRmewASYVW4Vyeb+hCoaerfKSv9MLcXSZV/r7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039737;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DutGulekxiyubV8Y4BVhzApq0tJxXeLDnBFDChJe/jQ=;
	b=wcrSNKmLtK+iqmtl61fU22OIu2ZMY9E/jKndZ/ihaVJdpFTV2QkHpidcP5kZa0CceD17
	 Ml2okRe8oM05Q3S5ng1P71VRY+7UEbzN3gZuOhrj6kn+THLDMot7FcfiZ7roY0ciCBDP/
	 o9rcHbApnSmCziIdzkdgcU/NILUdc4YcfGR0jA0EvoUHA7J6fL1SYYI9Apkaz5dnDjAQO
	 tsbfQIm3w/XB2frLi70RX5YU4ihjDmOuVFIfrcSD1fGmKSgmm8ber+/q8hHSkMRnHB9bc
	 8FlCp+MjZ3q4yUIQDN3YdLMBlBGh6Cj3HDLQuyww6FcNpG4ZeGGTjqfMfy1XFzhtXdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m4QFAvMW;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261CC606A31E;
	Mon, 26 Oct 2026 18:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 261CC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m4QFAvMW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039736; x=1824575736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gUOGIIA12IZ2RJQA6xl7ouXGMrXgc47zgb7kK7764bw=;
  b=m4QFAvMWAq6xC6o9p3xvbXcMgfz9XNffAysDtnW+4pG9gRgiQQq7/mTZ
   zFIpIpd/RbJkO/townQdDZ5APMe5vuf5SgMccH4zfgfy3S6GL7hHYw8ef
   4Hb2rpAdh4k6vpbED2WR2SFiMzeqFae7vzcPeLHT0ViTK3hbyrsEOLvQw
   mYOeJs9Q+9/CL4w1tujnRz7reeBSIOuZ4pZvZitHwfOODlYEOaMANdywb
   SfdlYGmKaRl89NiQ5dq6fcIllesVXUPqOFHe2MwTFfipOPYNUiZDBxVR+
   wv41g3ZIv+m3BG8Ak7+kQrnDzAImsf85DNnxHQDDkgroEd/qEyPh9vZ3p
   A==;
X-CSE-ConnectionGUID: oMbkIZdISEWLO2jFUqwEKg==
X-CSE-MsgGUID: Y+kH/li9TZapaba4BCeSGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731429"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731429"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:35 -0700
X-CSE-ConnectionGUID: /Xd8VV+vRWW2EI2Ji/wtKQ==
X-CSE-MsgGUID: VaV0SkrESQ6F432M0KN6cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293857"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 26 Oct 2026 11:35:35 -0700
From: Ehab Ababneh <ehab.ababneh@intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	tony.luck@intel.com
Cc: ashok.raj.linux@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	pengfei.xu@intel.com,
	ravi.v.shankar@intel.com
Subject: [PATCH 00/17] platform/x86/intel/ifs: Support group-based In-Field Scan and Diamond Rapids
Date: Mon, 26 Oct 2026 11:38:03 -0700
Message-ID: <20261026183820.129459-1-ehab.ababneh@intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some Intel Xeon processors, starting with Diamond Rapids (DMR), share
one SCAN test engine between multiple CPU cores in a module (Dual-Core
Module, DCM), instead of only between the threads of a single core. All
logical processors that share an engine must start the In-Field Scan
(IFS) test at the same time. The current driver assumes the sharing
domain is cpu_smt_mask(), which does not hold on these systems. Also,
although the cores in a module are tested together, each core gets its
own result: on a DCM, one core can pass while the other fails.

This series:

 - Patch 1 removes the SBAF test, which is not planned for any CPU and
   whose test images were never published.

 - Patches 2-6 are cleanups and preparatory refactoring (comment fixes,
   clearer MSR bit names, u64 MSR bitfields, early return on image
   errors, a generic Array BIST parameter struct). Patches 2-4 have no
   functional change.

 - Patch 7 adds stop_cluster_cpuslocked(), the cluster-level counterpart
   of stop_core_cpuslocked(), so that all threads of a cluster can
   rendezvous and issue WRMSR at the same time.

 - Patches 8-10 enumerate ALL_LP_JOIN_NEEDED, select the CPUs to test
   together from topology_cluster_cpumask(), and check at driver init
   that TID_BIT_SHIFT matches that mask.

 - Patches 11-13 record per-CPU results for group tests and expose them
   through new sysfs files (status_list, details_list, cpus_ran_list,
   addnl_details_list). The existing status and details files remain,
   but now report the result of the CPU written to run_test rather than
   the first CPU in the group.

 - Patch 14 adds Diamond Rapids to the CPU match table.

 - Patch 15 removes the 256 limit on the batch file number.

 - Patches 16-17 update the IFS documentation and ABI document.

Most of this series was developed by Jithu Joseph and Qiuxu Zhuo, who
have both since left Intel. I have taken over upstreaming it, so please
send questions and review comments to me. The patches keep their
original authorship and Signed-off-by tags. Where Qiuxu changed a patch
written by someone else, the change is noted in brackets in the commit
message, and I have added my Signed-off-by to every patch.

Jithu Joseph (7):
  platform/x86/intel/ifs: Refactor Array BIST function interface
  platform/x86/intel/ifs: Enumerate the bit to determine if CPUs need to
    join for IFS tests
  platform/x86/intel/ifs: Select CPUs from topology_cluster_cpumask()
    for simultaneous IFS tests
  platform/x86/intel/ifs: Track and report scan results on a per-CPU
    basis
  platform/x86/intel/ifs: Add new sysfs interfaces {status, details,
    cpus_ran}_list
  platform/x86/intel/ifs: Add additional details sysfs interface
  platform/x86/intel/ifs: Add Intel Diamond Rapids server support

Qiuxu Zhuo (9):
  platform/x86/intel/ifs: Revert SBAF feature
  platform/x86/intel/ifs: Fix IFS sysfs interfaces in the comments
  platform/x86/intel/ifs: Clarify In-Field Scan MSR bit macro
    definitions
  platform/x86/intel/ifs: Use u64 to define the bits of IFS MSR
    registers
  platform/x86/intel/ifs: Early return on the IFS image hash/chunk error
  stop_machine: Add stop_cluster_cpuslocked() for per-cluster operations
  platform/x86/intel/ifs: Validate TID_BIT_SHIFT matches
    topology_cluster_cpumask()
  platform/x86/intel/ifs: Update IFS documentation
  Documentation/ABI: Update IFS ABI doc

Tony Luck (1):
  platform/x86/intel/ifs: Remove limit on number of batch files

 .../ABI/testing/sysfs-platform-intel-ifs      |  28 +-
 arch/x86/include/asm/msr-index.h              |  17 +-
 drivers/platform/x86/intel/ifs/core.c         |  97 +++--
 drivers/platform/x86/intel/ifs/ifs.h          | 223 +++++-----
 drivers/platform/x86/intel/ifs/load.c         |  52 +--
 drivers/platform/x86/intel/ifs/runtest.c      | 394 ++++++------------
 drivers/platform/x86/intel/ifs/sysfs.c        | 104 ++++-
 include/linux/stop_machine.h                  |  15 +
 include/trace/events/intel_ifs.h              |  27 --
 kernel/stop_machine.c                         |  35 +-
 tools/arch/x86/include/asm/msr-index.h        |  14 +-
 11 files changed, 487 insertions(+), 519 deletions(-)


base-commit: 98f039265e580291d5e76a11b2072541fbb1c393
-- 
2.43.0

