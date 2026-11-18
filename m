Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030228;
	b=HHlnjHXzkix68apkf6c+GKYMkuIDu4L8LPwOtO80L5Fc8hPuAGeCTQszYSbV8NrxW2pe
	 pcjULx65hZBdJwPIt6mp+3GyoPNK6UaAyRftby4UdR83HA2OgSPWzW0wrZPn5AKeHkmV9
	 63b+iHHW5ALoGXkYsy4205zIr7X74xZqXh5FUDD9oz78s9zejjsk7Fn4HqfrCu5MKRD15
	 Djw4czm7hG9AlR0oTW30F9NxIHDfalMRB/szE9U7QOL7vyl2a6jeU4NzbGnNXttiKwS/y
	 Sb4PHkPlAg24aWOPsZmKPPH2yMb4k4Agvpr5qhzSS1BWlJYioN+VU5OUutSH84TtWKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030228;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8b97LAFXkHqf3ImA+hRZVAdygdDHehIHOl+nw25LrKQ=;
	b=Ug47Sd87s6Ildu7314VW2M7CrpiMD7Y4fE5hgjAE6xDgjvlSbe8XNDYQzrdele+gTJII
	 pClEk9KicSPXxYJNkgYuwnZ/39HYANGA+hgRLXSDA6oLeX3T/avSGgQkdaIeT0fCGrxHx
	 ndZHcnibLNX02p0h3pmz2QLykouyYzZ30HgBehK7On5e1sSBfwqZcxaTPDqLTxeL1Lrc2
	 iZFMVcFzdN2bs5SwA2a9jUL4j82xiYuwbPKonUzDfu4xaNIesEa3Pcg7FUwX6NXNWhtx1
	 jlsrWz1rTbtqOFngarGoEEN7U7UYc9OLUWyFD78yC8G7fHHvEFHkDHj7uO2f85IpAVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S7x8Xr5Q;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1553606E7D4;
	Wed, 18 Nov 2026 19:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1553606E7D4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S7x8Xr5Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795030228; x=1826566228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C+/t5w0levhPh/xyTT+pFLdA9lEhbo0jPDkf8tDDFQI=;
  b=S7x8Xr5Qn7Ird79a3Wz5E9XpCvF0kZDVyoAGe8zVz9M8hKEIBRZhUYb4
   uKA+0pmtGtJvEMviOIs6kWEhim3Myn2X08wCeH9kOofDu4vK1eJpnoiP/
   JugA5huQz6Kv5Tu+kV5mGAv2MzdoUAlg+QlFn1RTTJ5gDwWztmrP3sxAc
   p3uGYv7VT7hjWxH0Fw++JYV70guuafZhBKqMzflTIycPnGyXdGeatRIOL
   eQwd/rD19RLwSrc5JJIfV/YnkHDirOoXZR6ZrSb2eXeToKYQsYxYpk8VM
   CJoVDYK6LFFknzXX2i1sPhgiEI1BnDIcLpesfV6KJYuuUjh+7Q+aklejA
   w==;
X-CSE-ConnectionGUID: bea/R9ZfQWmaC29j+wP1yQ==
X-CSE-MsgGUID: Uf0Z2NzpSUaiwTXZb7mFwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3781245"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3781245"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 11:30:27 -0800
X-CSE-ConnectionGUID: 0s6kvqwcQzuezvyQht6nsA==
X-CSE-MsgGUID: J9RFDFGVS5ya0ta3oJ4z5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10468092"
Received: from jf.intel.com ([10.165.154.102])
  by fmviesa008.fm.intel.com with ESMTP; 18 Nov 2026 11:30:27 -0800
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
	sathyanarayanan.kuppuswamy@linux.intel.com,
	pengfei.xu@intel.com,
	ravi.v.shankar@intel.com
Subject: [PATCH v2 07/17] stop_machine: Add stop_cluster_cpuslocked() for per-cluster operations
Date: Wed, 18 Nov 2026 12:32:49 -0700
Message-ID: <20261118193259.519568-8-ehab.ababneh@intel.com>
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

There is already stop_core_cpuslocked() for hardware core-level testing
features, which requires near-simultaneous execution of the WRMSR
instruction on all threads of a core to initiate a test. However, some
hardware requires this simultaneous execution of WRMSR at the cluster
level.

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
index 84e7fb627ba4..a189f405a4f2 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -157,6 +157,21 @@ int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data, const struct cpumask *
  */
 int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data);
 
+/**
+ * stop_cluster_cpuslocked: - stop all threads on a CPU cluster
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

