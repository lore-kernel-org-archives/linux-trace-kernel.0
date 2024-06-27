Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2486EE57D;
	Thu, 27 Jun 2024 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719455869; cv=none; b=VUvraqEd5x0/JwvTBqidpz24KVzrGUEchk+fH0rHKn4Xe+P3DvLMI9v1aWDoywP2pRnnH3BJ9SwYpXNZW2581nr8ah5D2CL/YTI1CMuhFTXRmr/RJpLJ6iFFCHhzsbEzgcheOlyYxo7NmVGecL+Pl6dTrZLZgsx8uVghhcw7HGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719455869; c=relaxed/simple;
	bh=f9ksulllz9Whvoack1P59db8I8PzWveewB4WmQHnQ9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ch7lOZay2yxAZIF7X0qVndIw29THK17ht+d+iO07yXALDz46VATfbNt5kGkdA1biyr3cixr/BOHS+kpspdFzDpVZPKUNLQD2Ri0VoVFlvJ8H+g32jo81WmQXHwSF+lo2U8UDqbjC3ZtUJj+jZOpQaHp6ULHZRJXrpuiTk0lcVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=md6n3YPF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="md6n3YPF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719455868; x=1750991868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f9ksulllz9Whvoack1P59db8I8PzWveewB4WmQHnQ9w=;
  b=md6n3YPFKvBT2fdvpcnugSF2aicC7NFTNnYu+r+1a9zt/BmHRy1xHm7Y
   4/KlDFrkda+ZoHvfvwt4jHWapazsgwv3d+kcATFuawaIm1jnzY04Zta/W
   GVG5OgVY3oGjbqoipaveov4umpVgJq+mWlxg1NTQpKpfJ/B2ok+pEFfir
   Zf61K1tL+qgWEhbDqqEyxPOx1xkXJKey50F6tM2MG8fmuMEGRsx/GBwzW
   4zaYib9I1uYG/CwkKnW6b8HNHHatRorRjpm/Y2Xi+QQvIksm5rdMWCvQM
   0IxhULrtHss8YJaOoHkPXMS2IFz5fb+AZLhW2ThuSwZavRpEnQwYe25QF
   A==;
X-CSE-ConnectionGUID: KekiA+8tQDuLW5nGtTrtdg==
X-CSE-MsgGUID: X1XpzGBaSBKZrqYCE/gwvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27959504"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="27959504"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 19:37:46 -0700
X-CSE-ConnectionGUID: N2zy6o+gQve42Vxja4hs4w==
X-CSE-MsgGUID: cFZu4SJ9RIGY3dpoKXvPig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="44052404"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 19:37:45 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Jithu Joseph <jithu.joseph@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ashok Raj <ashok.raj@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-trace-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Shankar Ravi V <ravi.v.shankar@intel.com>
Subject: [PATCH v1 3/4] platform/x86/intel/ifs: Add SBAF test support
Date: Thu, 27 Jun 2024 02:35:15 +0000
Message-Id: <20240627023516.3783454-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627023516.3783454-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240627023516.3783454-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jithu Joseph <jithu.joseph@intel.com>

In a core, the SBAF test engine is shared between sibling CPUs.

An SBAF test image contains multiple bundles. Each bundle is further
composed of subunits called programs. When a SBAF test (for a particular
core) is triggered by the user, each SBAF bundle from the loaded test
image is executed sequentially on all the threads on the core using
the stop_core_cpuslocked mechanism. Each bundle execution is initiated by
writing to MSR_ACTIVATE_SBAF.

SBAF test bundle execution may be aborted when an interrupt occurs or
if the CPU does not have enough power budget for the test. In these
cases the kernel restarts the test from the aborted bundle. SBAF
execution is not retried if the test fails or if the test makes no
forward progress after 5 retries.

Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h     |  30 +++
 drivers/platform/x86/intel/ifs/runtest.c | 234 +++++++++++++++++++++++
 2 files changed, 264 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 600bb8a1b285..b261be46bce8 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -157,6 +157,8 @@
 #define MSR_SBAF_HASHES_STATUS			0x000002b9
 #define MSR_AUTHENTICATE_AND_COPY_SBAF_CHUNK	0x000002ba
 #define MSR_SBAF_CHUNKS_AUTHENTICATION_STATUS	0x000002bb
+#define MSR_ACTIVATE_SBAF			0x000002bc
+#define MSR_SBAF_STATUS				0x000002bd
 
 #define MSR_COPY_SCAN_HASHES			0x000002c2
 #define MSR_SCAN_HASHES_STATUS			0x000002c3
