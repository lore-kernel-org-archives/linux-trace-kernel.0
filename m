Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88583FC5C6;
	Thu,  4 Jun 2026 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564215; cv=none; b=jowFNxh9rRSDJyfP+QxRZ5CvoXmdhdND4m4QpBMeAZj4C/1TGWaZleL0zBdl4HbknJIAdx7OA4H5/ydfCvMK99un4SwyoPb45Elx/LBdBg/cF9s3f1LNebUatW7Pgzfism8+dc1WJTdgt88or/MRFgTPq3vzuvbOWnaW/4NkUmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564215; c=relaxed/simple;
	bh=u7m5qBC4oxN3Xu3l0syY7/zzo03zA/Ib4uA/pQil+x0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJfM+em1vr1G6pNlEZ6ePng9VZyJZSWErj+vSfC+/gTC310TjkuDo0aKPo2vFplDEIl3wWqdWGI0DsfhyecEkkvGqxtSgzCNUvHc9PyyYHFS+KkWVXP1hkAgcGkzlHm/0A5300XLv/NoAjkEKjA3Lawc/fkTLQ+VNTX0G0ZxMN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 343581C1A4E;
	Thu,  4 Jun 2026 09:10:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 1B64620010;
	Thu,  4 Jun 2026 09:10:10 +0000 (UTC)
Date: Thu, 4 Jun 2026 05:10:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 peterz@infradead.org, jpoimboe@kernel.org, samitolvanen@google.com
Subject: Re: [PATCH v3] tracing: fix CFI violation in probestub test
Message-ID: <20260604051008.47264843@fedora>
In-Reply-To: <20260603153147.573589-1-eva.kurchatova@virtuozzo.com>
References: <20260603153147.573589-1-eva.kurchatova@virtuozzo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6smcz7xwn5kotkj6z18k5pw6cghexbum
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 1B64620010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+e2yPlBhebdtSlUxA+VsWKvcU/WlRxqAM=
X-HE-Tag: 1780564210-873366
X-HE-Meta: U2FsdGVkX19/bYHi6qBdqFbtlXpIYV5nSJOj1Zh2EqhlUV5LRqOiKm/2gZK/EyGKCraHC2R6Zy1IdlRHHHunq9r4HZScl4nvQAFN4fhhsiNb6PG23TfOGLQjvRgI+WMc1lPhL7xOGtlPijwGAviwg/GLZ3CygOBS6NGNIUgTfTkll+UHxbPz/hUVphR9s1FEhFj+3086R5hn7Do3mYbilrJQ4sNvKUJ6q85gepaAKroZoDB4mB+fZR5bzmW4gDrh/F3zHCAzviFMggkPyB0pkCQl+1SYAi9SszbqxQFk4AuuRbRRKW1ayVGHMbs0kw4YnOfgn1NamwS4sBNiwoyoWISrYN7HjisIVW3XCM6ZuwUvtb/gt3pgiexyf0qoHQTHqCKpwVo/N6wdH8dNiupjdZ0wHSSq5KF0tal3WivwVydUJhexdmeSCAE4iWwZM/VtgyNlAgJUIVg55AeM/xLOtRCsH9v1SSRN1h1P7kUqER2iPEGM9folAOeh/VklIvU4ay1uD41fn6Hsz/wQ1qrMrhEeU+YqPhw8HJiMNCkpRoI=

On Wed,  3 Jun 2026 18:31:42 +0300
Eva Kurchatova <eva.kurchatova@virtuozzo.com> wrote:

> When multiple callbacks are registered on the same tracepoint,
> callbacks will be indirectly called via traceiter helper.
> 
> Pointers to __probestub_* callbacks reside in __tracepoints section,
> which is excluded from ENDBR checks in objtool, causing objtool to
> assume those functions are never indirectly called.
> 
> Registering multiple callbacks using sched_wakeup test will result
> in #CP exception due to missing ENDBR in __probestub_sched_wakeup
> on a CFI-enabled machine.
> 
> Fix this by adding CFI_NOSEAL annotation to probestub declaration.

I took this but rewrote the change log as it is still incorrect. It has
nothing to do with multiple callbacks attached to the probe. It has to
do with how tprobes works.

I updated with this:

From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Subject: [PATCH] tracing: Fix CFI violation in probestub being called by
 tprobes

The probestub is a function to allow tprobes to hook to a tracepoint to
gain access to its parameters. The function itself is only referenced by
the tracepoint structure which lives in the __tracepoint section. objtool
explicitly ignores that section and when processing functions in the
kernel, if it detects one that has no references it will seal it to have
its ENDBR stripped on boot up.

This means when a tprobe is attached to the sched_wakeup tracepoint, when it
is triggered it will call __probestub_sched_wakeup and due to the missing
ENDBR on a CFI-enabled machine it will take a #CP exception.

Fix this by adding CFI_NOSEAL annotation to probestub declaration.

Cc: stable@vger.kernel.org
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://patch.msgid.link/20260603153147.573589-1-eva.kurchatova@virtuozzo.com
Fixes: d5173f753750 ("objtool: Exclude __tracepoints data from ENDBR checks")
Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
[ Updated change log ]
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 763eea4d80d8..2d2b9f8cdda4 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -20,6 +20,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/static_call.h>
+#include <linux/cfi.h>
 
 struct module;
 struct tracepoint;
@@ -389,6 +390,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	void __probestub_##_name(void *__data, proto)			\
 	{								\
 	}								\
+	/*								\
+	 * Annotate the probestub 'CFI_NOSEAL' to stop objtool from	\
+	 * requesting the kernel remove the ENDBR, because the only	\
+	 * references to the function are in the __tracepoint section,	\
+	 * that objtool doesn't scan.					\
+	 */								\
+	CFI_NOSEAL(__probestub_##_name);				\
 	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);	\
 	DEFINE_RUST_DO_TRACE(_name, TP_PROTO(proto), TP_ARGS(args))
 
-- 
2.53.0

