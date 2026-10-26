Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039748;
	b=24k5aEDZvXZfK6dCgqahlL3mQvN9qx+r81avk4hKQMDFxV9O3EtXfdFYjr1Z4nUEwmdz
	 v8lvIagLK+NKiTGMaZ+AMc7YaJV8jzA5Ssq8PrvmdJwBw/nLkHQOUPkg9PFmz6NNzNoXT
	 XjxkreQWM9od4F7jrQw6ETkBGS49wtRSlmgpj3o7QftDYeIGNYS1qmjNPKezc+0Wl1WI2
	 RMpLxWCZt/brDCFvCkWiFLvKjD76UEIcJiU9GqEo0s5zSTLTfJvpcdp6ZIxjo6IHETHPJ
	 kZ7WWiJHeUazUr3NDNDikY+Q0kazAVNIHDN8iLx8nk3yyMLUKCOuyJZzrRl/OsyefTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039748;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LB5z2JOjn1VADg9sk3XC/yZtTaBRa3/Poidd+1UuW30=;
	b=e6y0VkTR8BBrbYvwwwUrrFB6M8j+2W2eZqdzz4NjoLZatNNrJMaM0js6ok1z8kkmbsxk
	 EOFhWavQM/Ul47swvgAmTlB93FYjvKzkL9nrTXbw2vuK7rZDfyNF9Ojzm1dVTNE4dfyeX
	 P+VR57WWuz6L3fUc9ye1gPcdFTCDMPyC0kPeNhYzJYgoD/L5msgGjT6OQaiXZOFCxO8/l
	 bbruIa3uxoxAG12HToA6vYotFNl7gGrVaZbZLxjyw9E24iRaeVnrhyTfbY0cNgq3cjkO8
	 KerlbbgENi/DmwSPd1tzqHSy0LAEnKO8mdK3UVkpAcI/Vhpn1y5Nhe/bphyB1+Z9j3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D+jCOat7;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C8F60A3802;
	Mon, 26 Oct 2026 18:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06C8F60A3802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D+jCOat7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039747; x=1824575747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hk1GTiS7OBxsYsODQfuHL/GFBXqHxr/38LtR19ndVD4=;
  b=D+jCOat7jHKn3hE6hD5i+cBb2ZOoHnNKikrqWn9su5M7T+oswbc6/ePP
   wTIEyPNV5vX6NoRKBRB/VuA/SeDBD6+rl0w422OFqHYeUpMcCWfNIRPjK
   NVEFr46rZa0agDL4HCWAx42Xt8WY5Oq+hnWkLQPnEVJvMDgMCpvgOZKAA
   bXo8Ve93+5x6U6ZChQLIqYddug4XVCVcueNGAr99cxD5GAdKkLWgeouMj
   OiAAfG1BdPJmH0h1UWS4TXQ242HDKipSp2B5xb/c1p7cRASovl8YLNysg
   ClSI2B8VxdxQWEcjm8gXszQdwMRtorg25crusDIQIt1FQm7QJrmw7pM1B
   w==;
X-CSE-ConnectionGUID: rWOR3xMLRwWkulvMzzND9Q==
X-CSE-MsgGUID: qDHSckJiQq67awtH/3tevg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731532"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731532"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:37 -0700
X-CSE-ConnectionGUID: VF8VyLxBSIWKZs8uXXrWjA==
X-CSE-MsgGUID: fP6uW+GrQ3qz2pEa2acUyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293899"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 26 Oct 2026 11:35:37 -0700
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
Subject: [PATCH 11/17] platform/x86/intel/ifs: Track and report scan results on a per-CPU basis
Date: Mon, 26 Oct 2026 11:38:14 -0700
Message-ID: <20261026183820.129459-12-ehab.ababneh@intel.com>
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

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
---
 drivers/platform/x86/intel/ifs/core.c    |  10 +-
 drivers/platform/x86/intel/ifs/ifs.h     |  12 +++
 drivers/platform/x86/intel/ifs/runtest.c | 117 ++++++++++++++++-------
 3 files changed, 105 insertions(+), 34 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index c830a02fe7b3..08a3e519749b 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -51,6 +51,8 @@ static const struct ifs_test_msrs scan_msrs = {
 	.test_ctrl = MSR_SAF_CTRL,
 };
 
