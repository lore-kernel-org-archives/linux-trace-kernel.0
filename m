Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8137B26A1D1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890773; cv=none; b=NT1e1YMHoR4HTyZrWyZQPGx65AAiPOCsWaXWn8vSaqhpdww5gfFq0dQYuxB0eKULxHDzlK4/AUI9HhdfDK9HJrV0W1CGLKSMdjWYsUhO1TeiAXQgbPgozFbNxSEZX/laMinNf/omLejaZqQD3jsNQDZuYPYp5dntwjhzETlWd2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890773; c=relaxed/simple;
	bh=AeYe2vBNU+m9FBdUC7nwJOFvDJpO9BLROJh30fvw8Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6MeJAA4Yiq9fRuxBI7bZVAEKC8TYJk3Bc3o/Wen5hhYLOyjRWHtvUYJjvWn4mDzkx1utrCA3hLYEyAhdnOp9B1jkJsTlgV9GVadMqKAF7n2SiCvxj2yGl1k5bpJFKOD3a4l4ADwoYr3HaQrPBHa0eVGchSKT2Zg1JREkajsmoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPLQxRb+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPLQxRb+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739890770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4Xvf5gPCmpzm9QGgHlDq78O/tV2kJRlkD34Az50cMA=;
	b=RPLQxRb+yvf9S0dTEgHEZy4z+PrJHaQAFbTRhfNb5Nx2dsmUCHypKoaDgl1/fGWZ3cV4qK
	TD3lxX3j0IZQagUJcppVzZxH/YQR876PtL0KV4Lc0DQLfLHttSq5OA7G0vNFzSVrH8zDi8
	ERSQ5NrQ1PX2bJXg/ZEBsxK+HXMEZPQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-8BpTYZv1N6u1qu9Drsr6gg-1; Tue,
 18 Feb 2025 09:59:25 -0500
X-MC-Unique: 8BpTYZv1N6u1qu9Drsr6gg-1
X-Mimecast-MFC-AGG-ID: 8BpTYZv1N6u1qu9Drsr6gg_1739890764
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 686FF18D95E0;
	Tue, 18 Feb 2025 14:59:24 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1ECB81800357;
	Tue, 18 Feb 2025 14:59:21 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 4/8] rtla/timerlat: Add BPF skeleton to collect samples
Date: Tue, 18 Feb 2025 15:58:55 +0100
Message-ID: <20250218145859.27762-5-tglozar@redhat.com>
In-Reply-To: <20250218145859.27762-1-tglozar@redhat.com>
References: <20250218145859.27762-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add BPF program that attaches to the osnoise:timerlat_sample tracepoint
and collects both the summary and the histogram (if requested) into BPF
maps (one map of each kind per context).

The program is designed to be used for both timerlat-top and
timerlat-hist. If using with timerlat-top, the "entries" parameter is
set to zero, which prevents the BPF program from recording histogram
entries. In that case, the maps for histograms do not have to be
created, as the BPF verifier will identify the code using them as
unreachable.

An IRQ or thread latency threshold might be supplied to stop recording
if hit, similar to the timerlat tracer threshold, which stops ftrace
tracing if hit. A BPF ringbuffer is used to signal threshold overflow to
userspace. In aa-only mode, this is the only function of the BPF
program.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/.gitignore         |   1 +
 tools/tracing/rtla/Makefile           |  14 ++-
 tools/tracing/rtla/src/Build          |   1 +
 tools/tracing/rtla/src/timerlat.bpf.c | 149 +++++++++++++++++++++++
 tools/tracing/rtla/src/timerlat_bpf.c | 166 ++++++++++++++++++++++++++
 tools/tracing/rtla/src/timerlat_bpf.h |  59 +++++++++
 6 files changed, 389 insertions(+), 1 deletion(-)
 create mode 100644 tools/tracing/rtla/src/timerlat.bpf.c
 create mode 100644 tools/tracing/rtla/src/timerlat_bpf.c
 create mode 100644 tools/tracing/rtla/src/timerlat_bpf.h

diff --git a/tools/tracing/rtla/.gitignore b/tools/tracing/rtla/.gitignore
index 293f0dbb0ca2..1a394ad26cc1 100644
--- a/tools/tracing/rtla/.gitignore
+++ b/tools/tracing/rtla/.gitignore
@@ -4,3 +4,4 @@ rtla-static
 fixdep
 feature
 FEATURE-DUMP
+*.skel.h
diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 0aa116f7b355..557af322be61 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -73,6 +73,17 @@ CFLAGS		+= $(INCLUDES) $(LIB_INCLUDES)
 
 export CFLAGS OUTPUT srctree
 
