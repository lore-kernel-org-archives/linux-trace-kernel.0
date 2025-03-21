Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A12253E8
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742557044; cv=none; b=mzylSLWvrwiYin3XvJkUS8BFF+yB7+34IicBUy44b65ts/OFS36HhvdyVoHWSV0YyJ7dP2hr/zlyaSAj6B7AaAHnpUwHNqsB+MD0WdGtaZNOcnSiYP7gb63pZCIKaaYUpUpYxMJ3XaWNsMLg1bV6XviNaiJPQ13/gD+oRmmI+7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742557044; c=relaxed/simple;
	bh=tnk3bsb90JY2mcV21Ncrc9nnVyKzLcleDYrjSkfxIGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Jb75LrywfzOGb6PcjaOM//WkXdrh2ofN7Bm/RBTXhAjj+KmYvi7okOsna9xndwvJgfG0SPncxUvoEXkSXHeh4Nf1/JCuHMeMfgV0wH+qCIs1h+obAfr+GtLwiAlS3HsJTLamCSxQBFbahtwyC2M9ilwMw/EryrkTtXweG11Ge2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Br9vMT1A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Br9vMT1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742557042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LA4tQm8B9yk34e6zjAsFaRrtnSy4omTcdpMVJkFUhlY=;
	b=Br9vMT1ANbZ3H/eBQdaz7la3/nMxpX6exglJ4gvN5Gy242qhj2iZlkXhSqtXdkAtn3WLef
	oCR2x9SYzzxlr6ounW8KmBB3GGtliCwSNzayZRoGNPPiAoguxneVyv6jjcxfmpxjQS6fbs
	vAJ5xvmrSuboEeQ/L3UhQGW8n/ZbVX4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-G9l1zSPmNxik0ZaxajVs0Q-1; Fri, 21 Mar 2025 07:37:21 -0400
X-MC-Unique: G9l1zSPmNxik0ZaxajVs0Q-1
X-Mimecast-MFC-AGG-ID: G9l1zSPmNxik0ZaxajVs0Q_1742557040
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39135d31ca4so1051838f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742557040; x=1743161840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LA4tQm8B9yk34e6zjAsFaRrtnSy4omTcdpMVJkFUhlY=;
        b=N9VCOiEgYXoARuu2C5ncKEhPf71BXaNc154odP/m96XhJCZ3Yz/AERlOCuZfmY339N
         U4d4kUeByYcYe76odXH+XRsrXLDMp2Yu+nslrQAJD3QAMM86j28xdlPdufyhT3cFRWRh
         XuxxH8JHp+/iWtmjhhZpWP9C5IbI4Frt2687LeZIy+dps7s4hUWfuuOBSqvvSepsVhLm
         m0lICucgj858tvxqlsE4ClKPy+JuAS3HKajvFqUiKI36ccUNqf1po26BvTVQ6ikntPfE
         4KvIcvRjv9szhnFYLnXHqgoXANxZTzHk77U2iEfUPJW2Uj0h5MrXpkf4mWutp/ftyQ56
         Eqnw==
X-Forwarded-Encrypted: i=1; AJvYcCXjJHeyHD8glQx22JTsrLtEQbIJuE4zkZFUQPhUzarRH4eVzK+UzmWgWv1mthvgu1JWcOMH224Xlm6uwbeKY9f6eMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzelZL++pA4Fm9pF7VKN/QkhJekwvSaChlcKLvS4YFB+MkezQA
	7rC/jd9H7psU7bUWTG6pcLd3TdR/+n0zBOhI0salEnAm0P46NRIjDBm3aD2XqPiVYEH3wm6/51A
	oh0h697m61p/U0ITRwXKMGySQFKQNvCxVM4PDpr26fiXt206vD0JUxR+GF88GZrH012yu/A==
X-Gm-Gg: ASbGncuihpMeOma98U4KJV+aPy9k5juKnfYJY+ylaSpCN1QHGXEoUUIW4vKdwRL5hQH
	WFZxTCz5ouRwOf/IAT7Ikg6gI5Rvea6EYR0mvqGlk6o5MeedHe6TAg/fPhg6zCsOz+RFbMaXl12
	jjYE9x/iN46GLw2NhaPiFeZ523GPLnAfJATL4nzNZKm4e7khH7inp8gwM4FVpmgB6mZDeT0sRRc
	Jd8aNRTilq+YWOd6hHQaaN5L1hwXjDP31mysUN3a1i0oBG5u5Y5BFFMw7bHsl9zWMiEcqxIOoJt
	ljUbg+Ljim8D4quuH7ZbcnFyMcrE3Sg//AP0pSSmL1FDW6gUpKBGcEmSuVa18Cd3Y2ROyimLzVh
	h
X-Received: by 2002:a05:6000:4021:b0:390:df83:1f22 with SMTP id ffacd0b85a97d-3997959ce52mr7464153f8f.25.1742557039602;
        Fri, 21 Mar 2025 04:37:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzgIkkOJsHGuf2WyAxCwKihBA43kh5WjBQNfuxP9FngTIZo6gSbHPXNu6WapbxvVPx5btxjA==
X-Received: by 2002:a05:6000:4021:b0:390:df83:1f22 with SMTP id ffacd0b85a97d-3997959ce52mr7464123f8f.25.1742557039114;
        Fri, 21 Mar 2025 04:37:19 -0700 (PDT)
Received: from localhost (p200300cbc72a910023d23800cdcc90f0.dip0.t-ipconnect.de. [2003:cb:c72a:9100:23d2:3800:cdcc:90f0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f43e50sm74599665e9.12.2025.03.21.04.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:37:18 -0700 (PDT)
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
Subject: [PATCH v3 2/3] kernel/events/uprobes: pass VMA to set_swbp(), set_orig_insn() and uprobe_write_opcode()
Date: Fri, 21 Mar 2025 12:37:12 +0100
Message-ID: <20250321113713.204682-3-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321113713.204682-1-david@redhat.com>
References: <20250321113713.204682-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wSg2w3UlsJ9SHelVwH6kblK90iVyS6faifPT_znmBBk_1742557040
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We already have the VMA, no need to look it up using
get_user_page_vma_remote(). We can now switch to
get_user_pages_remote().

Acked-by: Oleg Nesterov <oleg@redhat.com>
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

