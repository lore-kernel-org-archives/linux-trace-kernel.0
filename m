Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965031FBEB4
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jan 2025 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336783; cv=none; b=ISrR/8yGyKdlHoCkcL3DSL1MEeD01SSt/EUQBamhoQx+hQ6ZVfUNZ0Il8ljImbOgcNpCbaYIXkcfKNvzZql3z//fmsaBj6ye0QF9DFvmJYdXMEzkj6iRxgRV7YlJ3t/KNEO1ygTS9h2SFjEETxQdkjtvvKj1UHcvVISTTudnR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336783; c=relaxed/simple;
	bh=lDl5drBkYzVy9toQq6HEzUqIT/PGvzU0P07pQal1y5M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=onvsMkI1SJakywsSpDVtOgsVGnyIlxMc30eCNJhGwvLgpUnK5IrbZRzRLGeR/A+tGXr4U5c25QpY3M327c9KKO/NgSDEKr2TaProjDBfvvL7nQcUNvQJrOhUpN9pHdoNcEWsMt0hEZnXiNyVhUvHBk+SdKeY4sbMjjA8c1KgojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vaf2Sy2N; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vaf2Sy2N"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-436723db6c4so96116665e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Jan 2025 03:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736336780; x=1736941580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d8iCsJo5WR6KzxB92gJlgV5iV2uqY4fo13qrdsq5Log=;
        b=vaf2Sy2NRVW9SDmWFu+CNDCm3ISrggsQioK155BQZhxAdBqBYdsEWLNss1LanAbRMV
         ULvPl9WwOGQlLhVW/lFb+tuYVz6lK/25YbtVxiMt/RIjJSSWThK1LjGdbo5wyNf4sqj2
         DpqiFw822Y3Rf7s8YxVkPLSidSt+R2CKE+kK5RWC3EXLH26zmEP6N83aFJxmn4WSlDa2
         Em5pEgDwjzvCl9lXfVcFajwDBTJ/lB0VFMhCds4ZiRz2cJyzSUHd9iuV9J4ckhytGw3k
         0ULI1k6GW/EnJsGDEbinvEisD+v2nW0CBSMdW4QTajnagaWQW2R+C9NS2AJHB0eqOSTS
         MlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736336780; x=1736941580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8iCsJo5WR6KzxB92gJlgV5iV2uqY4fo13qrdsq5Log=;
        b=wAWHKqwJm/pIlp6dCOriukTWjI5MhYuUjCCfBTZmwJZsee5VeZF9uycM4WXq7QZmKR
         9SiRqwOHuJf3veuLhEdiEo911jv0HIWjBAMCQkpJgf6Hg7FVLZL+EC+vyJW1mXxu2gmm
         9jCVtMjVkRppp+1n/R+mcJU8vXc6kNrr/G6WnDU6vp7M3ZP6QY5so7R9atO4ZVqK4YOr
         //6DNrz4RixOiE9TgMvtJUM6llpDzYJPjPuXoEVP9DvYeBIfaGI5jrBv/EiNYjeYAuGV
         AsaxZreqt42EwSKmi9QnVoUiVrPlfobDIfm4XLGnxNJ0QqfCveGbbqNE0xvvUX+mPfZ2
         ci8A==
X-Forwarded-Encrypted: i=1; AJvYcCUSdTIh+eejyw+/pkTNNoyzTYVvTYcP5pjAaiUZw2BnAi98t2KdCa5HlaWULX1cwIcWbdYaXPwkvWAL0rY1IPZcU8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrFOCS1knPWjzFue1OVX2SGoDCWhzyNJEtnx3y0/vCYF0Ofw85
	00vu245BJzMJqVktOrwXxWhBAfEu9j8T+e86T8S38ETrKYWYw8zEqlNcdmv+plDg4IXakfeZVTi
	UrOQZYuw101OPyUmxNQ==
