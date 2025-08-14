Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4C25FA10
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155442; cv=none; b=Vgwyt64hn0vylKwzJFlXUSeqfy5DgKs2QPqWTvVBjRyVqyragF8pT2HldI3CnDUVOqsh2kjOY1Pi0sPuTOh76X6eEZvaz0c9UxSozb7kEZlJ70gV/+pLJ6TN3kbNHB8mkYeYOXEozGBaR72cRQ32/ftVlziK5nPBmewitXAjYVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155442; c=relaxed/simple;
	bh=HyBSVP9vaW+zxs8yUs65KBf1dFoj9lJNktmuMf6kBsw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S2TyfbczCIw7s8Wkk6zmqqmk+BEQy5s05CBiW2qJ+DR1lVEN6BuWlqyQVu1aE4xS9tFMdi3/lBhn7Fjdp8mggRkJ53sKfVVgenDyZBrfs3jewl8DTq3qJ7Gx82WoDaCipYg6kD8l93Ql/xYHolSQtBaV9qCQ8e7R6S14YgY0hSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=Ibr372lp; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="Ibr372lp"
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 57E77SQA095728;
	Thu, 14 Aug 2025 15:07:28 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4c2bsB66Lpz2L4ry1;
	Thu, 14 Aug 2025 15:07:10 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 14 Aug 2025 15:07:25 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <rostedt@goodmis.org>, <surenb@google.com>, <hannes@cmpxchg.org>,
        <peterz@infradead.org>, <mingo@redhat.com>
CC: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>, <andrii@kernel.org>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <yuming.han@unisoc.com>,
        <ke.wang@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: [RFC PATCH] sched: psi: Add psi events trace point
Date: Thu, 14 Aug 2025 15:07:19 +0800
Message-ID: <20250814070719.865-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 57E77SQA095728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1755155261;
	bh=CUVJOspjeTissTdOFBExc/EBuLf29IJX1c9mooiSAas=;
	h=From:To:CC:Subject:Date;
	b=Ibr372lp6cWBsXFN0OI1YVMyDpxSu6HP0F+zRzybeYAPc+BtVUGnjaWgDmfbGtS9d
	 nLo9PVkeKduMonh05kZ8F+PdqRrXNtpG2dTtD2Ck6mnlZYGlqcyFbEIQ2tlC42inLR
	 3QEvcxjpaDGvKhMJ3lMCdblMikHWqQbRQCqOxiS9onZcxVJujx2je1m93uDC1oY9TZ
	 nwNH8gMoGXl/A8CSTVhcCjNSAsgqLKL95lVrABhO0+QOKt0XPZdGirdmiHdjBLDmpK
	 Ing4uonbCJK1Br8NLQ5qsqhGHX39DzJoscNtSnwJT3hmc+lIwjiO6688cr7wNNnMhM
	 OsLAx1VRH1gSQ==

Add trace point to psi triggers. This is useful to
observe the psi events in the kernel space.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 include/trace/events/sched.h | 5 +++++
 kernel/sched/psi.c           | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..c23cb2bc76fd 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -896,6 +896,11 @@ DECLARE_TRACE(sched_set_need_resched,
 	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
 	TP_ARGS(tsk, cpu, tif));
 
+struct psi_trigger *t
+DECLARE_TRACE(psi_event,
+	TP_PROTO(struct psi_trigger *t),
+	TP_ARGS(t));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 59fdb7ebbf22..268fc1b9cf1d 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -509,6 +509,8 @@ static void update_triggers(struct psi_group *group, u64 now,
 		if (now < t->last_event_time + t->win.size)
 			continue;
 
+		trace_psi_event_tp(t);
+
 		/* Generate an event */
 		if (cmpxchg(&t->event, 0, 1) == 0) {
 			if (t->of)
-- 
2.25.1

