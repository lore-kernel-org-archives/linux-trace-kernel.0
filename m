Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA1531D380
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153809; cv=none; b=XU6IFzVuN1Ia6cIgRxMG1YtsSPmxei94+PpCCskvy4dQVCFj8hBnwMUoBDNJo6YspTebg7D65MUbJweZ/NY77Mp6zbppFysWAWSwhveQRXs4QOdVOFXf9LC8+UcHenGgseWqBXsH+vEA/H5qlR+yCaHm7JyOsVxVOE/4hm9dUEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153809; c=relaxed/simple;
	bh=pJ78poG9/dSR/9SR9eLiC60bvQx+3N0aqJrUIMbTDPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhSrPvGh7nRU/1Jrv75kEMmeRd1UQsjENTNBTGm3xWeEhTD1UY4yhSIHKpjqlZo+hk07SdRlKwJiU7/ee7w4xmdmaJfu5CHG9ZyX+F7IMbqhRStLTQeJSTuSGePV8x0VNIhvYuvipoc4wiLMqO3UUDtcIItXKgBd/jrLX0i0C78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZqBkLD0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZqBkLD0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764153807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3p+Iodt8jx7PveX+7eZHvZvNP4dSAnqUhkVVKz+5rU=;
	b=DZqBkLD0DeaWJktSle/DfYz6CQe5Xt+6s6HR1dLzQlbwXgRH3e1tz8IFOikcVleSSUVj7Y
	griA/pJeEf9MRKxron3of8MGfSoD56yy8CyFzl5VoqdQ5FzPgNBaZao3immTDFRaq1vmJl
	avm+HwA9F82sD3UTSvDn4lPwRwBg27k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-RCC_9F7iPHuT9jo42iZC8w-1; Wed,
 26 Nov 2025 05:43:23 -0500
X-MC-Unique: RCC_9F7iPHuT9jo42iZC8w-1
X-Mimecast-MFC-AGG-ID: RCC_9F7iPHuT9jo42iZC8w_1764153802
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85CAC1956061;
	Wed, 26 Nov 2025 10:43:22 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.226.131])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 991F518004A3;
	Wed, 26 Nov 2025 10:43:19 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH 8/8] verification/rvgen: Remove unused variable declaration from containers
Date: Wed, 26 Nov 2025 11:42:39 +0100
Message-ID: <20251126104241.291258-9-gmonaco@redhat.com>
In-Reply-To: <20251126104241.291258-1-gmonaco@redhat.com>
References: <20251126104241.291258-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The monitor container source files contained a declaration and a
definition for the rv_monitor variable. The former is superfluous and
can be removed.

Remove the variable declaration from the template as well as the
existing monitor containers.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/monitors/rtapp/rtapp.c                    | 2 --
 kernel/trace/rv/monitors/sched/sched.c                    | 2 --
 tools/verification/rvgen/rvgen/templates/container/main.c | 2 --
 3 files changed, 6 deletions(-)

diff --git a/kernel/trace/rv/monitors/rtapp/rtapp.c b/kernel/trace/rv/monitors/rtapp/rtapp.c
index fd75fc927d65..17f271231c99 100644
--- a/kernel/trace/rv/monitors/rtapp/rtapp.c
+++ b/kernel/trace/rv/monitors/rtapp/rtapp.c
@@ -8,8 +8,6 @@
 
 #include "rtapp.h"
 
-struct rv_monitor rv_rtapp;
-
 struct rv_monitor rv_rtapp = {
 	.name = "rtapp",
 	.description = "Collection of monitors for detecting problems with real-time applications",
diff --git a/kernel/trace/rv/monitors/sched/sched.c b/kernel/trace/rv/monitors/sched/sched.c
index d04db4b543f9..dd9d96fc6e21 100644
--- a/kernel/trace/rv/monitors/sched/sched.c
+++ b/kernel/trace/rv/monitors/sched/sched.c
@@ -8,8 +8,6 @@
 
 #include "sched.h"
 
-struct rv_monitor rv_sched;
-
 struct rv_monitor rv_sched = {
 	.name = "sched",
 	.description = "container for several scheduler monitor specifications.",
diff --git a/tools/verification/rvgen/rvgen/templates/container/main.c b/tools/verification/rvgen/rvgen/templates/container/main.c
index 7d9b2f95c7e9..5fc89b46f279 100644
--- a/tools/verification/rvgen/rvgen/templates/container/main.c
+++ b/tools/verification/rvgen/rvgen/templates/container/main.c
@@ -8,8 +8,6 @@
 
 #include "%%MODEL_NAME%%.h"
 
-struct rv_monitor rv_%%MODEL_NAME%%;
-
 struct rv_monitor rv_%%MODEL_NAME%% = {
 	.name = "%%MODEL_NAME%%",
 	.description = "%%DESCRIPTION%%",
-- 
2.51.1

