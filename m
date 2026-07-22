Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEFB3659F9;
	Wed, 22 Jul 2026 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784683196; cv=none; b=bq9gD7dx9YuVKAntbtRh90aMYTkXTzOUwcDtiD74LS+UBlAuBAJqWMzD0+seTz9oLG/78GCZWErjGm9YcLXODvYlyWqKrtbk7wOUsAZ+yMbHa5WEd+r6tddl5K8SYp17cwl1EwkstERse3eZ9Lq9hzmexVZtcM6QCj/MfUA5VsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784683196; c=relaxed/simple;
	bh=DdIdiZwVAgZcV6ZKm07x6lhSHNvPVIPbcPtRgJ/q/qI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=El9z3uQwut5js8W17jV9Eporc0waSnI7gMwtwQfJwoa5htBHLW28Mgydwsr5ZYGgnqleE0/MRIUGoubplaIYEf5A2qPH+ZR8/k8Dke2R4OWR8emIfbNqsOQ1gQVBhF06sk/rCnq8JXJi3kXzcmSc8gYoMeTU5W3eP+V1jbZPlzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 9BDB3A0482;
	Wed, 22 Jul 2026 01:19:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 1113A2002C;
	Wed, 22 Jul 2026 01:19:50 +0000 (UTC)
Date: Tue, 21 Jul 2026 21:20:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Do not clean up hiter in mmiotrace read function
Message-ID: <20260721212010.76e9ed61@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: msxtwszk35iz3x9btj7qaiahw3cyc6md
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 1113A2002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19H9YqhLWq0oxWwSEz3G/CvtjowTRQibZU=
X-HE-Tag: 1784683190-118970
X-HE-Meta: U2FsdGVkX196lAzIO+CaTlsROr+Spso35hDqRIKXVuENWEb6TiENnzmbJxp0qfauLXZCEeSrjx0Wwa9UswHV1dLordQjrbaBAl7cdKGodeXp6kvLxdHCDICi+dEZvmTobWT+XOJEJiWkPynILypRbqnUSSadkXbePF6LjzIgFZ7MDE8BKzOtdX0DE3TpcustsXwowAH/gZupcGdZ2cwwC3+arX6rPy25k+zlc8Duor3KA/xcRfWNOQ4n+PbFJPAKxr4Nv/9a+NsauwKSsuH12gjkXFMEx+KVL55CMb7mLJFNEnciTFKpxwHShuGc5wCnil6XIGn70WcbEYksfsbZr+ruGvS9A7c3HOyhTqKnJf2VccLI8y0klGI/z1qzmlakDrFaleeO8kbcRQZRgyj0Sa1qaAgJxxUCJ+u8ZKopvuw=

From: Steven Rostedt <rostedt@goodmis.org>

When the mmiotrace trace was first created, it allocated a descriptor in
its pipe_open() method. Since there was no pipe_close() method when it was
created (in May of 2008, and pipe_close() was added in December of 2009),
it cleaned up the allocated descriptors in the read.

Now that the clean up is in the pipe_close() method that now exists,
remove the clean up from the read as it is no longer needed.

Also simplify the code by inverting the early exit conditional into a
conditional to perform the logic and get rid of the goto.

Link: https://lore.kernel.org/all/20260715143604.14481-1-gaikwad.dcg@gmail.com/
Link: https://lore.kernel.org/all/20260721211143.36dbd559@gandalf.local.home/

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_mmiotrace.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index b88b8d9923ad..ba604c22d2d2 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -142,21 +142,13 @@ static ssize_t mmio_read(struct trace_iterator *iter, struct file *filp,
 		if (!overrun_detected)
 			pr_warn("mmiotrace has lost events\n");
 		overrun_detected = true;
-		goto print_out;
 	}
 
-	if (!hiter || !hiter->dev)
-		return 0;
-
-	mmio_print_pcidev(s, hiter->dev);
-	hiter->dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, hiter->dev);
-
-	if (!hiter->dev) {
-		destroy_header_iter(hiter);
-		iter->private = NULL;
+	if (hiter && hiter->dev) {
+		mmio_print_pcidev(s, hiter->dev);
+		hiter->dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, hiter->dev);
 	}
 
-print_out:
 	ret = trace_seq_to_user(s, ubuf, cnt);
 	return (ret == -EBUSY) ? 0 : ret;
 }
-- 
2.53.0

