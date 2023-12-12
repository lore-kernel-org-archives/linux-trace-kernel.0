Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF31219D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl9o34XT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A671BC433C8;
	Tue, 12 Dec 2023 00:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702341095;
	bh=F/Kxb87O9vo84XgLRSww/hEUCFdP2xq50nSqIwYQH4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nl9o34XTMEL+ih5Oz5tmdl3lsjLyP3MAWTAZqcpckYD8gJbelzuFpPrrtS+pP2sMh
	 4GJL2SayF33WtWgJSRCkozA2GVYFLUNhGwy67Bhn02C4Y4LUxUykYUq5XSVeW0byIh
	 7xe+CA+EdLtdHTvjufmcMSKlvSA7g9p4sPrMcy2BYbsIlRZVTCmu1Nffgdl41WH1YC
	 4QPqujTxcSmGGgm7TIYsAtjY6xoSHUrp4wRy59kCtskEpmWCNKtM3o+/o4iBQPKrLm
	 YlhpIVWUAa+25Nkl8t4yXFk7HUy/3L4vCQg4ra5WEuo4vb3KTSJIzhQjY9C2LBQyj3
	 gcnJgT78CMNuQ==
Date: Tue, 12 Dec 2023 09:31:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Never use absolute timestamp for start
 event
Message-Id: <20231212093131.682d946fdb6b6719ade566e6@kernel.org>
In-Reply-To: <20231211115949.4692e429@gandalf.local.home>
References: <20231211115949.4692e429@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 11:59:49 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> On 32bit machines, the 64 bit timestamps are broken up into 32 bit words
> to keep from using local64_cmpxchg(), as that is very expensive on 32 bit
> architectures.
> 
> On 32 bit architectures, reading these timestamps can happen in a middle
> of an update. In this case, the read returns "false", telling the caller
> that the timestamp is in the middle of an update, and it needs to assume
> it is corrupted. The code then accommodates this.

I'm not sure but, why we don't retry reading the timestamp in this case?

> 
> When first reserving space on the ring buffer, a "before_stamp" and
> "write_stamp" are read. If they do not match, or if either is in the
> process of being updated (false was returned from the read), an absolute
> timestamp is added and the delta is not used, as that requires reading
> theses timestamps without being corrupted.

Ah, so here the timestamp is checked and rejected the corrupted one.

> The one case that this does not matter is if the event is the first event
> on the sub-buffer, in which case, the event uses the sub-buffer's
> timestamp and doesn't need the other stamps for calculating them.
> 
> After some work to consolidate the code, if the before or write stamps are
> in the process of updating, an absolute timestamp will be added regardless
> if the event is the first event on the sub-buffer. This is wrong as it
> should not care about the success of these reads if it is the first event
> on the sub-buffer.
> 
> Fix up the parenthesis so that even if the timestamps are corrupted, if
> the event is the first event on the sub-buffer (w == 0) it still does not
> force an absolute timestamp.

Hmm, in that case don't we remove '&& w' because either the first entry of
the sub-buffer or not, we will add an absolute timestamp if the timestamp
is in update?

Thank you,

> 
> Cc: stable@vger.kernel.org
> Fixes: 58fbc3c63275c ("ring-buffer: Consolidate add_timestamp to remove some branches")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 02bc9986fe0d..bc70cb9bbdb7 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3584,7 +3584,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
>  		 * absolute timestamp.
>  		 * Don't bother if this is the start of a new page (w == 0).
>  		 */
> -		if (unlikely(!a_ok || !b_ok || (info->before != info->after && w))) {
> +		if (unlikely((!a_ok || !b_ok || info->before != info->after) && w)) {
>  			info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
>  			info->length += RB_LEN_TIME_EXTEND;
>  		} else {
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