+ifeq ($(BUILD_BPF_SKEL),1)
+src/timerlat.bpf.o: src/timerlat.bpf.c
+	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
+
+src/timerlat.skel.h: src/timerlat.bpf.o
+	$(QUIET_GENSKEL)$(BPFTOOL) gen skeleton $< > $@
+else
+src/timerlat.skel.h:
+	$(Q)echo '/* BPF skeleton is disabled */' > src/timerlat.skel.h
+endif
+
 $(RTLA): $(RTLA_IN)
 	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RTLA) $(RTLA_IN) $(EXTLIBS)
 
@@ -83,7 +94,7 @@ static: $(RTLA_IN)
 rtla.%: fixdep FORCE
 	make -f $(srctree)/tools/build/Makefile.build dir=. $@
 
-$(RTLA_IN): fixdep FORCE
+$(RTLA_IN): fixdep FORCE src/timerlat.skel.h
 	make $(build)=rtla
 
 clean: doc_clean fixdep-clean
@@ -91,6 +102,7 @@ clean: doc_clean fixdep-clean
 	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
 	$(Q)rm -rf feature
+	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h
 check: $(RTLA)
 	RTLA=$(RTLA) prove -o -f tests/
 .PHONY: FORCE clean check
diff --git a/tools/tracing/rtla/src/Build b/tools/tracing/rtla/src/Build
index dbed9e31829b..7bb7e39e391a 100644
--- a/tools/tracing/rtla/src/Build
+++ b/tools/tracing/rtla/src/Build
@@ -8,4 +8,5 @@ rtla-y += timerlat_top.o
 rtla-y += timerlat_hist.o
 rtla-y += timerlat_u.o
 rtla-y += timerlat_aa.o
+rtla-y += timerlat_bpf.o
 rtla-y += rtla.o
