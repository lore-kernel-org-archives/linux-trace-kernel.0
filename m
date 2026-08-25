Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F516403123;
	Tue, 25 Aug 2026 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665835; cv=none; b=PhpDuIqKp8KI5sUynojdyEkUXbVEpN9Lch8meD9HZmKyQRhJgWBVDUPoAS4BIbqS8gzQ6PftgV0BeVIOUkuM0Kk0JzyQ4eWR6CcMkCtAG8o577Bb0Rk1xKg8k+EXfwBbE8+jMPpfQNESr6c/OZ/uTH859ClBcbira03JMSN5qVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665835; c=relaxed/simple;
	bh=ZHnGqxoi+oYhWf+Jt7cUwzbcMZKrzKgg950XjEyq6Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfqqSNoGC3LcvFB+A9jeRJZumiZqBIyILbRtetvpdK0BbT4EdY0XHzQUxPzzJC5henpzebkh6qEygtscrZze/4hfZ/CWGEwjS+TQJX2LiEgDOyaGtyr/lx/NU08a30gHdaVzVJQjr3hRErhflC6znQ94/hGB5yo92TKy3Cg3+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=5uRHesK9; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="5uRHesK9"
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id D22B6A03F3;
	Tue, 25 Aug 2026 13:50:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 247F02000F;
	Tue, 25 Aug 2026 13:50:30 +0000 (UTC)
Date: Tue, 25 Aug 2026 09:51:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing/probes: Fix use-after-free on field
 name/type of multi-probe events
Message-ID: <20260825095112.12420edb@gandalf.local.home>
In-Reply-To: <20260825111210.3271443-1-bsdhenrymartin@gmail.com>
References: <20260824144356.1f61aea2@gandalf.local.home>
	<20260825111210.3271443-1-bsdhenrymartin@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 31tze4t7pae3hksqqifffgbra3rwhx1w
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 247F02000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18709dxrohK0t9s9sDuYK9mcfsOc54+dq0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=+kDSCdTZXKD+FWGPT4VtXD3iVJnB2we72zr2jC36xuc=; b=5uRHesK99kkTDeD7VNy7fROFAxRHuop2qELrSPaC4Vk3dZXDcjz+WI+/lBMVqQ0+KoviJtVOQAQgj7Em9LV6/0b3W8nyePJjgxto0NiyV8uvoXMOBMRfirXW7RcB1+Yg3VeZ3qA1NM4HnF37atJojsmAKSNrOc02netdFj3+oEY=
X-HE-Tag: 1787665830-840854
X-HE-Meta: U2FsdGVkX192lIwq2QLlTmMt5qPRkZ9BT9hfnFSThffIigUZltUOJQSg4vNBwYlWtYWlq8/QZtWNbL8x7YFVlhTTXov1jF1T0FZYwGgbBlnoH4ucl1iIgABGTE24zW/M4SWf9jTISzjiuKeA6oWdEckM5aaOun5AKwmrFSo6QLm65xb1CAYumotAKhb7pnHr31RBA0ugCYEcP1xSWTzgd1NiQVB7VGSgEjeMsLF6IQaDQ5kRzRn3VsEu82NJ45ISR9Nhh+tYKRyJhIlN8iFGS8H0a21t0p1C8r0V/G0k9M4Ab/aYjovFTinYd5NaUU/VkRsDTPjd+rESA0Ydo4Epd2u1cXyfFh94

On Tue, 25 Aug 2026 19:12:10 +0800
Henry Martin <bsdhenrymartin@gmail.com> wrote:

> The fields of a probe-based dynamic event (kprobe, uprobe, eprobe and
> fprobe events) are created in traceprobe_define_arg_fields() by handing
> the probe_arg name/type strings to trace_define_field(), which only
> stores the pointers without copying. Those strings are owned by the
> trace_probe and are freed when that probe is removed.
> 
> An event can hold several probes ("multi-probe per event", added by the
> Fixes: commit below).

You can remove the ", added by the Fixes: commit below" as that is already
assumed when there's a Fixes tag.

