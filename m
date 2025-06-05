Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7706C14A4C7;
	Thu,  5 Jun 2025 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749154732; cv=none; b=J7vnKAxb6LErqOW76uefn9uMbV4Y+P+pgZNhOaOt5lf/XbW01JoO3HNxR3iemjEqcf92PDmF9gwQkmk4QIh0J5qXlbL/hsA+wUE2PQ4H7Wk5O27/CerIZ3V1I4c+8uqlhN+AughqAVXrpsfNOdLVorxejHZDF4ZN4nmKNb8mz9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749154732; c=relaxed/simple;
	bh=L2FN8aVUMIxFboZiUb09rQ953kWIeYaD3a/zsb4fjbw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=N/zyya6YUXLVqGUbiNHqdyGTFfwRWPC1APjpvhHwdQTV4uYY58gLuaYf7PAOeilMl1Ii1OsTMA7vqYpAzsFu5KttOSjC/fnjRC6HTOfmdr52bYQE5dNZQIm/4DBBk/bbEYdsW3S0p6g9hWvdUm+e09uYgfdGgm7B95Qd4v8P8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 102F812169B;
	Thu,  5 Jun 2025 20:18:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id DC2966000F;
	Thu,  5 Jun 2025 20:18:39 +0000 (UTC)
Date: Thu, 5 Jun 2025 16:19:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: [PATCH] mmap: Remove unused events vma_mas_szero and vma_store
Message-ID: <20250605161959.328ed2a7@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: DC2966000F
X-Stat-Signature: e6kafeutbfgm8w1t86x3zxtzfqzt5q86
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19zYBTYrdAQI+0fA9yqDXU/8il5cWKEtfg=
X-HE-Tag: 1749154719-696794
X-HE-Meta: U2FsdGVkX19rrlChUTkMolyY9BbaPyOzyDTxbnStfSTUO/TWDklMgdLH6kkUuCjp6VqxXEnnCzDRQp578hdxVcVQIBZ0uIwemF1VkPnwlmXOYsUvUdJfGH41e9Nz/7eBU/Y/QpcQIpift3JmpOYcTwbzJJuJu06lN3dTumaugFEsRZy/q2ADodK6tZrcqMt+41KrT+j3wSe9wyQFFuUV5uRHeQ/jCjWjgnE8rXmxtZXbaqiZjF8NlYyCgJ5LN8UFy+r/kecDVDx3oZApck45BdmxHWKLXnRrD+vPC7gpimLN6hCeqIrNfrcJELh5iBjQ3uzI/1b2BjOqxkfHuuT/DfY84g07etfGhbG1ocUIDxUHVpSbMBeXg6exXurB7wbba/CV7Txrf06DZdTN9uZjqg==

From: Steven Rostedt <rostedt@goodmis.org>

When the __vma_adjust() was converted to use the vma iterator it removed
the functions vma_mas_store() and vma_mas_remove(). These functions called
the tracepoints trace_vma_mas_store() and trace_vma_mas_szero()
respectively. The calls to these tracepoints were removed but the trace
events that created the tracepoints were not removed. Each trace event can
take up to 5K of memory, and it is allocated regardless of if they are
called or not.

Remove the unused trace events.

Link: https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.home/

Fixes: fbcc3104b843 ("mmap: convert __vma_adjust() to use vma iterator")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/mmap.h | 52 -------------------------------------
 1 file changed, 52 deletions(-)

diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
index f8d61485de16..ee2843a5daef 100644
--- a/include/trace/events/mmap.h
+++ b/include/trace/events/mmap.h
@@ -43,58 +43,6 @@ TRACE_EVENT(vm_unmapped_area,
 		__entry->align_offset)
 );
 
-TRACE_EVENT(vma_mas_szero,
-	TP_PROTO(struct maple_tree *mt, unsigned long start,
-		 unsigned long end),
-
-	TP_ARGS(mt, start, end),
-
-	TP_STRUCT__entry(
-			__field(struct maple_tree *, mt)
-			__field(unsigned long, start)
-			__field(unsigned long, end)
-	),
-
-	TP_fast_assign(
-			__entry->mt		= mt;
-			__entry->start		= start;
-			__entry->end		= end;
-	),
-
-	TP_printk("mt_mod %p, (NULL), SNULL, %lu, %lu,",
-		  __entry->mt,
-		  (unsigned long) __entry->start,
-		  (unsigned long) __entry->end
-	)
-);
-
-TRACE_EVENT(vma_store,
-	TP_PROTO(struct maple_tree *mt, struct vm_area_struct *vma),
-
-	TP_ARGS(mt, vma),
-
-	TP_STRUCT__entry(
-			__field(struct maple_tree *, mt)
-			__field(struct vm_area_struct *, vma)
-			__field(unsigned long, vm_start)
-			__field(unsigned long, vm_end)
-	),
-
-	TP_fast_assign(
-			__entry->mt		= mt;
-			__entry->vma		= vma;
-			__entry->vm_start	= vma->vm_start;
-			__entry->vm_end		= vma->vm_end - 1;
-	),
-
-	TP_printk("mt_mod %p, (%p), STORE, %lu, %lu,",
-		  __entry->mt, __entry->vma,
-		  (unsigned long) __entry->vm_start,
-		  (unsigned long) __entry->vm_end
-	)
-);
-
-
 TRACE_EVENT(exit_mmap,
 	TP_PROTO(struct mm_struct *mm),
 
-- 
2.47.2

