Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353F430793
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612849; cv=none; b=Oa+HiUnxZAuRcNFCqBOP0G4ZqECYZ+c5yqgS/Zx6r4umpNivSwMRR7UUP1z2dQkx4ho63d93xjMvAbab4sbP9J96Py+wfvuIYunPKJmeVd7XS0BsNQRaXKHoM8E6IkLyoKwfjk1LeL7pwTa2nXHXjXgDdnGNcsxHUCjjpnPqc18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612849; c=relaxed/simple;
	bh=jdoTWZOvq1yVtF1uSVFl+vDjF8mXL7677VsdIYeRVkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e7GCGhW7rLOmfEgwSL7ECynKShzKSPjnrrrvRsiAYo/9AwEtSh4W5a1AiL0EuK5K+nOyvjtSln9t32k3sIXyIwrGAhS2ga7FFMpnOOUTqRE/7S/obs8on3lEpGx8a3v8oc8ouAhEC3ZTYfQGZC3XEftcJ8DAFUkhSjKuQZO9Ef4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/knK1Vv; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/knK1Vv"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-493ce4b7777so14860385e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jul 2026 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783612847; x=1784217647; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rXrlbDb1W0LMn5jsqHyz0yKKuiZPXY5VJCQYOGVxTTM=;
        b=E/knK1VvlUrZqQwso7fQYOXdMQaSR2+KBgl63pRvOraQhi8/7x1vIMpqSr3FTSlsIr
         nBUdTBf6MslxJxszwiaxdXQfdXqTuvmg9BHt04JJcCtyILnoXKReBMRTU4gHbxe54Lk3
         VSebySp0t5ZyqwWCBWEAWC1dtnTbMy0+AZ5L6KKdlNxUZcuEltQ175mhEw/+f9w8I5bx
         Ibbspc9xF6AT0YGRKpjBld3Kzc8+1Yjqbqgj9Bwya7DtxGVjImFghGTZZbs4VaApiQm4
         TmknCUe5ExT/7B7p0SKp7KE55OoR6+UrJkGXzYCE6LjDqe8GMiV5CG0K6vmBD25sOJoo
         6dYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612847; x=1784217647;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rXrlbDb1W0LMn5jsqHyz0yKKuiZPXY5VJCQYOGVxTTM=;
        b=QKM3Ib4Ira3Kgjz4U3XeXCXo/rYuxTSd+0iePyTeWC3+s09RyGp2zxMILrw6ifzKU6
         H1kh9HyRJ10rpnq8g/cVpzJFdDVJc7TiRtLZ+a3II0mwfYDKUpTZlOSoPQhd1qwVdUJu
         /4xsYUSLNp2bI+ewsG29Fj4K93FFFz0XrygUc102NVUTFKIV5SjTOVfsFF3JUmiWnphQ
         jKSihrtdLboSkPiSAQ+StDSMU+FMc56Xd3rZvvfbNN5esLHkQF9wDTU5NFgtMGbRGIsS
         tlxyTBLzFyJFSSmKG5yhB57XI+TMFfY+xj/FWddBhX9Q+H5EpHDM+6nDN0WVT84iVR9w
         4+XQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKvboaQzfAMsumIySiOX/NC/N24WrRcOiGirpRGcFf6ez2ddY/qfDsQ/rEYPbpGb3cYDw62AaiNfrItya5bELEEJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4gJM/Jz6oUF0YBd8Eqcl7HdWkQhXKD4qsraABPksR/A8nnhFH
	/sNllD8wvJz+YJzY6LpInqsLR7NZQErFFS37uBlPMPyVlV/7fhk0/FTU8TtfdVJDxFnZQ2WQPMC
	ev0xx80QGtAJ+UqyRWET2Fg==
X-Received: from wmbjq16.prod.google.com ([2002:a05:600c:55d0:b0:493:d43c:ae47])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:8496:10b0:490:b2c9:e284 with SMTP id 5b1f17b1804b1-493e689afc1mr58351385e9.30.1783612846698;
 Thu, 09 Jul 2026 09:00:46 -0700 (PDT)
Date: Thu,  9 Jul 2026 17:00:17 +0100
In-Reply-To: <20260709160017.1729517-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709160017.1729517-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709160017.1729517-4-vdonnefort@google.com>
Subject: [PATCH v2 3/3] ring-buffer: Allow sparse CPU masks in ring_buffer_desc()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

No user currently relies on sparse CPU masks, but the descriptor logic already
supports them via linear fallback. Remove the arbitrary limitation.

Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 56a328e94395..4e7b4ce7b8a7 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2329,10 +2329,7 @@ static struct ring_buffer_desc *ring_buffer_desc(struct trace_buffer_desc *trace
 	size_t len;
 	int i;
 
-	if (!trace_desc)
-		return NULL;
-
-	if (cpu >= trace_desc->nr_cpus)
+	if (!trace_desc || !trace_desc->nr_cpus)
 		return NULL;
 
 	end = (struct ring_buffer_desc *)((void *)trace_desc + trace_desc->struct_len);
-- 
2.55.0.795.g602f6c329a-goog

