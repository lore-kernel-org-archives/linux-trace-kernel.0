Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5539535294E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866168; cv=none; b=BUzWJgvmH9qZAGF0R2G3JITLjoEnZtWmSu+AgGcWPXZ1dhq9hFO4WKBe/S61u9IUxrDLroSLUdG5R7CoZWCSMBtl2U0OyjiASvDGAMMnxIeNrAjfmzjzvW2I9Jye9DoqKBe2VJlzIzmdBW0SChNMjSsYEn909BAJNK1V8PayQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866168; c=relaxed/simple;
	bh=YpT43noux36Qb8SPRAxAVRkhFfy4HwaeXM5l7XWGGkw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AE/iAAwz/MEFaY4UeJ2jc7Aq+URk5m8c9VtB6aDQpzjCKfS3r/WtNpPFsF3KP+0hw7VEbnLBnRvfADYUxttr3d68a5Ms6kl3WUF/hycin3mxITJeOL31dxFWRqP123kxY7Z7Ie1bnhesTWX62uPOd0u29qSs1WVCDypcX01IZlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VI7q487C; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VI7q487C"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4802bb29400so37325575e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 05:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769866163; x=1770470963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZUIc60w8aDIxM9yUNkpf1enaQr7Rd+FSbamqcyyReA=;
        b=VI7q487CmZOIo+01B4R9MgNl5VKEa6WkOnkToDmYxHeSqH4Qejfj662WMwJKMENhWm
         HuQI5h4Bq83fZQ/P9c9z45V2LqvLAqDbB+bd7n7Yzt9ui6kTv9PzU3vvw6T8/8Mllg6d
         acRTPjJGjtZuTV5Qi2C6/erZfErlv9q2A+/4ItbM9AG5e5BD2HAkMG+yk1GdXEgbe8Ef
         OuAUtMWdrRVovAFIrvqhYTOpTDDsNnJ6h3kp0jB/xX8xwyB4B6E4rHWuJnHl8DLoE56S
         tDOT3ggKgFcIM/PzOfbQFNmKi4GjQctkjSogCpmp6exKhwtCM3fQ/jb7wtWOh9KyLg9s
         A5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769866163; x=1770470963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZUIc60w8aDIxM9yUNkpf1enaQr7Rd+FSbamqcyyReA=;
        b=ZglZNZd2JVzA8rWAMpb6fAik36qKd7dpYKvEB08TBxk/8Zfe+0+71J9RZbFZvS9lst
         8jVoSjALr3dvordj6si/udmXx3sRojkwxWxVtlTKNj15eKp36P+00Af3gHCSs+Zey5+z
         SSfayI2yglU4WXkc9PtbpzzfrjeDKF7K/J+RHSQzZWI2mENXi65aPfaGc6D7DOJt/OvC
         gd4MM6Y4aM4x7LwHJX6GMAONaHdrf10mVSuJHkUTWmzMh93CR4G1y8jDQ1HCn/90H55S
         w2PkdKw6uUY/fAzDaSLoeL+hBc6yaWjLG8SihxU90suRrN9GLMIMQgAMEYO/Z3F4nz1U
         3RLg==
X-Forwarded-Encrypted: i=1; AJvYcCUyYUFy/b5aqRQuPoyqsxsleD+ACYiDO95b5I0IF7QX4ytS7parrHR5XPYec5uU27DVGDt+oiz5XmTY7Qw2L6P4CTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdYD/BdapoaeOrMMlLZQmSkDSBtugbTjOHaxzGelxn+ep8LAXr
	dnBuRgdQ+75LPtKAhc6DToNCtTVavY3D0B/TjXau5fL/qyCWUCz1VDaFzQLn8dHL1q1TVJKzVTU
	2EFoN+vlBbA10VtPcOfhRBg==
X-Received: from wrfi9.prod.google.com ([2002:a5d:5849:0:b0:435:a2c9:8c02])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ec7:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-482db463c13mr79331465e9.16.1769866162768;
 Sat, 31 Jan 2026 05:29:22 -0800 (PST)
Date: Sat, 31 Jan 2026 13:28:19 +0000
In-Reply-To: <20260131132848.254084-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131132848.254084-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131132848.254084-2-vdonnefort@google.com>
Subject: [PATCH v11 01/30] ring-buffer: Add page statistics to the meta-page
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
index 630221b00838..1187d632dd5d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6131,6 +6131,8 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 	meta->entries = local_read(&cpu_buffer->entries);
 	meta->overrun = local_read(&cpu_buffer->overrun);
 	meta->read = cpu_buffer->read;
+	meta->pages_lost = local_read(&cpu_buffer->pages_lost);
+	meta->pages_touched = local_read(&cpu_buffer->pages_touched);
 
 	/* Some archs do not have data cache coherency between kernel and user-space */
 	flush_kernel_vmap_range(cpu_buffer->meta_page, PAGE_SIZE);
-- 
2.53.0.rc1.225.gd81095ad13-goog

