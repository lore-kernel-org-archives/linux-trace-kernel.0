Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A1E3D4133
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974927; cv=none; b=FTWeN5lMTKP386ccRj/qWg/mnkNVQ+gf3TTn4epR/Rh5qM3IWd/pvQ5/NbNcJ0+NnRa39KJSwUnNzSDh36zCX9FXPcrVfc4JJFd/m1JQ79EJf4uQYpIXfwMQyfaIao1dtt31zpG1ZsE04F5JwIv4FCCyFf4hVuY18R9vK1Cm/t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974927; c=relaxed/simple;
	bh=Q0mzPvGBLhiOAgqhvTncmXs99vsutcsJKhcc+yzBV/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rvCujAsiOqMTwdknK7QVi2jqdv5hFpc8X5oCsH8x1qKrmtWckC6+J6ACrZdzxGw5wSzwnSt4iNyCgFJBWZefgNtS7ESujOPLcmum7ZM/1WYjtdvcIMyKCiMqPwzDK2Bact8iHEOQosUQfTWnCD9l23c2WlHoje8hb2NI6Xm/zlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dDiN4kq1; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDiN4kq1"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4954c2d4081so30186225e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974923; x=1787579723; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9cUo1ghw442/JzmiS4QlBSalW0kaijGQL1xFuRWTKA=;
        b=dDiN4kq1CdIusLF6jzVlVFBIH5wBBoewB9sFYPKnWFWYY0HgTyGtXbvTfyhav4mk2X
         hFYwusX+bgTvTNRkX6eCpFQ+KWKpXY4Ih+GfaqBBqsTc5r6phU8AlMstWKJiUARQbKYZ
         kCg8IuYCLxgBXWhspUhCb6IAXXB3mLUKvFQG/b0Tb7co9hhGgeQh0Vsny09R+rAi/vBb
         koYu5FnhsuCnF3+ZvxratG2F1tm8U+F+jA+y+JHh+YB9BtSF83Om7+fJuILZB/R9/iq4
         uPhom95QVG+MMrCVq3tAmeRXvoeSg6f7mGN0BZFwZWuh0eXwF8HrJB7lDV1SbQq73VE9
         h/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974923; x=1787579723;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f9cUo1ghw442/JzmiS4QlBSalW0kaijGQL1xFuRWTKA=;
        b=AEyh1wFYItLbf3QW7H5Vm1P+2ZQq//Il5qeULijGlRumCFOsXpAj0DfRrP58z3fWeA
         hHBOWn2hp2NQnD4r8IzfMXD8W1Z6KdQviMxsJ6FAO7HHIYaAcYxTosqYqxCIn6F/SiF1
         /9i9YsdY5VLQKzl0J56jGdHsczpsu2W7GZLzJqFBApSBHi3nIopm/1Jws8n4XLhFcCj4
         RO8jJJy5esjmp5+4B6coYdJPj9b4fOeeOk7cMUp5Exg1PHKlC24zRCck6EsPWTGHA9q4
         ZulXBb/Hx23jx9qyXMAd2HRGzqktdPdMYsWfdhlRBF9oQZRzspD64Wvab4hLS3kup6l4
         BwFg==
X-Forwarded-Encrypted: i=1; AHgh+RpJe+D17jDP9ArVlyVYOUvzRhXzyNdT8JBVnD6aXZHsgHvKm5xUsBFcNtN3MlGb8dO95GXELDcUyyajcm7/X+VwvuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvR9kr6plaDerWGEUYwiJ/q4MWv6yBZziJgelQvz1WQSCXDRrL
	r8UeFyb76gTtAzr1f7EnNZFlXgUncmk7XgKu88hGkvdCc42Legm5hmFGgqeVn86Xmb9Ky4XE8KI
	THKX4ZkgcndOScBbhv6R/Pw==
X-Received: from wmti12.prod.google.com ([2002:a05:600c:8b8c:b0:495:5762:2123])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6088:b0:499:7219:122f with SMTP id 5b1f17b1804b1-4998792adf6mr459702175e9.4.1786974922439;
 Mon, 17 Aug 2026 06:55:22 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:55:02 +0100
In-Reply-To: <20260817135517.3919534-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817135517.3919534-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817135517.3919534-4-vdonnefort@google.com>
Subject: [PATCH v6 03/18] tracing/remotes: Use kstrtobool for boolean tracefs files
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

