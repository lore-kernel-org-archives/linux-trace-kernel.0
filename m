Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5677513D8A0;
	Fri,  7 Feb 2025 01:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738893035; cv=none; b=fOA10jgRYNs8hzYE8M17yCK3GvfcJ3WPe6vDijWzts0DJXhYB6g4imADi9XAUNW0b0ttXSnVmv6C2EAHIQ3MA4rz5TGIRwpDxaWCSAp7ErfXHst9jfy3GwByvx7PUclPgvCFuj4nF2I6Di7yt8kjVXA18YZflS21IGKcQ4GXj6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738893035; c=relaxed/simple;
	bh=JDmpgwRPli0t+qRzeujnWjyH1fJYkoGdjKTTWPc4thw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DGTbZiHJe65Xkt2nKOd8E2FJ5QacoFSsfwKjG+bPLjzfPrxaDz5arH6wt3HyfqbHJJXHKR7A8k747Aruz7vmZqA/zOrgWvvyiAV4tx+ArBKZ2D8RTGCfINtJbgELff23DOvP4jqPc3R/eqXOyw5ukKns1oxFzIiTOScY9136MQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbnEfEgt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbnEfEgt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB6DC4CEE0;
	Fri,  7 Feb 2025 01:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738893033;
	bh=JDmpgwRPli0t+qRzeujnWjyH1fJYkoGdjKTTWPc4thw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WbnEfEgtWHhH4y0u/LeIV8foWZduR3LAbJz3eSz05hmDYP7swdRL45CI/nDicR+uh
	 nZwhTTvAIsHn7tSp18FgyiepFRPG5xU2TuAi/DYt3Y6/XIb2neV7AE49UQY/l2i5Ff
	 d3vpjULK9wyFhtAabMfF1uO6CyVTIy1txYlILGp0Fz8lG6luOrjWnGhUBJqxO55y2w
	 yOVvzCvEv+Nnlo92CorLgsvoVKMkH2fn+JBV9094Y+kxr3+5zqdb4lYlSGBbj1x844
	 a8ZIhGA+Qj5s8NEMQr6akjsBsSSJv53+QfzMtTsp/hlYCP6VrsoljfT1TdEfhbgqWd
	 /aQYZ+4DR7mpg==
Date: Fri, 7 Feb 2025 10:50:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] tracing: Show last module text symbols in the
 stacktrace
Message-Id: <20250207105029.ae917bcd839deea88d0383fc@kernel.org>
In-Reply-To: <20250206124631.7fe2ecfb@gandalf.local.home>
References: <20250207015330.5c71ad55ed2f516da1410711@kernel.org>
	<173886114516.496116.8314066678313037503.stgit@devnote2>
	<20250206124631.7fe2ecfb@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 12:46:31 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri,  7 Feb 2025 01:59:05 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the previous boot trace buffer can include module text address in
> > the stacktrace. As same as the kernel text address, convert the module
> > text address using the module address information.
> 
> Note, this doesn't look like it depends on the first two patches, which I
> don't think we want yet. As that assumes we never disable the buffer once
> we start it, and may start it again. But that's a debate we can have later.

Yes, the first 2 patches are kind of optimization.

