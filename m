Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745112;
	b=vv/NZv0l+xPgG6UdpqBke9u5nHn+4CwFZSXdm79WIiVMF4Vhz9WAXSuHFsMVkVzX/ulv
	 QgGeoRi0qz7XLj6b8dOtyOmuMNQysLgwHLKvacyTtnl2TyxLJrZs74GbjARVOgApYVp+w
	 V0cl4yCqWL8nv045FCmGo1XEwIRsttp9kX3YRZCS/NcdAZSi9ujNy841XNlzJzJ6Y0WOZ
	 P5YocDQmTJPGeamNkWNMWmf6BdlhaUeaagq+iHrnNh9C9HuxfpJ+sW8MESxq54EMhcSTQ
	 T+k8M2X8zXYcslQxn9jUC0yMWlP0g698lehwLMyK1IJcCRFQ/arPczWEYT9aqSb9pEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=b1QRyQDO5+0ViUOtVbl2pTjWS8q1UvDtamNlK0wDnbM=;
	b=o5u2p7M73WMqm7zp5CAxf5ASzL3TOGz3fPCjv3A3mvSLsD4DSYYqSKXwSIEnyWu5LUl3
	 x7PV1VZcfndCFrbDLv3aaea6WR4RA3FxqVI7bjP9I/FkxN8LYlZygyt6eytB7WQIGpnlU
	 bY5Zb3K3FcC7+OPVEPUjGZLWB413ykGMsQvFm9JyF/8gVGGFsiulffi78wX/yD8SOSsIL
	 mxJSVm/6X0tpucX0CLjnLa6sbsfEfOXfTezQO4UtPdZ1rqxt8bblwdXzhlRaj7/TQVYky
	 fRm/rJzrnAyEAPy85ae0hEPx3VDdEdbPhS2gRrLUPnp8MVV40jxebI3dsK1xKSN1hhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--nhuhuan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bJyiuFya;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26824606A328
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 22:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26824606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nhuhuan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bJyiuFya
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so49554eec.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Nov 2026 14:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793745111; x=1794349911; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1QRyQDO5+0ViUOtVbl2pTjWS8q1UvDtamNlK0wDnbM=;
        b=bJyiuFyaKi8z+F7FYfiPHCvNqgp24FnmcXdPTXFBwaRp1esH0/LvaqH/65IFd+GC4p
         dw2HjDy6Ri1aHCJNTouvg7i6n5CWpX6qeg2l94tMsF6TANayB5Yba29Crte/3KdP8j7M
         Y1Cvvuk7L70H9dbepktWlh8b4cJYTjt+k2QBwI9Gc4hab9akbLtTXnzR/ukOYXJ9YVVl
         uPOspPemlkzrvSiB1Fg8R6dgkatfbz8HK4vk6HZk2e4rguxkUWVODo3XKMNO0Jk5rMQy
         RMsFGO3gZFfjMtgmn3btmFKmXsuDC28PngTa/YXknmrHH4y7zM3d5Oka8lQD2OMsPk9L
         zOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793745111; x=1794349911;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1QRyQDO5+0ViUOtVbl2pTjWS8q1UvDtamNlK0wDnbM=;
        b=ged+CCro5N92+uBOFTo4qupfB6SNcNnTek7/tluuEAoOLUziZY7Al+CTyS1QGSGaio
         dRR6oLL8DFCCIMKVXe7lB452qdIaa9cZficYA6zkUZRay1whpGuGhxjn8d8lfhFRI1By
         VCjHokNG7hLUYEEoxn6mEkRxegR4ZfNkV5LEP8Ffs8Iu+t7c+smeSHGz4STZB4ArBsJD
         sZSzmHt6i5AuyysPq/2dJ5XN32Tjq9q8FcTt73ZpZwQ/nlHzc0Yyx9jIiDSBeShErwt2
         OTRsVBGqfo5wSSzo/gRqRuUeBjguoGjOv1GwI1q8FG4abdjVF/O1XfVoZd0ACu6XvxLJ
         NNJQ==
X-Forwarded-Encrypted: i=1; AKwUvByYQmHG5Zfpt69OFTZojJ8NMKuPW+VTAvlBnIVCErPOwbX+cYzi14J+UiF7mzl+k55b16JtC7q6KFpbJ7MgQqGjq5w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YZQpsoISGhF7SFp02izLgDx4COQZVSnCGdxOK0iiB+2Fp8Vvn
	SVRDIpvihhVg5pXyeB7Z3CBifu0rZOhncRTREhFpzFy0F+lu4cuFSVP8F0TQLBrPKlz0wBgRkJs
	gDuhpZyHz4g==
