Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793599;
	b=40zvcU3sPVurvpgzThRa4LzxGkvA35gtR7I2rAsYfnI1UJdd4c+1mpJpUpTWy+h/jdh3
	 3eXa1Rh9G6U8Yw0NcM1QuafqMn7P/8DT1GPbqcjrcgAxWsC3NJxfzDf6xV9dK44wKUHUq
	 hUOB2KPCxvGT+fD5gY96jII2zJ135GnLdKL9cGiimuMRFxYLUymK8fPlr2fUGpSUCNUcG
	 xCQ6BRaShXMCOo3dxVSn54dyfPzNADRAu5P56WIw2NoHywP7L+TFdOEjhLNzEQ338QfHB
	 Fque/gzSxVWKHke37mOXHI8HbjALsVrb689UqoF4Luhxlx1BLbyaezVeJ0gJS0cFmrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793599;
	h=DMARC-Filter:DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=YG5qQ8Px/+gMqscHRPi1XkagjpMh1bgQ0AcpnW31odA=;
	b=IwD/MJ6G8aZSrMvVS4MUvoz+cTg8ejaeTNqoQEmX3UhoBg3/Tzilkbu0NQknsxfD6zg7
	 Y4VXmx882EgcTViJr7Vtuazs0YTY75MN/0ZZrOFQBfqJf8+RDvv0aSz1cFsIn2ABexFaL
	 ySf85oCJvGxkIPORPr215kK6O7/5rvUEndvJw2P8WZQXEIEiFES+4QpybPwyRuhuk/MUb
	 xKxVCtR0iiwAJ3HYebF+T5HS9O7HHC+z5vIVD5lIFUYS5ntwQS+geoGlXknHd+sdmOKS2
	 6e5+jBcEn8EUlHi5+4RVAoK3l2Y7l5nuLbQdO03H/dKFZRNMPz4rCTwcjoDZbpaScfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hgbvH5U+;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E2606A334
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E71E2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hgbvH5U+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795793599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YG5qQ8Px/+gMqscHRPi1XkagjpMh1bgQ0AcpnW31odA=;
	b=hgbvH5U+JP8rADb7Awml9QVzyqHP2fioe1MZLI8ZmYLbT5UkO48cM4Y/33qemeBfBYVRQ5
	AYznlGjIdM3xnpGcJnnwl5CYagVzXaKuHezYC9a7FF9xNkIqarpPrtQWn5nSiVpoJ4w4Xa
	kon6+lscAwSPAScZuUCe/wLIfvgaHKc=
X-MC-Rep: binary re single
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-b9nGg3LYM_GvkgQcoW8i_w-1; Fri,
 27 Nov 2026 15:33:16 +0000
X-MC-Unique: b9nGg3LYM_GvkgQcoW8i_w-1
X-Mimecast-MFC-AGG-ID: b9nGg3LYM_GvkgQcoW8i_w_1795793595
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53D901954235;
	Fri, 27 Nov 2026 15:33:15 +0000 (UTC)
Received: from tglozar-thinkpadt14gen5.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5DBD1955F76;
	Fri, 27 Nov 2026 15:33:12 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH 07/10] rtla/trace: Allow storing start clock value of tracefs instances
Date: Fri, 27 Nov 2026 16:32:03 +0100
Message-ID: <20261127153206.134322-8-tglozar@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 7YJqoQUcLsaATBcmoVcsRlE2F497iEtfi6fTrtwDM5A_1795793595
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add a per-CPU start_ts array to struct trace_instance, allocated and
freed with the instance, and helpers to save the current clock into it
and to copy it between instances.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/trace.c | 36 ++++++++++++++++++++++++++++++++++
 tools/tracing/rtla/src/trace.h |  4 ++++
 2 files changed, 40 insertions(+)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index a007479768f99..1885219cdb589 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -200,6 +200,11 @@ void trace_instance_destroy(struct trace_instance *trace)
 		tep_free(trace->tep);
 		trace->tep = NULL;
 	}
+
+	if (trace->start_ts) {
+		free(trace->start_ts);
+		trace->start_ts = NULL;
+	}
 }
 
 /*
@@ -219,6 +224,8 @@ int trace_instance_init(struct trace_instance *trace, char *tool_name)
 
 	trace_seq_init(trace->seq);
 
+	trace->start_ts = calloc_fatal(nr_cpus, sizeof(*trace->start_ts));
+
 	trace->inst = create_instance(tool_name);
 	if (!trace->inst)
 		goto out_err;
@@ -276,6 +283,35 @@ int trace_instance_clear(struct trace_instance *trace)
 	return tracefs_instance_file_write(trace->inst, "trace", "");
 }
 
+/*
+ * trace_instance_save_start - save the start timestamp of a given instance
+ * @trace: the trace instance
+ * @cpus: the set of CPUs to read
+ *
+ * Read the current timestamp of each CPU in @cpus and store it in the
+ * instance's start_ts array. Must be called before tracing is enabled.
+ *
+ * Returns 0 on success, -1 if any CPU could not be read.
+ */
+int trace_instance_save_start(struct trace_instance *trace, const cpu_set_t *cpus)
+{
+	return trace_get_now_ts_cpus(trace->inst, cpus, trace->start_ts);
+}
+
+/*
+ * trace_instance_copy_start - copy the start timestamps between instances
+ * @dst: the destination trace instance
+ * @src: the source trace instance
+ *
+ * The per-CPU clock is not tied to a trace instance, so the timestamps
+ * captured for one instance are valid for every other instance as well.
+ */
+void trace_instance_copy_start(struct trace_instance *dst,
+			       const struct trace_instance *src)
+{
+	memcpy(dst->start_ts, src->start_ts, nr_cpus * sizeof(*src->start_ts));
+}
+
 /*
  * trace_get_cpu_now_ts - get the current timestamp of a CPU
  * @inst: the trace instance, NULL for the top instance
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index ad9eaaa61b77a..5a3cdb14f86a7 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -19,6 +19,7 @@ struct trace_instance {
 	struct tracefs_instance		*inst;
 	struct tep_handle		*tep;
 	struct trace_seq		*seq;
+	unsigned long long		*start_ts;
 	unsigned long long		missed_events;
 	unsigned long long		invalid_events;
 	unsigned long long		processed_events;
@@ -28,6 +29,9 @@ int trace_instance_init(struct trace_instance *trace, char *tool_name);
 int trace_instance_start(struct trace_instance *trace);
 int trace_instance_stop(struct trace_instance *trace);
 int trace_instance_clear(struct trace_instance *trace);
+int trace_instance_save_start(struct trace_instance *trace, const cpu_set_t *cpus);
+void trace_instance_copy_start(struct trace_instance *dst,
+			       const struct trace_instance *src);
 void trace_instance_destroy(struct trace_instance *trace);
 
 struct trace_seq *get_trace_seq(void);
-- 
2.56.1

