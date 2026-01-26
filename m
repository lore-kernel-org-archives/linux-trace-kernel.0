Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C59E332EDD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424277; cv=none; b=SZWSmGEaFz+8CmgaScTxL8rerm57SswqK1RSx6Vtk3xo3WokggwwzNlVZhGnX/sTB8awGOiq6EumTGEZCebyF1j/FYk9CQNE61bt5j2sCqvrtKNHf1tzgWPGA+8aqYMnQUyXpWD7PUmx6tUE/JhA5rN/EHQpPgsyzF5pACYAeFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424277; c=relaxed/simple;
	bh=iaQ0yA4R1YMjqmjGhIBLQinGbFMCowT55FHzF+/yiYg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YcJ5IYIBXx+wIJWfDtwMHoZETKfdjpM2GGoKy5PSNCQ6T4M70amHgh2gP9Zy0F0dwRShRxZizCB2j8ke8YRxXtce65F0iqAN9pFIzha8EfpI6BlPGtOFXJCwAtYxqmhJYNffapvK4iLzY+2Td2//TxQZsaM8LR/PDKdNtuL+4uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UucnxJk7; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UucnxJk7"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47d4029340aso56591935e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 02:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424274; x=1770029074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L2udmx+4SJHsFMJWVRdW8n/HMzlAkQIzlTSPPm28eNE=;
        b=UucnxJk755FU+8LGplbEKz+XWGnzY9/4xoZoSkofOG7eQfqQ34+xT+jnBPHk9hMK6S
         Djt3dTPqrZKQOA5EDjxNoyQMVtieu4HJBWh+kHcbQ18DM1EmC3gwAcqbQ3pDqnJ87HA5
         F5kFDpETAieY6nCHHgomkO01dnOz0LCUWgHVA+0YyhJnv7WeZXpPxYSpOgWyTxMG4Hi5
         9jMcabBqAt/JFp2T4k4V/H9RMMs43plbNImtwNe1r2Q3htqH1FwKlAEYEPTrvaXaowDf
         5DpwnYWgHGmpSovri+sjCar7e1/0G0Kf6K3preVq71+ZlqO8nBHh+uj/IZJUxhHvc484
         7U7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424274; x=1770029074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2udmx+4SJHsFMJWVRdW8n/HMzlAkQIzlTSPPm28eNE=;
        b=dLChzzWnfsXfLBMaTthDG5kE89Rb3MEuTrdKYnrtIuRh7HqKd7AMgbF7WVyjR/gv11
         W+vIy+4UVb11DWIK3+qgenQo6ytphcPoQN6l3y4nXaTFT8GTZt693hrfsGInBm2Ux1jq
         FSHJw8B2bhrV2/tsWGGKO+iQOZV1kFzYN7NFTIE1nvSRCV2ebpUEYSBkwDV52/Sgwy1J
         wTJVpywsCGyetHZOxi+8Z4DNAG4l8N/qEp55I32MpVSqRgJA0vzvWtXJkGvZcZVDxrib
         Qp/rIM/dqUwRhZSZjIQnSTmgHa93K3U9xYrgtG5jQXiqEZvi9V2WDBMhcX9AFfXvzgUh
         OFDA==
X-Forwarded-Encrypted: i=1; AJvYcCUzLrP8Ryv5FTBFQize4ZICeKt7HelAzONhxSVSAYfBMa/2ZF8bMRQUbEnpP7ukhhb/RDT7bkE3NPImAJt2q6RtTtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7CZ0l6WKTUTmhuKH4tyVR+wGp9uIXE/QbExzVlvLZ1Ax2vQpz
	eaJv8n4L1iUrunt8VShUB6Ev9MDhetZ+gIypeGOSYH6L1kmyORSOIWPxnK3OOR5Izv6RuCgjRt2
	WcirOs4ejAA4U0UY8bGXWiA==
X-Received: from wmpk39.prod.google.com ([2002:a05:600c:827:b0:480:4a03:7b7b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:500d:b0:477:7f4a:44b0 with SMTP id 5b1f17b1804b1-4805d06c44emr66099755e9.33.1769424273803;
 Mon, 26 Jan 2026 02:44:33 -0800 (PST)
Date: Mon, 26 Jan 2026 10:43:57 +0000
In-Reply-To: <20260126104419.1649811-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126104419.1649811-9-vdonnefort@google.com>
Subject: [PATCH v10 08/30] tracing: Add init callback to trace remotes
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

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/trace_remote.h b/include/linux/trace_remote.h
index 55754ef78104..15a579633123 100644
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
index a744bbf48e88..924e3f3ec6d2 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -837,6 +837,7 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv)
 {
 	struct trace_remote *remote;
+	int ret;
 
 	remote = kzalloc(sizeof(*remote), GFP_KERNEL);
 	if (!remote)
@@ -854,7 +855,11 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
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
2.52.0.457.g6b5491de43-goog

