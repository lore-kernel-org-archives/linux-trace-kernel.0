Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ECE20CCFB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437727; cv=none; b=aXwMNE2/WM9zWJtZD5WYNDYAH7tMCrWFmjrxC7/ilV6pggmG6TRA5+lmOtiotvXy1BR7DIAm5qtisVJoSgky8LS2+ToGZTQeOpJAy8myXWE7ayESI2m7vDKZTC199CpNPVmpGP25kULfK92ZEG5HsY05NYIjEwBad7k2HiTvR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437727; c=relaxed/simple;
	bh=7lxebOFXavNgwYliJWTj9B1sZfiJGlwD+50awa3TdEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/F1WrU9kSewbjiTjIsihAQze+7DXyUdT//dOFdOw6lS68+P5x3q/dt8kNEWW1RC7ND3Zu7dii431QhgdI2cH0lyeH82o0Ln9dA9QU79W0LZ4vZitT/JRo1NSXkuhADlZn9Wx33PSKQ9J1rSsF7tJOdizlVVYjj9KV12WYrXM5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3sRjHkC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3sRjHkC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739437724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PP1VZXHqFJNyImLW6DDg7WEg0AroZyzUn2EupOxrJE=;
	b=Y3sRjHkCoYG0yW2HEsXOrGpPU/8IL5a7j1gMu8uEf8xJl0zuVrscfTiUvPo9cFXcwS3+X2
	fGBX6xcYPFV8ChBBQ1xDxE3Nw/hlJY9YtINzkhoE9ptiPiCN5sHjW3aowRwDHVijImNdra
	meXogrrz9zIB+2PwKwmrxv/JKt81tuQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-WNW271jBO42wUqNuEFTJuA-1; Thu,
 13 Feb 2025 04:08:41 -0500
X-MC-Unique: WNW271jBO42wUqNuEFTJuA-1
X-Mimecast-MFC-AGG-ID: WNW271jBO42wUqNuEFTJuA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A744D1955F28;
	Thu, 13 Feb 2025 09:08:39 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.81])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C7D81800360;
	Thu, 13 Feb 2025 09:08:35 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2 01/11] tracing: Fix DECLARE_TRACE_CONDITION
Date: Thu, 13 Feb 2025 10:07:59 +0100
Message-ID: <20250213090819.419470-2-gmonaco@redhat.com>
In-Reply-To: <20250213090819.419470-1-gmonaco@redhat.com>
References: <20250213090819.419470-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

