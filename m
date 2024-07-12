Received: from relay162.nicmail.ru (relay162.nicmail.ru [91.189.117.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC06BE46;
	Fri, 12 Jul 2024 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815194; cv=none; b=bfZGytA5rWJ8sKaIKAZfohum3pKgoe/qIdeGH/bODC5EIJDZgAZ450u4JM1nqVqNtse1Y/ASUsAJbrBEOG1wb+0brZ1FaNdFW/GvnWKslvmFJtlzaIdjJRC4Ojg4qljWBQf63PFd7XN0Z6Dbf47MZ3Fiuw/+oc+JAx80jEEt29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815194; c=relaxed/simple;
	bh=tw55h07OSfjQ937dzNTNMQpm5DrEVMeQv1t95oTNcU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JW/nNNWebJ6Bt9WWlIQnPfeGViuCKaL1aL30VwfZzqsDTSuAZZCe9a5B7cMzJjuwbCw897TRy3s2lNrAR+ZRG/wphMYSpUJRPpxYBIq+NYziaPhPtTRrOyGJ7wQnBmkZ0Ovx83lHRWPAotV2psjwiN81PpNwme3FJbkO/tgm7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.152] (port=29428 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1sSMdZ-00080c-9f;
	Fri, 12 Jul 2024 23:13:02 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1104.mail.hosting.nic.ru (Exim 5.55)
	with id 1sSMdZ-00FWm2-2q;
	Fri, 12 Jul 2024 23:13:01 +0300
From: Nikita Kiryushin <kiryushin@ancud.ru>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] tracing: remove unreachable trace_array_put
Date: Fri, 12 Jul 2024 23:12:58 +0300
Message-Id: <20240712201258.99070-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-SCL: -1

There is a trace_array_put() in check result for
nonseekable_open() in tracing_buffers_open(). However,
it would be never executed as nonseekable_open never fails
(by design).

Remove the check and associated unreachable code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 7b85af630348 ("tracing: Get trace_array ref counts when accessing trace files")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
 kernel/trace/trace.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 578a49ff5c32..7e480501b509 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7883,11 +7883,7 @@ static int tracing_buffers_open(struct inode *inode, struct file *filp)
 
 	mutex_unlock(&trace_types_lock);
 
-	ret = nonseekable_open(inode, filp);
-	if (ret < 0)
-		trace_array_put(tr);
-
-	return ret;
+	return nonseekable_open(inode, filp);
 }
 
 static __poll_t
-- 
2.34.1

