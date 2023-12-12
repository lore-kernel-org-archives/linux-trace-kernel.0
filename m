Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6232573177
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igwB604A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DE8C433C8;
	Tue, 12 Dec 2023 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702390812;
	bh=32D5OibO0S828mD8/iI+qNHoBvt9+ZXoMSHftKjKbcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=igwB604Aqp997pDV3+MxQMAZQ8IXZXq1CqOBA77lXN+g4O9RD5iF+PYljarvD0ncU
	 jdk7NfWgqwlRa3FRPA6Rs1evDijZ+/w91IrGXq42omc5sizXOFzbOeETGSbXBg/KP+
	 4eIwFRbLWO6CtzCzLCX7TZktFG3YR0w19MW7Ii1kCdmMhy2WcFp9OJ+1/0NfMb9Cpr
	 TNznoeq9hT94hdn8f1UPN31RwvbF5QhcqcAX8h9bqKvuiQBLRXFJhb92bJ/BiifWSX
	 UcED2EHvD6ss0IYeauDQwL3g8PWNHtJhTbt4BexGrPd8OHEBP6okSRhLf/Jakrg9Pp
	 coC3ECf/UFCLQ==
Date: Tue, 12 Dec 2023 23:20:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] ring-buffer: Never use absolute timestamp for first
 event
Message-Id: <20231212232008.5b79e5d7fcb8967604ae5c3a@kernel.org>
In-Reply-To: <20231212071837.5fdd6c13@gandalf.local.home>
References: <20231212071837.5fdd6c13@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 07:18:37 -0500
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
> 
> When first reserving space on the ring buffer, a "before_stamp" and
> "write_stamp" are read. If they do not match, or if either is in the
> process of being updated (false was returned from the read), an absolute
> timestamp is added and the delta is not used, as that requires reading
> theses timestamps without being corrupted.
> 
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
> 
> It's actually likely that w is not zero, but move it out of the unlikeyl()
> and test it first. It should be in hot cache anyway, and there's no reason
> to do the rest of the test for the first event on the sub-buffer. And this
> prevents having to test all the 'or' statements in that case.
> 
> Cc: stable@vger.kernel.org
> Fixes: 58fbc3c63275c ("ring-buffer: Consolidate add_timestamp to remove some branches")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v2: https://lore.kernel.org/linux-trace-kernel/20231211115949.4692e429@gandalf.local.home
> 
> - Move the test to 'w' out of the unlikely and do it first.
>   It's already in hot cache, and the rest of test shouldn't be done
>   if 'w' is zero.
> 
>  kernel/trace/ring_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index b416bdf6c44a..095b86081ea8 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3581,7 +3581,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
>  		 * absolute timestamp.
>  		 * Don't bother if this is the start of a new page (w == 0).
>  		 */
> -		if (unlikely(!a_ok || !b_ok || (info->before != info->after && w))) {
> +		if (w && unlikely(!a_ok || !b_ok || info->before != info->after)) {
>  			info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
>  			info->length += RB_LEN_TIME_EXTEND;
>  		} else {

After this else,

                } else {
                        info->delta = info->ts - info->after;

The code is using info_after, but it is not sure 'a_ok'. Does this mean if
'w == 0 && !a_ok' this doesn't work correctly?
What will be the expected behavior when w == 0 here?

Thank you,


> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
