Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030230;
	b=HEp9JJVPocRv151fBnsKyRDJNwcCk18Y9luGOtLl+UUBl/GAVJY4w0Q2yYlx+3wn94+B
	 40NOYS4fVPISesWOtkC7U+KVaW/K6SPoZ2DBkJWC0ONFhHbxFykTkHBAd++jHSaul0SBg
	 aNqy+laYi77bZdbqh40eNbOnmDg6jPjRvj+p5iX0YC4fIqnfMePMOjWBhS0BMUrvCck39
	 TZ+puNH0F+cAIJ3U47u0NP6pgM+zYa8G9nJkWN4VvJi+0fS8vsHLriz0ihOd7Nnrj24w6
	 7W/QSJ3i8EQjYVvRx8FtNIy+Hz8rSdeyYGBXzXgu5a6Sp7vEzt0UdALMkPOODyAipEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030230;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=kmTAt9OKjoemkh6YcekBimjkSsIq2zO5OkQrWIvESds=;
	b=3gZL9nqZq+ylH3eMTa2QLEs79HkTo1Xm5+gnqrq3I8cMYZc96LQYuTJvHqiikI3mnpvF
	 XvU92PiiH9AqJUb2T4slxhQNExIgwiRVg3rwRhtt2ASSmC/qIFrvjfyTKeUch2IondF3L
	 TXRdYMruT1SRoPhRPS2DS+wtDebfReVWjWJQjerULjwGvv5kIBHw2CiOWnbscEBDT7Bj9
	 XD4A7z01jUpYbtJt/attP4It7tEZabVDERVPefaDIOdNbZmJLTUiZNe7PhaZ6sGEkuDDm
	 /XkbQG/KSEt2bSYb9DhicP/D4KbEvS8YC6/Fi05+bBdQYWLkK8y3dDCvGd1BZxwSmgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GRRysK9h;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B12460A3833;
	Wed, 18 Nov 2026 19:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B12460A3833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GRRysK9h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795030230; x=1826566230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jKrPiESBh8gotD51pqtvCyiFgcwUc/jfYXoVnUtA6pM=;
  b=GRRysK9hiKtXwg/IBh/Y2MLEvblL7LyBUXHzxP9AZ34ztNYlhxsTel1o
   RuWLRyIag2OQtc3AQrrLcVFLUfU7Uc3Jv4Uu8LKSGk9HpdxS7mUqUAD7x
   gGkuogiOhPBCe+ZgGsbbW5I8g4HJryRJrnEO1LPpTE3l0coM0GkgVRWa2
   CtlJXdmc8DIcmF8nr5qd19ZCKesAWecDzy2OZ8sahoI4Af6YRMRT1i5x/
   eq1y1sL0w2EBOwbuGu8Sz8XpQ+QEx/DHSLcfAcFhpY032s2SqcA2TWxbe
   hdfoFyVNIBDiO/Z1uGkLzCIqj0o6AN4lZOGqhASU+w61bXD2ogPbbdTZc
   w==;
X-CSE-ConnectionGUID: nxjDw4kTS7uNg7RJ6bCFKQ==
X-CSE-MsgGUID: e3hn/6uJT3Cp2HM7PBL63Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3781272"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3781272"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 11:30:29 -0800
X-CSE-ConnectionGUID: IwIy3MQtStW8xGEa6toCow==
X-CSE-MsgGUID: oku3OpaPQ7WUhPdZY0ruww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10468104"
Received: from jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 18 Nov 2026 11:30:28 -0800
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
Subject: [PATCH v2 10/17] platform/x86/intel/ifs: Warn if a group test fails with CPUs missing
Date: Wed, 18 Nov 2026 12:32:52 -0700
Message-ID: <20261118193259.519568-11-ehab.ababneh@intel.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

All the logical processors that share a SCAN test engine must join a
group test. TID_BIT_SHIFT [1] gives the number of low APIC ID bits that
tell these logical processors apart. The driver builds the group from
topology_cluster_cpumask(), which only holds CPUs that are enumerated
and online. So it cannot tell whether every logical processor sharing
the engine actually takes part, for example on a part that exposes only
one core per module, or when a sibling has been taken offline.

Checking this once at driver load does not help: the group can change
at runtime through CPU hotplug, and failing to load would stop parts
that may still test fine. Instead, read TID_BIT_SHIFT at init and, when
a test does not pass, check whether all logical processors in the
CPU's TID_BIT_SHIFT APIC ID range were in the group. If not, say so in
the log. The test is run either way.

TID_BIT_SHIFT is only enumerated starting with SAF_GEN=2 (Granite
Rapids), so skip the check on SAF_GEN=0 parts (Sapphire Rapids and
Emerald Rapids).

