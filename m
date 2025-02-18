Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2452024397E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881901; cv=none; b=bxIAGld2g1n8qeWLCwzTicdLM66o2FvRSLoz070U19zJg/c/1sUhO+l+2M/uD0pRKOnyY6SF90iAJ1koCsiitktdLZVVYqiHo116lxQsGtykW9xtaxdcsKNkPG4VInZOfyXImzZ4Gu+lA6QxdWSvalmHBYosLSFeciutxBMvNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881901; c=relaxed/simple;
	bh=7lxebOFXavNgwYliJWTj9B1sZfiJGlwD+50awa3TdEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leLonExPsRQySe9MmQje0K6RSU9fj5IdaTyZjtx4LRWhGYxs5b27/V2fwcnkya7N0soBrV6QxGkhOLb7V5SAVGdIQVADApUZpahgUxJ1LsgEB2RTYCc0Wfh8DEKy4MckGWlRwutiARCRKjiWdt3jmQoe3KYD4mcYf1bMlfEM82w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/Js8j8p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/Js8j8p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739881899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PP1VZXHqFJNyImLW6DDg7WEg0AroZyzUn2EupOxrJE=;
	b=h/Js8j8pO4dju3Smz7bCUPeEJ7atjJxT/gHLSDwNtgK3bENkPzCBrAB6Fby/0uMmC3u8SH
	mBE4l4egVtLAU2/eyLzID3tQiPqHysigPKvyCiQ/15qHzfB+xPNn5dFbkAGs4c3/CzT6qC
	LlNXaUF771zaugEZH5eBB3vXxb39F0U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-4Z6th3mmNAu6S5hECWY-Rg-1; Tue,
 18 Feb 2025 07:31:35 -0500
X-MC-Unique: 4Z6th3mmNAu6S5hECWY-Rg-1
X-Mimecast-MFC-AGG-ID: 4Z6th3mmNAu6S5hECWY-Rg_1739881894
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DEA6180036F;
	Tue, 18 Feb 2025 12:31:34 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.33.84])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50233180056F;
	Tue, 18 Feb 2025 12:31:30 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v4 01/11] tracing: Fix DECLARE_TRACE_CONDITION
Date: Tue, 18 Feb 2025 13:31:06 +0100
Message-ID: <20250218123121.253551-2-gmonaco@redhat.com>
In-Reply-To: <20250218123121.253551-1-gmonaco@redhat.com>
References: <20250218123121.253551-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Commit 287050d39026 ("tracing: Add TRACE_EVENT_CONDITIONAL()") adds
macros to define conditional trace events (TRACE_EVENT_CONDITIONAL) and
tracepoints (DECLARE_TRACE_CONDITION), but sets up functionality for
direct use only for the former.

Add preprocessor bits in define_trace.h to allow usage of
DECLARE_TRACE_CONDITION just like DECLARE_TRACE.

Fixes: 287050d39026 ("tracing: Add TRACE_EVENT_CONDITIONAL()")
Link: https://lore.kernel.org/linux-trace-kernel/20250128111926.303093-1-gmonaco@redhat.com
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/trace/define_trace.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index e1c1079f8c8db..ed52d0506c69f 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -76,6 +76,10 @@
 #define DECLARE_TRACE(name, proto, args)	\
 	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
+#undef DECLARE_TRACE_CONDITION
+#define DECLARE_TRACE_CONDITION(name, proto, args, cond)	\
+	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
+
 /* If requested, create helpers for calling these tracepoints from Rust. */
 #ifdef CREATE_RUST_TRACE_POINTS
 #undef DEFINE_RUST_DO_TRACE
@@ -108,6 +112,8 @@
 /* Make all open coded DECLARE_TRACE nops */
 #undef DECLARE_TRACE
 #define DECLARE_TRACE(name, proto, args)
+#undef DECLARE_TRACE_CONDITION
+#define DECLARE_TRACE_CONDITION(name, proto, args, cond)
 
 #ifdef TRACEPOINTS_ENABLED
 #include <trace/trace_events.h>
@@ -129,6 +135,7 @@
 #undef DEFINE_EVENT_CONDITION
 #undef TRACE_HEADER_MULTI_READ
 #undef DECLARE_TRACE
+#undef DECLARE_TRACE_CONDITION
 
 /* Only undef what we defined in this file */
 #ifdef UNDEF_TRACE_INCLUDE_FILE
-- 
2.48.1

