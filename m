Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039749;
	b=dr5lEbempelTl0CzpNhJh4RmWFOUxie5xzTqySb3B397uElr767oxAOi2sm4HfLrXTFb
	 gO1BuzrvliSCt8rZFo5o5Kk33rJzhRF7ZDqCd4x51OcFwYmTwjl4JV1oDZRq+0A52Mhgb
	 KrjIbDjuVpVlkN+Dz1ldYn6cCAz/HdjVyytKdj9SbCGFOEwekorv1HKs+uO16chJNftP4
	 AjTj6CgIAXkt6qSrsSHvg5260KI3+fxFyUwp6ErClCp4L1aMRUyfbmtrQ467bWApzb5xI
	 Uu7xG/Dqvjabg1KS0nuP2R3Xm927BQYLx22dbStZoySf6IlKbVxDH2fr5J1PZfJLWrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039749;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eAs5vZDXx73edOgOG4NPVpmJ+c14EhkC4FV7ULARZWI=;
	b=rnWLO6BuPZmrCEAt37rzTxxVHlqADuUABxZXuu/GuThDvkivfUSe6DuRfrUoZG2DHtdg
	 l+iwQrFwoZwa//GoRKfCLPg0WwRv9DiLezEuPDzihhSo2gHM/hZCNQtFgdWJPOY0j7HRD
	 PtAjEyEClarln0dcyn/LtFpECtdTpuB2YsiXh3U3OfJJJcc2wgKyVLtCbVMVRFTGPiNy5
	 C+RvHHOk3Lcv4IHaLYZD6aIckHw5LXkd11QCEvdgXWBqPAsNkC1eD8gL4Nj9BGls/2gI6
	 Tu/LElbQmnLPTkrI3PMZuC2CPGfAzS38b6hZloMGxoUDwhTzhMAYfHxgYLFXOqVh2nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NMff88ob;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF760A5BD2;
	Mon, 26 Oct 2026 18:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EDF760A5BD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NMff88ob
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039749; x=1824575749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ikC4Qlj4ZvTMIl4+e308BeDjgeA84T+eaaVkCJnu6sg=;
  b=NMff88obdxnCkOEfzRMFcpOx1XIK6Oz6xQNyV/nkGYCzdRHCACXirDmM
   2FBms8HLrymWngZZnnbkKaUyXBQkPnZahwR8L5XTkIbZNL+Lo2IY1HrC7
   fZPqcfxk4IMvI6vN71ZLp/FiaJ5ooFi6vwZqX8fL5rz9IrSfOE+qK9fEd
   MKwp3l/RQKdL5PLLAoK9MPiVrmieb1usS/aYT9PAA6vJuShiA00S31g2C
   eIYBfuRN/dp4EeIIoiMgPs3sVvmZCWLjY47/MtSVhw/qOi6wS7tfkLCAb
   ttIm7z9WuTXeYapDLWDD9mch3h8XSsLaMHTOaoAzkAp4gWvTsGYYnipA1
   Q==;
X-CSE-ConnectionGUID: 5Y6PvyEiRFG4nyE2EitYGQ==
X-CSE-MsgGUID: /xssWpGbR7OwBaMIhb+dwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731571"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731571"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:38 -0700
X-CSE-ConnectionGUID: pnLmmyuhTOWOLvjhINFJ1g==
X-CSE-MsgGUID: buWCoSRqTVC8mrkdhJPHIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293914"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 26 Oct 2026 11:35:38 -0700
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
Subject: [PATCH 16/17] platform/x86/intel/ifs: Update IFS documentation
Date: Mon, 26 Oct 2026 11:38:19 -0700
Message-ID: <20261026183820.129459-17-ehab.ababneh@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026183820.129459-1-ehab.ababneh@intel.com>
References: <20261026183820.129459-1-ehab.ababneh@intel.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Update the simultaneous IFS testing domain in the IFS documentation from
a core to a group that shares the same SCAN engine, which works for both
the traditional Hyper-Threading (HT) systems and the Dual-Core Module (DCM)
based systems (e.g., Diamond Rapids).

Add documentation for the new sysfs interfaces {status, details,
additional_details, cpus_ran}_list.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h | 64 +++++++++++++++++++---------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 3f11ae08dce1..551202f86cea 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -14,11 +14,11 @@
  * Introduction
  * ------------
  *
