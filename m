Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DE326D4E5
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123592; cv=none; b=K3Bi2EbPRelJiPKtbBwg5/k5e48et+twWBOVykKhA4g7o5lMV/DEZJN6axs4rHuV/vbD+4RWdFh8MyV2HoY4Ps80z6AbfzMIQaSKXUgcexqSOJeGbRfKkbKYcxmV3iHKqVxVWcbeEA2EgjnFmOkTcywnPD2Xetg3l8X9lgV3RsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123592; c=relaxed/simple;
	bh=w6Sp86eHEMVoVOxdFnIDhhVPOr3sGlq3VH2c/w0u1E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Oc61aM3Uj9tJPdsjpflcb6JJGgWvlaB4EWTIC0xVVrPYmACmW+PSiOPIqh2acv8qRB4ENLX2MyNqZGeVbOJoS0Ak0JAxULPOiTu14lvfopNnflYOAeD7+h41TO7IqRS/4PztywNYanK86T1ICAJEaGaCO/JSKAaUcQ5XsddzZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8CuIFcE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8CuIFcE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784123590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwk64BpXBFsCzUAEimbym6phg6u2yD1wC5895sqxBoY=;
	b=M8CuIFcEQRj4F9X8IhHM9n/XCrky6FEHMzfTyeMgaUCoIuhV5JXf7Z7exZBG92eqDqtC09
	o90UFTcOH4Y+2IkjZ6s7pS9gELhp1Jii9VDXp5LIcrTusr8QtPTHFi+yw5DfjEP6hykZ4c
	uO8m7XsHv5VOBHs9s8KmnK2/+7g9Dq0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-C1O3IunOPQ2UzB98WnBWjQ-1; Wed,
 15 Jul 2026 09:53:06 -0400
X-MC-Unique: C1O3IunOPQ2UzB98WnBWjQ-1
X-Mimecast-MFC-AGG-ID: C1O3IunOPQ2UzB98WnBWjQ_1784123583
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4B5D180065C;
	Wed, 15 Jul 2026 13:53:02 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.80.235])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B71D1956089;
	Wed, 15 Jul 2026 13:53:00 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: rostedt@goodmis.org,
	acme@kernel.org,
	peterz@infradead.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v5 1/5] eventfs: define event fields before directory creation
Date: Wed, 15 Jul 2026 09:52:22 -0400
Message-ID: <20260715135231.338535-3-ashelat@redhat.com>
In-Reply-To: <20260715135231.338535-2-ashelat@redhat.com>
References: <20260715135231.338535-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: oSXfQ6WXzoHiGZsDkqVkuQNlJKaXwVa0qtn7icTwU80_1784123583
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Move the event_define_fields() call in event_create_dir() before the
eventfs directory creation. Previously, a failure after directory
creation wouldn't clean up eventfs_inode because the error path didn't
call eventfs_remove_dir(). This eliminates the need to clean up the
eventfs directories if event_define_fields() fails.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 kernel/trace/trace_events.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..ddb6932a3ee7 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3190,6 +3190,13 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 	if (WARN_ON_ONCE(strcmp(call->class->system, TRACE_SYSTEM) == 0))
 		return -ENODEV;
 
+	ret = event_define_fields(call);
+	if (ret < 0) {
+		pr_warn("Could not initialize trace point events/%s\n",
+			trace_event_name(call));
+		return ret;
+	}
+
 	e_events = event_subsystem_dir(tr, call->class->system, file, parent);
 	if (!e_events)
 		return -ENOMEM;
@@ -3208,12 +3215,6 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 
 	file->ei = ei;
 
-	ret = event_define_fields(call);
-	if (ret < 0) {
-		pr_warn("Could not initialize trace point events/%s\n", name);
-		return ret;
-	}
-
 	/* Gets decremented on freeing of the "enable" file */
 	event_file_get(file);
 
-- 
2.54.0

