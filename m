Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E9839020C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551232; cv=none; b=q/nMLrPU/2rQH4Lvt2oUZZZ1ERdCj9ekqZKqQVv8rHEAO9TlFNySX7oR6elKSjxAOs3SPQS0YGwSEavGNOfmLDrgjbX2zZrxTYzPWHLkXOrTsuugR+VQs5uoUeS0dpgWiHJf9g6Zw8aV4L1vHtVvBiBBeymRHjrwR5/5Gs0czMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551232; c=relaxed/simple;
	bh=Q0mzPvGBLhiOAgqhvTncmXs99vsutcsJKhcc+yzBV/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aAY1R6bAWXXkiwCnTTQxB6Tkt9D5SrCK5deg50bofP9CM0k0PDMYeDHnSJBHGUd3QaVoUgbKmu2+McPxS+WX5mDVD8aJg2bqoj0mkgBY8R8XhYJRpCplfYX66/EtOvnk8ArZ38AY+sy5KR1TedhNpCeyBG/QzfjiQDNxKoLDmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XKyusDFQ; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XKyusDFQ"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4994aebe932so12690895e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786551228; x=1787156028; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9cUo1ghw442/JzmiS4QlBSalW0kaijGQL1xFuRWTKA=;
        b=XKyusDFQpszIzjGLvMk2dbS2N/teC6TffGma5aP5NBO1krKc91jUK34R+4PuXTc9+/
         Tmf6ZMN+37fx+zpC4WcyfJ7j3SXD4snZlEEIdKIG8FtmxRFpzBStMMJy3tEvm7s0UTmc
         6PZnQQUXPHf0Jzc6AYRp7dWdWdXwcXTxZ5eILDbX9G6iR9Wtjg1DXRxwNtl443COvhcz
         3N7XRizdXY98lgJ9AkUHzjYXcGhBbh3oEs/Fy7wfO5zDaH5dty3At0nDRph3XY4zmUxS
         JKVzM/1GhD8VPRXbm2p0M0HKW1sz8t8FEiM04YqEzPWCBvePiaOJc/gR7vRK3vGdh2Lh
         QMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551228; x=1787156028;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f9cUo1ghw442/JzmiS4QlBSalW0kaijGQL1xFuRWTKA=;
        b=nYDVhgCYRE5wSjdADTDEpE9DMaVTSvM8hO5lqMUhfOySYrDxPEZhh1c69dz8SNSU+d
         UE8mJ7rO52Qtr0TKvhNYOBnltcdt+PHSICWwIpFGIQdppbb8Xaizk094eZSxtvJWqJyL
         W4gYrL1cgJVb9Dl0bjQXPxiE6I+v5LcQmEOiyzoz5kzq/94BkRdfcG2J633bHvBU9YRE
         DCjVLED71AXXnP1FtAJ5t4ThEns4Ylt2THP5rd5UE8ukiF+0d/mx9FQAvYXTF5hOBzkt
         q+rRRkBomOvKEqZFxtfa3EkyaagBa9CuBT3A1Ke31p85Nm3pIEbq5HdYRx/4d1kOuc6D
         ysUg==
X-Forwarded-Encrypted: i=1; AHgh+RrjBtDmi0RY3LbLAY4vhxGm8TYgPmCiCFu+BNlvYgivFzEXJYH7u90yvG0gho43TotcfMtYf1imN8zlLvOIpmgRJwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTHSMKtSQaRYcgSsASNQginsgM/p6gVCpv/6qD3p52TcZbuv+G
	Ls90FImHrPVDdDfP1TmSozOlAMUqbOKZHP0Kg2LzgutSGR7+EsSUHZUSas8m1fLnXLH1rxkhIN3
	B4brcgK3yxFyeQWRFyitJpQ==
X-Received: from wmpo38.prod.google.com ([2002:a05:600c:33a6:b0:495:6814:f17c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:468e:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-4997c127e00mr77601965e9.13.1786551227902;
 Wed, 12 Aug 2026 09:13:47 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:13:25 +0100
In-Reply-To: <20260812161340.2417322-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812161340.2417322-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812161340.2417322-4-vdonnefort@google.com>
Subject: [PATCH v5 03/18] tracing/remotes: Use kstrtobool for boolean tracefs files
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Use kstrtobool in trace_remote.c where possible. This is more user-friendly
as it allows a better variety of input strings.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 0384277070b9..0e4d41a93a7c 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -235,10 +235,10 @@ tracing_on_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t
 {
 	struct seq_file *seq = filp->private_data;
 	struct trace_remote *remote = seq->private;
-	unsigned long val;
+	bool val;
 	int ret;
 
-	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	ret = kstrtobool_from_user(ubuf, cnt, &val);
 	if (ret)
 		return ret;
 
@@ -1147,10 +1147,10 @@ static ssize_t remote_event_enable_write(struct file *filp, const char __user *u
 	struct seq_file *seq = filp->private_data;
 	struct remote_event *evt = seq->private;
 	struct trace_remote *remote = evt->remote;
-	u8 enable;
+	bool enable;
 	int ret;
 
-	ret = kstrtou8_from_user(ubuf, count, 10, &enable);
+	ret = kstrtobool_from_user(ubuf, count, &enable);
 	if (ret)
 		return ret;
 
@@ -1231,10 +1231,10 @@ static ssize_t remote_events_dir_enable_write(struct file *filp, const char __us
 					      size_t count, loff_t *ppos)
 {
 	struct trace_remote *remote = file_inode(filp)->i_private;
+	bool enable;
 	int i, ret;
-	u8 enable;
 
-	ret = kstrtou8_from_user(ubuf, count, 10, &enable);
+	ret = kstrtobool_from_user(ubuf, count, &enable);
 	if (ret)
 		return ret;
 
-- 
2.55.0.691.gc56d675ccc-goog

