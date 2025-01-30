Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB238DD3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jan 2025 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738260930; cv=none; b=gHwxpd1KDwuM9WX9U04EfMg/8724QcK/ukTbZ2yEK18iqdnw3JJ4aaBAdiqJU/7NPdCl/rSTugk0pbitMkN1xnjute6rZJBpl//1MH6PraHe5gaX1TkSrAqNVMwFmYb7CQY9h3ZqfztiPQ/wbLVWXWh+NXuofy4TVIr/r4Df/n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738260930; c=relaxed/simple;
	bh=XPT+9XkaTAzObYJ1bdlbTqw6s3LWjn4zwDx+3v+UTR4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XWhXW3BltsV9vLq9GOhUcuG5ssBa8UGaaRWX6lcc36mgzInHmVyl+bEKoclIIqR4F0c6o6gMkOa6A+hFStQAxz6d0/FMnf6i8hI/I3Pht3EUHqBmtOQaL/WWNkNHc1qMF7aex2Wq6Fb8Cn4SXOuM1KzCzJsbtkZ6QoBPlcG5wnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=In8QJo4/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="In8QJo4/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738260928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d23NPHmcbepta9lyEp40cUJkMkXp8ZsIbiHpFpP824s=;
	b=In8QJo4/kM8QdMlyle80Xu91K3wd63uTuKWOwLle+0pTPUI+Pi0tAcibbUitYWEvJOX2SP
	JxAAihMMX0NCoOHFcwo1eTx6fhyMp4Q+WRL4n0Jr5d7XEV8+PzUA3IVV5YkXL8NQIFP2qW
	/P4Nt98659DSGwnjCmjlaSuzxzo2Dwc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-utabT-OKMDqFep12mqVStA-1; Thu,
 30 Jan 2025 13:15:23 -0500
X-MC-Unique: utabT-OKMDqFep12mqVStA-1
X-Mimecast-MFC-AGG-ID: utabT-OKMDqFep12mqVStA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7DC419560AB;
	Thu, 30 Jan 2025 18:15:21 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.125])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2D2C1800268;
	Thu, 30 Jan 2025 18:15:16 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH] irq/tracing: Add IRQ name to irq_handler_exit tracepoint
Date: Thu, 30 Jan 2025 15:14:38 -0300
Message-ID: <20250130181439.58130-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The irq_handler_entry tracepoint includes a "name" field, which allows
for easy identification and filtering of specific IRQs. However, the
irq_handler_exit tracepoint lacks this field, making it difficult to
pair corresponding entry and exit events for analysis.

Add the "name" field to irq_handler_exit to enable consistent tracking
and correlation of IRQ entry and exit events.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 include/trace/events/irq.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
index 837c1740d0d0..d705406daa37 100644
--- a/include/trace/events/irq.h
+++ b/include/trace/events/irq.h
@@ -88,16 +88,18 @@ TRACE_EVENT(irq_handler_exit,
 
 	TP_STRUCT__entry(
 		__field(	int,	irq	)
+		__string(	name,	action->name	)
 		__field(	int,	ret	)
 	),
 
 	TP_fast_assign(
 		__entry->irq	= irq;
+		__assign_str(name);
 		__entry->ret	= ret;
 	),
 
-	TP_printk("irq=%d ret=%s",
-		  __entry->irq, __entry->ret ? "handled" : "unhandled")
+	TP_printk("irq=%d name=%s ret=%s",
+		  __entry->irq, __get_str(name), __entry->ret ? "handled" : "unhandled")
 );
 
 DECLARE_EVENT_CLASS(softirq,
-- 
2.48.1

