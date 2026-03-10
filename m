Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F723BF68E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Mar 2026 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158885; cv=none; b=NJ7q90EyWYnoG4SCZh56ioVj3GdSk4Xqhw+FxDL21Gag1exuMyuiDjjyFvXvJp9M96MYp8GAVSD9JK6KfVZdFHd2aZHlbMrqSrmGCcDHdpwi2GdzZ0xhIu1XS7/eYx7T5C0rA0jhK72K7osZru9w/vti9q0A1LAOIjCj1t4ZIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158885; c=relaxed/simple;
	bh=7uJDxOktfuAUdWvKCi12TmhY+QG8Fu2tuBJnM93GuC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=pBUCKjfmV5YSc+s1dTf2PPaSj1DlfLkZiaxfsXji3cl67b4h09Nshz6TQ3HBcBZLBf1z/pxA50H6FvbkLM0StAUlNyx3qdYUOC/DB7ywioudMm1j+3asQnk641zszHuNlahySTem3GOfql7B8uO4LQBXUeqKPlbXE1VomurLKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KiNagCKs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiNagCKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773158883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LBaIhMbdc5Ebvoq+n/EjSK2+VaJF2BYvKIgcOKN6X0M=;
	b=KiNagCKshfry32rqu08Hs/ti6b3XXb9OufdLxuPXffS2Vf96cNYuQcSCwkDa0BL6E71l95
	UhEINzXQNPo3k0buf1JoEkkNoDMayooa3ABQqGy4q48S7vUdWamhW1PpOKxn3+xFNM9t/N
	eWTbInL4PhDS9koN0QNjhzCVIiZdimw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-05ITMjX1N8aLP4HjfgPvzw-1; Tue,
 10 Mar 2026 12:08:00 -0400
X-MC-Unique: 05ITMjX1N8aLP4HjfgPvzw-1
X-Mimecast-MFC-AGG-ID: 05ITMjX1N8aLP4HjfgPvzw_1773158879
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 034DE1956089;
	Tue, 10 Mar 2026 16:07:59 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 886711800361;
	Tue, 10 Mar 2026 16:07:56 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] rtla: Fix segfault on multiple SIGINTs
Date: Tue, 10 Mar 2026 17:07:25 +0100
Message-ID: <20260310160725.144443-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: kRJAZDsaMdHw5BwGRjOSdGVI87oaX95FWAYI-oyjGjk_1773158879
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Detach stop_trace() from SIGINT/SIGALRM on tool clean-up to prevent it
from crashing RTLA by accessing freed memory.

This prevents a crash when multiple SIGINTs are received.

Fixes: d6899e560366 ("rtla/timerlat_hist: Abort event processing on second signal")
Fixes: 80967b354a76 ("rtla/timerlat_top: Abort event processing on second signal")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/common.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index ceff76a62a30..51cdf86d60d0 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -39,6 +39,18 @@ static void set_signals(struct common_params *params)
 	}
 }
 
+/*
+ * unset_signals - unsets the signals to stop the tool
+ */
+static void unset_signals(struct common_params *params)
+{
+	signal(SIGINT, SIG_DFL);
+	if (params->duration) {
+		alarm(0);
+		signal(SIGALRM, SIG_DFL);
+	}
+}
+
 /*
  * common_parse_options - parse common command line options
  *
@@ -284,7 +296,7 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
 
 	retval = ops->main(tool);
 	if (retval)
-		goto out_trace;
+		goto out_signals;
 
 	if (params->user_workload && !params->user.stopped_running) {
 		params->user.should_run = 0;
@@ -306,6 +318,8 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
 	if (ops->analyze)
 		ops->analyze(tool, stopped);
 
+out_signals:
+	unset_signals(params);
 out_trace:
 	trace_events_destroy(&tool->record->trace, params->events);
 	params->events = NULL;
-- 
2.53.0

