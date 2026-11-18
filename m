Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030225;
	b=hCRnmll9QaGKiDGUsll6H5DUaUXjVn8kpqxF5BjrSGSFhAL/L/SvVMJMRm1GtUOIyFow
	 7N8+CWi0TN2vDRvpLzSRqlXgwDNjQKA2bvKVKENuG8gqj4n7Eu76avXGWccJwJkYcQSxu
	 REDjSZJQzlFLPg8n4MtUMxR9704d8zKLGaqP7urDIL7r2ksgkZE/q1mNqR2MRcL9cHu3M
	 7zpkPbr1B5p90wzcmf2jKKZHRAuw9xgwB69+MpDHFyHPqBnmx4XoVSiGR3rQ2lrqTG0Ge
	 5+WBornDe/gaBD+3tc4ztHKsgQj9YGZAZiM8qgxZSkUPhyv5rEvghtpGcc7lkuuEp2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030225;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TiKCTQwI498M+zPJy/UReFz64BjTVYGFPlsNBrp4k5s=;
	b=Jpr+R/nEGb1glvI/8pd2SzdeF4zHDw5Q1oIwiHSMsWrqx5DytH51eqUX2uHZFoi2YAve
	 4yemo++LL/D280ZLrmDfLlBfW0XVXipkN5/h7Yx4Yt5fj6DjnsbyUijiSQ/SvK5B46Czd
	 sJKcNYkJDmE8hVPjsNYmojdyFLlyRx41kjplHMzvvqs0QUS7oZs5M4okbKZDxMSA5DBkq
	 r8YvtytILds4GPscu2a6pu4mZoQ7/HHFb2Xtuo/AF/JRcRMGYslngqvYkIVpQgy8j/x0p
	 iKQhjQ4HpXZO5BkHjO3cMnKdR5Uj+ccDEBLjov8OM7lP0k1/0lxk4DjLXcKG/lTzv8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mKz90UKO;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019D0606DD0E;
	Wed, 18 Nov 2026 19:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 019D0606DD0E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mKz90UKO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795030225; x=1826566225;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BJ0fotAq/M8m1ArkEbvyP0Mk3dq+2UrG44ML+IBS0zo=;
  b=mKz90UKOZsvKoJ4EfO34yHAniDoMFGdH9JYjO7Zn0DtJpjzXMyI/7LWP
   +b+grK5ukWQR7/jGQPxuRXrSHfbi153hWyMWIZDaLpn9eI+fz1eGANPCq
   j6EQxgTbqy92LpAiafDsjj/HOVafdhfMEhwMiaeAluiy23r0MyQmmlKhW
   dC17JrH4m31u/BjHOBtkQ+iULnS5fZ2Kpjs3B6UvPdANQAhLhu6VKhfV7
   827kKPG73bw9TTlZRKHi+X6osAeeZISY+tazQeTDc9u3jVv2w/TcRwO1S
   LmTVlARXzWEPpPrayQKUZG3jmkmC+RcAwyQRRrJ8TGb6K9HcRtD7PIiEV
   Q==;
X-CSE-ConnectionGUID: U4ihUUVxRqSPeJy8MdYCXg==
X-CSE-MsgGUID: nPAJv6q9SSezXKLOhQj93w==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3781175"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3781175"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 11:30:24 -0800
X-CSE-ConnectionGUID: p+7tQvU2SD+OhHIXRzPzJg==
X-CSE-MsgGUID: cwEt8V/aTsmViOJfLMHDLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10468060"
Received: from jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 18 Nov 2026 11:30:24 -0800
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
Subject: [PATCH v2 00/17] platform/x86/intel/ifs: Support group-based In-Field Scan and Diamond Rapids
Date: Wed, 18 Nov 2026 12:32:42 -0700
Message-ID: <20261118193259.519568-1-ehab.ababneh@intel.com>
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
   together from topology_cluster_cpumask(), and warn when a group test
   does not pass while some of the logical processors sharing the scan
   engine (per TID_BIT_SHIFT) were not in the group.

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
original authorship and Signed-off-by tags, except patch 10, which I
rewrote for v2 (Qiuxu is credited as co-developer). Where Qiuxu
changed a patch written by someone else, the change is noted in
brackets in the commit message, and I have added my Signed-off-by to
every patch.

