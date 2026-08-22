Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493AA31B80E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406847; cv=none; b=ex4337ys9Cbh95BaGskgQzY9vbzybq42W4InvgzUlp2ck56aL6tisBiDablCOMkxYFvS+wWkXMUo5YcWiBbApWbPcyp1/tdEz0nmwZjxwBpQ5aTih9O3yN87cupP936JzZQjnpN6RUgFwwdztQi+kYLpAZuuk6cygnIaPsFQZ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406847; c=relaxed/simple;
	bh=4T4e+dBD9VZFscecYaj+M9GKfaZGdYPdiQhQKoI5Wvo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FWUQ1tNvaIPC7b4nAO0KdpEqj0vwfhA8lJFYBoIoznoJveB9aQiXa55ZedsSWjpcxor28ZDuF4Q5MUD70xyVyafLN+kIE7Rd0pgnAB0J1BpWl2SbzVgCXG4474sCLZj6CuGcgFr0ZWLX5saOr19ZNc1JEEAToy5qCPgaooUd3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CTf11aBC; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CTf11aBC"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955d314945so9785055e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 06:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787406842; x=1788011642; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iy152RdCZfa3BuEh7IM6k3QBkRdl6kOpMlXoFvVNGkU=;
        b=CTf11aBCB9qdAQK4M42Jj2ru/GpO9UgKXxwnDCvOZhvRGG1IR3VYn39JJTZ/KjlXpY
         LGLGOvCjOg5PiMMmnibk7XGvczH4Mi/ouhNLKKRf1Mtcqnry2kgiOcdvsDddRVyNWN39
         no/FEI/i9XEzfLtuY9GNwOU5t/qZ12IrfnDot8Kslzze5i2p9Oj34T3zfKiYSLZb3Qmv
         oMokwMFYIUxeMXXrY0+86kEiFd01Sfzc80GU2oVyZZMZmZNFAD7wo1JQIQpvSvr0RNfk
         qy8CHe6LqianSXNBK3h9ug0h+0mafoA1CZ6KPptEUs1NSgrAvd9RxfVZBPalV7aIWBm8
         r9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787406842; x=1788011642;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iy152RdCZfa3BuEh7IM6k3QBkRdl6kOpMlXoFvVNGkU=;
        b=BEBTuNgKq3i6ow4qd894XC7jSi0XOaZByV1qCMoq8G219+I5VzM++Uhu442+qVs04e
         0jWHvvh+leRVUhA1CWFbAUskQi50AbJ7s4J5Vn9lgfPG1aS+0P7xh6vcBu1la6t+8KnE
         RNGPy7gi4lpFTMgmSOf9vZV0Sn5AzDmLeHtUtXRtkp7dmtc4wqvxMFx8Gak7ncj6rKZ3
         Y9q2lzL117O609xgtkuzoWnrkAbDE/07eQeRid7XpDSij4ht9EFk8fovXLEi+/09IJRw
         u/he4uDuIBXQ1nZgdBQSL0h9Y43cgUr1QEZj6GrcKeYHX18uSJT1l6At4XTB/Ix8f5iP
         Q+/A==
X-Forwarded-Encrypted: i=1; AHgh+RoSkHAvjA88EwBtTEqgdJPAACJE3W4Hq76RSheE8ijZEpSiBbi4tEvTewrwh4qGpLm+TINUBdA3A9s1059YhTLa6sQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nCm+z1QKLT/JOlrI+vySl3+jIgZlIuZOSrvY2CqV/97wvKp/2y
	qkGxiYpHQpcx7l2EwOHJsySMwWhH1WBToAS28AtAxJVeiOh/B3drO4TTgz3d/7dilkkY1/YzSg=
	=
X-Received: from wmbd17.prod.google.com ([2002:a05:600c:58d1:b0:499:c849:1518])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1552:b0:499:49f3:77b1
 with SMTP id 5b1f17b1804b1-499c19ad953mr53970335e9.3.1787406842383; Sat, 22
 Aug 2026 06:54:02 -0700 (PDT)