> 
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace.c        |   76 +++++++++++++++++++++++++++++++++++++++++--
> >  kernel/trace/trace.h        |    4 ++
> >  kernel/trace/trace_output.c |    3 +-
> >  3 files changed, 78 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 5a064e712fd7..9d942b7c2651 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -49,6 +49,7 @@
> >  #include <linux/fsnotify.h>
> >  #include <linux/irq_work.h>
> >  #include <linux/workqueue.h>
> > +#include <linux/sort.h>
> >  
> >  #include <asm/setup.h> /* COMMAND_LINE_SIZE and kaslr_offset() */
> >  
> > @@ -6007,6 +6008,27 @@ struct trace_scratch {
> >  
> >  static DEFINE_MUTEX(scratch_mutex);
> >  
> > +unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr)
> > +{
> > +	struct trace_scratch *tscratch;
> > +	int i;
> > +
> > +	/* If we don't have last boot delta, return the address */
> > +	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
> > +		return addr;
> > +
> > +	tscratch = tr->scratch;
> > +	if (tscratch && tr->module_delta && tscratch->entries[0].mod_addr < addr) {
> > +		/* Note that entries are sorted */
> > +		for (i = 0; i < tr->nr_modules; i++)
> > +			if (addr < tscratch->entries[i].mod_addr)
> > +				break;
> > +		return addr + tr->module_delta[i - 1];
> > +	}
> > +
> > +	return addr + tr->text_delta;
> > +}
> > +
> >  static int save_mod(struct module *mod, void *data)
> >  {
> >  	struct trace_array *tr = data;
> > @@ -6068,6 +6090,9 @@ static void update_last_data(struct trace_array *tr)
> >  
> >  	/* Using current data now */
> >  	tr->text_delta = 0;
> > +	kfree(tr->module_delta);
> > +	tr->module_delta = NULL;
> > +	tr->nr_modules = 0;
> >  
> >  	if (!tr->scratch)
> >  		return;
> 
> The above could probably go after the check for !tr->scratch.

Indeed.

So TRACE_ARRAY_FL_LAST_BOOT means the buffer is on a reserved memory and it
still have the previous boot data. OTOH, `tr->scratch` means the buffer has
scratch pad area. And currently last_boot_info related fields are used
only if there is a scratch pad area. Currently the reserved memory based
buffer must have the scratch pad, but you might expect there could be
the previous boot data without scratch pad area in the future?

> 
> > @@ -9351,10 +9376,37 @@ static struct dentry *trace_instance_dir;
> >  static void
> >  init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
> >  
> > +static int make_mod_delta(struct module *mod, void *data)
> > +{
> > +	struct trace_scratch *tscratch;
> > +	struct trace_mod_entry *entry;
> > +	struct trace_array *tr = data;
> > +	int i;
> > +
> > +	tscratch = tr->scratch;
> > +	for (i = 0; i < tr->nr_modules; i++) {
> > +		entry = &tscratch->entries[i];
> > +		if (!strcmp(mod->name, entry->mod_name)) {
> > +			tr->module_delta[i] = (unsigned long)mod->mem[MOD_TEXT].base - entry->mod_addr;
> > +			return 1;
> 
> Returning 1 causes the module_loop to stop. That is, this will only process
> the first module it finds and then no more after that.

Ah, good catch! I must have been half asleep. :(

> 
> > +		}
> > +	}
> 
> Doesn't this assume that we have the same modules loaded?

Yes, I thought that was your idea to show the symbols if the same module
is loaded. We can use 

> 
> Note, I do plan on adding another field in the trace_scratch structure that
> has the uname, then only allow the ascii trace to use the current kallsyms
> if the uname matches.

Yeah, it is OK. I thought the build-id is useful, but uname is also good.

> 
> > +	return 0;
> > +}
> > +
> > +static int mod_addr_comp(const void *a, const void *b, const void *data)
> > +{
> > +	const struct trace_mod_entry *e1 = a;
> > +	const struct trace_mod_entry *e2 = b;
> > +
> > +	return e1->mod_addr - e2->mod_addr;
> 
> Hmm, could this possibly cause an overflow issue? If the two addresses are
> more than 32 bits apart?

I guess the modules are loaded in the same area (mostly in vmalloc) and
maybe the area size is under 2GB. Anyway, we can shift down it by page size.

> 
> > +}
> > +
> >  static void setup_trace_scratch(struct trace_array *tr, void *scratch, unsigned int size)
> >  {
> >  	struct trace_scratch *tscratch = scratch;
> >  	struct trace_mod_entry *entry;
> > +	int i, nr_entries;
> >  
> >  	if (!scratch)
> >  		return;
> > @@ -9371,7 +9423,7 @@ static void setup_trace_scratch(struct trace_array *tr, void *scratch, unsigned
> >  		goto reset;
> >  
> >  	/* Check if each module name is a valid string */
> > -	for (int i = 0; i < tscratch->nr_entries; i++) {
> > +	for (i = 0; i < tscratch->nr_entries; i++) {
> >  		int n;
> >  
> >  		entry = &tscratch->entries[i];
> > @@ -9385,6 +9437,20 @@ static void setup_trace_scratch(struct trace_array *tr, void *scratch, unsigned
> >  		if (n == MODULE_NAME_LEN)
> >  			goto reset;
> >  	}
> > +	nr_entries = i;
> > +	/* Allocate module delta array */
> > +	tr->module_delta = kcalloc(nr_entries, sizeof(long), GFP_KERNEL);
> > +	if (!tr->module_delta)
> 
> I wonder if this should trigger a WARN_ON()?

I think this module_delta is optionally decode the previous boot data.
So maybe pr_info() is enough.

> 
> > +		goto reset;
> > +	tr->nr_modules = nr_entries;
> > +
> > +	/* Sort module table by base address. */
> > +	sort_r(tscratch->entries, nr_entries, sizeof(struct trace_mod_entry),
> > +		mod_addr_comp, NULL, NULL);
> > +
> > +	/* Scan modules */
> > +	module_for_each_mod(make_mod_delta, tr);
> > +
> >  	return;
> >   reset:
> >  	/* Invalid trace modules */
> 
> 
> BTW, here's my removal patch:

Thank you! and as I discussed above, I think we can postpone the module
removal until the next module is loaded on the same address.
(or, we can use the scratch pad as a log structured table, in this case
we can set a removal flag and replace the oldest removed one. Something
like LRU.)

Thanks,

> 
> -- Steve
> 
> 
> From 521bc0e5286c93eb4be981d22a6c05043a78b555 Mon Sep 17 00:00:00 2001
> From: Steven Rostedt <rostedt@goodmis.org>
> Date: Wed, 5 Feb 2025 11:55:51 -0500
> Subject: [PATCH] tracing: Update modules to persistent instances when removed
> 
> When a module is removed, remove it from the list of saved modules in the
> persistent memory to any persistent instance that is currently active.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 69 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 65 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 443f2bc5b856..13eeb8df8b8c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6001,6 +6001,7 @@ struct trace_mod_entry {
>  
>  struct trace_scratch {
>  	unsigned long		kaslr_addr;
> +	unsigned long		first_free_slot;
>  	unsigned long		nr_entries;
>  	struct trace_mod_entry	entries[];
>  };
> @@ -6012,6 +6013,7 @@ static int save_mod(struct module *mod, void *data)
>  	struct trace_array *tr = data;
>  	struct trace_scratch *tscratch;
>  	struct trace_mod_entry *entry;
> +	unsigned int idx;
>  	unsigned int size;
>  
>  	guard(mutex)(&scratch_mutex);
> @@ -6021,16 +6023,60 @@ static int save_mod(struct module *mod, void *data)
>  		return -1;
>  	size = tr->scratch_size;
>  
> -	if (struct_size(tscratch, entries, tscratch->nr_entries + 1) > size)
> -		return -1;
> +	idx = tscratch->first_free_slot < tscratch->nr_entries ?
> +		tscratch->first_free_slot : tscratch->nr_entries;
>  
> -	entry = &tscratch->entries[tscratch->nr_entries];
> +	if (struct_size(tscratch, entries, idx + 1) > size)
> +		return -1;
>  
> -	tscratch->nr_entries++;
> +	entry = &tscratch->entries[idx];
>  
>  	entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
>  	strscpy(entry->mod_name, mod->name);
>  
> +	if (idx == tscratch->nr_entries)
> +		tscratch->nr_entries++;
> +
> +	for (idx++; idx < tscratch->nr_entries; idx++) {
> +		entry = &tscratch->entries[idx];
> +		if (!entry->mod_addr)
> +			break;
> +	}
> +
> +	tscratch->first_free_slot = idx;
> +
> +	return 0;
> +}
> +
> +static int remove_mod(struct module *mod, void *data)
> +{
> +	struct trace_array *tr = data;
> +	struct trace_scratch *tscratch;
> +	struct trace_mod_entry *entry;
> +	unsigned int idx;
> +	unsigned int size;
> +
> +	guard(mutex)(&scratch_mutex);
> +
> +	tscratch = tr->scratch;
> +	if (!tscratch)
> +		return -1;
> +	size = tr->scratch_size;
> +
> +	for (idx = 0; idx < tscratch->nr_entries; idx++) {
> +		entry = &tscratch->entries[idx];
> +		if (entry->mod_addr == (unsigned long)mod->mem[MOD_TEXT].base)
> +			break;
> +	}
> +	if (idx == tscratch->nr_entries)
> +		return -1;
> +
> +	if (idx < tscratch->first_free_slot)
> +		tscratch->first_free_slot = idx;
> +
> +	entry->mod_addr = 0;
> +	entry->mod_name[0] = '\0';
> +
>  	return 0;
>  }
>  
> @@ -10112,6 +10158,20 @@ static void trace_module_record(struct module *mod)
>  	}
>  }
>  
> +static void trace_module_delete(struct module *mod)
> +{
> +	struct trace_array *tr;
> +
> +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> +		/* Update any persistent trace array that has already been started */
> +		if ((tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) ==
> +		    TRACE_ARRAY_FL_BOOT) {
> +			if (trace_array_active(tr))
> +				remove_mod(mod, tr);
> +		}
> +	}
> +}
> +
>  static int trace_module_notify(struct notifier_block *self,
>  			       unsigned long val, void *data)
>  {
> @@ -10124,6 +10184,7 @@ static int trace_module_notify(struct notifier_block *self,
>  		break;
>  	case MODULE_STATE_GOING:
>  		trace_module_remove_evals(mod);
> +		trace_module_delete(mod);
>  		break;
>  	}
>  
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
