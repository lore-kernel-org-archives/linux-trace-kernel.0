Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C016B314A67
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291074; cv=none; b=pwEHNsZaMyY6J9rVvfwqJ9ZK3sa/mPHzcf9u+gmlN55bXDApPI96qJVPCV6ScqzXM6y+lCZpPkoxlCi0Ol8fhqBztuHkAxWGkwVoyf8F6CmiMLUGr0mL0ylOR+w32pdTVC/FUvk4nQdHDDE1uWrwwAPJNea0vLCOfJvJbDYsS/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291074; c=relaxed/simple;
	bh=6qgIJ8u1gERU6N730C3amNcSnAQVHmP8n9+eh+nLyvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcsN8hv3aBnrKRtaU5ZYliyfJplB+GUQAp7DE+2ZavGUbCuqK4aBADdcMe6ohbErS5j3ffByPAouub+rNLYoktBcfxdS0VQ3cZCZQOFfwm5pFP579fk/3gb92/tO0XMVxJBQ+EzQEhCq5IWT3m4UA7jldYMDud1jg44F/t/TjZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cyv5x5qm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cyv5x5qm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758291071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WH7zL8z2soHypFa78bT6ajSkmjk69JdopeRXpRBTaNc=;
	b=Cyv5x5qmChhQ+RAIxNm3FZABx+1m3f68YWmr6g5RnfspT46+fmlyW3tpxmQ+dF/2+VH/ZA
	j+7uQRH2g3EeRwcpTAh3jWCx+wOrsXM30zUeR3vUW48HYsPQmLkcBADJJN+S2g6tMubtRC
	rFcYgOnt/y+cvyJeLOleR3B5JH0tIDI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-g44b1rImNkS4630dZW4snw-1; Fri,
 19 Sep 2025 10:11:08 -0400
X-MC-Unique: g44b1rImNkS4630dZW4snw-1
X-Mimecast-MFC-AGG-ID: g44b1rImNkS4630dZW4snw_1758291067
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB72A1800359;
	Fri, 19 Sep 2025 14:10:58 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A2F541955F43;
	Fri, 19 Sep 2025 14:10:54 +0000 (UTC)
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
Subject: [PATCH v2 09/20] verification/rvgen: Remove unused variable declaration from containers
Date: Fri, 19 Sep 2025 16:09:43 +0200
Message-ID: <20250919140954.104920-10-gmonaco@redhat.com>
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
2.51.0

