Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C023CE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760425697; cv=none; b=mYpNOzpTtZ8FiWqWTPRfu6Qcqte4Ob+ILH1mG01eGykMmH680pVzOqhIbRPNEmyralp9No9fHqeuj2vbJz0OW4nrJyq3KwJlFvjhc0z1OoARf9+HSztKir1a9MjUWU2ZfJZk/AO72tvg3uvjQye3oBhIn0FxBkqnhdpuxi4KcBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760425697; c=relaxed/simple;
	bh=IFdx44pNyqPY8SY4rPShB5bYnZzgvHxflnf2/XOWWAo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWp6SwAbT0Px3aXRulSse3XuJ7/9+bLBfgcRr5AYG7zzrXfeKFhjLDGGJk5UWK8MELoFGI4vySs4QxNVDoXpaRv9upqToCKqPYOZafLSu+2q4AchrESO/+be/DkVJ3Od4fQl80RVt/EjWRWP77skvYt8+uKhgxAmwGgbNofl7zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ad4tKOK2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ad4tKOK2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760425694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IFdx44pNyqPY8SY4rPShB5bYnZzgvHxflnf2/XOWWAo=;
	b=ad4tKOK2lhMWXw7Aoj2qeW7Df6lLQIT8+VfRrbsfLLMQ6rPu9wC1+IDN/h4TdOhZs4YA3s
	QozySVEtJInIQ34y10aTILW9ZOhWDqRXOqk8NZIppEDQIvsfvQMCBKr2eIiHFPo5zLgJr6
	ubAdZ1Ot0qIwpOYKaQYQRk7GxnvF5vk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-Bol1uCTQPJePPGApESCVNA-1; Tue, 14 Oct 2025 03:08:13 -0400
X-MC-Unique: Bol1uCTQPJePPGApESCVNA-1
X-Mimecast-MFC-AGG-ID: Bol1uCTQPJePPGApESCVNA_1760425692
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso3974209f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760425692; x=1761030492;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kttvYHXy0dkls+A2ePr50EJQBuY3+2CK/H0WABCdXHI=;
        b=d3y4b+qHf4W+hwl7Ddml5cBY6X5wl2caXM2Yq2qEZpBKNUnkyJ1Ty3QXoIVbpBDz7m
         n3P0V9yl3jhuEvOCius4i31zzssLYwNIcPxSXn0aj0ysxVrdZ7ujRjCJjV1U14Fwpr07
         N9pyt3DvQBGGwbfnOic9dqtvnK7CzRr8OqecHZL+rlwM0gn09dkSxYLMcO0i7eeuPt7+
         k3obVR3JnFF1SOGBVTOJfQCfyh9E4n3Fl9LY4P/+Cjit+U/2hKKGDyegc7E/KwWSWtt4
         n3BDHrn/tf1glN0BWTjeRJdaAoECUEzaYufaMuDmOcq5c9hUePe4SSXcBCthwzl7DgLH
         WUZA==
X-Gm-Message-State: AOJu0YyW1FG6WrMsXi2H5RgONNEFSMoc8lxgGway47pvMfndEwBhRGgv
	kzAvyrvNg99QJWcn8q8DjWoFStFNcPGOuIZ6Tc/m9vkrR3KPek35kdGmBYxNFBJ9X9DnYWNvdZD
	585Q3rvULYob2DDSZYMmKd47MAoBpT4L57giXkV9SMr3+XQxXCFfBVUwdOgIfnCbtXYVjqcHnPQ
	==
X-Gm-Gg: ASbGncvk2P4AMOYvdV9zL8a6G0yQx3Gp0g5NWbNT976mHtVTmzzFpzGrgVQLiIcW1OW
	I/BaOl5c+tUCmxCOmKBJVMK420TGicd2+SFIzGlqb9IjDDHuSfiUu+1Hb64lZM4aIMOz1BNcjWN
	7wPxCpQW1k2YGu6j+JUT74d66fHWmafAkpioa0kcbmhbKR3BboX2mBQ8DzMWKHlHGs1v1gQTDr4
	c2zY/ogk+yTdJaXXaOAbBmWJTpEXe2eMx2wF6EsT2GXOm7BLUGQyNQas557tQ3bT7Z7NU6TZK7q
	ofWV0tJWX4ee5+YMzqVjAslSTTrvWuYWDtiPAQa5YmqnIqszNlL46NXfgXM+qlhsNA==
