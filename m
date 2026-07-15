Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CF948C40B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130424; cv=none; b=KhIjl8j7gKWtK/6D40TSVDAJC3X+mo9NBZgrEDbl9Cwaz7/k+bCJ+8CI+fIRXPdTd5l4aE36rNjBm284IbGjjzaRgxiyvLrBhHMSOILxRGCKYIn/xpI/APMbkfebUJPimnxM2jt5ylncSw9P5o76lwGgvkyZoCDufQL49D4CM1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130424; c=relaxed/simple;
	bh=6j6oFNDGCW22dPi/OuojAv6AgzWQQtmzdQGiZwBPIS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=EEApNTo3f5LXQopGcO41Uob1uYNpxXw7/0nbk4UxNZjB8xascWx6WN1Q4SQhgfhqyNgPGkSvBtgYx077ykfZ+tvLvFFCFNCDGlouDrmpnJYq4MC8zjxFpqTgd2uYe08NelQ10NgsJNARDPOuK2fNsdMerPYxHDbKqmeOvMk/rTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bmp5+zhc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bmp5+zhc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784130420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZyfMFThYySVUZ/UP9vZ/no6yT92LHdHbfgfkLQhYtrY=;
	b=Bmp5+zhcB/T9KeENLp/KqJBc6sLQagyzQbx+mowEzhVgnmNQ2EHEE5YJIYmb2OTGFHeobL
	bX1PICkib+kqEksvjo5rsoqkvPdrY0x4Y0VbXiTTUg4s1OOSzvVQMUMJT0gDFrvPlQ5IZk
	+fQjxB96ISKt2d/72F2jrUwu4X0Kxrc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-nrpd4CmENcac4dNV13t-pQ-1; Wed,
 15 Jul 2026 11:46:56 -0400
X-MC-Unique: nrpd4CmENcac4dNV13t-pQ-1
X-Mimecast-MFC-AGG-ID: nrpd4CmENcac4dNV13t-pQ_1784130415
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F6031955F1D;
	Wed, 15 Jul 2026 15:46:55 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.32.112])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCA251800576;
	Wed, 15 Jul 2026 15:46:51 +0000 (UTC)
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
Subject: [PATCH v3 5/6] rtla: Unconditionally clean any pre-existing filters for user-provided events
Date: Wed, 15 Jul 2026 17:45:50 +0200
Message-ID: <20260715154553.2020891-6-vschneid@redhat.com>
In-Reply-To: <20260715154553.2020891-1-vschneid@redhat.com>
References: <20260715154553.2020891-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: gMRoXZpz0vTVLLWtcZhcRKgcDJTh310UMu0Vkxmc7Bc_1784130415
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

A later commit will apply a filter to events recorded to the trace
output. To prevent any user confusion, remove pre-existing filters when
enabling an event provided via the '-e' command line argument.

Suggested-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 tools/tracing/rtla/src/trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index e407447773d04..f67f02cc92cdd 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -473,6 +473,10 @@ static int trace_event_enable_filter(struct trace_instance *instance,
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

