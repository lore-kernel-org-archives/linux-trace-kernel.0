Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257D451A746;
	Fri,  4 Sep 2026 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547682; cv=none; b=o8RtlTRDtISbaBUa1lQsPhsFwKi0QcXo/ZBsaVDEYS58iYzqExasGn3L7VjcodtQbee/22mWhZwz8N47FGCuIY4NgRYK84CE2fPhYvA30rjVd5qG8BfSVuBKMIAjoVU1IfEtruPLJlk5RHpEau/MEKu60NQoTw871JAFA6wih/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547682; c=relaxed/simple;
	bh=1w4IiuOGzu+7c6F7J2tT++TPLaBtwAUCqLimBi9v92o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=C19Pi+Pcu6raTHXk3/jf2GjiVHFUVkB0zcKO1gVtad2R5GCK8IOofIfk5RiSzFdqTvAXpWgUMLduAeGb3UkbpUK1VkNboQb5MoPkMgM5XTUSAOwQ5GELxN9+A2t9y1YSRCcUapkfVChbSukKO0HH0p4a3eV5Mp6UcmqKEFK2viI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=PjbFcQdw; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="PjbFcQdw"
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 9B48E1C0E24;
	Fri,  4 Sep 2026 18:47:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id F2DDA2000F;
	Fri,  4 Sep 2026 18:47:56 +0000 (UTC)
Date: Fri, 4 Sep 2026 14:49:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH] tracing: Fix comment in tracing_buffers_splice_read()
Message-ID: <20260904144902.506862a1@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F2DDA2000F
X-Stat-Signature: xe3wc7murc7zxzefq6b37zeomy49cmuu
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+fkc77siUfI8tds78EWHWM6xAMVDFqBVs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=WHtUlS/S3IuYsDOaQvCTXzr2xQjMj9MLFo+p/8KdbxQ=; b=PjbFcQdwpdcPw6mIdA9guZWfXkpvruMK2plELaMm8jQ7dRjZRQ3+XbFY1BgwMUdDlG4QN/pt6g7SBcNt9ZDClRUwZCkS4QGl2SsvKEleClam95nJFDCgqNNSo8nUsOssZ3QgKb+vDbUTki/wbHQYAM+D62YdSwUGe7cbFO0nb4U=
X-HE-Tag: 1788547676-690281
X-HE-Meta: U2FsdGVkX189116QGrs4UF0+NYBV1sqYWzNTB4gqLtPI3oj0Fv6O7yq5LWsU/lqvtdw8lwHVTr9+K8/w/xQmOnZJ+BbRvV+irgrR8UQ0ATwVOyZHyZSPhrF+fTbyQTyLxP+scH7pR+cOy2K+/2+IJUmuAAl0bLUg+yIKri03ci3zSqnTKU+G4RHy0hIAHHSmV7qtq4VDj711G/VahECCxLJVJgXv/55TE5P6Z9bP8QahSy5iLXpwpNv/NwVAs4Ms+aJMdBAsLDSeP/epY/b+vIzbwDRDIx1J1IVTL8KI51Zmb5id5kroQ2DM4CbhOEbQlawPWKYdtzHhaU+knl8rHT9PfXwvguoBLJjDZaliL2XiHFbtWQ6n1RpdxrEf2GL1ye7v3mJfdaZusG3NvhMapA==

From: Steven Rostedt <rostedt@goodmis.org>

The comment about returning an error if the read fails on the first
iteration is slightly incorrect. It makes it sound like the only reason it
could fail on a later iteration is if the subbuf order changed. That is
incorrect, it could also fail if the length passed in was not a multiple
of the subbuf size. Fix the comment.

Link: https://lore.kernel.org/all/20260904143527.40e73d36@gandalf.local.home/
Fixes: TBD
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b26c4c277ce5..8658cad53cb5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7296,11 +7296,13 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 			r = ring_buffer_read_page(ref->buffer, ref->rpage, len, iter->cpu_file, 1);
 		} else if (!i) {
 			/*
-			 * We failed to read because the length is too small
-			 * or unaligned. If this is the first iteration, it's
-			 * an invalid userspace input. Otherwise, this is due
-			 * to a subbuf order change. Do not report an error
-			 * and just finish the read.
+			 * If this fails to read on the first iteration, it
+			 * means the length was too small and an error should
+			 * be returned to user space. Otherwise, at least
+			 * one sub-buffer was successfully read but this failed
+			 * due to either the length was unaligned or the
+			 * subbuf order changed. Either case, do not report
+			 * an error.
 			 */
 			ret = -EINVAL;
 		}
-- 
2.53.0

