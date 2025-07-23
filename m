Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDBD1E32C3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287210; cv=none; b=E1U0tuQPLv8NWuQEtKprUaiC+UWxV+6l6MgrCPCUWmZVDFzOY4i5JZ/GupFb+2dscM816zEti27WDIGJdNsn4s7/5PeoSNtIZ7IA0SdhF1X92GY/E9WePqNGRp6c5gI6e075muZ76qX3CdO2ShXb87Pi8HFe+ey1Sw8IaS20KBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287210; c=relaxed/simple;
	bh=tOC32Oh3OZC6/TRTsRS+MWCGEV9yx9V02OjGz64Lj1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivtfGT8g7tPVzVd8qHgAXEsm7HhQkUdRuiPfshLCMiPabIayGT5Vqvwx0BQdNN0YqQT9G++xhxiWrbW1A1hUpmInvEKe/sEdqScmbsSCkSTHsn5yT4cccUoIfbU7Zunrxji8c2SUEpOLgu/TwxR0zeQBNrlOpdaZNPLa0e9AVfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSCbRRbE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSCbRRbE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753287207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZkotH8eDD3gPKF8/kfB5mDEHts9L4DPlhdUC6a+g0c=;
	b=jSCbRRbEF+w9i/NmNo3uc3ROHciRt81p/1GIkxEfA02qBlNXnB9hGqqmo1hn1YtISOXURc
	qzzgf80P+gpATQfmYHqszrLEWmltQrGaPIs5hvTryDRCXlbcuCFQV/qM4hAZDe8S9MfO4K
	ZUnp30NToAoa31IPtSzc7gudjq3q9dA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-8HPCAYN6MfuuGjr6N8SwfA-1; Wed,
 23 Jul 2025 12:13:24 -0400
X-MC-Unique: 8HPCAYN6MfuuGjr6N8SwfA-1
X-Mimecast-MFC-AGG-ID: 8HPCAYN6MfuuGjr6N8SwfA_1753287202
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C429C18002B2;
	Wed, 23 Jul 2025 16:13:22 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.162])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C82DA18002AF;
	Wed, 23 Jul 2025 16:13:18 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/5] rv: Return init error when registering monitors
Date: Wed, 23 Jul 2025 18:12:40 +0200
Message-ID: <20250723161240.194860-6-gmonaco@redhat.com>
In-Reply-To: <20250723161240.194860-1-gmonaco@redhat.com>
References: <20250723161240.194860-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Monitors generated with dot2k have their registration function (the one
called during monitor initialisation) return always 0, even if the
registration failed on RV side.
This can hide potential errors.

Return the value returned by the RV register function.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/monitors/sched/sched.c                    | 3 +--
 kernel/trace/rv/monitors/sco/sco.c                        | 3 +--
 kernel/trace/rv/monitors/scpd/scpd.c                      | 3 +--
 kernel/trace/rv/monitors/sncid/sncid.c                    | 3 +--
 kernel/trace/rv/monitors/snep/snep.c                      | 3 +--
 kernel/trace/rv/monitors/snroc/snroc.c                    | 3 +--
 kernel/trace/rv/monitors/tss/tss.c                        | 3 +--
 kernel/trace/rv/monitors/wip/wip.c                        | 3 +--
 kernel/trace/rv/monitors/wwnr/wwnr.c                      | 3 +--
 tools/verification/rvgen/rvgen/templates/container/main.c | 3 +--
 tools/verification/rvgen/rvgen/templates/dot2k/main.c     | 3 +--
 11 files changed, 11 insertions(+), 22 deletions(-)

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
diff --git a/tools/verification/rvgen/rvgen/templates/container/main.c b/tools/verification/rvgen/rvgen/templates/container/main.c
index 89fc17cf8958..7d9b2f95c7e9 100644
--- a/tools/verification/rvgen/rvgen/templates/container/main.c
+++ b/tools/verification/rvgen/rvgen/templates/container/main.c
@@ -21,8 +21,7 @@ struct rv_monitor rv_%%MODEL_NAME%% = {
 
 static int __init register_%%MODEL_NAME%%(void)
 {
-	rv_register_monitor(&rv_%%MODEL_NAME%%, NULL);
-	return 0;
+	return rv_register_monitor(&rv_%%MODEL_NAME%%, NULL);
 }
 
 static void __exit unregister_%%MODEL_NAME%%(void)
diff --git a/tools/verification/rvgen/rvgen/templates/dot2k/main.c b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
index 83044a20c89a..e0fd1134bd85 100644
--- a/tools/verification/rvgen/rvgen/templates/dot2k/main.c
+++ b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
@@ -74,8 +74,7 @@ static struct rv_monitor rv_%%MODEL_NAME%% = {
 
 static int __init register_%%MODEL_NAME%%(void)
 {
-	rv_register_monitor(&rv_%%MODEL_NAME%%, %%PARENT%%);
-	return 0;
+	return rv_register_monitor(&rv_%%MODEL_NAME%%, %%PARENT%%);
 }
 
 static void __exit unregister_%%MODEL_NAME%%(void)
-- 
2.50.1

