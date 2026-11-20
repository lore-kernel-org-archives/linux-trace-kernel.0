Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197276;
	b=gD4qGOsRZCo1UGV3m5F+OoJnalhzIXIelSlLDRTuc7T9stpYNEvwDyVKB/hnmi7v41XX
	 wlrn9k8mYbG8+jfTRbfnCpsD3hOAB0ciqeyTzhmV44lJi9VzflDBHBu914//m59I6+gTC
	 KKhosO65d1GqqRvAHBfySOOKRFQK/RikVYn8gYRFvIIPvtIzaY9amzV4jjwuXqEw1GdDO
	 VlNCbUCAPIhKLVhqKND0Hm+4Z4pm/6VD+xGMPb/z7ZWXHVQ141gb8M6ZLlb247mi+hwAq
	 Kmc34qRxBSvXOGGh7niukqljHjCg1DmPJSs8b9rd36A70h18sb/EjeJ4Ic+SqBDFQTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197276;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=R9X1893/3Skruqxo5f1Ry/ssOhOqBbrLcbPE3I4xpyY=;
	b=Ns2v4dYB2+lTsdOL25dBMTvbpGk+SzORHzEHWnUejnVJYbWM/7gq+4vjrTw8L7A4hc0y
	 Y3aTblb4Ywvnr0baxV4bUk1XiUQfePwMuQ+dqLm3v2KWZ14ySqz8+GCx4lflbWVDDCV4+
	 5NHDB2EqsF7XxWvv3fFbyxMicQhY9EXls8hyObSe05nhjwzKWLn6niJ17A8IrlNlVOfOg
	 BwWoBjfTvk+TO8EuYE79Jmj+8XARJJQ6PsNsYSv6fYeN337B4+9NulD6MPVhM6AhZIahb
	 dZqLBzb9DMlmKcc260mA3jFil+JN27UH0bqKhjfNacHsflen8QCLN5EEXbxq7tk3ghQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="T/ufEPJR";
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396A9606A32A;
	Fri, 20 Nov 2026 17:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 396A9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T/ufEPJR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795197274; x=1826733274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fHd2OLpkQ1lToAIPfGE9snYS5jmE7+1ShSsAQqxXoeg=;
  b=T/ufEPJRB/pw8XdUZ/ImxlndF1PMsCTExAMsQHaASkbI+s7i6IFoW92W
   TExCwSBOOyFz2+ZY6hcmC3Sfo3jWUztwCOHb2muGFvHc+0N2FJWU0B2Rm
   eq95oUnUKD5B8e/tgCRAHtUujIdMSXuTjLvFuadd/wCpZUP+yUcCbIVUU
   d3ls301QC3WH74ZTd2NFLQLvjInLG7dpZ+DzOxWj01fQUdCiJukcPoPbU
   uY46DoeULTwnEqarLySz74Bw5rm05YQhHk2+zHrUAsHhbEn9RsjzN4SKc
   xfFOoaNDg/U3scXr6MH4JDmKawTT2iWOfejU9N5mng9cq3l5lJBDp+RiR
   w==;
X-CSE-ConnectionGUID: NRBlKnRCTyK8A9RJq9tMSg==
X-CSE-MsgGUID: mjI05lMVRw6nWU213KI4WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4108962"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4108962"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:54:25 -0800
X-CSE-ConnectionGUID: k2DGFmxOQAijsPvu5O82OA==
X-CSE-MsgGUID: pVWj1jPnRiOqxmLOmOrPUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11171061"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2026 09:54:24 -0800
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
Subject: [PATCH v3 09/17] platform/x86/intel/ifs: Select CPUs from topology_cluster_cpumask() for simultaneous IFS tests
Date: Fri, 20 Nov 2026 10:56:50 -0700
Message-ID: <20261120175658.1147030-10-ehab.ababneh@intel.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jithu Joseph <jithu.joseph@intel.com>

