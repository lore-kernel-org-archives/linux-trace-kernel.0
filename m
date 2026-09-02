Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8D499F1C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352848; cv=none; b=Gda6kAWLYN/lLW5eApRJTOS1GIoqjz0HzXrjZbauqR5j8UNq8z8//9yUnAwF46v+zkDIPHLb1CWjo/I/TRWlLdpQNFY0szfoZuUJrUz+ZYi7g47b6GrLCAi6hZyhmTMNm4WE9DBL+1E8B7wgqGF9zKrb5Hoh3CBqlvlMn1xdZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352848; c=relaxed/simple;
	bh=ZccytlZcaWZYFSyTPqJW0JygOeg9EwNFvjyOxiUQktU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pqpTpNsZ4jTBg02luTuDpjGdo8PKe6QnWf1xVO+4dYu9TKXb2XoHvrwzXTy2vMCJblI8bv5GW3elFdxLNGxN9aN3o38bJuJbXOztyvclHNBFABjNNEkIQbR+DEY5VQvGvE2gwbwRKJ74JOnFDnOZcVcI4bX95U5GWsUa7DPNeqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R25ifaxj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R25ifaxj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788352845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PA6+1++Yl6Rg3Cc+SEzrgVmupmxBw7hIdx8Fpe28Jto=;
	b=R25ifaxj/XEqcF9dWSi3G7jz82SjzRw6YOxFY33JG7aww/ZVuLdJ2qAMnI+2U8yw/iUN91
	EveHbk4Vf2Tvz5bAHrTQSc6AoHmSt0e89905zMOoMyYmFe3fSsUB0qKI7Wjb4yLLDAyyF/
	yL1MJ/XG3QGwo0KHZ80DShvhwSEhC1U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-AMVI-rA0PVuKfpmw534X7g-1; Wed,
 02 Sept 2026 08:40:42 -0400
X-MC-Unique: AMVI-rA0PVuKfpmw534X7g-1
X-Mimecast-MFC-AGG-ID: AMVI-rA0PVuKfpmw534X7g_1788352841
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F6711911B1F;
	Wed,  2 Sep 2026 12:40:41 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.33.19])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F8401955F72;
	Wed,  2 Sep 2026 12:40:37 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 6/8] rtla: Enable and disable events in the user-defined order
Date: Wed,  2 Sep 2026 14:39:35 +0200
Message-ID: <20260902123942.695822-7-vschneid@redhat.com>
In-Reply-To: <20260902123942.695822-1-vschneid@redhat.com>
References: <20260902123942.695822-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: pMiSDOnshwdiDfZkMNp2cW_9teqjwewLQomN8W1gyhM_1788352841
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Events are processed in LIFO order for ease of internal processing, but
this is can be confusing to users if the processing ordering is exposed to
them.

A following commit will do just that by making it so the last-defined event
options (filters/triggers) overrides any previous options for that same
event. Thus, process the events in the user-defined order.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 tools/tracing/rtla/src/trace.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index e407447773d04..17d148f7d5d6e 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -440,6 +440,21 @@ static void trace_event_disable_trigger(struct trace_instance *instance,
 			tevent->event ? : "*", tevent->trigger);
 }
 
+static inline struct trace_events *trace_events_tail(struct trace_events *tevent)
+{
+	while (tevent && tevent->next)
+		tevent = tevent->next;
+
+	return tevent;
+}
+
+/*
+ * Events are stashed in LIFO order; flip that to FIFO to process them in the
+ * same order as they are defined by the user on the command line.
+ */
+#define for_each_trace_event(tevent) \
+	for (tevent = trace_events_tail(tevent); tevent; tevent = tevent->prev)
+
 /*
  * trace_events_disable - disable all trace events
  */
@@ -451,7 +466,7 @@ void trace_events_disable(struct trace_instance *instance,
 	if (!events)
 		return;
 
-	while (tevent) {
+	for_each_trace_event(tevent) {
 		debug_msg("Disabling event %s:%s\n", tevent->system, tevent->event ? : "*");
 		if (tevent->enabled) {
 			trace_event_disable_filter(instance, tevent);
@@ -460,7 +475,6 @@ void trace_events_disable(struct trace_instance *instance,
 		}
 
 		tevent->enabled = 0;
-		tevent = tevent->next;
 	}
 }
 
@@ -544,7 +558,10 @@ int trace_events_enable(struct trace_instance *instance,
 	struct trace_events *tevent = events;
 	int retval;
 
-	while (tevent) {
+	if (!events)
+		return 0;
+
+	for_each_trace_event(tevent) {
 		debug_msg("Enabling event %s:%s\n", tevent->system, tevent->event ? : "*");
 		retval = tracefs_event_enable(instance->inst, tevent->system, tevent->event);
 		if (retval < 0) {
@@ -562,7 +579,6 @@ int trace_events_enable(struct trace_instance *instance,
 			return 1;
 
 		tevent->enabled = 1;
-		tevent = tevent->next;
 	}
 
 	return 0;
-- 
2.55.0

