Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D5F309F01
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668196; cv=none; b=oeF7fOFiV6TM1zhAUYXKFBf94vuYKrBy5TQfndRHYee4MNnxzr/BkolvEBb/BHqXY2uyGUT93FYhX3meXewUMWSyO+U1cYffT8SP4TDVyhZWm0Qpywm8NnK0spUbQAFW5GdzKEPwKKOv///XfBh8gGtasEcSafWDQT8hUbrZkqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668196; c=relaxed/simple;
	bh=WTMLyErWOb8zCrndU1XpyXrUk4hC/pi+xHnhtc2fDxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HqjRnW0sPDgWf9kk5JorrtSdrp3LMK8EhvrJtHws6fVLgcKYxghYbPNWfqTK2yCMyi2DgQhbUx3Xvj3KdN4C2UAYAv7Gf2v5SjWfY/uBONiB4ZO6pM2uHicqwhVgtm2hAB5sHsZn1A3hbZLR3ZX8831oC4eR9BaQOWbfekfiPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4qzQbrXD; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4qzQbrXD"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477964c22e0so33230155e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 01:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764668193; x=1765272993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BJMobDlS9cUjf1A94hhHD9cE0Yb81+orJSLPQk+5ukA=;
        b=4qzQbrXDCEKzVr2Av0QmY/gnmIkQGMZU/ZIjOw/dmqF6O2guAP9CZGJRS5VW+uswib
         y3i8iyaolgNhmcJZ8AuQge1pO+5R8owJ6C6vlFJkMOuV1Iefv7UyT8u1r2sxo2iemkHr
         C1j6TcPIcIOs9p2OUDaC88vNjnmwG2Li+/zUfQ5NKqlnK99PZ9y8eE26zu1Fk7ndIIKq
         3jl7Rw4H+gzk/nSS74zUqlCSw1hJ23DzdUr7bKfazn7HV87YROBDMvyTULXM6AFQu88K
         uAAtdJbRRg4X76WxIgj0n1ZrzdXYEN0j842zmaYmLoqp3oe3b/y6GCLF+18ifEI+nvU6
         Kkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668193; x=1765272993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJMobDlS9cUjf1A94hhHD9cE0Yb81+orJSLPQk+5ukA=;
        b=Bvb1I5X3yE4Jz7CSaXATU5xEdk79bpZdhdaAeGtkOdDJvxLlOwlPq3MmGEvgLsy/2c
         vej35VytZFRrJF4c5IZwkPF1TM0b/o9Wx2XEwiXG4BdSvlryXlgaQ0LZ3gbic1L6kGWz
         oZkCgt/ecKjY6gSuGCJcz1foqLni8LBYkQz7z3uAhOhq+0bL7IKDj5aCRjxbxB9lTjuI
         CODil1t8xS1nKjOLT9fy7CR8z2CKsCUGZT/tsp5fK4DzYItvNBrHOcsiDXZNC/R7K+LL
         rbTP/Cw0JS63LpOjAel8AOFMvtR9BTygNNG/mSkw9+FSjVU6rPd5kulJH0+dZUFzz4Dp
         tJtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsSvNb/ksoevq/OyG5a+0VW6b8VJ/cLn5461CliGo8RcVEfOXQJA6ZSzIR1Ya4PhkVMOXYp0oZNA1GUKRJlobbtOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy11p0YHgpCF3M4rm7hYPNqShSbQ+mbVf/iWHNZZv7epybzvwyU
	bXvIGaKLVCElAQjUpCZXIfpw7WwiIIhKaBtn0LOPpp79zKzt4IlwM/0Vxa4VSyplrVJvK4nvwD7
	q5jGuhEaOtvmsXHHOlqemOA==
X-Google-Smtp-Source: AGHT+IFOZr0MC/hR67QKvdZl1NGr26HqxISCDgDHqiuErADTEPz6Od/NumPdYRXvv0diOBWVyP3bPEcOcKjqzEay
X-Received: from wmlc8.prod.google.com ([2002:a7b:c848:0:b0:477:5a4b:d57f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a41:b0:479:255f:8805 with SMTP id 5b1f17b1804b1-47926f80721mr15071745e9.4.1764668192874;
 Tue, 02 Dec 2025 01:36:32 -0800 (PST)
Date: Tue,  2 Dec 2025 09:35:54 +0000
In-Reply-To: <20251202093623.2337860-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202093623.2337860-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251202093623.2337860-2-vdonnefort@google.com>
Subject: [PATCH v9 01/30] ring-buffer: Add page statistics to the meta-page
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
index afcd3747264d..048dde717b94 100644
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
2.52.0.107.ga0afd4fd5b-goog