The current intel_ifs driver selects CPUs from cpu_smt_mask() to run
IFS test simultaneously. This approach works well for processors currently
supported by the intel_ifs driver, where threads in a CPU core share the
same SCAN test engine. However, it will not work for new Intel Xeon
processors, such as Diamond Rapids, where multiple CPU cores in a module
share the same SCAN test engine and must run IFS tests simultaneously.

Starting with Granite Rapids (GNR) and later generations, bit[20:16]
(TID_BIT_SHIFT) of MSR_INTEGRITY_CAPABILITIES register [1] contains the
number of bits to shift right on x2APICID to obtain a unique topology ID
for all logical processors that share a SCAN test engine. In theory,
computing a cpumask by this method and using a stop_machine() variant
with an arbitrary cpumask passed in to rendezvous CPUs for simultaneous
IFS tests should work for both cases where threads in a core or CPU
cores in a module share the same SCAN test engine. However, as per
Tony Luck's feedback and the previous discussion [2], a stop_machine()
variant with an arbitrary cpumask is not wanted.

Observations on existing Intel Xeon processors and the upcoming Diamond
Rapids with IFS capability show that the logical processors sharing the
same SCAN test engine are exactly the logical processors sharing the
same L2 cache.

topology_cluster_cpumask() returns the cpumask for CPUs sharing the same
L2 cache. Therefore, select CPUs from topology_cluster_cpumask() to run
IFS tests if simultaneous testing is required.

[1] Vol. 4 "Table 2-56. Additional MSRs Supported by the Intel® Xeon®
    6 P-Core Processors" in the Intel Software Developers' Manual,
    March 2025.

