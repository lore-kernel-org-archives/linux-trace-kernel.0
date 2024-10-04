Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A014B946
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035468; cv=none; b=MwCAcq7jnD+8M8qqwxIFqhU1g0ezJT5fu6UoA9z60RMKnbt1GLQ3Ley4dLcLwu8J7ltkXOQcC4/1JL//GpM7U6Dzao8KWwdOGnlRLwJeTAHlEkhEVcxJR5k2R9LQGJwT06TISLkcVnJEE5tUVuf9Mu5EX1iFKwGQMCwQQVnHW1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035468; c=relaxed/simple;
	bh=Tc5jmZCZrGDUdcJHEYTP95l82veU6Kxy/s4bIBrAsCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1IEI6HuOfF//gcbhpSrgWLB+6fVKewB8qzIJPFdpRmI7lKwblHLEwdc3ZBAa2iXzhMIljWb9N0UgN5haIEmFUn05rXtic/zOLqIvrnt9cv0clSS4ZsrMJT8HskdX7oddw6bTPBDCNN6KSLC4LaeIJ23/qttDaQTUcgM/9krI1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSehgC+U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSehgC+U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728035464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXN04guyF1JexnsZyIhDlbYqNdwlg807kbuff9ZcX58=;
	b=aSehgC+U43XcSC6QUMnf582Uf1jE9GFmb5LPy4hcfT4ktP02P+oO2F+7Hb+iW/TVy5veV8
	30/3vhlQAD3gGAXpJ2oJ6Y2uQwB2RGMqBt/TxNDYrSUbjgNiZSBDkJgnzAv3TbbvHvia7w
	1z2v9h2ztWHVy2P7syIoJWM4Bbg34Sw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-YuaBklv6PGq8k0PJ3VgARQ-1; Fri,
 04 Oct 2024 05:51:01 -0400
X-MC-Unique: YuaBklv6PGq8k0PJ3VgARQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 163EA1956089;
	Fri,  4 Oct 2024 09:51:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.176])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0EF93000198;
	Fri,  4 Oct 2024 09:50:57 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH RESEND v3 3/6] rtla/utils: Add idle state disabling via libcpupower
Date: Fri,  4 Oct 2024 11:50:11 +0200
Message-ID: <20241004095014.2492813-4-tglozar@redhat.com>
In-Reply-To: <20241004095014.2492813-1-tglozar@redhat.com>
References: <20241004095014.2492813-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Tomas Glozar <tglozar@redhat.com>

Add functions to utils.c to disable idle states through functions of
libcpupower. This will serve as the basis for disabling idle states
per cpu when running timerlat.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/utils.c | 150 +++++++++++++++++++++++++++++++++
 tools/tracing/rtla/src/utils.h |  13 +++
 2 files changed, 163 insertions(+)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 9ac71a66840c..6ae084fdedf9 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -4,6 +4,9 @@
  */
 
 #define _GNU_SOURCE
+#ifdef HAVE_LIBCPUPOWER_SUPPORT
+#include <cpuidle.h>
+#endif /* HAVE_LIBCPUPOWER_SUPPORT */
 #include <dirent.h>
 #include <stdarg.h>
 #include <stdlib.h>
@@ -519,6 +522,153 @@ int set_cpu_dma_latency(int32_t latency)
 	return fd;
 }
 
