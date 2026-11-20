Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197278;
	b=J4mzcu6LJ60zJWSixNBwOCIrBsAKpq5dvj2ECwrociArhJMlw8paw9ujkShHpuWisNWU
	 0IAM00nWEABSFh+i0k3Cv02IsgYoORW6uI8aj6c+orQNxaNAkGugAZjgL9uC7OhzWETSH
	 ClINL2tQVzDIbm5OrUiwb7V8uqxg9/FcOZNnwoRQc7XaEyqeS5JdEM07oDP2juAFBNsWV
	 UMtBd0PC0QmGpBEeZzs/3FZxnPubfwVgbYD15EIWMlVxEtXQDkTeJq25hxapk5y8W2qU2
	 211YQrRHc1/tW6xIARD6g347rYwzqVHYTrSB7a3ruxiZn5lWcSX9tkZbMZmJTZx557Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197278;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zJYbOvY91KIsFbtVsqdtx2I4yfZiliRtmRDVA1HpDNI=;
	b=GLrW196Mv9QyC+pU63voaAwcK1p7f6qq+ey1SXBQoXokeBEoaiVAg50tMKv1BZ2BmrJ4
	 gG0WeUInK45fLz6HOMJcrXZYrUrh8pCwFWiLatY7sHzHuQL8HyF1WgYQMo5xcPThOgIrV
	 zC98dN25ArmRFtbV8sSKLf9XZm5Lj353iOQVkFS3ChLf2tHwqoJAX/6UDnohdEWdvMPJr
	 j412qsYYmZ0HQjSPf4Kp1+FJ+9gU/LZZeXWpWKjihl9iQm5NwqLYFowoFaK+DAJuJLvuA
	 VrZnigXd2MLiMRv6n581h/Q+mYyAhT1HrEDf8hGafWfa4cDhNSiDIFKyCDBaIlTIUbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RPRmuREV;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695E60A5BD3;
	Fri, 20 Nov 2026 17:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B695E60A5BD3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RPRmuREV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795197276; x=1826733276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MhzUD5bZV803OeuyZV7iDMthdkdLhCC2DwWMFAEc6vY=;
  b=RPRmuREVyCC0aMudHJJEMXYQWfW6l70VPOSznGW4zdYbcsDfWFlCw2IV
   BcuV9gZCaiExC3DLrYF/mbY0ERkOI5E3MCmo6ChelshgS9ZZX0EPD0ih0
   lBGdaWX0johTaO6KuGA+2n+n8rWtTVTWG/orvVyY4z1J3uJmJu4ZavwEO
   HBrQXipOe61dKhcRoW/QaunADDrwpueWM6xz35Kkp/Rs6IxLr0LrPy2qp
   0k7hrDfH8FtZnSynj/U74/hJv54bj/Az8F18G6aK7YdL6flIQbvyr7QB2
   If451xQ0n9UtKf2lFQ7uYdFxXPPC24XNWuRMs4P8NHJ1cBYVxM16xytet
   Q==;
X-CSE-ConnectionGUID: T8XHnPYvRIK9BSwlIk/zUw==
X-CSE-MsgGUID: grI6tVfNQdyXykeZ9LcDAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4108983"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4108983"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:54:26 -0800
X-CSE-ConnectionGUID: DTwme7aFTjaO2NxO3GmqLg==
X-CSE-MsgGUID: kChPCmhlS2mI9WBWqjISnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11171067"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2026 09:54:25 -0800
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
Subject: [PATCH v3 11/17] platform/x86/intel/ifs: Track and report scan results on a per-CPU basis
Date: Fri, 20 Nov 2026 10:56:52 -0700
Message-ID: <20261120175658.1147030-12-ehab.ababneh@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120175658.1147030-1-ehab.ababneh@intel.com>
References: <20261120175658.1147030-1-ehab.ababneh@intel.com>
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

From: Jithu Joseph <jithu.joseph@intel.com>

IFS requires invoking the scan simultaneously within a group of CPUs, as
indicated in the MSR_INTEGRITY_CAPABILITIES (bits 20:16). When bit 21 is
set, it indicates that all threads in the groups need to trigger the test
at the same time.

When the tests are run simultaneously, record the test results in a
per-CPU structure. This reduces the need to redundantly repeat the test
for all thread in the same group.

