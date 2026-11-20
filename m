Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197272;
	b=5HMKfEM6TyWGauOAFXBtGJhBVRroLJxlLmeFDLAKt/cdEdi0IqwE1KOSzWc6650aXdK1
	 N3SUfmaEwFb19BDGfflQgCCBOhAMDsdwKw/YjhTixuWznZPHC6uXAe/Tei7LXXxRIAHTH
	 WlHOL/0U38J49uMKgIynCx91EqagAVclb78UQNVD1HR67jhK33DZmalhAlE43E/LUzCZ1
	 jA3shm24/wHqTdmIh8K0O/2A7YtPeNLlu9geZC5pb8ICGna9y1wgnZ5mXkpGEm2YU/AaS
	 7XLtmbhiafJpZOjopo0CKjdEPbXwzP2kj0/eFVaVVVxUDsMAxdE2D1QP0hoseR5SWag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197272;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dth3tzjzbGH8qzlRP87+uBXDgfWjM2UcICvv3wDcmQE=;
	b=I1uYWgkjYowtx52IBhoZik7F+0hM7W42WVR/acGpucCx9dUvc/Das/21Y5qSuv6TbpvS
	 UW81W+0CmXE7cZJTu9PRmJBEFVHNHEA2AsnJNVsFQXYyHQ7yzlFfBMxmcKLPE2FBU805g
	 /NpMiGH61QloD2u/9rgtgqwGZ1DValI15StYBJ0zxD9DycOhjik1WF4hrnQhw68vMwNMU
	 NAkT1z2ylKAXLj8TvmCPdCHFebT7NdKSYvxyHWCr0D+WiFTJ/4DkzMy1Axq/U7EAciG9v
	 5Rk3PShLqiGiqa7glSlF7NRHkkkGntuFE4mvdzZJV7QdkxQ8ND6gg1lu5IjprpUrXog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="oGz9/ayb";
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4660A2627;
	Fri, 20 Nov 2026 17:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0A4660A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oGz9/ayb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795197268; x=1826733268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WObv3zUagmyMlXLQN9yqbTFv9VnY8RsUTI15wi/FrwY=;
  b=oGz9/aybLoe8ANPS0MBZ/oZo2JI/SxI4g373Thp9HPejfW9sbr/F/lTB
   4PkzTDTJP+8xroAZ7Lxx8vg4HL86Wa0NkSz22+ASZ9J6uahC4NvS+bNOG
   uT4W9/HQlH6UE3/5LCJ/PiRHIiBqPICg6uOxMrl5dznUflBCGicixEN8f
   sHVqOV26eMBVD9HDXjRMjipFvrMfMAnI3gi8u9jSdCek3PciEiPC2wutU
   CBvdQtjqG+g3PseYvKdS6KCNc/V/xmx20GxJmSKHz/t8MahpTOL3tlPCg
   47qb/cH4yrGpxbLewQM/AKk1IUEF15uWCtL235vgo+7sZIYVgSDR/pEAC
   A==;
X-CSE-ConnectionGUID: Bwdr1KIFS4+A4vnki2m4eg==
X-CSE-MsgGUID: pATDk33VSLSclgnJuIy8OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4108938"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4108938"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:54:24 -0800
X-CSE-ConnectionGUID: +XixkpBKTJuMj5I+vjDYrw==
X-CSE-MsgGUID: Ik2cYkLXQSCfBAz9kyyLFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11171051"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2026 09:54:23 -0800
From: Ehab Ababneh <ehab.ababneh@intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org,
	tony.luck@intel.com,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: ashok.raj.linux@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 07/17] stop_machine: Add stop_cluster_cpuslocked() for per-cluster operations
Date: Fri, 20 Nov 2026 10:56:48 -0700
Message-ID: <20261120175658.1147030-8-ehab.ababneh@intel.com>
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

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

stop_core_cpuslocked() can only run a function simultaneously on the
threads of a single core. However, Intel In-Field Scan (IFS) on Diamond
Rapids requires a near-simultaneous WRMSR on all threads of a cluster to
start a test, because the cores of a module share one scan test engine.

Add stop_cluster_cpuslocked(), a customized version of
stop_machine_cpuslocked() for operating solely on the threads of a
single cluster.

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 include/linux/stop_machine.h | 15 +++++++++++++++
 kernel/stop_machine.c        | 35 ++++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 84e7fb627ba4..870ea49aa32a 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -157,6 +157,21 @@ int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data, const struct cpumask *
  */
 int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data);
 
+/**
+ * stop_cluster_cpuslocked - stop all threads on a CPU cluster
+ * @cpu: any CPU in the targeted cluster
+ * @fn: the function to run
+ * @data: the data ptr for @fn()
+ *
+ * Same as above, only the CPUs associated with a single CPU cluster are affected.
+ *
+ * Context: Must be called from within a cpus_read_lock() protected region.
+ *
+ * Return: 0 if all executions of @fn returned 0, any non zero return
+ * value if any returned non zero.
+ */
+int stop_cluster_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data);
+
 int stop_machine_from_inactive_cpu(cpu_stop_fn_t fn, void *data,
 				   const struct cpumask *cpus);
 #else	/* CONFIG_SMP || CONFIG_HOTPLUG_CPU */
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index d085ba1f4b44..1afda0ddfb90 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -630,32 +630,41 @@ int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus)
 }
 EXPORT_SYMBOL_GPL(stop_machine);
 
-#ifdef CONFIG_SCHED_SMT
-/*
- * INTEL_IFS is the only user of this API. That selftest can
- * only be compiled if SMP=y. On x86 it selects SCHED_SMT.
- * Keep the ifdefs for now.
- */
-int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data)
+static int stop_cpus_cpuslocked(const struct cpumask *cpus, cpu_stop_fn_t fn, void *data)
 {
-	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
-
 	struct multi_stop_data msdata = {
 		.fn = fn,
 		.data = data,
-		.num_threads = cpumask_weight(smt_mask),
-		.active_cpus = smt_mask,
+		.num_threads = cpumask_weight(cpus),
+		.active_cpus = cpus,
 	};
 
 	lockdep_assert_cpus_held();
 
-	/* Set the initial state and stop all online cpus. */
+	/* Set the initial state and stop all online @cpus. */
 	set_state(&msdata, MULTI_STOP_PREPARE);
-	return stop_cpus(smt_mask, multi_cpu_stop, &msdata);
+	return stop_cpus(cpus, multi_cpu_stop, &msdata);
+}
+
+#ifdef CONFIG_SCHED_SMT
+/*
+ * INTEL_IFS is the only user of this API. That selftest can
+ * only be compiled if SMP=y. On x86 it selects SCHED_SMT.
+ * Keep the ifdefs for now.
+ */
+int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data)
+{
+	return stop_cpus_cpuslocked(cpu_smt_mask(cpu), fn, data);
 }
 EXPORT_SYMBOL_GPL(stop_core_cpuslocked);
 #endif
 
+int stop_cluster_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data)
+{
+	return stop_cpus_cpuslocked(topology_cluster_cpumask(cpu), fn, data);
+}
+EXPORT_SYMBOL_GPL(stop_cluster_cpuslocked);
+
 /**
  * stop_machine_from_inactive_cpu - stop_machine() from inactive CPU
  * @fn: the function to run
-- 
2.43.0

