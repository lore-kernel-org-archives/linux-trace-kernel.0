Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D7A26CE29
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710672; cv=none; b=r0vil+6FwyB3h6O0nI0vg1+ORjcRUA/QqXpO3iByw6HQPHmTOM0JbGn97ffn7QnL8n1+uiHhUZLRb+rlJSAxwne+XOCmV/xyQc9NbCWeeGxMGeeW0Urf3WETLP8TG9FIWMTzchHv9VfbpTBCj6f6f/fLIKhRnOqbK2iSijVfBRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710672; c=relaxed/simple;
	bh=wCRHEI4Gr9GQ9YrMxzcufPVsDD45+GAUAQW5OsVA3Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uITG+uP6tUpv/7Es2nav3O+Kl0eU+K67yhMLSi2XjZJD9HQqX2Bn3mF4LBirRrS+1C12O9ne1DvMEU0My6vuZR9Jwx3kysVts6auubZ42PBvzlaiP7P233g/9K7F3nuyJUYa6plfLBinoA5z63IVye/ON8cZ6Yljf0rdRm9jM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmSE1x+9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmSE1x+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753710670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QnREYUfmROuy8Xd9VfNIle0dZqywQvFAtZmuQi72IXo=;
	b=KmSE1x+9tzkAvYTpK+EYVOwJRgXFyAgDjt1fnt8AanEGAdpzc8+qc1H6G7I74dULHi3rKU
	YRm/FOx8aApjwVVtjl7Hk2uX9bJqwOYUtMPEeYP1ajlvxDmrkj1i5LK57j3qSVi7DKtWOn
	xVVyvbxzbkhNWLcXuNexiV/w1Hb2pwo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-_L-ehQGqMMuldP_VbIZ73Q-1; Mon,
 28 Jul 2025 09:51:06 -0400
X-MC-Unique: _L-ehQGqMMuldP_VbIZ73Q-1
X-Mimecast-MFC-AGG-ID: _L-ehQGqMMuldP_VbIZ73Q_1753710664
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D230E1800C3A;
	Mon, 28 Jul 2025 13:51:04 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.215])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A1AF218003FC;
	Mon, 28 Jul 2025 13:50:59 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v5 4/9] rv: Adjust monitor dependencies
Date: Mon, 28 Jul 2025 15:50:16 +0200
Message-ID: <20250728135022.255578-5-gmonaco@redhat.com>
In-Reply-To: <20250728135022.255578-1-gmonaco@redhat.com>
References: <20250728135022.255578-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

RV monitors relying on the preemptirqs tracepoints are set as dependent
on PREEMPT_TRACER and IRQSOFF_TRACER. In fact, those configurations do
enable the tracepoints but are not the minimal configurations enabling
them, which are TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS (not selectable
manually).

Set TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS as dependencies for
monitors.

Fixes: fbe6c09b7eb4 ("rv: Add scpd, snep and sncid per-cpu monitors")
Acked-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/monitors/scpd/Kconfig  | 2 +-
 kernel/trace/rv/monitors/sncid/Kconfig | 2 +-
 kernel/trace/rv/monitors/snep/Kconfig  | 2 +-
 kernel/trace/rv/monitors/wip/Kconfig   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/monitors/scpd/Kconfig b/kernel/trace/rv/monitors/scpd/Kconfig
index b9114fbf680f..682d0416188b 100644
--- a/kernel/trace/rv/monitors/scpd/Kconfig
+++ b/kernel/trace/rv/monitors/scpd/Kconfig
@@ -2,7 +2,7 @@
 #
 config RV_MON_SCPD
 	depends on RV
-	depends on PREEMPT_TRACER
+	depends on TRACE_PREEMPT_TOGGLE
 	depends on RV_MON_SCHED
 	default y
 	select DA_MON_EVENTS_IMPLICIT
diff --git a/kernel/trace/rv/monitors/sncid/Kconfig b/kernel/trace/rv/monitors/sncid/Kconfig
index 76bcfef4fd10..3a5639feaaaf 100644
--- a/kernel/trace/rv/monitors/sncid/Kconfig
+++ b/kernel/trace/rv/monitors/sncid/Kconfig
@@ -2,7 +2,7 @@
 #
 config RV_MON_SNCID
 	depends on RV
-	depends on IRQSOFF_TRACER
+	depends on TRACE_IRQFLAGS
 	depends on RV_MON_SCHED
 	default y
 	select DA_MON_EVENTS_IMPLICIT
diff --git a/kernel/trace/rv/monitors/snep/Kconfig b/kernel/trace/rv/monitors/snep/Kconfig
index 77527f971232..7dd54f434ff7 100644
--- a/kernel/trace/rv/monitors/snep/Kconfig
+++ b/kernel/trace/rv/monitors/snep/Kconfig
@@ -2,7 +2,7 @@
 #
 config RV_MON_SNEP
 	depends on RV
-	depends on PREEMPT_TRACER
+	depends on TRACE_PREEMPT_TOGGLE
 	depends on RV_MON_SCHED
 	default y
 	select DA_MON_EVENTS_IMPLICIT
diff --git a/kernel/trace/rv/monitors/wip/Kconfig b/kernel/trace/rv/monitors/wip/Kconfig
index e464b9294865..87a26195792b 100644
--- a/kernel/trace/rv/monitors/wip/Kconfig
+++ b/kernel/trace/rv/monitors/wip/Kconfig
@@ -2,7 +2,7 @@
 #
 config RV_MON_WIP
 	depends on RV
-	depends on PREEMPT_TRACER
+	depends on TRACE_PREEMPT_TOGGLE
 	select DA_MON_EVENTS_IMPLICIT
 	bool "wip monitor"
 	help
-- 
2.50.1

