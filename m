Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B61EEDE;
	Sat,  7 Jun 2025 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749306429; cv=none; b=gpJIpe1OYkNYkuwUoDApb0KZMXBGzr+o9B0tbilVIqxG9B5PppeohwcokcbcSHn3zwlw+8+nzEKaQv4a9a1rOCtLsXB7LGMzOizbNdkGUeEkwYzJWRrV9I7ar0cXJZYTQzvfVgqi/Yy1sCUUpXNcnVUX9BLd9gpjfyZKe0Ig9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749306429; c=relaxed/simple;
	bh=QMjxoZ8qXLwUD4CsAbquyp2sisBQwy7tspEYYmHf4hQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=teiQrU7fj2bVvE2ghUMEuQqBZcX2GUCBeoybDZr8ItHNx9yy01htUpLlJk3gdPTsJibHyOgjXfSkPZkoosXMVJ/hp1KF+6M4pbHPtiAokJl8ukwqCWPMOWQtjx+0QbXdAs7JK8rb8gUnF8sWrjDW24HgInfATGqqvzVvpt6v/1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 9C5FEBE14A;
	Sat,  7 Jun 2025 14:26:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 1FEA02000E;
	Sat,  7 Jun 2025 14:26:58 +0000 (UTC)
Date: Sat, 7 Jun 2025 10:28:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Add rcu annotation around file->filter accesses
Message-ID: <20250607102821.6c7effbf@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1FEA02000E
X-Stat-Signature: tmkgfwqbzumb1kwskugydpwn5g49mps5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19XMeTW4TfddNXNDaC82KqTngsn6M0KlDg=
X-HE-Tag: 1749306418-897492
X-HE-Meta: U2FsdGVkX18iK57pU5RN/cMe+lJmV2uIWUa2B7uronNOg8wC+JYJ7kbXxcEJsEWKDShiRRdCjW8UqlSzQDd25GJu5gELRaTcmnlVLr4UbLWMzuPEiI6mN+/eGZ55Ps7UKy4NBgXm5BCmECvn/J8QRnNWyG0z1Edgc+dOjpLqAQCO1+asnmkeLWiPVSC2H7ot4OZ3esfz7E0lKmOqeRdU8pOAeEHXgLoN5PAUen0K1SQzDf9LokSORLQ3qbGBnwK0CAp0eMITXikx83nng5KLf0NsFjBna7cgHYjPDg2eoYYDdqf4UNfylZTh4OjPyaza2RTwzH5JvDcr52yicqY3HXTFC678g1hWsuN2YSdhKrZYh5O5EhRMAxukS0LFFy9+

From: Steven Rostedt <rostedt@goodmis.org>

Running sparse on trace_events_filter.c triggered several warnings about
file->filter being accessed directly even though it's annotated with __rcu.

Add rcu_dereference() around it and shuffle the logic slightly so that
it's always referenced via accessor functions.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 711520081741..ea8b364b6818 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1250,7 +1250,9 @@ static void append_filter_err(struct trace_array *tr,
 
 static inline struct event_filter *event_filter(struct trace_event_file *file)
 {
-	return file->filter;
+	return rcu_dereference_protected(file->filter,
+					 lockdep_is_held(&event_mutex));
+
 }
 
 /* caller must hold event_mutex */
@@ -1320,7 +1322,7 @@ void free_event_filter(struct event_filter *filter)
 static inline void __remove_filter(struct trace_event_file *file)
 {
 	filter_disable(file);
-	remove_filter_string(file->filter);
+	remove_filter_string(event_filter(file));
 }
 
 static void filter_free_subsystem_preds(struct trace_subsystem_dir *dir,
@@ -1405,7 +1407,7 @@ static void try_delay_free_filter(struct event_filter *filter)
 
 static inline void __free_subsystem_filter(struct trace_event_file *file)
 {
-	__free_filter(file->filter);
+	__free_filter(event_filter(file));
 	file->filter = NULL;
 }
 
@@ -1465,7 +1467,7 @@ static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
 	list_for_each_entry(file, &tr->events, list) {
 		if (file->system != dir || !file->filter)
 			continue;
-		__free_filter(file->filter);
+		__free_subsystem_filter(file);
 	}
 	__free_filter(filter);
 }
-- 
2.47.2

