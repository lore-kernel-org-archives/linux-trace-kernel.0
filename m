Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9BD2063C6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336109; cv=none; b=ecs+yzJtzYhTxUvQS3uRoTzP3mBbDNjW6ejmohG1wK7lfyARIPda9Psb/sZqkvrl3VHrfcs94Zh/FrzbE/KuZBQgTvaOwSBB3qNy69Fz6etJ+hhQ8dJLJnb1Q0CeEUEIcDNEV9lGBtK596g/vwrCd3ftgc8ilUAeYN91VSBeXv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336109; c=relaxed/simple;
	bh=9o1sGRawhMhE83lK347pgMnxLiJgYGjZ2/N4XtWqcOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Of85RoMDgjs84426SUTOjdaNeRHP/B3rzPvUq8Ett9Zf6cNrYms38DE0MRJYJivpdQbeKRImfz6xSgEULd6x1YEZGz2OyrlFlDvCsgtxggczj/IwLtSskiSlgHGl33Po5TG5jaX+cgMTnk8KQuNc79TuycoS86MJZX6j4ZlbquM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpBgQMJl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpBgQMJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742336107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBMqWWSmA8jTU5EpZWWLoWgjipzuL5yIrBN/CPUgt3Q=;
	b=hpBgQMJlPyqLhvqrw7o3OUsuMW3a8CZOOSHMYK1lBfL52rwwHqtfizlXXom1qcsi6ZLBmC
	T5G9hDjGj+73PzJqYuMazl6XckV56tgj9c7KMCbhdHrssacBanqRQ8dnQLOqckI1TTrcA2
	NXFFMcowNrgu/TnvQsMuVXvoefbt/w4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-7g03T4l8MgCdPjarjHdxQQ-1; Tue, 18 Mar 2025 18:15:05 -0400
X-MC-Unique: 7g03T4l8MgCdPjarjHdxQQ-1
X-Mimecast-MFC-AGG-ID: 7g03T4l8MgCdPjarjHdxQQ_1742336104
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so23896245e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742336104; x=1742940904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBMqWWSmA8jTU5EpZWWLoWgjipzuL5yIrBN/CPUgt3Q=;
        b=FAszoxC4S6R9TPRmjdHkLUB27qhJ5tj+b7IuIMa/2eIb65AYv5FcuBeozYGXQMGMtP
         FqY1xTjs4t/5+7Of9kodwmEapZPYIpiKJkqG2xAHOdlm50yDxYWsEJtOfHhCOGmoN8aC
         NZB5qhuSQBhLOwTIrJHh7q0X+0ZaTuDlJJFRWoEDdJJ6fxDiFzNy920oFtSkMa9tOXj6
         nVTzefJ8fM67GTk+KxUFsPWCC0udGcBh/pwHDws9MhJCAFMwyFgQoVV4geeZNEzZgd89
         0cHExQdXx1Wk+Y1AQwiwroHUa+vaeDw3+asQ6LBfTivb+fmUNJGLb9do74n4pPsrhB5Z
         sqNg==
X-Forwarded-Encrypted: i=1; AJvYcCXKsimUooV+t2g0J6bOPfYQ7rFZu2Nro/tsj2exMO94YEl2T8qqtRgcLLcDe0gwG9GRofklISQh7+WBnYjM77f4XFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7qL3j8WbqXfYIFyOz105rfF1OYAhB6N5/bgqlgMi/CofK0vLT
	2vNeocP7sNIzXW5jgEsUaSnjF348eaxsLCujfeS2rvRf7+w7wuldOGS9GReKXWuAsD68BxhK2Rn
	1nnkUZmbTi/+ZDil6F33b3IMTueIP6p44nb41upYF/ijd20JelgPUtIu7thC4GZYL+VUkzw==
X-Gm-Gg: ASbGncuPwo/WMGzKsAuFrlYsXhlea6JQ9KV8yvdf0MajMkpH3iyIIjU2iW0pUw3KsMg
	yrOtzB2Uktwk5PL17quFq7s848fDM3r/GTnoT3BQPuz5D1uw2HGQ971T1x+jPPjAZXoiK1sIoSs
	XdoZzvDLzZQ6nEz5W2Zo8JPT8W6JxtIfPQ46H6sfEMgPUEvBHcB8ACikZP/Y44kH8JplBSdGpv8
	Dgq+ju2HPks6AvzYSRKKNL3Wx5iwgezhgZ7BDqpzm8zHvyqG8d1Q6BGL4OkvU6gGRE4lXXaXbU6
	XBKPVO+nStR+fXXE3zgf0bMTvLVT97kK95EAQrgIhNaObjWSugKfdIQZwlYU6kCeT/PARG0gdU0
	J
X-Received: by 2002:a5d:47ca:0:b0:391:47d8:de3d with SMTP id ffacd0b85a97d-399739bc959mr401443f8f.16.1742336103820;
        Tue, 18 Mar 2025 15:15:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVLQM9GTMoKWmV/uO8RTwFHvBEBsZ0wjM+Jkn+TplyWph+3HhlRdj3hBn4fJ8DOgl1P3A6xg==
X-Received: by 2002:a5d:47ca:0:b0:391:47d8:de3d with SMTP id ffacd0b85a97d-399739bc959mr401407f8f.16.1742336103412;
        Tue, 18 Mar 2025 15:15:03 -0700 (PDT)
