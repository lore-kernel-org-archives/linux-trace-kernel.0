Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A71DE2A0;
	Mon,  7 Oct 2024 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325663; cv=none; b=qDj5Pl0Odg+LIeMEtxtYNRxBIASs8HPXEQuQfaoTIXpPSRkBbLd/c1d4aNEM040iGe4xrzA+Ub3LDuoawKHgYkYx+wFzhrDV1wP86HlFxDVfi8ayfpStXEupNe10jjpn90iA3LC7Qy18tZeLOVM5QqqplsXQ0Sie2HJg2G1MqMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325663; c=relaxed/simple;
	bh=R7qPm/zvF4OcfCDCFOz7YuBz4ugGCU5ooI4nhanJLhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNFaN7YlzrMZR2FlnRWHlFRqKpREV9ufDXXLxuqL44Dd9E/CiF5KzziMmpKBXbpuf2W+T+VX9naPScZuBVVJ3riLAd0Gj2jtX4hZMgdLtDT2VmyY1k/t2vJOhA76GDFmUmMxDZ+65gqpBttAM1JeGkzdaydnMPMAWayZ5F5IC+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0E8C4CEC6;
	Mon,  7 Oct 2024 18:27:41 +0000 (UTC)
Date: Mon, 7 Oct 2024 14:27:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH] tracepoints: Use new static branch API
Message-ID: <20241007142742.7d5850c5@gandalf.local.home>
In-Reply-To: <20241007182521.xtlduygupnt6wnfa@treble>
References: <03da49e81c50eb2a9f47918409e4c590c0f28060.1727817249.git.jpoimboe@kernel.org>
	<20241007182521.xtlduygupnt6wnfa@treble>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 11:25:21 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Tue, Oct 01, 2024 at 03:24:01PM -0700, Josh Poimboeuf wrote:
> > The old static key API based on 'struct static_key' is deprecated.
> > Convert tracepoints to use the new API.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>  
> 
> Steven,
> 
> The kernel test robot found this patch breaks the build with
> CONFIG_HIST_TRIGGERS:
> 
>   https://lore.kernel.org/202410040333.vJSL1NXx-lkp@intel.com
> 
> Here's the fix, do you want to squash it in or should I post a v2?

Please post a v2. My workflow relies on patchwork, as it will automatically
update the status of the patch as it goes through git trees and my
"for-next/linus" postings.

If I modify the patch, then I need to do it manually.

-- Steve


> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 5f9119eb7c67..cc2924ad32a3 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -822,7 +822,7 @@ static inline void trace_synth(struct synth_event *event, u64 *var_ref_vals,
>  {
>  	struct tracepoint *tp = event->tp;
>  
> -	if (unlikely(atomic_read(&tp->key.enabled) > 0)) {
> +	if (unlikely(static_key_enabled(&tp->key))) {
>  		struct tracepoint_func *probe_func_ptr;
>  		synth_probe_func_t probe_func;
>  		void *__data;

