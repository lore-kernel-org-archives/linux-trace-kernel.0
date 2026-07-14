Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E963CF207
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053945; cv=none; b=Qb5NIuZh1VN8mtDRJ1iPsSWJrRQwyJEmusXoy+zsGd3elBoQqSOKpIz+P/G9FOU5WyBWVvPTkT0Jnzf8UKPp0rB2vYdXzh0klMNBVb7lxhf2BpHatQm+GnxfenqN00SUYObxLYiFvF1QV4Ef3JmHwB7px9/KrRoUOo+2XhJyfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053945; c=relaxed/simple;
	bh=w6Sp86eHEMVoVOxdFnIDhhVPOr3sGlq3VH2c/w0u1E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KVqNM3t+kcOlxF/Seu6f13elhhbJCRei/N6HpVLFVeGCuxek93D2pugGPuDLgV3/0p3amtJQ9wLjpUYdyYUHJq0xPZj0y3xkAIhilMqeG5zGJnS7O1mhK+q39DitJvZk+6AFhlJsnJY3V6AdX9scuFxCguFFje83N6oIt2fBp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vfb2prnb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vfb2prnb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784053942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwk64BpXBFsCzUAEimbym6phg6u2yD1wC5895sqxBoY=;
	b=Vfb2prnbapzRwcQlqajMfUcv3V02R9o2194JnQtHCLI0hlfSeGy4bqajAXEpoqUpyxLauF
	YStse7cW6SZajoi/gfwH6H491RtN36TUesnJt9HYvESirqRuLSWEjFOqhWaQXgVx7/sNi6
	oJs4O3fX2qX6ESKR57dJX6hg3k+Z6K8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-oLcVr0dXOfy6SdYCw-tc-g-1; Tue,
 14 Jul 2026 14:32:21 -0400
X-MC-Unique: oLcVr0dXOfy6SdYCw-tc-g-1
X-Mimecast-MFC-AGG-ID: oLcVr0dXOfy6SdYCw-tc-g_1784053940
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA31B1956070;
	Tue, 14 Jul 2026 18:32:19 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.65.227])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B61361800593;
	Tue, 14 Jul 2026 18:32:18 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: mpetlan@redhat.com,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v5 1/5] eventfs: define event fields before directory creation
Date: Tue, 14 Jul 2026 14:31:41 -0400
Message-ID: <20260714183150.292861-3-ashelat@redhat.com>
In-Reply-To: <20260714183150.292861-2-ashelat@redhat.com>
References: <20260714183150.292861-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: lLGgLWsou-BNfBxdEUp1UsWXMOA-FldgHfh8q7lSgYk_1784053940
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

