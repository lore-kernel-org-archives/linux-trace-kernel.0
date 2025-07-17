Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401B1149C6F;
	Thu, 17 Jul 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772341; cv=none; b=Wu0QfIJh+jSSe6HjG7EGNP0UHrbslFm/zyQaIyLq7FS1708x/ooPyTJDNDmdFPJtUWa2zP9ypGr3/rJT7vxSYeNnSPOsGhcTimZXacGXNchT+JCAYG1A8HqS65Ac/vd+aUJyt2yQiE4ea6Wi85CyyzKv7cKGBiCbOk3OxlhT89k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772341; c=relaxed/simple;
	bh=ZPiHZveIgHkC8Rb4EfBSqm3b8SH1Bb+V4gSOdOS20rU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UOTnJguLoPBn/zTbqjxlYJzsdDMIfeeLKxQLdYvkLCz03t2RCTQm1YJersBeVq+hmHJj1Dn+yG1Tfj/lnX7R55wRVKb6CFhfWwTV9A2ititDcI6p+npgh0ECLbyQUfF9seM9nezVcTt7NFlwOXazUIuS1kiKogZWbvEcTwjVNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id BCE921A0199;
	Thu, 17 Jul 2025 17:12:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 110E12000E;
	Thu, 17 Jul 2025 17:12:14 +0000 (UTC)
Date: Thu, 17 Jul 2025 13:12:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Fusheng =?UTF-8?B?SHVhbmc=?=(
 =?UTF-8?B?6buE5a+M55Sf?=) " <Fusheng.Huang@luxshare-ict.com>
Subject: [PATCH] tracing: Add down_write(trace_event_sem) when adding trace
 event
Message-ID: <20250717131204.74559b88@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: e18m3jhaxdoxsa17kje4zjqqa94ts8p9
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 110E12000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Yn2W1Qzph4pmF+6OL4cYJlq+h/qnJk3s=
X-HE-Tag: 1752772334-163259
X-HE-Meta: U2FsdGVkX19Dr3lVlSvW7gx1g4ZfQaaJZ+FkKNVJIVoWdmSIpmjYGXliui2ZJToqkfxLy6159cgk6SW6FSDfLurcRhXFDCBHCJ0wvCzdbEII9R3cpEP5AXK8OEH85So8XrCZdnpXYcqbpZpcRPzoVXiuBFBNekXgY93meXDV4T3XWEkXJ9kX9h0o21+pJhrBS75OtBrp1DAn77gymA/jf97eU3b45aq750x7DI2SQim63/FQNhe903JNsCDXz6lNanLXI/BtEBANBIQCMdos4ofz/3EUVCooy5FbCgCamGxowk3+Ce6ry/FSOMe4PbHpoDtcpNEwOzQPIfF9Qf7wpPD0wP4pM3Mbt+Sk0Gy5muHtW2XSe04C1GWwASiHys6zDiSHFML38eCAuUNlIHRKPe5yH8JyCtSIuXawrSuARM32tQ3tdDZlhQRmrMYtiTwCHMPBQ3u6a97DgDpMJfTcOA==

From: Steven Rostedt <rostedt@goodmis.org>

When a module is loaded, it adds trace events defined by the module. It
may also need to modify the modules trace printk formats to replace enum
names with their values.

If two modules are loaded at the same time, the adding of the event to the
ftrace_events list can corrupt the walking of the list in the code that is
modifying the printk format strings and crash the kernel.

The addition of the event should take the trace_event_sem for write while
it adds the new event.

Also add a lockdep_assert_held_read() on that semaphore in
__trace_add_event_dirs() as it iterates the list.

Cc: stable@vger.kernel.org
Reported-by: Fusheng Huang(=E9=BB=84=E5=AF=8C=E7=94=9F)  <Fusheng.Huang@lux=
share-ict.com>
Closes: https://lore.kernel.org/all/20250717105007.46ccd18f@batman.local.ho=
me/
Fixes: 110bf2b764eb6 ("tracing: add protection around module events unload")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abf..552c92911e2c 100644
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
+	lockdep_assert_held_read(&trace_event_sem);
+
 	list_for_each_entry(call, &ftrace_events, list) {
 		ret =3D __trace_add_new_event(call, tr);
 		if (ret < 0)
--=20
2.47.2