There are several benefits:

 - Reduced power consumption by avoiding multiple scans.

 - Decreased time to complete a scan by 50% or more.

 - These tests could take up to 200ms. Prevents taking these cores out
   of circulation just to repeat tests that have already been conducted.

The cores in a group share a scan engine but each reports its own
result, and they can differ. So when a test is restarted, restart from
the lowest chunk any CPU in the group reached. When the test times out
or stops making progress, mark only the CPUs that did not reach the
last chunk as timed out or partially completed, and keep any error code
a CPU's hardware reported.

The existing status and details files now report the result of the
whole group: status is "pass" only if every CPU in the group passed.
Otherwise it is "fail" if any CPU failed, or "untested" if any CPU was
not fully tested, and details holds the status of the first such CPU.
The new per-CPU files added later in this series show which CPU did not
pass.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Co-developed-by: Ehab Ababneh <ehab.ababneh@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 drivers/platform/x86/intel/ifs/core.c    |  17 ++-
 drivers/platform/x86/intel/ifs/ifs.h     |  12 ++
 drivers/platform/x86/intel/ifs/runtest.c | 174 ++++++++++++++++-------
 3 files changed, 154 insertions(+), 49 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index b9ac04228141..25b7c0f6427e 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -49,6 +49,8 @@ static const struct ifs_test_msrs scan_msrs = {
 	.test_ctrl = MSR_SAF_CTRL,
 };
 
