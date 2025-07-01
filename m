Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C92629D;
	Tue,  1 Jul 2025 23:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751414354; cv=none; b=GF1QtfvtibATa6hnUW4xUFZMvXEABgZhczgHylYjg+DxmRuxcivqM7jUzy2n49Sb8/63BomAiMIyiLe2n17EPsrhRuDCNw/qlDhBGhUCALmlKNFEtmD3EX+L4nfR1M65DZXhDPCBUoFaWoEZXLNv3sl7ynoV8AjZXM2K4EUnPp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751414354; c=relaxed/simple;
	bh=i6Zgs72ee9IrKCYkI1HKUtQnqASG8qkLiOO5Og/A5Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GuaxGQkVCu8eeRB1yShWWmbBCP1YCQR0r0hh5FvEaVP+KAkuDfzLB6KXT6zrRLFXzndmRT0KiMWaOG07cNd7GhYFd2t6aOEfrFmuDLP4wv0wQZGSN59Z06jOf8Gx3onniOdrmgw7xYjDdyvsQv6Coq5wxafKRufNJUkQad0h2Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id C56E2B8977;
	Tue,  1 Jul 2025 23:59:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 1002520010;
	Tue,  1 Jul 2025 23:59:00 +0000 (UTC)
Date: Tue, 1 Jul 2025 19:59:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND] tracing: add kernel documentation for
 trace_array_set_clr_event, trace_set_clr_event and supporting functions
Message-ID: <20250701195939.3e297e20@gandalf.local.home>
In-Reply-To: <20250620085618.4489-1-gpaoloni@redhat.com>
References: <20250620085618.4489-1-gpaoloni@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1002520010
X-Rspamd-Server: rspamout02
X-Stat-Signature: byd7udbg8wu3ud3x41jxqe3qywx5k6m8
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+yjpaGI33+1uQDEuJXi4rplaa6AcJWvyU=
X-HE-Tag: 1751414340-194924
X-HE-Meta: U2FsdGVkX18p4xDgOHENOBWh4t4/vnCs4pCHpfGEJzhklNSTjY+hFuPOeQuBg2MDJ8cOC++fgiawVqYpA6JV8nYRFJUCZSsBGt+yDuWDsFGaL1uzs24tGVkyMmfS4iisPLvHEyZjSC4zDnWszMy+AXSB3iqNFNZi47VZEVG4Nn1ny62BtcFOOL78cqws1oRNIVsF+UeaWHhp0HrjInXwB3Z7MjwW9f8JH65bf3r4+QPPMcMBHfrF2luiHQRemW7K88F87lBK6ulIajBo8J5bAY2XCAtsEJrAwVgo3Nknmf5j13i6ewfrFAtG+xOYp1csPIYyQ7Eisxdu05kaxy8jd0ZJb7cB2hSIW2IHij/40n7zBOgN9RVfAv74UUiq++sRM7eQVSvdNQw=


FYI, I know some maintainers prefer a "RESEND" of a patch, but I personally
prefer a simple "ping" reply to the patch. Actually, I'll take either, but
my workflow is with patchwork[1] and I tend to give older patches in
patchwork priority. By sending a patch again via "RESEND" that patch will
supersede the older patch which actually pushes the patch further down into
the queue, which makes it even longer for me to see it (having the opposite
effect of the purpose of sending "RESEND").

[1] https://patchwork.kernel.org/project/linux-trace-kernel/list/

On Fri, 20 Jun 2025 10:56:18 +0200
Gabriele Paoloni <gpaoloni@redhat.com> wrote:

