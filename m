Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF3E340264
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706975; cv=none; b=lZQP5A3l7HYbreNNFrXJqWdCDrL1OEx1kk6YhxdsIql+oyf3kN2mDShADq+dD6QjOIucO+fyw80AHAClEISKMB+FZFYpO7d+BEagQfbl/6KLXAefjh6RIZVyG8BMMJ6u8/LyFlHn+ViYIN2JMtbrdIFH392jcDBV5IE9rputURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706975; c=relaxed/simple;
	bh=GdNVqyvUvcHuf/HcL1GjWVzimf5pBVb6UaPWIEtgTpw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLYcjbrUzMT2ECvRLNtcrb8JcHGg3/Tqix6wzxBXGeuDEZxYkwyE0U9HkWwD3BHl4CdN5ZIarqqNmTTxISUOQrrJKeYI0RKfs3+/W+IzHbGVwI3p/Z4zanuZofLMW2X+CVx0mHlWw9Lh4OKbBSvBv+5MXcSaV68FRw3bDv/qRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8k3H0ni; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8k3H0ni"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767706972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMb5EeLAGOztdhNhPXPhwLEVSwERWiY6H9aj3v+zftA=;
	b=H8k3H0niuHAI7tdiyUUy0yA8anttQn8/5PXoqJYL2RKm4iVmO0Sxqckco0Ad+tRuhd+SYK
	kf1E2SwT8l2TYGIlAX6A06kX5L7PrccI8Mg+P9n3gWOk6YgAg4ZwfPXkJxxHonAeTM7Qy7
	lCkeiePTc8Cc/zs1H4wEyos5oUGAaWA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-qdtbuPjjOZOqkzBt6YrKeQ-1; Tue,
 06 Jan 2026 08:42:49 -0500
X-MC-Unique: qdtbuPjjOZOqkzBt6YrKeQ-1
X-Mimecast-MFC-AGG-ID: qdtbuPjjOZOqkzBt6YrKeQ_1767706968
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C616195609E;
	Tue,  6 Jan 2026 13:42:48 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B3AB1800367;
	Tue,  6 Jan 2026 13:42:44 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v2 08/18] rtla: Use standard exit codes for result enum
Date: Tue,  6 Jan 2026 08:49:44 -0300
Message-ID: <20260106133655.249887-9-wander@redhat.com>
In-Reply-To: <20260106133655.249887-1-wander@redhat.com>
References: <20260106133655.249887-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The result enum defines custom values for PASSED, ERROR, and FAILED.
These values correspond to standard exit codes EXIT_SUCCESS and
EXIT_FAILURE.

Update the enum to use the standard macros EXIT_SUCCESS and
EXIT_FAILURE to improve readability and adherence to standard C
practices.

The FAILED value is implicitly assigned EXIT_FAILURE + 1, so there
is no need to assign an explicit value.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/utils.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 7fa3ac5e0bfb6..5286a4c7165d3 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -4,6 +4,7 @@
 #include <time.h>
 #include <sched.h>
 #include <stdbool.h>
+#include <stdlib.h>
 
 /*
  * '18446744073709551615\0'
@@ -102,7 +103,7 @@ __attribute__((__warn_unused_result__)) int strtoi(const char *s, int *res);
 #define ns_to_per(total, part) ((part * 100) / (double)total)
 
 enum result {
-	PASSED = 0, /* same as EXIT_SUCCESS */
-	ERROR = 1,  /* same as EXIT_FAILURE, an error in arguments */
-	FAILED = 2, /* test hit the stop tracing condition */
+	PASSED	= EXIT_SUCCESS,
+	ERROR	= EXIT_FAILURE,
+	FAILED, /* test hit the stop tracing condition */
 };
-- 
2.52.0

