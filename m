Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1521246780;
	Fri, 25 Jul 2025 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753449689; cv=none; b=pKsVIsunkaaq52J+hwYjy/neSX9cbiYgVk4GDWkuEzmXgMVs2bYU4isCIyQJOnPmF+1Dqi/v5W3R5nRnuDNtH5lqAtQoYWIhL/IUVWh9A2c3cDmpfzyJHK9D6F3gL4tFbSC6DQJbsATzlKLgiLnAx5MoMbUY+qG2hZhvN+PHKKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753449689; c=relaxed/simple;
	bh=1MGKZ+QXqS6uZzSzRApOKmGmRcscRN4yJjylkQk/TRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXbPK9q1Ojc3Xf4IiXEGzNo52RmjZuO699qp/9LXVrLqH9VnKKBclwaW1UxcNZC7Sk22fFBg8Edl5V6lt1X+JCYMkcN5Yx2HkcU/O3zfAl4xZjeAhhaJb16qe+sFH0l0OdNE5woR6L+VP4DIA9KKDa8mh2HpkUISrESoCAsIeek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 69B8C1A073E;
	Fri, 25 Jul 2025 13:21:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id B7DE418;
	Fri, 25 Jul 2025 13:21:23 +0000 (UTC)
Date: Fri, 25 Jul 2025 09:21:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] tracing: Remove "__attribute__()" from the type
 field of event format
Message-ID: <20250725092128.6ebd7422@gandalf.local.home>
In-Reply-To: <175333239565.2267214.13923288877217326467.stgit@mhiramat.tok.corp.google.com>
References: <175333238644.2267214.1835493691667067597.stgit@mhiramat.tok.corp.google.com>
	<175333239565.2267214.13923288877217326467.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kbc5npgwmuxgjbo8bn7dj1aahepp9emi
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: B7DE418
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/rYuzcO53HV/k/sFg0ej8lxIWmj+4nzLQ=
X-HE-Tag: 1753449683-921948
X-HE-Meta: U2FsdGVkX18ZCgt8bcLHfNQw/alvGodNchbvbuXEAjV3vQRG6XKrJQ20RroP3jeBtuBbKteTe8B39IdRr+w6FblG+TSv6TsfEf/0RJeY4bplpyKZGcYhsh2XrFMuimM5cKl9Sgny0UQ8TD+00lTpxzKm7usPr/fdcN5I8eEj9alWuHLUUxdpymblahaV41DcEyHRhvFiVNDPrFWlnLoz91SSa9xWzbG6ropySmIOfBQnUNg4y0dq1bXARWWwolqGUbNvIbVlA4tDDx1n/WiWWoJ4C+gBuWt/PNjF30ZBR0aHAllJDoPuR76Dy3HJ317ptwePE2XO1CfNg2ltl1a4T6Cm1txPiijq

