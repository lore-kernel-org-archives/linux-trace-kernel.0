Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831B246BC0;
	Tue, 10 Jun 2025 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562344; cv=none; b=GNN00NQTCv0dNyLJABnwMIvx9ni/GvG7JTH8kZQaC9cpbS9gEiXqVr9HpBqtfg9RF43P6KsDN2wcnt0TJFspd8XVR16sk6wvHhCp2kYKnefYmG72RxVlrNGA7sLd1fxhvDN0OItN9SebKtcTYFbmR3pavAc7Fk7tP1FuWHNOGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562344; c=relaxed/simple;
	bh=VeRRqAMQwsV9AjP9CYbvqZkSDgtiD6xuz7fHbLhSbnA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=M3gmgIstj1BaccwQredb1zR25O/UM3QVBzr38WLNTtCDaodjm2bg/Jycsr9/1GoRf6rbcLNWdDoi9o38JqkHPyBagGIe8IaOmfgHf4ydFwhfmI/+JvEgQt6KTpj722lPE+EiSIIiuLEzx4jrUpx4zNXxh6AaTTF+fRl4PD3vyoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 771C158BC6;
	Tue, 10 Jun 2025 13:32:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id A032C2003B;
	Tue, 10 Jun 2025 13:32:18 +0000 (UTC)
Date: Tue, 10 Jun 2025 09:33:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] tracing: Do not free "head" on error path of 
 filter_free_subsystem_filters()
Message-ID: <20250610093348.33c5643a@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: A032C2003B
X-Stat-Signature: u5szw3tasguzey7x9yqnn1fm4cpsdkj8
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18teGOKpr+gusiYZViqrtt0SH+AHwK4pL4=
X-HE-Tag: 1749562338-672093
X-HE-Meta: U2FsdGVkX19o22b6/1AqabH+17ZgdEx9/+iJe8gTqjfMpZMTd1HAM2PlDfEbaosybXJ167UrtDeE9LwfI18yH4c6g/42OlR1oxLR+B0t5oDSG9XnwCWpdWN+1xCOXFCu/N5NolV6sfuz8ZHmwO7OOVn2wIeiM3oI+6tRQ6uPYAb6en8kIwbT6rMsqfINTk2Nj6DzIhXorlJSLzYU8jRhseS79CcEi6WeCDs+K7EHMdq+rUHVgU+WSA7ZWdnMD7b6piwhrRbSfYJUFDt9xTzmAfr12ma75Cus9AhhgWrXAmNJH48KZ7kJ7Ciye1tfnxrerikSJ2FNRPE5cK5SSCCo//ckmEhzgveGujSLheor0ZSj1ehZzlfBe0+iVj/7oVl3ZYGaNdoLlfzBKyAMlpl6yrXvERcuh86xvZA5WDAtMHWX2De7Xc3GP0PmtQqad69KXP1nWBdczkL0bHi1jJKk4gRbmqL65qCeQNmdKBxFRoqVhADsLYhjGZdEJI0zw+vxoKjCwUfjzUc=

From: Steven Rostedt <rostedt@goodmis.org>

The variable "head" is allocated and initialized as a list before
allocating the first "item" for the list. If the allocation of "item"
fails, it frees "head" and then jumps to the label "free_now" which will
process head and free it.

This will cause a UAF of "head", and it doesn't need to free it before
jumping to the "free_now" label as that code will free it.

Fixes: a9d0aab5eb33 ("tracing: Fix regression of filter waiting a long time on RCU synchronization")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202506070424.lCiNreTI-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index ea8b364b6818..08141f105c95 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1437,10 +1437,8 @@ static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
 	INIT_LIST_HEAD(&head->list);
 
 	item = kmalloc(sizeof(*item), GFP_KERNEL);
-	if (!item) {
-		kfree(head);
+	if (!item)
 		goto free_now;
-	}
 
 	item->filter = filter;
 	list_add_tail(&item->list, &head->list);
-- 
2.47.2

