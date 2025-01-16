Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B613C22D4D2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039002; cv=none; b=beW3DrIrYOoZP8MDBcCLLwXi8glq/iv/lKnZovK9vO0Z1p9CjBY6OXDrepDwbABD+bjqbq69jP03lgip83hOpZhI4bEpbCNWvhbUg9z8zjH8hSbtcTdELT4TUGPasYm2SiSnFUJjPBljVk/Q3T3h0YZlcWjz276nSGQXnrNJPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039002; c=relaxed/simple;
	bh=eXU4eDJAiamJRuR+6S2I3SUCuOJ+Y2hxbM89zmDUtO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNuh2Sc8tpaBtxOwSjTs0RqULIhZ5jVX3Esw2EN09VImOkJtF7HkdO8vQiGmninuymr6CFtRaO5U9HTGtUpFxH474Pv4wHFjlUHSHNSnnw/1mghz9mVDX35d7DkgiCzupDRr000wbA8H+2O2OOe/7UA7Bi23P3f/uYxG5n2g7go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXik5zNa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXik5zNa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737038999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OV9Fq3atwZdfSKyP9etV+P8SOmdjLcTXf5dOUOGY3Q=;
	b=iXik5zNaKESsIPKG/dWSWQ/eGfNmXobWoqPdnHJu0NW2TwEmxoZjRSpZcyPl6/0sLXh6E2
	cM4rNYdjGl1CQ90ph53MurgTRgSLf/Pc5f4w6so7XdRxsSFa5WDZxFAajc1Oyoa9b89pv/
	Z4ZLy1Yuz0MlfyfA9i1gPBB1WJtvQFY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-wmE4v85sP2mkLXJZRI6S9A-1; Thu,
 16 Jan 2025 09:49:58 -0500
X-MC-Unique: wmE4v85sP2mkLXJZRI6S9A-1
X-Mimecast-MFC-AGG-ID: wmE4v85sP2mkLXJZRI6S9A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F7911955DCD;
	Thu, 16 Jan 2025 14:49:57 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9485819560BF;
	Thu, 16 Jan 2025 14:49:54 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 1/5] rtla: Add trace_instance_stop
Date: Thu, 16 Jan 2025 15:49:27 +0100
Message-ID: <20250116144931.649593-2-tglozar@redhat.com>
In-Reply-To: <20250116144931.649593-1-tglozar@redhat.com>
References: <20250116144931.649593-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Support not only turning trace on for thet timerlat tracer, but also
turning it off.

This will be used in subsequent patches to stop the timerlat tracer
without also wiping the trace buffer.

Cc: stable@vger.kernel.org
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/trace.c | 8 ++++++++
 tools/tracing/rtla/src/trace.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 170a706248ab..440323a997c6 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -196,6 +196,14 @@ int trace_instance_start(struct trace_instance *trace)
 	return tracefs_trace_on(trace->inst);
 }
 
+/*
+ * trace_instance_stop - stop tracing a given rtla instance
+ */
+int trace_instance_stop(struct trace_instance *trace)
+{
+	return tracefs_trace_off(trace->inst);
+}
+
 /*
  * trace_events_free - free a list of trace events
  */
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index c7c92dc9a18a..76e1b77291ba 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -21,6 +21,7 @@ struct trace_instance {
 
 int trace_instance_init(struct trace_instance *trace, char *tool_name);
 int trace_instance_start(struct trace_instance *trace);
+int trace_instance_stop(struct trace_instance *trace);
 void trace_instance_destroy(struct trace_instance *trace);
 
 struct trace_seq *get_trace_seq(void);
-- 
2.47.1