+DEFINE_PER_CPU(struct ifs_test_output, ifs_scan_n);
+
 static struct ifs_device ifs_devices[] = {
 	[IFS_TYPE_SAF] = {
 		.test_caps = &scan_test,
@@ -58,6 +60,9 @@ static struct ifs_device ifs_devices[] = {
 			.minor = MISC_DYNAMIC_MINOR,
 			.groups = plat_ifs_groups,
 		},
+		.rw_data = {
+			.result_ptr = &ifs_scan_n,
+		},
 	},
 	[IFS_TYPE_ARRAY_BIST] = {
 		.test_caps = &array_test,
@@ -86,7 +91,7 @@ static int __init ifs_init(void)
 {
 	const struct x86_cpu_id *m;
 	u64 msrval;
-	int i, ret;
+	int i, ret, cpu;
 
 	m = x86_match_cpu(ifs_cpu_ids);
 	if (!m)
@@ -105,6 +110,16 @@ static int __init ifs_init(void)
 	if (!ifs_pkg_auth)
 		return -ENOMEM;
 
+	/*
+	 * Clear the per-CPU results before misc_register() below makes
+	 * run_test visible to user space, so no test can be running yet.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct ifs_test_output *out = per_cpu_ptr(&ifs_scan_n, cpu);
+
+		memset(out, 0, sizeof(*out));
+	}
+
 	for (i = 0; i < IFS_NUMTESTS; i++) {
 		if (!(msrval & BIT(ifs_devices[i].test_caps->integrity_cap_bit)))
 			continue;
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 62db0a6aa940..acf8d8a7b105 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -130,6 +130,7 @@
  */
 #include <linux/device.h>
 #include <linux/miscdevice.h>
+#include <linux/percpu-defs.h>
 
 #define MSR_ARRAY_BIST				0x00000105
 #define MSR_COPY_SCAN_HASHES			0x000002c2
@@ -290,6 +291,7 @@ struct ifs_test_msrs {
  * @loaded: If a valid test binary has been loaded into the memory
  * @loading_error: Error occurred on another CPU while loading image
  * @valid_chunks: number of chunks which could be validated.
+ * @cpu: The CPU on which the test was triggered
  * @status: it holds simple status pass/fail/untested
  * @scan_details: opaque scan status code from h/w
  * @cur_batch: number indicating the currently loaded test file
@@ -298,6 +300,7 @@ struct ifs_test_msrs {
  * @array_gen: test generation of array test
  * @all_lp_join: all logical processors join test
  * @tid_bit_shift: APIC-ID bits of the logical processors sharing a scan engine
+ * @result_ptr: points to percpu result
  */
 struct ifs_data {
 	cpumask_t	grp_cpumask;
@@ -305,6 +308,7 @@ struct ifs_data {
 	bool	loaded;
 	bool	loading_error;
 	int	valid_chunks;
+	int	cpu;
 	int	status;
 	u64	scan_details;
 	u32	cur_batch;
@@ -313,6 +317,7 @@ struct ifs_data {
 	u32	array_gen;
 	bool	all_lp_join;
 	u8	tid_bit_shift;
+	struct ifs_test_output __percpu *result_ptr;
 };
 
 struct ifs_work {
@@ -327,6 +332,13 @@ struct ifs_device {
 	struct miscdevice misc;
 };
 
+struct ifs_test_output {
+	u64	test_details;
+	int	test_result;
+};
+
+DECLARE_PER_CPU(struct ifs_test_output, ifs_scan_n);
+
 static inline struct ifs_data *ifs_get_data(struct device *dev)
 {
 	struct miscdevice *m = dev_get_drvdata(dev);
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index a67f2b313eb9..9022ec55d0a1 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -29,7 +29,6 @@
 struct run_params {
 	struct ifs_data *ifsd;
 	union ifs_scan *activate;
-	union ifs_status status;
 };
 
 struct run_array_params {
@@ -85,25 +84,21 @@ static void message_not_tested(struct device *dev, int cpu, union ifs_status sta
 	 * been corrupted. Reloading the image may fix this issue.
 	 */
 	if (status.control_error) {
-		dev_warn(dev, "CPU(s) %*pbl: Scan controller error. Batch: %02x version: 0x%x\n",
-			 cpumask_pr_args(cpu_smt_mask(cpu)), ifsd->cur_batch, ifsd->loaded_version);
+		dev_warn(dev, "CPU %d: Scan controller error. Batch: %02x version: 0x%x\n", cpu,
+			 ifsd->cur_batch, ifsd->loaded_version);
 		return;
 	}
 
 	if (status.error_code < ARRAY_SIZE(scan_test_status)) {
-		dev_info(dev, "CPU(s) %*pbl: SCAN operation did not start. %s\n",
-			 cpumask_pr_args(cpu_smt_mask(cpu)),
+		dev_info(dev, "CPU %d: SCAN operation did not start. %s\n", cpu,
 			 scan_test_status[status.error_code]);
 	} else if (status.error_code == IFS_SW_TIMEOUT) {
-		dev_info(dev, "CPU(s) %*pbl: software timeout during scan\n",
-			 cpumask_pr_args(cpu_smt_mask(cpu)));
+		dev_info(dev, "CPU %d: software timeout during scan\n", cpu);
 	} else if (status.error_code == IFS_SW_PARTIAL_COMPLETION) {
-		dev_info(dev, "CPU(s) %*pbl: %s\n",
-			 cpumask_pr_args(cpu_smt_mask(cpu)),
+		dev_info(dev, "CPU %d: %s\n", cpu,
 			 "Not all scan chunks were executed. Maximum forward progress retries exceeded");
 	} else {
-		dev_info(dev, "CPU(s) %*pbl: SCAN unknown status %llx\n",
-			 cpumask_pr_args(cpu_smt_mask(cpu)), status.data);
+		dev_info(dev, "CPU %d: SCAN unknown status %llx\n", cpu, status.data);
 	}
 }
 
@@ -119,8 +114,8 @@ static void message_fail(struct device *dev, int cpu, union ifs_status status)
 	 * the core being tested.
 	 */
 	if (status.signature_error) {
-		dev_err(dev, "CPU(s) %*pbl: test signature incorrect. Batch: %02x version: 0x%x\n",
-			cpumask_pr_args(cpu_smt_mask(cpu)), ifsd->cur_batch, ifsd->loaded_version);
+		dev_err(dev, "CPU %d: test signature incorrect. Batch: %02x version: 0x%x\n",
+			cpu, ifsd->cur_batch, ifsd->loaded_version);
 	}
 }
 
@@ -191,13 +186,14 @@ static void ifs_stop_cpus(struct ifs_data *ifsd, int cpu, cpu_stop_fn_t fn, void
  */
 static int doscan(void *data)
 {
-	int cpu = smp_processor_id(), start, stop;
+	struct ifs_test_output *pcpu_scan;
 	struct run_params *params = data;
 	union ifs_status status;
 	struct ifs_data *ifsd;
-	int first;
+	int start, stop;
 
 	ifsd = params->ifsd;
+	pcpu_scan = this_cpu_ptr(ifsd->result_ptr);
 
 	if (ifsd->generation) {
 		start = params->activate->gen2.start;
@@ -207,9 +203,6 @@ static int doscan(void *data)
 		stop = params->activate->gen0.stop;
 	}
 
-	/* Only the first logical CPU on a core reports result */
-	first = cpumask_first(&ifsd->grp_cpumask);
-
 	wait_for_sibling_cpu(ifsd, &scan_cpus_in, NSEC_PER_SEC);
 
 	/*
@@ -225,13 +218,108 @@ static int doscan(void *data)
 
 	trace_ifs_status(ifsd->cur_batch, start, stop, status.data);
 
-	/* Pass back the result of the scan */
-	if (cpu == first)
-		params->status = status;
+	pcpu_scan->test_details = status.data;
 
 	return 0;
 }
 
+static union ifs_status *get_scan_status(struct ifs_test_output *pcpu_scan)
+{
+	return (union ifs_status *)&pcpu_scan->test_details;
+}
+
+/* Iterate over the per-CPU scan results of all CPUs in the test group */
+#define for_each_group_scan_status(lcpu, ifsd, pcpu_scan, scan_status)		\
+	for ((lcpu) = cpumask_first(&(ifsd)->grp_cpumask);			\
+	     (lcpu) < nr_cpu_ids &&						\
+	     ((pcpu_scan) = per_cpu_ptr((ifsd)->result_ptr, (lcpu)),		\
+	      (scan_status) = get_scan_status(pcpu_scan), true);		\
+	     (lcpu) = cpumask_next((lcpu), &(ifsd)->grp_cpumask))
+
+static bool can_restart_test_group(struct device *dev)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+	struct ifs_test_output *pcpu_scan;
+	union ifs_status *scan_status;
+	int lcpu;
+
+	for_each_group_scan_status(lcpu, ifsd, pcpu_scan, scan_status) {
+		if (!can_restart(*scan_status))
+			return false;
+	}
+	return true;
+}
+
+/*
+ * The cores in a group can stop at different chunks. Return the lowest
+ * chunk reached so that no CPU skips chunks when the test is restarted.
+ */
+static u32 group_min_chunk(struct ifs_data *ifsd)
+{
+	struct ifs_test_output *pcpu_scan;
+	union ifs_status *scan_status;
+	u32 chunk, min_chunk = U32_MAX;
+	int lcpu;
+
+	for_each_group_scan_status(lcpu, ifsd, pcpu_scan, scan_status) {
+		chunk = ifsd->generation ? scan_status->gen2.chunk_num :
+			scan_status->gen0.chunk_num;
+		min_chunk = min(min_chunk, chunk);
+	}
+
+	return min_chunk;
+}
+
+/* Group result precedence: any failure, then any untested CPU, then pass */
+static const int result_rank[] = {
+	[SCAN_TEST_PASS] = 0,
+	[SCAN_NOT_TESTED] = 1,
+	[SCAN_TEST_FAIL] = 2,
+};
+
+/*
+ * Set the result of every CPU in the group. @reason is the software error
+ * code for a CPU that stopped before @stop_chunk without an error code of
+ * its own. The group passes only if all CPUs passed; otherwise ifsd->status
+ * and ifsd->scan_details report the first CPU with the worst result.
+ */
+static void update_group_result(struct device *dev, int stop_chunk, int reason)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+	struct ifs_test_output *pcpu_scan;
+	union ifs_status *scan_status;
+	int lcpu, report_cpu = ifsd->cpu;
+	u32 reached_chunk;
+
+	ifsd->status = SCAN_TEST_PASS;
+
+	for_each_group_scan_status(lcpu, ifsd, pcpu_scan, scan_status) {
+		reached_chunk = ifsd->generation ? scan_status->gen2.chunk_num :
+				scan_status->gen0.chunk_num;
+
+		if (scan_status->signature_error) {
+			pcpu_scan->test_result = SCAN_TEST_FAIL;
+			message_fail(dev, lcpu, *scan_status);
+		} else if (scan_status->control_error || scan_status->error_code ||
+			   reached_chunk <= stop_chunk) {
+			/* E.g. timeout, or another CPU in the group stopped the scan */
+			if (!scan_status->control_error && !scan_status->error_code)
+				scan_status->error_code = reason;
+			pcpu_scan->test_result = SCAN_NOT_TESTED;
+			message_not_tested(dev, lcpu, *scan_status);
+		} else {
+			pcpu_scan->test_result = SCAN_TEST_PASS;
+		}
+
+		if (result_rank[pcpu_scan->test_result] > result_rank[ifsd->status]) {
+			ifsd->status = pcpu_scan->test_result;
+			report_cpu = lcpu;
+		}
+	}
+
+	ifsd->scan_details = per_cpu_ptr(ifsd->result_ptr, report_cpu)->test_details;
+}
+
 /*
  * Use stop_core_cpuslocked() to synchronize writing to MSR_ACTIVATE_SCAN
  * on all threads of the core to be tested. Loop if necessary to complete
@@ -240,16 +328,24 @@ static int doscan(void *data)
  */
 static void ifs_test_core(int cpu, struct device *dev)
 {
-	union ifs_status status = {};
+	int reason = IFS_SW_PARTIAL_COMPLETION;
 	union ifs_scan activate;
 	unsigned long timeout;
 	struct ifs_data *ifsd;
 	int to_start, to_stop;
 	int status_chunk;
 	struct run_params params;
-	int retries;
+	int retries, lcpu;
 
 	ifsd = ifs_get_data(dev);
+	ifsd->cpu = cpu;
+
+	/* Don't let results from a previous test leak into this one */
+	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
+		struct ifs_test_output *out = per_cpu_ptr(ifsd->result_ptr, lcpu);
+
+		memset(out, 0, sizeof(*out));
+	}
 
 	activate.gen0.rsvd = 0;
 	activate.delay = IFS_THREAD_WAIT;
@@ -272,7 +368,7 @@ static void ifs_test_core(int cpu, struct device *dev)
 
 	while (to_start <= to_stop) {
 		if (time_after(jiffies, timeout)) {
-			status.error_code = IFS_SW_TIMEOUT;
+			reason = IFS_SW_TIMEOUT;
 			break;
 		}
 
@@ -280,20 +376,15 @@ static void ifs_test_core(int cpu, struct device *dev)
 		atomic_set(&scan_cpus_in, 0);
 		ifs_stop_cpus(ifsd, cpu, doscan, &params);
 
-		status = params.status;
-
 		/* Some cases can be retried, give up for others */
-		if (!can_restart(status))
+		if (!can_restart_test_group(dev))
 			break;
 
-		status_chunk = ifsd->generation ? status.gen2.chunk_num : status.gen0.chunk_num;
+		status_chunk = group_min_chunk(ifsd);
 		if (status_chunk == to_start) {
 			/* Check for forward progress */
-			if (--retries == 0) {
-				if (status.error_code == IFS_NO_ERROR)
-					status.error_code = IFS_SW_PARTIAL_COMPLETION;
+			if (--retries == 0)
 				break;
-			}
 		} else {
 			retries = MAX_IFS_RETRIES;
 			if (ifsd->generation)
@@ -304,18 +395,7 @@ static void ifs_test_core(int cpu, struct device *dev)
 		}
 	}
 
-	/* Update status for this core */
-	ifsd->scan_details = status.data;
-
-	if (status.signature_error) {
-		ifsd->status = SCAN_TEST_FAIL;
-		message_fail(dev, cpu, status);
-	} else if (status.control_error || status.error_code) {
-		ifsd->status = SCAN_NOT_TESTED;
-		message_not_tested(dev, cpu, status);
-	} else {
-		ifsd->status = SCAN_TEST_PASS;
-	}
+	update_group_result(dev, to_stop, reason);
 }
 
 static int do_array_test(void *data)
@@ -324,7 +404,6 @@ static int do_array_test(void *data)
 	int cpu = smp_processor_id();
 	union ifs_array *command;
 	struct ifs_data *ifsd;
-	int first;
 
 	ifsd = params->ifsd;
 
@@ -334,9 +413,7 @@ static int do_array_test(void *data)
 	/*
 	 * Only one logical CPU on a core needs to trigger the Array test via MSR write.
 	 */
-	first = cpumask_first(&ifsd->grp_cpumask);
-
-	if (cpu == first) {
+	if (cpu == ifsd->cpu) {
 		wrmsrq(MSR_ARRAY_BIST, command->data);
 		/* Pass back the result of the test */
 		rdmsrq(MSR_ARRAY_BIST, command->data);
@@ -354,6 +431,7 @@ static void ifs_array_test_core(int cpu, struct device *dev)
 	unsigned long timeout;
 
 	ifsd = ifs_get_data(dev);
+	ifsd->cpu = cpu;
 	params.ifsd = ifsd;
 
 	command.array_bitmask = ~0U;
-- 
2.43.0