[1] Vol. 4 "Table 2-56. Additional MSRs Supported by the Intel® Xeon®
    6 P-Core Processors" in the Intel Software Developers' Manual,
    March 2025.

Suggested-by: Tony Luck <tony.luck@intel.com>
Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 arch/x86/include/asm/msr-index.h         |  1 +
 drivers/platform/x86/intel/ifs/core.c    |  6 +++++
 drivers/platform/x86/intel/ifs/ifs.h     |  2 ++
 drivers/platform/x86/intel/ifs/runtest.c | 30 ++++++++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 9224b55e1f07..baa16d75749d 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -283,6 +283,7 @@
 #define MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST_BIT	4
 #define MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST		BIT(MSR_INTEGRITY_CAPS_PERIODIC_SCAN_BIST_BIT)
 #define MSR_INTEGRITY_CAPS_SAF_GEN_MASK			GENMASK_ULL(10, 9)
+#define MSR_INTEGRITY_CAPS_TID_BIT_SHIFT_MASK		GENMASK_ULL(20, 16)
 #define MSR_INTEGRITY_CAPS_ALL_LP_JOIN_BIT		21
 #define MSR_INTEGRITY_CAPS_ALL_LP_JOIN			BIT(MSR_INTEGRITY_CAPS_ALL_LP_JOIN_BIT)
 
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index f2d2caab0479..b9ac04228141 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -122,6 +122,12 @@ static int __init ifs_init(void)
 		 */
 		ifs_devices[i].rw_data.all_lp_join = ifs_devices[i].rw_data.generation ?
 						(msrval & MSR_INTEGRITY_CAPS_ALL_LP_JOIN) : true;
+
+		/* TID_BIT_SHIFT is only enumerated on SAF_GEN=2 and later */
+		if (ifs_devices[i].rw_data.generation)
+			ifs_devices[i].rw_data.tid_bit_shift =
+				FIELD_GET(MSR_INTEGRITY_CAPS_TID_BIT_SHIFT_MASK, msrval);
+
 		ifs_devices[i].rw_data.array_gen = (u32)m->driver_data;
 		ret = misc_register(&ifs_devices[i].misc);
 		if (ret)
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 365429fafe7a..62db0a6aa940 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -297,6 +297,7 @@ struct ifs_test_msrs {
  * @chunk_size: size of a test chunk
  * @array_gen: test generation of array test
  * @all_lp_join: all logical processors join test
+ * @tid_bit_shift: APIC-ID bits of the logical processors sharing a scan engine
  */
 struct ifs_data {
 	cpumask_t	grp_cpumask;
@@ -311,6 +312,7 @@ struct ifs_data {
 	u32	chunk_size;
 	u32	array_gen;
 	bool	all_lp_join;
+	u8	tid_bit_shift;
 };
 
 struct ifs_work {
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index c618857cd620..783b29f234ba 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -425,6 +425,32 @@ static void build_cpugroup_mask(struct device *dev, int cpu)
 	cpumask_copy(&ifsd->grp_cpumask, topology_cluster_cpumask(cpu));
 }
 
+/*
+ * Check whether all logical processors that share the scan engine with @cpu
+ * (the TID_BIT_SHIFT APIC-ID range) are online and in the test group. If not,
+ * the test is still attempted; it may pass if the microcode handles the
+ * missing logical processors, e.g. a module with only one core.
+ */
+static bool ifs_group_incomplete(int cpu, struct ifs_data *ifsd)
+{
+	u32 shift = ifsd->tid_bit_shift;
+	u32 engine = cpu_data(cpu).topo.apicid >> shift;
+	int i;
+
+	if (!ifsd->generation || !ifsd->all_lp_join)
+		return false;
+
+	if (cpumask_weight(&ifsd->grp_cpumask) != 1U << shift)
+		return true;
+
+	for_each_cpu(i, &ifsd->grp_cpumask) {
+		if (cpu_data(i).topo.apicid >> shift != engine)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Initiate per core test. It wakes up work queue threads on the target CPU and
  * its sibling CPU. Once all sibling threads wake up, the scan test gets executed and
@@ -464,6 +490,10 @@ int do_core_test(int cpu, struct device *dev)
 	default:
 		ret = -EINVAL;
 	}
+
+	if (!ret && ifsd->status != SCAN_TEST_PASS && ifs_group_incomplete(cpu, ifsd))
+		dev_warn(dev, "CPU %d: test did not pass; not all CPUs sharing the scan engine were found (group %*pbl)\n",
+			 cpu, cpumask_pr_args(&ifsd->grp_cpumask));
 out:
 	cpus_read_unlock();
 	return ret;
-- 
2.43.0

