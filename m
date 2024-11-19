Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6A1D1303;
	Tue, 19 Nov 2024 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034615; cv=none; b=BV068ZAUufUhfh3fNcuEfRnpZjSFG5CbdeWmoP/pttBYi8FKesdjtdC3nWZlg9kNyWUkLtZOgtXGrWVzZ/E7jV+3BjW4Svj0e7jpGYW6YyYINTfHCdpqN4rf8KVXNFb/ON7FNGG1h157gL0t5MlbOPukRn8n/G46hUymdsenguQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034615; c=relaxed/simple;
	bh=C9mHD0gHCQv2Bn7YxHs4Zu5S+fUFQt+SkrQfU84oGnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0SsmsfwwQlLthh0BbxU5EzC7UMBqhzVM78Z3b/Wg4x6zRZn2hw/jEU+W/+i+e2On11E+C1rJfaRr6lWZWC/dSkG4h9wLSMIbEtekVL0/Zx8ZOZp/pDAq5pXVG2KWhIWkVkAdb9k9HFtDjN5eriX9mN1Ten1GdU+ABcecSwmVS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDFFC4CECF;
	Tue, 19 Nov 2024 16:43:34 +0000 (UTC)
Date: Tue, 19 Nov 2024 11:44:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Geert Uytterhoeven
 <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>, Tomas Glozar
 <tglozar@redhat.com>
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
Message-ID: <20241119114407.762b7ff6@gandalf.local.home>
In-Reply-To: <20241119112850.219834f5@gandalf.local.home>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
	<3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org>
	<20241115102554.29232d34@gandalf.local.home>
	<cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org>
	<20241115145502.631c9a2c@gandalf.local.home>
	<2c43288a-517d-4220-ad31-f84dda8c1805@yoseli.org>
	<20241118152057.13042840@gandalf.local.home>
	<22856ed6-b9d0-4206-b88d-4226534c8675@yoseli.org>
	<20241119102631.76363f2a@gandalf.local.home>
	<20241119112850.219834f5@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 11:28:50 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> print fmt: "page=%p pfn=0x%lx flags=%s", (mem_map + ((REC->pfn) - (m68k_memory[0].addr >> 13))), REC->pfn, (REC->reclaim_flags) ? __print_flags(REC->reclaim_flags, "|", {0x0001u, "RECLAIM_WB_ANON"}, {0x0002u, "RECLAIM_WB_FILE"}, {0x0010u, "RECLAIM_WB_MIXED"}, {0x0004u, "RECLAIM_WB_SYNC"}, {0x0008u, "RECLAIM_WB_ASYNC"} ) : "RECLAIM_WB_NONE"

Running gdb on this, I found that it crashed on the "m68k_memory[0].addr"
because it failed to fail on the '.' that it doesn't know how to parse.

This patch should stop the crash (against libtraceevent)

-- Steve

diff --git a/src/event-parse.c b/src/event-parse.c
index 0427061603db..a6da8f04cbf3 100644
--- a/src/event-parse.c
+++ b/src/event-parse.c
@@ -2498,6 +2498,10 @@ process_op(struct tep_event *event, struct tep_print_arg *arg, char **tok)
 
 		/* higher prios need to be closer to the root */
 		prio = get_op_prio(*tok);
+		if (prio < 0) {
+			token = *tok;
+			goto out_free;
+		}
 
 		if (prio > arg->op.prio)
 			return process_op(event, arg, tok);
