Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D38D3D9534;
	Mon, 27 Jul 2026 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182075; cv=none; b=VkcrmgUvZ9LbN7i7a6kC8iF+EeHvG8wsoiEDY6zejcoMzUaL/ef2ErQhVd2P9/987i/+jlh4axzh2LFyPy/J2Ywj8hUrtdRMzj8RK0von5qi6Sl/8XU30iRemOgalc6JievkBZLKcB9cyzOC6/uFRT2CHp3+5qgpCqwmu6dkEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182075; c=relaxed/simple;
	bh=7+ivClIKGDZD3UDjMhQpIwQ9FdKhSqZ1MsXdjZ7DeZY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cE9ejKJXXu01puOLu72iWbrMqGc1eilAC+hWtrvuZHNUYK9c4nxDs9Df0xXHOMTCXHmepkRopgMz5KUG3SzTv+90Ao3cSrVc5GCZlfoCyf6XkmkDnOwrEmYxw0NDldf3TfGJ68D7UKhZB0KGjDmFXlYV1JYIzRQShaFE8KXbFHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org; spf=pass smtp.mailfrom=rostedt.org; dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b=ZixCw2bv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=evUXozVU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rostedt.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b="ZixCw2bv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="evUXozVU"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 210451D002DD;
	Mon, 27 Jul 2026 15:54:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 27 Jul 2026 15:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rostedt.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1785182067; x=1785268467; bh=Vi
	Z7hF+J0S+/i/VNfq5Y+4QpoUxFg8hbRMmMfWUKn9A=; b=ZixCw2bvf+hPeakB+q
	SUUj80lzk7SF10E96JSX6YUbNGvJSTCtD1g58paoMPIUsj3NpkXwGJVddVvJcKx6
	XevzmlYNixpjkjunMpdtMBhGPm6A8iTJR5jlSlNEvimMLPmX36boGJyb4qBvArB9
	kzg5+Eg8qncdguDvrULOJ3ai3+eS/wY3mmaPIYGL7JfjPiqFck8lBuoL1oqH/q6I
	UtCc2s4QgBG0yUt/kPHiRj3Ix9R1mA8gkPP/aePMR9eFcsfdpax1Azbs/2z05tUI
	VvUhXEKyBq4CLf78qSVt4czTjTOQ4WT29rYcES3jjPnQqvzyw08ynhTQhnNPlIO0
	PMDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785182067; x=1785268467; bh=ViZ7hF+J0S+/i/VNfq5Y+4QpoUxF
	g8hbRMmMfWUKn9A=; b=evUXozVUpNfepBBOWS3W6i6EvRpvqgFDHKaLst7p9UNQ
	BIhpFpigRYbOp/BxkyxSbrQgKBr9M2yYVtxpbIoArtDjawCm3yUP8uV1SKSJ8YVo
	pWMDJs0x54HBAvZxpFQIuWDoM6JIwOKIX7VpfvRXsBZbP1H/K3HeRwaL9R/LA0bM
	cV1vXaAz/Wk7JBthfP7lEKesnehvW6uVLD4/FyOY0kqBvLA5bP7VHL8skJphBGjO
	UghJJND+TvVLital/VotSx4pmLTQadlUU+5H2s14UkrHJATD4z8CaT/3c/hz4ovD
	sI36GlgLMdBACOl9kye/82x4ew17swAeSLG95yj2ag==
X-ME-Sender: <xms:c7dnaiKtk5mpy6xODw38bRvwPwf2WjK5eEJ2qUUQjKI2xJVm13T9ww>
    <xme:c7dnan9R5QEUKdz-Mu6xoGGZP0OEDE77fiRE3lzABsBywhdZFF8QyjBB4TH8DHtXN
    uoe9KtIXgdJ_siKT4ZbxmjFNqUnW-EZveOVYBVZC39pVCNKe_G0W9rr>
