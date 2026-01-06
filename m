Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19223328FB
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706754; cv=none; b=qmhyQhB9/smh8bIChgszVdDlmgboywxm4EylhgX1SK9vjl6ZNZk17C7g6Gn6+r3q9/R1511Dw2ZDJyNkxmKt7GDYcUA9o4EodcMDDN+aW+79SfGE9sOb9s9sibyg0waZka6YiAEQ3BvyyjOutFRiizkA3GzlJDZYyc4ffgUL9DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706754; c=relaxed/simple;
	bh=I6Y2Bnj5DjlTKswbTwkLRHVOQ3wPXG/AMGsGn2yZi04=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dr1DSHInifNTgoCGRNBjbNGPZC0WM05r4wfT5aS48yS6edurAMitDgxVd4KECubobF2Jxa2weuq4iinbgUiriPPLIM8ot/gnZHDuFv8vpXezCPLm22HsNfI9rrTwgURd18PKuXQ4VN3sAm31WePGhjzZqm4cZNwGF25hhUV5b1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJqlgTqD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJqlgTqD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767706751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uaMzECtULTxucImjVPwH8LTz8bTXnv1pm1HYLWyzkw=;
	b=IJqlgTqDeAZZ31BgOqThcvrQ/OhGV9e7nYEdt8LZUaeDkoOKID1rD6058FJRXTSoQNeZkX
	7CGOMm7XeEdDfq4nncul6/sMcFyRvW2Axuj9M7i4A99qTXEMGekKmYE7IgOQI9xW+nU0/S
	Hi6bgzUD7fiRRwjO2IBJ40YfqZ7y5vE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-tYE0V7fbMImPiH-ewnz63g-1; Tue,
 06 Jan 2026 08:39:08 -0500
X-MC-Unique: tYE0V7fbMImPiH-ewnz63g-1
X-Mimecast-MFC-AGG-ID: tYE0V7fbMImPiH-ewnz63g_1767706747
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E1F41800625;
	Tue,  6 Jan 2026 13:39:07 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 23BD2180035A;
	Tue,  6 Jan 2026 13:39:02 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v2 02/18] rtla: Use strdup() to simplify code
Date: Tue,  6 Jan 2026 08:49:38 -0300
Message-ID: <20260106133655.249887-3-wander@redhat.com>
In-Reply-To: <20260106133655.249887-1-wander@redhat.com>
References: <20260106133655.249887-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The actions_add_trace_output() and actions_add_shell() functions were
using calloc() followed by strcpy() to allocate and copy a string.
This can be simplified by using strdup(), which allocates memory and
copies the string in a single step.

Replace the calloc() and strcpy() calls with strdup(), making the
code more concise and readable.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index ff7811e175930..090d514fe4126 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -69,8 +69,7 @@ actions_add_trace_output(struct actions *self, const char *trace_output)
 
 	self->present[ACTION_TRACE_OUTPUT] = true;
 	action->type = ACTION_TRACE_OUTPUT;
-	action->trace_output = calloc_fatal(strlen(trace_output) + 1, sizeof(char));
-	strcpy(action->trace_output, trace_output);
+	action->trace_output = strdup_fatal(trace_output);
 }
 
 /*
@@ -97,8 +96,7 @@ actions_add_shell(struct actions *self, const char *command)
 
 	self->present[ACTION_SHELL] = true;
 	action->type = ACTION_SHELL;
-	action->command = calloc_fatal(strlen(command) + 1, sizeof(char));
-	strcpy(action->command, command);
+	action->command = strdup_fatal(command);
 }
 
 /*
-- 
2.52.0

