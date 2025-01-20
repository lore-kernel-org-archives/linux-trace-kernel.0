Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9658423A9;
	Mon, 20 Jan 2025 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737412079; cv=none; b=fkfSWsSSxTo8ImOMytX3i4t99Qa8+Tq/1F8U6MphiXYaK603VcEVdaIC/z65mN4jx67JbANxVgOP3yblMadRH+2Flq2pDKd87RgNqbgmr6JXKm0+qqvdLrA2FT8vGDzaiKsLsY0HAVJcrv7eV3w1PkLtf064gz7W+eqnYMGw24A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737412079; c=relaxed/simple;
	bh=TEyulGXhPHXtGubGRQOaNsPCr6o6NX9Iea5epgxoegw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OzsvpXaudOrT9NYcT3E2smYlJ1ptusLMfiwIIilW0Y1bBzm9AbckHaLSAZI2U1imbUKvuUV4xL29rm7SUurCngqNrJFfPHMbg6EPnkFl22hvSZCt/Jz0M91m7wAoZXmy0NMa7TI3TRsYWOQ+NuJLe1gXeQL2JQInNVUlc4qrRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327F5C4CEDD;
	Mon, 20 Jan 2025 22:27:58 +0000 (UTC)
Date: Mon, 20 Jan 2025 17:27:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] tracing: Rename update_cache() to update_mod_cache()
Message-ID: <20250120172756.4ecfb43f@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The static function in trace_events.c called update_cache() is too generic
and conflicts with the function defined in arch/openrisc/include/asm/pgtable.h

Rename it to update_mod_cache() to make it less generic.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501210550.Ufrj5CRn-lkp@intel.com/
Fixes: b355247df104e ("tracing: Cache ":mod:" events for modules not loaded yet")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index bb1406719c3f..51c5014877e8 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3580,7 +3580,7 @@ EXPORT_SYMBOL_GPL(trace_remove_event_call);
 	     event++)
 
 #ifdef CONFIG_MODULES
-static void update_cache(struct trace_array *tr, struct module *mod)
+static void update_mod_cache(struct trace_array *tr, struct module *mod)
 {
 	struct event_mod_load *event_mod, *n;
 
@@ -3600,7 +3600,7 @@ static void update_cache_events(struct module *mod)
 	struct trace_array *tr;
 
 	list_for_each_entry(tr, &ftrace_trace_arrays, list)
-		update_cache(tr, mod);
+		update_mod_cache(tr, mod);
 }
 
 static void trace_module_add_events(struct module *mod)
-- 
2.45.2

