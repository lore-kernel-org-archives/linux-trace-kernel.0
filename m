Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20CC2222D1
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 May 2025 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212238; cv=none; b=qVdU4D22/BhKva4PZOd6ekRkB9utQXaYn/DZvb6s/Xj44WceYUUZKAmHO1xpRoSpJt65CUSnYTzF1BQstIYn9l2qDqrcCd6TrhpeCXzpd8NviVp65m9Mds5p0pl5Q/VG03E54aIaoxIOWxwhpCpYVn/NufeFHRm2MkXHWM70PFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212238; c=relaxed/simple;
	bh=Q/gmaZitNUy7PGKIGZr56MbVLDyPJQIGg3ovMHnqkSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugguOsIB85+wizkH1GtOiQDj+/yc8OpVSxqW+152EGY/D4pRORh4b8YZxbMvpGOnxhZBjfw5VaSLp6PK6tXJD/DI/n3XXe9x3zMFuaYL45D+Hao2LoozMdg5iHwjak7QplzDD3PIdqzTYKp/sUv+ssbn4NY+A/KiBWB/69Vdtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=giGATNbh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giGATNbh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747212235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjnDKvTuWk25Od1hNCNKL2cK4eQ0a+O0r9zXXkmS0OU=;
	b=giGATNbhwBbMTA67gkY4qjQGZPqIrvmxuP/+DUbu2uz047tBq1ihWOSH49oUMuHieRJYA0
	W0L/PcllcYjRzdYBj/WIsx7wXvjbWpIG6xswcv3+di+rwoVzWZ4rXp6BgYkVLHS3oRbYNH
	7fBtN507RK5ORBy/p8fbAnATb0Q97Ao=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-5QifaTuZPKWLrTAWafHBNQ-1; Wed,
 14 May 2025 04:43:54 -0400
X-MC-Unique: 5QifaTuZPKWLrTAWafHBNQ-1
X-Mimecast-MFC-AGG-ID: 5QifaTuZPKWLrTAWafHBNQ_1747212233
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D6F11800361;
	Wed, 14 May 2025 08:43:53 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.189])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2178A1953B80;
	Wed, 14 May 2025 08:43:48 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>
Subject: [RFC PATCH v2 05/12] rv: Return init error when registering monitors
Date: Wed, 14 May 2025 10:43:07 +0200
Message-ID: <20250514084314.57976-6-gmonaco@redhat.com>
In-Reply-To: <20250514084314.57976-1-gmonaco@redhat.com>
References: <20250514084314.57976-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Monitors generated with dot2k have their registration function (the one
called during monitor initialisation) return always 0, even if the
registration failed on RV side.
This can hide potential errors.

Return the value returned by the RV register function.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/monitors/sched/sched.c | 3 +--
 kernel/trace/rv/monitors/sco/sco.c     | 3 +--
 kernel/trace/rv/monitors/scpd/scpd.c   | 3 +--
 kernel/trace/rv/monitors/sncid/sncid.c | 3 +--
 kernel/trace/rv/monitors/snep/snep.c   | 3 +--
 kernel/trace/rv/monitors/snroc/snroc.c | 3 +--
 kernel/trace/rv/monitors/tss/tss.c     | 3 +--
 kernel/trace/rv/monitors/wip/wip.c     | 3 +--
 kernel/trace/rv/monitors/wwnr/wwnr.c   | 3 +--
 9 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/rv/monitors/sched/sched.c b/kernel/trace/rv/monitors/sched/sched.c
