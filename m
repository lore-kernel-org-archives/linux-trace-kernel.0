Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F145A383A5;
	Thu,  6 Feb 2025 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863952; cv=none; b=Q8SwZreAGeSKHucmFeAVyTacHBvBqNV6UplxoBItAipfYg31eL54unfwYocJ6L9vB68Rj/4Vtv8jsNB/odJhbzoOQpKfTQCsbt+AeOFPayz94lUD+WEdFCN2kWVjr9ViR5MkNyCEuuJAbaooFwnDKfjYJVlioZVLDmmAYhGmP/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863952; c=relaxed/simple;
	bh=pEzGzwcqG4AV3dGawUFOo23/moR+4NIZlqB+xb6WqX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbwtkjANqI75cYKw85dGk3+wZOylbwM4DVv498LmFgdG4VYl5ZMDi8Nyrgjq8bHoe9A8KPPJfRmSAi7HnpNJLpq91VBRNFdQdDRJnvlohdE7ZaxZTlmrZi2gK6vI5vb1d0O9E1VzJobMx5tYf+iv1tD1KNLNe1lGmWC7ExgN+Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E3DC4CEDD;
	Thu,  6 Feb 2025 17:45:49 +0000 (UTC)
Date: Thu, 6 Feb 2025 12:46:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] tracing: Show last module text symbols in the
 stacktrace
Message-ID: <20250206124631.7fe2ecfb@gandalf.local.home>
In-Reply-To: <173886114516.496116.8314066678313037503.stgit@devnote2>
References: <20250207015330.5c71ad55ed2f516da1410711@kernel.org>
	<173886114516.496116.8314066678313037503.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri,  7 Feb 2025 01:59:05 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Since the previous boot trace buffer can include module text address in
> the stacktrace. As same as the kernel text address, convert the module
> text address using the module address information.

Note, this doesn't look like it depends on the first two patches, which I
don't think we want yet. As that assumes we never disable the buffer once
we start it, and may start it again. But that's a debate we can have later.