@@ -283,6 +285,34 @@ union ifs_array {
 	};
 };
 
+/* MSR_ACTIVATE_SBAF bit fields */
+union ifs_sbaf {
+	u64	data;
+	struct {
+		u32	bundle_idx	:9;
+		u32	rsvd1		:5;
+		u32	pgm_idx		:2;
+		u32	rsvd2		:16;
+		u32	delay		:31;
+		u32	sigmce		:1;
+	};
+};
+
+/* MSR_SBAF_STATUS bit fields */
+union ifs_sbaf_status {
+	u64	data;
+	struct {
+		u32	bundle_idx	:9;
+		u32	rsvd1		:5;
+		u32	pgm_idx		:2;
+		u32	rsvd2		:16;
+		u32	error_code	:8;
+		u32	rsvd3		:21;
+		u32	test_fail	:1;
+		u32	sbaf_status	:2;
+	};
+};
+
 /*
  * Driver populated error-codes
  * 0xFD: Test timed out before completing all the chunks.
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 282e4bfe30da..bdb31b2f45b4 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -29,6 +29,13 @@ struct run_params {
 	union ifs_status status;
 };
 
+struct sbaf_run_params {
+	struct ifs_data *ifsd;
+	int *retry_cnt;
+	union ifs_sbaf *activate;
+	union ifs_sbaf_status status;
+};
+
 /*
  * Number of TSC cycles that a logical CPU will wait for the other
  * logical CPU on the core in the WRMSR(ACTIVATE_SCAN).
@@ -146,6 +153,7 @@ static bool can_restart(union ifs_status status)
 #define SPINUNIT 100 /* 100 nsec */
 static atomic_t array_cpus_in;
 static atomic_t scan_cpus_in;
