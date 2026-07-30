Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212C5372ECB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423807; cv=none; b=YU8WFTafgd/ZI/L8xw+nxfmCBLV3cbzL8G/G0iLMQNgHnpwf0i1HFb/Jz/2MDIkvyfcg8CEONxpTmqOAbm/a+PtPZG4aKASJLaHCpQ43fzWipfdfWDa1semztVHwZiWrEVLJmGUz1YwZbVkLc7Fj09TRB7Cdiqa0P12Zt3D3E3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423807; c=relaxed/simple;
	bh=5MIHgChRNy12kVUm5iWs8ChIekHBsvSP0fhUEXrwf9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/UMnH6zbdTV6EsPRfhD+bGYdmj9IcR87z84mwz5nKxQxm2+hVKWJUCzz8EtlhIVYJWG0ZJUE9R3jdGJiimBEOFfvu2tXCpo6xPbYkTSJHWDOX6FmjtwwjQx8NS+ON+Qz2a6Htw0xaPwiMWptzkwQplhHXEE6tnAoZGC2edC51E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbQsHu3+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbQsHu3+"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so3714217a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785423803; x=1786028603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RepOlA7uegAkHRX0rdEAbivBLVoGLgApQvWSVyuj8bk=;
        b=QbQsHu3+JqhaRjXqsLBTJ+FkpQQ/8mBLgNCsoWNxdfWaESRCjncau+oVJLEb5T0bSi
         VYMTv2+5Bya+2bIy95JGLScHfNlJcSMUzyZrFoqFk1+uFSjFx0jjk74ITUYsSGzLCBgk
         Ayg5cK6a7IXLPFRLphy5dMMqu1aWbcbnCI4UrYdeiRvL84Xb0QeJloTYFQQ6Nio0NjXT
         Fv8+3QS2vB0ORWDhRHjYILRu1iLaGNjNOB8wTO70jtE+07BnIvmx8AY5Ez/tfi0IHuC8
         NXqgAkIZPs+WU+MxzZuOWzqdy/V1X//qanJRfy0nHuq0gPYLxSwK0mUsFJ7Wb2NCgwNL
         9q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785423803; x=1786028603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RepOlA7uegAkHRX0rdEAbivBLVoGLgApQvWSVyuj8bk=;
        b=CcvXHD4hUzPK7Dc/dWYSe40tuIr+yNA5HKyQU4ogTzyCwPfiBMDJc34Min8eeMsSmd
         //nue6sB3iK69hY2/C2GyClwcmyqRSC052UkHhlW8dYPvamoHtZuy+5sjM7aH84CVORg
         z3YaW3x2z2aGJSyEpHXh+ifX6FeaID2NWmRFFG0B6rozqtrQekaxrvV1uVqE9uQRgmJ8
         VBySkdlGjd2dhZwxZlH03A47LkyRExGqXX/bJTgfBlQQWt/SJliQLT1FeGbIrkgjXYOV
         1YrvewjQgFNa0OrkKLT3xQsO3NYes/HnvNMgOO6pZjPirB/93M3ZJnavhB1frSsD5Hbl
         hF5A==
X-Forwarded-Encrypted: i=1; AHgh+RrUkuy6OjEXPtkNn4SVh4vPzV3hQnIqusooCvy11a9frlX/n1/x/1QWVa24S+IxVCKvyofCRh2GOyDVoFXrS9fdOI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtFcQSgDQ7TVhqRt+WH1kL09FBLTLdGbS2R4cWxfnJ02yqpGcm
	C7DG9Gh1XNBXMEIerw6zjfNsoYsz07+RfMPriajB2c9318/cKiXcpgHI