+#ifdef HAVE_LIBCPUPOWER_SUPPORT
+static unsigned int **saved_cpu_idle_disable_state;
+static size_t saved_cpu_idle_disable_state_alloc_ctr;
+
+/*
+ * save_cpu_idle_state_disable - save disable for all idle states of a cpu
+ *
+ * Saves the current disable of all idle states of a cpu, to be subsequently
+ * restored via restore_cpu_idle_disable_state.
+ *
+ * Return: idle state count on success, negative on error
+ */
+int save_cpu_idle_disable_state(unsigned int cpu)
+{
+	unsigned int nr_states;
+	unsigned int state;
+	int disabled;
+	int nr_cpus;
+
+	nr_states = cpuidle_state_count(cpu);
+
+	if (nr_states == 0)
+		return 0;
+
+	if (saved_cpu_idle_disable_state == NULL) {
+		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+		saved_cpu_idle_disable_state = calloc(nr_cpus, sizeof(unsigned int *));
+		if (!saved_cpu_idle_disable_state)
+			return -1;
+	}
+
+	saved_cpu_idle_disable_state[cpu] = calloc(nr_states, sizeof(unsigned int));
+	if (!saved_cpu_idle_disable_state[cpu])
+		return -1;
+	saved_cpu_idle_disable_state_alloc_ctr++;
+
+	for (state = 0; state < nr_states; state++) {
+		disabled = cpuidle_is_state_disabled(cpu, state);
+		if (disabled < 0)
+			return disabled;
+		saved_cpu_idle_disable_state[cpu][state] = disabled;
+	}
+
+	return nr_states;
+}
+
+/*
+ * restore_cpu_idle_disable_state - restore disable for all idle states of a cpu
+ *
+ * Restores the current disable state of all idle states of a cpu that was
+ * previously saved by save_cpu_idle_disable_state.
+ *
+ * Return: idle state count on success, negative on error
+ */
+int restore_cpu_idle_disable_state(unsigned int cpu)
+{
+	unsigned int nr_states;
+	unsigned int state;
+	int disabled;
+	int result;
+
+	if (!saved_cpu_idle_disable_state)
+		return -1;
+
+	nr_states = cpuidle_state_count(cpu);
+
+	if (nr_states == 0)
+		return 0;
+
+	for (state = 0; state < nr_states; state++) {
+		if (!saved_cpu_idle_disable_state[cpu])
+			return -1;
+		disabled = saved_cpu_idle_disable_state[cpu][state];
+		result = cpuidle_state_disable(cpu, state, disabled);
+		if (result < 0)
+			return result;
+	}
+
+	free(saved_cpu_idle_disable_state[cpu]);
+	saved_cpu_idle_disable_state[cpu] = NULL;
+	saved_cpu_idle_disable_state_alloc_ctr--;
+	if (saved_cpu_idle_disable_state_alloc_ctr == 0) {
+		free(saved_cpu_idle_disable_state);
+		saved_cpu_idle_disable_state = NULL;
+	}
+
+	return nr_states;
+}
+
+/*
+ * free_cpu_idle_disable_states - free saved idle state disable for all cpus
+ *
+ * Frees the memory used for storing cpu idle state disable for all cpus
+ * and states.
+ *
+ * Normally, the memory is freed automatically in
+ * restore_cpu_idle_disable_state; this is mostly for cleaning up after an
+ * error.
+ */
+void free_cpu_idle_disable_states(void)
+{
+	int cpu;
+	int nr_cpus;
+
+	if (!saved_cpu_idle_disable_state)
+		return;
+
+	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		free(saved_cpu_idle_disable_state[cpu]);
+		saved_cpu_idle_disable_state[cpu] = NULL;
+	}
+
+	free(saved_cpu_idle_disable_state);
+	saved_cpu_idle_disable_state = NULL;
+}
+
+/*
+ * set_deepest_cpu_idle_state - limit idle state of cpu
+ *
+ * Disables all idle states deeper than the one given in
+ * deepest_state (assuming states with higher number are deeper).
+ *
+ * This is used to reduce the exit from idle latency. Unlike
+ * set_cpu_dma_latency, it can disable idle states per cpu.
+ *
+ * Return: idle state count on success, negative on error
+ */
+int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int deepest_state)
+{
+	unsigned int nr_states;
+	unsigned int state;
+	int result;
+
+	nr_states = cpuidle_state_count(cpu);
+
+	for (state = deepest_state + 1; state < nr_states; state++) {
+		result = cpuidle_state_disable(cpu, state, 1);
+		if (result < 0)
+			return result;
+	}
+
+	return nr_states;
+}
+#endif /* HAVE_LIBCPUPOWER_SUPPORT */
+
 #define _STR(x) #x
 #define STR(x) _STR(x)
 
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index d44513e6c66a..e439db7fc848 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -64,6 +64,19 @@ int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr);
 int set_comm_cgroup(const char *comm_prefix, const char *cgroup);
 int set_pid_cgroup(pid_t pid, const char *cgroup);
 int set_cpu_dma_latency(int32_t latency);
+#ifdef HAVE_LIBCPUPOWER_SUPPORT
+int save_cpu_idle_disable_state(unsigned int cpu);
+int restore_cpu_idle_disable_state(unsigned int cpu);
+void free_cpu_idle_disable_states(void);
+int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int state);
+static inline int have_libcpupower_support(void) { return 1; }
+#else
+static inline int save_cpu_idle_disable_state(unsigned int cpu) { return -1; }
+static inline int restore_cpu_idle_disable_state(unsigned int cpu) { return -1; }
+static inline void free_cpu_idle_disable_states(void) { }
+static inline int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int state) { return -1; }
+static inline int have_libcpupower_support(void) { return 0; }
+#endif /* HAVE_LIBCPUPOWER_SUPPORT */
 int auto_house_keeping(cpu_set_t *monitored_cpus);
 
 #define ns_to_usf(x) (((double)x/1000))
-- 
2.46.2

