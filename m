Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389CF226CF6;
	Tue, 10 Feb 2026 00:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683272; cv=none; b=TLwP4V1bYDNXbQV7BlYDcMw69H+vL9iMBXuPn19RgQZ9LLLy8niv9Y+vb3DR46pT5Xa0sRxQBNZvwLkQm5WILGIX2DUr06zJCbeUom7jYljDjnkNbUxWHCANhc+gMXdiJxGkGROqQrfZagP/sSxhQ6Kzc8B97hyQH0N6DaV5Yr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683272; c=relaxed/simple;
	bh=QP0/A9y6C6heqIf0MuwaI3QW+w5fYdMCFBD3Z1UnalY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hYRX0bQKDM+LI6nxf2/iQzzbUlO0r+d6t1HqXpIwMeHD0cmuJ1JWY7k3/lMLMEwki6QCgVwbij1m7i7JjzPkcMh4I++HMhptBjgQldrouVlYT91ae1wgoSFaQhP6EKawvegp8No4hOSD+kxT1zgO0sGh7M6HB7ipPTLuEzd/CeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id E824C1B2EF1;
	Tue, 10 Feb 2026 00:27:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 4860A2E;
	Tue, 10 Feb 2026 00:27:48 +0000 (UTC)
Date: Mon, 9 Feb 2026 19:27:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] tracing: Move d_max_latency out of CONFIG_FSNOTIFY
 protection
Message-ID: <20260209192746.70529899@fedora>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xrhpe4ja6k7ejrow4i1m3ia4yajehhbf
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 4860A2E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18mfVrp3D7rhil+k/d7+7ngwRJf+bsjyOU=
X-HE-Tag: 1770683268-134686
X-HE-Meta: U2FsdGVkX1+s9RMH9yFb6K4WPuuyPJMpPqE8x2XEnds7sqDGURwRg5whT6U7u7WvlxgSe24uGhnp2uxMhQQlHt92BVaz1l1NprCUb8elX8u7AAgb+wKwtBax2N/wS/h/EuDLoj9I6waF0Bsgv8SWDU9kpfuecUEh3bQwnkEGdfanzigqadAM43+rAWKfaZ4izqjaqsh873Ew4QAjkTzzhPxIwQDQ4e5mraxJ0LV2hQdnbSnLIyTnl+G49eT8LAVOPzkiBxx3g1iMmsNwSqur6E5zwkiS5F6dFVRXJm2hL+DioaEjv47j28QBIUMxg0mbbEffPmg7P7US1mROvbhCBe2rH7dNXaHVDzi24GmiTfvIus5E+3jWAuAYMFTpoOXiDIAtlvahkuDyFBajljf25MHI0tVJW34btHVtsuct5fY=

From: Steven Rostedt <rostedt@goodmis.org>

The tracing_max_latency shouldn't be limited if CONFIG_FSNOTIFY is defined
or not and it was moved out of that protection to be always available with
CONFIG_TRACER_MAX_TRACE. All was moved out except the dentry descriptor
for it (d_max_latency) and it failed to build on some configs.

Move that out of the CONFIG_FSNOTIFY protection too.

Fixes: ba73713da50e ("tracing: Clean up use of trace_create_maxlat_file()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602092133.fTdojd95-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 31fb137e1c66..c08edaa7d179 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -346,8 +346,8 @@ struct trace_array {
 	spinlock_t		snapshot_trigger_lock;
 	unsigned int		snapshot;
 	unsigned long		max_latency;
-#ifdef CONFIG_FSNOTIFY
 	struct dentry		*d_max_latency;
+#ifdef CONFIG_FSNOTIFY
 	struct work_struct	fsnotify_work;
 	struct irq_work		fsnotify_irqwork;
 #endif
-- 
2.51.0

