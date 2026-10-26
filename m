Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039747;
	b=y74u0yTY5dUAgcxGt1U/J7jHvhG7cxJBAZntERw4aalrdhbJ3rfhYdcIoYCEUY3SJ3NS
	 MmVh6qL3AGCnuR1rAljF4lviWIzX2lFTiN64GBHh4jWYow1AfYcfqqqY9IxKW/fN7RwWT
	 LJ+LaKGk5/+kDcUkFbnVvpai/bcEm2O1WzOZ9XBvC8ic4ZuHmFj7Lqeao9CudtzBnEoPp
	 KwWj/RncCRdAeaZ32+JOr/WmoeVQSNVZMgIgpmPukbm5i3dUgA+3o9XPwwZBbFbom0sxP
	 iVAqUnNPWSOPnHCvw/Ijq6xetlrO2G1H2WN99AEILKKRdE4Kx6U24x8f2WIsIyGUtlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039747;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=L2te96Kj19k7Y9DBKsOTkK/OT9lMYyP6GuRONJlt2OM=;
	b=VjwAh37JcoQsNvMIOYmItwTOznxQpjVUxHWYZjQmc4gxW09ADxCLmCT3+n1wkBennB/a
	 5FqjKPQCSwAO8WbquFxHlHRAts6Jr8LpHKhpOYAoWZQEPyz9aZxw4s7tCsQk4H08kEC1E
	 R/OFiiEeDLS5Kac5zV5IQe6gRltv87cNIoniElgSVm3O3lisbjf2UX8TQfCyiCn9fqi1z
	 PZQvvDDPDiBUmABP6EsoeKAOHcnoir0qvMKeyvbOrkYPJ701J8/WmLDBsWb4TWZLACZ7I
	 S63AIRXxiFCrhdBs7vQMPlIyjlZwGsHlBb7WWp1TjI5sQ1L9DHm73C1MxINqGBdn+PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gLe4wJam;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A431E60A2630;
	Mon, 26 Oct 2026 18:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A431E60A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gLe4wJam
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039747; x=1824575747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DYQaoRfmdyDp2DpG4jIIp7t3bjNqKZyLWTDas/W0P58=;
  b=gLe4wJamxgZ9aowoYxQU57ld2uV2zSQlnB8IdCTaL1u8HYYdEAFfD/9h
   xdIrVqj/OEezHwlnLK0onLyGAw1WBikZTLP4Vdubkkokaj+XeksdOc7/c
   66E9VZyJWkkrWVNPlzRR0Uc9ZHLiQ48Z7jkOeYngoVU0R3UATSqQNkNRb
   XZXO+0FKVSd45Lolgyc/2qw0b3FeM5ZMcn6a3iEV6dClS8mpujP0CE6R7
   A3AaC84yFmLCQ7Jts7nmJrfhhI4VH03AIR6ETxTHg/vRYD8GYLnDMX9zB
   CNprv0Ea0KnU5Kmjrn4UAeLy9Qui3NQN6Be/JWaqB+26f2uqtlr+7mozY
   g==;
X-CSE-ConnectionGUID: UL0O5ya1ROW/6mp4UWwOAQ==
X-CSE-MsgGUID: +BNjxTqLSZKwHm0Vv0Arkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731516"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731516"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:37 -0700
X-CSE-ConnectionGUID: hd+8rcTrSa60mslNlcArCA==
X-CSE-MsgGUID: TgD2ZV1fRYmk+N77QP+mnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293896"
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
Subject: [PATCH 10/17] platform/x86/intel/ifs: Validate TID_BIT_SHIFT matches topology_cluster_cpumask()
Date: Mon, 26 Oct 2026 11:38:13 -0700
Message-ID: <20261026183820.129459-11-ehab.ababneh@intel.com>
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

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

The intel_ifs driver assumes logical processors indicated by TID_BIT_SHIFT
[1] that share the same SCAN test engine match topology_cluster_cpumask().
Validate this assumption during driver initialization and fail loading if
it doesn't hold.

[1] Vol. 4 "Table 2-56. Additional MSRs Supported by the Intel® Xeon®
    6 P-Core Processors" in the Intel Software Developers' Manual,
    March 2025.

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
---
 arch/x86/include/asm/msr-index.h      |  1 +
 drivers/platform/x86/intel/ifs/core.c | 48 +++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 554ce662fdf4..e93c76389ca5 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -281,6 +281,7 @@
 #define MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST_BIT	4
 #define MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST		BIT(MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST_BIT)
 #define MSR_INTEGRITY_CAPS_SAF_GEN_MASK			GENMASK_ULL(10, 9)
+#define MSR_INTEGRITY_CAPS_TID_BIT_SHIFT_MASK		GENMASK_ULL(20, 16)
 #define MSR_INTEGRITY_CAPS_ALL_LP_JOIN_BIT		21
 #define MSR_INTEGRITY_CAPS_ALL_LP_JOIN			BIT(MSR_INTEGRITY_CAPS_ALL_LP_JOIN_BIT)
 
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index f2d2caab0479..c830a02fe7b3 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation. */
 
+#define pr_fmt(fmt)  "intel_ifs: " fmt
+
 #include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/kdev_t.h>
@@ -69,6 +71,45 @@ static struct ifs_device ifs_devices[] = {
 	},
 };
 
+/*
+ * Test whether logical processors indicated by TID_BIT_SHIFT that share the
+ * same SCAN test engine match the cpumask from topology_cluster_cpumask().
+ */
+static bool topology_cluster_matched(u32 msrval)
+{
+	u32 dist, shift = FIELD_GET(MSR_INTEGRITY_CAPS_TID_BIT_SHIFT_MASK, msrval);
+	const cpumask_t *cpumask = topology_cluster_cpumask(0);
+	u32 delta, step = 0, first = cpu_data(0).topo.apicid;
+	unsigned int cpu, cpus;
+
+	/* Get the minimal APIC ID step among the CPUs in the same cluster. */
+	for_each_cpu_andnot(cpu, cpumask, cpumask_of(0)) {
+		delta = abs(cpu_data(cpu).topo.apicid - first);
+
+		if (!step) {
+			step = delta;
+			continue;
+		}
+
+		if (step > delta)
+			step = delta;
+	}
+
+	/* A Hyper-Threading (HT) system with HT disabled. */
+	if (!step)
+		step = 2;
+
+	cpus = cpumask_weight(cpumask);
+	dist = step * cpus;
+
+	if (dist != (1 << shift)) {
+		pr_err_once("APICID step %u, group cpus %u, TID_BIT_SHIFT %u\n", step, cpus, shift);
+		return false;
+	}
+
+	return true;
+}
+
 #define IFS_NUMTESTS ARRAY_SIZE(ifs_devices)
 
 static void ifs_cleanup(void)
@@ -122,6 +163,13 @@ static int __init ifs_init(void)
 		 */
 		ifs_devices[i].rw_data.all_lp_join = ifs_devices[i].rw_data.generation ?
 						(msrval & MSR_INTEGRITY_CAPS_ALL_LP_JOIN) : true;
+
+		if (ifs_devices[i].rw_data.all_lp_join && !topology_cluster_matched(msrval)) {
+			pr_err_once("TID_BIT_SHIFT mismatched topology_cluster_cpumask().\n");
+			ret = -EINVAL;
+			goto err_exit;
+		}
+
 		ifs_devices[i].rw_data.array_gen = (u32)m->driver_data;
 		ret = misc_register(&ifs_devices[i].misc);
 		if (ret)
-- 
2.43.0

