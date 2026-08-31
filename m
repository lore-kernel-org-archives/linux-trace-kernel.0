Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969E23DA7D0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167233; cv=none; b=jdbD5kF7TyPMsLq34kaPVWSt+GyfzRdz1QcqQKpMp81WQmex6SKcezl0IYFr/k+Gj5ubkdb0hFMJ+izQWmzR8ehGIC/LjbT5wcZZ5ZMHdlAyY+5x1KV1oXQlAg+a6XoTIp226TL/j5fSr09GIABbZwQOwG1hIzCGAzCWQnSZAac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167233; c=relaxed/simple;
	bh=3DM/K98fffruEH8/09LX1Unl1VL6OtdvW7P6hrxuI0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Nk6NFj73sTEUo0tXTv1Ewb9QtqpM7AHifOESaHgOOJtu7Kvts5XsqJltC5cdSXo9u8iMaIYlWmJ6zi2g+piExeF5vB+EKXh5KNgnQJQYR2TOGg0LVWZANjed+L2d6imoM29UGjexqfUFv/+ETaanodXrDoi/xMxH349dA4m+w/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbTAmYy+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbTAmYy+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6xpONabfnSBWbWSB7Bl4iKA12vAnmh9pV4xx/IOXqI=;
	b=DbTAmYy+jYSIOFz8J6NEruGtb8krwjwj5zYLGIflyi+6Q19ybc5TUhiZKz8ryxTr+axJ9K
	yxG803XhIEVAozlepnP8P8z788WfO6B0vc+hAx7XeOXry9D5yk2ib46isnC7QuX7Ng6mmN
	xbox7UxomtShXr2JjPKui75sDH83orA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-3aVp4fTkMX6317d2y747XQ-1; Mon,
 31 Aug 2026 05:07:04 -0400
X-MC-Unique: 3aVp4fTkMX6317d2y747XQ-1
X-Mimecast-MFC-AGG-ID: 3aVp4fTkMX6317d2y747XQ_1788167223
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 215471944B23;
	Mon, 31 Aug 2026 09:07:03 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C45E118005BB;
	Mon, 31 Aug 2026 09:06:59 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC PATCH 02/20] tools/rv: Skip empty pid error in selftest if command failed
Date: Mon, 31 Aug 2026 11:05:06 +0200
Message-ID: <20260831090524.106845-3-gmonaco@redhat.com>
In-Reply-To: <20260831090524.106845-1-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: p0yDW1Yyx2GIju7gm9Pws3llB8D0cpG-ay5quxexwVk_1788167223
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

