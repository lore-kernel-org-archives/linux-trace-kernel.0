Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5C2306489
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424286; cv=none; b=ukbatIBH/TZFMobPYk/jNk1LzeOuwlMHUxZBlUhrn9r1jiO4fBsZh3CdIyNBbRvhlNcpUptrUPB5AmDHPAsuBxekTy3hKfHnmUiAEJ8vMfYNssEYithlW49u1YHugAn9BUlQRgpET9cYQTNsPXUUN9bWVpQ7BQ44s85f+7YrtzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424286; c=relaxed/simple;
	bh=xjEuSksDJKSQNNkYquEsLCni1hW+QLCJE9z+GY0XPL8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=siXxhjDlmNU3bS+FHAw0nL/yeuqjF79i1OvVhexNn1TkX7Wy98l3vtiNfJJrig4uk5UcUxFXeBpWqFhQde/F56gbKhFfgub1144MBgaCqA4i/6G1OlUsuAkQtg4HYayXVgMZ4qp+bg7KFSVV6YUUyjsUk2BlyTzNiOoQQ88NMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vOrYLh53; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vOrYLh53"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47d62cc05daso42137255e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 02:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424281; x=1770029081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bAuB0YdbnPC1gHE5GkC16j+FeJhoKW2PjTnj9gON1mU=;
        b=vOrYLh533lyEZxyckZlCzWqIJvhj0R12H9tiYB3ty0Q/auFPQg4qNwStLkJKOwZXCe
         1eNpFcggHDjJsdyAbnYA0l84M5h1ndGdhGQt1J2p42cXr6LOZJrrlk4Q3JdfopsosHVV
         t7HRPNPisfvN3wul3Fr9bTujnDA+S8lMUpFT1G9qeKSn6lZ7Immh97Nwb6IHZewZ0y2s
         jzB7S8W+EEFGAw4cODUMcrybouX9r0Xk2LsYwzpVjvDWYW9osven0ClZSGFKNJea/F1B
         6/gGflqUjqc+RJ4/EcB5L5Y1YvQU60KIW5LH7S4Ls9HbfZwt5k8elQ0b+pQyAne9lRMI
         JZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424281; x=1770029081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAuB0YdbnPC1gHE5GkC16j+FeJhoKW2PjTnj9gON1mU=;
        b=wjTn7ViHi6GVxx7ij42VVuXlfQyi+ZO15ARgf7Cx6lXZ/5b72J4/IseeDM07iK9Uc1
         yarF+DlBLq8Tb5AGEZ6Piw3fkLaA5qEXHArCYQ+ptHO8xuhQm2azJZUBvsba1Eip2JeA
         87rZddJvKaIb6CW13jdcIdeo/HM5VXq7G5O7T3sAAfOsIW5jso+utDmgjmYKfhGdpYkJ
         S/3ZenimtFhCMVdIHLyK1LooplBGUDB+B1wqu6jUucag9NlhCas+eOGWn2d3v4Tc2LNd
         ZSHJKLpfae94Ue5I23Jg1Jl/ZzF9XdaUweCFO9bwQKYGAmq0SL45klAPKpNeZDFA6MEz
         G30A==
X-Forwarded-Encrypted: i=1; AJvYcCXLf4Ty/3290vvnJWm8bJDPb58AV1QAFCu6rXZUnmlWLCQ5nq6YxE74FsAR9x5KWfNOCA9XOy7x5rTPkgxn3b2+3c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQV6CcZMMy9z0RsSkrGE4ADY+kD/RwuDy0pRZmabLFFK+av3hn
	e0WWgz9F8n4L/edUSI/NWpiQ8yUIbsjbALsN1IOAizq/Y8lqtedaUzTj5aDIIfD8kHb6FSzrc0c
	dwu6sU5t6KS+p8Wp4bMvRxQ==
X-Received: from wmlf26.prod.google.com ([2002:a7b:c8da:0:b0:47e:e722:72e4])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a05:b0:47e:e952:86ca with SMTP id 5b1f17b1804b1-4805ce3fcfemr73650335e9.2.1769424281349;
 Mon, 26 Jan 2026 02:44:41 -0800 (PST)
Date: Mon, 26 Jan 2026 10:44:06 +0000
In-Reply-To: <20260126104419.1649811-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126104419.1649811-18-vdonnefort@google.com>
Subject: [PATCH v10 17/30] tracing: load/unload page callbacks for simple_ring_buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add load/unload callback used for each admitted page in the ring-buffer.
This will be later useful for the pKVM hypervisor which uses a different
VA space and need to dynamically map/unmap the ring-buffer pages.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/simple_ring_buffer.h b/include/linux/simple_ring_buffer.h
index f324df2f875b..ecd0e988c699 100644
--- a/include/linux/simple_ring_buffer.h
+++ b/include/linux/simple_ring_buffer.h
@@ -110,4 +110,11 @@ int simple_ring_buffer_reset(struct simple_rb_per_cpu *cpu_buffer);
  */
 int simple_ring_buffer_swap_reader_page(struct simple_rb_per_cpu *cpu_buffer);
 
