Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05823DD857
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328373; cv=none; b=azgGig9agia1E+VuzhDbS9W3mcbGKEQQXxl1Kugnh4hNvdAe8VIfNU7psOHQ3Dy5dnhymtAi1W+edIyklmDhfn+MOjvOcmxkD2YEXYuBRAptUJoca9PgZMVy01W/WqXiosOgjbxr18Kn5Dr97fAqFTW0oW1+BXX7yzbeqS5zqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328373; c=relaxed/simple;
	bh=oGYDlULfgOSuXW+qyzO3rfB4JOQYXfdXeTf6EYeNE/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RF9E4/Pi8F/h9kqL6FDOsx4SYv8VbCQI8Hvzpm7ZI15lA7V5MJ7wCL6WXF6DPUsSwBJJueofvIju/2XmFJqvITDeR83iTDdABwG/eMML8QIEvIj15oUd2ACkJ/C5yz4zxiYu4hyrmEi5jLCLpiW/8p9pwC//ylwTNpDi5eNiwyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ems6ZW9A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ems6ZW9A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780328367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6vCX6wnnxLuIxViqLQBjsL4zOCYCEBSGVIqh4zvajm0=;
	b=Ems6ZW9Ah9+3E53H4duFh1tjazQ8x9WkHZgRyJxeuKwGpd3PzCBkgtt12GH4sbe0vUTYFv
	LadKWZIwA4qGa6tEndYgk+2pNvZPugchfH5v9TqTiqi6fwC7mTKcXcYWLNOsttWg9WIEUg
	4Pwqe2KmIFEwIfY5jfagdEfvtCS1MgU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-wM68WgJ2P7iU8LVTyrNoeA-1; Mon,
 01 Jun 2026 11:39:23 -0400
X-MC-Unique: wM68WgJ2P7iU8LVTyrNoeA-1
X-Mimecast-MFC-AGG-ID: wM68WgJ2P7iU8LVTyrNoeA_1780328360
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3395195605C;
	Mon,  1 Jun 2026 15:39:19 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7AAE18004A3;
	Mon,  1 Jun 2026 15:39:17 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 10/13] rv: Use 0 to check preemption enabled in opid
Date: Mon,  1 Jun 2026 17:38:37 +0200
Message-ID: <20260601153840.124372-11-gmonaco@redhat.com>
In-Reply-To: <20260601153840.124372-1-gmonaco@redhat.com>
References: <20260601153840.124372-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Q6CHCa3UVWISyIqgEphB5i3nCm7AVjRFP8enkHBOwBA_1780328360
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Tracepoint handlers no longer run with preemption disabled by default
since a46023d5616 ("tracing: Guard __DECLARE_TRACE() use of
__DO_TRACE_CALL() with SRCU-fast"), the opid monitor should now count 1
in the preemption count as preemption disabled.

Change the rule for preempt_off to preempt > 0.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/monitors/opid/opid.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/trace/rv/monitors/opid/opid.c b/kernel/trace/rv/monitors/opid/opid.c
index 2922318c6..3b6a85e81 100644
--- a/kernel/trace/rv/monitors/opid/opid.c
+++ b/kernel/trace/rv/monitors/opid/opid.c
@@ -22,14 +22,8 @@ static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_opid env, u64 time_ns
 	if (env == irq_off_opid)
 		return irqs_disabled();
 	else if (env == preempt_off_opid) {
-		/*
-		 * If CONFIG_PREEMPTION is enabled, then the tracepoint itself disables
-		 * preemption (adding one to the preempt_count). Since we are
-		 * interested in the preempt_count at the time the tracepoint was
-		 * hit, we consider 1 as still enabled.
-		 */
 		if (IS_ENABLED(CONFIG_PREEMPTION))
-			return (preempt_count() & PREEMPT_MASK) > 1;
+			return (preempt_count() & PREEMPT_MASK) > 0;
 		return true;
 	}
 	return ENV_INVALID_VALUE;
-- 
2.54.0

