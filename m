Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29FC4ADDAD
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865433; cv=none; b=GCj76/aPVqG02GK1Tkw58aaOjHd/UUCl6c3MCIEp6Wn2BXv19osdyG6t08ZzwV6MQ0l9XJKr5aJVVaint/Bta2X324F3FK8LR+bSK9J6JTDC3S10XUdA+w5RAa01rf9wWSVNViM6hrBz5cbBOKSHU0jCuL9WVtAuWLp5O+ayJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865433; c=relaxed/simple;
	bh=6j6oFNDGCW22dPi/OuojAv6AgzWQQtmzdQGiZwBPIS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qTZ5o7aQf7x3C3cov2csXEZsVxVKYyvo/02XwdEajHyW9d7vwlJkQlZEA5sJRCCnzHwuvTMglSb07N7hxMvEY4rYnEPlDyftj+vHxLgaK77bEmSyMWcZ2esyn8Trq+oDaLxJ5iap5c9eqalsBnPg4gMeUgVx8y+BEXRRHf2cRBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KAfpRpQR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAfpRpQR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785865430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZyfMFThYySVUZ/UP9vZ/no6yT92LHdHbfgfkLQhYtrY=;
	b=KAfpRpQR4yMN+ne6jyWjk3iP1lusI52OZJQA+UdllsPUAZ0IXMOQ++Ls6KtBB+M+ZScC6Y
	HbAuNtCfcHYffZyXEaqAyR56qhefGuotCAyMsagr5eisbivR2+uIZzJvUeJhOzarUf6YWQ
	xH0SHlmJRUJzoI12QiJBDMFYGQF1uMQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-Hq0rdqakNAeJfEKXDx4n-g-1; Tue,
 04 Aug 2026 13:43:37 -0400
X-MC-Unique: Hq0rdqakNAeJfEKXDx4n-g-1
X-Mimecast-MFC-AGG-ID: Hq0rdqakNAeJfEKXDx4n-g_1785865413
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EBF81800364;
	Tue,  4 Aug 2026 17:43:33 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.34.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9ACEF195608E;
	Tue,  4 Aug 2026 17:43:29 +0000 (UTC)
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
Subject: [PATCH v4 5/6] rtla: Unconditionally clean any pre-existing filters for user-provided events
Date: Tue,  4 Aug 2026 19:42:37 +0200
Message-ID: <20260804174242.2288433-6-vschneid@redhat.com>
In-Reply-To: <20260804174242.2288433-1-vschneid@redhat.com>
References: <20260804174242.2288433-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: I9C-Ovzf5OK1m7v2ywfl86kKJ9_P49vTG1VaPDxlrvs_1785865413
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

