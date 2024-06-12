Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DE017F50F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204163; cv=none; b=KskbMhbZMvQaGbXjNaUkCVRh0l6Yp1I6eWggLxx5UI8owS3CEgFst/3xct6PNhViypMDrYx1tlZNT3Dv/lX7TKH3eAgkVyO+qtC8z5R2wDCWiazRwOEh1fUpsmFD/OMqOXkDkyYiuUAi3a1JPBC6egCgBgKLUTZjum0ZB8WIYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204163; c=relaxed/simple;
	bh=cJUXunAqIxilQZmNC5/bPQJRP2yY+mwrA9Z610+q4z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVtgfQf+xHf4ZrakTuCNYE1cOMQNF/y8dScT8L+k4mE2uxK4KtJvmtyayEUsubjEKNoPGu6xvgy9zDcTedXfhs0JS2wCMzVQYqPQ6oEMLAoFRiugCNv06/Y2lbOsiGnfJ5nC0d5o+jXZbI8sYrx/MhTm42bIIEVkrjh0AW0MoLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhsM57CX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhsM57CX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718204160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tFx/qXVo6O1Pq7NugdqAhdDFg17/I3UZeqAqLRYlrw=;
	b=LhsM57CXEDlmrpoLT0r+Ao2qLEcd8MnH+47s4VjbKgcC9M2cKFuhw3O1K6MV7thB4jbPe5
	C0lbaoInBTdWB3CHaz36J633zWjrfy6+CsQe8asa0ortkqCYVnfRk6/dgrhZjVkeAGkOid
	ISfaDwrn1PSOgMLjSjNOAFsFXPAXQCs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-4mOH9h5IPVaP7ddRIxOVcQ-1; Wed,
 12 Jun 2024 10:55:57 -0400
X-MC-Unique: 4mOH9h5IPVaP7ddRIxOVcQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C2B71955E7F;
	Wed, 12 Jun 2024 14:55:56 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.68])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65C591954AC0;
	Wed, 12 Jun 2024 14:55:54 +0000 (UTC)
From: tglozar@redhat.com
To: bristot@kernel.org,
	rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	jwyatt@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/5] rtla/utils: Add idle state disabling via libcpupower
Date: Wed, 12 Jun 2024 16:54:36 +0200
Message-ID: <20240612145439.206990-3-tglozar@redhat.com>
In-Reply-To: <20240612145439.206990-1-tglozar@redhat.com>
References: <20240612145439.206990-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Tomas Glozar <tglozar@redhat.com>

Add functions to utils.c to disable idle states through functions of
libcpupower. This will serve as the basis for disabling idle states
per cpu when running timerlat.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/utils.c | 133 +++++++++++++++++++++++++++++++++
 tools/tracing/rtla/src/utils.h |   4 +
 2 files changed, 137 insertions(+)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 9ac71a66840c..638c50f0f88e 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -4,6 +4,7 @@
  */
 
 #define _GNU_SOURCE
+#include <cpuidle.h>
 #include <dirent.h>
 #include <stdarg.h>
 #include <stdlib.h>
@@ -519,6 +520,138 @@ int set_cpu_dma_latency(int32_t latency)
 	return fd;
 }
 
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
+	}
+
+	saved_cpu_idle_disable_state[cpu] = calloc(nr_states, sizeof(unsigned int));
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
+	nr_states = cpuidle_state_count(cpu);
+
+	if (nr_states == 0)
+		return 0;
+
+	for (state = 0; state < nr_states; state++) {
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
+
+	if (!saved_cpu_idle_disable_state)
+		return;
+
+	for (cpu = 0; cpu < sysconf(_SC_NPROCESSORS_CONF); cpu++) {
+		if (!saved_cpu_idle_disable_state[cpu])
+			continue;
+		free(saved_cpu_idle_disable_state[cpu]);
+		saved_cpu_idle_disable_state[cpu] = NULL;
+	}
+
+	free(saved_cpu_idle_disable_state);
+	saved_cpu_idle_disable_state = NULL;
+}
+
+/*
+ * set_cpu_idle_disable_state - set disable for all idle states of a cpu
+ *
+ * This is used to reduce the exit from idle latency. Unlike
+ * set_cpu_dma_latency, it can disable idle states per cpu.
+ *
+ * Return: idle state count on success, negative on error
+ */
+int set_cpu_idle_disable_state(unsigned int cpu, unsigned int disable)
+{
+	unsigned int nr_states;
+	unsigned int state;
+	int result;
+
+	nr_states = cpuidle_state_count(cpu);
+
+	for (state = 0; state < nr_states; state++) {
+		result = cpuidle_state_disable(cpu, state, disable);
+		if (result < 0)
+			return result;
+	}
+
+	return nr_states;
+}
+
 #define _STR(x) #x
 #define STR(x) _STR(x)
 
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index d44513e6c66a..b310ed5cd867 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -64,6 +64,10 @@ int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr);
 int set_comm_cgroup(const char *comm_prefix, const char *cgroup);
 int set_pid_cgroup(pid_t pid, const char *cgroup);
 int set_cpu_dma_latency(int32_t latency);
+int save_cpu_idle_disable_state(unsigned int cpu);
+int restore_cpu_idle_disable_state(unsigned int cpu);
+void free_cpu_idle_disable_states(void);
+int set_cpu_idle_disable_state(unsigned int cpu, unsigned int disable);
 int auto_house_keeping(cpu_set_t *monitored_cpus);
 
 #define ns_to_usf(x) (((double)x/1000))
-- 
2.43.0

