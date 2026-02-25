Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C5B38E5FD
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013177; cv=none; b=VUTuG+nyl8cfvGRdX5FkJWuep3O2HwqgADsFGqwI/Ny3jZ9hog9m5KoxaBUPxhS4A5mw8intXGUS2lnTnrKYRL5hGfnLL1JR53DMypT2yDikN8OmjfOGoppP1vAC/z9ihX6h2nH45AWGne4OD8wtsYgJrLX8ouOB2wYslcDNKb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013177; c=relaxed/simple;
	bh=MDrEFgcwxr4RQmTHk+YJ5HbbpzMh6vpOEfDu2mLU91w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CBGAT/ja+fcG15EtoS885x+pNXyII3bSk2F6Msk43XTyYsiTg8Ukk5f4Nr/awofXWRRCQxuH+7ZTF3e0WAXWlH1n0BFPih3mxw0zNRyqqZVe+n2PJh2C9lJCc4Sh8LoJJmJ9Ft+uZui74ASsdpdmEhidyP+bDlaRcHnwj/ay0bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzrNeXnV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzrNeXnV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772013175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kO0zoFWYPRbDr8YKYEjZMgyeFmg69CxtJKAzgYm3eLM=;
	b=NzrNeXnVyFF2UHesOFpwkhLB/DzTmGnbAn4xrc2h2Zck4g7AcAm3Gy3INkEn6HCECxT7a0
	Xqb+0te1C0//uzZlyBsbQA2eMhddElmEelxrdk8qlyIsPr69QhU5bMgKSX9VehlLkOHelU
	/wxsiBG4CIzdk/X/Ru4fb6LONbBqkBs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-ghaZjbg-McKL45C9Q17gmg-1; Wed,
 25 Feb 2026 04:52:51 -0500
X-MC-Unique: ghaZjbg-McKL45C9Q17gmg-1
X-Mimecast-MFC-AGG-ID: ghaZjbg-McKL45C9Q17gmg_1772013169
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA8231956088;
	Wed, 25 Feb 2026 09:52:49 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.34.216])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F5781800370;
	Wed, 25 Feb 2026 09:52:44 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	sched-ext@lists.linux.dev
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 14/16] sched_ext: Export task_is_scx_enabled() for verification
Date: Wed, 25 Feb 2026 10:51:20 +0100
Message-ID: <20260225095122.80683-15-gmonaco@redhat.com>
In-Reply-To: <20260225095122.80683-1-gmonaco@redhat.com>
References: <20260225095122.80683-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 8Fy6YYbu5szXzwM2rn-FlwzuC3wIQDVvKpt9juJlvg4_1772013169
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When a sched_ext scheduler is loaded, depending on the configuration, it
can handle also fair tasks, however it isn't trivial to understand if a
certain task is currently handled by fair or ext outside of scheduler
code. This can be a problem when writing verification or observability
tools like RV monitors.

Export a task_is_scx_enabled() to allow quick classification by using
the scx state SCX_TASK_ENABLED.

To: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/sched/ext.h | 2 ++
 kernel/sched/ext.c        | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index bcb962d5ee7d..68e5aff95159 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -232,6 +232,7 @@ void print_scx_info(const char *log_lvl, struct task_struct *p);
 void scx_softlockup(u32 dur_s);
 bool scx_hardlockup(int cpu);
 bool scx_rcu_cpu_stall(void);
+bool task_is_scx_enabled(struct task_struct *p);
 
 #else	/* !CONFIG_SCHED_CLASS_EXT */
 
@@ -240,6 +241,7 @@ static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
 static inline void scx_softlockup(u32 dur_s) {}
 static inline bool scx_hardlockup(int cpu) { return false; }
 static inline bool scx_rcu_cpu_stall(void) { return false; }
+static inline bool task_is_scx_enabled(struct task_struct *p) { return false; }
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 62b1f3ac5630..1e48bc3cde15 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3772,6 +3772,14 @@ bool task_should_scx(int policy)
 	return policy == SCHED_EXT;
 }
 
+/*
+ * Used by verification/observability tools like RV monitors.
+ */
+bool task_is_scx_enabled(struct task_struct *p)
+{
+	return scx_get_task_state(p) == SCX_TASK_ENABLED;
+}
+
 bool scx_allow_ttwu_queue(const struct task_struct *p)
 {
 	struct scx_sched *sch;
-- 
2.53.0

