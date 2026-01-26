Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5623432AAA2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424269; cv=none; b=G9qVzO44sTHNZiOd+snDK4NUlWm+b9bfD/HjNs69pKT1R4K7dEbkzMiF7r2KDvKTsbHls4uifAk+5wMBNaN4NmRhqlWUj9+l2xggMsNkfxWVBlc7LsDWErEplSxfOfkkZbqAiym5RaEru4sUDydNmOk30tToHTV5cAPJvbqfpMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424269; c=relaxed/simple;
	bh=t7R+pvWqC6CiC8mrPebUWkZQhBfP+oPIAOX+3pC+A90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GsDsmwUtYrK8aesXw5E68dvkymQ2hxy2ZzDZm3YihE9R7Oyt7Jn00HqY0vKclYORZgmatHTutHk2v7xkzrV049kGoeTOhzQXZ3w/mF2M5qVncp49HCY7Qdbj6mCOAEOvt6/qBcPE2FBNt36SvBtlfRdnG8hppiZcIoUHtHYcSWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJAThAIR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJAThAIR"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so41865075e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 02:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424267; x=1770029067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffA5SL3LC5b8XzI2Nz3h29Xpe+4f+LbMdzYhyUIPyHo=;
        b=mJAThAIRB5vma8+LFrfjzgSldPBIyxhQQvfuHMiEMjfZ78RrMU+V/tDTqKoSjXWPkB
         qXKsAAIcgKYFr0rfjQ/cPNXe5uCTKlhkL9yJvUggxt1iLgUSJkfQ1zZFqAlNm2ruSOp8
         lJTVGQtLjYtTq8Yd2UochfOnp0nXRmd29loZy5dNCzSg0Pl65LeKbUi1NtioQflu6YAi
         ySmyQbHSi6MaA9mvl9c2JWcKhZZ0mhq3gGEHhj3sNrN+2xmucR4tduK+pPYkCWA80iki
         f/7c7wW2l/RNH/WwwYDNNPrBvdLXviB/4+IbIEUKEpDObJr0AFOq3hFmQTLOZZJYZWAi
         9TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424267; x=1770029067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffA5SL3LC5b8XzI2Nz3h29Xpe+4f+LbMdzYhyUIPyHo=;
        b=ukBKoYXXpkRXQQyq3bRXNFsnkEGJb/2kRJxeYkLAnnIcrcxAuUdAC7Lw+yIBZr4og+
         97ZVDjFwFbhNKmO9XbYuK8o91aX6YDvVYeqlSxInsNkjQKtNd8HHzZn6dcKX2efvf5Hu
         ShxOrCLN/X/QzSBiBLgeca0zpTtY/ggFWbjaknOXuLleR4SpFqMrJvRbdsE9AZ9gy/u5
         NPv5dOWCHGLuke5aNSkvL3jVv9rNDXgbAPo2jCvs+1lgQi8CzSk4is6612LI1rE8zZT6
         m9WyU8h7yfLXq0vS6/4d15383awu2rJ99IJ9oaBhNdC8/wCnQaQck9C1P9PDPxDyOtb2
         n1RA==
X-Forwarded-Encrypted: i=1; AJvYcCXhSElSttUWhw+s5XWPuyt9TtkI2WdgkAF7aN1m3P0MV12U5VZ5zNy57m6uHEau+ZeIk7b6dYZsivYud7WLraOkGok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNNSVG4ISd2OUAMJ4vR/aQhtZ3iMXNuf0+knKo++XEyusrVsFW
	1ByzjBOvTTpokhbjj25JQ/Npg5ibXnbySsz0DqrWk0qsWGng2KoMdTWfwo7el3N1QUQRYnVOeMh
	g4LqTo/FX290sE98uOFkyJw==
X-Received: from wmbz12.prod.google.com ([2002:a05:600c:c08c:b0:480:4a03:7b6c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35c2:b0:47f:b737:5ce0 with SMTP id 5b1f17b1804b1-4805cf66771mr72717075e9.23.1769424266779;
 Mon, 26 Jan 2026 02:44:26 -0800 (PST)
Date: Mon, 26 Jan 2026 10:43:50 +0000
In-Reply-To: <20260126104419.1649811-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126104419.1649811-2-vdonnefort@google.com>
Subject: [PATCH v10 01/30] ring-buffer: Add page statistics to the meta-page
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
2.52.0.457.g6b5491de43-goog

