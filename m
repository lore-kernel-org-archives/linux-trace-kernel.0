Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C55C2147F9;
	Wed,  2 Sep 2026 01:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311157; cv=none; b=Xp/Bv70Exvfx1CDUAUpD6AfB4zlmP6DsCHLrwsu7uA5dYHcJPynAG9Xg6PGb+s5cYXZsyEBvZLTmIxM7uBzIBZSWgEK/H5R6C3pBfOHUXgZetmDnIl1u4RG/fg2081DilNXJsc+lQ7UidF42X9V76vDmPAU1CDseveX4D7Vqkqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311157; c=relaxed/simple;
	bh=G6mj4uucw+lxFhJnbCRVLYMLP5qnXYIcGTAvaFQVVRk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P5/JE91BpcPdDMW1LJnkHwKN+AmU9dxB8UI/JjqfK1hBJXyp/4xrkUoBqDobrjgiUPMcsXvBp7miX2oS4b0DJufzFIi876RRUTjiJMjyYz1PJxX5BPUAHCKBDXjytTd6LAPQwUsrEOhesFSPBIj44C/7qAB4/oej5A22lyFQHj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7nFWnEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7nFWnEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663471F000E9;
	Wed,  2 Sep 2026 01:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788311156;
	bh=sLgUC8VpwyFUje+UaIx19juDGpSbhSdLKGKX3IDt4ds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f7nFWnEJFDJUMUXJicySKm0d5xperoMG7j9kmFmI65/4oKw55LyIAj5fI4dlcXHqu
	 He4ZriphRZu9cB3Xb7SqEifgR6q3pA0CPpktIzVDi5g6oggF9eTmcK3hMHjEQkPpNh
	 GknhAWbVBgi9dMQb2YtW5b2f6jwN9OLquZ6ZewPgbaa4jioX6QLCS2P+h8VdVPzBwo
	 5eoMHqRc3I8vLf5SVvjkEKaUxJoh4sheYVsjH6kO4uwF8oD26p+wJJ0N9qxg/nnJds
	 etIWrXw4j7Kb9F/VxXhVGoGIPrjgBK/uwbME1gxEdZmwu2aPHHQGaCFn7sdZDA4uiK
	 BpfEge1rGodwA==
Date: Wed, 2 Sep 2026 10:05:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tracing/probes: Fix use-after-free on field
 name/type of events with multiple probes
Message-Id: <20260902100551.489de0ff0825d1ab2ce8f50e@kernel.org>
In-Reply-To: <20260826030009.1855331-1-bsdhenrymartin@gmail.com>
References: <20260825102221.79713c98@gandalf.local.home>
	<20260826030009.1855331-1-bsdhenrymartin@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 11:00:09 +0800
Henry Martin <bsdhenrymartin@gmail.com> wrote:

> The fields of a probe-based dynamic event (kprobe, uprobe, eprobe and
> fprobe events) are created in traceprobe_define_arg_fields() by handing
> the probe_arg name/type strings to trace_define_field(), which only
> stores the pointers without copying. Those strings are owned by the
> trace_probe and are freed when that probe is removed.
> 
> An event can have several probes attached. The field list is defined
> only once, by the first probe that registers the event, but it is kept
> alive by any surviving sibling probe. Deleting just that first probe by
> symbol -
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
> Have traceprobe_define_arg_fields() duplicate the name and type strings
> and anchor the copies on the trace_probe_event, which embeds the event
> call and outlives every individual probe; trace_probe_event_free()
> releases them.
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

Thanks! this looks good to me.

Hmm, maybe I need to update kselftest to check this issue.
Since the current multiprobe test case does not set any argument, this
was not caught. I have checked this patch with below update.

Let me pick this fix.

Thank you,

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
index f0d5b7777ed7..10633d54130c 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_multiprobe.tc
@@ -30,3 +30,27 @@ cat kprobe_events | grep "$DEF2"
 
 :;: "Appending different type must fail" ;:
 ! echo "$DEF1 \$stack" >> kprobe_events