> The field list is defined only once, by the first
> probe that registers the event, but it is kept alive by any surviving
> sibling probe. Deleting just that first probe by symbol -
> 
>   # primary A: fields are defined from A's args
>   echo 'p:kprobes/ev vfs_read  a1=$arg1' >  kprobe_events
>   # append B: shares A's event call
>   echo 'p:kprobes/ev vfs_write a1=$arg1' >> kprobe_events
>   # delete only A (matched by symbol), B survives
>   echo '-:kprobes/ev vfs_read'           >> kprobe_events
> 
> frees A's args (trace_probe_cleanup() -> traceprobe_free_probe_arg()),
> but trace_probe_unlink() keeps the trace_probe_event because the probe
> list is not empty. The event call stays registered via B while its
> fields now reference freed memory. Any field lookup then reads it, e.g.
> 
>   echo 'a1 == 1' > events/kprobes/ev/filter
> 
>   BUG: KASAN: slab-use-after-free in strcmp+0xa7/0xb0
>   Call Trace:
>    strcmp
>    trace_find_event_field
>    parse_pred
>    process_preds
>    create_filter
>    apply_event_filter
>    event_filter_write
> 
> field->name references parg->name (kstrdup'd, freed with the probe) and,
> for array arguments, field->type references parg->fmt (kmalloc'd, freed
> with the probe) - the scalar type otherwise points at the static
> fmttype rodata, which is safe.
> 
> Fix it in the probe layer, which is where the borrowing happens, so that
> trace_define_field() and static trace events are left untouched. Make

You can remove that first sentence. It's not useful information for this
commit. It's just stating why you changed it from a previous version.

> traceprobe_define_arg_fields() duplicate the name and type strings and
> have the trace_probe_event - which embeds the event call and outlives
> every individual probe - own the copies, releasing them in
> trace_probe_event_free().
> 
> The reproducer above triggers reliably; the field lookup and the delete
> both run under event_mutex, so this is a dangling reference after
> removal rather than a race.
> 
> The issue was found by the autokbug dynamic kernel fuzzer at Tencent
> Yunding Lab.
> 
> Fixes: ca89bc071d5e4 ("tracing/kprobe: Add multi-probe per event support")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> v3:
>  - Steve: wrong fix / wrong file. Move the fix out of trace_events.c
>    into the probe layer (traceprobe_define_arg_fields() /
>    trace_probe_event_free()) so trace_define_field() and static events
>    are untouched. Ownership now lives on trace_probe_event, whose
>    lifetime matches the event call and its field list.
>  - Clarify in the changelog that this is kprobe multi-probe-per-event
>    (append_trace_kprobe), not eprobes, and add a shell reproducer.
> v2:
>  - Reworded the module-rodata note (dropped, superseded by v3).
> 
>  kernel/trace/trace_probe.c | 36 +++++++++++++++++++++++++++++++++++-
>  kernel/trace/trace_probe.h |  2 ++
>  2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index c4163904ba747..26a9fb3533bde 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -2552,19 +2552,48 @@ int traceprobe_set_print_fmt(struct trace_probe *tp, enum probe_print_type ptype
>  int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  				 size_t offset, struct trace_probe *tp)
>  {
> +	struct trace_probe_event *tpe = trace_probe_event_from_call(event_call);
>  	int ret, i;
>  
> +	/*
> +	 * A field created by trace_define_field() only stores the name and
> +	 * type pointers, it does not copy the strings. Here they point into
> +	 * the probe_arg of @tp, which is freed when @tp is removed. For a
> +	 * multi-probe event the field list is defined once by the first probe

Nit. I find "multi-probe event" somewhat ambiguous. Could you reword that
to "an event with multiple probes attached," ?

> +	 * but kept alive by the surviving siblings, so removing that first
> +	 * probe would leave the fields referencing freed memory. Make the
> +	 * event own duplicates that live as long as the event call itself.

The last sentence doesn't parse for me. Can you reword it?

Other than that, the rest looks good.

Masami, have any thoughts?

-- Steve


> +	 */
> +	if (tp->nr_args) {
> +		tpe->field_strings = kcalloc(tp->nr_args * 2, sizeof(char *),
> +					     GFP_KERNEL);
> +		if (!tpe->field_strings)
> +			return -ENOMEM;
> +	}
> +
>  	/* Set argument names as fields */
>  	for (i = 0; i < tp->nr_args; i++) {
>  		struct probe_arg *parg = &tp->args[i];
>  		const char *fmt = parg->type->fmttype;
>  		int size = parg->type->size;
> +		char *name, *type;
>  
>  		if (parg->fmt)
>  			fmt = parg->fmt;
>  		if (parg->count)
>  			size *= parg->count;
> -		ret = trace_define_field(event_call, fmt, parg->name,
> +
> +		name = kstrdup(parg->name, GFP_KERNEL);
> +		type = kstrdup(fmt, GFP_KERNEL);
> +		if (!name || !type) {
> +			kfree(name);
> +			kfree(type);
> +			return -ENOMEM;
> +		}
> +		tpe->field_strings[tpe->nr_field_strings++] = name;
> +		tpe->field_strings[tpe->nr_field_strings++] = type;
> +
> +		ret = trace_define_field(event_call, type, name,
>  					 offset + parg->offset, size,
>  					 parg->type->is_signed,
>  					 FILTER_OTHER);
> @@ -2576,6 +2605,11 @@ int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  
>  static void trace_probe_event_free(struct trace_probe_event *tpe)
>  {
> +	int i;
> +
> +	for (i = 0; i < tpe->nr_field_strings; i++)
> +		kfree(tpe->field_strings[i]);
> +	kfree(tpe->field_strings);
>  	kfree(tpe->class.system);
>  	kfree(tpe->call.name);
>  	kfree(tpe->call.print_fmt);
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index fba1af092a9bd..d1fb3520700fb 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -264,6 +264,8 @@ struct trace_probe_event {
>  	struct trace_event_call		call;
>  	struct list_head 		files;
>  	struct list_head		probes;
> +	char				**field_strings;
> +	int				nr_field_strings;
>  	struct trace_uprobe_filter	filter[];
>  };
>  