X-Gm-Gg: AR+sD13FJoHvqvN6akGGI2nyO1ukHfm2Cnu0ko2IQ7IpPXDKMQqvP3zKwPPIBngoYBw
	NCLGd+nhMNF4YGeq4r+Se+Rin18Z+2x9AsySLMs1h1UxeVEQH8YILHWg22vxbQP/AqNzU3TxXp6
	vkaS11G7xXieZPqiM2lYFAU/wfiYOoX9S4V4ykqNoT9A9hJtldEiuC6ocrICKkQa99CRuQxSFB4
	3fOfb4DqKn/rQF3MGmsEcLL8P2Mos9WuKJVCoI1tDBn3/8Caar4mzr3JNSPz2DR8a90qjqSD3nA
	lsNh+ImLKsrHa+nJL6x8iO6Id5Y05kMj4bQbT/7qp9P5vBgCAKIf19o48xEqrYZdqD4eg3nMxGy
	VF0/T6NdyKLTqXTWqfZdAg9c1F+Sxsz6JB2cMjmvJVc/TzOe7MIA7SHVMnxtxpBjAWKUTXXj30l
	DQzqCQ3Q+GgfQP+nEZGCAq/uRnlfIoh87E0zPTsXh+URzyQQvOfH/VW11tMnSxePxkyahvrJ3A3
	ngRPzezmY7j1XKc0UpoWwXsPaD80va6mQ==
X-Received: by 2002:a17:906:ee87:b0:c16:318:34e3 with SMTP id a640c23a62f3a-c1fa5457a44mr140525966b.16.1785423803124;
        Thu, 30 Jul 2026 08:03:23 -0700 (PDT)
