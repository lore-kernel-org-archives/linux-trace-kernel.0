Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B4421578D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183010; cv=none; b=T79IelfO+GI9PRNlc75KBot7b2SKBZUU+xciRwZgGDKHnDjsPR0dR0zX5Nus0VY7NU+jnoJU2H1cl9FO2B+1NwXHD23LbF3EYxDA4booR2QbapnZcwGbeqTc3ETi5YBZav1zXzb2tVbogcUMhmOISYPA5iVC4+wdrTtSwkfFcD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183010; c=relaxed/simple;
	bh=B1apLdGdbSeS7TZ9uWJagJsoGYG3fb4E+Tmcww/wsEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSoqUczJNCjProTU0dfMgXD7bNFq3PYAXkDzU5z9kSl3DbNoXFc0YmPqTR20f3ktNJ2yGChO+ZVvd5x2aTE/FQJq9JKSpl0iIR2o6rgVzHBk68Omt/npoKEK7xLmp5MrLD+l52IuaIMxqnzGKSLGaUu+1OAt9UgTjol+dsyvwx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwnARA7u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwnARA7u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769183008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XChOJQVNTKzLAzN/OE5pi3ush6z4OzNOlNgezYKdP9s=;
	b=GwnARA7unABrnWPu1oYDSuAWQY0fwJCOEUBmFNHrQMBxEB64ydCffQo38Zrful1Zx7DgBb
	33OT96QPVfqhnsEl75H6mPiGBo6LLiiA02YyP7yxf2gTJX78bbI0k8b/pC903DwjgsOCHq
	+w6IVAPrkgbbNLu5mUJABVvXWcxx5Os=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-zzfGPp-TNKqfiHwHjfYDUA-1; Fri,
 23 Jan 2026 10:43:23 -0500
X-MC-Unique: zzfGPp-TNKqfiHwHjfYDUA-1
X-Mimecast-MFC-AGG-ID: zzfGPp-TNKqfiHwHjfYDUA_1769183002
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1ACC1956094;
	Fri, 23 Jan 2026 15:43:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.59])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8DA9018004D8;
	Fri, 23 Jan 2026 15:43:19 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [RFC PATCH 1/3] tracing/osnoise: Record timerlat instance counts
Date: Fri, 23 Jan 2026 16:25:32 +0100
Message-ID: <20260123152534.1036533-2-tglozar@redhat.com>
In-Reply-To: <20260123152534.1036533-1-tglozar@redhat.com>
References: <20260123152534.1036533-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

While recording a timerlat sample, track how many timerlat instances are
registered at the moment and how many instances have tracing on.

This enables a user of the timerlat_sample threshold to synchronize with
any users of the timerlat tracer instance buffer.

Note that this also reverses the order in which the trace buffer record
and the tracepoint are processed: the tracepoint now fires after the
trace buffer entries are recorded.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 include/trace/events/osnoise.h | 14 ++++++++++----
 kernel/trace/trace_osnoise.c   | 10 ++++++++--
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/osnoise.h b/include/trace/events/osnoise.h
index 3f4273623801..50beaf8fbb52 100644
--- a/include/trace/events/osnoise.h
+++ b/include/trace/events/osnoise.h
@@ -79,26 +79,32 @@ TRACE_EVENT(osnoise_sample,
 #ifdef CONFIG_TIMERLAT_TRACER
 TRACE_EVENT(timerlat_sample,
 
-	TP_PROTO(struct timerlat_sample *s),
+	TP_PROTO(struct timerlat_sample *s, int instances_registered, int instances_on),
 
-	TP_ARGS(s),
+	TP_ARGS(s, instances_registered, instances_on),
 
 	TP_STRUCT__entry(
 		__field(	u64,		timer_latency	)
 		__field(	unsigned int,	seqnum		)
 		__field(	int,		context		)
+		__field(	int,		instances_registered	)
+		__field(	int,		instances_on		)
 	),
 
 	TP_fast_assign(
 		__entry->timer_latency = s->timer_latency;
 		__entry->seqnum = s->seqnum;
 		__entry->context = s->context;
+		__entry->instances_registered = instances_registered;
+		__entry->instances_on = instances_on;
 	),
 
-	TP_printk("timer_latency=%llu seqnum=%u context=%d",
+	TP_printk("timer_latency=%llu seqnum=%u context=%d instances_registered=%d instances_on=%d",
 		  __entry->timer_latency,
 		  __entry->seqnum,
-		  __entry->context)
+		  __entry->context,
+		  __entry->instances_registered,
+		  __entry->instances_on)
 );
 #endif // CONFIG_TIMERLAT_TRACER
 
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 827104d00bc0..65ddc1f49c19 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -574,15 +574,21 @@ static void record_timerlat_sample(struct timerlat_sample *sample)
 {
 	struct osnoise_instance *inst;
 	struct trace_buffer *buffer;
-
-	trace_timerlat_sample(sample);
+	int instances_registered = 0;
+	int instances_on = 0;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
+		if (tracer_tracing_is_on(inst->tr))
+			instances_on++;
+		instances_registered++;
+
 		buffer = inst->tr->array_buffer.buffer;
 		__record_timerlat_sample(sample, buffer);
 	}
 	rcu_read_unlock();
+
+	trace_timerlat_sample(sample, instances_registered, instances_on);
 }
 
 #ifdef CONFIG_STACKTRACE
-- 
2.52.0

