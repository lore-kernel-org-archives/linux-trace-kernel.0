Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FE87E3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDA9C433C7;
	Tue, 12 Dec 2023 01:42:38 +0000 (UTC)
Date: Mon, 11 Dec 2023 20:43:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Never use absolute timestamp for start
 event
Message-ID: <20231211204319.2e847950@gandalf.local.home>
In-Reply-To: <20231212093131.682d946fdb6b6719ade566e6@kernel.org>
References: <20231211115949.4692e429@gandalf.local.home>
	<20231212093131.682d946fdb6b6719ade566e6@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 09:31:31 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 11 Dec 2023 11:59:49 -0500
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
> 
> I'm not sure but, why we don't retry reading the timestamp in this case?

The timestamp that is read is a variable written by the context that this
context interrupted. Reading it again will just produce the same result.

> 
> > 
> > When first reserving space on the ring buffer, a "before_stamp" and
> > "write_stamp" are read. If they do not match, or if either is in the
> > process of being updated (false was returned from the read), an absolute
> > timestamp is added and the delta is not used, as that requires reading
> > theses timestamps without being corrupted.  
> 
> Ah, so here the timestamp is checked and rejected the corrupted one.
> 
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
> 
> Hmm, in that case don't we remove '&& w' because either the first entry of
> the sub-buffer or not, we will add an absolute timestamp if the timestamp
> is in update?

We do not want to add a timestamp if it's the first entry on the sub
buffer, because then it's going to be using the subuffer's timestamp.

> 
> Thank you,
> 
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 58fbc3c63275c ("ring-buffer: Consolidate add_timestamp to remove some branches")
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >  kernel/trace/ring_buffer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 02bc9986fe0d..bc70cb9bbdb7 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -3584,7 +3584,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
> >  		 * absolute timestamp.
> >  		 * Don't bother if this is the start of a new page (w == 0).
> >  		 */
> > -		if (unlikely(!a_ok || !b_ok || (info->before != info->after && w))) {
> > +		if (unlikely((!a_ok || !b_ok || info->before != info->after) && w)) {

But talking with you, I think you are right that we should place the w first.

		if (w && unlikely(!a_ok || !b_ok || info->before != info->after)) {

as the 'w' is not actually unlikely.

-- Steve

> >  			info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
> >  			info->length += RB_LEN_TIME_EXTEND;
> >  		} else {
> > -- 
> > 2.42.0
> >   
> 
> 

