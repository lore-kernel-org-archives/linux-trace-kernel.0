Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7258128C874
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 04:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781151686; cv=none; b=EUOnmP37bfP39svW4Aw+qhfXLC5R5zHttFjTbsslJXlVFkS3ah+CF4OM+cnKtUYh68HOsuTfSPvuoJCkcEaLOK+aZaZ+FgWCW0q2dJEG509VscN8rksPV8L+WI1fU3ZDWfjvTUfoaJWpqJ7rnLQAcTmBmp9KcCnrFBh55XpALxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781151686; c=relaxed/simple;
	bh=0te+i9a/MoRadeQVR5jKcvhhCawGb36tZuFxB4eHYn8=;
	h=Message-ID:From:Date:Subject:To:Cc; b=QIbUGUQo+g/IVnkYnLKoYd7lCc94E4sPNiLzPpZc9C6HD5rWAdVcclhgZ3lwWiiib/jbhVM9cZniOKVliH1EGzOuVWSLXFwXj8lYQzc/CZcCACKEdaHJ/kXpeoOYcmBnVuF9888ZsAwTaD3wgJ7M/Wou4gZtWwwuPTaY7enzRlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhlD9Lqt; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhlD9Lqt"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so4613966a91.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 21:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781151684; x=1781756484; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM4XTomlMtTxHkUKPHi8ZbL/w0xReDLXjA1BvbxdT/c=;
        b=JhlD9LqthEToTswZu9ijISRi21Q8OE7XH9SbxqQyFqhumGQqM8jGzSHLGA2Om2ykkp
         sRx2XWa20cPE7QeOlwwqB5jdW/8UcjXkrqEUWxTg96IVOdcuj8JL+kQMUMLF23NVWVjS
         u13BxQ+VcsOplTS3sqq2pkn/hPwCKHmGi6OPVp6tn2kUTvtquNgyBYUyRQE0LHBcB+Qu
         Ekej3PRCzD1OICx46Su0MJWxHMBT/vnHfz0RHcRI1iwmXagRYej83HCTcxtUTrvUyjwl
         emLW2m1gxoGCZiTtZ1V1MbIj2FnwAeicwTN1brbjI1AQMLcThZ6da1xy6bEN2mSRFrKf
         IVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781151684; x=1781756484;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yM4XTomlMtTxHkUKPHi8ZbL/w0xReDLXjA1BvbxdT/c=;
        b=PVsq/mj+GwqiAktCsK9klLrKUrnQ+1d7iXzV8rEWjVjOr/B24v3qFe1SLqM38ubgaN
         uZuOYbZrvdQVDn8Kl/0T3Z7YxJN2TQ2Ww7klUqCCrMNMhAUzG1YTENjfY8F+SVWHOenm
         FDcGLkmD8F7YqS6pMTpkKuLm1Yejp4D4vpv+J8W8RDVZN7Vvsp1/NX2VZwzYihnCx1s6
         Iy5Bl8HBMWdFFkYKNCUaOYbxyzYcqTpvE9PaCgLvs71KGQPGBPrX87+S0YwGEU44qlhY
         9+E09R/iuSb1BeOEJfrchJczZRnIgKJCfcZzNSLcnd5Q428W/0ddnxTddtPLFinBPD7g
         8Kpw==
X-Forwarded-Encrypted: i=1; AFNElJ/uD/vWfWyhasJlI5FjadkPMKh3AEe+5r7wk0oFdOTZpW8Xt8qJGtOI2YS1lAHQrbeSlyFEJkHO7FYeuC68+LHiT7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3n7gETuPsi5flY5iL8tNoMdbiYMzMj+KxYF/p0RYI34lA7LjA
	hYeNpPFxYq7ZpnrS7esqJiD/TOpSEjthbFzPpoKvWin3nUjXeJdPsrZKcR+hQI/t
X-Gm-Gg: Acq92OG/CVuPti3nf0zVlkZYlN/D5GXivR1FloopF9bRgcI9/anbJUMI+xEvX3Frb/n
	IcOzpHQempvbJ4pmoPe08TSd4Dj67gDqzpDNrHU8hQ4PSuJ3XoAPswrC80l0VaDEBdn7bounjNn
	y0RWsFjAXo3Uen1dHIOZnffP4kyLmswmWTxn4ckw3tndJVM00w3sOljShfnWenbsrnhq2rPJlF4
	lPeEzlGqREKwcfVtmpKiBImYSk34GnI4rUOQ0wAmvHCyOO0X9DYBUqUDCKKMRg/wXRSv5a+rxww
	6S4UxBbiAjq98nJGTgxFbL+QRW5qLuIn7C5F5JIrI1BGwLmIfaF2YfgYVmyGfvGyyfkiAIdvT1d
	OTiNH3h7T27mPqMkOuQY5gRD3uBkCMTJwe85V/SrY60GX5cu5ey2rfdJq880jUcsnTVrTybEhFb
	Da6uZ5wXi6ot7X6N/p9dlUKVfuQT8=
X-Received: by 2002:a17:90b:4a43:b0:36b:b4a1:2939 with SMTP id 98e67ed59e1d1-377a48cc277mr1494064a91.15.1781151684556;
        Wed, 10 Jun 2026 21:21:24 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a0eb9sm1002903a91.4.2026.06.10.21.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 21:21:24 -0700 (PDT)
Message-ID: <6a2a37c4.f0a9eb5a.2fc603.7724@mx.google.com>
From: "Wayen.Yan" <win847@gmail.com>
Date: Thu, 11 Jun 2026 11:52:57 +0800
Subject: [PATCH] tracing: Remove unused ret assignment in tracing_set_tracer()
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
    mathieu.desnoyers@efficios.com,
    linux-trace-kernel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

In tracing_set_tracer(), the assignment 'ret = 0' following the
__tracing_resize_ring_buffer() error check is a dead store. After
this point, all subsequent code paths either return with a constant
value (-EINVAL, 0, -EBUSY) or reassign ret before reading it
(tracing_arm_snapshot_locked, tracer_init).

Remove the unnecessary assignment.

No functional change.

Signed-off-by: Wayen.Yan <win847@gmail.com>
---
 kernel/trace/trace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6eb4d3097a..58f81b36b7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5018,7 +5018,6 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 						RING_BUFFER_ALL_CPUS);
 		if (ret < 0)
 			return ret;
-		ret = 0;
 	}
 
 	list_for_each_entry(t, &tr->tracers, list) {
-- 
2.51.0