+static atomic_t sbaf_cpus_in;
 
 /*
  * Simplified cpu sibling rendezvous loop based on microcode loader __wait_for_cpus()
@@ -387,6 +395,226 @@ static void ifs_array_test_gen1(int cpu, struct device *dev)
 		ifsd->status = SCAN_TEST_PASS;
 }
 
+#define SBAF_STATUS_PASS			0
+#define SBAF_STATUS_SIGN_FAIL			1
+#define SBAF_STATUS_INTR			2
+#define SBAF_STATUS_TEST_FAIL			3
+
+enum sbaf_status_err_code {
+	IFS_SBAF_NO_ERROR				= 0,
+	IFS_SBAF_OTHER_THREAD_COULD_NOT_JOIN		= 1,
+	IFS_SBAF_INTERRUPTED_BEFORE_RENDEZVOUS		= 2,
+	IFS_SBAF_UNASSIGNED_ERROR_CODE3			= 3,
+	IFS_SBAF_INVALID_BUNDLE_INDEX			= 4,
+	IFS_SBAF_MISMATCH_ARGS_BETWEEN_THREADS		= 5,
+	IFS_SBAF_CORE_NOT_CAPABLE_CURRENTLY		= 6,
+	IFS_SBAF_UNASSIGNED_ERROR_CODE7			= 7,
+	IFS_SBAF_EXCEED_NUMBER_OF_THREADS_CONCURRENT	= 8,
+	IFS_SBAF_INTERRUPTED_DURING_EXECUTION		= 9,
+	IFS_SBAF_INVALID_PROGRAM_INDEX			= 0xA,
+	IFS_SBAF_CORRUPTED_CHUNK			= 0xB,
+	IFS_SBAF_DID_NOT_START				= 0xC,
+};
+
+static const char * const sbaf_test_status[] = {
+	[IFS_SBAF_NO_ERROR] = "SBAF no error",
+	[IFS_SBAF_OTHER_THREAD_COULD_NOT_JOIN] = "Other thread could not join.",
+	[IFS_SBAF_INTERRUPTED_BEFORE_RENDEZVOUS] = "Interrupt occurred prior to SBAF coordination.",
+	[IFS_SBAF_UNASSIGNED_ERROR_CODE3] = "Unassigned error code 0x3",
+	[IFS_SBAF_INVALID_BUNDLE_INDEX] = "Non valid sbaf bundles. Reload test image",
+	[IFS_SBAF_MISMATCH_ARGS_BETWEEN_THREADS] = "Mismatch in arguments between threads T0/T1.",
+	[IFS_SBAF_CORE_NOT_CAPABLE_CURRENTLY] = "Core not capable of performing SBAF currently",
+	[IFS_SBAF_UNASSIGNED_ERROR_CODE7] = "Unassigned error code 0x7",
+	[IFS_SBAF_EXCEED_NUMBER_OF_THREADS_CONCURRENT] = "Exceeded number of Logical Processors (LP) allowed to run Scan-At-Field concurrently",
+	[IFS_SBAF_INTERRUPTED_DURING_EXECUTION] = "Interrupt occurred prior to SBAF start",
+	[IFS_SBAF_INVALID_PROGRAM_INDEX] = "SBAF program index not valid",
+	[IFS_SBAF_CORRUPTED_CHUNK] = "SBAF operation aborted due to corrupted chunk",
+	[IFS_SBAF_DID_NOT_START] = "SBAF operation did not start",
+};
+
+static void sbaf_message_not_tested(struct device *dev, int cpu, u64 status_data)
+{
+	union ifs_sbaf_status status = (union ifs_sbaf_status)status_data;
+
+	if (status.error_code < ARRAY_SIZE(sbaf_test_status)) {
+		dev_info(dev, "CPU(s) %*pbl: SBAF operation did not start. %s\n",
+			 cpumask_pr_args(cpu_smt_mask(cpu)),
+			 sbaf_test_status[status.error_code]);
+	} else if (status.error_code == IFS_SW_TIMEOUT) {
+		dev_info(dev, "CPU(s) %*pbl: software timeout during scan\n",
+			 cpumask_pr_args(cpu_smt_mask(cpu)));
+	} else if (status.error_code == IFS_SW_PARTIAL_COMPLETION) {
+		dev_info(dev, "CPU(s) %*pbl: %s\n",
+			 cpumask_pr_args(cpu_smt_mask(cpu)),
+			 "Not all SBAF bundles executed. Maximum forward progress retries exceeded");
+	} else {
+		dev_info(dev, "CPU(s) %*pbl: SBAF unknown status %llx\n",
+			 cpumask_pr_args(cpu_smt_mask(cpu)), status.data);
+	}
+}
+
+static void sbaf_message_fail(struct device *dev, int cpu, union ifs_sbaf_status status)
+{
+	/* Failed signature check is set when SBAF signature did not match the expected value */
+	if (status.sbaf_status == SBAF_STATUS_SIGN_FAIL) {
+		dev_err(dev, "CPU(s) %*pbl: Failed signature check\n",
+			cpumask_pr_args(cpu_smt_mask(cpu)));
+	}
+
+	/* Failed to reach end of test */
+	if (status.sbaf_status == SBAF_STATUS_TEST_FAIL) {
+		dev_err(dev, "CPU(s) %*pbl: Failed to complete test\n",
+			cpumask_pr_args(cpu_smt_mask(cpu)));
+	}
+}
+
+static bool sbaf_bundle_completed(union ifs_sbaf_status status)
+{
+	if (status.sbaf_status || status.error_code)
+		return false;
+	return true;
+}
+
+static bool sbaf_can_restart(union ifs_sbaf_status status)
+{
+	enum sbaf_status_err_code err_code = status.error_code;
+
+	/* Signature for chunk is bad, or scan test failed */
+	if (status.sbaf_status == SBAF_STATUS_SIGN_FAIL ||
+	    status.sbaf_status == SBAF_STATUS_TEST_FAIL)
+		return false;
+
+	switch (err_code) {
+	case IFS_SBAF_NO_ERROR:
+	case IFS_SBAF_OTHER_THREAD_COULD_NOT_JOIN:
+	case IFS_SBAF_INTERRUPTED_BEFORE_RENDEZVOUS:
+	case IFS_SBAF_EXCEED_NUMBER_OF_THREADS_CONCURRENT:
+	case IFS_SBAF_INTERRUPTED_DURING_EXECUTION:
+		return true;
+	case IFS_SBAF_UNASSIGNED_ERROR_CODE3:
+	case IFS_SBAF_INVALID_BUNDLE_INDEX:
+	case IFS_SBAF_MISMATCH_ARGS_BETWEEN_THREADS:
+	case IFS_SBAF_CORE_NOT_CAPABLE_CURRENTLY:
+	case IFS_SBAF_UNASSIGNED_ERROR_CODE7:
+	case IFS_SBAF_INVALID_PROGRAM_INDEX:
+	case IFS_SBAF_CORRUPTED_CHUNK:
+	case IFS_SBAF_DID_NOT_START:
+		break;
+	}
+	return false;
+}
+
+/*
+ * Execute the SBAF test. Called "simultaneously" on all threads of a core
+ * at high priority using the stop_cpus mechanism.
+ */
+static int dosbaf(void *data)
+{
+	struct sbaf_run_params *run_params = data;
+	int cpu = smp_processor_id();
+	union ifs_sbaf_status status;
+	struct ifs_data *ifsd;
+	int first;
+
+	ifsd = run_params->ifsd;
+
+	/* Only the first logical CPU on a core reports result */
+	first = cpumask_first(cpu_smt_mask(cpu));
+	wait_for_sibling_cpu(&sbaf_cpus_in, NSEC_PER_SEC);
+
+	/*
+	 * This WRMSR will wait for other HT threads to also write
+	 * to this MSR (at most for activate.delay cycles). Then it
+	 * starts scan of each requested bundle. The core test happens
+	 * during the "execution" of the WRMSR.
+	 */
+	wrmsrl(MSR_ACTIVATE_SBAF, run_params->activate->data);
+	rdmsrl(MSR_SBAF_STATUS, status.data);
+
+	/* Pass back the result of the test */
+	if (cpu == first)
+		run_params->status = status;
+
+	return 0;
+}
+
+static void ifs_sbaf_test_core(int cpu, struct device *dev)
+{
+	struct sbaf_run_params run_params;
+	union ifs_sbaf_status status;
+	union ifs_sbaf activate;
+	unsigned long timeout;
+	struct ifs_data *ifsd;
+	int stop_bundle;
+	int retries;
+
+	ifsd = ifs_get_data(dev);
+
+	activate.data = 0;
+	activate.delay = IFS_THREAD_WAIT;
+
+	timeout = jiffies + (2 * HZ);
+	retries = MAX_IFS_RETRIES;
+	activate.bundle_idx = 0;
+	stop_bundle = ifsd->max_bundle;
+
+	while (activate.bundle_idx <= stop_bundle) {
+		if (time_after(jiffies, timeout)) {
+			status.error_code = IFS_SW_TIMEOUT;
+			break;
+		}
+
+		atomic_set(&sbaf_cpus_in, 0);
+
+		run_params.ifsd = ifsd;
+		run_params.activate = &activate;
+		run_params.retry_cnt = &retries;
+		stop_core_cpuslocked(cpu, dosbaf, &run_params);
+
+		status = run_params.status;
+
+		if (sbaf_bundle_completed(status)) {
+			activate.bundle_idx = status.bundle_idx + 1;
+			activate.pgm_idx = 0;
+			retries = MAX_IFS_RETRIES;
+			continue;
+		}
+
+		/* Some cases can be retried, give up for others */
+		if (!sbaf_can_restart(status))
+			break;
+
+		if (status.pgm_idx == activate.pgm_idx) {
+			/* If no progress retry */
+			if (--retries == 0) {
+				if (status.error_code == IFS_NO_ERROR)
+					status.error_code = IFS_SW_PARTIAL_COMPLETION;
+				break;
+			}
+		} else {
+			/* if some progress, more pgms remaining in bundle, reset retries */
+			retries = MAX_IFS_RETRIES;
+			activate.bundle_idx = status.bundle_idx;
+			activate.pgm_idx = status.pgm_idx;
+		}
+	}
+
+	/* Update status for this core */
+	ifsd->scan_details = status.data;
+
+	if (status.sbaf_status == SBAF_STATUS_SIGN_FAIL ||
+	    status.sbaf_status == SBAF_STATUS_TEST_FAIL) {
+		ifsd->status = SCAN_TEST_FAIL;
+		sbaf_message_fail(dev, cpu, status);
+	} else if (status.error_code || status.sbaf_status == SBAF_STATUS_INTR ||
+		   (activate.bundle_idx < stop_bundle)) {
+		ifsd->status = SCAN_NOT_TESTED;
+		sbaf_message_not_tested(dev, cpu, status.data);
+	} else {
+		ifsd->status = SCAN_TEST_PASS;
+	}
+}
+
 /*
  * Initiate per core test. It wakes up work queue threads on the target cpu and
  * its sibling cpu. Once all sibling threads wake up, the scan test gets executed and
@@ -420,6 +648,12 @@ int do_core_test(int cpu, struct device *dev)
 		else
 			ifs_array_test_gen1(cpu, dev);
 		break;
+	case IFS_TYPE_SBAF:
+		if (!ifsd->loaded)
+			ret = -EPERM;
+		else
+			ifs_sbaf_test_core(cpu, dev);
+		break;
 	default:
 		ret = -EINVAL;
 	}
-- 
2.25.1

