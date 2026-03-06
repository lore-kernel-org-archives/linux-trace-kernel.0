Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51D03B7B6F
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807764; cv=none; b=YyQkEeMF2QwCi0EgGjbJGsRbojvG6Ky7eXBEi5LarbI1gui7BVbv33WZGFPEB34QHRD65fgW5vt8qcfW5V3C7G2q3C1d3H4YP+FFmq3u7qN7BKHMhRjmO01I4hjzLZccRhcogCQoIXeVKHuJzY15MYDdyGm/00hWJmTXl4YlPp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807764; c=relaxed/simple;
	bh=nCoqfYLkFALSGqFmK5+OUBL2T+SjXlSRskeq0sqM6lo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ouge6wiPQW7SM0bOwQIohMQPZbsVnmsohx4fNEjnG2LLVWYD/va2qD1bvjLJP8vfvfSHWg7MsJm4L1R27/xwx7xvlu9Z4H5xDPBxegfNU/sDJqvtj/pPbMNDdYyWXt/7hIJ2DXL8UjEmSANxC0Lb2JHSxNjuoF6oF0rhxXXNt9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ff7HgNG8; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ff7HgNG8"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-439c794edd9so2865934f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 06:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772807760; x=1773412560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/el005jPydhTNUS1hr5dgVCq32s5flSC0Li9+BCYSpc=;
        b=Ff7HgNG8qkz/SWjxwzh2AAjN07lK7vhPSr+wcruMKyD76jRTj1gURwDMcuAG6JXxd7
         KmKFWmRPQnMckV/CJRQ+E6NEIX/ynL7Dql1KpNtoPtoPL6PJP/fwUnE+pUzCLmh3LVJM
         roaWijkoA6lLPQZ+0z8N8EI95osWCUif3OiC87eCQq5+sYsdAVsm1hIM8GE8C65Zujo7
         tWmmvurZzM5ZGZ5rSyNyfmlYQpDBKSFBupYqndOefcZlvBpK6FW2przKtGdRd9sbt8RP
         VuW+txHt4eAln1a6l8nK5LUDTscRPgGQLZHUFM+lBINjioj1byraMpX9cGjQofL2+Ibu
         pAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807760; x=1773412560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/el005jPydhTNUS1hr5dgVCq32s5flSC0Li9+BCYSpc=;
        b=CMKgmFH+3+scCdU+7YRKhLBCOl/oWBuTQ7mRsMuIQNAC0kpztA2QIma6MoJ/wsMYY4
         yKtnQu+5iFWjjYSWTZDcqsaCMsdgZnk4dRiM+jeUaj2qt3AXTw865h9jhIFs0KzUgVFO
         Y/fIXrFKD+0Uj/USm36H0t2rYAoMg00M4o6LuzRv91E9O3PFr0eAXwTRlfMM35V8mnMZ
         tbYdrkW6wePx90zechJqODSx25D+5ZqfowWf/rNLWDKJDR+Bst14/LPHPGofSHcVKOkU
         kaBc4/mC/qLCAb7kbepz1icYRw28c+A4Pix/0jXYGRAnUShy4jwIfD6rll5f8ttZl+Hy
         mdEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcvNdCCyCfB8dvFsZi2SZ4L1eCGXBO75P3mlgJ8S4775cB3KX7/NsVYC7QCW95Fwm1S6uX/kgSuDuxA9EpJT8RDVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA8jkPTuSmJDVBJfsP3g55aeEzqIqi8S2rPLmqTSGq7lIjl5v5
	BQ5QgfO91rudaLO40GqIIUDzg8KCvi+5eVNnKNIE5Htdf148j6VcgAAmGJFAr0wY+DG8ypAwF/D
	hu35iHXoP282YSmkatcTAPA==
X-Received: from wrph18.prod.google.com ([2002:adf:f4d2:0:b0:439:cb0d:43ff])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40dc:b0:439:c9d0:5fc2 with SMTP id ffacd0b85a97d-439da891b2cmr4112557f8f.39.1772807759879;
 Fri, 06 Mar 2026 06:35:59 -0800 (PST)
Date: Fri,  6 Mar 2026 14:35:12 +0000
In-Reply-To: <20260306143536.339777-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306143536.339777-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306143536.339777-9-vdonnefort@google.com>
Subject: [PATCH v13 08/32] tracing: Add init callback to trace remotes
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