+
+:;: "Remove remaining probe" ;:
+echo "-:$EVENT_NAME" >> kprobe_events
+
+:;: "Define multiprobe with arguments and verify format and filter after primary removal" ;:
+DEF1_ARG="p:$EVENT_NAME $SYM1 a1=\$stack"
+DEF2_ARG="p:$EVENT_NAME $SYM2 a1=\$stack"
+echo $DEF1_ARG >> kprobe_events
+echo $DEF2_ARG >> kprobe_events
+
+# Remove primary probe that defined the fields
+echo "-:$EVENT_NAME $SYM1" >> kprobe_events
+grep -q "$DEF2_ARG" kprobe_events
+! grep -q "$DEF1_ARG" kprobe_events
+
+# Verify format and filter on remaining event (reads field->name and field->type)
+cat events/$EVENT_NAME/format > /dev/null
+echo 'a1 == 0' > events/$EVENT_NAME/filter
+echo 0 > events/$EVENT_NAME/filter
+
+# Clean up
+echo "-:$EVENT_NAME" >> kprobe_events
+test `cat kprobe_events | wc -l` -eq 0
+



Thanks,

> ---
> v4:
>  - Drop the redundant "added by the Fixes: commit below" and reword the
>    code comment ("an event with multiple probes attached"; clearer last
>    sentence), per Steve's review.
>  - Steve: drop the sentence explaining the move from the previous
>    version from the changelog.
>  - sashiko-bot (ack'd by Steve): traceprobe_define_arg_fields() may be
>    called again after a failed first attempt, since event_define_fields()
>    ignores this hook's return value. Freeing and resetting the leftover
>    duplicates at entry avoids leaking the previous array and writing
>    past the new one.
> v3:
>  - Move the fix out of trace_events.c into the probe layer
>    (traceprobe_define_arg_fields()/trace_probe_event_free()). Ownership
>    lives on trace_probe_event, whose lifetime matches the field list.
>  - Clarify this is kprobe multi-probe-per-event, not eprobes, and add a
>    shell reproducer.
> v2:
>  - Changelog wording (superseded by v3).
> 
>  kernel/trace/trace_probe.c | 48 ++++++++++++++++++++++++++++++++++++-
>  kernel/trace/trace_probe.h |  2 ++
>  2 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index c4163904ba747..0dfeb6d5eec07 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -2552,19 +2552,60 @@ int traceprobe_set_print_fmt(struct trace_probe *tp, enum probe_print_type ptype
>  int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  				 size_t offset, struct trace_probe *tp)
>  {
> +	struct trace_probe_event *tpe = trace_probe_event_from_call(event_call);
>  	int ret, i;
>  
> +	/*
> +	 * A field created by trace_define_field() only stores the name and
> +	 * type pointers, it does not copy the strings. Here they point into
> +	 * the probe_arg of @tp, which is freed when @tp is removed. For an
> +	 * event with multiple probes attached, the field list is defined
> +	 * once by the first probe but kept alive by the surviving siblings,
> +	 * so removing that first probe would leave the fields referencing
> +	 * freed memory. Duplicate the strings and anchor the copies on the
> +	 * trace_probe_event, which lives as long as the field list itself.
> +	 *
> +	 * event_define_fields() ignores the return value of this hook, so
> +	 * if a previous attempt failed before creating any field, it may
> +	 * call here again. Release duplicates left behind by such an
> +	 * attempt before starting over.
> +	 */
> +	for (i = 0; i < tpe->nr_field_strings; i++)
> +		kfree(tpe->field_strings[i]);
> +	kfree(tpe->field_strings);
> +	tpe->field_strings = NULL;
> +	tpe->nr_field_strings = 0;
> +
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
> @@ -2576,6 +2617,11 @@ int traceprobe_define_arg_fields(struct trace_event_call *event_call,
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
> -- 
> 2.43.0


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