> As per Linux Kernel documentation guidelines
> (https://docs.kernel.org/doc-guide/kernel-doc.html),
> <<Every function that is exported to loadable modules using
> EXPORT_SYMBOL or EXPORT_SYMBOL_GPL should have a kernel-doc
> comment>>; hence this patch adds detailed kernel-doc headers  
> documentation for trace_array_set_clr_event, trace_set_clr_event


When referencing functions, please add parenthesis "func()" when naming
them.

> and the main functions in the respective call-trees that support
> their functionalities.

Also add newlines in the change log, to make it visually easier to read.

> For each of the documented functions, as part of the extensive
> description, a set of "Function's expectations" are described in
> a way that facilitate:
> 1) evaluating the current code and any proposed modification
>    to behave as described;
> 2) writing kernel tests to verify the code to behave as described.
> 
> Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> ---
> Re-sending as no feedbacks have been received.
> ---
>  kernel/trace/trace_events.c | 125 +++++++++++++++++++++++++++++++-----
>  1 file changed, 109 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 120531268abf..4bd1f6e73ef1 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -763,6 +763,54 @@ void trace_event_enable_tgid_record(bool enable)
>  	} while_for_each_event_file();
>  }
>  
> +/*

If you are going to use kerneldoc comments, might as well make it a
kerneldoc format: /**

> + * __ftrace_event_enable_disable - enable or disable a trace event
> + * @file: trace event file associated with the event.
> + * @enable: 0 or 1 respectively to disable/enable the event (any other value is
> + * invalid).

Saying 0 or 1 should assume that those are the only values. Don't need the
content in the parenthesis.

> + * @soft_disable: 1 or 0 respectively to mark if the enable parameter IS or
> + * IS NOT a soft enable/disable.
> + *
> + * Function's expectations:
> + * - If soft_disable is 1 a reference counter associated with the trace
> + * event shall be increased or decreased according to the enable parameter
> + * being 1 (enable) or 0 (disable) respectively.
> + * If the reference counter is > 0 before the increase or after the decrease,
> + * no other actions shall be taken.

Although this has newlines (which I like!), the indentation should be with
the first word after the hyphen. That is, instead of:

 * - If soft_disable is 1 a reference counter associated with the trace
 * event shall be increased or decreased according to the enable parameter
 * being 1 (enable) or 0 (disable) respectively.
 * If the reference counter is > 0 before the increase or after the decrease,
 * no other actions shall be taken.

It should be:

 * - If soft_disable is 1 a reference counter associated with the trace
 *   event shall be increased or decreased according to the enable parameter
 *   being 1 (enable) or 0 (disable) respectively.
 *   If the reference counter is > 0 before the increase or after the decrease,
 *   no other actions shall be taken.

Making it easier to read.

> + *
> + * - if soft_disable is 1 and the trace event reference counter is 0 before
> + * the increase or after the decrease, an enable value set to 0 or 1 shall set
> + * or clear the soft mode flag respectively; this is characterized by disabling
> + * or enabling the use of trace_buffered_event respectively.
> + *
> + * - If soft_disable is 1 and enable is 0 and the reference counter reaches
> + * zero and if the soft disabled flag is set (i.e. if the event was previously
> + * enabled with soft_disable = 1), tracing for the trace point event shall be
> + * disabled and the soft disabled flag shall be cleared.

Would it be possible to group the requirements within "If soft_disable is
1"? Seeing three different lines starting with the same state seems
inefficient.

> + *
> + * - If soft_disable is 0 and enable is 0, tracing for the trace point event
> + * shall be disabled only if the soft mode flag is clear (i.e. event previously
> + * enabled with soft_disable = 0). Additionally the soft disabled flag shall be
> + * set or cleared according to the soft mode flag being set or clear
> + * respectively.
> + *
> + * - If enable is 1, tracing for the trace point event shall be enabled (if
> + * previously disabled); in addition if soft_disable is 1 and the reference
> + * counter is 0 before the increase, the soft disabled flag shall be set.
> + *
> + * - When enabling or disabling tracing for the trace point event
> + * the flags associated with comms and tgids shall be checked and, if set,
> + * respectively tracing of comms and tgdis at sched_switch shall be
> + * enabled/disabled.
> + *
> + * Returns 0 on success, or any error returned by the event register or
> + * unregister callbacks.
> + *
> + * NOTE: in order to invoke this code in a thread-safe way, event_mutex shall
> + * be locked before calling it.
> + * NOTE: the validity of the input pointer file shall be checked by the caller

I have to find some time to make sure the above is correct. I'm looking at
this more at a superficial level. And I'll look at the rest later.

Cheers,

-- Steve