Link: https://lore.kernel.org/all/20220505082824.GD2501@worktop.programming.kicks-ass.net/ [2]
Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h     |  2 +
 drivers/platform/x86/intel/ifs/runtest.c | 59 +++++++++++++++++++-----
 2 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 814ebac10a5d..365429fafe7a 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -285,6 +285,7 @@ struct ifs_test_msrs {
 
 /**
  * struct ifs_data - attributes related to Intel IFS driver
+ * @grp_cpumask: set of CPUs being tested simultaneously
  * @loaded_version: stores the currently loaded ifs image version.
  * @loaded: If a valid test binary has been loaded into the memory
  * @loading_error: Error occurred on another CPU while loading image
@@ -298,6 +299,7 @@ struct ifs_test_msrs {
  * @all_lp_join: all logical processors join test
  */
 struct ifs_data {
+	cpumask_t	grp_cpumask;
 	int	loaded_version;
 	bool	loaded;
 	bool	loading_error;
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index c6a4d6dcccf1..9797e1e6dd51 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -156,11 +156,9 @@ static atomic_t scan_cpus_in;
 /*
  * Simplified CPU sibling rendezvous loop based on microcode loader wait_for_cpus()
  */
-static void wait_for_sibling_cpu(atomic_t *t, long long timeout)
+static void wait_for_sibling_cpu(struct ifs_data *ifsd, atomic_t *t, long long timeout)
 {
-	int cpu = smp_processor_id();
-	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
-	int all_cpus = cpumask_weight(smt_mask);
+	int all_cpus = cpumask_weight(&ifsd->grp_cpumask);
 
 	atomic_inc(t);
 	while (atomic_read(t) < all_cpus) {
@@ -172,6 +170,19 @@ static void wait_for_sibling_cpu(atomic_t *t, long long timeout)
 	}
 }
 
+/*
+ * Run @fn simultaneously on all CPUs that must start the test together with
+ * @cpu: all threads of the cluster if all logical processors must join,
+ * otherwise all threads of the core.
+ */
+static void ifs_stop_cpus(struct ifs_data *ifsd, int cpu, cpu_stop_fn_t fn, void *data)
+{
+	if (ifsd->all_lp_join)
+		stop_cluster_cpuslocked(cpu, fn, data);
+	else
+		stop_core_cpuslocked(cpu, fn, data);
+}
+
 /*
  * Execute the scan. Called "simultaneously" on all threads of a core
  * at high priority using the stop_cpus mechanism.
@@ -195,9 +206,9 @@ static int doscan(void *data)
 	}
 
 	/* Only the first logical CPU on a core reports result */
-	first = cpumask_first(cpu_smt_mask(cpu));
+	first = cpumask_first(&ifsd->grp_cpumask);
 
-	wait_for_sibling_cpu(&scan_cpus_in, NSEC_PER_SEC);
+	wait_for_sibling_cpu(ifsd, &scan_cpus_in, NSEC_PER_SEC);
 
 	/*
 	 * This WRMSR will wait for other HT threads to also write
@@ -265,7 +276,7 @@ static void ifs_test_core(int cpu, struct device *dev)
 
 		params.activate = &activate;
 		atomic_set(&scan_cpus_in, 0);
-		stop_core_cpuslocked(cpu, doscan, &params);
+		ifs_stop_cpus(ifsd, cpu, doscan, &params);
 
 		status = params.status;
 
@@ -310,15 +321,18 @@ static int do_array_test(void *data)
 	struct run_array_params *params = data;
 	int cpu = smp_processor_id();
 	union ifs_array *command;
+	struct ifs_data *ifsd;
 	int first;
 
+	ifsd = params->ifsd;
+
 	command = params->command;
-	wait_for_sibling_cpu(&array_cpus_in, NSEC_PER_SEC);
+	wait_for_sibling_cpu(ifsd, &array_cpus_in, NSEC_PER_SEC);
 
 	/*
 	 * Only one logical CPU on a core needs to trigger the Array test via MSR write.
 	 */
-	first = cpumask_first(cpu_smt_mask(cpu));
+	first = cpumask_first(&ifsd->grp_cpumask);
 
 	if (cpu == first) {
 		wrmsrq(MSR_ARRAY_BIST, command->data);
@@ -350,7 +364,7 @@ static void ifs_array_test_core(int cpu, struct device *dev)
 		}
 		atomic_set(&array_cpus_in, 0);
 		params.command = &command;
-		stop_core_cpuslocked(cpu, do_array_test, &params);
+		ifs_stop_cpus(ifsd, cpu, do_array_test, &params);
 
 		if (command.ctrl_result)
 			break;
@@ -398,6 +412,24 @@ static void ifs_array_test_gen1(int cpu, struct device *dev)
 		ifsd->status = SCAN_TEST_PASS;
 }
 
+static void build_cpugroup_mask(struct device *dev, int cpu)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+
+	cpumask_clear(&ifsd->grp_cpumask);
+
+	/*
+	 * Some CPUs, such as Sierra Forest and Clearwater Forest, have multiple cores
+	 * sharing the same SCAN test engine, but they don't require a rendezvous.
+	 */
+	if (!ifsd->all_lp_join) {
+		cpumask_set_cpu(cpu, &ifsd->grp_cpumask);
+		return;
+	}
+
+	cpumask_copy(&ifsd->grp_cpumask, topology_cluster_cpumask(cpu));
+}
+
 /*
  * Initiate per core test. It wakes up work queue threads on the target CPU and
  * its sibling CPU. Once all sibling threads wake up, the scan test gets executed and
@@ -420,12 +452,15 @@ int do_core_test(int cpu, struct device *dev)
 
 	switch (test->test_num) {
 	case IFS_TYPE_SAF:
-		if (!ifsd->loaded)
+		if (!ifsd->loaded) {
 			ret = -EPERM;
-		else
+		} else {
+			build_cpugroup_mask(dev, cpu);
 			ifs_test_core(cpu, dev);
+		}
 		break;
 	case IFS_TYPE_ARRAY_BIST:
+		build_cpugroup_mask(dev, cpu);
 		if (ifsd->array_gen == ARRAY_GEN0)
 			ifs_array_test_core(cpu, dev);
 		else
-- 
2.43.0

