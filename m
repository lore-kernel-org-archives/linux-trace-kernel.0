Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C21E194A60
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402861; cv=none; b=nco1jA2joKbOjKWosJUzE+xkfOkRawwSdMSvozk2fwEBJpBA844pcxkrrjbQnrHJWxbm6LP4RwpQSbiJh9qu+2V5rnH/JUOwrEpUJq4mazRUuP4hI3VcjzRBlfLvgu9jIOPSYvwev2ILYsWGpw7bpmgBjiIOA0lycovQMf3ClxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402861; c=relaxed/simple;
	bh=VXhc6kuUvVh88rMf6Dfs48+dusU9+NFd7/XvHXsuLFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NMCEuPHG62Q1Vm5mUBAMXuj/ER8kir+NtK0+8TRGM12ZwdHpVHGH6RbIzpcv0YQUviUXnU0sEv7Oltiln22DTFTukibmNpaccqzz8w1gac2cElTXpRHa1AwqcKYhu3dLHx93hxgbcNPohxkDOH2+MU2eedRbXiAGDEmS1xMJC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1BfpOvZd; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1BfpOvZd"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso11917445e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747402858; x=1748007658; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pqHHSd/acUgt02haNYwh+lCiOm/YA61Dyq06MdhKSUs=;
        b=1BfpOvZdLuI6GJiB7nv+T/qb30panCCN3EvudmB3GUml0E1xFn08GivdoUqXhuq0qq
         OvLhFPqOHMTNuSpVjQnbfHy9TAuLXVIZDhO+L1wwiT12JNzRPb2IIztLD9CHAK9caJI+
         Z8xM5NicVeDmB0FjcYAAwWABq0qg8Q5Y8fYCwaBdlb31o0sycgfgjsFv9Q/2aSPRsLHj
         ydUjeje5hy1TSO9vkWeYCSHryHuf2C6BahfJTbrDeTyphEKInSwA/4am0Pd/zyVAQ2o9
         Mv9CqaUbiqbfq5NArDnDkHEbwf5jeVlI7lHaAHLJDU3WlysbS2i48KvqFOcHUPR4Thy5
         pe8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402858; x=1748007658;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqHHSd/acUgt02haNYwh+lCiOm/YA61Dyq06MdhKSUs=;
        b=GAiXvF23EEA5FcKzH1KKzX4S8sEJ0IBULjPMBB6i8+QXY02iXMDib2f6eEPw7YmNnb
         RHupb8PKoQzC0BvJtczpb13gl+fM4D3X9cMLQypSzORYLLalVxVOWDXnO5hevi11jQ+Q
         jMrFnRIA8fhh+s92ZU2EK7igSTUYUD3mCSGTFTqoJ7Qj/lHf0Ja3lUN5zaTi5GXZwGJo
         q+XczYklaWBxYqwrQl70Gd4S0VRaldiqjS7CeHUQGZ31Opb5XVGn53apg/I6gMQqjKm/
         FYsF/Hx5+fyXNUGXdl02VA5PvIkMZH+xejpEtgej4dciyxoqW2vtoTnhWVU17KCbRhPy
         n7sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZdErrrVR4g2T6IgU2vUThi4qlO+Tj7O4JcrF7yLU4RI5XLvYrxzziweOA9o11kVyO4vDyzm0MVvmL8Op8in1/dbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2DUa421zHyseKhws8bvEzZwGmq7aujaBOkurbijdcbadY3P6O
	Bx9NSTqufmN8EzWTWjGIq5TiIl8Re5kErTuMyRc5sOEUnF3bNgnBgh+lpOucfFT8PV1mLAU4Fs+
	XPMIZMYyCCj9YJ4I0pqmDqw==
X-Google-Smtp-Source: AGHT+IERHQk7zgcioL7fmaIDqK4DV/c0A3+lhvu9kgl4ryWQaxYhNaW0ruiCml2zAVK/r7QIv2zASe+SXD169wcB
X-Received: from wmrn6.prod.google.com ([2002:a05:600c:5006:b0:441:bc26:4d3f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:548e:b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-442fefd5f18mr31225325e9.3.1747402858314;
 Fri, 16 May 2025 06:40:58 -0700 (PDT)
Date: Fri, 16 May 2025 14:40:19 +0100
In-Reply-To: <20250516134031.661124-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516134031.661124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250516134031.661124-14-vdonnefort@google.com>
Subject: [PATCH v5 13/25] tracing: load/unload page callbacks for simple_ring_buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add load/unload callback used for each admitted page in the ring-buffer.
This will be later useful for the pKVM hypervisor which uses a different
VA space and need to dynamically map/unmap the ring-buffer pages.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/simple_ring_buffer.h b/include/linux/simple_ring_buffer.h
index d6761dc2f404..e74707f10b93 100644
--- a/include/linux/simple_ring_buffer.h
+++ b/include/linux/simple_ring_buffer.h
@@ -47,4 +47,12 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
 int simple_ring_buffer_enable_tracing(struct simple_rb_per_cpu *cpu_buffer, bool enable);
 int simple_ring_buffer_swap_reader_page(struct simple_rb_per_cpu *cpu_buffer);
 int simple_ring_buffer_reset(struct simple_rb_per_cpu *cpu_buffer);
+
+int __simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer,
+			      struct simple_buffer_page *bpages,
+			      const struct ring_buffer_desc *desc,
+			      void *(*load_page)(unsigned long va),
+			      void (*unload_page)(void *va));
+void __simple_ring_buffer_unload(struct simple_rb_per_cpu *cpu_buffer,
+				 void (*unload_page)(void *));
 #endif
diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index 3efdb895d77a..56b4701979ba 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -64,7 +64,7 @@ static void simple_bpage_reset(struct simple_buffer_page *bpage)
 	local_set(&bpage->page->commit, 0);
 }
 
-static void simple_bpage_init(struct simple_buffer_page *bpage, unsigned long page)
+static void simple_bpage_init(struct simple_buffer_page *bpage, void *page)
 {
 	INIT_LIST_HEAD(&bpage->list);
 	bpage->page = (struct buffer_data_page *)page;
@@ -290,10 +290,15 @@ int simple_ring_buffer_reset(struct simple_rb_per_cpu *cpu_buffer)
 	return 0;
 }
 
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
 
 	/* At least 1 reader page and one head */
@@ -302,15 +307,22 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
 
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
@@ -320,7 +332,13 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
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
 
 		bpage->list.next = &(bpage + 1)->list;
 		bpage->list.prev = &(bpage - 1)->list;
@@ -329,6 +347,14 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
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
 	bpage->list.next = &cpu_buffer->tail_page->list;
 	cpu_buffer->tail_page->list.prev = &bpage->list;
@@ -336,19 +362,46 @@ int simple_ring_buffer_init(struct simple_rb_per_cpu *cpu_buffer, struct simple_
 	/* The last init'ed page points to the head page */
 	simple_bpage_set_head_link(bpage);
 
+	cpu_buffer->bpages = bpages;
+
 	return 0;
 }
 
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
 	cpu_buffer->bpages = 0;
 }
 
+void simple_ring_buffer_unload(struct simple_rb_per_cpu *cpu_buffer)
+{
+	return __simple_ring_buffer_unload(cpu_buffer, __unload_page);
+}
+
 int simple_ring_buffer_enable_tracing(struct simple_rb_per_cpu *cpu_buffer, bool enable)
 {
 	if (!simple_rb_loaded(cpu_buffer))
-- 
2.49.0.1101.gccaa498523-goog

