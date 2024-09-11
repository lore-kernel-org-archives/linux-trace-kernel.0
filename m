Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D09A186E4A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047070; cv=none; b=mnDN3PMjN0Zwy8ahTTB8ZDx6REb6V+QTDupqrwES6rLDd4KzQv9KxVbeboCoZec8ckgOL5KfYSvCHjcCGz0pY785zp4VwtcudCcVxR4DXTZHWMVnweUZ14sk67HYjsmerlJmv1VDSpiLUwJzzpTbk0nTW3daCtoQZqsrJi27hHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047070; c=relaxed/simple;
	bh=+C1Mr6Eih+8GBOgaIA5ob9ph+NaEjJpwr6bdsWTV2h4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kztnGNsqrpKpbKQvQZLyXX3sKaOsb9cEz5Q5PRf6tubPPr/+qaiBb676SEcN2u0ruqmigv6XaIabPO82BYaK8cs5Sku8XcPHNrK3q9UbbNnbU9RFaVGrwGTcoA7cvZJTqbocb51bpikCZfR2qbR76Q/Ix4qiZBzPr2ioUV7Zt+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GlRSAQrM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GlRSAQrM"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6db791c41dfso94804047b3.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726047068; x=1726651868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hy3Znb+Dwqyrq2cJ7HorL7uStGBaHWkuWbAR2JZBqCQ=;
        b=GlRSAQrMLl9xezMp6rRpHOu9JtlWFUzKoSiibUpP7rGvE2SZVIgQ7KAQy6m+brYwFw
         ZqU6VkcOZPsY/YYDAWxUfrZF/ydUPNdk11IZfgWYcoW4/suK/moxAOoSHolU7Bs5GWAf
         1aqKvP4ODFdzvqEShL9ZYlfWgfkPDFY/yTtMf/TqhI7QsHCn3UH4UkTot3uC/LvQhJdJ
         SkoDnaSwM62L9hlZaqOU+ql+uEpsDgybU0nawe+QhZIT/rsh9uHSZNVrs57hIhVLe44R
         3gEQuO4wA71uJegylG8Uotd4VivPO/VgceYvbRmAztr+1/P51tl3OlhhSC+cdyNFLRxa
         +ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047068; x=1726651868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hy3Znb+Dwqyrq2cJ7HorL7uStGBaHWkuWbAR2JZBqCQ=;
        b=FnDXo1vGZoT2ixQf0m7rjGih18M6UNSy7jYB1772wZixzN6CaW4leeTMDApOoQNtLv
         go7WeF7/ViCPI35j8OmiHA/3h2o7TxqBfOHUiO1MUHQbnm0Ghj0aiIDOGSeaT201fb1q
         qZKK/BR1VK1JF+V9r2u7zzWj3WqftFNQnukkk9mbzKSJGN80tL8DKQil6rGz6Ude3xG0
         nfzWHG1DzWKuo1xbTOUe0G//ukC0tpNPayN+KMk1l5mmGI0oQEKU6zbOCkcptARcHnEy
         X7KYuERDdR/pw19lyBX3qCIuPs96tSW2DV1NaO2faui+TUu5n6TEfEG+5SE8C51GZ2L7
         GE/A==
X-Forwarded-Encrypted: i=1; AJvYcCUfaUJnqt+iOpm318/x9fr8QkbnhZ+xl1yMEqLtxj04NfmH++aWF8TStFLMPtith4TBnzJr8PcoDSjlir5q9pUkvKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpVT/BUpeYK0FR0hjtU20A3ZRWXav4ocNug3NgKDPwcJnmJvbE
	F9LatBiq5QxWtVvG44qBhot0o2zWpnrE6X1KuaC+dvllJJm4ZNj5oW8t9OrwAD/t1R976CEsb9h
	4kenv5nCtmXm9eSNUDw==
X-Google-Smtp-Source: AGHT+IFSAGx//hRZK4AAM97oklvEIfq79G7ievWf/yDgvOrEXJqZ7cy+6snJMt8gT5Wm1/gNBfGcYxIfKSWjx/Ue
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:2f89:b0:6be:9d4a:f097 with
 SMTP id 00721157ae682-6db452739d0mr2138547b3.7.1726047068233; Wed, 11 Sep
 2024 02:31:08 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:30:26 +0100
In-Reply-To: <20240911093029.3279154-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911093029.3279154-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911093029.3279154-11-vdonnefort@google.com>
Subject: [PATCH 10/13] KVM: arm64: Add raw interface for hyp tracefs
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev
Cc: kvmarm@lists.linux.dev, will@kernel.org, qperret@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The raw interface enables userspace tools such as trace-cmd to directly
read the ring-buffer without any decoding by the kernel.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 1720daeda8ae..0d0e5eada816 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -740,6 +740,86 @@ static const struct file_operations hyp_trace_pipe_fops = {
 	.llseek         = no_llseek,
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
+	.llseek         = no_llseek,
+};
+
 static int hyp_trace_clock_show(struct seq_file *m, void *v)
 {
 	seq_puts(m, "[boot]\n");
@@ -794,6 +874,9 @@ int hyp_trace_init_tracefs(void)
 
 		tracefs_create_file("trace_pipe", TRACEFS_MODE_READ, per_cpu_dir,
 				    (void *)cpu, &hyp_trace_pipe_fops);
+
+		tracefs_create_file("trace_pipe_raw", TRACEFS_MODE_READ, per_cpu_dir,
+				    (void *)cpu, &hyp_trace_pipe_fops);
 	}
 
 	return 0;
-- 
2.46.0.598.g6f2099f65c-goog

