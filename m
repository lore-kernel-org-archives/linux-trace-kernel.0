Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6891A00E7;
	Tue, 25 Feb 2025 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509735; cv=none; b=Oh0iQpBOwFPcP2KMfVEdFLeToEiP+Zr7FM1H85+iqbNcuNHHPFW4KdN2cjb1fGtU3KHsnkfTUwMr4Np5KQLm4/34ANBO/UxTBvxaM/KxrCo0L248mgL6bnMWHf/BRM6cyAyZ/oJf9IvI5Ld750EzJVJSBgZvR5AUgzhbUngBXoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509735; c=relaxed/simple;
	bh=e55btSmzwT+hxbQtmW4K8hhRNif0xkEz8Shghfp3xbM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FZeyMdHCXV8M8BdARNihfn5c8W8fZmXkyYpLrc7YuK7ayZmRCNu3PYFK33RQe2uw+X6UrkUk1+wVfIndMlvIGFKd0e1qXqKo0H4ZvXKTAnFT5CnL710Fez5hZ56ybv6kKzpGZmQwAmTDL6f9JEDqWyBLcf/lWhPRysl7l03kblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7482AC4CEDD;
	Tue, 25 Feb 2025 18:55:33 +0000 (UTC)
Date: Tue, 25 Feb 2025 13:56:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Michael Petlan <mpetlan@redhat.com>, Veronika
  Molnarova <vmolnaro@redhat.com>, Suren Baghdasaryan <surenb@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RESEND][PATCH] tracing: gfp: Remove duplication of recording GFP
 flags
Message-ID: <20250225135611.1942b65c@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The gfp_flags when recorded in the trace require being converted from
their numbers to values. Various macros are used to help facilitate this,
but there's two sets of macros that need to keep track of the same GFP
flags to stay in sync.

Commit 60295b944ff68 ("tracing: gfp: Fix the GFP enum values shown for
user space tracing tools") added a TRACE_GFP_FLAGS macro that holds the
enum ___GFP_*_BIT defined bits, and creates the TRACE_DEFINE_ENUM()
wrapper around them.

The __def_gfpflag_names() macro creates the mapping of various flags or
multiple flags to give them human readable names via the __print_flags()
tracing helper macro.

As the TRACE_GFP_FLAGS is a subset of the __def_gfpflags_names(), it can
be used to cover the individual bit names, by redefining the internal
macro TRACE_GFP_EM():

  #undef TRACE_GFP_EM
  #define TRACE_GFP_EM(a) gfpflag_string(__GFP_##a),

This will remove the bits that are duplicate between the two macros. If a
new bit is created, only the TRACE_GFP_FLAGS needs to be updated and that
will also update the __def_gfpflags_names() macro.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Last version: https://lore.kernel.org/20250116214439.046082618@goodmis.org

  This was originally sent with a patch that fixed the output of gfp flags
  in trace events to show human readable flags and not hex numbers.

  This patch on the other hand is a clean up as the there's now two macros
  that define the bits to print. This makes the one macro use the other
  macro that is a subset of the first.

  Can someone in the memory management subsystem either give me an acked-by
  and I can take this through my tree, or you can just take this through
  the memory management tree. Either way works for me.

 include/trace/events/mmflags.h | 41 +++++++++-------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 72fbfe3caeaf..82371177ef79 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -78,6 +78,13 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 
 #define gfpflag_string(flag) {(__force unsigned long)flag, #flag}
 
+/*
+ * For the values that match the bits, use the TRACE_GFP_FLAGS
+ * which will allow any updates to be included automatically.
+ */
+#undef TRACE_GFP_EM
+#define TRACE_GFP_EM(a) gfpflag_string(__GFP_##a),
+
 #define __def_gfpflag_names			\
 	gfpflag_string(GFP_TRANSHUGE),		\
 	gfpflag_string(GFP_TRANSHUGE_LIGHT),	\
@@ -91,41 +98,13 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 	gfpflag_string(GFP_NOIO),		\
 	gfpflag_string(GFP_NOWAIT),		\
 	gfpflag_string(GFP_DMA),		\
-	gfpflag_string(__GFP_HIGHMEM),		\
 	gfpflag_string(GFP_DMA32),		\
-	gfpflag_string(__GFP_HIGH),		\
-	gfpflag_string(__GFP_IO),		\
-	gfpflag_string(__GFP_FS),		\
-	gfpflag_string(__GFP_NOWARN),		\
-	gfpflag_string(__GFP_RETRY_MAYFAIL),	\
-	gfpflag_string(__GFP_NOFAIL),		\
-	gfpflag_string(__GFP_NORETRY),		\
-	gfpflag_string(__GFP_COMP),		\
-	gfpflag_string(__GFP_ZERO),		\
-	gfpflag_string(__GFP_NOMEMALLOC),	\
-	gfpflag_string(__GFP_MEMALLOC),		\
-	gfpflag_string(__GFP_HARDWALL),		\
-	gfpflag_string(__GFP_THISNODE),		\
-	gfpflag_string(__GFP_RECLAIMABLE),	\
-	gfpflag_string(__GFP_MOVABLE),		\
-	gfpflag_string(__GFP_ACCOUNT),		\
-	gfpflag_string(__GFP_WRITE),		\
 	gfpflag_string(__GFP_RECLAIM),		\
-	gfpflag_string(__GFP_DIRECT_RECLAIM),	\
-	gfpflag_string(__GFP_KSWAPD_RECLAIM),	\
-	gfpflag_string(__GFP_ZEROTAGS)
-
-#ifdef CONFIG_KASAN_HW_TAGS
-#define __def_gfpflag_names_kasan ,			\
-	gfpflag_string(__GFP_SKIP_ZERO),		\
-	gfpflag_string(__GFP_SKIP_KASAN)
-#else
-#define __def_gfpflag_names_kasan
-#endif
+	TRACE_GFP_FLAGS				\
+	{ 0, "none" }
 
 #define show_gfp_flags(flags)						\
-	(flags) ? __print_flags(flags, "|",				\
-	__def_gfpflag_names __def_gfpflag_names_kasan			\
+	(flags) ? __print_flags(flags, "|", __def_gfpflag_names		\
 	) : "none"
 
 #ifdef CONFIG_MMU
-- 
2.47.2

