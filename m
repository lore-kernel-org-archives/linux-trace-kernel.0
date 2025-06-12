Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BEC22157F;
	Thu, 12 Jun 2025 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737006; cv=none; b=ZLYYmW4B2uG44LdJJ6ukA3V0tOd25YdVVVhrA7frWbQAdM8l5ylyRDm/yvpGXlqdZ8paUAtqbuJQ90Gvyn0H9oNtRtOf0G2snd0Nx7N895C1nR8nUCMhf8dHjP2CVkEg8WvM7dSsxT4lUK0OUK7xO580dUm6K/ZNHqe6UM+f2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737006; c=relaxed/simple;
	bh=4Z63mMzRXQGf11Y/TbOm11xYKVHZZ2q9evEA63ZcDYg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Xo1RAP9rDJGa41x/1fHszXiM5eJ36e7rqx/o6Gl96TymfeU39W7qY25n8JV659i0RtLFtVrTTw7oo1LPZlhETOaEN4MBmpXHS7/ps65Jym7fave+0wB0fHNbKHQOZuWvPx7GEk5Hg4KfNM/wE9ReoquNENmsbGH5ue39c9IcqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 181C3140C8F;
	Thu, 12 Jun 2025 14:03:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 027DB17;
	Thu, 12 Jun 2025 14:03:13 +0000 (UTC)
Date: Thu, 12 Jun 2025 10:03:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org, x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>,
 Borislav Petkov <bp@alien8.de>
Subject: [PATCH] mm, x86/mm: Move creating the tlb_flush event back to x86
 code
Message-ID: <20250612100313.3b9a8b80@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 027DB17
X-Stat-Signature: a633aexr8assinwfnh58a1t5wtz17x14
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18C+o9UXjVaYLfXVFToL0QGqnozJG/773c=
X-HE-Tag: 1749736993-720449
X-HE-Meta: U2FsdGVkX19nUL9F8mZWNw+0MQ2nz2VkNz1X5YCpiQuSBsq9uh+KUxoAKhB5MUcc5h6RjHD+G5h0yQy7k2Us0ulvQkv+rh3UAN7WnG8Lb2grJSArNfqFjyxllkbiyIPcwy6cyN+ddxtnBWE6ID6ipVqvayImDHh3c3jDvRHcQZWAf3Djybp3gf/aL56oh25yZ03EEORZ4uj2Zpj2qNPT+74t/pGv+TreaTKs7VW6qT0hiovVztZAwdAwLpOnXYdX6YrFD13kBMcDloNpG7ccwAJMXvMebpvRRvBukQWn2pe9sXYt1T7skK7Qg9IUEd9N+p8eaLkCvqYlBKzf89GQX509Y7VtxBUh7HORsK1uO7qyqI5yt+bTw/BbXPNuzDjObl59oP53N6z9WDhTXIbGCj+9JZDhO99L

From: Steven Rostedt <rostedt@goodmis.org>

Commit e73ad5ff2f76 ("mm, x86/mm: Make the batched unmap TLB flush API
more generic") moved the trace_tlb_flush out of mm/rmap.c and back into
x86 specific architecture, but it kept the include to the events/tlb.h
file, even though it didn't use that event.

Then another commit came in and added more events to the mm/rmap.c file
and moved the #define CREATE_TRACE_POINTS define from the x86 specific
architecture to the generic mm/rmap.h file to create both the tlb_flush
tracepoint and the new tracepoints.

But since the tlb_flush tracepoint is only x86 specific, it now creates
that tracepoint for all other architectures and this wastes approximately
5K of text and meta data that will not be used.

Remove the events/tlb.h from mm/rmap.c and add the define
CREATE_TRACE_POINTS back in the x86 code.

Fixes: 4cc79b3303f22 ("mm/migration: add trace events for base page and HugeTLB migrations")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Note, I will be adding code soon that will make unused events cause a warning.

 arch/x86/mm/init.c | 1 +
 mm/rmap.c          | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 7456df985d96..f85313a8b5a9 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -34,6 +34,7 @@
  * We need to define the tracepoints somewhere, and tlb.c
  * is only compiled when SMP=y.
  */
+#define CREATE_TRACE_POINTS
 #include <trace/events/tlb.h>
 
 #include "mm_internal.h"
diff --git a/mm/rmap.c b/mm/rmap.c
index fb63d9256f09..0bc00668970f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -79,7 +79,6 @@
 #include <asm/tlbflush.h>
 
 #define CREATE_TRACE_POINTS
-#include <trace/events/tlb.h>
 #include <trace/events/migrate.h>
 
 #include "internal.h"
-- 
2.47.2

