Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033532E9ED3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764064; cv=none; b=DWUFtMyYiwMHZdR41cOuQAjsC2lUYHttWI2+LFBpjKLJTpXtKEB8e0WQPdwPTpnKF+qDJNfnEmezGpx+PSVEFI/tMvRrCxn09qEazlru8Mfcbajfdq4avIUfY0GPV2Jo1ye9+xGUB1qP1EvnP3n8HEJy/wC+9nKpDIgzshayNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764064; c=relaxed/simple;
	bh=qoDF1ovJLicBrzwJxz32Udbfhq4kyqYKtfXv9oULSqU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gBattzBFF/tRTF5CfqC9UEsiI0lB3a0WHqIGH1sq2PSajv4A7BhceWgBiqJQ+pXQuW1vGs+GOmcpyZ1h0wgvRtKqA72brmjj0lzg1pKdB5qllahEksN+AXyfXMA2SlbetFdU06inKrxCCIzl6nuwqWoYd5wl9N+zOubb1/sB2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x0LOF0/a; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x0LOF0/a"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0cc989so4608295e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764060; x=1756368860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dJOAg2LepmucyL506XIcO8nq6zYHDDz484cJsiMQI5I=;
        b=x0LOF0/aY0wHkDyRj4bxdvKPkz4as5p6kR8B6Ac9EfX/SGzVlaYd34cBtY2USeTcZA
         6uO4HZOCDDM2U+Jn8Ks+vwA+edA1sF248nT/umlKMGF4F4qNLhFxzXlDTpsWUMR4oFGb
         +aH3cTg/ceJ4g3AKl9vf97PZlBMrXNeuSElLu3p5hjdluManD7K0x2o6/XCj6bS2nCmf
         RYVUDh09WYtq9ssQapHYFSGUCvnMovmjJYaNgZtlqsrOIx4rVDua/Pfx73dgsZ7J7Soo
         j3cZ+JTMNVhjwKUT3SG3vmSFXhIAZW+0+zRtN4kwfClVnbh9HFxuuWxI68NhV7NbQHgJ
         DPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764060; x=1756368860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJOAg2LepmucyL506XIcO8nq6zYHDDz484cJsiMQI5I=;
        b=EY9JfVq+sjGABcilwZ1QgDxXN0mRiBBW926EDB43Ug5EaxT6Dx/lEERD0Kz/D/Wmzl
         Z1wyZQmLlJhF+7iVe6N+e1dzZUQDrah7szZKWza6PtW5JbFhwbjf4svce0AEWru6YILn
         P+xsIfkXM5ROnJPhCCkijbaFphYYU9DKrOD161dUPROTLvpMO/5aV895aNCAs86tvj5R
         aqhzUsYyogxiNsKiAtXxdkEp8O3sgSE06r3sP4cJWGxsNx+uVnW02EOZupX4mlJ1JamJ
         dsGY6l62Cyc0IeSOXU4IxozdLNaMEn0L8WQ8JFKqQRgVMNRTCxX5DGbPcNvOOBlmB1nM
         9V9w==
X-Forwarded-Encrypted: i=1; AJvYcCUCXkDSJZuwvRfaRsz9ghcSIhvTNZPwK9pYA2JMFa9NGtkj9HH3LtbwYDbLgrTDju+1awCulQtArjyp88cmKteY5F0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbyjb9Q+QvDRxrI+upG2N57gNkxaSjfil+/83rJkHjVl3STjSG
	CsUG4f5OdA24aMsdKqBs3j97XbekA90DIJl3wKoFQpuLzHWOHzZnvO6Y39ZT1z3MFW+g8l9TsGY
	AHIVRyglViGvxy9RC/JjeTQ==
X-Google-Smtp-Source: AGHT+IHcoqwzyqcPrFsP+sYGNNnfFwMlL/y8NDzxBQBSaC+pxoZobjyvT11sCcSBD4JOgEO+Nyr7sVyBoR8vIUR9
X-Received: from wmqa19.prod.google.com ([2002:a05:600c:3493:b0:459:dbaa:93a6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:358e:b0:459:d3ce:2cbd with SMTP id 5b1f17b1804b1-45b4d7dd79bmr9793685e9.13.1755764060486;
 Thu, 21 Aug 2025 01:14:20 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:13:49 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-2-vdonnefort@google.com>
Subject: [PATCH v6 01/24] ring-buffer: Add page statistics to the meta-page
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
index bb71a0dc9d69..064005c9347e 100644
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
2.51.0.rc2.233.g662b1ed5c5-goog

