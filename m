Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A64F55D3;
	Thu,  3 Sep 2026 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456395; cv=none; b=DVDL7DtfRhT2CUi9aPxVwIX704oELyyp3suivSF2apGlt+9E7EjN+a4jH8qV1EbQ8uxOw2d2sc1qj5F0RGPoJdrt65eXQ5qXzCX2QqiM0O8B78QxdO0MNRCQlPSdQfkA5zEJbBdZSZirkNsVr1xO9BkOppS3KLM47NRErpH0+YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456395; c=relaxed/simple;
	bh=6MZkHmI7KIdxZmtzWmbWfXmFLSbXSnS/AF5iFuCjuGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=u/m6zH3cFDugXfWvTgksXdlkCck1cGuDq/B0gu678UtsjhvrIzxH7LtjN6g7s4IfhZDDu0/T85wswr59qfyM2KIX5ZSJ5BDA7HHAg5SrLedoVoM3mxyWcQvSrZpKL+ajMHaeZAlxYzy9ChY9gqBTuftOq74qg6ntjGnTrobTdqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=NIoAdcnC; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="NIoAdcnC"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id D0A5D405E2;
	Thu,  3 Sep 2026 17:26:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 27EB320030;
	Thu,  3 Sep 2026 17:26:25 +0000 (UTC)
Date: Thu, 3 Sep 2026 13:27:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH] ftrace: Add checking nr_subbufs to persistent ring buffer 
 validation
Message-ID: <20260903132728.7fb27d34@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xm63i8kti5fzcdp3aym4uo8sc86cj3zr
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 27EB320030
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18MTPDN1pO17eBclGPNQPbBTTtaEcie9Z0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Kx242b73O88THqGlqMnzySnHUjwHnJ8hlJwPqHlsHI4=; b=NIoAdcnCZwhRH6NcTIVihpkJJ5NvXHIlC7OADu5sN+BQntaIXkmW3kedJC693fghG+XTjZAF/8vqr9oPA9ZSGZCOFl6elpF/QjHcHQ+PTUTt79sWPS3ayr9udnXOf5OWkLTnYdoumISvSMwGf/nRwFnW4RlLW4LoGdCDkYo2ob4=
X-HE-Tag: 1788456385-270618
X-HE-Meta: U2FsdGVkX18msQmni3doAfXqNixdA771BOOqF/FKKjxMBIhv0NFnI20vm2C199Gzqc8Alp7VEydBQ+eZHFYj0vux1kUbbeS2hFe8Zl+/hQ/5e6OPR+govPV5bcHXu40hl2AmgQilzU3/1ES7lF0G4X1rTmM0P0dwLHC++edcTJXKc9hNzG6inEVBtgwtu6stPvdECKvrnDr5YhoLXwVGYQM6DaXnmzu8tzwLWm9rvLpmpQrto0/RhntjgS0WymF/uSmJg9lZjqN2IPAgl7yndRHd3M74Hm3heJSnIt2CD4cys6oU7HrvgNyyvKdU7LB89SnfsvZvmrx+3VIGFjHanl4EvvY2ztcWS1pYkVYny01wYygHAaA4OJ1tTF6E2rREXWGz7iYG0RhmUa6xFxV4/Q==

From: Steven Rostedt <rostedt@goodmis.org>

Sashiko reported that the code was using meta->nr_subbufs without making
sure that it matched the nr_pages + 1 on data that was assuming the two
were the same.

Add a check to the persistent ring buffer validation code to make sure
that the saved nr_subbufs matches what we expect.

Fixes: f5b95f1fa2ef3 ("ring-buffer: Validate the persistent meta data subbuf array")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260901164836.D962D1F000E9@smtp.kernel.org/
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ef66f726e2e2..748d4ae8badf 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1869,6 +1869,11 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
 		return false;
 	}
 
+	if (meta->nr_subbufs != nr_pages + 1) {
+		pr_info("Ring buffer boot meta [%d] invalid nr_subbufs\n", cpu);
+		return false;
+	}
+
 	buffers_start = meta->first_buffer;
 	buffers_end = meta->first_buffer + (subbuf_size * meta->nr_subbufs);
 
-- 
2.53.0

