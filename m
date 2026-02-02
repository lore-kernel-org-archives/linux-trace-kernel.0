Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A43C1E7C03;
	Mon,  2 Feb 2026 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048488; cv=none; b=EhAwy9WLJRy1Fkg46eFR7XqlhVB8FuDkT7YT0bPjC2Kf4IzgUcCsLL+rsONRGf5N5sjpLVSqHHgsQ2grbfZb7+HzXOAw3Btnnn/9QDs5ZNmK19O+M8420mUiwuaD4u2UwHrJBlQtqBJw60agW6tL+Pk5d5dtmjuemBENalOBoG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048488; c=relaxed/simple;
	bh=GUX+HIvqwqX3bKfQhQZ6LilQ4o+ym7h9zBxYvV9yP48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VH3qJK1+hJVZetpSTChd/KZ27RzyN9S7RaW18zg0beVRKVGKNTBXAXQlAGqGzuP0zb6v3+D/m3oGfbDniL4KjT6HpeTW4map1ybM2rt+i2yQa2REP5qNsfZwV9GpcOSKuF1kieJaebg5SD+kiuqEiytzDzGoXbJ6qeKc1ofBoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id B2CB4C0F37;
	Mon,  2 Feb 2026 16:08:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id BA41E20029;
	Mon,  2 Feb 2026 16:08:03 +0000 (UTC)
Date: Mon, 2 Feb 2026 11:08:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "jempty.liang" <imntjempty@163.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Fix funcgraph_exit calltime/rettime offset
 for 32-bit ARM
Message-ID: <20260202110828.440c8d44@gandalf.local.home>
In-Reply-To: <20260202103804.40cbaa27@gandalf.local.home>
References: <20260202123342.2544795-1-imntjempty@163.com>
	<20260202103804.40cbaa27@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9m1tuea6uxqc1ieft5cyswi4rkhom71z
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: BA41E20029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/1joY0cdyqd1+K1BUXn5x+NFAwEZ5RbSc=
X-HE-Tag: 1770048483-105100
X-HE-Meta: U2FsdGVkX1+cu1JbGkEUvItcjEaKIKYhkfCgRMl4EbundQFPM0dnTxsRMRSfrhYvhgM95D6eFuWmqpDhc0AQ0rT7m2OHoHyVmXIDeuCykqIUwpetGWer15k97v06LFSJlc40qMWQi6LIvvOOZcf9EJ8oCFbRr3go0VBCTsSTDhe58fbxqnQc8YkIIQ8I3FCAAx7IB03iQB9TATsVO4VPekxmNlbQGdIMls1tjGgyRqX+vCgmKosBLg19eLzwndHyouZ0nwSU4C2FIoADZjYZbkE6rw0GvMJFbntD5360CxuvvCUfgXnKKyopcECgfvIE2+lpAGUPWAuXO+QZOtOBiwYDW8QRrkkPDXQDIhvaP1PVw8cAauCCJtv6YRjSGVXj

On Mon, 2 Feb 2026 10:38:04 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Can you try this patch to see if it fixes the issue for you?

Ignore that patch, try this one instead. This was fixed for trace_events a
while ago, but the same fix wasn't done for ftrace events.

-- Steve

diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index 1698fc22afa0..5b96ac750049 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -14,6 +14,9 @@
 
 #include "trace_output.h"
 
+/* The alignment of a type when in a structure */
+#define ALIGN_STRUCTFIELD(type) ((int)(__alignof__(struct {type b;})))
+
 /* Stub function for events with triggers */
 static int ftrace_event_register(struct trace_event_call *call,
 				 enum trace_reg type, void *data)
@@ -88,7 +91,7 @@ static void __always_unused ____ftrace_check_##name(void)		\
 #undef __field_ext
 #define __field_ext(_type, _item, _filter_type) {			\
 	.type = #_type, .name = #_item,					\
-	.size = sizeof(_type), .align = __alignof__(_type),		\
+	.size = sizeof(_type), .align = ALIGN_STRUCTFIELD(_type),	\
 	is_signed_type(_type), .filter_type = _filter_type },
 
 
