Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E0817AE11;
	Tue, 11 Mar 2025 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741656608; cv=none; b=iz7qYa2zCawVQTZdEP76dO+4EvCZUpYOlAzqHSg6k33K7wCgZtvnCoUjvLNUHW0QC46szog/O0jlkL0GNJw51V2UuUR/vvTfpdLfskhhK+9U5PZVoLlZq3FZjaVLo5gFvpvxnps/N+jRY84YPi0kGn0SMDFCUEFBUaZUKJM9rSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741656608; c=relaxed/simple;
	bh=w9HyIeLsxGet48XT7rsx5+4DYHO4MrVOy19e355cau0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P0hcy7RXfX3+N91HzbhEyTl9Y3VKt1NMtk2uCOmJoyIHLmqHYfEi1PI4Dg5aZCxjs6GEBiqzrBcXQiESvYnuLLwlyy4ThiDS5BsdJ8Ox84rt7kfBOBh/EU9vVCJyuONDutAnlrkK9uAQcKDY4K8AvOstPAZU2hgIRNBakfg/jHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7zoyQNd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7zoyQNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2835BC4CEE5;
	Tue, 11 Mar 2025 01:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741656607;
	bh=w9HyIeLsxGet48XT7rsx5+4DYHO4MrVOy19e355cau0=;
	h=From:To:Cc:Subject:Date:From;
	b=k7zoyQNdUBbSuIq4RIvsTyMxonGniWRIP9P9sXkN7svWNyu1oXRnuQqwZ5k8txSlc
	 fJf2hJnCCUm6G+UuCIHW/UxM2wNgPDN3qGyDrFTvCqvvQmcKsdkFRVrjXp2hXqcJig
	 W4xH4yB4fCx6KbiKB59nTDql+fqbeNpigvtnmo5O2/JhkJKAXBYS2WMX8NAJyCkyMD
	 HrqoyyAqfzCyQGGdVUSDXdXOSOYAqLNe4UL1jc1JzaCQxj3RnfTyj5NbvYsQ9+BlPA
	 gIljIUhs4k7W/2/nxVasYtlw7iyqjK5h3cN9P2gDO1gXP22Y+firfhesm+I8cxAstW
	 Gs34zbJGslNJg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing: Skip update_last_data() if cleared and remove active check for save_mod()
Date: Tue, 11 Mar 2025 10:30:03 +0900
Message-ID: <174165660328.1173316.15529357882704817499.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

If the last boot data is already cleared, there is no reason to update it
again. Skip if the TRACE_ARRAY_FL_LAST_BOOT is cleared.
Also, for calling save_mod() when module loading, we don't need to check
the trace is active or not because any module address can be on the
stacktrace.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - merge [1/3] and [2/3] in the previous series.
---
 kernel/trace/trace.c |   26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c3c79908766e..d17278a72e72 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6033,6 +6033,12 @@ static void update_last_data(struct trace_array *tr)
 	if (!(tr->flags & TRACE_ARRAY_FL_BOOT))
 		return;
 
+	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+		return;
+
+	/* Only if the buffer has previous boot data clear and update it. */
+	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
+
 	/* Reset the module list and reload them */
 	if (tr->scratch) {
 		struct trace_scratch *tscratch = tr->scratch;
@@ -6045,9 +6051,6 @@ static void update_last_data(struct trace_array *tr)
 		module_for_each_mod(save_mod, tr);
 	}
 
-	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
-		return;
-
 	/*
 	 * Need to clear all CPU buffers as there cannot be events
 	 * from the previous boot mixed with events with this boot
@@ -6070,7 +6073,6 @@ static void update_last_data(struct trace_array *tr)
 #else
 	tscratch->kaslr_addr = 0;
 #endif
-	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
 }
 
 /**
@@ -10092,15 +10094,6 @@ static void trace_module_remove_evals(struct module *mod)
 static inline void trace_module_remove_evals(struct module *mod) { }
 #endif /* CONFIG_TRACE_EVAL_MAP_FILE */
 
-static bool trace_array_active(struct trace_array *tr)
-{
-	if (tr->current_trace != &nop_trace)
-		return true;
-
-	/* 0 is no events, 1 is all disabled */
-	return trace_events_enabled(tr, NULL) > 1;
-}
-
 static void trace_module_record(struct module *mod)
 {
 	struct trace_array *tr;
@@ -10109,11 +10102,8 @@ static void trace_module_record(struct module *mod)
 		/* Update any persistent trace array that has already been started */
 		if ((tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) ==
 		    TRACE_ARRAY_FL_BOOT) {
-			/* Only update if the trace array is active */
-			if (trace_array_active(tr)) {
-				guard(mutex)(&scratch_mutex);
-				save_mod(mod, tr);
-			}
+			guard(mutex)(&scratch_mutex);
+			save_mod(mod, tr);
 		}
 	}
 }

