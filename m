Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75C22157F;
	Thu, 12 Jun 2025 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737587; cv=none; b=GTYcc8cwC4+BOa6ug33Sx3E4mAPtSANAxS/QG8O6iJ9+xYQKM/Lsf+liHdk/52dSDmnL5vvcAL4YofXHtIsW0UWK3Km3GLQItCjoQU/WbgMExL7Bk8oDvUhjrWcYZEeBpVZmFySZI5dxcLfwMIVzDazjWSwTgfXmmeBlKLKJ6AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737587; c=relaxed/simple;
	bh=Rpnn5xMwFPnTBd6TTY6z/Yi1ye7/TyK0BtV8aMiEVRk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hGPmk0CrOGoiTuP48bETyWwlBQ+pU7seUTGBHeZTGD0bj+OBqQTp1O4W/PmUakBRhtkz87HENgQR9nIk7UdOoZuBelBMt3LhGbp1s82GYoc+jmsCNbAI+RKUStjyisyFuqghMc9VioGyDQA7JeP+dxeBq1e9CEZn2yGZxbh5cDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id ED80F81105;
	Thu, 12 Jun 2025 14:13:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id D4CE518;
	Thu, 12 Jun 2025 14:13:00 +0000 (UTC)
Date: Thu, 12 Jun 2025 10:12:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/thp: tracing: Hide hugepage events under
 CONFIG_PPC_BOOK3S_64
Message-ID: <20250612101259.0ad43e48@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bph8eeis91dcouz9rgjooibbaxyq1yrh
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: D4CE518
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/TNcbCQL4JSQd2WThmCKZIdmvrRbao+Pg=
X-HE-Tag: 1749737580-822780
X-HE-Meta: U2FsdGVkX1+l9YM5abWc5caLLQlplWKE+WQkJvUPSjXG5kG4eFjP+HIM2/a2LpO5jRBFVVvKGK5Dt5Wrtb1q64jWXnsO5l9ab27tqcNjb75RYUBiBD7M0J62l2cH7TSG1kd3z58eiTfTW928dek77QjPHuiNdToXVDAoqndf6gbqD7fnIGW4JNuoyF/QSdrr2EdufYw/lXM9pLVGN6c4/zHRRcKiCZMtjKzWOAY6gWZM/nwAXUlgMcmg52eaQKssksrYHBRiMZ0xLODygqNKD521zy3rOyE80bBFkeS/Ua8pqPK/TeYmNZPUg65ijCr1IvmqzAiwkGu5ieXeG2ACi6oQlnilmcjMK1E85Sxhg5WAVvGlfBetvlIvkffN5OhhLzFpYohGI5vNu6duHQCGRn53lTEF849O

From: Steven Rostedt <rostedt@goodmis.org>

The events hugepage_set_pmd, hugepage_set_pud, hugepage_update_pmd and
hugepage_update_pud are only called when CONFIG_PPC_BOOK3S_64 is defined.
As each event can take up to 5K regardless if they are used or not, it's
best not to define them when they are not used. Add #ifdef around these
events when they are not used.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Note, I will be adding code soon that will make unused events cause a warning.

 include/trace/events/thp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/thp.h b/include/trace/events/thp.h
index f50048af5fcc..c8fe879d5828 100644
--- a/include/trace/events/thp.h
+++ b/include/trace/events/thp.h
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include <linux/tracepoint.h>
 
+#ifdef CONFIG_PPC_BOOK3S_64
 DECLARE_EVENT_CLASS(hugepage_set,
 
 	    TP_PROTO(unsigned long addr, unsigned long pte),
@@ -66,6 +67,7 @@ DEFINE_EVENT(hugepage_update, hugepage_update_pud,
 	    TP_PROTO(unsigned long addr, unsigned long pud, unsigned long clr, unsigned long set),
 	    TP_ARGS(addr, pud, clr, set)
 );
+#endif /* CONFIG_PPC_BOOK3S_64 */
 
 DECLARE_EVENT_CLASS(migration_pmd,
 
-- 
2.47.2

