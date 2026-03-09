Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E2E3E9592
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073571; cv=none; b=oyXH6QB47ZqGpGf2AmC7HsXanI8UpWoepk63AHpKc39qDZRcnjgYpRYS8jIx0TPNUCxJ2bk6VdkHXC0e3pl2LWF9lA0hVeOiBFmj2zsNefmz3vk6n3e17gLPNPmmhKd1s8yPsWXWnYKHxrLClgs8edP+LS9qkDqnM5CagGVa9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073571; c=relaxed/simple;
	bh=nCoqfYLkFALSGqFmK5+OUBL2T+SjXlSRskeq0sqM6lo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BzpsUK5sLT3S4R3U4nIlUstndKDEPQwz1zi+O+t1RSr4pMkmnxNhLJt2HRRiASooir+RjBWP2YPSV2QPrdkIeVWDO/D6VeHTsV0uUYsD+hlQggbc+H9bzpXrarrP6hNB/mAHCJiPjkPOIpJ7lfcTMzPZBLsinFLYVjXR0UMaOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/d3hPqq; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/d3hPqq"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-660af6ded1cso8890152a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Mar 2026 09:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773073568; x=1773678368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/el005jPydhTNUS1hr5dgVCq32s5flSC0Li9+BCYSpc=;
        b=B/d3hPqqesDTDde344RwpKWuzM3jOIJIXMK3NE7mtahN9wc5acI/BnQrnnmZBuASsP
         /i0lVpgqF37ha0u/rESqVByAixDzHwuWLfLWz2h5h8fUsOLKdL0iNF5ZUPuzX+QjaVPZ
         Tuiz/w8v5zHFeoAdbqrJ4UX1eW2om8pNeRoJQaiyjMzkDOdb68w7z17zUkJGPlcCRPi2
         3k46hUX/eoG3rra9sf+8hOVIsREKGzsBTYh533OgglOij+P8fUIh75HxOFeSdad07rL1
         Rk2hgr/VJDDRYctGFfzVk+9tbF58DjzrNC93PFQvGPkRh6Eje+JHa4X7+gDy0kXRy7Ck
         ypHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073568; x=1773678368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/el005jPydhTNUS1hr5dgVCq32s5flSC0Li9+BCYSpc=;
        b=XEnOnL9MNG9xywm7nthO5ayi1fO1R2zsnHSuTZjjDC7vggCYNRs/VnlPTE18b0mo4y
         uFzjtPqwg44FlUazgj1Zw0PauidXpe+zjnADeUAq81MoAi8o7lnhYzLLN3FpVrQbMGG/
         7Y7529Uwbu+6DgLQrIq8bC626eRdb+Q1QoEM6nQD4zYPdi/9BTOfBUcFqZTK/30hgC5h
         J7005RrNYYns2eLGSN4lqxQG154rBLM433miW5NmZMGpJ39gPOjL0wvvm39U8psC8gsO
         xHtzx8tLMyj1hxHUoTXsEAcmjkHsjx4e9rYEQ97/2Sl1ZwXrOvz0bnNF5QwbUY3eYQDS
         lnIw==
X-Forwarded-Encrypted: i=1; AJvYcCUXhf6rfuU2GyE4BBjMbSGqrztD3kzWaHcDUHA99aYvGQRvKK8Gw864A5SSziNDoBdiDPvC9VGdSiphTp8Z+UTGL58=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxzZVCseu96cygpf26BqAUgSbxGrAukBNV71EXUmGEbXJcwbSq
	9T4seKq/zKbSdqehAgxMnqtGbWYwiEA6/ZbfmfenouXXqGBgo+whfuP6lqTsKTaub/vr/QIPTcz
	GmARLquvZBvEiWpB0T2txjA==
X-Received: from ejzd4.prod.google.com ([2002:a17:906:c204:b0:b93:57d1:f5fe])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c13:b0:b96:ef71:49f1 with SMTP id a640c23a62f3a-b96ef715938mr293231166b.15.1773073568096;
 Mon, 09 Mar 2026 09:26:08 -0700 (PDT)
Date: Mon,  9 Mar 2026 16:24:54 +0000
In-Reply-To: <20260309162516.2623589-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309162516.2623589-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309162516.2623589-9-vdonnefort@google.com>
Subject: [PATCH v14 08/30] tracing: Add init callback to trace remotes
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
index 039ba71c3b3e..294d051dcef1 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -863,6 +863,7 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv)
 {
 	struct trace_remote *remote;
+	int ret;
 
 	remote = kzalloc_obj(*remote);
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
2.53.0.473.g4a7958ca14-goog

