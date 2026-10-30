Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395863;
	b=kTnQD+NqMI3nHGmX0ltHt7j870+viVc6rk1N3BCENrpV7cjTFFdfx7GQ5q+7QErthKjj
	 y143aOcwMncEXUhMqKOPBvzIA+NB7qfFS1Bwh4XYQsBc4WbccInS/LoJfApO+uvcko8o9
	 PQ398jo32RDjIo+qDB4ZiBkG7QQllqt7FmX8E8aEVKfJjDexPz/AtQDEp4U6rFjBlsgtF
	 EezDGTXowRRZ7lyfHLJWFewh47WjribPPVJ1/8sY406Ky82RAt9546utytMvOmnjvpM7d
	 z9OHLNUoLlKv0AThpFGgcV7ZdZQmWJ3aJZZbOEYXVXaR9CKxQBc1oGG5eLnrb5FMrxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395863;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=oMsLb/DFitXdzNYA1WSrlTGfxGJputCfg0bfurbuFrQ=;
	b=0s6AsEUR0RS7A2SICO5LgyQIILerH5uZebhtwUli2tTZqHHwt8CUXWf6nI7+diIrs6IB
	 BPlZFwZwlk+26dd2k/ZiOQ/zYJY417SnBzfeeQVHaaA7e9HoZXGzytm46RjW+AlDlpQ7e
	 nqE81DXUb/XSPe/asRdMX8JRW3WbNCXnzYlWm8d/owp47W5eNnUryZj4DNniRVHSN/9QZ
	 6x+NxXpV3XxCQuvR1Oj3peerFWrvpK2zWFctEsvWQTvY66gYEMQ4lpTGo3nzlqkjBHqir
	 bjp8wwA5nLOLa1imU5JelggoIkkL3/YpULbQkFNdQZKc+jxKLMNuvIKe22UfH2IkhBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=HEgm7fIY;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9A2606A31A;
	Fri, 30 Oct 2026 21:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC9A2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=HEgm7fIY
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 17581807EC;
	Fri, 30 Oct 2026 21:30:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 2C14F2000E;
	Fri, 30 Oct 2026 21:30:50 +0000 (UTC)
Date: Fri, 30 Oct 2026 17:30:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Cao Ruichuang <create0818@163.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Shuah Khan <shuah@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing: Export live module tracepoint strings in
 printk_formats
Message-ID: <20261030173049.6656d506@gandalf.local.home>
In-Reply-To: <178647423521.280401.10184675433127100074@163.com>
References: <20260428083920.4a64eaf6@gandalf.local.home>
	<178647423521.280401.10184675433127100074@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ubn3dezjxx81ghku4sghe97xcf6efjmp
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2C14F2000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+p6zVZCfshOXdXdtQ8doj6JThgneZZKho=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=oMsLb/DFitXdzNYA1WSrlTGfxGJputCfg0bfurbuFrQ=; b=HEgm7fIYzQr/kbGuiWESOMsIUC+zI8ivUcYNnaB1fVeeeIyZCt05PhiavqMKz0XUrZef83OhIvAmfXyMUQCgoJp/MY0ljBgXksf1Ie666HuM9iBPSlrMNnT1WZy9gAXi+LWkhVP54uTVVe1Mj/dtmoTqoSjS9e3JmIdxNwXmxs0=
X-HE-Tag: 1793395850-433973
X-HE-Meta: U2FsdGVkX1/5tOWGQknL5oBXzt4xh+llECwTdv/3xHtyPxqO/mXKvY72/O1s3k3XaTHOBZQz/POGSJCgqR7kf3uiCK0gMbyy/qn693nO3WSTeuIcsS7vaBv6EDXlsuXqEIp1TR6EOMFwd/D+wsrvzQ4w+qL+4H7cXY4cM3aU0SlOXOciJ/KO1RLqFB3kn/9XrxBVJJOhkF7LxLQBG/qbxzQTRe6x04MPhO61DJDA6VMJkmMW/9IUMvOg9+b1HgfVYMwSBO9cQId6M4VuW5Q096KlcAkAVKFYI/dOdIYlV5cRdYBy1vX8Xw3DOVVj0/L5JZUWy1FfHZ953RwVssux4L4rkyXwjdNi

On Tue, 11 Aug 2026 18:15:13 +0000
Cao Ruichuang <create0818@163.com> wrote:

Hi Cao,

Sorry for the late reply, with AI bugs coming in, as well as travel and
conferences, I fell very behind in submitted patches.

