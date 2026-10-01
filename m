Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD1C5275A1
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868099; cv=none; b=Bw4T0OOb9+fqEWoWs+F3J9Om8ZqDFJUnAQ8h/yNufsMwUijQbevFrlN1m8j74XmVhK9ABs4YMUtHvuXiXMpZisCtXFlvSiaPjZWCxrUk4VIpmnDtSnGUPJqIaVnr+ZTc7UJ2jkmTPTNXhW8NcVG8UCe5qmlHYTiXWcUiOiWozkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868099; c=relaxed/simple;
	bh=3DM/K98fffruEH8/09LX1Unl1VL6OtdvW7P6hrxuI0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FtW7UyJVF2iKyTcouTGWqWlF3b+VKw6mLEwgQhJqd/AXvDpz1b8Amrl3kcn69HvcQsMQoV2EztbOyNgYVcKUGj33bk89Qef+ylLtTClmBaMZBMO/enkd1wc1SZxOANar142VT21uHwqauUl85YeLReaQAY3js4qNECBb0MSNzUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TPPCh7Fd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPPCh7Fd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790868096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6xpONabfnSBWbWSB7Bl4iKA12vAnmh9pV4xx/IOXqI=;
	b=TPPCh7FdXH+RH6719imMvOjtQ266nlM7lxer+dZ2hHSqCj0TULZS8xkzOrysSNuGWggOWF
	MY7/DOIu2/0f/9M2kfYDw7Pd3ERktPZhbsrGp1k5V6Gf0BWDw7KfojY7nQrB3Vy5pKr/Xo
	YFYU1WAPIGh3tWMtJqfzTRJn/YJA3rU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-7XLberyqMKeVFPnL_XiV2g-1; Thu,
 01 Oct 2026 11:21:33 -0400
X-MC-Unique: 7XLberyqMKeVFPnL_XiV2g-1
X-Mimecast-MFC-AGG-ID: 7XLberyqMKeVFPnL_XiV2g_1790868091
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D4FA195419D;
	Thu,  1 Oct 2026 15:21:31 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 09D541800351;
	Thu,  1 Oct 2026 15:21:27 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH v2 02/15] tools/rv: Skip empty pid error in selftest if command failed
Date: Thu,  1 Oct 2026 17:20:29 +0200
Message-ID: <20261001152042.124445-3-gmonaco@redhat.com>
In-Reply-To: <20261001152042.124445-1-gmonaco@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: Wk_85bq_EW0rbzBH2YGWTP0YbNPiHiK3RR_gUmIDWgs_1790868091
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Some rv userspace selftests rely on the pid of the rv process to match
with the output and fail prematurely in case the pid was not found.
If the rv process failed, however, it's likely it will terminate before
catching the pid, and the test reports empty pid ignoring the error that
caused the process to fail.

Report empty pid only when the rv process succeeds (exit code not what
was expected) and continue showing exit code and output otherwise.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/tests/engine.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/verification/tests/engine.sh b/tools/verification/tests/engine.sh
index cfdf2180aad8..4dad43b0b822 100644
--- a/tools/verification/tests/engine.sh
+++ b/tools/verification/tests/engine.sh
@@ -60,8 +60,9 @@ _check() {
 	failbuf=''
 	fail=0
 
-	# Suppress any other error if a needed pid is empty
-	if [ -z "$pid" ] && grep -q "\$pid" <<< "$patterns"; then
+	# Suppress any other error if a needed pid is empty and there was no other error
+	if [ -z "$pid" ] && grep -q "\$pid" <<< "$patterns" \
+		&& [ $exitcode -eq "$expected_exitcode" ]; then
 		result=''
 		failure "# Empty pid for $command"
 		return 1
-- 
2.55.0