Changes in v2:
- Rebased onto v7.4-rc1.
- Tested on Emerald Rapids, Granite Rapids, Clearwater Forest and
  Diamond Rapids (Tested-by: Yi Lai on all patches).
- Patch 9: build the CPU group mask only after the CPU online and image
  loaded checks pass, so a rejected run_test write no longer changes
  the group reported by the *_list files (Sashiko).
- Patch 10: reworked, with a new title (was "Validate TID_BIT_SHIFT
  matches topology_cluster_cpumask()"). The check at driver init is
  gone: it failed driver load on Sapphire Rapids and Emerald Rapids,
  which don't enumerate TID_BIT_SHIFT, when a CPU in the group was
  offline, and on parts that expose only one core per module. Now
  TID_BIT_SHIFT is read at init and, if a test does not pass, the
  driver warns when not all logical processors in the TID_BIT_SHIFT
  range were in the group. The test always runs (Sashiko, suggested by
  Tony Luck). Author changed to me, with Qiuxu as Co-developed-by.
- Patch 11:
  - clear the per-CPU results of the group at the start of each test,
    and clear them in ifs_init() before the devices are registered
    (Sashiko);
  - restart an interrupted test from the lowest chunk reached by any
    CPU in the group (Sashiko);
  - don't overwrite error codes reported by the hardware with the
    driver's timeout or partial-completion code; report a CPU that
    stopped early without an error code as partially completed
    (Sashiko);
  - the patch 10 warning checks the results of all CPUs in the group;
  - commit message: explain that cores in a group can report
    different results.
- Patches 12, 13: read the CPU group mask only once in the *_list show
  functions (Sashiko).
- Patch 16: fix typos; say "group" instead of "core"; use the real
  attribute name addnl_details in the commit message; describe what
  happens with offline CPUs instead of requiring all CPUs in a group
  to be online (Sashiko).

v1: https://lore.kernel.org/all/20261026183820.129459-1-ehab.ababneh@intel.com/

Ehab Ababneh (1):
  platform/x86/intel/ifs: Warn if a group test fails with CPUs missing

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

Qiuxu Zhuo (8):
  platform/x86/intel/ifs: Revert SBAF feature
  platform/x86/intel/ifs: Fix IFS sysfs interfaces in the comments
  platform/x86/intel/ifs: Clarify In-Field Scan MSR bit macro
    definitions
  platform/x86/intel/ifs: Use u64 to define the bits of IFS MSR
    registers
  platform/x86/intel/ifs: Early return on the IFS image hash/chunk error
  stop_machine: Add stop_cluster_cpuslocked() for per-cluster operations
  platform/x86/intel/ifs: Update IFS documentation
  Documentation/ABI: Update IFS ABI doc

Tony Luck (1):
  platform/x86/intel/ifs: Remove limit on number of batch files

 .../ABI/testing/sysfs-platform-intel-ifs      |  33 +-
 arch/x86/include/asm/msr-index.h              |  17 +-
 drivers/platform/x86/intel/ifs/core.c         |  59 ++-
 drivers/platform/x86/intel/ifs/ifs.h          | 229 ++++-----
 drivers/platform/x86/intel/ifs/load.c         |  52 +-
 drivers/platform/x86/intel/ifs/runtest.c      | 450 ++++++++----------
 drivers/platform/x86/intel/ifs/sysfs.c        | 109 ++++-
 include/linux/stop_machine.h                  |  15 +
 include/trace/events/intel_ifs.h              |  27 --
 kernel/stop_machine.c                         |  35 +-
 tools/arch/x86/include/asm/msr-index.h        |  14 +-
 11 files changed, 531 insertions(+), 509 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