>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace.c        |   76 +++++++++++++++++++++++++++++++++++++=
++++--
>  kernel/trace/trace.h        |    4 ++
>  kernel/trace/trace_output.c |    3 +-
>  3 files changed, 78 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 5a064e712fd7..9d942b7c2651 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -49,6 +49,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/irq_work.h>
>  #include <linux/workqueue.h>
> +#include <linux/sort.h>
> =20
>  #include <asm/setup.h> /* COMMAND_LINE_SIZE and kaslr_offset() */
> =20
> @@ -6007,6 +6008,27 @@ struct trace_scratch {
> =20
>  static DEFINE_MUTEX(scratch_mutex);
> =20
> +unsigned long trace_adjust_address(struct trace_array *tr, unsigned long=
 addr)
> +{
> +	struct trace_scratch *tscratch;
> +	int i;
> +
> +	/* If we don't have last boot delta, return the address */
> +	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
> +		return addr;
> +
> +	tscratch =3D tr->scratch;
> +	if (tscratch && tr->module_delta && tscratch->entries[0].mod_addr < add=
r) {
> +		/* Note that entries are sorted */
> +		for (i =3D 0; i < tr->nr_modules; i++)
> +			if (addr < tscratch->entries[i].mod_addr)
> +				break;
> +		return addr + tr->module_delta[i - 1];
> +	}
> +
> +	return addr + tr->text_delta;
> +}
> +
>  static int save_mod(struct module *mod, void *data)
>  {
>  	struct trace_array *tr =3D data;
> @@ -6068,6 +6090,9 @@ static void update_last_data(struct trace_array *tr)
> =20
>  	/* Using current data now */
>  	tr->text_delta =3D 0;
> +	kfree(tr->module_delta);
> +	tr->module_delta =3D NULL;
> +	tr->nr_modules =3D 0;
> =20
>  	if (!tr->scratch)
>  		return;

The above could probably go after the check for !tr->scratch.

> @@ -9351,10 +9376,37 @@ static struct dentry *trace_instance_dir;
>  static void
>  init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
> =20
> +static int make_mod_delta(struct module *mod, void *data)
> +{
> +	struct trace_scratch *tscratch;
> +	struct trace_mod_entry *entry;
> +	struct trace_array *tr =3D data;
> +	int i;
> +
> +	tscratch =3D tr->scratch;
> +	for (i =3D 0; i < tr->nr_modules; i++) {
> +		entry =3D &tscratch->entries[i];
> +		if (!strcmp(mod->name, entry->mod_name)) {
> +			tr->module_delta[i] =3D (unsigned long)mod->mem[MOD_TEXT].base - entr=
y->mod_addr;
> +			return 1;

Returning 1 causes the module_loop to stop. That is, this will only process
the first module it finds and then no more after that.

> +		}
> +	}

Doesn't this assume that we have the same modules loaded?

Note, I do plan on adding another field in the trace_scratch structure that
has the uname, then only allow the ascii trace to use the current kallsyms
if the uname matches.

> +	return 0;
> +}
> +
> +static int mod_addr_comp(const void *a, const void *b, const void *data)
> +{
> +	const struct trace_mod_entry *e1 =3D a;
> +	const struct trace_mod_entry *e2 =3D b;
> +
> +	return e1->mod_addr - e2->mod_addr;

Hmm, could this possibly cause an overflow issue? If the two addresses are
more than 32 bits apart?

> +}
> +
>  static void setup_trace_scratch(struct trace_array *tr, void *scratch, u=
nsigned int size)
>  {
>  	struct trace_scratch *tscratch =3D scratch;
>  	struct trace_mod_entry *entry;
> +	int i, nr_entries;
> =20
>  	if (!scratch)
>  		return;
> @@ -9371,7 +9423,7 @@ static void setup_trace_scratch(struct trace_array =
*tr, void *scratch, unsigned
>  		goto reset;
> =20
>  	/* Check if each module name is a valid string */
> -	for (int i =3D 0; i < tscratch->nr_entries; i++) {
> +	for (i =3D 0; i < tscratch->nr_entries; i++) {
>  		int n;
> =20
>  		entry =3D &tscratch->entries[i];
> @@ -9385,6 +9437,20 @@ static void setup_trace_scratch(struct trace_array=
 *tr, void *scratch, unsigned
>  		if (n =3D=3D MODULE_NAME_LEN)
>  			goto reset;
>  	}
> +	nr_entries =3D i;
> +	/* Allocate module delta array */
> +	tr->module_delta =3D kcalloc(nr_entries, sizeof(long), GFP_KERNEL);
> +	if (!tr->module_delta)

I wonder if this should trigger a WARN_ON()?

> +		goto reset;
> +	tr->nr_modules =3D nr_entries;
> +
> +	/* Sort module table by base address. */
> +	sort_r(tscratch->entries, nr_entries, sizeof(struct trace_mod_entry),
> +		mod_addr_comp, NULL, NULL);
> +
> +	/* Scan modules */
> +	module_for_each_mod(make_mod_delta, tr);
> +
>  	return;
>   reset:
>  	/* Invalid trace modules */


BTW, here's my removal patch:

-- Steve


=46rom 521bc0e5286c93eb4be981d22a6c05043a78b555 Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 5 Feb 2025 11:55:51 -0500
Subject: [PATCH] tracing: Update modules to persistent instances when remov=
ed

When a module is removed, remove it from the list of saved modules in the
persistent memory to any persistent instance that is currently active.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 69 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 443f2bc5b856..13eeb8df8b8c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6001,6 +6001,7 @@ struct trace_mod_entry {
=20
 struct trace_scratch {
 	unsigned long		kaslr_addr;
+	unsigned long		first_free_slot;
 	unsigned long		nr_entries;
 	struct trace_mod_entry	entries[];
 };
@@ -6012,6 +6013,7 @@ static int save_mod(struct module *mod, void *data)
 	struct trace_array *tr =3D data;
 	struct trace_scratch *tscratch;
 	struct trace_mod_entry *entry;
+	unsigned int idx;
 	unsigned int size;
=20
 	guard(mutex)(&scratch_mutex);
@@ -6021,16 +6023,60 @@ static int save_mod(struct module *mod, void *data)
 		return -1;
 	size =3D tr->scratch_size;
=20
-	if (struct_size(tscratch, entries, tscratch->nr_entries + 1) > size)
-		return -1;
+	idx =3D tscratch->first_free_slot < tscratch->nr_entries ?
+		tscratch->first_free_slot : tscratch->nr_entries;
=20
-	entry =3D &tscratch->entries[tscratch->nr_entries];
+	if (struct_size(tscratch, entries, idx + 1) > size)
+		return -1;
=20
-	tscratch->nr_entries++;
+	entry =3D &tscratch->entries[idx];
=20
 	entry->mod_addr =3D (unsigned long)mod->mem[MOD_TEXT].base;
 	strscpy(entry->mod_name, mod->name);
=20
+	if (idx =3D=3D tscratch->nr_entries)
+		tscratch->nr_entries++;
+
+	for (idx++; idx < tscratch->nr_entries; idx++) {
+		entry =3D &tscratch->entries[idx];
+		if (!entry->mod_addr)
+			break;
+	}
+
+	tscratch->first_free_slot =3D idx;
+
+	return 0;
+}
+
+static int remove_mod(struct module *mod, void *data)
+{
+	struct trace_array *tr =3D data;
+	struct trace_scratch *tscratch;
+	struct trace_mod_entry *entry;
+	unsigned int idx;
+	unsigned int size;
+
+	guard(mutex)(&scratch_mutex);
+
+	tscratch =3D tr->scratch;
+	if (!tscratch)
+		return -1;
+	size =3D tr->scratch_size;
+
+	for (idx =3D 0; idx < tscratch->nr_entries; idx++) {
+		entry =3D &tscratch->entries[idx];
+		if (entry->mod_addr =3D=3D (unsigned long)mod->mem[MOD_TEXT].base)
+			break;
+	}
+	if (idx =3D=3D tscratch->nr_entries)
+		return -1;
+
+	if (idx < tscratch->first_free_slot)
+		tscratch->first_free_slot =3D idx;
+
+	entry->mod_addr =3D 0;
+	entry->mod_name[0] =3D '\0';
+
 	return 0;
 }
=20
@@ -10112,6 +10158,20 @@ static void trace_module_record(struct module *mod)
 	}
 }
=20
+static void trace_module_delete(struct module *mod)
+{
+	struct trace_array *tr;
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		/* Update any persistent trace array that has already been started */
+		if ((tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) =3D=3D
+		    TRACE_ARRAY_FL_BOOT) {
+			if (trace_array_active(tr))
+				remove_mod(mod, tr);
+		}
+	}
+}
+
 static int trace_module_notify(struct notifier_block *self,
 			       unsigned long val, void *data)
 {
@@ -10124,6 +10184,7 @@ static int trace_module_notify(struct notifier_bloc=
k *self,
 		break;
 	case MODULE_STATE_GOING:
 		trace_module_remove_evals(mod);
+		trace_module_delete(mod);
 		break;
 	}
=20
--=20
2.45.2

