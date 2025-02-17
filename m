Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254FB21C188;
	Mon, 17 Feb 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798195; cv=none; b=oajJYQZQom1AesrPGnFTTghQOC3KWScjxz+dbhW1nL6u3WiMhShGA4BaKPf6XSfCf6p6YZLuGyksX5BXjVHykVaP5td+thDkvxPgB+wMqYp6tUNPHBGXP/SJcaUskzYui0XbmU+zOGq/ufxWWPRlN6G5sNnCfrLvpTA7O+ZR6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798195; c=relaxed/simple;
	bh=wyxvqAZpVxqQZ+urKOWQ+0EqdnJ4IB5u0lshrjFkqAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QLzMqAgkKdG1VCySr4WAY4HbUllTdEUhEX4KVnd7ZrGzu3XJ9NnLxGF3sy9TylYMP1OBNQy1zDBVN9NSpumRzvaSnxmnCAVQW7QbWZ5jGq+a5bkwiqOijKq8k9HZ7+IlnGVsy49Ls3clHYPnQ0BnltezoWNU0sP3XLRPr6SuOA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MYTv89Ja; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nhnlbg3r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYTv89Ja";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nhnlbg3r"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739798191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hbzeR8+Y7kYNnpEhwXuG2o0ayidVAVXDLH2xJ++sFq0=;
	b=MYTv89JaLWwTZ4hqEsQ65a3p8WL38z2EgzHOFTBQUgpGy0HrA6Vs1LwodIHPhkXDF7NUhc
	V8DGXyvNtuQmAPfEeCiooWf2I4QNw/r0Tkue4XoFcc4ffVzddVf87c+Lxa7Ev/YtIQffy2
	TP+WBevURyfeW6nUqxjk1G6kYcohn7BfIxZNNw0nSkugf0hFkbleDLFvRMi5BPCHwZMy+y
	FQJ6zd4wMmlmsfTW1e8RYt1ShyB8QHN+ohqsvu7zoJbe4wLyyoDyfWb8jh0QrwpXFvTuE9
	t0LPvm4mMSSO7Yugr2TXaxoYb+ehMquBD4gzOM1o5jniTWCFJQCxijqXZI4CQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739798191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hbzeR8+Y7kYNnpEhwXuG2o0ayidVAVXDLH2xJ++sFq0=;
	b=nhnlbg3rrME/McneTBlNPVXjK2e2zMfvWMeY7kjBlShSXXD2ZqTobgx0Aml1TDArIvvxmu
	MDWkImDjbtw80lAA==
Date: Mon, 17 Feb 2025 14:16:12 +0100
Subject: [PATCH] tracing/user_events: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-restricted-pointers-trace-v1-1-bbe9ea279848@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAJs2s2cC/x3MQQrDIBBG4auEWXdAhUbIVUoXVv8kszFhRkpBc
 vdIl9/ivU4GFRgtUyfFV0yOOuAfE+U91Q0sZZiCC08XfGSFNZXcUPg8pDaocdOUwcmtHx+iiyn
 PNPpTscrv/369r+sGfoClOWsAAAA=
X-Change-ID: 20250217-restricted-pointers-trace-a0fb12707ac6
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739798191; l=1287;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=wyxvqAZpVxqQZ+urKOWQ+0EqdnJ4IB5u0lshrjFkqAw=;
 b=r/RcJt5aXygEOq0CjtIFIXiehHHKoVjtu7JXI7aBsbaIYYQRlJKgkBeAfl3dKOEiuEUXKwjlW
 apHuprJr5oQALJnPJYhMHz2Do8HvvdaBADzKQSr/efP+GBMNB92Z+jw
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Restricted pointers ("%pK") are not meant to be used through printk().
It can unintentionally expose security sensitive, raw pointer values.

Use regular pointer formatting instead.

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/trace/trace_events_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 97325fbd62836f4fb477c4a2b2936eff544291ec..3effc6fce20e65a8077de5221eb69db04fb1a775 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -455,7 +455,7 @@ static void user_event_enabler_fault_fixup(struct work_struct *work)
 	if (ret && ret != -ENOENT) {
 		struct user_event *user = enabler->event;
 
-		pr_warn("user_events: Fault for mm: 0x%pK @ 0x%llx event: %s\n",
+		pr_warn("user_events: Fault for mm: 0x%p @ 0x%llx event: %s\n",
 			mm->mm, (unsigned long long)uaddr, EVENT_NAME(user));
 	}
 

---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250217-restricted-pointers-trace-a0fb12707ac6

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

