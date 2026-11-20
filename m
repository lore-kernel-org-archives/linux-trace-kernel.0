Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197264;
	b=E+W+2skO7Ec17riWQGCrZQJ/SPW36LkSzm67Xkq74olpPRUg0gRRX4AkvNsRxC4MAP5k
	 o8Px7xKqlq7FYKIFT34qVlMGO2ZiuHbymN2B51WYcMLznctCo7x35f8p7gnkq9zJhYHju
	 PpN31PPIxVD8cFLnOdwASrrXvlDKTqooWspzKuhWZneCj+X7c4R516i8nYdO8ypP9do3Z
	 qGZgGFnHJ+EECutXRdH0pfzXDkoNa8MYt5w/Q/tSlRihWR26gO5qxqMG/GuRhiQgjAy0V
	 kPw4eJEg5bv75/waXi7pPOfDigGgrlRkTAaWJG3zQ7jCvn3olUzFM7zzPLNQHMtB/pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197264;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4xkWQTw+xMoY6GhpNwmgqDOHwtKjVnG6Rp0fvPI6sLk=;
	b=eUiQso4m2FNs+mWFEvpRR9klVpZicW6wypTQMJNLMQcX+/GJjiyXYodzHwhGy7MDG3AK
	 hnMR+DtxX4D1HqT7aIdp9sCY5yjQIwQoNtWWiP53R2VUe4RyJKq0pikdsRrSwNG3k9XEn
	 a0fvosRFbleWZgN1il7WKNWL3pUC9ZdLFIO/4NZnIIdtKkZOxQjJgwsvInLNDOnAm2AP6
	 aMsEz4W+mWMg2pUlz+u4wNTySiIyZ32hhWjlsVtHSaIaH5PUEfvNqUZ/0WApsjnS9TKeQ
	 BIzrbdIwXEOLnuuvN09NrZksnzoBe9ygJ1VA8IG9Fwtku6qqy3XZZ2k8sUkZVzKRuXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YHqB592E;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A960A261A;
	Fri, 20 Nov 2026 17:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E6A960A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YHqB592E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795197262; x=1826733262;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4Ja7WxlHqtakyGb/EQZBOk98DS3+1ZmUWHSc2CtuaPc=;
  b=YHqB592EGE7b/riEh57fj3C0tziVoH2d3BsPRyeWT6fVuz9A88J7I28a
   ivNaJKmIes3xVvym6lI75AemfJkhy2sSogXDDC39BO2kJWUq8Hh2JKJ6b
   JDIrD5yhfmDmC2+H8zR8pEI2NyTooAo4pIy9fdTtD8ei7b7KwnDwZGSA9
   u12u8hjVr6e8M7xSQALsdMBAAfd2BS+GyDP6SPEIL2bm3RdqaE6G5Aea9
   BxnReUJf1zyKquolMPNfb0xL96Hcca4geZJHEupPOMpCoghLcJX7jEabs
   lSzFWrbKa2RFWIA1n5nBFKvOOQxZK9dy6tL0f0zos8f/EQ+SM1FX+H8mm
   A==;
X-CSE-ConnectionGUID: 7NeuorAkRT2AkyJVGLeaZw==
X-CSE-MsgGUID: EWSult38Ssy0G39xYrpXfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4108869"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4108869"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:54:20 -0800
X-CSE-ConnectionGUID: 7MLhmsNZSYWsDtCosYR54Q==
X-CSE-MsgGUID: mLxeC95sRZK9qVdJhkLs6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11171016"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2026 09:54:20 -0800
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
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 00/17] platform/x86/intel/ifs: Support group-based In-Field Scan and Diamond Rapids
Date: Fri, 20 Nov 2026 10:56:41 -0700
Message-ID: <20261120175658.1147030-1-ehab.ababneh@intel.com>
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
   addnl_details_list). The existing status and details files remain
   and report the result of the whole group: status is "pass" only if
   every CPU in the group passed.

 - Patch 14 adds Diamond Rapids to the CPU match table.

 - Patch 15 removes the 256 limit on the batch file number.

 - Patches 16-17 update the IFS documentation and ABI document.

Most of this series was developed by Jithu Joseph and Qiuxu Zhuo, who
have both since left Intel. I have taken over upstreaming it, so please
send questions and review comments to me. The patches keep their
original authorship and Signed-off-by tags, except patch 10, which I
rewrote for v2 (Qiuxu is credited as co-developer). I have added my
Signed-off-by to every patch.

Thanks to Ilpo Järvinen for taking the time to review v2.

Changes in v3:
- Patch 11: the status and details files now report the result of the
  whole group instead of only the CPU written to run_test: status is
  "pass" only if all CPUs in the group passed, otherwise "fail" if any
  CPU failed or "untested" if any CPU was not fully tested, and details
  are those of the first such CPU. Patches 12, 16 and 17 describe this.
- Patch 11: when a group test times out or stops making progress, a
  CPU that completed all chunks is now reported as passed instead of
  untested; details now always match the per-CPU result (Sashiko).

From Ilpo's review:
- Patches 8, 9, 12, 13, 14, 15: dropped the "[ Qiuxu: ... ]" notes.
  Qiuxu reworded those commit messages while carrying the patches
  internally.
- Patch 7: rewrote the first paragraph of the commit message so that it
  stands on its own and names Diamond Rapids; dropped the extra ':' in
  the stop_cluster_cpuslocked() kernel-doc.
- Patch 9: add an ifs_stop_cpus() helper that picks
  stop_cluster_cpuslocked() or stop_core_cpuslocked(); passive voice in
  the commit message; reference [2] moved to a Link: tag.
- Patch 10: use BIT(); include <linux/bits.h> and <linux/processor.h>;
  braces around the multi-line if.
- Patch 11: trailing comma in the ifs_devices[] initializer; local
  pointer and sizeof(*ptr) in the memset() loops; get_scan_status() is
  now a static function; a for_each_group_scan_status() iterator
  replaces the repeated per-CPU loops. Added my Co-developed-by.
- Patch 12: cpus_ran_list_show() returns sysfs_emit() directly.
- Patches 15, 16, 17: wrap documentation and ABI text to 80 columns.

v2: https://lore.kernel.org/all/20261118193259.519568-1-ehab.ababneh@intel.com/

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

 .../ABI/testing/sysfs-platform-intel-ifs      |  44 +-
 arch/x86/include/asm/msr-index.h              |  17 +-
 drivers/platform/x86/intel/ifs/core.c         |  62 ++-
 drivers/platform/x86/intel/ifs/ifs.h          | 236 ++++-----
 drivers/platform/x86/intel/ifs/load.c         |  52 +-
 drivers/platform/x86/intel/ifs/runtest.c      | 479 ++++++++----------
 drivers/platform/x86/intel/ifs/sysfs.c        | 107 +++-
 include/linux/stop_machine.h                  |  15 +
 include/trace/events/intel_ifs.h              |  27 -
 kernel/stop_machine.c                         |  35 +-
 tools/arch/x86/include/asm/msr-index.h        |  14 +-
 11 files changed, 557 insertions(+), 531 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

