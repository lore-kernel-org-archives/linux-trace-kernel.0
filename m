Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A703ACF1B
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807755; cv=none; b=Ye1DfOUG+Tcf0wbVNumga6z7GQtKzlunRJFemwcDYnWiX5NysCnewuxc2Ha9FgmtxbwvNGKFHOlfQeUwm851JoAp7qMGj19dgd9Lzb2iYzMq+ForYXhhKI9f4Qtk6JC5Nq1HLd/S10eWk8XZPKhnrIw1pOFbSmgr4GN0I/euhrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807755; c=relaxed/simple;
	bh=Hz/rHu9p9uFE73JluB0dAIuM1LGGVJBibGRScbVoAfE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qGIkTNnVhrD5cI6ZQHjpTz+Q5yjWARF+wx+EPIlItL+mUI4YVeUqqycjslhTaypKM6qby4FFTg9sK2xTByqkSMSO3AlDOnLdaY9R/KGmi9uZUO6mCDdHy8IesJoiGpvl1NbSLYp5VlxjaA+hAv+LObD+9Te+WSP/6XDUWPlGxTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KMDqRpwW; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMDqRpwW"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-439b484ee04so3874845f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 06:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772807753; x=1773412553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Q6YHflryAt4GuwVgZW5CjVF0OSLajguucPNlc9fXbU=;
        b=KMDqRpwWmuOWz1wjbwaBXWH1WxI/ZqLp0MMSQlKTkVuPgspCH01ad/d5mxuV8ILoyc
         II751UmB/xLgBjFv+nloagl4T26Covr2lXpFwVyKlnBa69UWYQxTW1pnK3pS7g3BvXoC
         dbaPq9pN7yr+MAotb8N+/BadF/QgLZecETBGNymUk92YUE9+Pa5GrV7laWbg0PqvreAf
         WqlgzXA0N+fzxPwTu5+HhyVXyROIu7IRvzHw7UhBAQOuQaM1i5Wzcpr+OLqvLG8Gmuh+
         h42RmCz3qcA7kEkK+YTKbMtwnAh74cNdFlGJCA056hcG5A5am5UrH0oYObYl6zOyl1Db
         AseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807753; x=1773412553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Q6YHflryAt4GuwVgZW5CjVF0OSLajguucPNlc9fXbU=;
        b=qSwP04hmIUkcyxiP2a6tzN0A+MuOQJ7bCC01TPEmn0GMIUoYCAsqLwAyV55tunwi5M
         XxNrT32R86wruISI1z/qZt5u+RQBt5xgFAPRP4q8NpBmVtztll7Gtj3/U/ilNtYc+DGr
         srSHFUwIpvt1+ZBqfZ+RMti2N9IWxnRMDe/2ukiplJi1oOscTb6/FA35TjR1DjG3j38E
         jzsHCkkcgrIPx7Dy4PIIEG1/BJyTxAQr9eeIVgulD7ks2WO2Ne/YvZXzC6Ycu3UQYLSC
         rfHf4x6HmvIPNfUHZm/yYRW9YlqqwibrfzoO9aJJKlV6v+PT2qMbgUhSfDgOG1ZPRv54
         z95Q==
X-Forwarded-Encrypted: i=1; AJvYcCXN6spcB1Nidg2gvDi9LH42k2Hy/Rbisy69er5R9A60ChdzzBEcxMsmW8zsvbA4RYazQJm9k+pzIqSj4uEmJiOLMnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk8wxEIOanwOUwdBgEqKzvi3R0jV6LrUBpU4Rw5cmCmlVrcat5
	mGGrg0hBBdA6AebvkcHv136AxNhe3+gFddDQH9nbFzYQD5/lVv/xQYiUaembzGc18rzfud1RW83
	yl8oN402fnOSD1FsnC4yKgA==
X-Received: from wmpg39.prod.google.com ([2002:a05:600c:4ca7:b0:483:8ade:6472])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:64c7:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-4852671d9c3mr34583765e9.8.1772807752682;
 Fri, 06 Mar 2026 06:35:52 -0800 (PST)
Date: Fri,  6 Mar 2026 14:35:05 +0000
In-Reply-To: <20260306143536.339777-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306143536.339777-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306143536.339777-2-vdonnefort@google.com>
Subject: [PATCH v13 01/32] ring-buffer: Add page statistics to the meta-page
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add two fields pages_touched and pages_lost to the ring-buffer
meta-page. Those fields are useful to get the number of used pages in
the ring-buffer.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index c102ef35d11e..e8185889a1c8 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -17,8 +17,8 @@
  * @entries:		Number of entries in the ring-buffer.
  * @overrun:		Number of entries lost in the ring-buffer.
  * @read:		Number of entries that have been read.
- * @Reserved1:		Internal use only.
- * @Reserved2:		Internal use only.
+ * @pages_lost:		Number of pages overwritten by the writer.
+ * @pages_touched:	Number of pages written by the writer.
  */
 struct trace_buffer_meta {
 	__u32		meta_page_size;
@@ -39,8 +39,8 @@ struct trace_buffer_meta {
 	__u64	overrun;
 	__u64	read;
 
-	__u64	Reserved1;
-	__u64	Reserved2;
+	__u64	pages_lost;
+	__u64	pages_touched;
 };
 
 #define TRACE_MMAP_IOCTL_GET_READER		_IO('R', 0x20)
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f16f053ef77d..1b8be41faa78 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6154,6 +6154,8 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 	meta->entries = local_read(&cpu_buffer->entries);
 	meta->overrun = local_read(&cpu_buffer->overrun);
 	meta->read = cpu_buffer->read;
+	meta->pages_lost = local_read(&cpu_buffer->pages_lost);
+	meta->pages_touched = local_read(&cpu_buffer->pages_touched);
 
 	/* Some archs do not have data cache coherency between kernel and user-space */
 	flush_kernel_vmap_range(cpu_buffer->meta_page, PAGE_SIZE);
-- 
2.53.0.473.g4a7958ca14-goog

