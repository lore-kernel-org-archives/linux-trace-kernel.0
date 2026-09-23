Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF79E45629C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149351; cv=none; b=HuVhhoE/5SXQ5jWKmOdIRjLPeNQaFIFVHEZxajvIuKtpjpj70XgL/pVmoS1UbG89RItvxhNWw8CovE4OBm/dup507LRMGkUhF9qRC3SkkbAP15SJspS4IaTleFXBhYzvRgKJkLWw7fFL+zKHPKk6dV0h45FvKMc+IgdNrGNCxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149351; c=relaxed/simple;
	bh=WpFODar40DMohqmlS0gOpdR8Hzf1EpMWE9H8MvsGOhs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pkueGM9zs+DX4r1M618IUTlYWwCz4duJ1qhR8fbiMxhguLS6gMIQwQ/3QjcNHD74YwO6OYeP4j+Of7KTSyXgzqD9y3kxXJKVPT9W/3NBkHl16+w3eqIoF9QLgP0vbWx8ZUtPEIafE5BH52uToDqb7QYaGF6cys0hYjMh9tooc4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LfLJHi4v; arc=none smtp.client-ip=209.85.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LfLJHi4v"
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a6735afb87so655764a12.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 00:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790149344; x=1790754144; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n01qPftWqsYu6YQIAam2h/k+qUdj2gjru4thEeyqswQ=;
        b=LfLJHi4v/vg4GET/xI2vEU0L5HUco4Z+onXkxuga0NH3Y/8xgkpaZ4a5lE2Wndq01X
         FIMmjLgjFL4GONWhJnVPvmjuBMltECb/qpprbWzTiQ0UAxRgBEE+2Z7dQyC8WpkuNjPc
         Y4MWOFQWCj1jDDYeB2o/uvPQUYoYtgxvBfsh6+TwM2DIedhG3sWkApDfkbbRIjGnWPZ7
         3Q4H9mgBJvPKLlj1gv0Re/3H8CecO/4JH+CbzQeVxXkPdlrUzH7mSspHjxhRKe9GNOwt
         pB2HhcxPraMW8JxObz617IPPqb4KOJn5pk15NnfNYgv1r7v1prsIlGz7MDNVDpSsfNna
         bMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790149344; x=1790754144;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n01qPftWqsYu6YQIAam2h/k+qUdj2gjru4thEeyqswQ=;
        b=dLh//ad5TPX/v2hzlJVDukXcSuubOp3b80DnzHuUTYoT8a3UqYqAlXwz6wlP+n6Z1R
         k7JcQBUb0NGjFER29yE7PH26dsRUDeDhMUQzoIpE/qpZfurKBiCELDmYA3RNINQZ9SF+
         RatesORei4UNsXAoh4UmOyHdzMXMLk0D10MbDBO96exnfjjmOLEEXoeDDFOXd3ctbbq+
         Ms0LiRHMeK9LYaWIQ2+YSEzy6Bic0KUja2QvOnvffPaVrvX/sNRoaybzadzQK3HC7pA/
         C8MRdceOMFOHVLBwS/pocQInnwx3cQ8TeJqesWx+USIeVdtpSmdMKwoz1ECKKigquVZJ
         XnHg==
X-Forwarded-Encrypted: i=1; AKwUvBy10MQL4auOqo0Kol6FTvZY/Ov86katqYpZitTvsw96lwuH3w8RPgO0N1+MV4G8NnpWLtaFObRjJjE1xvl8AogV0+c=@vger.kernel.org
X-Gm-Message-State: AFuF++lzLRCbfpfcnMJguRmYX1dNRMOkSAO7u/8nV1IlGNVvMNCofynn
	U8ItAFmpo/+8PEKQqNFItiZTmgGNpkUH3a5yyioHHfguLz1LTIWEsxYeVfFundpR7XicmyD9yQn
	BF8e50jncsjc5BvZqz0cKMQ==
X-Received: from edbbm14.prod.google.com ([2002:a05:6402:b0e:b0:6a7:e8d7:a57b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5d6:b0:6aa:9274:b555 with SMTP id 4fb4d7f45d1cf-6aab3b66e94mr1403176a12.31.1790149344211;
 Wed, 23 Sep 2026 00:42:24 -0700 (PDT)
Date: Wed, 23 Sep 2026 08:42:12 +0100
In-Reply-To: <20260923074213.3077182-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923074213.3077182-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923074213.3077182-3-vdonnefort@google.com>
Subject: [PATCH 2/3] tracing: Fix simple_ring_buffer undef check on parisc
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"

simple_ring_buffer uses local_set() and cmpxchg() on unsigned long. Add
them to undefsyms_base.c to extend the allowlist for the parisc
architecture.

Fixes: 1211907ac0b5 ("tracing: Generate undef symbols allowlist for simple_ring_buffer")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/5574c9e6-9ed2-4ee6-a2b2-fb6ee81e83a1@roeck-us.net/
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/undefsyms_base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/undefsyms_base.c b/kernel/trace/undefsyms_base.c
index e65baf58e6ff..37310baf706b 100644
--- a/kernel/trace/undefsyms_base.c
+++ b/kernel/trace/undefsyms_base.c
@@ -9,6 +9,7 @@
 
 #include <linux/atomic.h>
 #include <linux/string.h>
+#include <asm/local.h>
 #include <asm/page.h>
 
 void undefsyms_base(void *p, int n);
@@ -18,11 +19,13 @@ static char page[PAGE_SIZE] __aligned(PAGE_SIZE);
 void undefsyms_base(void *p, int n)
 {
 	char buffer[256] = { 0 };
-
 	u32 u = 0;
+
 	memset((char * volatile)page, 8, PAGE_SIZE);
 	memset((char * volatile)buffer, 8, sizeof(buffer));
 	memcpy((void * volatile)p, buffer, sizeof(buffer));
 	cmpxchg((u32 * volatile)&u, 0, 8);
+	cmpxchg((unsigned long *)p, 0, 8);
+	local_set((local_t *)p, 8);
 	WARN_ON(n == 0xdeadbeef);
 }
-- 
2.55.0.1082.g2b9226bbc0-goog

