Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569AF3EF668
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949581; cv=none; b=T/AxSUQ8gtrddSNGyqlQsfgmA9IXNiH8KzQzsLpflW9SBYjfMqayhCa5rj6LIZ/2EhpOzSpytV8u/1H9Gpiuw7LWaGh9lVzMMKAkVd+UisWiIGoUfjGulkFvnR9d377cBq9j1Ms3kObeU9HY8MWYbfXN6dDHX/MHfagSk8gLxiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949581; c=relaxed/simple;
	bh=IVEoVJLaOW+OQ3xUR3Fk3fINw5X12rMVrCN7XEIr5nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XMZmpfKxc5dWsZSoSwj4Q6wIbB8aX1vjxAWRYPlv5L3UR+j47isqd1QIkWYfR4W9NciLZEEjZcPArB6sVlt0EMnhSpvFwrGf8dSdWOQMb+eIzvWUIFMFrVqa50p97INQJLbgFBglb6f5Xzaz4HFHqXbWz+H3f1+eJgv6uFLPlsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKJNnhya; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKJNnhya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776949579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUPA16kyMcDrjTI7wxaAg2ovzTokNi1sNbJRhq/QcZI=;
	b=aKJNnhya7KpPaWHLtbXRiQv1O7t1V0jSn+8S7G+yBLElmnstD0zyYJiU0EKCA4Uem/62Rq
	WoCVR6RL2RcnftnWcOqwG8PO/xVoy+MUw7cd7i5gj4dELcGdZCPRTyZEsOQ1custpueMv/
	Nk7GLfGXc587smaBeTEwPIfI9RvBVTQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-VHMa3HWfNF6Ve-mvAfIabQ-1; Thu,
 23 Apr 2026 09:06:17 -0400
X-MC-Unique: VHMa3HWfNF6Ve-mvAfIabQ-1
X-Mimecast-MFC-AGG-ID: VHMa3HWfNF6Ve-mvAfIabQ_1776949576
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBEE018001E1;
	Thu, 23 Apr 2026 13:06:15 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A18F01800347;
	Thu, 23 Apr 2026 13:06:13 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 4/9] rtla/tests: Use negative match when testing --aa-only
Date: Thu, 23 Apr 2026 15:05:53 +0200
Message-ID: <20260423130558.882022-5-tglozar@redhat.com>
In-Reply-To: <20260423130558.882022-1-tglozar@redhat.com>
References: <20260423130558.882022-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 3jd-h60zZpAvYX7VyJsysZf41s7oHOEuGpSGS8MThjE_1776949576
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

For testing the -a/--auto option in timerlat tool, the string "analyzing
it" is matched against to make sure auto-analysis was triggered.

Use the same string as a negative match for --aa-only option test.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/timerlat.t | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index fb60022aaa64..f47a82c115c7 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -38,7 +38,7 @@ check_top_hist "dump tasks" \
 check "print the auto-analysis if hits the stop tracing condition" \
 	"timerlat top --aa-only 5" 2
 check_top_hist "disable auto-analysis" \
-	"timerlat TOOL -s 3 -T 10 -t --no-aa" 2
+	"timerlat TOOL -s 3 -T 10 -t --no-aa" 2 "" "analyzing it"
 check_top_q_hist "verify -c/--cpus" \
 	"timerlat TOOL -c 0 -d 10s -T 1 --on-threshold shell,command=tests/scripts/check-cpus.sh" 2 "^Affinity of threads: 0$"
 
-- 
2.53.0