X-Google-Smtp-Source: AGHT+IHXMIUN4Xu/0FCutrVo30LeA75reWr3RoI+cwLisNRBI4gx5AnZfMZi4bJ3gkUBjuYDzu4HpZhou3JnhYMl
X-Received: from wmpz19.prod.google.com ([2002:a05:600c:a13:b0:435:dde5:2c3b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4751:b0:435:23c:e23e with SMTP id 5b1f17b1804b1-436e26af4b4mr21060665e9.12.1736336780098;
 Wed, 08 Jan 2025 03:46:20 -0800 (PST)
Date: Wed,  8 Jan 2025 11:45:33 +0000
In-Reply-To: <20250108114536.627715-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108114536.627715-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108114536.627715-10-vdonnefort@google.com>
Subject: [PATCH v2 09/12] KVM: arm64: Add raw interface for hyp tracefs
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The raw interface enables userspace tools such as trace-cmd to directly
read the ring-buffer without any decoding by the kernel.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 78193dbd8a33..3d2a58977442 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -749,6 +749,85 @@ static const struct file_operations hyp_trace_pipe_fops = {
 	.release        = hyp_trace_pipe_release,
 };
 
+static ssize_t
+hyp_trace_raw_read(struct file *file, char __user *ubuf,
+		   size_t cnt, loff_t *ppos)
+{
+	struct ht_iterator *iter = (struct ht_iterator *)file->private_data;
+	size_t size;
+	int ret;
+
+	if (iter->copy_leftover)
+		goto read;
+
+again:
+	ret = ring_buffer_read_page(iter->trace_buffer,
+				    (struct buffer_data_read_page *)iter->spare,
+				    cnt, iter->cpu, 0);
+	if (ret < 0) {
+		if (!ring_buffer_empty_cpu(iter->trace_buffer, iter->cpu))
+			return 0;
+
+		ret = ring_buffer_wait(iter->trace_buffer, iter->cpu, 0, NULL,
+				       NULL);
+		if (ret < 0)
+			return ret;
+
+		goto again;
+	}
+
+	iter->copy_leftover = 0;
+
+read:
+	size = PAGE_SIZE - iter->copy_leftover;
+	if (size > cnt)
+		size = cnt;
+
+	ret = copy_to_user(ubuf, iter->spare + PAGE_SIZE - size, size);
+	if (ret == size)
+		return -EFAULT;
+
+	size -= ret;
+	*ppos += size;
+	iter->copy_leftover = ret;
+
+	return size;
+}
+
+static int hyp_trace_raw_open(struct inode *inode, struct file *file)
+{
+	int ret = hyp_trace_pipe_open(inode, file);
+	struct ht_iterator *iter;
+
+	if (ret)
+		return ret;
+
+	iter = file->private_data;
+	iter->spare = ring_buffer_alloc_read_page(iter->trace_buffer, iter->cpu);
+	if (IS_ERR(iter->spare)) {
+		ret = PTR_ERR(iter->spare);
+		iter->spare = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int hyp_trace_raw_release(struct inode *inode, struct file *file)
+{
+	struct ht_iterator *iter = file->private_data;
+
+	ring_buffer_free_read_page(iter->trace_buffer, iter->cpu, iter->spare);
+
+	return hyp_trace_pipe_release(inode, file);
+}
+
+static const struct file_operations hyp_trace_raw_fops = {
+	.open           = hyp_trace_raw_open,
+	.read           = hyp_trace_raw_read,
+	.release        = hyp_trace_raw_release,
+};
+
 static int hyp_trace_clock_show(struct seq_file *m, void *v)
 {
 	seq_puts(m, "[boot]\n");
@@ -803,6 +882,9 @@ int hyp_trace_init_tracefs(void)
 
 		tracefs_create_file("trace_pipe", TRACEFS_MODE_READ, per_cpu_dir,
 				    (void *)cpu, &hyp_trace_pipe_fops);
+
+		tracefs_create_file("trace_pipe_raw", TRACEFS_MODE_READ, per_cpu_dir,
+				    (void *)cpu, &hyp_trace_pipe_fops);
 	}
 
 	return 0;
-- 
2.47.1.613.gc27f4b7a9f-goog

