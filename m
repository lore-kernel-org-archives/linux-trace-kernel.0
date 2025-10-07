Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720902797BE
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830840; cv=none; b=n0fry9kqhMW0Kh3aQ9lJAvYacwKhx36jhxrd/rxLWhAHFdc1w8AZoF0a2vh60tfXC5wD+moQ/H9H3hdM/y8+rbQ/xIy9Ud+Qxfa574cOgHK9zTlGzzenIIIYuCZf/4Lg9js9+spEpWNg8JWtEMQDw2tiHBenZk5x0tipoTzU5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830840; c=relaxed/simple;
	bh=36M0MNbgV00Pqi5+l51V9XYis+XFYGG0olx3EDkVhg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLTTNIf4A2LcuaXgpKj0yCBihS5uxIEjHhoLZtFePIWcTSD43vfLLryGHNiNke4ZOWvKCPTVabVh7JR6zzFvl+O5JpTI46iSz5fFAel/5zdb3OMgonqy+trRcIaO8foQpH6T/kINRSRAlnMYnKPjzuyp11m+sWxxJfRMg3fc31c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5RzTe2X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5RzTe2X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759830837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pG62RW4qXh/xHnupCaMWDYV5gWCoTE5hgP0ELuR9B7s=;
	b=f5RzTe2XhDupDnz6IVHvOv+Du+QLKsJqab+dqBRFa9wmq2ezLScU3+oRBX2hbvC8EVr2hQ
	rp4PR7Z4P579qEPOS+QPrBaUdqc+7I/3fBxe0mB9iA/2sHbDsuyHdu9Te9Wqkgrl/YpKAu
	uCoa6Ca80tMyfn4JOoBgi+E0VhKueVI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-POLmCQlLMOeeJZobFdxlow-1; Tue,
 07 Oct 2025 05:53:54 -0400
X-MC-Unique: POLmCQlLMOeeJZobFdxlow-1
X-Mimecast-MFC-AGG-ID: POLmCQlLMOeeJZobFdxlow_1759830833
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FD641800366;
	Tue,  7 Oct 2025 09:53:53 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.244])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0FF4418004D8;
	Tue,  7 Oct 2025 09:53:50 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 2/3] rtla/tests: Extend action tests to 5s
Date: Tue,  7 Oct 2025 11:53:40 +0200
Message-ID: <20251007095341.186923-2-tglozar@redhat.com>
In-Reply-To: <20251007095341.186923-1-tglozar@redhat.com>
References: <20251007095341.186923-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

In non-BPF mode, it takes up to 1 second for RTLA to notice that tracing
has been stopped. That means that action tests cannot have a 1 second
duration, as the SIGALRM will be racing with the threshold overflow.

Previously, non-BPF mode actions were buggy and always executed
the action, even when stopping on duration or SIGINT, preventing
this issue from manifesting. Now that this has been fixed, the tests
have become flaky, and this has to be adjusted.

Fixes: 4e26f84abfb ("rtla/tests: Add tests for actions")
Fixes: 05b7e10687c ("tools/rtla: Add remaining support for osnoise actions")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/tests/osnoise.t  | 4 ++--
 tools/tracing/rtla/tests/timerlat.t | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index e3c89d45a6bb..08196443fef1 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -39,9 +39,9 @@ check "hist stop at failed action" \
 check "top stop at failed action" \
 	"timerlat top -T 2 --on-threshold shell,command='echo -n abc; false' --on-threshold shell,command='echo -n defgh'" 2 "^abc" "defgh"
 check "hist with continue" \
-	"osnoise hist -S 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+	"osnoise hist -S 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
 check "top with continue" \
-	"osnoise top -q -S 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+	"osnoise top -q -S 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
 check "hist with trace output at end" \
 	"osnoise hist -d 1s --on-end trace" 0 "^  Saving trace to osnoise_trace.txt$"
 check "top with trace output at end" \
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index b5d1e7260a9b..b550a6ae2445 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -60,9 +60,9 @@ check "hist stop at failed action" \
 check "top stop at failed action" \
 	"timerlat top -T 2 --on-threshold shell,command='echo -n 1; false' --on-threshold shell,command='echo -n 2'" 2 "^1ALL"
 check "hist with continue" \
-	"timerlat hist -T 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+	"timerlat hist -T 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
 check "top with continue" \
-	"timerlat top -q -T 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+	"timerlat top -q -T 2 -d 5s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
 check "hist with trace output at end" \
 	"timerlat hist -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
 check "top with trace output at end" \
-- 
2.51.0

