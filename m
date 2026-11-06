Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988467;
	b=GCpJdk063tLPp/1eFUI20KNW6YPtAWXeD/GR1JyEGdQAF1b7D9PP1YrXh3HvB8hJmXx4
	 PYTI76s6UMVAPNIQUJrZWi8Cw6AOMDkabHblc3fEPTT6VRhw79yTNpf6Mm5Qz7mMX9bq8
	 sQquXsSOzEd2SssJe5Z89aPyEWJ5yOhoWbbq9kM3NujkEb2gSl/GfUoEq6RFt1eQ0UPAp
	 DGiNs+NssCBd9JoxWbT2CjJxzNeCKC9dRz9Wi8nbcC9mAFWPvZNkeTu6xfHrK1QilKycY
	 2u6ZzJ2cOBiHRUyXkrkWElMdPulLI8BqamcFkJ6KDS48J2R/DGUyDaWn7+T2M5n59mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=3YLiYCoYt3MBqofEy/3+iGxK3/1Shjyq4GIjhoK/1n0=;
	b=1tswPIfY5c1p5YhO6JmU3mavLfRkzb4mWp1IYQDHrC9huEXMVuM3SxOtHUAr9u4qMMmz
	 vcK9SLI6PwZSjNEYZdvfWxKGSQsmKyDEEKKs/a93vJfMy/I2VNuenNJNmzDde/Z97PsEv
	 t0arLSS6ENIZoJbQZJ5THeR25CHyODgPqLPdvi7rPLUWtxNOl/Hl1utX7XSL1cAsgoZU5
	 UX8iV/OFX6VM+4JYZ9yGxcp0mRPRqCMdtY0Uu6xD5MMuFMo5uJmdFx2ntPPWjcPZJ7jVR
	 bqT8/MLGf9KalxYJXaDgUK9+jBqt8mAIBAPJ8hVI5rgn13EoNyf+qjdfZsGLj9bGQJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="B3p/YyeG";
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAA5606A329
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EAA5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B3p/YyeG
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-49323e268aeso646729f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988466; x=1794593266; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3YLiYCoYt3MBqofEy/3+iGxK3/1Shjyq4GIjhoK/1n0=;
        b=B3p/YyeGMbALzaHph1+mML6CdYJYKLGM5FBhXRwzBJ0aWf6MuW+sngswVre9kUaoIw
         h8Gv6owzBerbnRGaYzDYK+mQCZ1laniasThEMfZy5n2j9lYZdFMT+6ETemdXP1LSjlUu
         1dKeJaPqUlwQPovpIysgkSIUUSi9Hi8+ceTx57rsIB7sZ+v+Y4adaf8iYRCmqLUGaNS3
         bPdTj3Wpd3v7RUO0B0KWR9BUuIcRtFe4pG134wWxkb89UOST/5/7zP1vMJ/VX9ox/b9P
         /vlHBOpqQkXtytrtgk9pW5aorYBeDCdskI5fbccw7/jbZ5taUGvYzl0S66v+4ag6bjBX
         PcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988466; x=1794593266;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3YLiYCoYt3MBqofEy/3+iGxK3/1Shjyq4GIjhoK/1n0=;
        b=W7PFCWUb+gP3Uiy4xH7NCrc7f8YG+5nVqXPvvcjXPBKtYpOccWMVDakq2c+fzAKLBv
         6mD7taf9APOG+Gdnx8JsNeUdtv/UOQDhxCabWTbvTQyyKdo7qaD6hP+HvYo189t9mcip
         rtnNK3sr4lsxXUs6L1y0nvwnSyr2Ou6zmioSIpGzRXaZ4uO4zz+Qx0y4T7g71PZKwO9g
         xZqhvgxlBCROph6m6wsiHfaARG04WUFS7eXfldBqCCF5RC3Nh4SnVf5QUOWZrDP+IIMZ
         LA11/b/z0sIaDDU5H0oFAhS35lS/TxYqSoi8SkMdTxx+N1mvaIjusheiLlcOLczNFU2T
         6mOw==
X-Forwarded-Encrypted: i=1; AL+hErFDpQIGwNiGc8KxTZmi5vIq69Z4SaO0Kn1mPBIKOdgtvch9Swdrv3gNzM/8f6YyVsTUovEJ0mA06XWs5YFe+RG1N3U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+b3HZ+SIk2XXaETcAvIJJXSfDxrE/+vdNDvSlv5AoDF04ywiSl
	TUYAsPNuTxwXJImq5Z8X2HzfHBjy4TGNlm6FdlqjCbwjhchiYgWJTu7kslwsax0Ivxq1wQAiAz9
	dlYvadNCCRusAo0mCz9Owqw==
X-Received: from wrsq11.prod.google.com ([2002:adf:fecb:0:b0:48d:f8b9:6520])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1acb:b0:48e:6651:5956 with SMTP id ffacd0b85a97d-49112301e21mr12834790f8f.0.1793988465463;
 Fri, 06 Nov 2026 10:07:45 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:39 +0000
In-Reply-To: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106180657.2460376-4-vdonnefort@google.com>
Subject: [PATCH v8 03/21] tracing/remotes: Use kstrtobool for boolean tracefs files
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
index 10091ff9d42a..026f6ec9b07b 100644
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
2.56.0.455.g6c5a503b38-goog

