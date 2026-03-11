Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E584D27CCF0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234152; cv=none; b=FmbnsDNNQd47ossBdMovhyvBOJITRvA50L9F4Qg8qpp3HUaU2PsdWZDmiRYcWd3fFR6sHBtp4tq040lBLtmdfM4+bVaOLQ6r+wO3JkHbvURspPI/FKYb2xHXuMyiHV+JoNPSdaJdXFZoOmyC7HZPTZfrvLe5icU+12mpDXsUYTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234152; c=relaxed/simple;
	bh=UrUp6nfMg0UsSBxqAU/KgQgWt9eB0jo6UHftMfqrkBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=dWxypX9jVKIRU2hoLGnIZJ98gHRmUIhnVRG5Lt9DF3J7RxIRz53QwGfUeVHEPqpwMOwhB+ZIrWBl6rR2ZxSkbewzVEpj/5QF8+RSp2Mdkw5QlVAbQnSXctbmusiDwXpj5GjecPMaZm4REtdBJnKe1XJiR78FRyVP/4mGrcWF3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmM17dJX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmM17dJX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773234149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0p430872sznMzJxH8mT2+q8E3XDrCfM5KcPZiV1a8U=;
	b=NmM17dJXzNnBtFyCrnrv7okyUIk431pSdw68eiuiqFbAGwYZxXBbQXgmfIWV5flARexKKj
	Z5GGFtNWBGgdwkT9d6M/5JQJ/grGtIgslpL/BZG3PCULgyY9s0c9HpyA8BkS2/q8o4v1PP
	TthSXQzAYcRzwUm0xTyB1FbNtq9+gIE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-lUpYh_5pNlOX0qZ1thti8Q-1; Wed,
 11 Mar 2026 09:02:28 -0400
X-MC-Unique: lUpYh_5pNlOX0qZ1thti8Q-1
X-Mimecast-MFC-AGG-ID: lUpYh_5pNlOX0qZ1thti8Q_1773234146
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 132EC19560B5;
	Wed, 11 Mar 2026 13:02:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.206])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3C2130002D2;
	Wed, 11 Mar 2026 13:02:19 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: acme@kernel.org,
	williams@redhat.com,
	gmonaco@redhat.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v3 2/4] trace/preemptirq: make TRACE_PREEMPT_TOGGLE user-selectable
Date: Wed, 11 Mar 2026 09:50:16 -0300
Message-ID: <20260311125021.197638-3-wander@redhat.com>
In-Reply-To: <20260311125021.197638-1-wander@redhat.com>
References: <20260311125021.197638-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: V8oxbjVWgadfkuOnMCT0bYNxW-DV_-vzNCoLZFDy_EQ_1773234146
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Make TRACE_PREEMPT_TOGGLE directly selectable so that
preempt_enable/preempt_disable tracepoints can be enabled in
production kernels without requiring the preemptoff latency tracer
overhead.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 kernel/trace/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 49de13cae4288..e007459ecf361 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -413,10 +413,10 @@ config STACK_TRACER
 	  Say N if unsure.
 
 config TRACE_PREEMPT_TOGGLE
-	bool
+	bool "Preempt disable/enable tracing hooks"
 	help
-	  Enables hooks which will be called when preemption is first disabled,
-	  and last enabled.
+	  Enables hooks into preemption disable and enable paths for
+	  tracing or latency measurement.
 
 config IRQSOFF_TRACER
 	bool "Interrupts-off Latency Tracer"
-- 
2.53.0

