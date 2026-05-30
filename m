Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F67308F23
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 May 2026 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150657; cv=none; b=eLsa232JPpwOX79yK3DkvgSORxYHETwBQTgSbA01USoqwJ0BPKPacQR8gxlsc+Q6oVsw+mPZCFqQD4+Ddu0txl6fL/UvRoNZeCOPftR04fz6z67hXW4MtJyOAD9ikKLQLDwScXjg0sFB1sjQYIOxNC+ir66ZJyyppLIh5T9s4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150657; c=relaxed/simple;
	bh=dXsrP4TL3rMdvbYgcsppSeBzkUR4NUGfNW4/c1f+jwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Ff1Qak/7UqYjyAbMkYdjl82ZmL0+M8whH7Efu2J/FQ4W65rR+EWhaKVzQQDlBGGS+JqkIiw+I5xIaRR64HslPE/GF5TZ06cTd5txqiSL3LykM6W0Smm7+t20unE+MxXgHsAXQOdbtbNYcwmcykQetqeKMwcVd/Oay841SeNdgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TP943xOj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TP943xOj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780150655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76JYe2UfOZXC8uyARcR9DHU+vZw6MDU2He4odYWsbfA=;
	b=TP943xOjwy8JNukZ0a6NOPKhyYAZLvjoCDlsL0KX49iYdfuWnl4YIaCkOIyhZJ2xx3VvMX
	C2U7ockOGTfKIiIGb3Xbs19l8zYV8YFZWB0qln2ZNshEP2LRCFRj+JrmwUdjpSs6Mj6Ewq
	piN/1q/xswXMEXlbgs02yrh/JojPAZo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81--kDJX1H1O6ySHx3mOsiuKA-1; Sat,
 30 May 2026 10:17:30 -0400
X-MC-Unique: -kDJX1H1O6ySHx3mOsiuKA-1
X-Mimecast-MFC-AGG-ID: -kDJX1H1O6ySHx3mOsiuKA_1780150649
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84E801800451;
	Sat, 30 May 2026 14:17:29 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A27730001BB;
	Sat, 30 May 2026 14:17:27 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 10/13] rv: Use 0 to check preemption enabled in opid
Date: Sat, 30 May 2026 16:16:49 +0200
Message-ID: <20260530141652.58084-11-gmonaco@redhat.com>
In-Reply-To: <20260530141652.58084-1-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: xUQsdhygnuQ5OADoBnE7F8e6KSKEMemvJG-ZXqvngTQ_1780150649
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Tracepoint handlers no longer run with preemption disabled by default
since a46023d5616 ("tracing: Guard __DECLARE_TRACE() use of
__DO_TRACE_CALL() with SRCU-fast"), the opid monitor should now count 1
in the preemption count as preemption disabled.

Change the rule for preempt_off to preempt > 0.

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

