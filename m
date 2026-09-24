Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E83C1985
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261914; cv=none; b=K3Y94B1wy2W5WBONsXX+4C/6/+MMlTzBDLhhomKBzPAAZf1FXEY1SbPDj1QqQp+zHur1vVSMzf8sw8kOk+k4BOnfNsNApP1Kve6/T/DQ+dQjSNsZ95Uyc9zm639DSOf+82Nin6cehCdHr9RmWJsFhP/eIyiyRAdSm7HDQRiLMvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261914; c=relaxed/simple;
	bh=e2G7J84G1D4XCfSLdP3gUfTkL5hqpo1OoPHtnVanTCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HBbM3fyBZfhxJTozBzXpTloWOrFTj1E3oSZUxu0lzOb/8zlFKYYeVJUogFTAu7No5Yb7mCDX4TEBwRthvoujNYqqIahnk2S1spJ8J0wclHiwDM0S4s3Ka4LvBsatvz2MQG7QFKaXYTj8Nhj+MnUlrsDP0RfO3LCKD5Q+Py3Xq4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLvkzAZN; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLvkzAZN"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4957287363bso14589585e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261907; x=1790866707; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vM356NruxwMMdbIb0iHJaJTYDI/MzfDme3zT783DwBE=;
        b=pLvkzAZNyoUzqoZCbRSt6bQnN0UniSb5igWj26j2J7itpiDfUD53ny6tTZ0UT8cxyM
         TJtnNtzW0mNJwuok9QmIBYa4iDrufqmb1a+zqK8NuLt71mRIqoUd5UiDbUyFLZ6hRZoH
         nY9hyCCwiOZ+OITR0f2O70Anr2zi2Nga7hoEH0YpYHyqoKues5aBq1Mjx0zsRvIo/bBE
         hbGRo3WJ3J+GabriMM9f9MgFKmsqmK1hN+H3mXC2EI+7H1ziUBlbyDuJO/f5cjBS3V1G
         F8937akE4qBfzJb9QZrXf/vGRVrz+xwlIJq11/0if4kdPMfj+kNkewSDSAorCIpzHkVz
         wFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261907; x=1790866707;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vM356NruxwMMdbIb0iHJaJTYDI/MzfDme3zT783DwBE=;
        b=zahWRXzi3/aaGdVSf8RQ/VDaoSLEPMoRrAXi8JzmX+K0Ajditx2inxTxY15L9KHL1y
         Bit+HCW1Jksi7eRlNJKwnjn2Kc4Qag6PEafNxc7/4G0qvMpC1fAIjYclxg1Hx42Dj6O/
         682Vmy/qDS3BIpMwEQdA7gwgNRl6Wrp8c6Bjhk3PfjPEVjMQhLP9IZJ0ON0X8JCfzqnJ
         JV2jHv3l136LdsGES8a8ludAeaStNQ7SygE2yG4CAcyUMTLqYfN3M/8c+7RZc0UHPbEx
         Wm6cx8mRigyolUr20l+lb9+/uXVyFeOyFrBOitZzgJKRqXZJMvOC4oNVVX60YRJVa7qv
         TmEw==
X-Forwarded-Encrypted: i=1; AKwUvBxN7R1BLfvaBzRY0kw9rtA3njUt/cvt42lAEsc5uR7eyrTiExhVZlIbxt5kdfX/bOTnq6IZ83raYhGw0Lii8Ywz4gE=@vger.kernel.org
X-Gm-Message-State: AFuF++nnYN1snd7JYnHbYKudrwq4XyjviVFmyHD19p3/v89kzQfAgFqK
	lazIpn+hME7kAE6eaOxnYCu7LyqU7hemV8zhh/et/h+/0B4IDUQiM22TeDgGogre9suJehy99ME
	kOAhX2A9dx9h87MStzb5gFw==
X-Received: from wrbda3.prod.google.com ([2002:a05:6000:1963:b0:488:54c8:2f06])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1546:b0:49c:fa20:cc00 with SMTP id 5b1f17b1804b1-49fe66f4f59mr48865125e9.23.1790261907159;
 Thu, 24 Sep 2026 07:58:27 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:37 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-4-vdonnefort@google.com>
Subject: [PATCH v7 03/20] tracing/remotes: Use kstrtobool for boolean tracefs files
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Use kstrtobool in trace_remote.c where possible. This is more user-friendly
as it allows a better variety of input strings.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace_remote.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index a1b84290be2d..ae22d13308a5 100644
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
 
@@ -1151,10 +1151,10 @@ static ssize_t remote_event_enable_write(struct file *filp, const char __user *u
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
 
@@ -1235,10 +1235,10 @@ static ssize_t remote_events_dir_enable_write(struct file *filp, const char __us
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
2.56.0.rc1.310.g51773c2048-goog

