Received: from out-171.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D43939D2
	for <linux-trace-kernel@vger.kernel.org>; Sun,  9 Aug 2026 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786295475; cv=none; b=XFDLsxhjgQDb9WX4qQ7V+D8X88ITFH82o5Mc/V2e4/o3KSB9lIeLcZHGKywLS64fKgKrnoyGTdMsT4He3NitlbyHhY8T0Nk9vXp4lf8NUuwi+RcOi1BsAnyPp3MaClh5/35qll3XmyixGU56506y/3pGDsVd/0TikrfVYPN0mFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786295475; c=relaxed/simple;
	bh=wAQg/9NmXrfLyobx5fIeaAV5CS0AJ9K9oCiIVxJDzZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ECQaXulEnrvzO5of49+4UH79dxYzNSXC5pCqRKgYWxRD8KLbkM+1Hytw5cQJXZTHsQpgwBFgx1OPof1NApXiICK3xq0CPvNrO7QkWvjvztyksZ/bsnsuwo2EaBfSS2jGPFil4SmZHDSk7cG7EWaMSJtJEYitZsa5Mcfh7+RaoDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tN7C2eaS; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tN7C2eaS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786295471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQPNtqtBOPHBRFHptLFqoDAxsGiZfQYOCpsB9fHjmzw=;
	b=tN7C2eaSbRU9RpJFA2QPdUnFaG80k6OGQw8mxSQE2L35xK1ip7Fb+qGvNJ2NoQYRxHsN4t
	ulgvFYTItAWMG2H4NAgTQjyRbBO2dhgDmM1ORcMnfgOA+2PKeJ/Ncqgsp2rO0sP6Cbi+P9
	4s7ffT6ucWBiG0VG0jehJgJTzMNTXmg=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 2/4] rv/reactors: propagate rv_register_reactor() error from reactor init
Date: Mon, 10 Aug 2026 01:10:39 +0800
Message-Id: <c341d0f0849f9c68b0539da49449f8ff2b2d282d.1786294920.git.wen.yang@linux.dev>
In-Reply-To: <cover.1786294920.git.wen.yang@linux.dev>
References: <cover.1786294920.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Both register_react_printk() and register_react_panic() ignore the
return value of rv_register_reactor() and always return 0.  If the
registration fails (e.g. a duplicate reactor name), the init functions
silently report success even though the reactor was not registered.

Propagate the error from rv_register_reactor() so a failed registration
is reported instead of being silently ignored.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/reactor_panic.c  | 3 +--
 kernel/trace/rv/reactor_printk.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_panic.c
index 76537b8a4343..db7116ceafff 100644
--- a/kernel/trace/rv/reactor_panic.c
+++ b/kernel/trace/rv/reactor_panic.c
@@ -26,8 +26,7 @@ static struct rv_reactor rv_panic = {
 
 static int __init register_react_panic(void)
 {
-	rv_register_reactor(&rv_panic);
-	return 0;
+	return rv_register_reactor(&rv_panic);
 }
 
 static void __exit unregister_react_panic(void)
diff --git a/kernel/trace/rv/reactor_printk.c b/kernel/trace/rv/reactor_printk.c
index 48c934e315b3..002a10f6aa7b 100644
--- a/kernel/trace/rv/reactor_printk.c
+++ b/kernel/trace/rv/reactor_printk.c
@@ -25,8 +25,7 @@ static struct rv_reactor rv_printk = {
 
 static int __init register_react_printk(void)
 {
-	rv_register_reactor(&rv_printk);
-	return 0;
+	return rv_register_reactor(&rv_printk);
 }
 
 static void __exit unregister_react_printk(void)
-- 
2.25.1

