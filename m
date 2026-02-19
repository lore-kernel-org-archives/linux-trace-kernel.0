Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBFD344030
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513410; cv=none; b=Va7pG/qyWvsGfHBHrBH2CYmOe0UvyQHWTIOr3rjUTNwu37dUXKJ95eSUviuD1biGCBAkMzFtqYQCyrsYm8TFQ59Pf7aI0XAVAVZPIf4bGLGC6s/h0pauJdAm/E0mmWqM1vPnrjg8A3V1W5xQ04mcb+DoAZ8V8JGDdfadxA4+Duk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513410; c=relaxed/simple;
	bh=VoL8dKKWsuO5TLicfoNePNC5MtZdyCZna8S2hZwFS3E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NIbyp7WYmVButgbFRZ+jPLXzVVJ6+tpcoLvsGPgOETQLULOqJqO1Yq/vlNKulw26HuOR4ChGqqgEUlL+dZc6ZLy2RAerMxPGbyLaEorNgm/OxThoiLgj99AAV9ZoJsPwYe4KF5HRT5iiIUIB8z986MDXICv3EPG9qsiuxrLYGo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=itQaAbiD; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="itQaAbiD"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso11132035e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 07:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771513407; x=1772118207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jPS7WRrkBIoNMvCZPX+Css0sPZz9dHMI7aeVzVXuEDI=;
        b=itQaAbiDbrtwo547bt7Di09ykPwwfWQd+yqvljbTVMEBalOoG/znAev6iwp8Tm6rzL
         xkjGPrIw8O22Sk62zDTj+3Ctsobo3Pcu+NuDGQaK6ROTWiklNoGVG+OUSqFvTmETkx9G
         cy3BIoOrrdsmlOxInrCmHhl7pmQzTioDOBnC3ko1X6lRUFGyZjOo9ta3eGujBRbtjahS
         pnwxoLr9DPudRw8fYqj/ylFBnAzs7uCUYcuQzroikGHb8jLGDDmI/0qb43DT4/nnkYsd
         pIwrvnMQ/pxtttPh+bueHodzAO8BG+VnaYkp+l6OFcaJ9VLsCMGDlE4RF8sKeOayjwe/
         sbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771513407; x=1772118207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPS7WRrkBIoNMvCZPX+Css0sPZz9dHMI7aeVzVXuEDI=;
        b=nPZhEUdVFbA7iiRNbt3h8bZKu1KatPxDGm06IHRcKM46gTExYw4naUTUAXK1GiIKnn
         Tg/MazX7RfMjNMK1uFIuHQNyMQ+rb+ceoeumx2yVYTLmbCITonNn1fmLUfmQHS78HfGG
         z2KYjjCJhEWVbNrckgYJCCDHOJm7LZzEy89xRQegV2rj+lHQTGlS7GCyB0RNAPvCkgCY
         SIsBRy+KicFRW2dBXYjm9EGY8nHnnHAmhhangETmBUdvrSQXrfTMtURRuza1XqJjKo3L
         1qmvtvts8yggajtbh17JSmf3G481SxnUTTL+4sBttNeBN8LfUr5XBBzH0BeayH4kiS8A
         /E2g==
X-Forwarded-Encrypted: i=1; AJvYcCWmmqMH7FbaHtDyvB3QYJbjBEhp0nPreTfZw79rD/qnoQv2UvLLKiE2mcL9AfrLGW8UGNGaGYoHhYUVnA2X0RRnQp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBP3xO/+LoXskHLHmmRcBlELBv0bGUGST7Figw3NGcW8KdufwJ
	Ez917dWodrql7nyMyu7IVrp+CJL3O5j02+yzv9YC6l8CffSQIfId1NQyO0jA+0j2C3LzgJTflW+
	KGkz74jtzcSSd83R8Om7RWQ==
X-Received: from wmbdr17.prod.google.com ([2002:a05:600c:6091:b0:480:4a03:7b73])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:154f:b0:483:3384:a873 with SMTP id 5b1f17b1804b1-48379c15d86mr301886815e9.36.1771513406508;
 Thu, 19 Feb 2026 07:03:26 -0800 (PST)
Date: Thu, 19 Feb 2026 15:02:45 +0000
In-Reply-To: <20260219150307.14538-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219150307.14538-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Message-ID: <20260219150307.14538-9-vdonnefort@google.com>
Subject: [PATCH v12 08/30] tracing: Add init callback to trace remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a .init call back so the trace remote callers can add entries to the
tracefs directory.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/trace_remote.h b/include/linux/trace_remote.h
index 10ca03dc192b..090c58b7d92b 100644
--- a/include/linux/trace_remote.h
+++ b/include/linux/trace_remote.h
@@ -3,10 +3,13 @@
 #ifndef _LINUX_TRACE_REMOTE_H
 #define _LINUX_TRACE_REMOTE_H
 
+#include <linux/dcache.h>
 #include <linux/ring_buffer.h>
 
 /**
  * struct trace_remote_callbacks - Callbacks used by Tracefs to control the remote
+ * @init:		Called once the remote has been registered. Allows the
+ *			caller to extend the Tracefs remote directory
  * @load_trace_buffer:  Called before Tracefs accesses the trace buffer for the first
  *			time. Must return a &trace_buffer_desc
  *			(most likely filled with trace_remote_alloc_buffer())
@@ -22,6 +25,7 @@
  *			new reader-page from the @cpu ring-buffer.
  */
 struct trace_remote_callbacks {
+	int	(*init)(struct dentry *d, void *priv);
 	struct trace_buffer_desc *(*load_trace_buffer)(unsigned long size, void *priv);
 	void	(*unload_trace_buffer)(struct trace_buffer_desc *desc, void *priv);
 	int	(*enable_tracing)(bool enable, void *priv);
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 5147ebe3f0bb..4e2f9259c814 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -863,6 +863,7 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv)
 {
 	struct trace_remote *remote;
+	int ret;
 
 	remote = kzalloc(sizeof(*remote), GFP_KERNEL);
 	if (!remote)
@@ -880,7 +881,11 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 		return -ENOMEM;
 	}
 
-	return 0;
+	ret = cbs->init ? cbs->init(remote->dentry, priv) : 0;
+	if (ret)
+		pr_err("Init failed for trace remote '%s' (%d)\n", name, ret);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(trace_remote_register);
 
-- 
2.53.0.335.g19a08e0c02-goog