> diff --git a/include/linux/module.h b/include/linux/module.h
> index 7566815fa..d9ac1fd6e 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -513,7 +513,9 @@ struct module {
>  #endif
>  #ifdef CONFIG_TRACING
>  	unsigned int num_trace_bprintk_fmt;
> +	unsigned int num_tracepoint_strings;
>  	const char **trace_bprintk_fmt_start;
> +	const char **tracepoint_strings_start;
>  #endif
>  #ifdef CONFIG_EVENT_TRACING
>  	struct trace_event_call **trace_events;
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index e0d838c9c..2b973cc72 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -508,10 +508,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>   * the ASCII strings they represent.
>   *
>   * The @str used must be a constant string and persistent as it would not
> - * make sense to show a string that no longer exists. But it is still fine
> - * to be used with modules, because when modules are unloaded, if they
> - * had tracepoints, the ring buffers are cleared too. As long as the string
> - * does not change during the life of the module, it is fine to use
> + * make sense to show a string that no longer exists. For modules, the string
> + * mapping is exported while the module is loaded. When the module is unloaded,
> + * its trace buffers are cleared before the mapping is removed. As long as the
> + * string does not change during the life of the module, it is fine to use
>   * tracepoint_string() within a module.
>   */
>  #define tracepoint_string(str)						\
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a..cb0acb2ce 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2729,6 +2729,10 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  	mod->trace_bprintk_fmt_start = section_objs(info, "__trace_printk_fmt",
>  					 sizeof(*mod->trace_bprintk_fmt_start),
>  					 &mod->num_trace_bprintk_fmt);
> +	mod->tracepoint_strings_start =
> +		section_objs(info, "__tracepoint_str",
> +			     sizeof(*mod->tracepoint_strings_start),
> +			     &mod->num_tracepoint_strings);
>  #endif
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  	/* sechdrs[0].sh_size is always zero */
> diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
> index 98171a239..2aca8d206 100644
> --- a/kernel/trace/trace_printk.c
> +++ b/kernel/trace/trace_printk.c
> @@ -13,21 +13,29 @@
>  #include <linux/string.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/rcupdate.h>

Please keep this in "upside-down x-mas tree" format. The order of headers
goes by the length of their names.

>  #include <linux/ctype.h>
>  #include <linux/list.h>
>  #include <linux/slab.h>
>  
>  #include "trace.h"
>  
> +static int trace_bprintk_fmt_cnt;
> +
>  #ifdef CONFIG_MODULES
>  
>  /*
>   * modules trace_printk()'s formats are autosaved in struct trace_bprintk_fmt
>   * which are queued on trace_bprintk_fmt_list.
> + *
> + * modules tracepoint_string() entries are kept as ranges into the owning
> + * module's __tracepoint_str section and are removed again when the module
> + * goes away.
>   */
>  static LIST_HEAD(trace_bprintk_fmt_list);
> +static LIST_HEAD(tracepoint_str_list);
>  
> -/* serialize accesses to trace_bprintk_fmt_list */
> +/* serialize updates and printk_formats iteration of the module lists */
>  static DEFINE_MUTEX(btrace_mutex);
>  
>  struct trace_bprintk_fmt {
> @@ -35,6 +43,14 @@ struct trace_bprintk_fmt {
>  	const char *fmt;
>  };
>  
> +struct tracepoint_mod_str {
> +	struct list_head list;
> +	struct rcu_head rcu;
> +	struct module *mod;
> +	const char **start;
> +	unsigned int num;
> +};
> +
>  static inline struct trace_bprintk_fmt *lookup_format(const char *fmt)
>  {
>  	struct trace_bprintk_fmt *pos;
> @@ -75,6 +91,7 @@ void hold_module_trace_bprintk_format(const char **start, const char **end)
>  			if (fmt) {
>  				list_add_tail(&tb_fmt->list, &trace_bprintk_fmt_list);
>  				tb_fmt->fmt = fmt;
> +				trace_bprintk_fmt_cnt++;
>  			} else
>  				kfree(tb_fmt);
>  		}
> @@ -84,16 +101,63 @@ void hold_module_trace_bprintk_format(const char **start, const char **end)
>  	mutex_unlock(&btrace_mutex);
>  }
>  
> +static void hold_module_tracepoint_strings(struct module *mod)
> +{
> +	struct tracepoint_mod_str *tp_str;
> +
> +	if (!mod->num_tracepoint_strings)
> +		return;
> +
> +	tp_str = kmalloc_obj(*tp_str);
> +	if (!tp_str)
> +		return;
> +
> +	tp_str->mod = mod;
> +	tp_str->start = mod->tracepoint_strings_start;
> +	tp_str->num = mod->num_tracepoint_strings;
> +
> +	guard(mutex)(&btrace_mutex);
> +	list_add_tail_rcu(&tp_str->list, &tracepoint_str_list);
> +}
> +
> +static void release_module_tracepoint_strings(struct module *mod)
> +{
> +	struct tracepoint_mod_str *tp_str;
> +
> +	if (!mod->num_tracepoint_strings)
> +		return;
> +
> +	guard(mutex)(&btrace_mutex);
> +	list_for_each_entry(tp_str, &tracepoint_str_list, list) {

Please use list_for_each_entry_safe(). You are removing tp_str from the
list. Do not rely on internals of RCU to protect this. If the lock was a
spin lock, then it may have been safe (even though I would still ask for
this change). But because it is a mutex, this could be preempted, the RCU
grace period finish, the tp_str freed and then the loop will crash.

> +		if (tp_str->mod != mod)
> +			continue;
> +
> +		list_del_rcu(&tp_str->list);
> +		/* Module teardown waits for RCU before freeing the section. */
> +		kfree_rcu(tp_str, rcu);
> +		return;
> +	}
> +}
> +
>  static int module_trace_bprintk_format_notify(struct notifier_block *self,
>  		unsigned long val, void *data)
>  {
>  	struct module *mod = data;
> -	if (mod->num_trace_bprintk_fmt) {
> -		const char **start = mod->trace_bprintk_fmt_start;
> -		const char **end = start + mod->num_trace_bprintk_fmt;
>  
> -		if (val == MODULE_STATE_COMING)
> +	switch (val) {
> +	case MODULE_STATE_COMING:
> +		if (mod->num_trace_bprintk_fmt) {
> +			const char **start = mod->trace_bprintk_fmt_start;
> +			const char **end = start + mod->num_trace_bprintk_fmt;
> +
>  			hold_module_trace_bprintk_format(start, end);
> +		}
> +		hold_module_tracepoint_strings(mod);
> +		break;
> +	case MODULE_STATE_GOING:
> +		/* Trace event teardown runs first and clears module event buffers. */
> +		release_module_tracepoint_strings(mod);
> +		break;
>  	}
>  	return NOTIFY_OK;
>  }
> @@ -119,7 +183,7 @@ static int module_trace_bprintk_format_notify(struct notifier_block *self,
>   * next format in the list.
>   */
>  static const char **
> -find_next_mod_format(int start_index, void *v, const char **fmt, loff_t *pos)
> +find_next_mod_format(loff_t start_index, void *v, const char **fmt, loff_t *pos)
>  {
>  	struct trace_bprintk_fmt *mod_fmt;
>  
> @@ -158,6 +222,42 @@ find_next_mod_format(int start_index, void *v, const char **fmt, loff_t *pos)
>  	return &mod_fmt->fmt;
>  }
>  
> +static const char **
> +find_next_mod_tracepoint_str(loff_t start_index, loff_t *pos)
> +{
> +	struct tracepoint_mod_str *tp_str;
> +	loff_t offset = *pos - start_index;
> +
> +	if (offset < 0)
> +		return NULL;
> +
> +	list_for_each_entry(tp_str, &tracepoint_str_list, list) {
> +		if (offset < (loff_t)tp_str->num)
> +			return tp_str->start + offset;
> +
> +		offset -= tp_str->num;
> +	}
> +
> +	return NULL;
> +}
> +
> +static bool is_module_tracepoint_string(const char *str)
> +{
> +	struct tracepoint_mod_str *tp_str;
> +	unsigned int i;
> +
> +	/* The tracepoint printk path can call this with IRQs disabled. */
> +	guard(rcu)();
> +	list_for_each_entry_rcu(tp_str, &tracepoint_str_list, list) {
> +		for (i = 0; i < tp_str->num; i++) {
> +			if (str == tp_str->start[i])
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  static void format_mod_start(void)
>  {
>  	mutex_lock(&btrace_mutex);
> @@ -176,10 +276,21 @@ module_trace_bprintk_format_notify(struct notifier_block *self,
>  	return NOTIFY_OK;
>  }
>  static inline const char **
> -find_next_mod_format(int start_index, void *v, const char **fmt, loff_t *pos)
> +find_next_mod_format(loff_t start_index, void *v, const char **fmt, loff_t *pos)
> +{
> +	return NULL;
> +}
> +
> +static inline const char **
> +find_next_mod_tracepoint_str(loff_t start_index, loff_t *pos)
>  {
>  	return NULL;
>  }
> +
> +static inline bool is_module_tracepoint_string(const char *str)
> +{
> +	return false;
> +}
>  static inline void format_mod_start(void) { }
>  static inline void format_mod_stop(void) { }
>  #endif /* CONFIG_MODULES */
> @@ -194,6 +305,7 @@ void trace_printk_control(bool enabled)
>  __initdata_or_module static
>  struct notifier_block module_trace_bprintk_format_nb = {
>  	.notifier_call = module_trace_bprintk_format_notify,
> +	.priority = 0, /* lower than the trace event notifier */
>  };
>  
>  __printf(2, 3)
> @@ -259,14 +371,14 @@ bool trace_is_tracepoint_string(const char *str)
>  		if (str == *ptr)
>  			return true;
>  	}
> -	return false;
> +	return is_module_tracepoint_string(str);
>  }
>  
>  static const char **find_next(void *v, loff_t *pos)
>  {
>  	const char **fmt = v;
> -	int start_index;
> -	int last_index;
> +	loff_t start_index;
> +	loff_t last_index;
>  
>  	start_index = __stop___trace_bprintk_fmt - __start___trace_bprintk_fmt;
>  
> @@ -292,7 +404,11 @@ static const char **find_next(void *v, loff_t *pos)
>  		return __start___tracepoint_str + (*pos - last_index);
>  
>  	start_index += last_index;
> -	return find_next_mod_format(start_index, v, fmt, pos);
> +	if (*pos - start_index < trace_bprintk_fmt_cnt)
> +		return find_next_mod_format(start_index, v, fmt, pos);
> +
> +	start_index += trace_bprintk_fmt_cnt;
> +	return find_next_mod_tracepoint_str(start_index, pos);
>  }
>  
>  static void *
> diff --git a/samples/trace_printk/trace-printk.c b/samples/trace_printk/trace-printk.c
> index cfc159580..54c709c82 100644
> --- a/samples/trace_printk/trace-printk.c
> +++ b/samples/trace_printk/trace-printk.c
> @@ -2,6 +2,7 @@
>  #include <linux/module.h>
>  #include <linux/kthread.h>
>  #include <linux/irq_work.h>
> +#include <linux/tracepoint.h>
>  
>  /* Must not be static to force gcc to consider these non constant */
>  char *trace_printk_test_global_str =
> @@ -31,6 +32,9 @@ static int __init trace_printk_init(void)
>  {
>  	init_irq_work(&irqwork, trace_printk_irq_work);
>  
> +	(void)tracepoint_string("tracepoint_string_test_module_string_1");
> +	(void)tracepoint_string("tracepoint_string_test_module_string_2");

Actually this shouldn't be in trace_printk() as that's not how it would be
used. Please add it to samples. Something like this:

diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index ca5d98c360cb..e00630c2d922 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -51,6 +51,10 @@ static void do_simple_thread_func(int cnt, const char *fmt, ...)
 	trace_foo_with_template_print("I have to be different", cnt);
 
 	trace_foo_rel_loc("Hello __rel_loc", cnt, bitmask, current->cpus_ptr);
+
+	trace_foo_tracepoint_str(tracepoint_string("tracepoint_string_test_module_string_1"));
+	trace_foo_tracepoint_str(tracepoint_string("tracepoint_string_test_module_string_2"));
+
 }
 
 static void simple_thread_func(int cnt)
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 816848a456a2..48bca97086b6 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -623,6 +623,23 @@ TRACE_EVENT(foo_timer_fn,
 
 	TP_printk("name=%s count=%d", __get_str(name), __entry->count)
 );
+
+TRACE_EVENT(foo_tracepoint_str,
+
+	TP_PROTO(const char *str),
+
+	TP_ARGS(str),
+
+	TP_STRUCT__entry(
+		__field(	const char *,		str	)
+	),
+
+	TP_fast_assign(
+		__entry->str = str;
+	),
+
+	TP_printk("str=%s", __entry->str)
+);
 #endif
 
 /***** NOTICE! The #if protection ends here. *****/


> +
>  	trace_printk("This is a static string that will use trace_bputs\n");
>  	trace_printk(trace_printk_test_global_str);
>  
> diff --git a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> index b02550b42..d66a8134c 100644
> --- a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> +++ b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> @@ -23,5 +23,10 @@ grep -q ": (irq) .* trace_printk" trace
>  
>  grep -q "This is a %s that will use trace_bprintk" printk_formats
>  grep -q "(irq) This is a static string that will use trace_bputs" printk_formats
> +grep -q "tracepoint_string_test_module_string_1" printk_formats
> +grep -q "tracepoint_string_test_module_string_2" printk_formats
>  
>  rmmod trace-printk ||:
> +
> +! grep -q "tracepoint_string_test_module_string_1" printk_formats
> +! grep -q "tracepoint_string_test_module_string_2" printk_formats

You would need different test that relies on the trace event sample code
and do this test there.


> 
> base-commit: d5b201ed4feb7a11da242a97669424efeb724031


Thanks,

-- Steve