Received: from localhost (p200300cbc72d250094b54b7dad4afd0b.dip0.t-ipconnect.de. [2003:cb:c72d:2500:94b5:4b7d:ad4a:fd0b])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cbbc88f2sm19281199f8f.101.2025.03.18.15.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 15:15:02 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH v2 2/3] kernel/events/uprobes: pass VMA to set_swbp(), set_orig_insn() and uprobe_write_opcode()
Date: Tue, 18 Mar 2025 23:14:56 +0100
Message-ID: <20250318221457.3055598-3-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318221457.3055598-1-david@redhat.com>
References: <20250318221457.3055598-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q7VVWbY7ZKy31yPEzhvgNzaqQbXT8Ybj8wa1xa4mS3k_1742336104
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We already have the VMA, no need to look it up using
get_user_page_vma_remote(). We can now switch to
get_user_pages_remote().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm/probes/uprobes/core.c |  4 ++--
 include/linux/uprobes.h        |  6 +++---
 kernel/events/uprobes.c        | 33 +++++++++++++++++----------------
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index f5f790c6e5f89..885e0c5e8c20d 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -26,10 +26,10 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
 		(UPROBE_SWBP_ARM_INSN & 0x0fffffff);
 }
 
-int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
+int set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	     unsigned long vaddr)
 {
-	return uprobe_write_opcode(auprobe, mm, vaddr,
+	return uprobe_write_opcode(auprobe, vma, vaddr,
 		   __opcode_to_mem_arm(auprobe->bpinsn));
 }
 
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index b1df7d792fa16..288a42cc40baa 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -185,13 +185,13 @@ struct uprobes_state {
 };
 
 extern void __init uprobes_init(void);
-extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
-extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
+extern int set_swbp(struct arch_uprobe *aup, struct vm_area_struct *vma, unsigned long vaddr);
+extern int set_orig_insn(struct arch_uprobe *aup, struct vm_area_struct *vma, unsigned long vaddr);
 extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
 extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
-extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
+extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 259038d099819..ac17c16f65d63 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -474,19 +474,19 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  *
  * uprobe_write_opcode - write the opcode at a given virtual address.
  * @auprobe: arch specific probepoint information.
- * @mm: the probed process address space.
+ * @vma: the probed virtual memory area.
  * @vaddr: the virtual address to store the opcode.
  * @opcode: opcode to be written at @vaddr.
  *
  * Called with mm->mmap_lock held for read or write.
  * Return 0 (success) or a negative errno.
  */
-int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
-			unsigned long vaddr, uprobe_opcode_t opcode)
+int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+		unsigned long vaddr, uprobe_opcode_t opcode)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	struct uprobe *uprobe;
 	struct page *old_page, *new_page;
-	struct vm_area_struct *vma;
 	int ret, is_register, ref_ctr_updated = 0;
 	bool orig_page_huge = false;
 	unsigned int gup_flags = FOLL_FORCE;
@@ -498,9 +498,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (is_register)
 		gup_flags |= FOLL_SPLIT_PMD;
 	/* Read the page with vaddr into memory */
-	old_page = get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);
-	if (IS_ERR(old_page))
-		return PTR_ERR(old_page);
+	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags, &old_page, NULL);
+	if (ret != 1)
+		return ret;
 
 	ret = verify_opcode(old_page, vaddr, &opcode);
 	if (ret <= 0)
@@ -590,30 +590,31 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 /**
  * set_swbp - store breakpoint at a given address.
  * @auprobe: arch specific probepoint information.
- * @mm: the probed process address space.
+ * @vma: the probed virtual memory area.
  * @vaddr: the virtual address to insert the opcode.
  *
  * For mm @mm, store the breakpoint instruction at @vaddr.
  * Return 0 (success) or a negative errno.
  */
-int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
+int __weak set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+		unsigned long vaddr)
 {
-	return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN);
+	return uprobe_write_opcode(auprobe, vma, vaddr, UPROBE_SWBP_INSN);
 }
 
 /**
  * set_orig_insn - Restore the original instruction.
- * @mm: the probed process address space.
+ * @vma: the probed virtual memory area.
  * @auprobe: arch specific probepoint information.
  * @vaddr: the virtual address to insert the opcode.
  *
  * For mm @mm, restore the original opcode (opcode) at @vaddr.
  * Return 0 (success) or a negative errno.
  */
-int __weak
-set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
+int __weak set_orig_insn(struct arch_uprobe *auprobe,
+		struct vm_area_struct *vma, unsigned long vaddr)
 {
-	return uprobe_write_opcode(auprobe, mm, vaddr,
+	return uprobe_write_opcode(auprobe, vma, vaddr,
 			*(uprobe_opcode_t *)&auprobe->insn);
 }
 
@@ -1153,7 +1154,7 @@ static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
 	if (first_uprobe)
 		set_bit(MMF_HAS_UPROBES, &mm->flags);
 
-	ret = set_swbp(&uprobe->arch, mm, vaddr);
+	ret = set_swbp(&uprobe->arch, vma, vaddr);
 	if (!ret)
 		clear_bit(MMF_RECALC_UPROBES, &mm->flags);
 	else if (first_uprobe)
@@ -1168,7 +1169,7 @@ static int remove_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	set_bit(MMF_RECALC_UPROBES, &mm->flags);
-	return set_orig_insn(&uprobe->arch, mm, vaddr);
+	return set_orig_insn(&uprobe->arch, vma, vaddr);
 }
 
 struct map_info {
-- 
2.48.1

