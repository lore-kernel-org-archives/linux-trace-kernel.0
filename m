Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3273F23D7
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420324; cv=none; b=QjR2mFj4j1SIrd3KH/cy/gMCpTEhDqgPhIUJwsmF1f33p6fQef70li2VUV+8jN2H7hRDv15t3YDzzqYoMMieAyN3mdNh/50ISrmjvH88mPdTf98OS/YE/ENg9BDQB/eYU2zohJLbVXDCeyy4KJL01ixDmzdxd20vjPjgvWTH8DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420324; c=relaxed/simple;
	bh=uVHQi1l13+JySgqev6l7FJOaQ8ca5vVrXnGUJgx3a7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rp2nm/3OHVefzP4K0J7Y+rCtFQxDQjZ/RaYNcSGY7JEAQ8T3pRJNtTJUrm+mUAc32/6gDl3tQ3858XCOM7l20z1bfGlugRzHMN2JW/U8CTQgTUKRLFjj/YxSFkDA5+Ia6MgKqIID26xxPrEPkrNiTQFO6l6c7zf/aVs8IJZ3Nrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EzxzX7gI; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzxzX7gI"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490ae4d89e2so16559835e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420321; x=1781025121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ifltEC0E/QNCgnwkqwsV3wAeXJ1J6rBtSMF/jkE9/e4=;
        b=EzxzX7gIk00LjKOqpiQgXQMphZjFlvd/5RlWUzCzSaUGw5JlrRsj95SHp32y/2w0cL
         YIa+qUP1rm4JLJpVR0wT+k0WintOTwm82v/Iknmqv437lxoBnMy8nxXAkVI2H8ROIhUu
         YO4CdjUdfweZWDg5nyIEmu2tHR2+ON9Dsn0oHHsqGixa7KNK0bo3KLVBjtLofv22kCbK
         IM/4IwuWm2Re70nNmyslLZ09DjD+qgcf1akDWh2w6Jycq05uD/1iCRKTdQrQCSHCG2MK
         Bkq4DaGbj6VZiuCkIpwiu0zAkW/F+N7oc69POUy3dK/JcQ+mOtQXsTjPsBntkj1Wf5uE
         TGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420321; x=1781025121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifltEC0E/QNCgnwkqwsV3wAeXJ1J6rBtSMF/jkE9/e4=;
        b=dbjxvp0K+zWl/WelihgtCShpRZspgx8rKNBJjhZepQrdT8t9ylI+52blabseU1Dfk2
         XsYie9H89OcYAoa+3TdV4CjqA8aQmJA65yaSwkD9UjukoG6hhaI3CdVhehnq+a5xh+Is
         elqf+WzI+un1RN9xWe9JjsLhW/AWJi1PMOiSFtaK857osGFTh5R71eHmFLoz1Dc/Tgn8
         EgDiaiDubS9Db17+M3gGGSqfFyWNXbXUaIvm8Knf2DzoRJ0KALudQgS7t10pRw0QK+JM
         PLAGTifqOf4339FV55nz6E1qLULl6OjvjjJhL/FAkwl2GcqaKe58yJKFq7wvZP03qTPi
         0B0w==
X-Forwarded-Encrypted: i=1; AFNElJ++Tf/alM+SoEQGNBDNnMY/S7ufukMN+MiF0aWBlHlCEM8ydKmRCXRf/dRPmqHHpTRgPXooOoQVwyhmyJV2nJcuycc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdI0kuKVE/lSuOE6r0OszsrpNwFYVYohNLo4nXnRdM5N8/ZMxG
	6Nzw5t6KX0CEbCq4EiSrMid0I4pxw4v/CZVSUNPWKQIMglDNHqyO0RsN44nqnU5vsWYc451G3DV
	L3KKjwBmUtBg2Ze6a7qjLhQ==
X-Received: from wmbgz11.prod.google.com ([2002:a05:600c:888b:b0:490:b475:af0b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5292:b0:490:b0e1:2161 with SMTP id 5b1f17b1804b1-490b50405b2mr10948835e9.2.1780420321421;
 Tue, 02 Jun 2026 10:12:01 -0700 (PDT)
Date: Tue,  2 Jun 2026 18:11:34 +0100
In-Reply-To: <20260602171146.2238998-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602171146.2238998-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260602171146.2238998-3-vdonnefort@google.com>
Subject: [PATCH 02/13] tracing/remotes: Use kstrtobool for boolean tracefs files
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Use kstrtobool in trace_remote.c where possible. This is more user-friendly
as it allows a better variety of input strings.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index cfe84e9b8fe6..7fed18f28fa7 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -176,10 +176,10 @@ tracing_on_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t
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
 
@@ -1090,10 +1090,10 @@ static ssize_t remote_event_enable_write(struct file *filp, const char __user *u
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
 
@@ -1174,10 +1174,10 @@ static ssize_t remote_events_dir_enable_write(struct file *filp, const char __us
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
2.54.0.1032.g2f8565e1d1-goog

