Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB9C2FB;
	Mon, 20 Jan 2025 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395866; cv=none; b=cDki+1CdULNLkVp9Fz38lwVFx/Eett+YOlXUGOAwQYRZOrU+xSHPH50LHA3UVMnLzoYLw4S/VwWFIWpscozhvRjywxJH5IaX9QR0HPBNi5+UtKSYV9ThfWADSG9x/iJterfdDp6+0oyomxDPWAHbtPu/EVvp1u++Tfv2HPT1NYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395866; c=relaxed/simple;
	bh=OH/EvH8VozFDc0cnqUzfGkuUFlAc/vz17FGoLNFzDns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=O0DW1eg/Zz553VlwJiBeD92G5HXTlAJeUBEXGa0d07bbKOBTgLTWTv6vGRQI0pYy3Mf3J1AJH5AK+O/iwj8lt3dXzMuKFwPL6ms4uUUNxAcTUtAO7zCKSaVf7W9N5oq6Dn90UQKieM5OoO4xzVbtSNDcdurbnwcpwxM9GqmNoUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E92C4CEDD;
	Mon, 20 Jan 2025 17:57:45 +0000 (UTC)
Date: Mon, 20 Jan 2025 12:57:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>
Subject: [PATCH] tracing: Fix #if CONFIG_MODULES to #ifdef CONFIG_MODULES
Message-ID: <20250120125745.4ac90ca6@gandalf.local.home>
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

A typo was introduced when adding the ":mod:" command that did
a "#if CONFIG_MODULES" instead of a "#ifdef CONFIG_MODULES".
Fix it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501110319.xY9ltUxL-lkp@intel.com/
Fixes: b355247df104e ("tracing: Cache ":mod:" events for modules not loaded yet")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f762e554fad4..bb1406719c3f 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -857,7 +857,7 @@ static int ftrace_event_enable_disable(struct trace_event_file *file,
 	return __ftrace_event_enable_disable(file, enable, 0);
 }
 
-#if CONFIG_MODULES
+#ifdef CONFIG_MODULES
 struct event_mod_load {
 	struct list_head	list;
 	char			*module;
-- 
2.45.2

