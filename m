Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D58A20A5EA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184154; cv=none; b=Xk29pvgTrD/KRx0LRRGc1LKgRTQZLvp6eabXp+SoJXp7R9sdnuR7L/z+AMkAVAeg1tRDEloJJngYk2q8o7UbN0BfFgPtbrGiZOcjKNGKWdeMkYdKNHYolqT9F7WHB9QSpWF/4opxI6IVgn/lUdXhBif5XZaTg9J2OIGBdobNbtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184154; c=relaxed/simple;
	bh=PDHixAkCz2hUGn/9QvUEliZqbUZBqmNiqr4tcOzsd9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDnl8bBOQbIs6KWmvaS9ErbHbxWIoVZGUh/+KX+J4A7Wx6Vi9S8vjsCA/B1Ukn/IlcUdLJIVvOBkgc1uSNsXog+6P6qDXW7SbdxLtu8w0l1GtEJyGIpiVMayNPxwkVWD4KFHaBbHFyP/+VAi2fYcbVH712rYc6Njne4J/YHQ8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLEnlK07; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLEnlK07"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgY1l2hyeaoTtIgLtZ3jRMog3VIP/D81DWJyXRv2tfE=;
	b=PLEnlK07Y/aoPMY6f2VMO3oxQZhe3+898TvS4W+uqDajv2+RJKz/DxP+5HzOHgEZRLRwNc
	7xgDQJRuYAqdsWEc5qNQHmpZRChTAvr4BocA0+FxvARkkllR04z+Rp7kQH3BqodE/ENBNF
	320TAhxnowOJvOpuZ2Tw8xH7fRzoHp4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-b7gB0mZxOAWE-kngaOnexQ-1; Thu,
 14 Aug 2025 11:09:06 -0400
X-MC-Unique: b7gB0mZxOAWE-kngaOnexQ-1
X-Mimecast-MFC-AGG-ID: b7gB0mZxOAWE-kngaOnexQ_1755184145
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 718EF18002CD;
	Thu, 14 Aug 2025 15:09:05 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 229361800280;
	Thu, 14 Aug 2025 15:09:00 +0000 (UTC)
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
Subject: [RFC PATCH 07/17] verification/rvgen: Remove unused variable declaration from containers
Date: Thu, 14 Aug 2025 17:07:59 +0200
Message-ID: <20250814150809.140739-8-gmonaco@redhat.com>
In-Reply-To: <20250814150809.140739-1-gmonaco@redhat.com>
References: <20250814150809.140739-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The monitor container source files contained a declaration and a
definition for the rv_monitor variable. The former is superfluous and
can be removed.

Remove the variable declaration from the template as well as the
existing monitor containers.

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
2.50.1

