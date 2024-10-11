Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB2217335
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648679; cv=none; b=G7xL0dbHz0QF6NRdUk/BkJcVrXCG6pS0UrIN+HUcOI7P7YbJAQ43dES3E66gUJslEItYfSdF+xQpD7g6Ze9U9kwaTLYjm6lysIUGNtu+Q2dZf1hoZ09iifVgjnSsJNCZEc1mQwaI4NU6sllit6jwGZppbkp3FeEvdlvY/W9uaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648679; c=relaxed/simple;
	bh=R27iAHpj1PSNZ8OmW943b1jTbDXKM3Y5oH3UeO36BiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OawaEu8MqM5Psn0EIgCoOfn2CSX4xnOhVJszWnxhhV+5AffC9whmvNSwTLOiIPyrP8bZ/e7uTJ6bzBfW3oaT1B5rYKKtlCQpRoP8ErbpWqlnmGv+nQwl0PgDX9XIrzMAJL8thlA29iJJZX33/HQmAtkEnp6W2HONDhe+8bKQPZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akm8quNy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akm8quNy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728648676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+cyH3mChhjZL/0BUinFcbAe+3nD1GKBvuvuTmD+LuNk=;
	b=akm8quNypdQNGReuvhL49dGgspGtOEBoa+yAomTl98D0PHQJjTiv6Ld4RaW5rmiqqslD5Z
	eGijBvKNkOBzj4o00qw7pAu+PYaQ2iYoz6poihyuj1vbfxHLUFyAAM+RtyDqwlTeD4nDLI
	R1IL/fYAWMVcCazO0wnHhJPCRX8ofDI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-3V-Hej5iOHG3gvbZ61IrrQ-1; Fri,
 11 Oct 2024 08:11:13 -0400
X-MC-Unique: 3V-Hej5iOHG3gvbZ61IrrQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 561791955D97;
	Fri, 11 Oct 2024 12:11:12 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.178])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0C091956089;
	Fri, 11 Oct 2024 12:11:09 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	lgoncalv@redhat.com,
	Tomas Glozar <tglozar@redhat.com>,
	Attila Fazekas <afazekas@redhat.com>
Subject: [PATCH 2/2] rtla/timerlat: Make timerlat_hist_cpu->*_count unsigned long long
Date: Fri, 11 Oct 2024 14:10:15 +0200
Message-ID: <20241011121015.2868751-2-tglozar@redhat.com>
In-Reply-To: <20241011121015.2868751-1-tglozar@redhat.com>
References: <20241011121015.2868751-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Tomas Glozar <tglozar@redhat.com>

Do the same fix as in previous commit also for timerlat-hist.

Reported-by: Attila Fazekas <afazekas@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index a3907c390d67..bbeaba8b5183 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -62,9 +62,9 @@ struct timerlat_hist_cpu {
 	int			*thread;
 	int			*user;
 
-	int			irq_count;
-	int			thread_count;
-	int			user_count;
+	unsigned long long	irq_count;
+	unsigned long long	thread_count;
+	unsigned long long	user_count;
 
 	unsigned long long	min_irq;
 	unsigned long long	sum_irq;
@@ -304,15 +304,15 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 			continue;
 
 		if (!params->no_irq)
-			trace_seq_printf(trace->seq, "%9d ",
+			trace_seq_printf(trace->seq, "%9llu ",
 					data->hist[cpu].irq_count);
 
 		if (!params->no_thread)
-			trace_seq_printf(trace->seq, "%9d ",
+			trace_seq_printf(trace->seq, "%9llu ",
 					data->hist[cpu].thread_count);
 
 		if (params->user_hist)
-			trace_seq_printf(trace->seq, "%9d ",
+			trace_seq_printf(trace->seq, "%9llu ",
 					 data->hist[cpu].user_count);
 	}
 	trace_seq_printf(trace->seq, "\n");
@@ -488,15 +488,15 @@ timerlat_print_stats_all(struct timerlat_hist_params *params,
 		trace_seq_printf(trace->seq, "count:");
 
 	if (!params->no_irq)
-		trace_seq_printf(trace->seq, "%9d ",
+		trace_seq_printf(trace->seq, "%9llu ",
 				 sum.irq_count);
 
 	if (!params->no_thread)
-		trace_seq_printf(trace->seq, "%9d ",
+		trace_seq_printf(trace->seq, "%9llu ",
 				 sum.thread_count);
 
 	if (params->user_hist)
-		trace_seq_printf(trace->seq, "%9d ",
+		trace_seq_printf(trace->seq, "%9llu ",
 				 sum.user_count);
 
 	trace_seq_printf(trace->seq, "\n");
-- 
2.47.0