On Thu, 24 Jul 2025 13:46:35 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> With CONFIG_DEBUG_INFO_BTF=y and PAHOLE_HAS_BTF_TAG=y, `__user` is
> converted to `__attribute__((btf_type_tag("user")))`. In this case,
> some syscall events have it for __user data, like below;
> 
> /sys/kernel/tracing # cat events/syscalls/sys_enter_openat/format
> name: sys_enter_openat
> ID: 720
> format:
>         field:unsigned short common_type;       offset:0;       size:2; signed:0;
>         field:unsigned char common_flags;       offset:2;       size:1; signed:0;
>         field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
>         field:int common_pid;   offset:4;       size:4; signed:1;
> 
>         field:int __syscall_nr; offset:8;       size:4; signed:1;
>         field:int dfd;  offset:16;      size:8; signed:0;
>         field:const char __attribute__((btf_type_tag("user"))) * filename;      offset:24;      size:8; signed:0;
>         field:int flags;        offset:32;      size:8; signed:0;
>         field:umode_t mode;     offset:40;      size:8; signed:0;
> 
> 
> Then the trace event filter fails to set the string acceptable flag
> (FILTER_PTR_STRING) to the field and rejects setting string filter;
> 
>  # echo 'filename.ustring ~ "*ftracetest-dir.wbx24v*"' \
>     >> events/syscalls/sys_enter_openat/filter
>  sh: write error: Invalid argument
>  # cat error_log
>  [  723.743637] event filter parse error: error: Expecting numeric field
>    Command: filename.ustring ~ "*ftracetest-dir.wbx24v*"
> 
> Since this __attribute__ makes format parsing complicated and not
> needed, remove the __attribute__(.*) from the type string.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v4:
>  - Run sanitizer only if btf_type_tag() attribute is defined.
> Changes in v3:
>  - Sanitize field in update_event_field() to avoid boottime performance
>    overhead.
>  - Change the function names because those are not always require eval
>    maps.
>  - Remove unneeded alloc_type flag.
> Changes in v2:
>  - Add memory allocation check flag.
>  - Check the flag in update_event_fields() to avoid memory leak.
>  - Fix 'static const int ... strlen()' issue.
>  - Fix to find 2nd __attribute__ correctly. (adjust next after strcpy)
> ---
>  kernel/trace/trace.c        |   25 ++++++---
>  kernel/trace/trace.h        |    4 +
>  kernel/trace/trace_events.c |  115 +++++++++++++++++++++++++++++++++++++------
>  3 files changed, 116 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 95ae7c4e5835..b62528c42e26 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5937,17 +5937,26 @@ static inline void trace_insert_eval_map_file(struct module *mod,
>  			      struct trace_eval_map **start, int len) { }
>  #endif /* !CONFIG_TRACE_EVAL_MAP_FILE */
>  
> -static void trace_insert_eval_map(struct module *mod,
> -				  struct trace_eval_map **start, int len)
> +static void
> +trace_event_update_with_eval_map(struct module *mod,
> +				 struct trace_eval_map **start,
> +				 int len)
>  {
>  	struct trace_eval_map **map;
>  
> -	if (len <= 0)
> +	/* Always run sanitizer only if btf_type_tag attr exists. */
> +	if (!(IS_ENABLED(CONFIG_DEBUG_INFO_BTF) &&
> +	      IS_ENABLED(CONFIG_PAHOLE_HAS_BTF_TAG) &&
> +	      __has_attribute(btf_type_tag)) &&
> +	    len <= 0)
>  		return;

The above is quite messy and hard to read. Can you change it to:

	if (len <= 0) {
		/* If bpf_type_tag attr is used, still need to sanitize */
		if (!(IS_ENABLED(CONFIG_DEBUG_INFO_BTF) &&
		      IS_ENABLED(CONFIG_PAHOLE_HAS_BTF_TAG) &&
		      __has_attribute(btf_type_tag))
			return;
	}

Not much better, but a little easier to read.
		
>  
>  	map = start;
>  
> -	trace_event_eval_update(map, len);
> +	trace_event_update_all(map, len);
> +
> +	if (len <= 0)
> +		return;
>  
>  	trace_insert_eval_map_file(mod, start, len);
>  }
> @@ -10335,7 +10344,7 @@ static void __init eval_map_work_func(struct work_struct *work)
>  	int len;
>  
>  	len = __stop_ftrace_eval_maps - __start_ftrace_eval_maps;
> -	trace_insert_eval_map(NULL, __start_ftrace_eval_maps, len);
> +	trace_event_update_with_eval_map(NULL, __start_ftrace_eval_maps, len);
>  }
>  
>  static int __init trace_eval_init(void)
> @@ -10388,9 +10397,6 @@ bool module_exists(const char *module)
>  
>  static void trace_module_add_evals(struct module *mod)
>  {
> -	if (!mod->num_trace_evals)
> -		return;
> -
>  	/*
>  	 * Modules with bad taint do not have events created, do
>  	 * not bother with enums either.
> @@ -10398,7 +10404,8 @@ static void trace_module_add_evals(struct module *mod)
>  	if (trace_module_has_bad_taint(mod))
>  		return;
>  
> -	trace_insert_eval_map(mod, mod->trace_evals, mod->num_trace_evals);
> +	/* Even if no trace_evals, this need to sanitize field types. */
> +	trace_event_update_with_eval_map(mod, mod->trace_evals, mod->num_trace_evals);
>  }
>  
>  #ifdef CONFIG_TRACE_EVAL_MAP_FILE
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index bd084953a98b..1dbf1d3cf2f1 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -2125,13 +2125,13 @@ static inline const char *get_syscall_name(int syscall)
>  
>  #ifdef CONFIG_EVENT_TRACING
>  void trace_event_init(void);
> -void trace_event_eval_update(struct trace_eval_map **map, int len);
> +void trace_event_update_all(struct trace_eval_map **map, int len);
>  /* Used from boot time tracer */
>  extern int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
>  extern int trigger_process_regex(struct trace_event_file *file, char *buff);
>  #else
>  static inline void __init trace_event_init(void) { }
> -static inline void trace_event_eval_update(struct trace_eval_map **map, int len) { }
> +static inline void trace_event_update_all(struct trace_eval_map **map, int len) { }
>  #endif
>  
>  #ifdef CONFIG_TRACER_SNAPSHOT
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 120531268abf..5289e2032678 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3264,41 +3264,115 @@ static void add_str_to_module(struct module *module, char *str)
>  	list_add(&modstr->next, &module_strings);
>  }
>  
> +#define ATTRIBUTE_STR "__attribute__"

If you are going to test for the '(' right after, why not add it to the
strstr test?

