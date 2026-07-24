Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED61543CEE7;
	Fri, 24 Jul 2026 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913836; cv=none; b=ZP76FkI6yeJ2O1QOlCGg1KSR0+W/UVlDknOlassyQ/oz/ZxwkTNbjKW8YYudEBql5pPVr3pNSbOS+qN6v6l4iQKDzuo0hLmbFGXJp2DGdl24l8lyCCaYAN6hwqCcf53929WcQAnLJctUxrhExV/H4bhPf4VXFTV1xbyxmAnHRNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913836; c=relaxed/simple;
	bh=kFTB3zM2liSxnFOeyMCY9Avdx8ZrP0mW0fYyZEZ1K9c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Yb299Heegsk4eHABFP0Pvu/i5ChYagldnsYUgT0443VTPiw8Ni11DSjkgrnpjZgo2AYWM20pdPU8fNqUNbJrCzilsVgVbRUPHRHCqh3xzt6h+RDeJx+24tY1ceqaOUR+LjM98Szrt+zrdbWrFq0FlWd730R7a+jJG3gmGsdRT8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 88615402FE;
	Fri, 24 Jul 2026 17:23:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 0642A2000E;
	Fri, 24 Jul 2026 17:23:50 +0000 (UTC)
Date: Fri, 24 Jul 2026 13:24:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Delay module ref count for "enable_event" trigger
Message-ID: <20260724132415.1b5005db@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0642A2000E
X-Stat-Signature: i7ybatrkwx3codoa4cja3zja165bo994
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+lJLUje1q5HJrwQa6NG1hROELO+yXUFBQ=
X-HE-Tag: 1784913830-132034
X-HE-Meta: U2FsdGVkX1/KchazAR5R6yhpXVB1Zboe+M2Z8eXYPETqG2m4pZmLm5tA8s1O+Op02P/Gq9BQitj7dS7ZDU0XWIaD98IodgA1XY/Wt+xULNTCpDBZqt4X9icIZ2MvwTdTQFEbyHkII8hQXO5AeIvhZ5/YZgTFlOD62J5QMc6pEote+8u4YYXosRIfAZG+TQUDHDA1vPW02Mx1imGiCFTDrD0en4Lt82eAsbBzEZQIfRZ/l+eVOkwgCerx4EUoqAJYOE3ste4LvJfg8CCkEwZxMe3g0Qq1TYWzhFoWhCG3XGcFW04LuNa2Pq7paeT42Z4V6AB7NQaB6YdHvM0iszrbHFj4RGWJ2CL3QMA7YjGBAudAqqvDcfF8jW2AN76wYStd+dboH8Z+uCKuWeVlljUVO9K5KbIW4ihLKyNjYeSqkNev7TN7hvdoT2RdGbrYXs3JJ/2QttnT66EjV4oMN/qetGUJZhz+6MDXdL2YZ2apOzg=

From: Steven Rostedt <rostedt@goodmis.org>

Triggers are now delayed from freeing, but can still be triggered until
after the RCU grace period has ended. The freeing of the enable_event data
is put into the private_data_free() callback, but the put of the module
refcount is done immediately.

It is possible that if a module is removed that has an event that would
enable (or disable) it is still active, it can read the data of the module
after it is removed causing a use-after-free bug.

Move the trace_event_put_ref() that releases the module into the delayed
callback so that the module can not be removed until any reference to its
events are finished.

Cc: stable@vger.kernel.org
Reported-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20260724030523.19081-1-devnexen%40gmail.com
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 46e60b70a4bb..ad83419cb420 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1726,7 +1726,10 @@ int event_enable_trigger_print(struct seq_file *m,
 
 static void enable_trigger_private_data_free(struct event_trigger_data *data)
 {
-	kfree(data->private_data);
+	struct enable_trigger_data *enable_data = data->private_data;
+
+	trace_event_put_ref(enable_data->file->event_call);
+	kfree(enable_data);
 }
 
 void event_enable_trigger_free(struct event_trigger_data *data)
@@ -1741,7 +1744,6 @@ void event_enable_trigger_free(struct event_trigger_data *data)
 		/* Remove the SOFT_MODE flag */
 		trace_event_enable_disable(enable_data->file, 0, 1);
 		data->private_data_free = enable_trigger_private_data_free;
-		trace_event_put_ref(enable_data->file->event_call);
 		trigger_data_free(data);
 	}
 }
-- 
2.53.0

