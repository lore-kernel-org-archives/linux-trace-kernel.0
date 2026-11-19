Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110214;
	b=qivcSp0xw3MKxJuSjnvzP6uL6pn/oH4pPrrrJkCk3399ly7dboDZt2ojOg0f2sZVQswD
	 Lz/4hFtXaS3wt9c4ix5Xsuz4VMj1LFw5T6mvwz8BdSMlK1aaI5MjARP+UOTl1Na3Gs2Op
	 9f9mtDVIebAUhZ+jwAaoA45S2X7jjHOzZvxXUDP+y3ST2kS4xEWBa66PxuGrWGyBeEtKM
	 6+F5pvHTXy1pr5ZKEXFhyB8ohm79dsMeNyq116Xy0KzWQId2mEAilaMA0O/bBjnMALs0Q
	 x4LmshAz3pKdStcvHLSV8YdiPPeM7beXmoE2Tbvp8KRxEx5Wa6mJJhQI/xowTT95mzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110214;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=YBloNb6AAYgpF1Fh3OUyriFCyo6Q/5LP/OsGtrdzoV8=;
	b=sM/Z8uRwmTACqRLM1kelJyBJd/VVNHQ1SZtcfOgAgwHbiuwN9wzPX2oVd+xYsCCFRe2x
	 CG9aKrPCj9RGvGOg4fFpAEGwShoCurQKT9BvYy8jQo5TrNiYdeYyja331BHEAXUYY2dJT
	 jMPTR469Qks9b2rA1oTLFqKc6GfEQlAffYzKVqt3JtKdbjXfWcy2MRYD0aOlsbqlTBHEr
	 cjZOwA6jTd5o8hOGaEngCVPCDRdDcpm1hNjyzRjyBC7ZkWiWtZdItpbOQvl+W1FqygXFb
	 OiH/BPvoSfwUeY3Q8js9CEYaIpcB3IY4/9vljApax/26xw/kVLPbtJ4d+NeCsppbxYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=L5uG4mKu;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F013606A320;
	Thu, 19 Nov 2026 17:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F013606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=L5uG4mKu
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 937B4C0B7C;
	Thu, 19 Nov 2026 17:43:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 399E31C;
	Thu, 19 Nov 2026 17:43:22 +0000 (UTC)
Date: Thu, 19 Nov 2026 12:43:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] tracing: Add notrace to event functions that hook to ftrace
Message-ID: <20261119124319.3a8bfe50@gandalf.local.home>
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
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18yTNJvHisOR66jGyW6ZK36V4xWSDWKZZ4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=YBloNb6AAYgpF1Fh3OUyriFCyo6Q/5LP/OsGtrdzoV8=; b=L5uG4mKuWZ4IImsodFCiTQVH9e1xIH/Q7lsFzbrrzstDz96KJUIza1DF1NaoHgyZzbgoaWOXofwrCtN6egPPvTMKOB5T4FnW2CCdpFuDoQTOl9Ceqzm7d/IbBNol6GKc6Xesla7fjGC2nyNdLv6vKUqcVJqOHCvCCGDV1JHzvFc=
X-HE-Tag: 1795110202-247362
X-HE-Meta: U2FsdGVkX18BvGRuCV5Ta5oRQmKu8z18Os/6oolD2YnZQFlgKe6hQyWBmd1WxpC+e1pyajC6TZ6DHmc1IzdzgVvH4ekvxLG3R1JEYrZZ310iOw93N+pv2Z5DT5WWRbYISDKSfkRoE7C5andQBtnqEuG/PlDWjO72/RSHT9v39P2hKiI4eyP/uk0eIPzMJg3U4zZqE4SUzn86/tK2YVbVeqpa7xOKDX1FDgR2GSgncjooEzDGR2oF7DlLg36IfRvV1WhqHjrqtRlYUnHM4Cd6seutiGbKIWsd9V5hMlE2f1+RwmWKYau8M6E1Y9K9kuANextLurDuTSCgKlXTaI66C2LyvX+VCnyzsAE2wTp8tvz8+IMmcuq0JDRKvRwAFcFCMU7U81V/z1GV9DqyaY2ang==

From: Steven Rostedt <rostedt@goodmis.org>

A few functions in trace_events.c are used to hook to the ftrace function
hooks. Before CONFIG_FUNCTION_SELF_TRACING was added, these functions were not
marked for tracing because the entire directory was set to "notrace". But
now that certain files can be traced by ftrace when the
CONFIG_FUNCTION_SELF_TRACING config is set, individual functions that use ftrace
must be annotated with "notrace" otherwise they can trigger a triple fault
when called.

Annotate the trace_events.c functions that are attached to ftrace with
"notrace.

Cc: stable@vger.kernel.org
Fixes: f93a7d0caccd6 ("ftrace: Allow tracing of some of the tracing code")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c9d31c9f3fca..7f89160aeff3 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -4317,7 +4317,7 @@ static void update_event_probe(struct event_probe_data *data)
 		set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &data->file->flags);
 }
 
-static void
+static void notrace
 event_enable_probe(unsigned long ip, unsigned long parent_ip,
 		   struct trace_array *tr, struct ftrace_probe_ops *ops,
 		   void *data)
@@ -4334,7 +4334,7 @@ event_enable_probe(unsigned long ip, unsigned long parent_ip,
 	update_event_probe(edata);
 }
 
-static void
+static void notrace
 event_enable_count_probe(unsigned long ip, unsigned long parent_ip,
 			 struct trace_array *tr, struct ftrace_probe_ops *ops,
 			 void *data)
@@ -5205,7 +5205,7 @@ static DEFINE_PER_CPU(atomic_t, ftrace_test_event_disable);
 
 static struct trace_event_file event_trace_file __initdata;
 
-static void __init
+static void notrace __init
 function_test_events_call(unsigned long ip, unsigned long parent_ip,
 			  struct ftrace_ops *op, struct ftrace_regs *regs)
 {
-- 
2.53.0

