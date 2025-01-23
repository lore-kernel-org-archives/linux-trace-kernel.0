Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C0913212A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jan 2025 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642254; cv=none; b=PHpOeBAx3BghfBBaK21Q/agXt3oU4dqaejr363FF5NNbNZC3KVmbGeBellrujP32I/yw2Zz5iQrT4wKDiKDjUvP+AYy6FmFU9/mXEn/Jn6irHrODsimROQN5E2Mv0AUKjgGUaaQRyEChdg39RWmJI9uYWccdDMGsvu5o1B0FEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642254; c=relaxed/simple;
	bh=IMohP4nxXlXpvOvpPlcm3f2VRVU7gg21gutf8vCNX1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvSda6nUmKhQv1cbqMXL2toQ9+3OT4mmepSbiZ6hUENLyddoDQJfZN+/cehISrek1MaZPD3a/YMblAJ0ZriR8nHqrn5HURSC1vrsQHABuN+TLVBjWnM131nh6Ac22MYUFfzE5cB6zDe99U6VYhpaszn8HFc84VRQA/uubJnVERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gnojQxqm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnojQxqm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737642252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dT4dlQp+Wmdsq5JvY+uN/CXCmgnXpF4Xhn6I+amVfBY=;
	b=gnojQxqmNHIVQ4yiYX8MIGiSlVzHn0XPgwfnBzw8BGcPsxpqnPMeOAZ8LsgYkRp7uZsXAK
	CNxMU2yr1CwHt5vPFFBk0Okz8xy0GyvI3eI+Z0sQ9Gs5Z/5fiVVyvQFJ8h2rashrC1ZiGY
	b+Q7XHFCOpiXOENHRkkADxpT/9URbd0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-JFJCiLfrNQGIe-wGsz9zNQ-1; Thu,
 23 Jan 2025 09:24:07 -0500
X-MC-Unique: JFJCiLfrNQGIe-wGsz9zNQ-1
X-Mimecast-MFC-AGG-ID: JFJCiLfrNQGIe-wGsz9zNQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4E231955E79;
	Thu, 23 Jan 2025 14:24:06 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C360819560B7;
	Thu, 23 Jan 2025 14:24:04 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 1/4] rtla: Count missed trace events
Date: Thu, 23 Jan 2025 15:23:36 +0100
Message-ID: <20250123142339.990300-2-tglozar@redhat.com>
In-Reply-To: <20250123142339.990300-1-tglozar@redhat.com>
References: <20250123142339.990300-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add function collect_missed_events to trace.c to act as a callback for
tracefs_follow_missed_events, summing the number of total missed events
into a new field missing_events of struct trace_instance.

In case record->missed_events is negative, trace->missed_events is set
to UINT64_MAX to signify an unknown number of events was missed.

The callback is activated on initialization of the trace instance.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/trace.c | 34 ++++++++++++++++++++++++++++++++++
 tools/tracing/rtla/src/trace.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 170a706248ab..69a6bd2b3746 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -126,6 +126,31 @@ collect_registered_events(struct tep_event *event, struct tep_record *record,
 	return 0;
 }
 
+/*
+ * collect_missed_events - record number of missed events
+ *
+ * If rtla cannot keep up with events generated by tracer, events are going
+ * to fall out of the ring buffer.
+ * Collect how many events were missed so it can be reported to the user.
+ */
+static int
+collect_missed_events(struct tep_event *event, struct tep_record *record,
+		      int cpu, void *context)
+{
+	struct trace_instance *trace = context;
+
+	if (trace->missed_events == UINT64_MAX)
+		return 0;
+
+	if (record->missed_events > 0)
+		trace->missed_events += record->missed_events;
+	else
+		/* Events missed but no data on how many */
+		trace->missed_events = UINT64_MAX;
+
+	return 0;
+}
+
 /*
  * trace_instance_destroy - destroy and free a rtla trace instance
  */
@@ -181,6 +206,15 @@ int trace_instance_init(struct trace_instance *trace, char *tool_name)
 	 */
 	tracefs_trace_off(trace->inst);
 
+	/*
+	 * Collect the number of events missed due to tracefs buffer
+	 * overflow.
+	 */
+	trace->missed_events = 0;
+	tracefs_follow_missed_events(trace->inst,
+				     collect_missed_events,
+				     trace);
+
 	return 0;
 
 out_err:
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index c7c92dc9a18a..027cb66f5604 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -17,6 +17,7 @@ struct trace_instance {
 	struct tracefs_instance		*inst;
 	struct tep_handle		*tep;
 	struct trace_seq		*seq;
+	unsigned long long		missed_events;
 };
 
 int trace_instance_init(struct trace_instance *trace, char *tool_name);
-- 
2.48.1