Received: from [127.0.1.1] (h-62-63-197-109.NA.cust.bahnhof.se. [62.63.197.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a07bf18ff8sm729116a12.0.2026.07.30.08.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:03:22 -0700 (PDT)
From: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Date: Thu, 30 Jul 2026 17:02:57 +0200
Subject: [PATCH RFC v2 1/3] mm, x86: support copying a folio using
 non-temporal stores
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-rfc-nt-demote-v2-1-452dbe3b5073@zptcorp.com>
References: <20260730-rfc-nt-demote-v2-0-452dbe3b5073@zptcorp.com>
In-Reply-To: <20260730-rfc-nt-demote-v2-0-452dbe3b5073@zptcorp.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: David Rientjes <rientjes@google.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <nifan.cxl@gmail.com>, 
 Frank van der Linden <fvdl@google.com>, Jonathan Cameron <jic23@kernel.org>, 
 Raghavendra K T <rkodsara@amd.com>, 
 "Rao, Bharata Bhasker" <bharata@amd.com>, SeongJae Park <sj@kernel.org>, 
 Wei Xu <weixugc@google.com>, Xuezheng Chu <xuezhengchu@huawei.com>, 
 Yiannis Nikolakopoulos <yiannis@zptcorp.com>, dimitrios@palyvos.net, 
 Ryan Roberts <ryan.roberts@arm.com>, Huan Nguyen <nhuhuan@google.com>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>, 
 Alirad Malek <alirad.malek@zptcorp.com>
X-Mailer: b4 0.15.2

From: Alirad Malek <alirad.malek@zptcorp.com>

In x86, use memcpy_flushcache (that uses non-temporal store
instructions) to copy a folio. To achieve that, starting from folio_mc_copy
down to copy_mc_to_kernel, create a series of helpers (named with an _nt
suffix) that have similar behavior to the original counterparts.

Signed-off-by: Alirad Malek <alirad.malek@zptcorp.com>
Co-developed-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Signed-off-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
---
 arch/x86/include/asm/uaccess.h |  4 ++++
 arch/x86/lib/copy_mc.c         | 26 ++++++++++++++++++++++++++
 include/linux/highmem.h        | 32 ++++++++++++++++++++++++++++++++
 include/linux/mm.h             |  1 +
 mm/util.c                      | 17 +++++++++++++++++
 5 files changed, 80 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 367297b188c3..2d0938d3e372 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -494,6 +494,10 @@ unsigned long __must_check
 copy_mc_to_kernel(void *to, const void *from, unsigned len);
 #define copy_mc_to_kernel copy_mc_to_kernel
 
+unsigned long __must_check
+copy_mc_to_kernel_nt(void *to, const void *from, unsigned len);
+#define copy_mc_to_kernel_nt copy_mc_to_kernel_nt
+
 unsigned long __must_check
 copy_mc_to_user(void __user *to, const void *from, unsigned len);
 #endif
diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index 97e88e58567b..5a2ee5c2211e 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -81,6 +81,32 @@ unsigned long __must_check copy_mc_to_kernel(void *dst, const void *src, unsigne
 }
 EXPORT_SYMBOL_GPL(copy_mc_to_kernel);
 
+/**
+ * copy_mc_to_kernel_nt - memory copy that handles source exceptions
+ * if enabled, otherwise uses non-temporal stores
+ * @dst: destination address
+ * @src: source address
+ * @len: number of bytes to copy
+ *
+ * Return 0 for success, or number of bytes not copied if there was an
+ * exception.
+ */
+unsigned long __must_check copy_mc_to_kernel_nt(void *dst, const void *src, unsigned len)
+{
+	unsigned long ret;
+
+	if (copy_mc_fragile_enabled) {
+		instrument_memcpy_before(dst, src, len);
+		ret = copy_mc_fragile(dst, src, len);
+		instrument_memcpy_after(dst, src, len, ret);
+		return ret;
+	}
+
+	memcpy_flushcache(dst, src, len);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(copy_mc_to_kernel_nt);
+
 unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, unsigned len)
 {
 	unsigned long ret;
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index af03db851a1d..a5cb435b9ffe 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -468,6 +468,32 @@ static inline int copy_mc_highpage(struct page *to, struct page *from)
 
 	return ret;
 }
+
+#ifdef copy_mc_to_kernel_nt
+static inline int copy_mc_highpage_nt(struct page *to, struct page *from)
+{
+	unsigned long ret;
+	char *vfrom, *vto;
+
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
+	ret = copy_mc_to_kernel_nt(vto, vfrom, PAGE_SIZE);
+	if (!ret)
+		kmsan_copy_page_meta(to, from);
+	kunmap_local(vto);
+	kunmap_local(vfrom);
+
+	if (ret)
+		memory_failure_queue(page_to_pfn(from), 0);
+
+	return ret;
+}
+#else
+static inline int copy_mc_highpage_nt(struct page *to, struct page *from)
+{
+	return copy_mc_highpage(to, from);
+}
+#endif
 #else
 static inline int copy_mc_user_highpage(struct page *to, struct page *from,
 					unsigned long vaddr, struct vm_area_struct *vma)
@@ -481,6 +507,12 @@ static inline int copy_mc_highpage(struct page *to, struct page *from)
 	copy_highpage(to, from);
 	return 0;
 }
+
+static inline int copy_mc_highpage_nt(struct page *to, struct page *from)
+{
+	copy_highpage(to, from);
+	return 0;
+}
 #endif
 
 static inline void memcpy_page(struct page *dst_page, size_t dst_off,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5be3d8a8f806..d07ce478582d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1644,6 +1644,7 @@ void __folio_put(struct folio *folio);
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
 int folio_mc_copy(struct folio *dst, struct folio *src);
+int folio_mc_copy_nt(struct folio *dst, struct folio *src);
 
 unsigned long nr_free_buffer_pages(void);
 
diff --git a/mm/util.c b/mm/util.c
index b05ab6f97e11..e09e9b5f8eee 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -749,6 +749,23 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
 }
 EXPORT_SYMBOL(folio_mc_copy);
 
+int folio_mc_copy_nt(struct folio *dst, struct folio *src)
+{
+	long nr = folio_nr_pages(src);
+	long i = 0;
+
+	for (;;) {
+		if (copy_mc_highpage_nt(folio_page(dst, i), folio_page(src, i)))
+			return -EHWPOISON;
+		if (++i == nr)
+			break;
+		cond_resched();
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(folio_mc_copy_nt);
+
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
 static int sysctl_overcommit_ratio __read_mostly = 50;
 static unsigned long sysctl_overcommit_kbytes __read_mostly;

-- 
2.43.0

