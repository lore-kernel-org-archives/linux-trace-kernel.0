Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EA3288CA9
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 May 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550128; cv=none; b=ODbI+xU4mBnD0R8WvRKFddLeKZRkHKvtzB4liZ4KqAgZBZxAKX6insreXBVwViLx1eXFRnYzOAov86svfEXwl0Rog/MbrzmU2EGNCEj3upWqUo5fFkzyCVPm5L+puDosvRuKPIMMyESq/GHsli9HnriElKLZsoGDtQ7CPChYu50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550128; c=relaxed/simple;
	bh=l3cyRuYF81wunoJ7TifMvH83r4i55FQixMLbcy3lwME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ono2+NjSnqKyHdlLaC/EEg7RTlE/1vkCMe3dvHkNcR+PlVCWt1TKTxlFI3zGtmjBENrK9D5hX/mp6egH2rjIYCRBuBHa3gvvOYHxewPdZ/lhynF8H6898rMkaJ/gSppTDjkNuK8QY7UOrY8os7UtWihuQuCZZpsD9VhbylftX+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RE/y0T3O; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RE/y0T3O"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3912d5f6689so2843177f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 May 2025 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746550125; x=1747154925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ulR0t05oQC1aYq/PHkhH5FZiwJoFyTXIHcnk/CuN1Ys=;
        b=RE/y0T3OQ/eziv7mmJ0MwguaDxQ6HlPabzAzPBhc2ofZynkJWaWPnyApioLxuzTf8T
         FHorYK9j5HiZX1ibqzQKHABbWiUsAYChHQ84bl/otbUKlZN1GxaYx2/JSKCrjDtKMHe8
         //2rO8mbarHzUK9DkvjsrZFUu/7mdq8tqQDBq+oQcvdLrT1hlxGFKxb0+uXeQuYWDuTx
         P2eQXDbveBtGY2HeIxkOxWayG+0ZjwxmJjgaPz+QeIfP+vCuYZPj05hQgRmmPTP+ud62
         Kp+ai53MleOXaxnkT6Xp1XoFkV3jTcghvjEToPAbMZg1kdzVpwR4fuZKhIRwR9e3JnHX
         kNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746550125; x=1747154925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulR0t05oQC1aYq/PHkhH5FZiwJoFyTXIHcnk/CuN1Ys=;
        b=hlFUMq15q/jpzsUwLjKsF8NCFpIaaOp99SN40J6tS3vWzCHrBieJJUtp3tjvo8d1OM
         iqO58bv+UBQ5+mNEsKBG81YrF0eWm2QvuHfPUylCO6ebtuvBEYfWgETArNtBb7WhXDeG
         P2yw3+Ru7sUab+o+KgMpkTyyRqBRFoyftbQYSfQq0xkya6pQbkIIByoAos81qlOTaQXR
         2qL0V1UQruVbY5AFCj3whqZR+BkcgYObe5VNfI9QAYs1MNes9gPjiwCAh8RDUaStDyvH
         n+Z5MMNv0HBGdoSb+QJ6Vwp9oRwt80n2dlXuyjiL3Ithg/1Y8ESmwIx6mXN3Ka66JeMW
         /mMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiPeFxXbR/YpOjvSZ7IXqCEbuVmYPXqKJdevGtFPc5ljlweye8UGMdxX7Lpbx5g03N3VslNY2eTlcjeAhxL5HMV2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYN7+boQNhXstDjsfqxtnIWo34BRoSedy/UgoHrCLmGsrRf8Zs
	2viJIEG7eYidPuzYMr9Whp+wHWg1RS8ekw5efwZVmyMEBi6rXoZQl4zslEOopMhiS9cR3E3IklA
	r6W3oDPiiS3U4b56IQA==
X-Google-Smtp-Source: AGHT+IG1v09/s12usa8mhNe5u/61861N0/kCY4NkyY380pXa7lF6ETtkjTMmugXHCVnG7wZDISxXe9P8kKhSjb56
X-Received: from wrbbs23.prod.google.com ([2002:a05:6000:717:b0:3a0:90bc:bf72])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:47c7:0:b0:3a0:8352:775a with SMTP id ffacd0b85a97d-3a0b49b5e48mr195832f8f.34.1746550125284;
 Tue, 06 May 2025 09:48:45 -0700 (PDT)
Date: Tue,  6 May 2025 17:48:00 +0100
In-Reply-To: <20250506164820.515876-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250506164820.515876-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250506164820.515876-5-vdonnefort@google.com>
Subject: [PATCH v4 04/24] tracing: Add init callback to trace remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a .init call back so the trace remote callers can add entries to the
tracefs directory.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/trace_remote.h b/include/linux/trace_remote.h
index 1aa99da3c96a..82d26d97a536 100644
--- a/include/linux/trace_remote.h
+++ b/include/linux/trace_remote.h
@@ -3,9 +3,11 @@
 #ifndef _LINUX_TRACE_REMOTE_H
 #define _LINUX_TRACE_REMOTE_H
 
+#include <linux/dcache.h>
 #include <linux/ring_buffer.h>
 
 struct trace_remote_callbacks {
+	int	(*init)(struct dentry *d, void *priv);
 	struct trace_buffer_desc *
 		(*load_trace_buffer)(unsigned long size, void *priv);
 	void	(*unload_trace_buffer)(struct trace_buffer_desc *desc, void *priv);
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 2221705f65f4..6f4b921f6955 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -479,6 +479,7 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv)
 {
 	struct trace_remote *remote;
+	int ret;
 
 	remote = kzalloc(sizeof(*remote), GFP_KERNEL);
 	if (!remote)
@@ -495,7 +496,11 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
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
2.49.0.967.g6a0df3ecc3-goog