index 905e03c3c934..d04db4b543f9 100644
--- a/kernel/trace/rv/monitors/sched/sched.c
+++ b/kernel/trace/rv/monitors/sched/sched.c
@@ -21,8 +21,7 @@ struct rv_monitor rv_sched = {
 
 static int __init register_sched(void)
 {
-	rv_register_monitor(&rv_sched, NULL);
-	return 0;
+	return rv_register_monitor(&rv_sched, NULL);
 }
 
 static void __exit unregister_sched(void)
diff --git a/kernel/trace/rv/monitors/sco/sco.c b/kernel/trace/rv/monitors/sco/sco.c
index 4cff59220bfc..66f4639d46ac 100644
--- a/kernel/trace/rv/monitors/sco/sco.c
+++ b/kernel/trace/rv/monitors/sco/sco.c
@@ -71,8 +71,7 @@ static struct rv_monitor rv_sco = {
 
 static int __init register_sco(void)
 {
-	rv_register_monitor(&rv_sco, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_sco, &rv_sched);
 }
 
 static void __exit unregister_sco(void)
diff --git a/kernel/trace/rv/monitors/scpd/scpd.c b/kernel/trace/rv/monitors/scpd/scpd.c
index cbdd6a5f8d7f..299703cd72b0 100644
--- a/kernel/trace/rv/monitors/scpd/scpd.c
+++ b/kernel/trace/rv/monitors/scpd/scpd.c
@@ -79,8 +79,7 @@ static struct rv_monitor rv_scpd = {
 
 static int __init register_scpd(void)
 {
-	rv_register_monitor(&rv_scpd, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_scpd, &rv_sched);
 }
 
 static void __exit unregister_scpd(void)
diff --git a/kernel/trace/rv/monitors/sncid/sncid.c b/kernel/trace/rv/monitors/sncid/sncid.c
index f5037cd6214c..3e1ee715a0fb 100644
--- a/kernel/trace/rv/monitors/sncid/sncid.c
+++ b/kernel/trace/rv/monitors/sncid/sncid.c
@@ -79,8 +79,7 @@ static struct rv_monitor rv_sncid = {
 
 static int __init register_sncid(void)
 {
-	rv_register_monitor(&rv_sncid, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_sncid, &rv_sched);
 }
 
 static void __exit unregister_sncid(void)
diff --git a/kernel/trace/rv/monitors/snep/snep.c b/kernel/trace/rv/monitors/snep/snep.c
index 0076ba6d7ea4..2adc3108d60c 100644
--- a/kernel/trace/rv/monitors/snep/snep.c
+++ b/kernel/trace/rv/monitors/snep/snep.c
@@ -79,8 +79,7 @@ static struct rv_monitor rv_snep = {
 
 static int __init register_snep(void)
 {
-	rv_register_monitor(&rv_snep, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_snep, &rv_sched);
 }
 
 static void __exit unregister_snep(void)
diff --git a/kernel/trace/rv/monitors/snroc/snroc.c b/kernel/trace/rv/monitors/snroc/snroc.c
index bb1f60d55296..540e686e699f 100644
--- a/kernel/trace/rv/monitors/snroc/snroc.c
+++ b/kernel/trace/rv/monitors/snroc/snroc.c
@@ -68,8 +68,7 @@ static struct rv_monitor rv_snroc = {
 
 static int __init register_snroc(void)
 {
-	rv_register_monitor(&rv_snroc, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_snroc, &rv_sched);
 }
 
 static void __exit unregister_snroc(void)
diff --git a/kernel/trace/rv/monitors/tss/tss.c b/kernel/trace/rv/monitors/tss/tss.c
index 542787e6524f..0452fcd9edcf 100644
--- a/kernel/trace/rv/monitors/tss/tss.c
+++ b/kernel/trace/rv/monitors/tss/tss.c
@@ -74,8 +74,7 @@ static struct rv_monitor rv_tss = {
 
 static int __init register_tss(void)
 {
-	rv_register_monitor(&rv_tss, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_tss, &rv_sched);
 }
 
 static void __exit unregister_tss(void)
diff --git a/kernel/trace/rv/monitors/wip/wip.c b/kernel/trace/rv/monitors/wip/wip.c
index ed758fec8608..4b4e99615a11 100644
--- a/kernel/trace/rv/monitors/wip/wip.c
+++ b/kernel/trace/rv/monitors/wip/wip.c
@@ -71,8 +71,7 @@ static struct rv_monitor rv_wip = {
 
 static int __init register_wip(void)
 {
-	rv_register_monitor(&rv_wip, NULL);
-	return 0;
+	return rv_register_monitor(&rv_wip, NULL);
 }
 
 static void __exit unregister_wip(void)
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitors/wwnr/wwnr.c
index 172f31c4b0f3..4145bea2729e 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.c
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
@@ -70,8 +70,7 @@ static struct rv_monitor rv_wwnr = {
 
 static int __init register_wwnr(void)
 {
-	rv_register_monitor(&rv_wwnr, NULL);
-	return 0;
+	return rv_register_monitor(&rv_wwnr, NULL);
 }
 
 static void __exit unregister_wwnr(void)
-- 
2.49.0

