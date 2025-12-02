Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4F530F924
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668202; cv=none; b=H7h/RsTQl5G02doYeCf7ITXXa7n7jKeNfGtFoTZxcobbxR8j9eth7OKlOm3Ojajqu8xXozzOz05YpSyz4giIoS1OqUBitu6TkU3HEL2EwihQxmngGfA7kfIYtrV9bCmkKuPFiS359HnCQ2wzqed16oXFAV0isT42vupHX8bK9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668202; c=relaxed/simple;
	bh=6jZsAkpWSXcdA16GVH9yGV6F9gS3swQXbA0rH3VNSe0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f9fK/GYWSdTfFIZYblZGizxCn+M6vRPAdSN5wneJGlZ8Anp1quCbZpvBQak0wlYyqQF/trIitPhGphDY5HkIdl5+1KT1SJn16z/yM/1q3Extanar95S2qogJYqi6ZBx0a0s/NlyvayhjWcPd7eOYP91Fj0LX3KNLX1WVVfawGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YFJ7o4Br; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFJ7o4Br"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-42b2b642287so2598633f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 01:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764668199; x=1765272999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C6hDRr7zZJlL6+0BwYS6BtC3S7766siHfVTQT4bpz1c=;
        b=YFJ7o4Br+wgQOja65+aOpooSOLrtH0KLIv4jVeFX34c6wqIvPAx10bw379/EErosYg
         jjGJd+yY2YkHeMmEXf773CB2EcqqEe3ccOI0bgXCNfQiwPrWZdOqpFr39HSWt7h3n5VM
         UzjkFBJbM8OqdWB+hkyR/wQVkQcZrIVTP6hCaymV+56p2sQfHJOaIWs8LRUmd6sxBQqr
         OQYw8W6KfI0GgwkmajQsKR+vmBX4xUNLwbhMM6Xx21VhpWE1v8rMtm7J8pYlEW2GdK1v
         uaxfHuBemp2oXFifW3msPhVnCMT1S2yaXC9ICAtmz+wNvFkpGMuGljw1IVlP4QGYFqPL
         NS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668199; x=1765272999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6hDRr7zZJlL6+0BwYS6BtC3S7766siHfVTQT4bpz1c=;
        b=mOQlBZ/r+KbC8FziybX2FlwhG3GuNBMfqlRGM7agbXkQ+wUtp80YldzMODiIRO536P
         WAeFDEA3MPsH6FMofKKIBTd2emth/0fL0EIIFjQ22dn9oKdcCnYsRU3XFVzoMwNFB0eW
         dzkG/GlLSSjgDxjXlQYbnfFoKS+s0Yfdgo0lHaCbJdOjiqiw0gSCW6o9+j7JnAZ9flTj
         goZSy8pRn2PPi/7YiNb6OCSDisNDxBj5Q/waPhXhTfZBlORncsl8BrkdK1VGA917/7BX
         ibjtv8LOI1+0LcuIccvNMG/zkf+hg+HKCorp2tNTfFGwG+NwXZoDsxELhClvYAJZaebD
         UZAA==
X-Forwarded-Encrypted: i=1; AJvYcCWYj+VQ18Yat9/EbmRN3YZTTCucs92nDYeJ/bTGv8mjUgoqgxV7yfqLm7YMk5fwazu719PBPgmo16co1P6QgDlqjrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzStiymk0bA950gUMlJcYwEBp6woZ+Y5oSTHdbuQyZV5M4ZRfXv
	xtnPCoSeQqNyjNbH2WLFqERUHsrS4t/ayVOoOt+hqmsaIVYu+ndQSRvfLyCJSfLTBvtOrYa7ivv
	1xCPAEnbtOH0ofG/q5QOfaw==
X-Google-Smtp-Source: AGHT+IHwrvFhNppyviCL1Q1Q07XxwsMfPqHOqtUBea8U605YaGsdf4CkpCYK7lF/ypH0eslN4jrChDse/98GJevE
X-Received: from wrqf1.prod.google.com ([2002:adf:f8c1:0:b0:42c:c2d6:2a0])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5c89:0:b0:42b:3ee9:4775 with SMTP id ffacd0b85a97d-42cc1abe271mr45304466f8f.11.1764668198810;
 Tue, 02 Dec 2025 01:36:38 -0800 (PST)
Date: Tue,  2 Dec 2025 09:36:01 +0000
In-Reply-To: <20251202093623.2337860-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202093623.2337860-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251202093623.2337860-9-vdonnefort@google.com>
Subject: [PATCH v9 08/30] tracing: Add init callback to trace remotes
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
2.52.0.107.ga0afd4fd5b-goog

