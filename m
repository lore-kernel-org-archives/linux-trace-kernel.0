Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA5B334694;
	Thu, 16 Oct 2025 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635724; cv=none; b=V2/AFaCVtlk0lYrSXn8lJDbF9z0IdhRABfDUwO7IELM7FE1jKn/ILMmLecHy+dUYpQCFZRNkxCJaelTDig1DOEKW1H12iR875GvbHGZTQDcP17H301jJo/1Mj+KnBNjm8aId4fuCR6e2khV6tlWvJJcQaR6QUBSZ9Acfgc1hSlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635724; c=relaxed/simple;
	bh=R/q/AKN2X8TLTOQ+04qUt9yLcp9CCbLu8xq3N5p6yXo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WXSnCeRnoA4mHkEeGaGIdGNWu1+wkoU2hpkrn/z3qeUttrWYISxVy57o7Jx3UJj3s7Qk7COnXbDg0Km5cJSXjkwzFX87xHYvcoQ6Tax821t/+S7HGoQkdvEa4cTTMPjwhs19xx45ngTaj8KHYYZUrtC6j4e67VmV00O26bZWjfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id B7FDE1DFFC0;
	Thu, 16 Oct 2025 17:28:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 1069B20030;
	Thu, 16 Oct 2025 17:28:37 +0000 (UTC)
Date: Thu, 16 Oct 2025 13:28:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Do not warn in ring_buffer_map_get_reader()
 when reader catches up
Message-ID: <20251016132848.1b11bb37@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jrtpowyrq4rwezqzezthq81roqzfrgix
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 1069B20030
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19CXbz7v81C56kjBpRUdeWMNvKgDKnoavs=
X-HE-Tag: 1760635717-439770
X-HE-Meta: U2FsdGVkX18Mrtb3j9AjBTGApz6ZsHMt0y6PVr3shpzIvHXVMudSXck/SZMExRm5CHXnXz9sdZrSl875wtC+awQnY71bHJkek7XfjfqJvTmUCgaH0JNHBgTQ1llsjS/LPbf65pUigkEfz6w3VeXuqAANu1ow2zSDAjUCsmeC6oNydFfHo0ZS3dkA/QCPdCtVEFmzRvgHrXXMVVapM8R4MGecVAUZ9M1LqKYIjAfJR19LOAE8+60JCEoRUpapOeih9Jji7Ub9TpD0sGwtXHmSIGg5stPLKbfDof1RFcpuITOu5coB7+k6rAHQ5XP95CYTY3/9eQJ/7d7ieZ3bVchyOq5sKXSwCfkGNrvvMpbYiaIAzhAalTnnPEIlI1UBk3VZWBjzhWN4S51aRwCypnNmzA==

From: Steven Rostedt <rostedt@goodmis.org>

The function ring_buffer_map_get_reader() is a bit more strict than the
other get reader functions, and except for certain situations the
rb_get_reader_page() should not return NULL. If it does, it triggers a
warning.

This warning was triggering but after looking at why, it was because
another acceptable situation was happening and it wasn't checked for.

If the reader catches up to the writer and there's still data to be read
on the reader page, then the rb_get_reader_page() will return NULL as
there's no new page to get.

In this situation, the reader page should not be updated and no warning
should trigger.

Cc: stable@vger.kernel.org
Fixes: 117c39200d9d7 ("ring-buffer: Introducing ring-buffer mapping functions")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1244d2c5c384..afcd3747264d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7344,6 +7344,10 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 		goto out;
 	}
 
+	/* Did the reader catch up with the writer? */
+	if (cpu_buffer->reader_page == cpu_buffer->commit_page)
+		goto out;
+
 	reader = rb_get_reader_page(cpu_buffer);
 	if (WARN_ON(!reader))
 		goto out;
-- 
2.51.0

