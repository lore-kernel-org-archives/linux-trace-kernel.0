Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37496318136
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291110; cv=none; b=I2psPavFBcku6+e2oUg2GZ3ANteSjbp/+mSAWdx1RZMLpImSYcml3SsLy7775QW48EEJgTcRgSAU3r7DQNE7bdf8yuHg2L270NrWpxyiyAopDiO78p7bPD3jz3fo+VxN6bVt1YK3vmZWHU3wFwLt/NyTAZ7iX2DtHp0LxUlji9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291110; c=relaxed/simple;
	bh=WQNXShQgY7xogk082FyCjCHP+tYrX3Ygc3qimHccFXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esTO6BuUxriFDbs4jmz90/jch/2tbtM2QOK+r9pgd1ydH0DhTdzhyXnienaWTrdxDlUMHKO4nQV06fXAy46kXjx+O4NWOflIhxJMp2qBtVK2fpa/rKMuIbeB65Y6aGRx5/LZPSY9DbhEUWj2Or9dIhsWJ0qKxHKGRJlFAZev7RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GdlHdDkX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdlHdDkX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758291106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfwybVwZAOX255a6SxX6GTdqkRsVNInDqN+J7H6EHfY=;
	b=GdlHdDkXFqGjUyW5CzqTnlytVQHJI4SPjm+pwVQHqUMlYX+3P2A29fHR09ib7TDwIksxLX
	F/bW/pjQLbXD+6q0PMiJibdu+9tdtxdx1XTKQ5yXDaXmV7o3JtMYD/y8mx2hsbU2RhsWPo
	YZSrxrf0uqSdkR1iV6kiOQkFTjoxxH8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-nSRWILYLPnmarjJvl0RQDA-1; Fri,
 19 Sep 2025 10:11:42 -0400
X-MC-Unique: nSRWILYLPnmarjJvl0RQDA-1
X-Mimecast-MFC-AGG-ID: nSRWILYLPnmarjJvl0RQDA_1758291101
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8927C1800293;
	Fri, 19 Sep 2025 14:11:41 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F8C719560BB;
	Fri, 19 Sep 2025 14:11:36 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 16/20] sched: Export hidden tracepoints to modules
Date: Fri, 19 Sep 2025 16:09:50 +0200
Message-ID: <20250919140954.104920-17-gmonaco@redhat.com>
In-Reply-To: <20250919140954.104920-1-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The tracepoints sched_entry, sched_exit and sched_set_need_resched
are not exported to tracefs as trace events, this allows only kernel
code to access them. Helper modules like [1] can be used to still have
the tracepoints available to ftrace for debugging purposes, but they do
rely on the tracepoints being exported.

Export the 3 not exported tracepoints.
Note that sched_set_state is already exported as the macro is called
from modules.

[1] - https://github.com/qais-yousef/sched_tp.git

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ccba6fc3c3fe..334ff5b214d7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -117,6 +117,9 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
-- 
2.51.0

