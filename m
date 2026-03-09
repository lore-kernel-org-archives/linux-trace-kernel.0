Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0510D3BD63E
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073564; cv=none; b=Ge0Ro682xapWJa7t8uY0QPYQOM9KpvPT4MYrU9bRy0LTXiSdc0U7xOzs366UTLJ1uNNjiieNcVKDFH/migjh4HP5GDHg4XMKkTGT5vKVEX9K4vZBqxxyeia5E0LkAA8Z2nErPNzb2CZLPdiH4IZaGa74sdfp3n+wCNM6d6PKvWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073564; c=relaxed/simple;
	bh=nIPFmzqx2PgFsl5ulyTbEA9D1hoahr/PTdGwgGFM0/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y26Dc9I0Vs7LpWl3pttMAEhBh+vZ4i4mTK5hdg4zF5xGOjjgRtyKZCq3bni4xl8cNjp4TFTjUSPq5ieC/C/BiFAVlz2I/9gHusOOwrjiAATr3IOhPPRxMhAc/r+moqlyAMqugDYr8sNaPHRlfBVIuZtWJe1zrOmwWvfp+fKby0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fhHWdTXl; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fhHWdTXl"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-661aae3a881so5324640a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Mar 2026 09:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773073561; x=1773678361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tqn5G0/qxFsd1rBMaP6ON3DnSHbXMjD+lZjYLddNIoQ=;
        b=fhHWdTXleDCMmfkiRjo2vlRcDbxMjko4I006oVMlMy2w6YS1oli4JugSKMmk1w2oki
         Kkzq3JAwAPom4997efYuCHoPAdy0xVleszR9sIiYOBKbPAMeG8mAcW4ztZortRpPla09
         cbChjaGsiP4+O8TQOPQTpM6QbNh+tlQ51TmJ6/K/eFNUhRnnY6elwgtPkjMovWcYC1mw
         0uzMO9+5uneIS8RzrmredRyObPLqPHP2JdJcLjSJ92R7UleieoOBAo0EPECZ0eZ48lrX
         QLc77GE5QgqYNInuo2MDPn4yv9N7q25kyoV3aFliyS3LsZSTweQQ45GGgdgClB5Pnzj+
         t7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073561; x=1773678361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tqn5G0/qxFsd1rBMaP6ON3DnSHbXMjD+lZjYLddNIoQ=;
        b=hJloHE2UFq25d33dMkhXGGZAOTDCQthPT96lWAb2/9GQ7nhJQ4M2Tz56Z+nIxzXb3/
         caP23ShCdBsyYWUuL3HXi2C4FFpdZc8noj9txt6QiroO2EWVjyp0t/nRdm1uRhUvJcNI
         TmBhvmk8fxWYheNStZ76Ew7w/pZp26hntrQ35oq9pfQ6Sk2VOz+sFat4QVK5gZ2duhVP
         E1pa/yyHDigJZFGbgc1ySVaVheHhPSB9iHmhkQ3i9bDtdg8Ek8gXYkI33UkzCXa+se+i
         lHFtjc7EnTeQvfzNGvGkFAF028LFNFhwg/DbRRfvqA9imJMZIQ7wUC+xUvdMci90rPyu
         /K6w==
X-Forwarded-Encrypted: i=1; AJvYcCUVeV1fbwFVmopLiRJBvwSZrX7WXJTAU0ZiZe3kzN1oQli7w4qaRJukMcOm6MkWypR1eJpwN7DF9fjbM5RR6vADams=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+uF4OIjOHFfzFNpFBYoKY2YZm8jrGmAJjfCI/DsYJsBeHyaDO
	DWF7hUI6nDPs5FTvbW4LxWjgFkaOoQW6yW7hfxQsLCw44vGAe3hQZxIHIMdRog4sP0NruzofrQg
	SMNxHg9+9oX2O89iAj2+HNA==
X-Received: from edro9.prod.google.com ([2002:aa7:d3c9:0:b0:660:ed52:a77c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:430c:b0:662:ac7e:aabe with SMTP id 4fb4d7f45d1cf-662ac7ead72mr637065a12.15.1773073561283;
 Mon, 09 Mar 2026 09:26:01 -0700 (PDT)
Date: Mon,  9 Mar 2026 16:24:47 +0000
In-Reply-To: <20260309162516.2623589-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309162516.2623589-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309162516.2623589-2-vdonnefort@google.com>
Subject: [PATCH v14 01/30] ring-buffer: Add page statistics to the meta-page
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
index 17d0ea0cc3e6..82b4df579670 100644
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

