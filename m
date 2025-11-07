Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5433019AD
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508332; cv=none; b=QcG586d5Nu8G5qc7FHXE4NJuJmoe8Iqldn8n/GpW9BAEsJtTm49daZZdnibxadS5suQ9ewZ7JK7WwtjFEO4DmLJWiKWKniVraO4lf7jToNCmfZP1XHB/b+6hBQnsGH8ODXeqBRfljYao5eDMZ0ce/+j/cOWQ8RiyzReKdbT2bYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508332; c=relaxed/simple;
	bh=bbIu4OLAzPu9BN2qUYAt/wKwBQ34W6Iiz5uSvl5YDWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z9gcOrtPt9iqhw5RyL5ia6+oqGBDkgPCV7BBhliT+F9l4K4wb8acfgWN6hI44+cWnodNrXUYigWVDXU6vb0NJy6EcjUlYGLpzR6wT9E5kzAzLTjSJoUYNRLBZ3anLSYhgKWhgrvOUBu6UYqleyU6xSn3kgNbX1pcvc8XcunKA1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xIvZJDRk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xIvZJDRk"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e39567579so2271595e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762508329; x=1763113129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8oUgbBX1ulXE/9DMN2n7zAGqIrRVP1Mxd8sp0hGAu+o=;
        b=xIvZJDRk7yySSs9CgHSNkn2wQOC2r6AD8vMk+u0xc1eFwoLNnlbLVsLN11fc9H1eLS
         mJIauQoR1EQeGjrJj4E+pdQRJwzJYg7gFwEprKkcrwA8/XBmYXsEW2ed0AqoubK/LAAL
         4jus9nZ4zH3lN1M0L4wYsAGeXrjVRzNpBuWioiuT/c6mmVQULRFOdZLHaUoS1WtPSedW
         CC/pJ/l525HwTHncm3cWcl7GRF/LoXvBd4RpbVPUp5qlcK66LYeTgJzLlPsM8+VDep04
         5wnokAHkUHYfr5c34UR7xjDo3eywn4EG/XGDLsvRWf7b2fQizlXBrjCZjYVLKcsMn0nr
         FaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508329; x=1763113129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8oUgbBX1ulXE/9DMN2n7zAGqIrRVP1Mxd8sp0hGAu+o=;
        b=r0galhxc2ikht4a/sYbF4VDQm+HRPI433ZB/CALArHbB83m9g2+TXmkc7qAIOywUYW
         TqyhfWDDVlKFav2DNS5ziWsHkxDBrKz1D/eIlkgA0dQhMxt9ZNeqcPWFPY6cF1XeMhHy
         f0JVGgibKS3InsVfGOCV5QJLB8aish8H3PNZ2OfNwiylt389e+4ucevgiqGyKFguNiaZ
         dNkQiXxi4YdlQ+8zq13RT7e4iF+gYuUrnqEP7+Kw5vod2qszuO9qeczQk6FTma5wObyp
         q+xvExorJ4BrMIKVXnqGP63bphqrdcug3Uvgbwg04BcNWLwmZqFK4Hms9JG0Hq6X3mz6
         SOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa/p9tDKPE5awiIn4FBqJRywpYKsHF3eqS7sw9TojIJc77yy4Fn/4wLm8MYeSTi6aTy82rYOfpNFziTw7WDps//84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf7xm3gBFE3aiOYP4uZFebnjquceF7Y7CmVsiKGoM5oGRGTLqW
	wjrb9KXEGjBANUYdTLyIfEtOSCGhw3NaoLYtjIRzOOmC0l616cxnrLigPefldTCsoYIMbD+YbXU
	IkLY58phazF+lQo8RLbJKoQ==
X-Google-Smtp-Source: AGHT+IE23rPEzYSe4I0moWqEMyLx5Nz/SDjuSLTsgRUDjXKubF44UKXd0LSGwV/bDB8OhzSN4YVGVIEmz4/I2dF8
X-Received: from wmot14.prod.google.com ([2002:a05:600c:450e:b0:477:bdc:7343])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:548a:b0:475:de14:db1f with SMTP id 5b1f17b1804b1-4776bcc2b13mr22237325e9.30.1762508329480;
 Fri, 07 Nov 2025 01:38:49 -0800 (PST)
Date: Fri,  7 Nov 2025 09:38:13 +0000
In-Reply-To: <20251107093840.3779150-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107093840.3779150-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107093840.3779150-2-vdonnefort@google.com>
Subject: [PATCH v8 01/28] ring-buffer: Add page statistics to the meta-page
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
index 1244d2c5c384..6e912527e44f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6113,6 +6113,8 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 	meta->entries = local_read(&cpu_buffer->entries);
 	meta->overrun = local_read(&cpu_buffer->overrun);
 	meta->read = cpu_buffer->read;
+	meta->pages_lost = local_read(&cpu_buffer->pages_lost);
+	meta->pages_touched = local_read(&cpu_buffer->pages_touched);
 
 	/* Some archs do not have data cache coherency between kernel and user-space */
 	flush_kernel_vmap_range(cpu_buffer->meta_page, PAGE_SIZE);
-- 
2.51.2.1041.gc1ab5b90ca-goog