+int __simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer,
+			      struct simple_buffer_page *bpages,
+			      const struct ring_buffer_desc *desc,
+			      void *(*load_page)(unsigned long va),
+			      void (*unload_page)(void *va));
+void __simple_ring_buffer_unload(struct simple_rb_per_cpu *cpu_buffer,
+				 void (*unload_page)(void *));
 #endif
diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index 1d1f40c8c6d8..f01386975266 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -71,7 +71,7 @@ static void simple_bpage_reset(struct simple_buffer_page *bpage)
 	local_set(&bpage->page->commit, 0);
 }
 
-static void simple_bpage_init(struct simple_buffer_page *bpage, unsigned long page)
+static void simple_bpage_init(struct simple_buffer_page *bpage, void *page)
 {
 	INIT_LIST_HEAD(&bpage->link);
 	bpage->page = (struct buffer_data_page *)page;
@@ -342,10 +342,15 @@ int simple_ring_buffer_reset(struct simple_rb_per_cpu *cpu_buffer)
 }
 EXPORT_SYMBOL_GPL(simple_ring_buffer_reset);
 
-int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_buffer_page *bpages,
-			    const struct ring_buffer_desc *desc)
+int __simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer,
+			      struct simple_buffer_page *bpages,
+			      const struct ring_buffer_desc *desc,
+			      void *(*load_page)(unsigned long va),
+			      void (*unload_page)(void *va))
 {
 	struct simple_buffer_page *bpage = bpages;
+	int ret = 0;
+	void *page;
 	int i;
 
 	/* At least 1 reader page and two pages in the ring-buffer */
@@ -354,15 +359,22 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
 
 	memset(cpu_buffer, 0, sizeof(*cpu_buffer));
 
-	cpu_buffer->bpages = bpages;
+	cpu_buffer->meta = load_page(desc->meta_va);
+	if (!cpu_buffer->meta)
+		return -EINVAL;
 
-	cpu_buffer->meta = (void *)desc->meta_va;
 	memset(cpu_buffer->meta, 0, sizeof(*cpu_buffer->meta));
 	cpu_buffer->meta->meta_page_size = PAGE_SIZE;
 	cpu_buffer->meta->nr_subbufs = cpu_buffer->nr_pages;
 
 	/* The reader page is not part of the ring initially */
-	simple_bpage_init(bpage, desc->page_va[0]);
+	page = load_page(desc->page_va[0]);
+	if (!page) {
+		unload_page(cpu_buffer->meta);
+		return -EINVAL;
+	}
+
+	simple_bpage_init(bpage, page);
 	bpage->id = 0;
 
 	cpu_buffer->nr_pages = 1;
@@ -372,7 +384,13 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
 	cpu_buffer->head_page = bpage + 1;
 
 	for (i = 1; i < desc->nr_page_va; i++) {
-		simple_bpage_init(++bpage, desc->page_va[i]);
+		page = load_page(desc->page_va[i]);
+		if (!page) {
+			ret = -EINVAL;
+			break;
+		}
+
+		simple_bpage_init(++bpage, page);
 
 		bpage->link.next = &(bpage + 1)->link;
 		bpage->link.prev = &(bpage - 1)->link;
@@ -381,6 +399,14 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
 		cpu_buffer->nr_pages = i + 1;
 	}
 
+	if (ret) {
+		for (i--; i >= 0; i--)
+			unload_page((void *)desc->page_va[i]);
+		unload_page(cpu_buffer->meta);
+
+		return ret;
+	}
+
 	/* Close the ring */
 	bpage->link.next = &cpu_buffer->tail_page->link;
 	cpu_buffer->tail_page->link.prev = &bpage->link;
@@ -388,21 +414,48 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
 	/* The last init'ed page points to the head page */
 	simple_bpage_set_head_link(bpage);
 
+	cpu_buffer->bpages = bpages;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(simple_ring_buffer_init);
 
-void simple_ring_buffer_unload(struct simple_rb_per_cpu *cpu_buffer)
+static void *__load_page(unsigned long page)
 {
+	return (void *)page;
+}
+
+static void __unload_page(void *page) { }
+
+int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_buffer_page *bpages,
+			    const struct ring_buffer_desc *desc)
+{
+	return __simple_ring_buffer_init(cpu_buffer, bpages, desc, __load_page, __unload_page);
+}
+
+void __simple_ring_buffer_unload(struct simple_rb_per_cpu *cpu_buffer,
+				 void (*unload_page)(void *))
+{
+	int p;
+
 	if (!simple_rb_loaded(cpu_buffer))
 		return;
 
 	simple_rb_enable_tracing(cpu_buffer, false);
 
+	unload_page(cpu_buffer->meta);
+	for (p = 0; p < cpu_buffer->nr_pages; p++)
+		unload_page(cpu_buffer->bpages[p].page);
+
 	cpu_buffer->bpages = NULL;
 }
 EXPORT_SYMBOL_GPL(simple_ring_buffer_unload);
 
+void simple_ring_buffer_unload(struct simple_rb_per_cpu *cpu_buffer)
+{
+	return __simple_ring_buffer_unload(cpu_buffer, __unload_page);
+}
+
 int simple_ring_buffer_enable_tracing(struct simple_rb_per_cpu *cpu_buffer, bool enable)
 {
 	if (!simple_rb_loaded(cpu_buffer))
-- 
2.52.0.457.g6b5491de43-goog

