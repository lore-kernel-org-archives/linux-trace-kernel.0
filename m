Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D520729616D
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103338; cv=none; b=nXuleW3p2VUMI2NZhjL20Saz7aR55C289y9LlhYG0Z45jCiqRi5odgSCqNGOtZo7Q7+J9RWjKUhGMr8yQbrE07qs2yiJ4OnOLoVYw/5NVZpb9JmnnwG/ZChP9LPuJXkyuPB3eamXIISVLV65EOD+9wXLT20r81ou/g4agCIqZVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103338; c=relaxed/simple;
	bh=Ah9D1oaYdgLAYU43bf6vQIZvtJeF1OpFbII7FyU6mlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gvCcFRj78HFuCAmwqCxU/A57mkBHVSmW4xZyrx/QAsq78eWMXPzO1V/qsVjXPf0uUhKXTHK2AXE02+B/f7s+MaRVgT+EQphmIOUn9IQ/UvdMKXXxpDztxD+Kkhemkx5DApNV6XqGQFDMRFSriy8MTpcs1SaBCdCLmDE3QWIZPuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8IU2Jd9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8IU2Jd9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741103335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffON9SnaOWg9oFQtm+MueKUsNfzxra0dWfxUL8seX24=;
	b=O8IU2Jd9LoQ+Ut6kNYA/dSdPaQdx8Rmfcb/jqASy0lIo6005c13kuUIV75Hl//usNCfsVi
	fOG5OqYxgR3mpS+2/0+8YaccwVD+W5JMRmJ2ObSSCnIAomUy3Lp+9fTuwyyEyrvr5Li0gc
	CMvk+f78cJRptP825uFSAenYKBbbORY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-pR3iaNKiNW-2GMCb1Bo4uw-1; Tue, 04 Mar 2025 10:48:54 -0500
X-MC-Unique: pR3iaNKiNW-2GMCb1Bo4uw-1
X-Mimecast-MFC-AGG-ID: pR3iaNKiNW-2GMCb1Bo4uw_1741103333
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bca561111so6433265e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103333; x=1741708133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffON9SnaOWg9oFQtm+MueKUsNfzxra0dWfxUL8seX24=;
        b=rPDU31nbfJwvpYlIXgT8vTAY9mpV8IHGx1jjHFgnsEm07yoWjl/XEM6s6q/uH5xSSJ
         OFZmUjpm+tNML8+85fmN/zfF65r+6QA+c1wVXiBjs0roG2wtRODS5/E1acxxkhx+JIf7
         53S14fh9qV7zGg8Uy0sJwY9w1CdB8te/IRXUUBq4IbOCqVhXEU7tsWbnm35uaGWAtdRl
         NyOalNxbEZA+InZCRyoCNVdxemtyYZsDqX3rhPLTtdwuYJHD1D3dH+xd1vzxwqivJpaH
         l+kaHCyCKT6Q5dyavUYEpdh4b1wFXLUBQhZm4xtj77NjEP1eIY5LvhdCfP1753lStf4S
         MAvw==
X-Forwarded-Encrypted: i=1; AJvYcCX0vT9yypeFgGOYWwEbBzmt3qR5uGWPa2tLnxNs0J3AVizlEmlLASJl0acuVGOjPjCMAKWQY3ZCP8cEHovpSMNv5Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxss0NFbOsomOS4tbOgQY62R3CKmrtPc6zXuu8iEsaGL6gCuF6f
	jxK7fRlkGBepdvE1xKNZ+F8my6Rdh9QpkFbl6wqYe8Pr7k4nkCU4cM444eMA8LNAG638XWgUvN0
	eMIOStsTMHgxI9sHsO8+3PsA93qNlmIAnBMC+ZCRkNLTDZRpOcd0iMW6vytmcCkj3qjwifA==
X-Gm-Gg: ASbGncsWPTHkN6UU/U1cCZPE8k+WmV+azEnx6pzYIp+AFg9f1Ow0w8PFfCQqbuU8d5W
	b+YUPqpZg4KSgnyThPRJOIZPZIZuMClypJjV5Bk1+CEDPOwoO5IL80LJ3QTy+BjwBPtmoDeMEdd
	hAAPF9FHobI2+XQSh7MYpaLtMNE1g9vurFnXHibq0OwomfoU4QxSnUS0a61UdqDzAPw4rWy5Idf
	RHtiwjPr7efGhJ+gwYCplH4JGoRmkvlBM37rY99xRNuLeD48wy3lUEl9kYLVmKFYdPhyjYmUzAw
	GuTTx3ZEBgLhg0/UTcTg8DxqVmcAXQL/LTI4V1FMigeQTWrj8mvf1knJdV6kmMImDzwcm68evz/
	6
X-Received: by 2002:a05:600c:3c9d:b0:439:8a62:db42 with SMTP id 5b1f17b1804b1-43ba66e19d9mr153515825e9.8.1741103333134;
        Tue, 04 Mar 2025 07:48:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4Gjl+jrn0ypwJ4W8O9mKURosa8cKWKJgfr05HkBSuQdnMp7DSreUXUU7A6eFr/8nx/dTcdQ==
X-Received: by 2002:a05:600c:3c9d:b0:439:8a62:db42 with SMTP id 5b1f17b1804b1-43ba66e19d9mr153515575e9.8.1741103332777;
        Tue, 04 Mar 2025 07:48:52 -0800 (PST)
Received: from localhost (p200300cbc73610009e302a8acd3d419c.dip0.t-ipconnect.de. [2003:cb:c736:1000:9e30:2a8a:cd3d:419c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bca26676esm43128935e9.8.2025.03.04.07.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:48:52 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [PATCH -next v1 2/3] kernel/events/uprobes: pass VMA to set_swbp(), set_orig_insn() and uprobe_write_opcode()
Date: Tue,  4 Mar 2025 16:48:45 +0100
Message-ID: <20250304154846.1937958-3-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304154846.1937958-1-david@redhat.com>
References: <20250304154846.1937958-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _7uu6DwQJvvf4Yvl6PS1esAiUQqhYoemja8y7HIydBg_1741103333
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
index a40efdda9052b..4da3bce5e062d 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -186,13 +186,13 @@ struct uprobes_state {
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
index 991aacc80d0e0..0276defd6fbfa 100644
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

