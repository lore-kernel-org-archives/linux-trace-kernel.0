Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793596;
	b=ty6DD3T0horr9vuPdbnKJdAPXONgEs66pnAnB6eCFaV5U84VCI4mdmrXRgHaeEIJXLY+
	 TnVyqRiImgflCNSKpMQJOh3D4HUHw7X2Rg7fQRE9mpatR6MTzD6ZMtWdSxufXykmhSdm6
	 oCzqiE2liwwOOzv2EDAHblT9qKDbRQ8naXJIGDo3g1f1PneZ4PjAlRwjoJ2ruop4NAdk9
	 aVEObBm55OJ2cwa2yr1V4tQHGbzgKQ6zLt47QB29Cllp+SA4rRyBi4A6TygSawVF+gdbZ
	 4/6J+U09F/Iog/hDZGjsv+btIrDHS0Mvy/KQVkPjwYVUvt6LRI3hvs5xZK8spwB+LMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793596;
	h=DMARC-Filter:DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=sL377G+mE3vmudKuUPYDMLQhDlpun0NQIgwkwOtAIGY=;
	b=hGCsq1GZiBMYPFcbrdA5VLm4OTdypozMdQqpJiJN5nUPeQ+lMA/11liZZBDgkZYTyyXs
	 wF9rr/RNYZ3ruIlPtCfmsznzuyceGuzUQMoJxiE8XmLBT896mqLFPIVsIbuY0jB5fP0um
	 JoLyeF/SgFDfQvExYJGtslAWu78TZlB5p8QsQ3/iSrY/uLI1uKlC8PDaIIvwF2lueQNrV
	 4sk5mSE6uQv5lmuV4wWY+37I2Rf0nWXeN9CXKGWJhGi+SewTIi5moM82eRl46O4lrgFxp
	 uMH8Xisj7TRyV01FhlZ8k4WjwghqC+hjcUupxNbDeh/V1pcFoh/Pb6VkRzJDLjvkanQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BH13ngmV;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA6606A323
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1CA6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BH13ngmV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795793595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sL377G+mE3vmudKuUPYDMLQhDlpun0NQIgwkwOtAIGY=;
	b=BH13ngmVgBJImOsI3QAxEOpT7FEMVKaJNpMHUVt5SOL4pCu5PX4TDvWWvCKtQaD22+846A
	VPD2zcSutpnBIBqsTBhs+rnoCLPhIMDPBkbm6PmmyfiSUoTvBzvsLpznvkD0XolhlAWnra
	XJhKviUXCmVo6IEL6P2g9Eu1uxD6iHA=
X-MC-Rep: binary re single
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-V3ckFAX6MP2uD7s6anIjwA-1; Fri,
 27 Nov 2026 15:33:13 +0000
X-MC-Unique: V3ckFAX6MP2uD7s6anIjwA-1
X-Mimecast-MFC-AGG-ID: V3ckFAX6MP2uD7s6anIjwA_1795793592
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60A331955F1E;
	Fri, 27 Nov 2026 15:33:12 +0000 (UTC)
Received: from tglozar-thinkpadt14gen5.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A4351955F76;
	Fri, 27 Nov 2026 15:33:09 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH 06/10] rtla/trace: Add helper to gather "now ts" over a CPU set
Date: Fri, 27 Nov 2026 16:32:02 +0100
Message-ID: <20261127153206.134322-7-tglozar@redhat.com>
In-Reply-To: <20261127153206.134322-1-tglozar@redhat.com>
References: <20261127153206.134322-1-tglozar@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MofJF75NPjzW_H4wmW7Y2o1Ao0sYLXnn8xSlTrZ843Y_1795793592
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add trace_get_now_ts_cpus() to read the current timestamp of a set of
CPUs. One thread is spawned per CPU; each thread pins itself to its CPU
and reads the clock there, storing the value in its own per-CPU slot of
the output array.

Reading the clock from a thread pinned to the target CPU avoids
migrating the calling thread around, keeping its affinity untouched.

The threads are held behind a gate until all of them have been created,
then released together by a barrier, so the clock reads happen at nearly
the same time.

CPUs that cannot be pinned or read are left at 0, and the helper returns
-1, while still filling the CPUs that succeeded.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/trace.c | 140 +++++++++++++++++++++++++++++++++
 tools/tracing/rtla/src/trace.h |   3 +
 2 files changed, 143 insertions(+)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index e068f25759c00..a007479768f99 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -4,6 +4,7 @@
 #include <tracefs.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <pthread.h>
 #include <errno.h>
 
 #include "trace.h"
@@ -317,6 +318,145 @@ int trace_get_cpu_now_ts(struct tracefs_instance *inst, int cpu,
 	return ret;
 }
 