X-Received: from dlea11-n1.prod.google.com ([2002:a05:701b:420b:10b0:1a8:14f9:6e3a])
 (user=nhuhuan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1711:b0:1ae:59d6:91d7
 with SMTP id a92af1059eb24-1ae59d6945fmr16251403c88.40.1793745110700; Tue, 03
 Nov 2026 14:31:50 -0800 (PST)
Date: Tue,  3 Nov 2026 14:30:23 -0800
In-Reply-To: <20261103223025.2482227-1-nhuhuan@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260730-rfc-nt-demote-v2-0-452dbe3b5073@zptcorp.com> <20261103223025.2482227-1-nhuhuan@google.com>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261103223025.2482227-2-nhuhuan@google.com>
Subject: [RFC PATCH v3 1/3] mm, x86: support copying a folio using
 non-temporal stores
From: Huan Nguyen <nhuhuan@google.com>
To: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, trondmy@kernel.org, anna@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, jackmanb@google.com, 
	hannes@cmpxchg.org, shivankg@amd.com
Cc: rientjes@google.com, dave@stgolabs.net, nifan.cxl@gmail.com, 
	fvdl@google.com, jic23@kernel.org, rkodsara@amd.com, bharata@amd.com, 
	sj@kernel.org, weixugc@google.com, xuezhengchu@huawei.com, 
	yiannis@zptcorp.com, yiannis.nikolakop@gmail.com, 
	dimitrios.palyvos@zptcorp.com, alirad.malek@zptcorp.com, ryan.roberts@arm.com, 
	nhuhuan@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On x86_64 architecture, copying cold memory folios using standard store
instructions pollutes CPU caches with cold data, increasing memory
latency and bandwidth overhead.

Support machine-check safe non-temporal copying of folios:
- Add copy_mc_page_nt() to copy a 4KiB page using non-temporal stores,
  prefetching, and MCE exception handling.
- Add copy_mc_highpage_nt() to map and copy a 4KiB page.
- Add folio_mc_copy_nt() to copy a folio using copy_mc_highpage_nt().

Because non-temporal stores are weakly ordered, a wmb() is issued at the
end of folio_mc_copy_nt() before page tables are updated to ensure the
new folio contents are globally visible. In the event of task preemption
and CPU migration mid-folio, the scheduler's locked instructions on the
departing CPU serialize and drain earlier stores, while the final wmb()
covers the remainder on the new CPU.

Suggested-by: Alirad Malek <alirad.malek@zptcorp.com>
Suggested-by: Dimitrios Palyvos-Giannas <dimitrios.palyvos@zptcorp.com>
Signed-off-by: Huan Nguyen <nhuhuan@google.com>
---
 arch/x86/include/asm/page_64.h |  2 ++
 arch/x86/lib/copy_page_64.S    | 65 ++++++++++++++++++++++++++++++++++
 include/linux/highmem.h        | 21 +++++++++++
 include/linux/mm.h             |  1 +
 mm/util.c                      | 29 +++++++++++++++
 5 files changed, 118 insertions(+)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 1895c207f629..f37126b56239 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -114,7 +114,9 @@ static inline void clear_page(void *addr)
 	clear_pages(addr, 1);
 }
 
+#define __HAVE_ARCH_COPY_PAGE_NT 1
 void copy_page(void *to, void *from);