Date: Sat, 22 Aug 2026 15:53:23 +0200
In-Reply-To: <20260822135323.795946-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260822135323.795946-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2988; i=ardb@kernel.org;
 h=from:subject; bh=B9vd29okea5ocqXwmV5m+3LPo6WPI7iW8XzHP/zdLDo=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIatz5dVpa7gmF+04XHXv0Ldtx/jvSMk88RI+HWdutLtap
 Wi5rVx7RykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIpTSG/xktVZWhn+fx1iX+
 bvjnnZkok/3UO9r1gvf07LoHPi0HXRgZDsyUzJr3gL341aYFm75+/P88IPjPqYkbik+7C0pNn/V YjA0A
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260822135323.795946-12-ardb+git@google.com>
Subject: [RFC PATCH 1/9] mm: execmem: Add API to split an existing execmem
 cache allocation
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In order to permit the module loader to allocate MOD_TEXT and
MOD_INIT_TEXT from the same chunk of memory, add an API function to
execmem that splits an existing execmem cache allocation in two.

This will be used on arm64 to avoid .text and .init.text being placed
far away from each other.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/execmem.h |  9 ++++
 mm/execmem.c            | 44 ++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index 7de229134e30..59bd862cb061 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -178,6 +178,15 @@ void execmem_free(void *ptr);
 
 DEFINE_FREE(execmem, void *, if (_T) execmem_free(_T));
 
+/**
+ * execmem_split - allocate space from an existing execmem cache allocation
+ * @ptr  - the existing execmem cache allocation
+ * @size - the size to carve out from the existing allocation
+ *
+ * Return: the address of the carved out allocation, or %NULL on failure.
+ */
+void *execmem_split(void *ptr, size_t size);
+
 #ifdef CONFIG_MMU
 /**
  * execmem_vmap - create virtual mapping for EXECMEM_MODULE_DATA memory
diff --git a/mm/execmem.c b/mm/execmem.c
index 084a207e4278..6db0c1d82a9d 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -439,6 +439,33 @@ static bool execmem_cache_free(void *ptr)
 	return true;
 }
 
+static void *execmem_cache_split(void *ptr, size_t size)
+{
+	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
+	unsigned long addr = (unsigned long)ptr;
+	MA_STATE(mas, busy_areas, addr, addr);
+	void *area;
+	int err;
+
+	guard(mutex)(&execmem_cache.mutex);
+
+	area = mas_walk(&mas);
+	if (!area)
+		return ERR_PTR(-ENOENT);
+
+	if (size >= mas_range_len(&mas))
+		return ERR_PTR(-EINVAL);
+
+	addr += mas_range_len(&mas) - size;
+	mas_set_range(&mas, addr, mas.last);
+
+	err = mas_store_gfp(&mas, (void *)addr, GFP_KERNEL);
+	if (err)
+		return ERR_PTR(err);
+
+	return (void *)addr;
+}
+
 #else /* CONFIG_ARCH_HAS_EXECMEM_ROX */
 /*
  * when ROX cache is not used the permissions defined by architectures for
@@ -459,6 +486,11 @@ static bool execmem_cache_free(void *ptr)
 {
 	return false;
 }
+
+static void *execmem_cache_split(void *ptr, size_t size)
+{
+	return ERR_PTR(-ENOENT);
+}
 #endif /* CONFIG_ARCH_HAS_EXECMEM_ROX */
 
 void *execmem_alloc(enum execmem_type type, size_t size)
@@ -511,6 +543,18 @@ bool execmem_is_rox(enum execmem_type type)
 	return !!(execmem_info->ranges[type].flags & EXECMEM_ROX_CACHE);
 }
 
+void *execmem_split(void *ptr, size_t size)
+{
+	if (!ptr || !size)
+		return NULL;
+
+	ptr = execmem_cache_split(ptr, size);
+	if (!IS_ERR(ptr))
+		return ptr;
+	VM_WARN_ON(ptr != ERR_PTR(-ENOMEM));
+	return NULL;
+}
+
 static bool execmem_validate(struct execmem_info *info)
 {
 	struct execmem_range *r = &info->ranges[EXECMEM_DEFAULT];
-- 
2.55.0.860.g4b6b3295ed-goog

