Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039746;
	b=RHcSeNub8j2ovai5C7oKzGKi7ouHsYAg7mbiRbbSLicQ6UMqIAjcqMAzmpOLKeiZ1faF
	 nS+eWfjfEo6TaTBCr5aB+FVN/O3BvqOiPgErWOXyjvIDIg4D0Mny0FULqhBbvBvlTA2jY
	 ZH+IS6SvLcbXnF07UKe5QJEQXrvHQJJCh7g6/HMVDFVWrWlXNpNoa7R5LZC0YflLzhhRm
	 DoTPSt7PfFHJKUWsLdmITa70qSnnEYdI7H5ggO9HJR6MaWF/LAwIo3njdbfBIXiFvOYuR
	 n8Te8GtLkLSQVohORNpJ5xBQWA54Z4stQVZbYrQ4atTGGdT3W+3ndzSev4HHACy+WmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039746;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=8IXIgyLaA+4UqfpivStTKKUXpyrUeLkhuzRJJLKuQgQ=;
	b=KHF/kDNUZ7z1lDDwMpBO+H3BLAw/jOc5nyviwBopKrgSRo+4X6k8eBXEW5jFrhZT2JKW
	 oPBNJLa1keYlfqn0RTUiW2fJ/v5yabfKw/42ZGX5yR78S9jIYFYKRFlEIC3NQH5GyPjGQ
	 SgnOq/cYk8h2/b6jpE3Uv5Oz+yLBljpPNoxMl/M7iDnQfGMUL/n5cbziuh4ts29T9S3mT
	 pq3H3fEtY4zEeCfNQ2vYZfYIroq2ZkOO7aqkbow3s1FcHwmaTR9odGzRY0+RS/bvp9GSe
	 xpnQsjD45XQWXIZUdeK72s7SKkQojrohivpBR0EWiwY0yZN1kTBtbUNO18mKXb0rhjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cf8woerN;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4509C60A2621;
	Mon, 26 Oct 2026 18:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4509C60A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cf8woerN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039746; x=1824575746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gKrWOcsZ05suzYJeyq1XYm0d5VcpS3k0Qdn7J0IezJc=;
  b=cf8woerN39MStiFsjYwr3dHIMKhBqqanMhJwptcZlyVRktqQfCWpET7f
   XD480gMwg6uU4rnh3A/9LicWya0TEMleZkVIJB/vdnhHslkACubx58UMi
   AuuSXE/9aH71kiL+eQkCkXtNRV8ZgWLtx1EJCOIpeS7ILLus7HzeXefWZ
   G7mXNi1Zl+bKnJhiGKl7/S7g3WLWDBFXIX4KwkS62Cb3jnaSl0mlVi6N9
   iv7BNTaIscHhgzPQ+NcwXyTO8nmQJtMevkI5zaeiNXWBwIInXvANfl7hr
   LwdrAlb+FOfUr0tjgWXrqeYwTWRiEuxu/oWhkfmotaqBdjkWYvfbIU3yX
   w==;
X-CSE-ConnectionGUID: EvSfygMaRdGFYFTsUGfE+Q==
X-CSE-MsgGUID: gAUkqxaYRyejRV5S8kkE5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731507"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731507"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:36 -0700
X-CSE-ConnectionGUID: CmwxzSfxTQSxgHI3Gc8SBA==
X-CSE-MsgGUID: Z9FsR875RBeyTuP1lMm7ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293893"
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
Subject: [PATCH 09/17] platform/x86/intel/ifs: Select CPUs from topology_cluster_cpumask() for simultaneous IFS tests
Date: Mon, 26 Oct 2026 11:38:12 -0700
Message-ID: <20261026183820.129459-10-ehab.ababneh@intel.com>
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
Tony Luck's feedback and the previous discussion [2], the Linux community
is not in favor of a stop_machine() variant with an arbitrary cpumask.

Observations on existing Intel Xeon processors and the upcoming Diamond
Rapids with IFS capability show that the logical processors sharing the
same SCAN test engine are exactly the logical processors sharing the
same L2 cache.

topology_cluster_cpumask() returns the cpumask for CPUs sharing the same
L2 cache. Therefore, select CPUs from topology_cluster_cpumask() to run
IFS tests if simultaneous testing is required.

[ Qiuxu: Re-wrote the commit message. ]

[1] Vol. 4 "Table 2-56. Additional MSRs Supported by the Intel® Xeon®
    6 P-Core Processors" in the Intel Software Developers' Manual,
    March 2025.

[2] https://lore.kernel.org/all/20220505082824.GD2501@worktop.programming.kicks-ass.net/

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h     |  2 +
 drivers/platform/x86/intel/ifs/runtest.c | 48 +++++++++++++++++++-----
 2 files changed, 40 insertions(+), 10 deletions(-)

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
index c6a4d6dcccf1..09e7a81e9220 100644
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
@@ -195,9 +193,9 @@ static int doscan(void *data)
 	}
 
 	/* Only the first logical CPU on a core reports result */
-	first = cpumask_first(cpu_smt_mask(cpu));
+	first = cpumask_first(&ifsd->grp_cpumask);
 
-	wait_for_sibling_cpu(&scan_cpus_in, NSEC_PER_SEC);
+	wait_for_sibling_cpu(ifsd, &scan_cpus_in, NSEC_PER_SEC);
 
 	/*
 	 * This WRMSR will wait for other HT threads to also write
@@ -265,7 +263,11 @@ static void ifs_test_core(int cpu, struct device *dev)
 
 		params.activate = &activate;
 		atomic_set(&scan_cpus_in, 0);
-		stop_core_cpuslocked(cpu, doscan, &params);
+
+		if (ifsd->all_lp_join)
+			stop_cluster_cpuslocked(cpu, doscan, &params);
+		else
+			stop_core_cpuslocked(cpu, doscan, &params);
 
 		status = params.status;
 
@@ -310,15 +312,18 @@ static int do_array_test(void *data)
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
@@ -350,7 +355,11 @@ static void ifs_array_test_core(int cpu, struct device *dev)
 		}
 		atomic_set(&array_cpus_in, 0);
 		params.command = &command;
-		stop_core_cpuslocked(cpu, do_array_test, &params);
+
+		if (ifsd->all_lp_join)
+			stop_cluster_cpuslocked(cpu, do_array_test, &params);
+		else
+			stop_core_cpuslocked(cpu, do_array_test, &params);
 
 		if (command.ctrl_result)
 			break;
@@ -398,6 +407,24 @@ static void ifs_array_test_gen1(int cpu, struct device *dev)
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
@@ -411,6 +438,7 @@ int do_core_test(int cpu, struct device *dev)
 
 	/* Prevent CPUs from being taken offline during the scan test */
 	cpus_read_lock();
+	build_cpugroup_mask(dev, cpu);
 
 	if (!cpu_online(cpu)) {
 		dev_info(dev, "cannot test on the offline CPU %d\n", cpu);
-- 
2.43.0

