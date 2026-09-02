Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C3E49B1E4
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352852; cv=none; b=OQPfXAuuulICTovzkEU9YQ4ReO/EDhrw+/vuz+WqBphmY1ib/XbIr2ikfmjTAKQHqcQZ3r6meesmbVltPpxwdrzoIXcyl0moRZuo5R0WACE2X+rjkBNht0zo8947vH87GC3/SNyhZ+yNW8dQcNjNG8PArtpF9zJiPuxGj2iQuKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352852; c=relaxed/simple;
	bh=6xcKr5tZDHqLF3+pbISrVFsd7U/HkrFpGSZ5ZOOM58o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Zpl7LGhHNJqHok1bWI7sfQc2FaLsyr2zSLzYrLcL5I/3Fp3Y6gpKMf2ggHZ6ASb0OnrLANUmMOiyZv6Ze/KbNDmmLfZevG386TJjNBzuhvY8qufCWNAH+QZBL5pTRTXXGHI9NWrvmvsH0gkESjLtWTkummAdYYQrT4NblcnmzfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpcsMRFV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpcsMRFV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788352850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvSw3fPRx5YqD5lgP9OjNR44a1FjMhKCp+Qv0Husx7U=;
	b=LpcsMRFVguFauh8DdaRdDVoK3aCoevKtWk8XKQF+UHFS+UjJkmL6XtQ3fOp5z//1+dCn7t
	oMH2l/4g+ZVZE6wc4a1A+40AT5YnNjfpNqzOzit+IDPA4/NuiRCAvUD6iXZbZL1A+xVuc8
	L2EBt3UkMZuXDllWciAjIBPhpEhX8jY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-XbkaH8BGMWm9clSAAItU_w-1; Wed,
 02 Sept 2026 08:40:47 -0400
X-MC-Unique: XbkaH8BGMWm9clSAAItU_w-1
X-Mimecast-MFC-AGG-ID: XbkaH8BGMWm9clSAAItU_w_1788352845
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C336A18512C3;
	Wed,  2 Sep 2026 12:40:45 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.33.19])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE5B31955F7C;
	Wed,  2 Sep 2026 12:40:41 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 7/8] rtla: Unconditionally clean any pre-existing filters for user-provided events
Date: Wed,  2 Sep 2026 14:39:36 +0200
Message-ID: <20260902123942.695822-8-vschneid@redhat.com>
In-Reply-To: <20260902123942.695822-1-vschneid@redhat.com>
References: <20260902123942.695822-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: mAMzCrDoxxrJdX4iB2QgTfqlw0Mk07EZQDHJyIBkzpI_1788352845
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

A later commit will apply a filter to events recorded to the trace
output. To prevent any user confusion, remove pre-existing filters when
enabling an event provided via the '-e' command line argument.

Suggested-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 Documentation/tools/rtla/common_options.txt | 9 ++++++++-
 tools/tracing/rtla/src/trace.c              | 4 ++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/tools/rtla/common_options.txt b/Documentation/tools/rtla/common_options.txt
index 38da1cf443a48..6bf0f86393333 100644
--- a/Documentation/tools/rtla/common_options.txt
+++ b/Documentation/tools/rtla/common_options.txt
@@ -26,12 +26,19 @@
 
 **--filter** *<filter>*
 
-        Filter the previous **-e** *sys:event* event with *<filter>*. For further information about event filtering see https://www.kernel.org/doc/html/latest/trace/events.html#event-filtering.
+        Filter the previous **-e** *sys:event* event with *<filter>*.
+
+        If the same event is specified more than once but with different filters, the last specified filter will be the only one applied.
+
+	For further information about event filtering see https://www.kernel.org/doc/html/latest/trace/events.html#event-filtering.
 
         This option cannot be unset.
 
 **--trigger** *<trigger>*
         Enable a trace event trigger to the previous **-e** *sys:event*.
+
+        If the same event is specified more than once but with different triggers, the last specified trigger will be the only one applied.
+
         If the *hist:* trigger is activated, the output histogram will be automatically saved to a file named *system_event_hist.txt*.
         For example, the command:
 
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 17d148f7d5d6e..06204d339f967 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -487,6 +487,10 @@ static int trace_event_enable_filter(struct trace_instance *instance,
 	char filter[MAX_PATH];
 	int retval;
 
+	/* Unconditionally clean any pre-existing filters */
+	tracefs_event_file_write(instance->inst, tevent->system,
+				 tevent->event, "filter", "0");
+
 	if (!tevent->filter)
 		return 0;
 
-- 
2.55.0