+struct trace_cpu_ts_ctx {
+	pthread_mutex_t mutex;
+	pthread_cond_t cond;
+	pthread_barrier_t barrier;
+	bool go;
+	bool abort;
+};
+
+struct trace_cpu_ts_arg {
+	struct tracefs_instance *inst;
+	unsigned long long *ts;
+	struct trace_cpu_ts_ctx *ctx;
+	pthread_t thread;
+	bool created;
+	int cpu;
+	int retval;
+};
+
+static void *trace_cpu_ts_thread(void *data)
+{
+	struct trace_cpu_ts_arg *arg = data;
+	struct trace_cpu_ts_ctx *ctx = arg->ctx;
+	cpu_set_t affinity;
+	bool pinned;
+
+	CPU_ZERO(&affinity);
+	CPU_SET(arg->cpu, &affinity);
+
+	/*
+	 * Never read the clock without being pinned: the timestamp would be
+	 * the one of whichever CPU this thread happens to be running on.
+	 * A failure to pin must still reach the barrier, or the other threads
+	 * would wait forever.
+	 */
+	pinned = !sched_setaffinity(0, sizeof(affinity), &affinity);
+
+	pthread_mutex_lock(&ctx->mutex);
+	while (!ctx->go)
+		pthread_cond_wait(&ctx->cond, &ctx->mutex);
+	pthread_mutex_unlock(&ctx->mutex);
+
+	if (ctx->abort)
+		return NULL;
+
+	pthread_barrier_wait(&ctx->barrier);
+
+	if (pinned)
+		arg->retval = trace_get_cpu_now_ts(arg->inst, arg->cpu,
+						   &arg->ts[arg->cpu]);
+	return NULL;
+}
+
+/*
+ * trace_get_now_ts_cpus - get the current timestamp of a set of CPUs
+ * @inst: the trace instance, NULL for the top instance
+ * @cpus: the set of CPUs to read
+ * @ts: output array with nr_cpus entries, indexed by CPU
+ *
+ * Spawn a thread for each CPU in @cpus. Each thread pins itself to its CPU
+ * and reads the clock there, writing the timestamp to its own ts[cpu] slot.
+ * CPUs that cannot be read are left at 0.
+ *
+ * The threads are held after pinning until all of them were created, then
+ * released together by a barrier, so that the per-CPU clock readings happen
+ * at (nearly) the same time.
+ *
+ * Returns 0 on success, -1 if any CPU in @cpus could not be read.
+ */
+int trace_get_now_ts_cpus(struct tracefs_instance *inst, const cpu_set_t *cpus,
+			  unsigned long long *ts)
+{
+	struct trace_cpu_ts_ctx ctx = {
+		.mutex = PTHREAD_MUTEX_INITIALIZER,
+		.cond = PTHREAD_COND_INITIALIZER,
+	};
+	struct trace_cpu_ts_arg *args;
+	int cpu, count = 0, ret = 0;
+
+	args = calloc_fatal(nr_cpus, sizeof(*args));
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		if (!CPU_ISSET(cpu, cpus))
+			continue;
+
+		ts[cpu] = 0;
+
+		args[cpu].inst = inst;
+		args[cpu].ts = ts;
+		args[cpu].ctx = &ctx;
+		args[cpu].cpu = cpu;
+		args[cpu].retval = -1;
+
+		if (pthread_create(&args[cpu].thread, NULL, trace_cpu_ts_thread,
+				   &args[cpu])) {
+			debug_msg("Could not create thread for cpu %d\n", cpu);
+			ret = -1;
+			continue;
+		}
+
+		args[cpu].created = true;
+		count++;
+	}
+
+	if (count) {
+		/*
+		 * The barrier can only be sized now that the number of created
+		 * threads is known. If it cannot be set up, release the threads
+		 * without reading the clock.
+		 */
+		if (pthread_barrier_init(&ctx.barrier, NULL, count)) {
+			debug_msg("Could not initialize thread barrier\n");
+			ctx.abort = true;
+		}
+
+		pthread_mutex_lock(&ctx.mutex);
+		ctx.go = true;
+		pthread_cond_broadcast(&ctx.cond);
+		pthread_mutex_unlock(&ctx.mutex);
+	}
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		if (!args[cpu].created)
+			continue;
+
+		pthread_join(args[cpu].thread, NULL);
+		if (args[cpu].retval)
+			ret = -1;
+	}
+
+	if (count && !ctx.abort)
+		pthread_barrier_destroy(&ctx.barrier);
+	pthread_cond_destroy(&ctx.cond);
+	pthread_mutex_destroy(&ctx.mutex);
+
+	free(args);
+
+	return ret;
+}
+
 /*
  * trace_events_free - free a list of trace events
  */
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index 4ec8259ccdd71..ad9eaaa61b77a 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <tracefs.h>
 #include <stddef.h>
+#include <sched.h>
 
 struct trace_events {
 	struct trace_events *next;
@@ -39,6 +40,8 @@ void destroy_instance(struct tracefs_instance *inst);
 int save_trace_to_file(struct tracefs_instance *inst, const char *filename);
 int trace_get_cpu_now_ts(struct tracefs_instance *inst, int cpu,
 			 unsigned long long *ts);
+int trace_get_now_ts_cpus(struct tracefs_instance *inst, const cpu_set_t *cpus,
+			  unsigned long long *ts);
 int collect_registered_events(struct tep_event *tep, struct tep_record *record,
 			      int cpu, void *context);
 
-- 
2.56.1

