Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EEA3399E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37719C433C7;
	Tue, 12 Dec 2023 15:37:53 +0000 (UTC)
Date: Tue, 12 Dec 2023 10:38:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] ring-buffer: Never use absolute timestamp for first
 event
Message-ID: <20231212103835.00cc75fd@gandalf.local.home>
In-Reply-To: <20231212232008.5b79e5d7fcb8967604ae5c3a@kernel.org>
References: <20231212071837.5fdd6c13@gandalf.local.home>
	<20231212232008.5b79e5d7fcb8967604ae5c3a@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 23:20:08 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 12 Dec 2023 07:18:37 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > On 32bit machines, the 64 bit timestamps are broken up into 32 bit words
> > to keep from using local64_cmpxchg(), as that is very expensive on 32 bit
> > architectures.
> > 
> > On 32 bit architectures, reading these timestamps can happen in a middle
> > of an update. In this case, the read returns "false", telling the caller
> > that the timestamp is in the middle of an update, and it needs to assume
> > it is corrupted. The code then accommodates this.
> > 
> > When first reserving space on the ring buffer, a "before_stamp" and
> > "write_stamp" are read. If they do not match, or if either is in the
> > process of being updated (false was returned from the read), an absolute
> > timestamp is added and the delta is not used, as that requires reading
> > theses timestamps without being corrupted.
> > 
> > The one case that this does not matter is if the event is the first event
> > on the sub-buffer, in which case, the event uses the sub-buffer's
> > timestamp and doesn't need the other stamps for calculating them.
> > 
> > After some work to consolidate the code, if the before or write stamps are
> > in the process of updating, an absolute timestamp will be added regardless
> > if the event is the first event on the sub-buffer. This is wrong as it
> > should not care about the success of these reads if it is the first event
> > on the sub-buffer.
> > 
> > Fix up the parenthesis so that even if the timestamps are corrupted, if
> > the event is the first event on the sub-buffer (w == 0) it still does not
> > force an absolute timestamp.
> > 
> > It's actually likely that w is not zero, but move it out of the unlikeyl()
> > and test it first. It should be in hot cache anyway, and there's no reason
> > to do the rest of the test for the first event on the sub-buffer. And this
> > prevents having to test all the 'or' statements in that case.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 58fbc3c63275c ("ring-buffer: Consolidate add_timestamp to remove some branches")
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> > Changes since v2: https://lore.kernel.org/linux-trace-kernel/20231211115949.4692e429@gandalf.local.home
> > 
> > - Move the test to 'w' out of the unlikely and do it first.
> >   It's already in hot cache, and the rest of test shouldn't be done
> >   if 'w' is zero.
> > 
> >  kernel/trace/ring_buffer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index b416bdf6c44a..095b86081ea8 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -3581,7 +3581,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
> >  		 * absolute timestamp.
> >  		 * Don't bother if this is the start of a new page (w == 0).
> >  		 */
> > -		if (unlikely(!a_ok || !b_ok || (info->before != info->after && w))) {
> > +		if (w && unlikely(!a_ok || !b_ok || info->before != info->after)) {
> >  			info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
> >  			info->length += RB_LEN_TIME_EXTEND;
> >  		} else {  
> 
> After this else,
> 
>                 } else {
>                         info->delta = info->ts - info->after;
> 
> The code is using info_after, but it is not sure 'a_ok'. Does this mean if
> 'w == 0 && !a_ok' this doesn't work correctly?
> What will be the expected behavior when w == 0 here?
> 

Hmm, looking at this and

  https://lore.kernel.org/linux-trace-kernel/20231212065922.05f28041@gandalf.local.home/

I think the proper solution is simply:

		if (!w) {
			/* Use the sub-buffer timestamp */
			info->delta = 0;
		} else if (unlikely(!a_ok || !b_ok || info->before != info->after)) {
			info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
			info->length += RB_LEN_TIME_EXTEND;
		} else {
			info->delta = info->ts - info->after;
			if (unlikely(test_time_stamp(info->delta))) {
				info->add_timestamp |= RB_ADD_STAMP_EXTEND;
				info->length += RB_LEN_TIME_EXTEND;
			}
		}

Thanks,

-- Steve

