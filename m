Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795022727;
	b=DMtxKx6EJJlnIhlxy/ahQU+LM16RkVdDo9eg9yN4AdfsYLAeQj0qMRGXSjCWM8pS7AJS
	 zxbGA1I7f4OU+nPHbF3zb2gkBW9pbDUdBnmF55IiTH6mo4wiNBF8AXYP0C7wNuNBKQ1tP
	 AFnAwJq12fZyAzR3637upjbS6GZQyCNG41yPi4tgNgib/b7DPWJakd4pv226+R8VhF88L
	 mzpvOMXN7Sc3xa90+F5zSEE4yo3xEebuiDfLYNhPLAMCCp3kJekQiE3eXuK/6CprTJcXb
	 Ok3waHrR3aooSG9QYBda1b35Vpi7M1wziBrzcwo0wT5e9wZK1NFa1ZUr6vL+N7m5btA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022727;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Spam-Status:X-Rspamd-Server:X-Stat-Signature:X-Rspamd-Queue-Id:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=lAlZkFFvPUC1ahUVGV8q0/2eUbrqAK0tAlbDo9QLFvo=;
	b=5ZkQvTj3kcDuetRDk/vkr+nx9hgbK25CaPG7Jnzm/Sd/HcqerWHXvto8NdquxMhY4l3L
	 PSovQKchWJ2OcO4LCxl5YhTkaUPT6qhkweju7gGG7s1efUUe8h/ElEFlvkXPdC3sm/S7R
	 MO4PJrSlVQ/QU2XhPtPDhyddJ5Bdcnh8pWglmrEqWCPbPKMVnX5AIGnYa0195lrJePrPI
	 QMRb5zObPEOBdAymwd9Zzuz9hn4NEDQ2wb2rgLbaojmCeVnGCFfK6tNJPhTr57BnwvVAD
	 ameoqjtFIbw47QrLeD3yuwQlQTHy12F1wyLqMtN0KmnKlriRyhkpBjWYJb9FrSwrrbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Ul1Wa5cq;
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324A606A31C;
	Wed, 18 Nov 2026 17:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8324A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Ul1Wa5cq
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id BFEBD1407D9;
	Wed, 18 Nov 2026 17:25:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 294EB1D;
	Wed, 18 Nov 2026 17:25:23 +0000 (UTC)
Date: Wed, 18 Nov 2026 12:25:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Beau Belgrave <beaub@linux.microsoft.com>
Subject: [PATCH] tracing: Do not allow user events to add a system name
Message-ID: <20261118122520.4a689710@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Stat-Signature: pgbk7r7os4k5jcqjbggyujcrx1f3e4ez
X-Rspamd-Queue-Id: 294EB1D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/12mJxTvg5bPraYeiz1GoR8++kbc5wc7E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=lAlZkFFvPUC1ahUVGV8q0/2eUbrqAK0tAlbDo9QLFvo=; b=Ul1Wa5cqFzp/6Sr3kZEMLRqUubD1dL3wLUU6PktRbIfsE+1k89szLS6qB7Ouy31gfO+NSYyeY5EueAPCtA0AIKLlNXz64F/13SAtXIKp31m5peJ8vgu0G+KM1Z9NUU5YmDVFMKmVKAHLce/1OpPTt+RO87/jAQwznhFBNtYCZcw=
X-HE-Tag: 1795022723-160638
X-HE-Meta: U2FsdGVkX1+OpghJTkazZ+RSkD/abyBNt8kchnyJlFbX6NDdYXeH5nY5pSrUe1sc+DEFgh7CMDPNtvdEQqLGot31STwcoC4ulCtxdjeQSPnlm/qHFmnTcLgxuQJBtoWzmdfTnsUqt/S84QhaqHGBJWa0pC+3tFkMqfAGIhu4y1rcjizbrWskhNqHqJuKydjCM8bf9yLhKTGVBYiaQWvLEo2WgELIklzbMTx10myRNGmAvcSGkMqZV97ndTOfnO1fMvJ2nA4xaO7FfivEhjwTYp/xRjgonmlWGdnvKUV1o7ucrkZOSp+nFFQARpONKNXIXaz8rHhFQEAh9/Kz2VrPQ3q1zvl5FPZn8OBiA+t3/lICIyObtwzUGrSkx7XvXIBSN8rO00kmU2mn86bE/HQxz2jgydaqgOAF62PsCk9/DNN+SKuZlmaIKw==

From: Steven Rostedt <rostedt@goodmis.org>

User events currently do not support the addition of a system name, but
the parsing does not check to see if one is specified.

A kprobe can add its own system name with the following command:

 ~# echo 'p:mysystem/kprobe_event schedule a=%ax' >> dynamic_events
 ~# ls events/mysystem
 enable  filter  kprobe_event

But if one tries to do the same with user events:

 ~# echo 'u:user_events/test u32 a' >> dynamic_events
 ~# ls events/user_events
 ls: reading directory 'events/user_events/': Invalid argument
 enable  filter

It corrupts the file system as the event added had a '/' in the name.

Until user events support specifying system names, just return -EINVAL to
prevent the corrupted file system from happening:

 ~# echo 'u:user_events/test u32 a' >> dynamic_events
 -bash: echo: write error: Invalid argument

Cc: stable@vger.kernel.org
Fixes: 7f5a08c79df35 ("user_events: Add minimal support for trace_event into ftrace")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index f658c3a77aa7..5d41a28e4493 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1035,6 +1035,9 @@ static int user_event_parse_cmd(struct user_event_group *group,
 	if (flags)
 		*flags++ = '\0';
 
+	if (strstr(name, "/") != NULL)
+		return -EINVAL;
+
 	return user_event_parse(group, name, args, flags, newuser, reg_flags);
 }
 
-- 
2.53.0