X-Received: by 2002:a05:600c:3b11:b0:46e:43ee:3809 with SMTP id 5b1f17b1804b1-46fa9a86364mr172019475e9.7.1760425691847;
        Tue, 14 Oct 2025 00:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBGRGjdiMCnQn5yNuX2bFCVFs8mYsMvlH0qZjdQzQmK4l4YIwFG7Zm0iMoZHgEddJ5BuP3LA==
X-Received: by 2002:a05:600c:3b11:b0:46e:43ee:3809 with SMTP id 5b1f17b1804b1-46fa9a86364mr172019215e9.7.1760425691431;
        Tue, 14 Oct 2025 00:08:11 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426e50ef821sm7331150f8f.38.2025.10.14.00.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:08:11 -0700 (PDT)
Message-ID: <704a58272bb9071d31488c1e12d508914dc391a5.camel@redhat.com>
Subject: Re: [PATCH 1/3] rv: Pass va_list to reactors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>,
 Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Oct 2025 09:08:10 +0200
In-Reply-To: <20251014-rv-lockdep-v1-1-0b9e51919ea8@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
	 <20251014-rv-lockdep-v1-1-0b9e51919ea8@linutronix.de>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o1881GD0db-4fAJzYt-UWiMQoLAPPcrg7yWF7Yi8NzM_1760425692
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-10-14 at 07:51 +0200, Thomas Wei=C3=9Fschuh wrote:
> The only thing the reactors can do with the passed in varargs is to
> convert it into a va_list. Do that in a central helper instead.
> It simplifies the reactors, removes some hairy macro-generated code
> and introduces a convenient hook point to modify reactor behavior.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -16,34 +16,19 @@
> =C2=A0#include <linux/bug.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0
> -#ifdef CONFIG_RV_REACTORS
> -
> -#define DECLARE_RV_REACTING_HELPERS(name,
> type)=09=09=09=09=09=09=09\
> -static void cond_react_##name(type curr_state, type
> event)=09=09=09=09=09\
> -
> {=09=09=09=09=09=09=09=09=09=09=09=09\
> -=09if (!rv_reacting_on() ||
> !rv_##name.react)=09=09=09=09=09=09\
> -
> =09=09return;=09=09=09=09=09=09=09=09=09=09\
> -=09rv_##name.react("rv: monitor %s does not allow event %s on state
> %s\n",=09=09=09\
> -
> =09=09=09#name,=09=09=09=09=09=09=09=09=09\
> -
> =09=09=09model_get_event_name_##name(event),=09=09=09=09=09\
> -
> =09=09=09model_get_state_name_##name(curr_state));=09=09=09=09\
> -}
> -

The overall change looks good to me, just keep in mind there is an ongoing
refactor [1] for the da_monitor header to get rid of those macros, basicall=
y
making it more similar to the current ltl.
Depending on which gets merged first, you may need some (trivial) adaptatio=
n of
this.

Going to test it out more carefully in the next days.

Thanks,
Gabriele

[1] - https://lore.kernel.org/lkml/20250919140954.104920-1-gmonaco@redhat.c=
om

> -#else /* CONFIG_RV_REACTOR */
> -
> -#define DECLARE_RV_REACTING_HELPERS(name,
> type)=09=09=09=09=09=09=09\
> -static void cond_react_##name(type curr_state, type
> event)=09=09=09=09=09\
> -
> {=09=09=09=09=09=09=09=09=09=09=09=09\
> -
> =09return;=09=09=09=09=09=09=09=09=09=09=09\
> -}
> -#endif
> -
> =C2=A0/*
> =C2=A0 * Generic helpers for all types of deterministic automata monitors=
.
> =C2=A0 */
> =C2=A0#define DECLARE_DA_MON_GENERIC_HELPERS(name,
> type)=09=09=09=09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09=09
> =09=09=09\
> -DECLARE_RV_REACTING_HELPERS(name,
> type)=09=09=09=09=09=09=09=09\
> +static void react_##name(type curr_state, type
> event)=09=09=09=09=09=09\
> +{=09=09=09=09=09=09=09=09=09
> =09=09=09\
> +=09rv_react(&rv_##name,=09=09=09=09=09=09
> =09=09=09\
> +=09=09 "rv: monitor %s does not allow event %s on state
> %s\n",=09=09=09\
> +=09=09
> #name,=09=09=09=09=09=09=09=09=09=09\
> +=09=09
> model_get_event_name_##name(event),=09=09=09=09=09=09\
> +=09=09
> model_get_state_name_##name(curr_state));=09=09=09=09=09\
> +}=09=09=09=09=09=09=09=09=09
> =09=09=09\
> =C2=A0=09=09=09=09=09=09=09=09=09
> =09=09=09\
> =C2=A0/*=09=09=09=09=09=09=09=09=09
> =09=09=09\
> =C2=A0 * da_monitor_reset_##name - reset a monitor and setting it to init
> state=09=09=09\
> @@ -126,7 +111,7 @@ da_event_##name(struct da_monitor *da_mon, enum
> events_##name event)=09=09=09=09\
> =C2=A0=09for (int i =3D 0; i < MAX_DA_RETRY_RACING_EVENTS; i++)
> {=09=09=09=09=09\
> =C2=A0=09=09next_state =3D model_get_next_state_##name(curr_state,
> event);=09=09=09\
> =C2=A0=09=09if (next_state =3D=3D INVALID_STATE)
> {=09=09=09=09=09=09\
> -=09=09=09cond_react_##name(curr_state,
> event);=09=09=09=09=09\
> +=09=09=09react_##name(curr_state,
> event);=09=09=09=09=09\
> =C2=A0=09=09=09trace_error_##name(model_get_state_name_##name(curr_s
> tate),=09=09\
> =C2=A0=09=09=09=09=09=C2=A0=C2=A0
> model_get_event_name_##name(event));=09=09=09\
> =C2=A0=09=09=09return
> false;=09=09=09=09=09=09=09=09\
> @@ -165,7 +150,7 @@ static inline bool da_event_##name(struct da_monitor
> *da_mon, struct task_struct
> =C2=A0=09for (int i =3D 0; i < MAX_DA_RETRY_RACING_EVENTS; i++)
> {=09=09=09=09=09\
> =C2=A0=09=09next_state =3D model_get_next_state_##name(curr_state,
> event);=09=09=09\
> =C2=A0=09=09if (next_state =3D=3D INVALID_STATE)
> {=09=09=09=09=09=09\
> -=09=09=09cond_react_##name(curr_state,
> event);=09=09=09=09=09\
> +=09=09=09react_##name(curr_state,
> event);=09=09=09=09=09\
> =C2=A0=09=09=09trace_error_##name(tsk-
> >pid,=09=09=09=09=09=09\
> =C2=A0=09=09=09=09=09=C2=A0=C2=A0
> model_get_state_name_##name(curr_state),=09=09\
> =C2=A0=09=09=09=09=09=C2=A0=C2=A0
> model_get_event_name_##name(event));=09=09=09\
> diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
> index
> 5368cf5fd623e74a5739d2e0b3fc2c27c4bad597..00c42b36f961a00ee473aa58f14b015=
30852
> 3eb0 100644
> --- a/include/rv/ltl_monitor.h
> +++ b/include/rv/ltl_monitor.h
> @@ -16,21 +16,12 @@
> =C2=A0#error "Please include $(MODEL_NAME).h generated by rvgen"
> =C2=A0#endif
> =C2=A0
> -#ifdef CONFIG_RV_REACTORS
> =C2=A0#define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
> -static struct rv_monitor RV_MONITOR_NAME;
> =C2=A0
> -static void rv_cond_react(struct task_struct *task)
> -{
> -=09if (!rv_reacting_on() || !RV_MONITOR_NAME.react)
> -=09=09return;
> -=09RV_MONITOR_NAME.react("rv: "__stringify(MONITOR_NAME)": %s[%d]:
> violation detected\n",
> -=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 task->comm, task->pid);
> -}
> +#ifdef CONFIG_RV_REACTORS
> +static struct rv_monitor RV_MONITOR_NAME;
> =C2=A0#else
> -static void rv_cond_react(struct task_struct *task)
> -{
> -}
> +extern struct rv_monitor RV_MONITOR_NAME;
> =C2=A0#endif
> =C2=A0
> =C2=A0static int ltl_monitor_slot =3D RV_PER_TASK_MONITOR_INIT;
> @@ -98,7 +89,8 @@ static void ltl_monitor_destroy(void)
> =C2=A0static void ltl_illegal_state(struct task_struct *task, struct ltl_=
monitor
> *mon)
> =C2=A0{
> =C2=A0=09CONCATENATE(trace_error_, MONITOR_NAME)(task);
> -=09rv_cond_react(task);
> +=09rv_react(&RV_MONITOR_NAME, "rv: "__stringify(MONITOR_NAME)": %s[%d]:
> violation detected\n",
> +=09=09 task->comm, task->pid);
> =C2=A0}
> =C2=A0
> =C2=A0static void ltl_attempt_start(struct task_struct *task, struct ltl_=
monitor
> *mon)
> diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_pa=
nic.c
> index
> 74c6bcc2c7494408770881dda2b0de885c5eb88c..76537b8a4343cbd0d715f60db3cc886=
8e71c
> 1c0b 100644
> --- a/kernel/trace/rv/reactor_panic.c
> +++ b/kernel/trace/rv/reactor_panic.c
> @@ -13,13 +13,9 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/rv.h>
> =C2=A0
> -__printf(1, 2) static void rv_panic_reaction(const char *msg, ...)
> +__printf(1, 0) static void rv_panic_reaction(const char *msg, va_list ar=
gs)
> =C2=A0{
> -=09va_list args;
> -
> -=09va_start(args, msg);
> =C2=A0=09vpanic(msg, args);
> -=09va_end(args);
> =C2=A0}
> =C2=A0
> =C2=A0static struct rv_reactor rv_panic =3D {
> diff --git a/kernel/trace/rv/reactor_printk.c
> b/kernel/trace/rv/reactor_printk.c
> index
> 2dae2916c05fd17397195e37d9b42d24cea24b9c..48c934e315b31c14d3a5b4fa3ec334e=
f71f9
> e390 100644
> --- a/kernel/trace/rv/reactor_printk.c
> +++ b/kernel/trace/rv/reactor_printk.c
> @@ -12,13 +12,9 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/rv.h>
> =C2=A0
> -__printf(1, 2) static void rv_printk_reaction(const char *msg, ...)
> +__printf(1, 0) static void rv_printk_reaction(const char *msg, va_list a=
rgs)
> =C2=A0{
> -=09va_list args;
> -
> -=09va_start(args, msg);
> =C2=A0=09vprintk_deferred(msg, args);
> -=09va_end(args);
> =C2=A0}
> =C2=A0
> =C2=A0static struct rv_reactor rv_printk =3D {
> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.=
c
> index
> d32859fec238371b5721e08cf6558f0805565f7b..cb1a5968055abb22439a066b4e25dad=
98f07
> 8389 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -438,7 +438,7 @@ int reactor_populate_monitor(struct rv_monitor *mon)
> =C2=A0/*
> =C2=A0 * Nop reactor register
> =C2=A0 */
> -__printf(1, 2) static void rv_nop_reaction(const char *msg, ...)
> +__printf(1, 0) static void rv_nop_reaction(const char *msg, va_list args=
)
> =C2=A0{
> =C2=A0}
> =C2=A0
> @@ -477,3 +477,17 @@ int init_rv_reactors(struct dentry *root_dir)
> =C2=A0out_err:
> =C2=A0=09return -ENOMEM;
> =C2=A0}
> +
> +void rv_react(struct rv_monitor *monitor, const char *msg, ...)
> +{
> +=09va_list args;
> +
> +=09if (!rv_reacting_on() || !monitor->react)
> +=09=09return;
> +
> +=09va_start(args, msg);
> +
> +=09monitor->react(msg, args);
> +
> +=09va_end(args);
> +}

