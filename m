Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899B4FC8F6;
	Tue,  8 Sep 2026 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874780; cv=none; b=eE3mtwjXFi8k1eTqynQG0LyWgoXLRQMJGP2Ctcab2TSAHPFsB8jtrF16zGuAXdzKqNEZUZelkDY/jNJtjyFlZ2WGkQ4KuT1Yk1rOzha89/KF31b8IBgHizKFelJW4dofowPUs2zJEb14qCpJRKsrotKQR4F2AWdWg5y6rmNX+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874780; c=relaxed/simple;
	bh=mJIId2SG/DApe53JkGn9U6e1GVax4WGYQiytD1mHnd0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PB8b23Eo8BElkouDizeN7kC5hvtST2PIdciXn9fos8IHAKLGrEFa/7JHV9jQvzR415ssDVOT9zwDeUOaccXvdbmaqJG087qx7YQ7hohe0nEp+jZi9oFc3xrQmOEbMtgfPBKkSyXFRg/Sq55tRDkxg5M3H2d6LVlAHz+jplQmhuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=suJHOVuK; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="suJHOVuK"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 2B55CA06D8;
	Tue,  8 Sep 2026 13:39:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 4606F20024;
	Tue,  8 Sep 2026 13:39:21 +0000 (UTC)
Date: Tue, 8 Sep 2026 09:40:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Vincent Donnefort
 <vdonnefort@google.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: [PATCH] ring-buffer: Add a MAINTAINERS category specific for the
 tracing ring-buffer
Message-ID: <20260908094035.0b180833@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4606F20024
X-Stat-Signature: rg9hhdjkzd6f6otuzqn4mw53woao1ei9
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18CN4A85BQPBe5+wWf3JuXp3pbGA1LwvaI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=kZ6ltbc+kee29n1wPsToONv5ZZsAdG14wi0YCLinLKQ=; b=suJHOVuKGjKmCfQusyK1VqYaQot4HUkFrnRAZHKUZ9S6XX3vUSFZ0pmFsk+qRAr3HdWvTQ9f9aIVMUeBMqtLSm6pR7F62QdmU928tR9f5je8TBATCJ+lMrsWTYQ3Kh0NoFe/xcJCQopDS/75uYs7dKxP2QGzkEItJKBqoi/F5fA=
X-HE-Tag: 1788874761-143922
X-HE-Meta: U2FsdGVkX1/+Iqkp1MAOogVscGZvFVmbUg2auJShrWbIrj+8N2W0nSyqSa4oZX7/8AcPo21yx1CWPHhel/jk3kf0v1FvHv7+zXz4a4nbQAer38CeTHQGyY+G7nYTLVuHJeY2DRV5cONMffxaCKfYB+3YoEh5MrIDUO9zHvQDWC8QXG/s+1df9//4A5Z/nzMeLsKpg/n1THrCm7xnOwTpX+F4fnNnEwbuIIrgOp/fmqrG/OpWiJtUUifn/8o3ZuzAjmWQ4quRGFImAHB246KAsuWFwtujv6R2PEVpZ25TnJqSNNiBq2wJcSvmIcdYC+T09ti99baHOAbUY9a5mI/xEvlWmwraM8UZI1f4M008WA/BvV41EukdKgrKP0qvVEYkINd9ljn6B3bwwho/XDRalx7TY6CHcEB81R6fXCpU/bFcPTuVzvvuktVQlvQye6uxHYkKS7sYyw3jns7t+/2+aUIHVd74JNvcA8WDZsInIMCMYW/A7dENdSjm/dDKiFA0

From: Steven Rostedt <rostedt@goodmis.org>

The ring buffer code in the tracing directory has always been decoupled
from the tracing code. It had a clean abstracted API to allow it to be
used by systems outside of tracing. The API even allowed the ring buffer
code to be drastically changed without affecting the tracing sub-system.

Recently, Vincent Donnefort has been contributing a lot of work to enhance
the ring buffer. He implemented the user space mappings and recently
created a version to allow pKVM hypervisors to use the code to trace
the hypervisor and expose the events to the user.

Create a separate category for maintaining the ring buffer code so that
Vincent can become an official maintainer of it. His work has little to do
with the tracing code itself. In the future, he may even be the main
maintainer of the ring buffer.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..71bd2f57055d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27778,6 +27778,22 @@ F:	kernel/trace/trace_irqsoff.c
 F:	kernel/trace/trace_osnoise.c
 F:	kernel/trace/trace_sched_wakeup.c
 
+TRACING RING BUFFER
+M:	Steven Rostedt <rostedt@goodmis.org>
+M:	Vincent Donnefort <vdonnefort@google.com>
+M:	Masami Hiramatsu <mhiramat@kernel.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-trace-kernel@vger.kernel.org
+S:	Maintained
+Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
+F:	Documentation/trace/ring-buffer*
+F:	Documentation/trace/remotes.rst
+F:	include/linux/ring-buffer*.h
+F:	kernel/trace/*ring_buffer*.c
+F:	kernel/trace/remote*.c
+F:	tools/testing/selftests/ring-buffer/
+
 TRADITIONAL CHINESE DOCUMENTATION
 M:	Chen-Yu Yeh <chenyou910331@gmail.com>
 M:	Weijie Yuan <wy@wyuan.org>
-- 
2.53.0