+unsigned long copy_mc_page_nt(void *to, const void *from);
 KCFI_REFERENCE(copy_page);
 
 /*
diff --git a/arch/x86/lib/copy_page_64.S b/arch/x86/lib/copy_page_64.S
index d8e87fedc20d..185fa3bc34c0 100644
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -6,6 +6,7 @@
 #include <linux/cfi_types.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
+#include <asm/asm.h>
 
 /*
  * Some CPUs run faster using the string copy instructions (sane microcode).
@@ -88,3 +89,67 @@ SYM_FUNC_START_LOCAL(copy_page_regs)
 	addq	$2*8, %rsp
 	RET
 SYM_FUNC_END(copy_page_regs)
+
+/*
+ * Copy an entire 4KB page using non-temporal stores (movnti).
+ * Returns 0 on success, or number of bytes not copied on error.
+ */
+SYM_TYPED_FUNC_START(copy_mc_page_nt)
+	subq	$2*8, %rsp
+	movq	%rbx, (%rsp)
+	movq	%r12, 1*8(%rsp)
+
+	xorl	%eax, %eax
+	.p2align 4,,10
+	.p2align 3
+
+.L_nt0:	movq	0x8*0(%rsi,%rax), %rdx
+.L_nt1:	movq	0x8*1(%rsi,%rax), %rcx
+.L_nt2:	movq	0x8*2(%rsi,%rax), %rbx
+.L_nt3:	movq	0x8*3(%rsi,%rax), %r8
+.L_nt4:	movq	0x8*4(%rsi,%rax), %r9
+.L_nt5:	movq	0x8*5(%rsi,%rax), %r10
+.L_nt6:	movq	0x8*6(%rsi,%rax), %r11
+.L_nt7:	movq	0x8*7(%rsi,%rax), %r12
+
+	prefetchnta 5*64(%rsi,%rax)
+
+	movnti	%rdx, 0x8*0(%rdi,%rax)
+	movnti	%rcx, 0x8*1(%rdi,%rax)
+	movnti	%rbx, 0x8*2(%rdi,%rax)
+	movnti	%r8,  0x8*3(%rdi,%rax)
+	movnti	%r9,  0x8*4(%rdi,%rax)
+	movnti	%r10, 0x8*5(%rdi,%rax)
+	movnti	%r11, 0x8*6(%rdi,%rax)
+	movnti	%r12, 0x8*7(%rdi,%rax)
+
+	addq	$64, %rax
+	cmpq	$4096, %rax
+	jne	.L_nt0
+
+	movq	(%rsp), %rbx
+	movq	1*8(%rsp), %r12
+	addq	$2*8, %rsp
+	xorl	%eax, %eax
+	RET
+
+.E_nt:
+	negl	%eax
+	addl	$4096, %eax
+	sfence
+	movq	(%rsp), %rbx
+	movq	1*8(%rsp), %r12
+	addq	$2*8, %rsp
+	RET
+
+	_ASM_EXTABLE_TYPE(.L_nt0, .E_nt, EX_TYPE_DEFAULT_MCE_SAFE)
+	_ASM_EXTABLE_TYPE(.L_nt1, .E_nt, EX_TYPE_DEFAULT_MCE_SAFE)
+	_ASM_EXTABLE_TYPE(.L_nt2, .E_nt, EX_TYPE_DEFAULT_MCE_SAFE)
+	_ASM_EXTABLE_TYPE(.L_nt3, .E_nt, EX_TYPE_DEFAULT_MCE_SAFE)
+	_ASM_EXTABLE_TYPE(.L_nt4, .E_nt, EX_TYPE_DEFAULT_MCE_SAFE)
+	_ASM_EXTABLE_TYPE(.L_nt5, .E_nt, EX_TYPE_DEFAULT_MCE_SAFE)
+	_ASM_EXTABLE_TYPE(.L_nt6, .E_nt, EX_TYPE_DEFAULT_MCE_SAFE)
+	_ASM_EXTABLE_TYPE(.L_nt7, .E_nt, EX_TYPE_DEFAULT_MCE_SAFE)
+
+SYM_FUNC_END(copy_mc_page_nt)
+EXPORT_SYMBOL_GPL(copy_mc_page_nt)
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index d7aac9de1c8a..264b3f109151 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -484,6 +484,27 @@ static inline int copy_mc_highpage(struct page *to, struct page *from)
 }
 #endif
 
+#ifdef __HAVE_ARCH_COPY_PAGE_NT
+static inline int copy_mc_highpage_nt(struct page *to, struct page *from)
+{
+	unsigned long ret;
+	char *vfrom, *vto;
+
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
+	ret = copy_mc_page_nt(vto, vfrom);
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
+#endif
+
 static inline void memcpy_page(struct page *dst_page, size_t dst_off,
 			       struct page *src_page, size_t src_off,
 			       size_t len)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9f167950926a..549bb21027e4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2127,6 +2127,7 @@ void __folio_put(struct folio *folio);
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
 int folio_mc_copy(struct folio *dst, struct folio *src);
+int folio_mc_copy_nt(struct folio *dst, struct folio *src);
 
 unsigned long nr_free_buffer_pages(void);
 
diff --git a/mm/util.c b/mm/util.c
index 8acfe2148ba5..0418529264fd 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -778,6 +778,35 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
 }
 EXPORT_SYMBOL(folio_mc_copy);
 
+int folio_mc_copy_nt(struct folio *dst, struct folio *src)
+{
+	long nr = folio_nr_pages(src);
+	long i = 0;
+
+	for (;;) {
+#ifdef __HAVE_ARCH_COPY_PAGE_NT
+		if (copy_mc_highpage_nt(folio_page(dst, i), folio_page(src, i)))
+			return -EHWPOISON;
+#else
+		if (copy_mc_highpage(folio_page(dst, i), folio_page(src, i)))
+			return -EHWPOISON;
+#endif
+		if (++i == nr)
+			break;
+		cond_resched();
+	}
+
+#ifdef __HAVE_ARCH_COPY_PAGE_NT
+	/*
+	 * Drain weakly ordered non-temporal stores before the folio
+	 * is published.
+	 */
+	wmb();
+#endif
+	return 0;
+}
+EXPORT_SYMBOL(folio_mc_copy_nt);
+
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
 static int sysctl_overcommit_ratio __read_mostly = 50;
 static unsigned long sysctl_overcommit_kbytes __read_mostly;
-- 
2.56.0.398.g882cbad275-goog

