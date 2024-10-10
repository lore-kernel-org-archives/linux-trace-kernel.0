Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3645A1BCA02
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552830; cv=none; b=gvquFgrNo9xP1vwEyz6bBHEJHXSGPz1meuYPXi/ezwyMf3k3ZR44XfP25sh/DqSCdljIw/MhECRREVDz0EIJkfbU+w4JbRB5G5M73E3vBRUGvNur3VjkCcB48uMX73YkSCTaj1vg/ETLRcWGrBudpW7jTxwOE6YOxHi5UA4MzKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552830; c=relaxed/simple;
	bh=fkXobUdfWdyEcyBYXYsJwrld/0fHQc7RFH181BVrf/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=mtWmCLTy0WcbSlRNM4Hf0+fh8+N6mcNOZ75Um2rKx4qNkr8Hv3qkDYXfD99UvBRiftiZdNeZqSuxwFfhLNY75qgj/8VcXjfc7iKW+XlLH63CaYk+WwccoVSPFwR3UW+QV5hCTVpoR9w4pIIacEmhJsGZ6Ox5MGAEYITJRU5Rthw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MsHuEVEf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsHuEVEf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728552827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=huflEMTO5aCsGTjWE8teWJNUWw4AKygAw9ZhX1UXaaM=;
	b=MsHuEVEfnu3wq2DxKJ1pVtfvrN0vmQO6sy7It5sAAbpO7hhWjjWa51hcMj10VbwUjueKyD
	z2gGrxSurj2E9tAvYyktXf4owW2keV751lMPFQZWCS6Hjh2lDRF21J3CjaDtzsULOdgjS/
	s8bdFRXqATZO5V+O0TD/T5MWnMWlLx8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-dzgoB4H1P4SZqz8QQuKnMQ-1; Thu,
 10 Oct 2024 05:33:44 -0400
X-MC-Unique: dzgoB4H1P4SZqz8QQuKnMQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18A2D195608C;
	Thu, 10 Oct 2024 09:33:43 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.226.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9C3E300019E;
	Thu, 10 Oct 2024 09:33:40 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jstancek@redhat.com,
	jforbes@redhat.com,
	ezulian@redhat.com,
	tglozar@redhat.com
Subject: [PATCH 1/2] tools/rtla: drop __NR_sched_getattr
Date: Thu, 10 Oct 2024 11:32:58 +0200
Message-ID: <c355dc9ad23470098d6a8d0f31fbd702551c9ea8.1728552769.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

It's not used since commit 084ce16df0f0 ("tools/rtla:
Remove unused sched_getattr() function").

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/tracing/rtla/src/utils.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 9ac71a66840c..05b2b3fc005e 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -211,24 +211,20 @@ long parse_ns_duration(char *val)
 /*
  * This is a set of helper functions to use SCHED_DEADLINE.
  */
-#ifdef __x86_64__
-# define __NR_sched_setattr	314
-# define __NR_sched_getattr	315
-#elif __i386__
-# define __NR_sched_setattr	351
-# define __NR_sched_getattr	352
-#elif __arm__
-# define __NR_sched_setattr	380
-# define __NR_sched_getattr	381
-#elif __aarch64__ || __riscv
-# define __NR_sched_setattr	274
-# define __NR_sched_getattr	275
-#elif __powerpc__
-# define __NR_sched_setattr	355
-# define __NR_sched_getattr	356
-#elif __s390x__
-# define __NR_sched_setattr	345
-# define __NR_sched_getattr	346
+#ifndef __NR_sched_setattr
+# ifdef __x86_64__
+#  define __NR_sched_setattr	314
+# elif __i386__
+#  define __NR_sched_setattr	351
+# elif __arm__
+#  define __NR_sched_setattr	380
+# elif __aarch64__ || __riscv
+#  define __NR_sched_setattr	274
+# elif __powerpc__
+#  define __NR_sched_setattr	355
+# elif __s390x__
+#  define __NR_sched_setattr	345
+# endif
 #endif
 
 #define SCHED_DEADLINE		6
-- 
2.43.0

