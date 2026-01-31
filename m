Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A83C354AD7
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866173; cv=none; b=PFEdOetvefpufZVPn4WeZgOO0eGWGQLXEkmFanKVYA32Xg9Nrj4GPzz4HeODJ5Vmt3WqnjrflcGm2lLFt8RAtyfSr/zqCpTHkWJs4W3czJZm1VnYE4ieUGfow1Df7adX2Ch0mAkp6aOtQZXtGNdSzBDYGamK1iGn6HGCP4V8SA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866173; c=relaxed/simple;
	bh=wMqFpMWKBFJX4WNiZXUaDZF9TfQWdfJVHz79lqJGwb0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DbASxoseUOSI3D55gXwfG77s37C/+8xw4ScGp8NXoAotcCfT2I5amBLBeyWxj0xdpWQk4TPihR3oiKXYkSBjrZuPpPsieDLYwZU+ELuRE2QaPCm7AS9MUkNY+DFTHI9IiVxogm2B9NUwdd8MKF5tNtd0DL6Z0cCPLO7g8x2jJjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f62OxHfW; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f62OxHfW"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-658102e94c6so3878909a12.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 05:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769866169; x=1770470969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7EnUsHuSY31rm33Evz3AO9vawTajgwNWCLhwQDTSMr4=;
        b=f62OxHfWW/6jlk0I6bBMIDfPgkcfd1yA33hX5K+cbX8Yjs56EGJCV9JBxU2joHPdBQ
         ERrQsfjj1ovEW7pfHUr89CSPPmksW/zUEEQIkPrV5iQTwpUTBxAtd+llBgB+21kPA/7W
         NBX4l9dObaGLVmYR+p2Dp/VpTAzQWb2HsF7fs/2OeS3YCmXRWAJUNiXkuMnw/wMjTfjS
         AzpzdvQwA+ZM5oe8PYvn6YulJ9UV7YjRRUz9DjfrnNiQNzhy3KJngvg7syUGTP66/gyG
         wjm+sgNBKcfzejjyuuxjhqRIDFF+btXjwglAegAEtEnDbQ8eKx2b2fXoDJr1QwTFQk/J
         FOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769866169; x=1770470969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EnUsHuSY31rm33Evz3AO9vawTajgwNWCLhwQDTSMr4=;
        b=ud6QzWXBNa9VY9dytlxF6TAzfWRHjcDN8q15+KHWrQ312Zya8D0jK0e943u8Kf2onl
         PBKAnh5ga9QedzaQSFSVmcVoXwHf9wgqg6BGSzrG84ea1RXztah7GGhZMsQD3GLrgXva
         DbgqjZmw5swVlhkLrQuwp6RGB1FobrGmjsc7N8WVweduzjSMOYv6lFWN+b9OO6hhLNo5
         vFC6nD2udpFI5DUXrDrmT26cDX2aeDZ9RrjG7mDTdVn63w+v4m+hlj+XtMJ/oja5jNkb
         X1n80rtqHTqf0tRzBATDg7Ycchv3vcMiInk42xF6tF6yJhkBf1MbdijyR/0jJvUECtuU
         V+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCU7kN+riDnbuPJ6nBIeX0GTGTZIIHFXiqt311r/UVoTMM+aX0IFkPGHDd7EblvTrXZHMYgoKgKpWNksiLF+zxwrQ/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNAPQs/D70X/ZXjlY6p5p1O3jjxehRgteK0/MRZ4Sdk+RMPccC
	6iFyQwMrhDDC1J425vSWzgno5ANyUrhWPm+uozW3PFwsVjg6iE1cxvdhgiCOoTpitN0mRnnlWq9
	NFk9PQ66/RfU5uUC3sgPYtA==
X-Received: from edxz19.prod.google.com ([2002:aa7:cf93:0:b0:647:6be6:f4ec])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3587:b0:658:d405:9797 with SMTP id 4fb4d7f45d1cf-658de58b4f5mr3837419a12.16.1769866168670;
 Sat, 31 Jan 2026 05:29:28 -0800 (PST)
Date: Sat, 31 Jan 2026 13:28:26 +0000
In-Reply-To: <20260131132848.254084-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131132848.254084-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131132848.254084-9-vdonnefort@google.com>
Subject: [PATCH v11 08/30] tracing: Add init callback to trace remotes
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
index 7fb5271a8c30..c4df3d98e5dc 100644
--- a/include/linux/trace_remote.h
+++ b/include/linux/trace_remote.h
@@ -3,11 +3,14 @@
 #ifndef _LINUX_TRACE_REMOTE_H
 #define _LINUX_TRACE_REMOTE_H
 
+#include <linux/dcache.h>
 #include <linux/ring_buffer.h>
 
 /**
  * struct trace_remote_callbacks - Callbacks used by Tracefs to control the remote
  *
+ * @init:		Called once the remote has been registered. Allows the
+ *			caller to extend the Tracefs remote directory
  * @load_trace_buffer:  Called before Tracefs accesses the trace buffer for the first
  *			time. Must return a &trace_buffer_desc
  *			(most likely filled with trace_remote_alloc_buffer())
@@ -23,6 +26,7 @@
  *			new reader-page from the @cpu ring-buffer.
  */
 struct trace_remote_callbacks {
+	int	(*init)(struct dentry *d, void *priv);
 	struct trace_buffer_desc *(*load_trace_buffer)(unsigned long size, void *priv);
 	void	(*unload_trace_buffer)(struct trace_buffer_desc *desc, void *priv);
 	int	(*enable_tracing)(bool enable, void *priv);
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index e03fde73aac7..8a7662ff775f 100644
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
2.53.0.rc1.225.gd81095ad13-goog

