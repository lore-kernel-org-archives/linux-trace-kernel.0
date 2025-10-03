Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF823219313
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498750; cv=none; b=Cmn9tXxKI4LQKBatV4UpXSH2GcJrHiGJnk8pLTDvLxyXnT75ExfV4+gEUsUSDrjtwhGXI2BQsez9nDOQaxvXXpvvTcnW0juavf4AEANR+qrufHwuvxU0KZ1Nsb7X5feoNE4uBzQQX6zvi2pANfCCBT6peMaIH+eR3pgK8kP46+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498750; c=relaxed/simple;
	bh=LuttUe5CO5VAn3hELI/7s6eCl7Ml9SPGqKByWNdQ0S8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=giScCpgTyiMEEuRuRiGrrUY4sOnB6sb5gI5nbbO/++kR7FvyhpRLbZzWKH7PKjSUiohTHTAH3Kurt+Oc5Y5Ayw3ouo5icEN0W1R4ZF1tRcT3McetMCFkBGnoIoEcjEjLNuEjJXtj7OKppZA/JlS/oLqR1JgC/gXwSEf1IOjd87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1YYage+7; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1YYage+7"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e38bd6680so9482385e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498745; x=1760103545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fs/M7Fqoy0zdu3rq0sxtnZW6IS3TOjHhsegHTeIPLQM=;
        b=1YYage+71pG6+WfPFQUKbh5EJGtoPch4oVzuP4zljmjVNqw61f33TndpEupmm5oFxh
         g2ObI2QJ1DrDuSwWn1004h8hRwkeOnHS1TYRUmjacjKquvtQuL0JStnUGudxtnQKTRHv
         D1lrHxG/gGcl9tiEv3DupRgfqxi5xfuaj+n8gd96mqx7iHWUcmqi8ftR2ta/jVhcpeek
         6zW7LG/vUAxm6YKRYE1nVPQnFYCJ9oAFUx3pZpMnylYzcBlLidNeUgSpndERWii9Ylem
         0kbvTe9BGa+3GbIkR5NlsgdHILOJHQcgkdoPWGC16buC5GGSggvr2uG0SYlf+pvtKI9G
         dEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498745; x=1760103545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fs/M7Fqoy0zdu3rq0sxtnZW6IS3TOjHhsegHTeIPLQM=;
        b=giow+RkIbjCNWQEcEUu9AriPWSND4DYr8KyaEu2zgyqm17enzySAJGkjhknUZHX9wG
         Ls/xvOofvSuDSmTMwpNWBqyGj1HW9XTvCQBphKActrUU7BG+c9UdqpHI4xzrXuGbND3E
         tc3OxQ/0aFjy2AosUabXZFtcFo7L9Dm9tlVJ69rgxENJ0qvHh1YXdAh5xvibbhZkBZK+
         uGArirAGjx6UGJJMuNF9Sj+NJhoW2Hj+XjCFoue+zzFSMU965BTaf8Oj+HqzwFEErwd3
         zefGPljDKlMrBJF9mED8bbZoeurZdtUeNHH/f/DOuhuljr7qTk+au2z+H/QeIHH8q3rO
         DN4A==
X-Forwarded-Encrypted: i=1; AJvYcCXLSw+OmI5mbBaXV7uuGtCfTJutX1B3Oe95hZsGXe3aryZ6WGXYpF3wAYJrZ4jeuyCFqmufG/RrmcEnWqcNMvIspZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzjisjaHxPYOEq2I6y8PZmBdaPEzov9c4EtPQgE3y8fx1rIAFB
	ROdX1xCVF4kjYOlxrZJDSvU5vD8rn4EobcVo3JAuTu3J6O8xn1Ux+NlmdIEmLCBc/P1PmLCjWBa
	DtkHnVBuIGREq23ouxcxhjQ==
X-Google-Smtp-Source: AGHT+IGhMHN0dJUUicPDV7IwYD5dxjTKJb2FY9Dk+V7sxgd83geumTaXQTdlEwmEdvOKbgxCexNOxhanuhI6Kor0
X-Received: from wmbz10.prod.google.com ([2002:a05:600c:c08a:b0:46e:38cf:fbd6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:34ce:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-46e711408b5mr20342175e9.18.1759498745183;
 Fri, 03 Oct 2025 06:39:05 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:38:05 +0100
In-Reply-To: <20251003133825.2068970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003133825.2068970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-9-vdonnefort@google.com>
Subject: [PATCH v7 08/28] tracing: Add init callback to trace remotes
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
index c011df20df95..55ba3fd9e002 100644
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
 
 void trace_remote_free_buffer(struct trace_buffer_desc *desc)
-- 
2.51.0.618.g983fd99d29-goog