X-ME-Received: <xmr:c7dnatICMcYWaxzMbd381_hhxkmnxu9v5fpyIWeVXXlwsud4o56l7y_SK89T2i7h89if4TKI>
X-ME-Proxy-Cause: dmFkZTFRd2UFN2XbznV21RZ1qL+5rrwM/oVk5um0UlOnbYEpXd44R0XX4Xscv6Aa9dLCTq
    z6TkgMaXoQmWCakvfHHTy4ASx2D8wdGWyRhP3pyp+bvyXoi7iV7jQVBrS5ZvsXpN6MSFPH
    Zw5Q1NesAVWMiJHYChJXxo8L1sJ7FfKA0JmVSvcFdihY99Cz4keLWJKQDNPFvJc2GaO+dB
    uC30LsMw094TiGCWoARsWDoszSjmKGJcqnkshqxaQOiu4u/YaD2Bh6UxnxCw4wKUOB83Ba
    zH+pDw55MmbMt+unVg8A34OLJGEBsPDpX/iLezd66i7yl3TpBoO4juuIfNv8tR/aRXO3iq
    oGbmmQfwoX4GebaAMdWIdXcilw6lIXVCEXByxKtRtIYaluLoZ15T4xDvpJHAhVL9gyEx0M
    AzfdDO+MaTbDNXruw23Z1cvnIATPawP9I/L540YSWtz9uHOwqcWiq5IXV6A3tduoxDUeRH
    3sMb4zMAU9n50NQZkPFUokFue8i/SHUU8cc/Jsa/yx72eUVgcMzyZKYxfXUBsAqAgFv4qr
    HwXCUMefc7ekSJmaQPJlVYuN3R9sY4v1encSdxh558phE0C85L9EaCZ/DKeNd00M8sjeOa
    ndYxwvOyIpVum9X8S5oFYlTE3EGvZo0aSa7OHjX9raKuhZJCCealmgzxqTAg
X-ME-Proxy: <xmx:c7dnakktlW9sDTJt2WCHmWlCxQYC3NfVrc_Zug2V7S2LwvlJ9gHc3Q>
    <xmx:c7dnapPxah45M67FNTh6j7uZGzlgF9Gxb-zPTWLC5eGTMEuqiC6a_Q>
    <xmx:c7dnai3UQ1FUSixSZfXB4imm4DWWq8sF_GXqKCfSDEse_CM8lvvG7g>
    <xmx:c7dnaglYEM3Yt5GUfkKrjob5bqRMnYJc61z9uSErpEluIPuHeopy5g>
    <xmx:c7dnahausX_jO_LMJApFXFMMYJPNcrm_gUXOnUa-xbUh7bh0Sj_ynGlI>
Feedback-ID: id06e481b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 15:54:27 -0400 (EDT)
Date: Mon, 27 Jul 2026 15:54:59 -0400
From: Steven Rostedt <steven@rostedt.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing: Cleanup event_enable_trigger_parse() by using
 __free()
Message-ID: <20260727155459.202af38d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The enable_data variable gets freed on most error paths in
event_enable_trigger_parse(). Use free() to free it and just before
returning normally, call retain_and_null_ptr(enable_data) just before a
successful exit to keep it from being freed. On success, the enable_data
is assigned to the trigger_data->private_data field.

Also add a comment to why event_trigger_free(trigger_data) is being called
before a successful exit.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changes since v1: https://patch.msgid.link/20260701174829.67ab8a33@gandalf.local.home

- s/no_return_ptr/retain_and_null_ptr/ as no_return_ptr() has __must_check
  (Sashiko)

- Added a comment to explain the last event_trigger_free() before a successful
  exit.

 kernel/trace/trace_events_trigger.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 655db2e82513..87601c2560d0 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1739,7 +1739,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 			       char *glob, char *cmd, char *param_and_filter)
 {
 	struct trace_event_file *event_enable_file;
-	struct enable_trigger_data *enable_data;
+	struct enable_trigger_data *enable_data __free(kfree) = NULL;
 	struct event_trigger_data *trigger_data;
 	struct trace_array *tr = file->tr;
 	char *param, *filter;
@@ -1789,17 +1789,13 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	enable_data->file = event_enable_file;
 
 	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, enable_data);
-	if (!trigger_data) {
-		kfree(enable_data);
+	if (!trigger_data)
 		return ret;
-	}
 
 	if (remove) {
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		kfree(trigger_data);
-		kfree(enable_data);
-		ret = 0;
-		return ret;
+		return 0;
 	}
 
 	/* Up the trigger_data count to make sure nothing frees it on failure */
@@ -1828,7 +1824,12 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	if (ret)
 		goto out_disable;
 
+	/* Release the above reference taken for modules */
 	event_trigger_free(trigger_data);
+
+	/* The enabled_data is assigned to trigger_data->private_data */
+	retain_and_null_ptr(enable_data);
+
 	return ret;
  out_disable:
 	trace_event_enable_disable(event_enable_file, 0, 1);
@@ -1837,7 +1838,6 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
  out_free:
 	event_trigger_reset_filter(cmd_ops, trigger_data);
 	event_trigger_free(trigger_data);
-	kfree(enable_data);
 
 	return ret;
 }
-- 
2.53.0

