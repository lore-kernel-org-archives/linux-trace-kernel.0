Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBA0264FA5;
	Tue, 25 Mar 2025 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938715; cv=none; b=sq2gRK841VY5gZ3LywbvaOfckyfnJGPZ3c0ktLi8F7+ZMucAvH5ebxIL16P+lVYKcZifE6XdSDsTFAOSvBX+xsAfEp3yXq4orzDffGGn/pDLkiUKmRiec1GUcJ2nPbLV87xDODtkw8x/x+31GYFfUA/a7mjG+sRGhD0dxwtADHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938715; c=relaxed/simple;
	bh=JwBJp+fkMF6eEE7wxfkSU1SfjN5fgSBP10J0R75ipcU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iEX6FfdOcl9dXAvYsi2Y3PQ41/JYn0+2Th1uKYwlcAnJb0juIGXuH+C5cPWQn45gTlj/7Ph6eCs0S1+7b7bqGWLE8mElmUKTqAdNLvtx8bNodcupPEqiI1XGgyl2bSwMW7nvaMu01gZxr5fsbZ+mdzyxJlrCWIzPoK2AUusZmfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA03C4CEEE;
	Tue, 25 Mar 2025 21:38:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1txBzT-00000002Vf6-3EYT;
	Tue, 25 Mar 2025 17:39:19 -0400
Message-ID: <20250325213919.624181915@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Mar 2025 17:38:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/4] tracing: Show function names when possible when listing fields
References: <20250325213845.844200633@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When the "fields" option is enabled, the "print fmt" of the trace event is
ignored and only the fields are printed. But some fields contain function
pointers. Instead of just showing the hex value in this case, show the
function name when possible:

Instead of having:

 # echo 1 > options/fields
 # cat trace
 [..]
  kmem_cache_free: call_site=0xffffffffa9afcf31 (-1448095951) ptr=0xffff888124452910 (-131386736039664) name=kmemleak_object

Have it output:

  kmem_cache_free: call_site=rcu_do_batch+0x3d1/0x14a0 (-1768960207) ptr=0xffff888132ea5ed0 (854220496) name=kmemleak_object

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index ca8e09436a0a..ef6307a6ca5e 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -935,14 +935,24 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
 					break;
 				}
 
-				trace_seq_printf(&iter->seq, "0x%x (%d)",
-						 *(unsigned int *)pos,
-						 *(unsigned int *)pos);
+				if (sizeof(long) == 4)
+					trace_seq_printf(&iter->seq, "%pS (%d)",
+							 *(void **)pos,
+							 *(unsigned int *)pos);
+				else
+					trace_seq_printf(&iter->seq, "0x%x (%d)",
+							 *(unsigned int *)pos,
+							 *(unsigned int *)pos);
 				break;
 			case 8:
-				trace_seq_printf(&iter->seq, "0x%llx (%lld)",
-						 *(unsigned long long *)pos,
-						 *(unsigned long long *)pos);
+				if (sizeof(long) == 8)
+					trace_seq_printf(&iter->seq, "%pS (%lld)",
+							 *(void **)pos,
+							 *(unsigned long long *)pos);
+				else
+					trace_seq_printf(&iter->seq, "0x%llx (%lld)",
+							 *(unsigned long long *)pos,
+							 *(unsigned long long *)pos);
 				break;
 			default:
 				trace_seq_puts(&iter->seq, "<INVALID-SIZE>");
-- 
2.47.2