diff --git a/tools/tracing/rtla/src/timerlat.bpf.c b/tools/tracing/rtla/src/timerlat.bpf.c
new file mode 100644
index 000000000000..96196d46e170
--- /dev/null
+++ b/tools/tracing/rtla/src/timerlat.bpf.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_tracing.h>
+#include <stdbool.h>
+#include "timerlat_bpf.h"
+
+#define nosubprog __always_inline
+#define MAX_ENTRIES_DEFAULT 4096
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct trace_event_raw_timerlat_sample {
+	unsigned long long timer_latency;
+	int context;
+} __attribute__((preserve_access_index));
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, MAX_ENTRIES_DEFAULT);
+	__type(key, unsigned int);
+	__type(value, unsigned long long);
+} hist_irq SEC(".maps"), hist_thread SEC(".maps"), hist_user SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, SUMMARY_FIELD_N);
+	__type(key, unsigned int);
+	__type(value, unsigned long long);
+} summary_irq SEC(".maps"), summary_thread SEC(".maps"), summary_user SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 1);
+} signal_stop_tracing SEC(".maps");
+
+/* Params to be set by rtla */
+const volatile int bucket_size = 1;
+const volatile int output_divisor = 1000;
+const volatile int entries = 256;
+const volatile int irq_threshold;
+const volatile int thread_threshold;
+const volatile bool aa_only;
+
+int stop_tracing;
+
+nosubprog unsigned long long map_get(void *map,
+				     unsigned int key)
+{
+	unsigned long long *value_ptr;
+
+	value_ptr = bpf_map_lookup_elem(map, &key);
+
+	return !value_ptr ? 0 : *value_ptr;
+}
+
+nosubprog void map_set(void *map,
+		       unsigned int key,
+		       unsigned long long value)
+{
+	bpf_map_update_elem(map, &key, &value, BPF_ANY);
+}
+
+nosubprog void map_increment(void *map,
+			     unsigned int key)
+{
+	map_set(map, key, map_get(map, key) + 1);
+}
+
+nosubprog void update_main_hist(void *map,
+				int bucket)
+{
+	if (entries == 0)
+		/* No histogram */
+		return;
+
+	if (bucket >= entries)
+		/* Overflow */
+		return;
+
+	map_increment(map, bucket);
+}
+
+nosubprog void update_summary(void *map,
+			      unsigned long long latency,
+			      int bucket)
+{
+	if (aa_only)
+		/* Auto-analysis only, nothing to be done here */
+		return;
+
+	map_set(map, SUMMARY_CURRENT, latency);
+
+	if (bucket >= entries)
+		/* Overflow */
+		map_increment(map, SUMMARY_OVERFLOW);
+
+	if (latency > map_get(map, SUMMARY_MAX))
+		map_set(map, SUMMARY_MAX, latency);
+
+	if (latency < map_get(map, SUMMARY_MIN) || map_get(map, SUMMARY_COUNT) == 0)
+		map_set(map, SUMMARY_MIN, latency);
+
+	map_increment(map, SUMMARY_COUNT);
+	map_set(map, SUMMARY_SUM, map_get(map, SUMMARY_SUM) + latency);
+}
+
+nosubprog void set_stop_tracing(void)
+{
+	int value = 0;
+
+	/* Suppress further sample processing */
+	stop_tracing = 1;
+
+	/* Signal to userspace */
+	bpf_ringbuf_output(&signal_stop_tracing, &value, sizeof(value), 0);
+}
+
+SEC("tp/osnoise/timerlat_sample")
+int handle_timerlat_sample(struct trace_event_raw_timerlat_sample *tp_args)
+{
+	unsigned long long latency, latency_us;
+	int bucket;
+
+	if (stop_tracing)
+		return 0;
+
+	latency = tp_args->timer_latency / output_divisor;
+	latency_us = tp_args->timer_latency / 1000;
+	bucket = latency / bucket_size;
+
+	if (tp_args->context == 0) {
+		update_main_hist(&hist_irq, bucket);
+		update_summary(&summary_irq, latency, bucket);
+
+		if (irq_threshold != 0 && latency_us >= irq_threshold)
+			set_stop_tracing();
+	} else if (tp_args->context == 1) {
+		update_main_hist(&hist_thread, bucket);
+		update_summary(&summary_thread, latency, bucket);
+
+		if (thread_threshold != 0 && latency_us >= thread_threshold)
+			set_stop_tracing();
+	} else {
+		update_main_hist(&hist_user, bucket);
+		update_summary(&summary_user, latency, bucket);
+	}
+
+	return 0;
+}
diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
new file mode 100644
index 000000000000..5abee884037a
--- /dev/null
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifdef HAVE_BPF_SKEL
+#include "timerlat.h"
+#include "timerlat_bpf.h"
+#include "timerlat.skel.h"
+
+static struct timerlat_bpf *bpf;
+
+/*
+ * timerlat_bpf_init - load and initialize BPF program to collect timerlat data
+ */
+int timerlat_bpf_init(struct timerlat_params *params)
+{
+	int err;
+
+	debug_msg("Loading BPF program\n");
+
+	bpf = timerlat_bpf__open();
+	if (!bpf)
+		return 1;
+
+	/* Pass common options */
+	bpf->rodata->output_divisor = params->output_divisor;
+	bpf->rodata->entries = params->entries;
+	bpf->rodata->irq_threshold = params->stop_us;
+	bpf->rodata->thread_threshold = params->stop_total_us;
+	bpf->rodata->aa_only = params->aa_only;
+
+	if (params->entries != 0) {
+		/* Pass histogram options */
+		bpf->rodata->bucket_size = params->bucket_size;
+
+		/* Set histogram array sizes */
+		bpf_map__set_max_entries(bpf->maps.hist_irq, params->entries);
+		bpf_map__set_max_entries(bpf->maps.hist_thread, params->entries);
+		bpf_map__set_max_entries(bpf->maps.hist_user, params->entries);
+	} else {
+		/* No entries, disable histogram */
+		bpf_map__set_autocreate(bpf->maps.hist_irq, false);
+		bpf_map__set_autocreate(bpf->maps.hist_thread, false);
+		bpf_map__set_autocreate(bpf->maps.hist_user, false);
+	}
+
+	if (params->aa_only) {
+		/* Auto-analysis only, disable summary */
+		bpf_map__set_autocreate(bpf->maps.summary_irq, false);
+		bpf_map__set_autocreate(bpf->maps.summary_thread, false);
+		bpf_map__set_autocreate(bpf->maps.summary_user, false);
+	}
+
+	/* Load and verify BPF program */
+	err = timerlat_bpf__load(bpf);
+	if (err) {
+		timerlat_bpf__destroy(bpf);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * timerlat_bpf_attach - attach BPF program to collect timerlat data
+ */
+int timerlat_bpf_attach(void)
+{
+	debug_msg("Attaching BPF program\n");
+
+	return timerlat_bpf__attach(bpf);
+}
+
+/*
+ * timerlat_bpf_detach - detach BPF program to collect timerlat data
+ */
+void timerlat_bpf_detach(void)
+{
+	timerlat_bpf__detach(bpf);
+}
+
+/*
+ * timerlat_bpf_detach - destroy BPF program to collect timerlat data
+ */
+void timerlat_bpf_destroy(void)
+{
+	timerlat_bpf__destroy(bpf);
+}
+
+static int handle_rb_event(void *ctx, void *data, size_t data_sz)
+{
+	return 0;
+}
+
+/*
+ * timerlat_bpf_wait - wait until tracing is stopped or signal
+ */
+int timerlat_bpf_wait(int timeout)
+{
+	struct ring_buffer *rb;
+	int retval;
+
+	rb = ring_buffer__new(bpf_map__fd(bpf->maps.signal_stop_tracing),
+			      handle_rb_event, NULL, NULL);
+	retval = ring_buffer__poll(rb, timeout * 1000);
+	ring_buffer__free(rb);
+
+	return retval;
+}
+
+static int get_value(struct bpf_map *map_irq,
+		     struct bpf_map *map_thread,
+		     struct bpf_map *map_user,
+		     int key,
+		     long long *value_irq,
+		     long long *value_thread,
+		     long long *value_user,
+		     int cpus)
+{
+	int err;
+
+	err = bpf_map__lookup_elem(map_irq, &key,
+				   sizeof(unsigned int), value_irq,
+				   sizeof(long long) * cpus, 0);
+	if (err)
+		return err;
+	err = bpf_map__lookup_elem(map_thread, &key,
+				   sizeof(unsigned int), value_thread,
+				   sizeof(long long) * cpus, 0);
+	if (err)
+		return err;
+	err = bpf_map__lookup_elem(map_user, &key,
+				   sizeof(unsigned int), value_user,
+				   sizeof(long long) * cpus, 0);
+	if (err)
+		return err;
+	return 0;
+}
+
+/*
+ * timerlat_bpf_get_hist_value - get value from BPF hist map
+ */
+int timerlat_bpf_get_hist_value(int key,
+				long long *value_irq,
+				long long *value_thread,
+				long long *value_user,
+				int cpus)
+{
+	return get_value(bpf->maps.hist_irq,
+			 bpf->maps.hist_thread,
+			 bpf->maps.hist_user,
+			 key, value_irq, value_thread, value_user, cpus);
+}
+
+/*
+ * timerlat_bpf_get_summary_value - get value from BPF summary map
+ */
+int timerlat_bpf_get_summary_value(enum summary_field key,
+				   long long *value_irq,
+				   long long *value_thread,
+				   long long *value_user,
+				   int cpus)
+{
+	return get_value(bpf->maps.summary_irq,
+			 bpf->maps.summary_thread,
+			 bpf->maps.summary_user,
+			 key, value_irq, value_thread, value_user, cpus);
+}
+#endif /* HAVE_BPF_SKEL */
diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
new file mode 100644
index 000000000000..f1b54dbddb0e
--- /dev/null
+++ b/tools/tracing/rtla/src/timerlat_bpf.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+enum summary_field {
+	SUMMARY_CURRENT,
+	SUMMARY_MIN,
+	SUMMARY_MAX,
+	SUMMARY_COUNT,
+	SUMMARY_SUM,
+	SUMMARY_OVERFLOW,
+	SUMMARY_FIELD_N
+};
+
+#ifndef __bpf__
+#ifdef HAVE_BPF_SKEL
+int timerlat_bpf_init(struct timerlat_params *params);
+int timerlat_bpf_attach(void);
+void timerlat_bpf_detach(void);
+void timerlat_bpf_destroy(void);
+int timerlat_bpf_wait(int timeout);
+int timerlat_bpf_get_hist_value(int key,
+				long long *value_irq,
+				long long *value_thread,
+				long long *value_user,
+				int cpus);
+int timerlat_bpf_get_summary_value(enum summary_field key,
+				   long long *value_irq,
+				   long long *value_thread,
+				   long long *value_user,
+				   int cpus);
+static inline int have_libbpf_support(void) { return 1; }
+#else
+static inline int timerlat_bpf_init(struct timerlat_params *params)
+{
+	return -1;
+}
+static inline int timerlat_bpf_attach(void) { return -1; }
+static inline void timerlat_bpf_detach(void) { };
+static inline void timerlat_bpf_destroy(void) { };
+static inline int timerlat_bpf_wait(int timeout) { return -1; }
+static inline int timerlat_bpf_get_hist_value(int key,
+					      long long *value_irq,
+					      long long *value_thread,
+					      long long *value_user,
+					      int cpus)
+{
+	return -1;
+}
+static inline int timerlat_bpf_get_summary_value(enum summary_field key,
+						 long long *value_irq,
+						 long long *value_thread,
+						 long long *value_user,
+						 int cpus)
+{
+	return -1;
+}
+static inline int have_libbpf_support(void) { return 0; }
+#endif /* HAVE_BPF_SKEL */
+#endif /* __bpf__ */
-- 
2.48.1

