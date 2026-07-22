Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A379C282F18;
	Wed, 22 Jul 2026 01:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784682695; cv=none; b=TOMCXcSPImcR2stO23ZDaf8jc4FUbyz6MTgkE7Z80J81H2JFR5KbLrIAfzAnq8Yo/hWix5gvohaWL/+mDByl8sHnafF65tq5xK8WjznsWnYEQWpksT3lDqvGk1wsHz2slrFfKIS0gLvlgULl3JDIdxBU8jUd3P470+zs8qz9h40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784682695; c=relaxed/simple;
	bh=S0IC7Lhl0SxfXzJCkSeuB4x1sy5XgyUtsk1ascIIJFc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CUI1/y803wQjSyZEYIdZFm19rm0jKo9DrkxSQvsnBpM8vkp3xDRE5RBaH+vKhF/8NH53gEkHqpcVdLJ7lIEF6tNDuk1bYApHyoL8FmbsKBcs6bwbGhZR2eQO90Kqe9paH5evb4W9UkdsWaDmD12CeDNXQKuMFguywxgFNBePf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 66FF0C0152;
	Wed, 22 Jul 2026 01:11:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id DE80233;
	Wed, 22 Jul 2026 01:11:28 +0000 (UTC)
Date: Tue, 21 Jul 2026 21:11:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Fix mmiotrace possible NULL dereferencing of
 hiter->dev
Message-ID: <20260721211143.36dbd559@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jhz8iig39uo4uiajjz8mx8th4ni8r5ot
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: DE80233
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18MD1yTveXFTETYCXfp2FVSeraat7QQjfc=
X-HE-Tag: 1784682688-914176
X-HE-Meta: U2FsdGVkX1+Ybu8zFG8uSidq8BZXboN8tGTrSqfquer35bJxb6Qz2qy1aOhoKwHa2pFXJ676YFBL6pSTznUd5ViKuc+YHh25/P5I5yW2FcmnIdjrE8UICj8dtZG9LrsJ3ntTlyKUcbwMc+fGmcLxQEmmEHY7pvi1UYwWobX2Q/GRUvxcxmBWheGdIHiwxjFFtWctG7CWqKjIuqT0SIVSPUQFze5CzuW8071/8RzQlz6eIX4IjlOjcm17eZ1I9Rs7JDnoCmsMvOvJcJpF2Ywu6II1TOC9PehtZwK7qGu8ENcZXFI/gVo3KS8tP7zCIRhUtmliZs4Tf71pEkG5/5W4hA2/yHKHNrCMdFOUMe4otFSU7AHidU64Rza4O/40AyHCa9f2xQCm3uHVk9LROmNcXcvPsU5z0IHuGVHIXSSKdcGZ5PqbBfRAU0rphCrc3iFp/t+DQN/4U5B6//sh6LaBDki7uU1v72LL+pG8toQ82Vk=

From: Steven Rostedt <rostedt@goodmis.org>

If the mmio_pipe_open() fails to find a PCI device, the hiter->dev
will be assigned to NULL. The mmiotrace read() function dereferences the
hiter->dev if hiter exists.

Change the test of the read to not only check hiter being NULL, but also
the hiter->dev before dereferencing it.

Cc: stable@vger.kernel.org
Fixes: f984b51e0779 ("ftrace: add mmiotrace plugin")
Reported-by: Sashiko
Link: https://sashiko.dev/#/patchset/20260715143604.14481-1-gaikwad.dcg%40gmail.com
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_mmiotrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 20812e7f911f..b88b8d9923ad 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -145,7 +145,7 @@ static ssize_t mmio_read(struct trace_iterator *iter, struct file *filp,
 		goto print_out;
 	}
 
-	if (!hiter)
+	if (!hiter || !hiter->dev)
 		return 0;
 
 	mmio_print_pcidev(s, hiter->dev);
-- 
2.53.0

