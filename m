Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7A19DFA5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Jan 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738063196; cv=none; b=YnmTwE2x2F6hE0DhTe5qkOaOAfjsdG1+cpwCpfIOIJksv0hhTbVdS3FYLe0XBHaaOjKcaoh4I4ZYqQLDnaOSi1dVeSHUqK0YQuZhpgq9j0FFyduM6XUwWZ3MdtTZ2oll8Htr2wfnF+BRxc/Ph72Hm+EmbfBZduV98HPpfYfGdYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738063196; c=relaxed/simple;
	bh=JniHcGAvnt8DXzw5ROzdFmRwdCcds2G6y2PelLRKYcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rzclt6L7F030mgx/uk8CEQMssmbGhBNDoTuzjJ8H4/nL2nlYYNniaYLoYDThSV97NHg9VRStgqzZ/Jzc4d1haRo5na0lRCIgIrhP7YlotmTgoo5VSCtpegivy3R4T5XthImxOUiTm3frSoJMBrDuxyyq2dFFPj8yseJhTwN/+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tj+uT/7O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tj+uT/7O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738063193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DgODQwACdIA74cHoET43eABvQJ3HScrz4Yv4f+hZQ7U=;
	b=Tj+uT/7OQc1OGp9gFtyrAcs01q6qBhH84zUwvCU2ZUp63nsfsaF7mqmrRQEVLPHTahFsnT
	5gAwmuY5izToI4mmf4x6Pwd/VKnMX1/Ac2ECSyAf/XahPifcBsFGUke2DGkvP41uHIG5bJ
	VS7Dqdbztptd2xEZVUZYQ4jklfQyd2o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-GTxJklr4MS2oJmWaLNseeA-1; Tue,
 28 Jan 2025 06:19:49 -0500
X-MC-Unique: GTxJklr4MS2oJmWaLNseeA-1
X-Mimecast-MFC-AGG-ID: GTxJklr4MS2oJmWaLNseeA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 131251801F1B;
	Tue, 28 Jan 2025 11:19:48 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.193.107])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95E221800358;
	Tue, 28 Jan 2025 11:19:44 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH] tracing: Fix DECLARE_TRACE_CONDITION
Date: Tue, 28 Jan 2025 12:19:26 +0100
Message-ID: <20250128111926.303093-1-gmonaco@redhat.com>
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
Any attempt to use DECLARE_TRACE_CONDITION fails the build.

Add preprocessor bits in define_trace.h to allow usage of
DECLARE_TRACE_CONDITION just like DECLARE_TRACE.

Fixes: 287050d39026 ("tracing: Add TRACE_EVENT_CONDITIONAL()")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/trace/define_trace.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index e1c1079f8c8d..ed52d0506c69 100644
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

base-commit: 9c5968db9e625019a0ee5226c7eebef5519d366a
-- 
2.48.1