+DEFINE_PER_CPU(struct ifs_test_output, ifs_scan_n);
+
 static struct ifs_device ifs_devices[] = {
 	[IFS_TYPE_SAF] = {
 		.test_caps = &scan_test,
@@ -60,6 +62,9 @@ static struct ifs_device ifs_devices[] = {
 			.minor = MISC_DYNAMIC_MINOR,
 			.groups = plat_ifs_groups,
 		},
+		.rw_data = {
+			.result_ptr = &ifs_scan_n,
+		}
 	},
 	[IFS_TYPE_ARRAY_BIST] = {
 		.test_caps = &array_test,
@@ -127,7 +132,7 @@ static int __init ifs_init(void)
 {
 	const struct x86_cpu_id *m;
 	u64 msrval;
-	int i, ret;
+	int i, ret, cpu;
 
 	m = x86_match_cpu(ifs_cpu_ids);
 	if (!m)
@@ -175,6 +180,9 @@ static int __init ifs_init(void)
 		if (ret)
 			goto err_exit;
 	}
+
+	for_each_possible_cpu(cpu)
+		memset(per_cpu_ptr(&ifs_scan_n, cpu), 0, sizeof(struct ifs_test_output));
 	return 0;
 
 err_exit:
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 365429fafe7a..1043378c60e5 100644
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
@@ -297,6 +299,7 @@ struct ifs_test_msrs {
  * @chunk_size: size of a test chunk
  * @array_gen: test generation of array test
  * @all_lp_join: all logical processors join test
+ * @result_ptr: points to percpu result
  */
 struct ifs_data {
 	cpumask_t	grp_cpumask;
@@ -304,6 +307,7 @@ struct ifs_data {
 	bool	loaded;
 	bool	loading_error;
 	int	valid_chunks;
+	int	cpu;
 	int	status;
 	u64	scan_details;
 	u32	cur_batch;
@@ -311,6 +315,7 @@ struct ifs_data {
 	u32	chunk_size;
 	u32	array_gen;
 	bool	all_lp_join;
+	struct ifs_test_output __percpu *result_ptr;
 };
 
 struct ifs_work {
@@ -325,6 +330,13 @@ struct ifs_device {
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
index 09e7a81e9220..6c3d025817e7 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -83,25 +83,21 @@ static void message_not_tested(struct device *dev, int cpu, union ifs_status sta
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
 
@@ -117,8 +113,8 @@ static void message_fail(struct device *dev, int cpu, union ifs_status status)
 	 * the core being tested.
 	 */
 	if (status.signature_error) {
-		dev_err(dev, "CPU(s) %*pbl: test signature incorrect. Batch: %02x version: 0x%x\n",
-			cpumask_pr_args(cpu_smt_mask(cpu)), ifsd->cur_batch, ifsd->loaded_version);
+		dev_err(dev, "CPU %d: test signature incorrect. Batch: %02x version: 0x%x\n",
+			cpu, ifsd->cur_batch, ifsd->loaded_version);
 	}
 }
 
@@ -177,12 +173,13 @@ static void wait_for_sibling_cpu(struct ifs_data *ifsd, atomic_t *t, long long t
 static int doscan(void *data)
 {
 	int cpu = smp_processor_id(), start, stop;
+	struct ifs_test_output *pcpu_scan;
 	struct run_params *params = data;
 	union ifs_status status;
 	struct ifs_data *ifsd;
-	int first;
 
 	ifsd = params->ifsd;
+	pcpu_scan = this_cpu_ptr(ifsd->result_ptr);
 
 	if (ifsd->generation) {
 		start = params->activate->gen2.start;
@@ -192,9 +189,6 @@ static int doscan(void *data)
 		stop = params->activate->gen0.stop;
 	}
 
-	/* Only the first logical CPU on a core reports result */
-	first = cpumask_first(&ifsd->grp_cpumask);
-
 	wait_for_sibling_cpu(ifsd, &scan_cpus_in, NSEC_PER_SEC);
 
 	/*
@@ -211,12 +205,76 @@ static int doscan(void *data)
 	trace_ifs_status(ifsd->cur_batch, start, stop, status.data);
 
 	/* Pass back the result of the scan */
-	if (cpu == first)
+	if (cpu == ifsd->cpu)
 		params->status = status;
 
+	pcpu_scan->test_details = status.data;
+
 	return 0;
 }
 
+#define get_scan_status(stat) ((union ifs_status *)(&((stat)->test_details)))
+
+static void update_group_status(struct device *dev, int reason)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+	struct ifs_test_output *pcpu_scan;
+	union ifs_status *scan_status;
+	int lcpu;
+
+	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
+		pcpu_scan = per_cpu_ptr(ifsd->result_ptr, lcpu);
+		scan_status = get_scan_status(pcpu_scan);
+		scan_status->error_code = reason;
+	}
+}
+
+static bool can_restart_test_group(struct device *dev)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+	struct ifs_test_output *pcpu_scan;
+	union ifs_status *scan_status;
+	int lcpu;
+
+	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
+		pcpu_scan = per_cpu_ptr(ifsd->result_ptr, lcpu);
+		scan_status = get_scan_status(pcpu_scan);
+		if (!can_restart(*scan_status))
+			return false;
+	}
+	return true;
+}
+
+static void update_group_result(struct device *dev, int stop_chunk)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+	struct ifs_test_output *pcpu_scan;
+	union ifs_status *scan_status;
+	u32 reached_chunk;
+	int lcpu;
+
+	for_each_cpu(lcpu, &ifsd->grp_cpumask) {
+		pcpu_scan = per_cpu_ptr(ifsd->result_ptr, lcpu);
+		scan_status = get_scan_status(pcpu_scan);
+		reached_chunk = ifsd->generation ? scan_status->gen2.chunk_num :
+				scan_status->gen0.chunk_num;
+
+		if (scan_status->signature_error) {
+			pcpu_scan->test_result = SCAN_TEST_FAIL;
+			message_fail(dev, lcpu, *scan_status);
+		} else if (scan_status->control_error || scan_status->error_code ||
+			   reached_chunk <= stop_chunk) {
+			pcpu_scan->test_result = SCAN_NOT_TESTED;
+			message_not_tested(dev, lcpu, *scan_status);
+		} else {
+			pcpu_scan->test_result = SCAN_TEST_PASS;
+		}
+
+		if (lcpu == ifsd->cpu)
+			ifsd->status = pcpu_scan->test_result;
+	}
+}
+
 /*
  * Use stop_core_cpuslocked() to synchronize writing to MSR_ACTIVATE_SCAN
  * on all threads of the core to be tested. Loop if necessary to complete
@@ -235,6 +293,7 @@ static void ifs_test_core(int cpu, struct device *dev)
 	int retries;
 
 	ifsd = ifs_get_data(dev);
+	ifsd->cpu = cpu;
 
 	activate.gen0.rsvd = 0;
 	activate.delay = IFS_THREAD_WAIT;
@@ -258,6 +317,7 @@ static void ifs_test_core(int cpu, struct device *dev)
 	while (to_start <= to_stop) {
 		if (time_after(jiffies, timeout)) {
 			status.error_code = IFS_SW_TIMEOUT;
+			update_group_status(dev, IFS_SW_TIMEOUT);
 			break;
 		}
 
@@ -272,15 +332,17 @@ static void ifs_test_core(int cpu, struct device *dev)
 		status = params.status;
 
 		/* Some cases can be retried, give up for others */
-		if (!can_restart(status))
+		if (!can_restart_test_group(dev))
 			break;
 
 		status_chunk = ifsd->generation ? status.gen2.chunk_num : status.gen0.chunk_num;
 		if (status_chunk == to_start) {
 			/* Check for forward progress */
 			if (--retries == 0) {
-				if (status.error_code == IFS_NO_ERROR)
+				if (status.error_code == IFS_NO_ERROR) {
 					status.error_code = IFS_SW_PARTIAL_COMPLETION;
+					update_group_status(dev, IFS_SW_PARTIAL_COMPLETION);
+				}
 				break;
 			}
 		} else {
@@ -295,16 +357,7 @@ static void ifs_test_core(int cpu, struct device *dev)
 
 	/* Update status for this core */
 	ifsd->scan_details = status.data;
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
+	update_group_result(dev, to_stop);
 }
 
 static int do_array_test(void *data)
@@ -313,7 +366,6 @@ static int do_array_test(void *data)
 	int cpu = smp_processor_id();
 	union ifs_array *command;
 	struct ifs_data *ifsd;
-	int first;
 
 	ifsd = params->ifsd;
 
@@ -323,9 +375,7 @@ static int do_array_test(void *data)
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
@@ -343,6 +393,7 @@ static void ifs_array_test_core(int cpu, struct device *dev)
 	unsigned long timeout;
 
 	ifsd = ifs_get_data(dev);
+	ifsd->cpu = cpu;
 	params.ifsd = ifsd;
 
 	command.array_bitmask = ~0U;
-- 
2.43.0

