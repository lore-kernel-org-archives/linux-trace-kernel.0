Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039746;
	b=Ogaa+vivd95VJvTtppydDEIyosOGWI5pkYMGh6PLrVMCpOOSxdGVmuT1x6RvUYFbBn59
	 cSASBt/H901CjmcS3jMySMiUqAJjb0Ql50q/28d7gyM5RZ86rvJMLCHJPIV18DIdkIyzM
	 9soI36WaRdZL97/VP1USME2IA8IxDjqnd61XuR871xEF1MxCZUzu7swsaSyebRFygvUFl
	 kH/XpZwtZHCsxC+qxfblF33L1e3qM5YHwmg8ZO31mSZqfs9vzUFww2VzSnmul3fWrFnwY
	 nOP/lvaGSKZ2yW4/pbKZqGaWuIvA0wh/E0HThfI/g1WUJHrWK7E4/14LZV38lT0Ku2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039746;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A+mrrf+XQKllv+GkHmXZW/AtWosKvdqXTIcmXWpY3Kk=;
	b=HhLMYMgac//Cfe1YuzP+oWZRRUpUUhJZECQIOimIuLVDwXRsJuLd0uoKZ/gI7EgVQfdp
	 OkMuvzHpWILU8NjP9e5APWXc2r7pf/kopR1fg1crHp1pfusuKn96b+eGYfYqbsW7GBJ2O
	 B3lNLuF6fzQaJ2WqE069t7XVY38/QxWT2GFyB0rHZKvT/9n44/mnFf51Gd03/idi8l0E9
	 Rxa/GJc6++/6YxnITAu5dqMlg2fw8qy1aCFRIT6tXXPZTPZzlT2ayJ3BPpAt1CWeXkFpK
	 qXOuPUwEbZnp6xxeMa9QKQlUuOAUY3R4z6aXvSVUT23FsP0U8MXibbXsolhY6Q4/ynw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iaMxmvYz;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3701606A33D;
	Mon, 26 Oct 2026 18:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3701606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iaMxmvYz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793039740; x=1824575740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BArBRV3zitQH5P5O8FpzKit8BIwu6JlumqGQlHMwX28=;
  b=iaMxmvYz4q8MmnKeQpFXk/W55FXRcQmC7Vn8Ue6IFG0hCnrYvQkvfZCv
   nnngPnLVrSoxe/7px4Rulryp+CBOMPUVL5MpPz00d84NIW1O9u59ivlZj
   mb8Wws2aaTdiOFYAWdo3TEa2SMZPsWHXDviM3NGpmuyhKl3eQr882eXlZ
   chhHWJ3TWJsM2h35bGZObjVqW6q5d6klnwce5EgG7z91+FgeVpLiX8Vk4
   2amvvZQLTVFkCYQn6jFBO6aJ4vxgWGx396hzbOaKYsGr96qQnlaM/mZtd
   bV8tUi6ViCBOcL7YLPQvwYjZmGJVLS/VeHdVhxO7rPYhRAQrZ6+/DYtvv
   w==;
X-CSE-ConnectionGUID: 9jStmjgARCm345/4IwJlaA==
X-CSE-MsgGUID: hXAesj5hRyetZGzlfnZjRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1731497"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1731497"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 11:35:36 -0700
X-CSE-ConnectionGUID: YQABT/6ASe6fFyhy9Wlw7A==
X-CSE-MsgGUID: zBWphj+3TFmn6uZ2Nrj6Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4293884"
Received: from jf.intel.com (HELO jf.intel.com.jf.intel.com) ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 26 Oct 2026 11:35:36 -0700
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
Subject: [PATCH 07/17] stop_machine: Add stop_cluster_cpuslocked() for per-cluster operations
Date: Mon, 26 Oct 2026 11:38:10 -0700
Message-ID: <20261026183820.129459-8-ehab.ababneh@intel.com>
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

