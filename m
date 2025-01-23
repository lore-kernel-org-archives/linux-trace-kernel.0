Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D181F212B06
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jan 2025 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642257; cv=none; b=GrCP9es0qrJHrrnSrhXlb0AETcPQnaH6ysD/3xPnTMirtMjCBuzWbXxLb7QMF03cpvhl/k4Rj/120xflfWHUI8CHKa7pyJ29O8ULPZ7KbC4FDVOMySwp4pBeKOhy9h4qFcHiJOTBzJQLJ78HytTlzM2lctW7R5vMq7vQuLCWw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642257; c=relaxed/simple;
	bh=KFacXVY20Z1ZBEoE3aEgahE48ouQmhHcclOIAicpfuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQZYI/vjrQDSl24wf7s9gRlZjo+azWNnY3OZN7hBcP9SbRSPiXnDjBgb0Bfgz8mPyapecO3d488i2Ti4iQ1h1MW3Eanqe2mPE1SVNciftd32hPROCROp6jOA80OaUmFRvSxxG3ZDFt94wn3TLMIB8UsexH/QHsJgppXiSvUI7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jAHtVnxQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAHtVnxQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737642254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E46xhR1nOOiB1w8q52hc3gVyDXW6MKx7w+hnQxPf0/U=;
	b=jAHtVnxQ4sPGnvQuOb3UsN5fqm5gC8rNFxAZD+6w9PGGj+kdtGJa0c38kau8053Mc8nwIp
	fkLcGZhRC/3IlKz3YjnXLNXil8Qzi/gXp3PIkJDWgKWc/fD/t8W7qoPBs7g593cFO1GhQb
	lFSqXhJjzW5FH3cvfNxHmDS3GZs6dAY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-In4myt4jNmuX8EryDf4ygQ-1; Thu,
 23 Jan 2025 09:24:11 -0500
X-MC-Unique: In4myt4jNmuX8EryDf4ygQ-1
X-Mimecast-MFC-AGG-ID: In4myt4jNmuX8EryDf4ygQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72B6719560B3;
	Thu, 23 Jan 2025 14:24:10 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 569E9195E3D9;
	Thu, 23 Jan 2025 14:24:07 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/4] rtla: Count all processed events
Date: Thu, 23 Jan 2025 15:23:37 +0100
Message-ID: <20250123142339.990300-3-tglozar@redhat.com>
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

Add a field processed_events to struct trace_instance and increment it
in collect_registered_events, regardless of whether a handler is
registered for the event.

The purpose is to calculate the percentange of events that were missed
due to tracefs buffer overflow.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/trace.c | 4 ++++
 tools/tracing/rtla/src/trace.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 69a6bd2b3746..b9c4b6c2ce79 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -118,6 +118,8 @@ collect_registered_events(struct tep_event *event, struct tep_record *record,
 	struct trace_instance *trace = context;
 	struct trace_seq *s = trace->seq;
 
+	trace->processed_events++;
+
 	if (!event->handler)
 		return 0;
 
@@ -215,6 +217,8 @@ int trace_instance_init(struct trace_instance *trace, char *tool_name)
 				     collect_missed_events,
 				     trace);
 
+	trace->processed_events = 0;
+
 	return 0;
 
 out_err:
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index 027cb66f5604..2fd96cf36ce7 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -18,6 +18,7 @@ struct trace_instance {
 	struct tep_handle		*tep;
 	struct trace_seq		*seq;
 	unsigned long long		missed_events;
+	unsigned long long		processed_events;
 };
 
 int trace_instance_init(struct trace_instance *trace, char *tool_name);
-- 
2.48.1