- * In Field Scan (IFS) is a hardware feature to run circuit level tests on
- * a CPU core to detect problems that are not caught by parity or ECC checks.
- * Future CPUs will support more than one type of test which will show up
- * with a new platform-device instance-id.
- *
+ * In-Field Scan (IFS) is a hardware feature that runs circuit-level tests on
+ * all CPUs in a group, where all CPUs share the same SCAN test engine to
+ * detect problems that are not caught by parity or ECC checks. Future CPUs
+ * will support more than one type of test, which will show up with a new
+ * platform-device instance-id.
  *
  * IFS Image
  * ---------
@@ -59,19 +59,19 @@
  * Running tests
  * -------------
  *
- * Tests are run by the driver synchronizing execution of all threads on a
- * core and then writing to the ACTIVATE_SCAN MSR on all threads. Instruction
- * execution continues when:
+ * Tests are run by the driver synchronizing execution of all CPUs in a group
+ * that share the same SCAN test engine, then writing to the ACTIVATE_SCAN MSR
+ * on all CPUs. Instruction execution continues when:
  *
  * 1) All tests have completed.
  * 2) Execution was interrupted.
  * 3) A test detected a problem.
  *
- * Note that ALL THREADS ON THE CORE ARE EFFECTIVELY OFFLINE FOR THE
+ * Note that ALL CPUs IN THE GROUP ARE EFFECTIVELY OFFLINE FOR THE
  * DURATION OF THE TEST. This can be up to 200 milliseconds. If the system
- * is running latency sensitive applications that cannot tolerate an
+ * is running latency-sensitive applications that cannot tolerate an
  * interruption of this magnitude, the system administrator must arrange
- * to migrate those applications to other cores before running a core test.
+ * to migrate those applications to other CPUs before running a group test.
  * It may also be necessary to redirect interrupts to other CPUs.
  *
  * In all cases reading the corresponding test's STATUS MSR provides details on what
@@ -81,30 +81,52 @@
  * The IFS driver provides sysfs interfaces via /sys/devices/virtual/misc/intel_ifs_<n>/
  * to control execution:
  *
- * Test a specific core::
+ * Test a specific group::
  *
  *   # echo <CPU#> > /sys/devices/virtual/misc/intel_ifs_<n>/run_test
  *
- * when HT is enabled any of the sibling CPU# can be specified to test
- * its corresponding physical core. Since the tests are per physical core,
- * the result of testing any thread is same. All siblings must be online
- * to run a core test. It is only necessary to test one thread.
+ * Any CPU in the same group that shares the same SCAN test engin can be
+ * specified to test its corresponding group. All CPUs in the same group
+ * must be online to run a group test. It is only necessary to test one
+ * CPU in the group.
  *
- * For e.g. to test core corresponding to CPU5
+ * For e.g. to test a group corresponding to CPU5
  *
  *   # echo 5 > /sys/devices/virtual/misc/intel_ifs_<n>/run_test
  *
- * Results of the last test is provided in /sys::
+ * The result of the last test for the primary CPU in the group is provided in /sys::
  *
  *   $ cat /sys/devices/virtual/misc/intel_ifs_<n>/status
  *   pass
  *
- * Status can be one of pass, fail, untested
+ * Status can be one of pass, fail, untested.
  *
- * Additional details of the last test is provided by the details file::
+ * Additional details of the last test for the primary CPU in the group are provided in /sys::
  *
  *   $ cat /sys/devices/virtual/misc/intel_ifs_<n>/details
- *   0x8081
+ *   0x7f0080
+ *
+ * For intel_ifs_0, there are following additional sysfs files:
+ *
+ * All CPUs in the same group that ran the test are provided in /sys::
+ *
+ *   $ cat /sys/devices/virtual/misc/intel_ifs_0/cpus_ran_list
+ *   5,149
+ *
+ * The results of the last test for all CPUs in the same group are provided in /sys::
+ *
+ *   $ cat /sys/devices/virtual/misc/intel_ifs_0/status_list
+ *   pass pass
+ *
+ * Additional details of the last test for all CPUs in the same group are provided in /sys::
+ *
+ *   $ cat /sys/devices/virtual/misc/intel_ifs_0/details_list
+ *   0x7f0080 0x7f0080
+ *
+ * More additional details of the last test for all CPUs in the same group are provided in /sys::
+ *
+ *   $ cat /sys/devices/virtual/misc/intel_ifs_0/addnl_details_list
+ *   0xc44191a 0xc44191a
  *
  * The details file reports the hex value of the test specific status MSR.
  * Hardware defined error codes are documented in volume 4 of the Intel
-- 
2.43.0

