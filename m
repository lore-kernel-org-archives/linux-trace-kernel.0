Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6737A2459DD;
	Thu, 28 May 2026 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001311; cv=none; b=cU24g2brQlndd4LsGnjv3+3MQwAjICwGP3dlcWFEvbM4sK1TEXqm+SU6PRz+Q3yvX7rN6C9anxGWroaRH3dpCK01gM2bXQe6465YCq+qTXhV1R7S4PKbu+qmbghYsJt3Yx0pglD9opFdXkeit3MLMg7L0awa252lsyl5g4daizI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001311; c=relaxed/simple;
	bh=/qTYCtUvVWElEhbsu6Yv0bRiObRJmE20JY5gCw7tuZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTl7c6318Kh/VrIEl2WX1ldAeXE3oIesD2O63W4p4ej+uOuea1nz6gQjpC9hjRTMBlfOaGbZfVNpB+LH9wTqNdhEpvIrSc5DL6ykMo5GAjm2JwtbKYWo7Ziy6mJFbTTNuGqcVhc3WTag4VqlIEN2NQXuYH2UXIxgSEq71u/+0Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id B5D891620F8;
	Thu, 28 May 2026 20:48:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id C37FD20027;
	Thu, 28 May 2026 20:48:25 +0000 (UTC)
Date: Thu, 28 May 2026 16:49:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 peterz@infradead.org, jpoimboe@kernel.org, samitolvanen@google.com
Subject: Re: [PATCH] tracing: fix CFI violation in probestub helper
Message-ID: <20260528164902.1bb985f3@gandalf.local.home>
In-Reply-To: <20260524154301.21119-1-eva.kurchatova@virtuozzo.com>
References: <20260524154301.21119-1-eva.kurchatova@virtuozzo.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: C37FD20027
X-Stat-Signature: 5ow1d73bmfofru4gqqhm9n18jg9dioeq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/X6Db8NmhdvAeFlduXIPO3abXQoop0LyU=
X-HE-Tag: 1780001305-240675
X-HE-Meta: U2FsdGVkX1+3A+y4E0QhXxVlM2REDh3Z1RkqW7B8JDxWuvr34aDZlA/PDELIQZwzw42awj0vqv62psE54LUhYVR56xVNZFo8obGxWZG0bMQtqJMWvJFG01FgC0wY57YA4w5JASASJDCuo7SxEcg9Uf0BZDIuW1l63VMPY3H9T7bdpoSIc27Z6g4vDuHQUmebzvFX8/tkTM3y+UPI/ytrXgdkWa4DUvh5/HGpVioH1DhqyDZfsulaN2t9bU3REi7d13Nu7prTnXJuKwqyUhmhJaqh+wPiLYeqKimkoxVLrsTb+5wC/eza+akaiNGNu004+k7/8VR18mUUyoiYj0NKI4Uj4uOfwT3ONgt54ml69thlum3gwwtPtdq9YSnocUhzmRtv1qGzxLY2X/Dj4nYeMBV8TtR0US8e

On Sun, 24 May 2026 18:43:01 +0300
Eva Kurchatova <eva.kurchatova@virtuozzo.com> wrote:

> When multiple callbacks are registered on the same tracepoint, probestub
> will be indirectly called via traceiter helper.
> 
> Pointer to probestub callback resides in __tracepoints section, which is
> excluded from ENDBR checks in objtool. Pointers to regfunc/unregfunc
> callbacks reside in extended structure however, which is not affected.
> 
> Registering multiple callbacks will result in a #CP exception due to
> missed ENDBR in __probestub helper on a CFI-enabled machine.
> 
> Fix this by adding CFI_NOSEAL annotation to probestub declaration.
> 
> Fixes: d5173f753750 ("objtool: Exclude __tracepoints data from ENDBR checks")
> Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>

Wait! The probestub is not in the __tracepoints section. At least it
shouldn't be. Are you sure there's not another issue here?

#define __DEFINE_TRACE_EXT(_name, _ext, proto, args)			\
	static const char __tpstrtab_##_name[]				\
	__section("__tracepoints_strings") = #_name;			\
	extern struct static_call_key STATIC_CALL_KEY(tp_func_##_name);	\
	int __traceiter_##_name(void *__data, proto);			\
	void __probestub_##_name(void *__data, proto);			\
	struct tracepoint __tracepoint_##_name	__used			\
	__section("__tracepoints") = {					\

 Here the structure __tracepoint_##name is in the __tracepoints section.

		.name = __tpstrtab_##_name,				\
		.key = STATIC_KEY_FALSE_INIT,				\
		.static_call_key = &STATIC_CALL_KEY(tp_func_##_name),	\
		.static_call_tramp = STATIC_CALL_TRAMP_ADDR(tp_func_##_name), \
		.iterator = &__traceiter_##_name,			\
		.probestub = &__probestub_##_name,			\
		.funcs = NULL,						\
		.ext = _ext,						\
	};								\
	__TRACEPOINT_ENTRY(_name);					\
	int __traceiter_##_name(void *__data, proto)			\
	{								\
		struct tracepoint_func *it_func_ptr;			\
		void *it_func;						\
									\
		it_func_ptr =						\
			rcu_dereference_raw((&__tracepoint_##_name)->funcs); \
		if (it_func_ptr) {					\
			do {						\
				it_func = READ_ONCE((it_func_ptr)->func); \
				__data = (it_func_ptr)->data;		\
				((void(*)(void *, proto))(it_func))(__data, args); \
			} while ((++it_func_ptr)->func);		\
		}							\
		return 0;						\
	}								\
	void __probestub_##_name(void *__data, proto)			\
	{								\
	}

But above, probestub is just a function defined wherever the tracepoint is
created.

In fact, it's just there for fprobes to work. It doesn't get called if you
add more than one callback to the tracepoint. So your explanation is totally
bogus.

Do you actually see a crash? Or is this just some AI slop that told you
this is a bug?

-- Steve



> ---
>  include/linux/tracepoint.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 583d962abcc3..5a32a709759c 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -19,6 +19,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/tracepoint-defs.h>
>  #include <linux/static_call.h>
> +#include <asm/cfi.h>
>  
>  struct module;
>  struct tracepoint;
> @@ -356,6 +357,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	void __probestub_##_name(void *__data, proto)			\
>  	{								\
>  	}								\
> +	CFI_NOSEAL(__probestub_##_name);				\
>  	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
>  
>  #define DEFINE_TRACE_FN(_name, _reg, _unreg, _proto, _args)		\

