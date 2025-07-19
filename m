Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721633FE5;
	Sat, 19 Jul 2025 02:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752892332; cv=none; b=QIj0/OULRjpO1u8h70/IdMlVBlBXbR43D74FJwdahpsgRA1IvYL+RmlyZFRfzElEjAPO0f4KOMhRpKHMaj2R/zWPVXXBGKGcpMM18nlGKk8TgxClqtcwle8nOH0CKiHYI+QeZP+opv55dGI+4FTvhLzWErKXsYs7fWik5GTQMbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752892332; c=relaxed/simple;
	bh=C+RX06bZJ2roYO7uUJxJKJHQGWqWMU/oDRVmdH9jc78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fJ1xq4ATt74BtJFFtdn2pysXK7RqYpoW76MWyZFuEjOyUSV67AVfsL5dvQNo+ivw4BIriFZtjNOr8GtvzNqELp06rDLCGKdkdiAv0rsXhLxhGxs3l1Wrz1KL831F8WZZlB0/EwpdOVO7qrSjMb9vmQJcRkPdDRj5CxzDz4ZfcPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id A5558C022B;
	Sat, 19 Jul 2025 02:32:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id EA1168000E;
	Sat, 19 Jul 2025 02:31:59 +0000 (UTC)
Date: Fri, 18 Jul 2025 22:31:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Fusheng =?UTF-8?B?SHVhbmc=?=(
 =?UTF-8?B?6buE5a+M55Sf?=) " <Fusheng.Huang@luxshare-ict.com>
Subject: [PATCH v2] tracing: Add down_write(trace_event_sem) when adding
 trace event
Message-ID: <20250718223158.799bfc0c@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: EA1168000E
X-Stat-Signature: eai81qj1a4tsyzt67eaapfg4o5zi8agm
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/711df1uyTR8PoPlwk49RnliuQLfdXotM=
X-HE-Tag: 1752892319-537452
X-HE-Meta: U2FsdGVkX1/Q9TtgtlJhhJ0dnwXqi/dS/RSb3cQLxHHqLOU27D/NNTmQEJlFYhnDdPtYcViKdd73P49NexXrg81ab8PBFPNQV8+a9bBavC4wihUIvk7la2ruI2sw4gc0L7hwZUa27C1qG7PfdlBi7G8dkxFfcGhOm+uE6pxaa3z35yZ0AnsQktNrQxStvSpjIgQU8sEMhbGA1+awtjNrbiUXXGF7TWWJDL/qi7AgaOgcXNCbZLls56bG6mHJ3ZhsUkdwYkeFvuhw7wyDIdILwHnY3qAeC6/PEhJIJ+67jaffcuwtD8+0xnFUglqUNpVgwwMuzN2QT/inLPA4TSJE0RIwIStgYSZK99gF4Z6qZVdfdJ3H1P8Nmemd0KeGvMLUZGn4RSNGpL588aLP14JmhPiHcCIx1hEwu7BbQoZJ/14b10Cd3A12qjfUaFZUcnJHaiOwWFcRhZ7riWxL+BLA4w==

From: Steven Rostedt <rostedt@goodmis.org>

When a module is loaded, it adds trace events defined by the module. It
may also need to modify the modules trace printk formats to replace enum
names with their values.

If two modules are loaded at the same time, the adding of the event to the
ftrace_events list can corrupt the walking of the list in the code that is
modifying the printk format strings and crash the kernel.

The addition of the event should take the trace_event_sem for write while
it adds the new event.

Also add a lockdep_assert_held() on that semaphore in
__trace_add_event_dirs() as it iterates the list.

Cc: stable@vger.kernel.org
Reported-by: Fusheng Huang(=E9=BB=84=E5=AF=8C=E7=94=9F)  <Fusheng.Huang@lux=
share-ict.com>
Closes: https://lore.kernel.org/all/20250717105007.46ccd18f@batman.local.ho=
me/
Fixes: 110bf2b764eb6 ("tracing: add protection around module events unload")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250717131204.74559b88@batman.lo=
cal.home

- Replace lockdep_assert_held_read() with lockdep_assert_held() as it is
  actually held with down_write() when it is called.

 kernel/trace/trace_events.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abf..d01e5c910ce1 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3136,7 +3136,10 @@ __register_event(struct trace_event_call *call, stru=
ct module *mod)
 	if (ret < 0)
 		return ret;
=20
+	down_write(&trace_event_sem);
 	list_add(&call->list, &ftrace_events);
+	up_write(&trace_event_sem);
+
 	if (call->flags & TRACE_EVENT_FL_DYNAMIC)
 		atomic_set(&call->refcnt, 0);
 	else
@@ -3750,6 +3753,8 @@ __trace_add_event_dirs(struct trace_array *tr)
 	struct trace_event_call *call;
 	int ret;
=20
+	lockdep_assert_held(&trace_event_sem);
+
 	list_for_each_entry(call, &ftrace_events, list) {
 		ret =3D __trace_add_new_event(call, tr);
 		if (ret < 0)
--=20
2.47.2

