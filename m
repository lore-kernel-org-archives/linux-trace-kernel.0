Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFECA27E7C8;
	Sat, 12 Jul 2025 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752331062; cv=none; b=PQ/hUSHTAQ2orxDfHtVSzNEtrsH39CNLhDPwSLSJpqZuGhn4mOUqA+yoi8905namwxIsvFgjteFAr45RbtKR2juUqJA7dQTfeqJqIg5r0TTcZM4AvHm+dioAXlcfz7toIV1JXfmBkqcqLColqpiYzd+tJq6KxktwDqmJe+e7Z5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752331062; c=relaxed/simple;
	bh=PFQv1MiKwPHjCbE3SkmZSPRK8MgN7zNlyxripA+FjFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6khXT6Yi/ysOW+7oofObr8RHXEWXDtCKgvG+haFHcj1f7xMR2ntpFlBktGirAKgpDnI+vDiDUfKRcbDTLACCzTC0P3DMCnVCuAGAekehXU+229pueCZ78JwgC7/oRy74f1VnN6EYzIUdQvxHsR9+o7RqV0rOsAtDs7AR6gYgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 5A52316013F;
	Sat, 12 Jul 2025 14:37:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id B056E20025;
	Sat, 12 Jul 2025 14:37:31 +0000 (UTC)
Date: Sat, 12 Jul 2025 10:37:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Remove "__attribute__()" from the type
 field of event format
Message-ID: <20250712103732.79c7b9e1@batman.local.home>
In-Reply-To: <20250712204524.13ece418f90ea66d4bd0e598@kernel.org>
References: <175197567999.977073.8989204607899013923.stgit@mhiramat.tok.corp.google.com>
	<175197568917.977073.2201559708302320631.stgit@mhiramat.tok.corp.google.com>
	<20250709131107.397a3278@batman.local.home>
	<20250711143703.60a1a9a9f31a45f2000eec9d@kernel.org>
	<20250711120322.4ddb9b39@batman.local.home>
	<20250712204524.13ece418f90ea66d4bd0e598@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: f1rei356ssetnsu795jz3xcer5gyhgi8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: B056E20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+hQ6GS8OZgON/sLVGwYmpUtRbcIiBkgMQ=
X-HE-Tag: 1752331051-649973
X-HE-Meta: U2FsdGVkX1/hBdxgzFDNgX9buPFxsa0V/rMcqEPnhJKZif5/dc3xmV8oP/4FK6lLfXCkexGeWX7sXo4OJsFH3kcFv7XCXWyDSU/K7UxfBRzsBpSW+PNP9oEObbMfM0QNeDMD3pe5r+MDu7rqzVp3t4LcYI+uFBaHPWH7b/RhZnN9uqr/Itd3cyIM/UN2BbG2lRRBxgwoNFEVbr0SuYN66vhKdLtcrcEiU95jk4TmErQmxjpKEX7c81pFs4+daZ1j54MgcHwa66q5aCK3R40gqWMqYFRUig2a8OSHLLBdisp5hYIdWyPNMUOqzWhglZgaCQ1GS8qFpdev41UZZdYJBxdfChm22eFC

On Sat, 12 Jul 2025 20:45:24 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hmm, Ok. But when I sanitized the field->type in
> update_event_fields(), it did not work. So something
> we missed.

Ah, it's because we test to see if the event has enums or not before
calling update_event_fields. We need something like this:


diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abf..52829b950022 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3349,6 +3349,8 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 				}
 				update_event_printk(call, map[i]);
 				update_event_fields(call, map[i]);
+			} else if (need_sanitize_field_type(__type)) {
+				sanitize_fields(call);
 			}
 		}
 		cond_resched();


And have the attribute fixed in both update_event_fields() and have
your own sanitize_fields() that just does the attribute update.

-- Steve
