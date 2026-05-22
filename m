Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE223043C9
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463295; cv=none; b=vEccCWIwS0EL4IC6AITeHfwtoBvaQOajmlf6GI9rDvE9gts00c/L5ualDEHTEBre8jFSPDL8jXReAxDfXtKfyFee1Vzm0CN94cQOu35m4PZutOarXOpwUlIihfp3mPiiIAaaSO9cVGIEHROoGWM176GjNJdVaNajbSthSmEUUPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463295; c=relaxed/simple;
	bh=kL9HLy2U0FxzTvsrjk37010gdPtNgyG1J9qDxhceLUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oub5TaU97bhcSb/UV3f2J9gah3jKjzSwLMllIAahM6bfDrxtQi3acvwR2fCisFzxuzg4wsEa3mhwdQm8TxuYrAF7qt3VXClho0Nd2CSxngGYjbCeNyWR2gdepoLRyJYomEz0QsQch8uwSoM4Ln0DnVChZPei50l2BFBUDNdr+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 22DE567CFC;
	Fri, 22 May 2026 15:21:29 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDE02593A8;
	Fri, 22 May 2026 15:21:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Zp3+OHh0EGqeHwAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 22 May 2026 15:21:28 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 2/3] x86/xen: Cleanup Xen related trace points
Date: Fri, 22 May 2026 17:21:13 +0200
Message-ID: <20260522152114.77319-3-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522152114.77319-1-jgross@suse.com>
References: <20260522152114.77319-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 22DE567CFC
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 

Since dropping Xen-PV support for 32-bit, include/trace/events/xen.h
contains several stale trace point definitions. Remove them.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 include/trace/events/xen.h | 62 ++------------------------------------
 1 file changed, 3 insertions(+), 59 deletions(-)

diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
index 0577f0cdd231..e3f139f0bc78 100644
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -129,9 +129,10 @@ TRACE_EVENT(xen_mc_extend_args,
 		      __entry->res == XEN_MC_XE_NO_SPACE ? "NO_SPACE" : "???")
 	);
 
-TRACE_DEFINE_SIZEOF(pteval_t);
 /* mmu */
-DECLARE_EVENT_CLASS(xen_mmu__set_pte,
+TRACE_DEFINE_SIZEOF(pteval_t);
+
+TRACE_EVENT(xen_mmu_set_pte,
 	    TP_PROTO(pte_t *ptep, pte_t pteval),
 	    TP_ARGS(ptep, pteval),
 	    TP_STRUCT__entry(
@@ -146,13 +147,6 @@ DECLARE_EVENT_CLASS(xen_mmu__set_pte,
 		      (int)sizeof(pteval_t) * 2, (unsigned long long)__entry->pteval)
 	);
 
-#define DEFINE_XEN_MMU_SET_PTE(name)				\
-	DEFINE_EVENT(xen_mmu__set_pte, name,			\
-		     TP_PROTO(pte_t *ptep, pte_t pteval),	\
-		     TP_ARGS(ptep, pteval))
-
-DEFINE_XEN_MMU_SET_PTE(xen_mmu_set_pte);
-
 TRACE_DEFINE_SIZEOF(pmdval_t);
 
 TRACE_EVENT(xen_mmu_set_pmd,
@@ -170,37 +164,6 @@ TRACE_EVENT(xen_mmu_set_pmd,
 		      (int)sizeof(pmdval_t) * 2, (unsigned long long)__entry->pmdval)
 	);
 
-#ifdef CONFIG_X86_PAE
-DEFINE_XEN_MMU_SET_PTE(xen_mmu_set_pte_atomic);
-
-TRACE_EVENT(xen_mmu_pte_clear,
-	    TP_PROTO(struct mm_struct *mm, unsigned long addr, pte_t *ptep),
-	    TP_ARGS(mm, addr, ptep),
-	    TP_STRUCT__entry(
-		    __field(struct mm_struct *, mm)
-		    __field(unsigned long, addr)
-		    __field(pte_t *, ptep)
-		    ),
-	    TP_fast_assign(__entry->mm = mm;
-			   __entry->addr = addr;
-			   __entry->ptep = ptep),
-	    TP_printk("mm %p addr %lx ptep %p",
-		      __entry->mm, __entry->addr, __entry->ptep)
-	);
-
-TRACE_EVENT(xen_mmu_pmd_clear,
-	    TP_PROTO(pmd_t *pmdp),
-	    TP_ARGS(pmdp),
-	    TP_STRUCT__entry(
-		    __field(pmd_t *, pmdp)
-		    ),
-	    TP_fast_assign(__entry->pmdp = pmdp),
-	    TP_printk("pmdp %p", __entry->pmdp)
-	);
-#endif
-
-#if CONFIG_PGTABLE_LEVELS >= 4
-
 TRACE_DEFINE_SIZEOF(pudval_t);
 
 TRACE_EVENT(xen_mmu_set_pud,
@@ -236,24 +199,6 @@ TRACE_EVENT(xen_mmu_set_p4d,
 		      (int)sizeof(p4dval_t) * 2, (unsigned long long)pgd_val(native_make_pgd(__entry->p4dval)),
 		      (int)sizeof(p4dval_t) * 2, (unsigned long long)__entry->p4dval)
 	);
-#else
-
-TRACE_EVENT(xen_mmu_set_pud,
-	    TP_PROTO(pud_t *pudp, pud_t pudval),
-	    TP_ARGS(pudp, pudval),
-	    TP_STRUCT__entry(
-		    __field(pud_t *, pudp)
-		    __field(pudval_t, pudval)
-		    ),
-	    TP_fast_assign(__entry->pudp = pudp;
-			   __entry->pudval = native_pud_val(pudval)),
-	    TP_printk("pudp %p pudval %0*llx (raw %0*llx)",
-		      __entry->pudp,
-		      (int)sizeof(pudval_t) * 2, (unsigned long long)pgd_val(native_make_pgd(__entry->pudval)),
-		      (int)sizeof(pudval_t) * 2, (unsigned long long)__entry->pudval)
-	);
-
-#endif
 
 DECLARE_EVENT_CLASS(xen_mmu_ptep_modify_prot,
 	    TP_PROTO(struct mm_struct *mm, unsigned long addr,
@@ -452,7 +397,6 @@ TRACE_EVENT(xen_cpu_set_ldt,
 		      __entry->addr, __entry->entries)
 	);
 
-
 #endif /*  _TRACE_XEN_H */
 
 /* This part must be outside protection */
-- 
2.54.0