> +#define ATTRIBUTE_STR_LEN (sizeof(ATTRIBUTE_STR) - 1)
> +
> +/* Remove all __attribute__() from type */
> +static void sanitize_field_type(char *type)
> +{
> +	char *attr, *tmp, *next;
> +	int depth;
> +
> +	next = type;
> +	while ((attr = strstr(next, ATTRIBUTE_STR))) {
> +		next = attr + ATTRIBUTE_STR_LEN;
> +
> +		/* Retry if __attribute__ is a part of type name. */
> +		if ((attr != type && !isspace(attr[-1])) ||
> +		    *next != '(')

Now you wouldn't need the *next != '(' here.

> +			continue;
> +
> +		depth = 0;

		/* the ATTRIBUTE_STR already has the first '(' */
		depth = 1;

> +		while ((tmp = strpbrk(next, "()"))) {
> +			if (*tmp == '(')
> +				depth++;
> +			else
> +				depth--;
> +			next = tmp + 1;
> +			if (depth == 0)
> +				break;
> +		}
> +		next = skip_spaces(next);
> +		strcpy(attr, next);
> +		next = attr;
> +	}
> +}
> +
> +static bool need_sanitize_field_type(const char *type)
> +{
> +	return !!strstr(type, ATTRIBUTE_STR);
> +}
> +
> +static char *find_replacable_eval(const char *type, const char *eval_string,
> +				  int len)
> +{
> +	char *ptr;
> +
> +	if (!eval_string)
> +		return NULL;
> +
> +	ptr = strchr(type, '[');
> +	if (!ptr)
> +		return NULL;
> +	ptr++;
> +
> +	if (!isalpha(*ptr) && *ptr != '_')
> +		return NULL;
> +
> +	if (strncmp(eval_string, ptr, len) != 0)
> +		return NULL;
> +
> +	return ptr;
> +}
> +
>  static void update_event_fields(struct trace_event_call *call,
>  				struct trace_eval_map *map)
>  {
>  	struct ftrace_event_field *field;
> +	const char *eval_string = NULL;
>  	struct list_head *head;
> +	bool need_sanitize;
> +	int len = 0;
>  	char *ptr;
>  	char *str;
> -	int len = strlen(map->eval_string);
>  
>  	/* Dynamic events should never have field maps */
> -	if (WARN_ON_ONCE(call->flags & TRACE_EVENT_FL_DYNAMIC))
> +	if (call->flags & TRACE_EVENT_FL_DYNAMIC)
>  		return;
>  
> +	if (map) {
> +		eval_string = map->eval_string;
> +		len = strlen(map->eval_string);
> +	}
> +
>  	head = trace_get_fields(call);
>  	list_for_each_entry(field, head, link) {
> -		ptr = strchr(field->type, '[');
> -		if (!ptr)
> -			continue;
> -		ptr++;
>  
> -		if (!isalpha(*ptr) && *ptr != '_')
> -			continue;
> -
> -		if (strncmp(map->eval_string, ptr, len) != 0)
> +		/* Check the field has bad string or eval. */
> +		need_sanitize = need_sanitize_field_type(field->type);

Is there a reason you can't call the sanitize first?

Then you wouldn't need to do the strstr(ATTRIBUTE_STR) twice.

-- Steve


> +		ptr = find_replacable_eval(field->type, eval_string, len);
> +		if (likely(!need_sanitize && !ptr))
>  			continue;
>  
>  		str = kstrdup(field->type, GFP_KERNEL);
>  		if (WARN_ON_ONCE(!str))
>  			return;
> -		ptr = str + (ptr - field->type);
> -		ptr = eval_replace(ptr, map, len);
> -		/* enum/sizeof string smaller than value */
> -		if (WARN_ON_ONCE(!ptr)) {
> -			kfree(str);
> -			continue;
> +
> +		if (ptr) {
> +			ptr = str + (ptr - field->type);
> +
> +			ptr = eval_replace(ptr, map, len);
> +			/* enum/sizeof string smaller than value */
> +			if (WARN_ON_ONCE(!ptr) && !need_sanitize) {
> +				kfree(str);
> +				continue;
> +			}
> +		}
> +		if (need_sanitize) {
> +			sanitize_field_type(str);
> +			/* Update field type */
> +			if (field->filter_type == FILTER_OTHER)
> +				field->filter_type = filter_assign_type(str);
>  		}
>  
>  		/*
> @@ -3313,11 +3387,13 @@ static void update_event_fields(struct trace_event_call *call,
>  	}
>  }
>  
> -void trace_event_eval_update(struct trace_eval_map **map, int len)
> +/* Update all events for replacing eval and sanitizing */
> +void trace_event_update_all(struct trace_eval_map **map, int len)
>  {
>  	struct trace_event_call *call, *p;
>  	const char *last_system = NULL;
>  	bool first = false;
> +	bool updated;
>  	int last_i;
>  	int i;
>  
> @@ -3330,6 +3406,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
>  			last_system = call->class->system;
>  		}
>  
> +		updated = false;
>  		/*
>  		 * Since calls are grouped by systems, the likelihood that the
>  		 * next call in the iteration belongs to the same system as the
> @@ -3349,8 +3426,12 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
>  				}
>  				update_event_printk(call, map[i]);
>  				update_event_fields(call, map[i]);
> +				updated = true;
>  			}
>  		}
> +		/* If not updated yet, update field for sanitizing. */
> +		if (!updated)
> +			update_event_fields(call, NULL);
>  		cond_resched();
>  	}
>  	up_write(&trace_event_sem);

