Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030232;
	b=Wnqf1JdPtFoKPob9VNnT3hcxT5YuNUxIj57i6eztFmjovMqQK8iz2JIsG5EMQS6hGQGg
	 D7cLSIcYDIMck0i5ZCfcsi7a7R3VQMGwnE56vvLpqriYY8MSsEkV/n3zvj9j1s+/Tp+9W
	 SxaqLHBw6Qp53miaqXHUBDnQ8Rdf31bSJkbu++X/7z/mG7OyhcDQwKJ2rxh+FueMUruDv
	 C9A+2xBM9sSOj9WxDwEAQ9SWmSDenGMGVjUGCPDafIxxuiyZ4uaQ73LChmImkeSiA9l2a
	 V08+ciUgMga7lVLmfz6axKhhupFM1SRZqbyn/VEaT2ps3pljx7NyMSsuTl9KgBJm7Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030232;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n4PNeEybZpAW0mC0xqJL3DdhIkHCnBiTLB4/1PvHJhQ=;
	b=yp99HyYTvmyIju26SQnfWJF+o1Kwta3cDgvlJmJbdpmOp1vsRzkOT81unfmEGDGKD3+5
	 A5NRlJ2EBxnIwW+iuFcsP+bVUY6HuWgE2cYXQ0c8WzXjHER4LVA57jdY0HM/EqToGAEuX
	 JeDcFOV6QKuqUMVaTbd982zyQsPtQt+KUTk0g2EyEAVXxh3EVuxtccel9tonMVefW6JQm
	 TwQa2HsUEet6FShbYVGNkJe9aKepz+H+glIZyNK6PY+BoOrBI8CEQ1e5EuF0rXqHy+DCY
	 FR9mZkUtwnIHFzAMtPcUIv++T8ECkFOdJldxcexAl0oarCB2Z2hQ2USX8Ss5JBYjhgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MWwm5eVP;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F96607E70D;
	Wed, 18 Nov 2026 19:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98F96607E70D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MWwm5eVP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795030232; x=1826566232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P6kLXifl5/11T6GIbDHV5075zKSPQDKq9/6zWzb2fSM=;
  b=MWwm5eVPyTgTPu02X9CfghCu/DHVEAQ9ElNUPE2lXsPlG7dGPBcpv2NN
   FGbTHkCLcSP1WxbaqpBFJATUhjYejCfOfPFaRbg57f8Cpn3NINYZyYnLc
   4GZ/LNjVIScJR0i8GuWRmmSrQTtINbDxb0jrTE9sRMk1IdxrUX9Zqx6xT
   mEqvkqgOdPQcDkCUZOH6620dZzCDS9K+yaUnVCDzuuLi6HHs/f+uDlm3J
   mbX7zmKVAwhHiUZCcWDrWX+vCjQLb4WDKA7GoDA6S2nsJPyO7ztToHG+P
   wOozvPUb6p/cZJAzCZ0v3A4u6Q57OBZFwC25kv/1xOuLxuk6n0usmDAJP
   g==;
X-CSE-ConnectionGUID: FkgZfaW0T72rS8uR40OaPw==
X-CSE-MsgGUID: PWTHsgMxSECMXCsBLeU4wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3781330"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3781330"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 11:30:31 -0800
X-CSE-ConnectionGUID: r0whFGCgT4SwQ1qzBMs0mg==
X-CSE-MsgGUID: dnQXkmqkTBGxU10WNAw1Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10468135"
Received: from jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 18 Nov 2026 11:30:31 -0800
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
Subject: [PATCH v2 16/17] platform/x86/intel/ifs: Update IFS documentation
Date: Wed, 18 Nov 2026 12:32:58 -0700
Message-ID: <20261118193259.519568-17-ehab.ababneh@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118193259.519568-1-ehab.ababneh@intel.com>
References: <20261118193259.519568-1-ehab.ababneh@intel.com>
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
addnl_details, cpus_ran}_list.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h | 66 ++++++++++++++++++----------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 10eea2c6b871..46461cc69f94 100644
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
+ * Any CPU in the same group that shares the same SCAN test engine can be
+ * specified to test its corresponding group. Offline CPUs in the group do
+ * not take part in the test; if the test then does not pass, the driver
+ * warns. It is only necessary to test one CPU in the group.
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
@@ -125,7 +147,7 @@
  * uses the subrange feature to restart an interrupted test.
  *
  * 2) Hardware allows for some number of cores to be tested in parallel.
- * The driver does not make use of this, it only tests one core at a time.
+ * The driver does not make use of this, it only tests one group at a time.
  *
  */
 #include <linux/device.h>
-- 
2.43.0

