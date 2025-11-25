Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F5C27467D;
	Tue, 25 Nov 2025 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075296; cv=none; b=bJ97aNZTRcEb9dT/U1BZm8wWavQmvPUh8AztxuCxSkA1b/KTxfbbynwMF5hdSStZynvwZb4F7LUnAd1HauYd99F0PdAtCTUDj0ieEUTtbJ0hgo6mDcqTPpFZAIkOiYW0wSsMzaOiosnlty8YeBFXPdaxuGLaeyPsKK2AlQ29EP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075296; c=relaxed/simple;
	bh=6SF0ek0GMmnCDJQAzHkxEOigfxpB5RGxlQ6198vjN4E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hZRYw98QL7jGDHsNdw1qak4VkQbj3/cKIRSMoVEqs8fpwlBLt4dgwdG5HQGK6H9iwmzMoaslROgIgvI2EllPRScd0ZND0xTUyS26tX2Qiz1ozhwKnjAjO0UiVXWV+NlX2aBnOe3qXQYcXshpG6S8OgmrDLiCAQmk1QjS8h2C9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj8EJuVM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj8EJuVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7B7C4CEF1;
	Tue, 25 Nov 2025 12:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764075295;
	bh=6SF0ek0GMmnCDJQAzHkxEOigfxpB5RGxlQ6198vjN4E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fj8EJuVMGf4SxUo3Xu9E+oF4c6XDWzlg8A/OWrP08dP7g9RMsweQnwkPAD+8uuXb5
	 Dhn87LpPHR4tZM/9bkPfS4rLF03yeSXN+iZbTselx/RnLAAJEHrO/sqIGpJQS+4zO3
	 LcTprwIi04nIOdZbN1bSWZ4uUTbjQKDhcY+ey6NO2fEPMowOS8kK7HEjKs5JimOSHs
	 7S9MauJGiStDcfWTX+zBaVdz7xrVpQMnbNtDc1O7mgcPQmgInJ3G/aZ3JUD5PMJPEz
	 U4Ptmf/wjDxdWG8yX2T2PXewG69lBvzGp8TdChcIxIdRMH7vUgTQ52f79mctUWsCi7
	 baLP0PwoVlVFw==
Message-ID: <0229a5d929c91bc96dec7ae60c38c344c26caf8e.camel@kernel.org>
Subject: Re: [PATCH 1/2] tracing: Remove get_trigger_ops() and add
 count_func() from trigger ops
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 25 Nov 2025 06:54:54 -0600
In-Reply-To: <20251119031603.491057010@kernel.org>
References: <20251119031042.328864818@kernel.org>
	 <20251119031603.491057010@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Steve,

On Tue, 2025-11-18 at 22:10 -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> The struct event_command has a callback function called get_trigger_ops()=
.
> This callback returns the "trigger_ops" to use for the trigger. These ops
> define the trigger function, how to init the trigger, how to print the
> trigger and how to free it.
>=20
> The only reason there's a callback function to get these ops is because
> some triggers have two types of operations. One is an "always on"
> operation, and the other is a "count down" operation. If a user passes in
> a parameter to say how many times the trigger should execute. For example=
:
>=20
> =C2=A0 echo stacktrace:5 > events/kmem/kmem_cache_alloc/trigger
>=20
> It will trigger the stacktrace for the first 5 times the kmem_cache_alloc
> event is hit.
>=20
> Instead of having two different trigger_ops since the only difference
> between them is the tigger itself (the print, init and free functions are
> all the same), just use a single ops that the event_command points to and
> add a function field to the trigger_ops to have a count_func.
>=20
> When a trigger is added to an event, if there's a count attached to it an=
d
> the trigger ops has the count_func field, the data allocated to represent
> this trigger will have a new flag set called COUNT.
>=20
> Then when the trigger executes, it will check if the COUNT data flag is
> set, and if so, it will call the ops count_func(). If that returns false,
> it returns without executing the trigger.
>=20
> This removes the need for duplicate event_trigger_ops structures.
>=20
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Very nice cleanup, thanks!

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

> ---
> =C2=A0kernel/trace/trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 26 ++-
> =C2=A0kernel/trace/trace_eprobe.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 8 +-
> =C2=A0kernel/trace/trace_events_hist.c=C2=A0=C2=A0=C2=A0 |=C2=A0 60 +----=
--
> =C2=A0kernel/trace/trace_events_trigger.c | 257 ++++++++++---------------=
---
> =C2=A04 files changed, 116 insertions(+), 235 deletions(-)
>=20
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 58be6d741d72..036019ffc407 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1791,6 +1791,7 @@ extern void clear_event_triggers(struct trace_array=
 *tr);
> =C2=A0
> =C2=A0enum {
> =C2=A0	EVENT_TRIGGER_FL_PROBE		=3D BIT(0),
> +	EVENT_TRIGGER_FL_COUNT		=3D BIT(1),
> =C2=A0};
> =C2=A0
> =C2=A0struct event_trigger_data {
> @@ -1822,6 +1823,10 @@ struct enable_trigger_data {
> =C2=A0	bool				hist;
> =C2=A0};
> =C2=A0
> +bool event_trigger_count(struct event_trigger_data *data,
> +			 struct trace_buffer *buffer,=C2=A0 void *rec,
> +			 struct ring_buffer_event *event);
> +
> =C2=A0extern int event_enable_trigger_print(struct seq_file *m,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct event_trigger_data *data)=
;
> =C2=A0extern void event_enable_trigger_free(struct event_trigger_data *da=
ta);
> @@ -1909,6 +1914,11 @@ extern void event_file_put(struct trace_event_file=
 *file);
> =C2=A0 *	registered the trigger (see struct event_command) along with
> =C2=A0 *	the trace record, rec.
> =C2=A0 *
> + * @count_func: If defined and a numeric parameter is passed to the
> + *	trigger, then this function will be called before @trigger
> + *	is called. If this function returns false, then @trigger is not
> + *	executed.
> + *
> =C2=A0 * @init: An optional initialization function called for the trigge=
r
> =C2=A0 *	when the trigger is registered (via the event_command reg()
> =C2=A0 *	function).=C2=A0 This can be used to perform per-trigger
> @@ -1936,6 +1946,10 @@ struct event_trigger_ops {
> =C2=A0					=C2=A0=C2=A0 struct trace_buffer *buffer,
> =C2=A0					=C2=A0=C2=A0 void *rec,
> =C2=A0					=C2=A0=C2=A0 struct ring_buffer_event *rbe);
> +	bool			(*count_func)(struct event_trigger_data *data,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct trace_buffer *buffer,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *rec,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ring_buffer_event *rbe);
> =C2=A0	int			(*init)(struct event_trigger_data *data);
> =C2=A0	void			(*free)(struct event_trigger_data *data);
> =C2=A0	int			(*print)(struct seq_file *m,
> @@ -1962,6 +1976,9 @@ struct event_trigger_ops {
> =C2=A0 * @name: The unique name that identifies the event command.=C2=A0 =
This is
> =C2=A0 *	the name used when setting triggers via trigger files.
> =C2=A0 *
> + * @trigger_ops: The event_trigger_ops implementation associated with
> + *	the command.
> + *
> =C2=A0 * @trigger_type: A unique id that identifies the event command
> =C2=A0 *	'type'.=C2=A0 This value has two purposes, the first to ensure t=
hat
> =C2=A0 *	only one trigger of the same type can be set at a given time
> @@ -2013,17 +2030,11 @@ struct event_trigger_ops {
> =C2=A0 *	event command, filters set by the user for the command will be
> =C2=A0 *	ignored.=C2=A0 This is usually implemented by the generic utilit=
y
> =C2=A0 *	function @set_trigger_filter() (see trace_event_triggers.c).
> - *
> - * @get_trigger_ops: The callback function invoked to retrieve the
> - *	event_trigger_ops implementation associated with the command.
> - *	This callback function allows a single event_command to
> - *	support multiple trigger implementations via different sets of
> - *	event_trigger_ops, depending on the value of the @param
> - *	string.
> =C2=A0 */
> =C2=A0struct event_command {
> =C2=A0	struct list_head	list;
> =C2=A0	char			*name;
> +	const struct event_trigger_ops *trigger_ops;
> =C2=A0	enum event_trigger_type	trigger_type;
> =C2=A0	int			flags;
> =C2=A0	int			(*parse)(struct event_command *cmd_ops,
> @@ -2040,7 +2051,6 @@ struct event_command {
> =C2=A0	int			(*set_filter)(char *filter_str,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct event_trigger_data *data=
,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct trace_event_file *file);
> -	const struct event_trigger_ops *(*get_trigger_ops)(char *cmd, char *par=
am);
> =C2=A0};
> =C2=A0
> =C2=A0/**
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index a1d402124836..14ae896dbe75 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -513,21 +513,15 @@ static void eprobe_trigger_unreg_func(char *glob,
> =C2=A0
> =C2=A0}
> =C2=A0
> -static const struct event_trigger_ops *eprobe_trigger_get_ops(char *cmd,
> -							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *param)
> -{
> -	return &eprobe_trigger_ops;
> -}
> -
> =C2=A0static struct event_command event_trigger_cmd =3D {
> =C2=A0	.name			=3D "eprobe",
> =C2=A0	.trigger_type		=3D ETT_EVENT_EPROBE,
> =C2=A0	.flags			=3D EVENT_CMD_FL_NEEDS_REC,
> +	.trigger_ops		=3D &eprobe_trigger_ops,
> =C2=A0	.parse			=3D eprobe_trigger_cmd_parse,
> =C2=A0	.reg			=3D eprobe_trigger_reg_func,
> =C2=A0	.unreg			=3D eprobe_trigger_unreg_func,
> =C2=A0	.unreg_all		=3D NULL,
> -	.get_trigger_ops	=3D eprobe_trigger_get_ops,
> =C2=A0	.set_filter		=3D NULL,
> =C2=A0};
> =C2=A0
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 1d536219b624..f9cc8d6a215b 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6363,12 +6363,6 @@ static const struct event_trigger_ops event_hist_t=
rigger_named_ops =3D {
> =C2=A0	.free			=3D event_hist_trigger_named_free,
> =C2=A0};
> =C2=A0
> -static const struct event_trigger_ops *event_hist_get_trigger_ops(char *=
cmd,
> -								=C2=A0 char *param)
> -{
> -	return &event_hist_trigger_ops;
> -}
> -
> =C2=A0static void hist_clear(struct event_trigger_data *data)
> =C2=A0{
> =C2=A0	struct hist_trigger_data *hist_data =3D data->private_data;
> @@ -6908,11 +6902,11 @@ static struct event_command trigger_hist_cmd =3D =
{
> =C2=A0	.name			=3D "hist",
> =C2=A0	.trigger_type		=3D ETT_EVENT_HIST,
> =C2=A0	.flags			=3D EVENT_CMD_FL_NEEDS_REC,
> +	.trigger_ops		=3D &event_hist_trigger_ops,
> =C2=A0	.parse			=3D event_hist_trigger_parse,
> =C2=A0	.reg			=3D hist_register_trigger,
> =C2=A0	.unreg			=3D hist_unregister_trigger,
> =C2=A0	.unreg_all		=3D hist_unreg_all,
> -	.get_trigger_ops	=3D event_hist_get_trigger_ops,
> =C2=A0	.set_filter		=3D set_trigger_filter,
> =C2=A0};
> =C2=A0
> @@ -6945,29 +6939,9 @@ hist_enable_trigger(struct event_trigger_data *dat=
a,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> -static void
> -hist_enable_count_trigger(struct event_trigger_data *data,
> -			=C2=A0 struct trace_buffer *buffer,=C2=A0 void *rec,
> -			=C2=A0 struct ring_buffer_event *event)
> -{
> -	if (!data->count)
> -		return;
> -
> -	if (data->count !=3D -1)
> -		(data->count)--;
> -
> -	hist_enable_trigger(data, buffer, rec, event);
> -}
> -
> =C2=A0static const struct event_trigger_ops hist_enable_trigger_ops =3D {
> =C2=A0	.trigger		=3D hist_enable_trigger,
> -	.print			=3D event_enable_trigger_print,
> -	.init			=3D event_trigger_init,
> -	.free			=3D event_enable_trigger_free,
> -};
> -
> -static const struct event_trigger_ops hist_enable_count_trigger_ops =3D =
{
> -	.trigger		=3D hist_enable_count_trigger,
> +	.count_func		=3D event_trigger_count,
> =C2=A0	.print			=3D event_enable_trigger_print,
> =C2=A0	.init			=3D event_trigger_init,
> =C2=A0	.free			=3D event_enable_trigger_free,
> @@ -6975,36 +6949,12 @@ static const struct event_trigger_ops hist_enable=
_count_trigger_ops =3D {
> =C2=A0
> =C2=A0static const struct event_trigger_ops hist_disable_trigger_ops =3D =
{
> =C2=A0	.trigger		=3D hist_enable_trigger,
> +	.count_func		=3D event_trigger_count,
> =C2=A0	.print			=3D event_enable_trigger_print,
> =C2=A0	.init			=3D event_trigger_init,
> =C2=A0	.free			=3D event_enable_trigger_free,
> =C2=A0};
> =C2=A0
> -static const struct event_trigger_ops hist_disable_count_trigger_ops =3D=
 {
> -	.trigger		=3D hist_enable_count_trigger,
> -	.print			=3D event_enable_trigger_print,
> -	.init			=3D event_trigger_init,
> -	.free			=3D event_enable_trigger_free,
> -};
> -
> -static const struct event_trigger_ops *
> -hist_enable_get_trigger_ops(char *cmd, char *param)
> -{
> -	const struct event_trigger_ops *ops;
> -	bool enable;
> -
> -	enable =3D (strcmp(cmd, ENABLE_HIST_STR) =3D=3D 0);
> -
> -	if (enable)
> -		ops =3D param ? &hist_enable_count_trigger_ops :
> -			&hist_enable_trigger_ops;
> -	else
> -		ops =3D param ? &hist_disable_count_trigger_ops :
> -			&hist_disable_trigger_ops;
> -
> -	return ops;
> -}
> -
> =C2=A0static void hist_enable_unreg_all(struct trace_event_file *file)
> =C2=A0{
> =C2=A0	struct event_trigger_data *test, *n;
> @@ -7023,22 +6973,22 @@ static void hist_enable_unreg_all(struct trace_ev=
ent_file *file)
> =C2=A0static struct event_command trigger_hist_enable_cmd =3D {
> =C2=A0	.name			=3D ENABLE_HIST_STR,
> =C2=A0	.trigger_type		=3D ETT_HIST_ENABLE,
> +	.trigger_ops		=3D &hist_enable_trigger_ops,
> =C2=A0	.parse			=3D event_enable_trigger_parse,
> =C2=A0	.reg			=3D event_enable_register_trigger,
> =C2=A0	.unreg			=3D event_enable_unregister_trigger,
> =C2=A0	.unreg_all		=3D hist_enable_unreg_all,
> -	.get_trigger_ops	=3D hist_enable_get_trigger_ops,
> =C2=A0	.set_filter		=3D set_trigger_filter,
> =C2=A0};
> =C2=A0
> =C2=A0static struct event_command trigger_hist_disable_cmd =3D {
> =C2=A0	.name			=3D DISABLE_HIST_STR,
> =C2=A0	.trigger_type		=3D ETT_HIST_ENABLE,
> +	.trigger_ops		=3D &hist_disable_trigger_ops,
> =C2=A0	.parse			=3D event_enable_trigger_parse,
> =C2=A0	.reg			=3D event_enable_register_trigger,
> =C2=A0	.unreg			=3D event_enable_unregister_trigger,
> =C2=A0	.unreg_all		=3D hist_enable_unreg_all,
> -	.get_trigger_ops	=3D hist_enable_get_trigger_ops,
> =C2=A0	.set_filter		=3D set_trigger_filter,
> =C2=A0};
> =C2=A0
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_eve=
nts_trigger.c
> index cbfc306c0159..576bad18bcdb 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -28,6 +28,20 @@ void trigger_data_free(struct event_trigger_data *data=
)
> =C2=A0	kfree(data);
> =C2=A0}
> =C2=A0
> +static inline void data_ops_trigger(struct event_trigger_data *data,
> +				=C2=A0=C2=A0=C2=A0 struct trace_buffer *buffer,=C2=A0 void *rec,
> +				=C2=A0=C2=A0=C2=A0 struct ring_buffer_event *event)
> +{
> +	const struct event_trigger_ops *ops =3D data->ops;
> +
> +	if (data->flags & EVENT_TRIGGER_FL_COUNT) {
> +		if (!ops->count_func(data, buffer, rec, event))
> +			return;
> +	}
> +
> +	ops->trigger(data, buffer, rec, event);
> +}
> +
> =C2=A0/**
> =C2=A0 * event_triggers_call - Call triggers associated with a trace even=
t
> =C2=A0 * @file: The trace_event_file associated with the event
> @@ -70,7 +84,7 @@ event_triggers_call(struct trace_event_file *file,
> =C2=A0		if (data->paused)
> =C2=A0			continue;
> =C2=A0		if (!rec) {
> -			data->ops->trigger(data, buffer, rec, event);
> +			data_ops_trigger(data, buffer, rec, event);
> =C2=A0			continue;
> =C2=A0		}
> =C2=A0		filter =3D rcu_dereference_sched(data->filter);
> @@ -80,7 +94,7 @@ event_triggers_call(struct trace_event_file *file,
> =C2=A0			tt |=3D data->cmd_ops->trigger_type;
> =C2=A0			continue;
> =C2=A0		}
> -		data->ops->trigger(data, buffer, rec, event);
> +		data_ops_trigger(data, buffer, rec, event);
> =C2=A0	}
> =C2=A0	return tt;
> =C2=A0}
> @@ -122,7 +136,7 @@ event_triggers_post_call(struct trace_event_file *fil=
e,
> =C2=A0		if (data->paused)
> =C2=A0			continue;
> =C2=A0		if (data->cmd_ops->trigger_type & tt)
> -			data->ops->trigger(data, NULL, NULL, NULL);
> +			data_ops_trigger(data, NULL, NULL, NULL);
> =C2=A0	}
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(event_triggers_post_call);
> @@ -377,6 +391,36 @@ __init int unregister_event_command(struct event_com=
mand *cmd)
> =C2=A0	return -ENODEV;
> =C2=A0}
> =C2=A0
> +/**
> + * event_trigger_count - Optional count function for event triggers
> + * @data: Trigger-specific data
> + * @buffer: The ring buffer that the event is being written to
> + * @rec: The trace entry for the event, NULL for unconditional invocatio=
n
> + * @event: The event meta data in the ring buffer
> + *
> + * For triggers that can take a count parameter that doesn't do anything
> + * special, they can use this function to assign to their .count_func
> + * field.
> + *
> + * This simply does a count down of the @data->count field.
> + *
> + * If the @data->count is greater than zero, it will decrement it.
> + *
> + * Returns false if @data->count is zero, otherwise true.
> + */
> +bool event_trigger_count(struct event_trigger_data *data,
> +			 struct trace_buffer *buffer,=C2=A0 void *rec,
> +			 struct ring_buffer_event *event)
> +{
> +	if (!data->count)
> +		return false;
> +
> +	if (data->count !=3D -1)
> +		(data->count)--;
> +
> +	return true;
> +}
> +
> =C2=A0/**
> =C2=A0 * event_trigger_print - Generic event_trigger_ops @print implement=
ation
> =C2=A0 * @name: The name of the event trigger
> @@ -807,9 +851,13 @@ int event_trigger_separate_filter(char *param_and_fi=
lter, char **param,
> =C2=A0 * @private_data: User data to associate with the event trigger
> =C2=A0 *
> =C2=A0 * Allocate an event_trigger_data instance and initialize it.=C2=A0=
 The
> - * @cmd_ops are used along with the @cmd and @param to get the
> - * trigger_ops to assign to the event_trigger_data.=C2=A0 @private_data =
can
> - * also be passed in and associated with the event_trigger_data.
> + * @cmd_ops defines how the trigger will operate. If @param is set,
> + * and @cmd_ops->trigger_ops->count_func is non NULL, then the
> + * data->count is set to @param and before the trigger is executed, the
> + * @cmd_ops->trigger_ops->count_func() is called. If that function retur=
ns
> + * false, the @cmd_ops->trigger_ops->trigger() function will not be call=
ed.
> + * @private_data can also be passed in and associated with the
> + * event_trigger_data.
> =C2=A0 *
> =C2=A0 * Use trigger_data_free() to free an event_trigger_data object.
> =C2=A0 *
> @@ -821,18 +869,17 @@ struct event_trigger_data *trigger_data_alloc(struc=
t event_command *cmd_ops,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *private_data)
> =C2=A0{
> =C2=A0	struct event_trigger_data *trigger_data;
> -	const struct event_trigger_ops *trigger_ops;
> -
> -	trigger_ops =3D cmd_ops->get_trigger_ops(cmd, param);
> =C2=A0
> =C2=A0	trigger_data =3D kzalloc(sizeof(*trigger_data), GFP_KERNEL);
> =C2=A0	if (!trigger_data)
> =C2=A0		return NULL;
> =C2=A0
> =C2=A0	trigger_data->count =3D -1;
> -	trigger_data->ops =3D trigger_ops;
> +	trigger_data->ops =3D cmd_ops->trigger_ops;
> =C2=A0	trigger_data->cmd_ops =3D cmd_ops;
> =C2=A0	trigger_data->private_data =3D private_data;
> +	if (param && cmd_ops->trigger_ops->count_func)
> +		trigger_data->flags |=3D EVENT_TRIGGER_FL_COUNT;
> =C2=A0
> =C2=A0	INIT_LIST_HEAD(&trigger_data->list);
> =C2=A0	INIT_LIST_HEAD(&trigger_data->named_list);
> @@ -1271,31 +1318,28 @@ traceon_trigger(struct event_trigger_data *data,
> =C2=A0	tracing_on();
> =C2=A0}
> =C2=A0
> -static void
> -traceon_count_trigger(struct event_trigger_data *data,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct trace_buffer *buffer, void *rec,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ring_buffer_event *event)
> +static bool
> +traceon_count_func(struct event_trigger_data *data,
> +		=C2=A0=C2=A0 struct trace_buffer *buffer, void *rec,
> +		=C2=A0=C2=A0 struct ring_buffer_event *event)
> =C2=A0{
> =C2=A0	struct trace_event_file *file =3D data->private_data;
> =C2=A0
> =C2=A0	if (file) {
> =C2=A0		if (tracer_tracing_is_on(file->tr))
> -			return;
> +			return false;
> =C2=A0	} else {
> =C2=A0		if (tracing_is_on())
> -			return;
> +			return false;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (!data->count)
> -		return;
> +		return false;
> =C2=A0
> =C2=A0	if (data->count !=3D -1)
> =C2=A0		(data->count)--;
> =C2=A0
> -	if (file)
> -		tracer_tracing_on(file->tr);
> -	else
> -		tracing_on();
> +	return true;
> =C2=A0}
> =C2=A0
> =C2=A0static void
> @@ -1319,31 +1363,28 @@ traceoff_trigger(struct event_trigger_data *data,
> =C2=A0	tracing_off();
> =C2=A0}
> =C2=A0
> -static void
> -traceoff_count_trigger(struct event_trigger_data *data,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct trace_buffer *buffer, void=
 *rec,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ring_buffer_event *event)
> +static bool
> +traceoff_count_func(struct event_trigger_data *data,
> +		=C2=A0=C2=A0=C2=A0 struct trace_buffer *buffer, void *rec,
> +		=C2=A0=C2=A0=C2=A0 struct ring_buffer_event *event)
> =C2=A0{
> =C2=A0	struct trace_event_file *file =3D data->private_data;
> =C2=A0
> =C2=A0	if (file) {
> =C2=A0		if (!tracer_tracing_is_on(file->tr))
> -			return;
> +			return false;
> =C2=A0	} else {
> =C2=A0		if (!tracing_is_on())
> -			return;
> +			return false;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (!data->count)
> -		return;
> +		return false;
> =C2=A0
> =C2=A0	if (data->count !=3D -1)
> =C2=A0		(data->count)--;
> =C2=A0
> -	if (file)
> -		tracer_tracing_off(file->tr);
> -	else
> -		tracing_off();
> +	return true;
> =C2=A0}
> =C2=A0
> =C2=A0static int
> @@ -1362,13 +1403,7 @@ traceoff_trigger_print(struct seq_file *m, struct =
event_trigger_data *data)
> =C2=A0
> =C2=A0static const struct event_trigger_ops traceon_trigger_ops =3D {
> =C2=A0	.trigger		=3D traceon_trigger,
> -	.print			=3D traceon_trigger_print,
> -	.init			=3D event_trigger_init,
> -	.free			=3D event_trigger_free,
> -};
> -
> -static const struct event_trigger_ops traceon_count_trigger_ops =3D {
> -	.trigger		=3D traceon_count_trigger,
> +	.count_func		=3D traceon_count_func,
> =C2=A0	.print			=3D traceon_trigger_print,
> =C2=A0	.init			=3D event_trigger_init,
> =C2=A0	.free			=3D event_trigger_free,
> @@ -1376,41 +1411,19 @@ static const struct event_trigger_ops traceon_cou=
nt_trigger_ops =3D {
> =C2=A0
> =C2=A0static const struct event_trigger_ops traceoff_trigger_ops =3D {
> =C2=A0	.trigger		=3D traceoff_trigger,
> +	.count_func		=3D traceoff_count_func,
> =C2=A0	.print			=3D traceoff_trigger_print,
> =C2=A0	.init			=3D event_trigger_init,
> =C2=A0	.free			=3D event_trigger_free,
> =C2=A0};
> =C2=A0
> -static const struct event_trigger_ops traceoff_count_trigger_ops =3D {
> -	.trigger		=3D traceoff_count_trigger,
> -	.print			=3D traceoff_trigger_print,
> -	.init			=3D event_trigger_init,
> -	.free			=3D event_trigger_free,
> -};
> -
> -static const struct event_trigger_ops *
> -onoff_get_trigger_ops(char *cmd, char *param)
> -{
> -	const struct event_trigger_ops *ops;
> -
> -	/* we register both traceon and traceoff to this callback */
> -	if (strcmp(cmd, "traceon") =3D=3D 0)
> -		ops =3D param ? &traceon_count_trigger_ops :
> -			&traceon_trigger_ops;
> -	else
> -		ops =3D param ? &traceoff_count_trigger_ops :
> -			&traceoff_trigger_ops;
> -
> -	return ops;
> -}
> -
> =C2=A0static struct event_command trigger_traceon_cmd =3D {
> =C2=A0	.name			=3D "traceon",
> =C2=A0	.trigger_type		=3D ETT_TRACE_ONOFF,
> +	.trigger_ops		=3D &traceon_trigger_ops,
> =C2=A0	.parse			=3D event_trigger_parse,
> =C2=A0	.reg			=3D register_trigger,
> =C2=A0	.unreg			=3D unregister_trigger,
> -	.get_trigger_ops	=3D onoff_get_trigger_ops,
> =C2=A0	.set_filter		=3D set_trigger_filter,
> =C2=A0};
> =C2=A0
> @@ -1418,10 +1431,10 @@ static struct event_command trigger_traceoff_cmd =
=3D {
> =C2=A0	.name			=3D "traceoff",
> =C2=A0	.trigger_type		=3D ETT_TRACE_ONOFF,
> =C2=A0	.flags			=3D EVENT_CMD_FL_POST_TRIGGER,
> +	.trigger_ops		=3D &traceoff_trigger_ops,
> =C2=A0	.parse			=3D event_trigger_parse,
> =C2=A0	.reg			=3D register_trigger,
> =C2=A0	.unreg			=3D unregister_trigger,
> -	.get_trigger_ops	=3D onoff_get_trigger_ops,
> =C2=A0	.set_filter		=3D set_trigger_filter,
> =C2=A0};
> =C2=A0
> @@ -1439,20 +1452,6 @@ snapshot_trigger(struct event_trigger_data *data,
> =C2=A0		tracing_snapshot();
> =C2=A0}
> =C2=A0
> -static void
> -snapshot_count_trigger(struct event_trigger_data *data,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct trace_buffer *buffer, void=
 *rec,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ring_buffer_event *event)
> -{
> -	if (!data->count)
> -		return;
> -
> -	if (data->count !=3D -1)
> -		(data->count)--;
> -
> -	snapshot_trigger(data, buffer, rec, event);
> -}
> -
> =C2=A0static int
> =C2=A0register_snapshot_trigger(char *glob,
> =C2=A0			=C2=A0 struct event_trigger_data *data,
> @@ -1486,31 +1485,19 @@ snapshot_trigger_print(struct seq_file *m, struct=
 event_trigger_data *data)
> =C2=A0
> =C2=A0static const struct event_trigger_ops snapshot_trigger_ops =3D {
> =C2=A0	.trigger		=3D snapshot_trigger,
> +	.count_func		=3D event_trigger_count,
> =C2=A0	.print			=3D snapshot_trigger_print,
> =C2=A0	.init			=3D event_trigger_init,
> =C2=A0	.free			=3D event_trigger_free,
> =C2=A0};
> =C2=A0
> -static const struct event_trigger_ops snapshot_count_trigger_ops =3D {
> -	.trigger		=3D snapshot_count_trigger,
> -	.print			=3D snapshot_trigger_print,
> -	.init			=3D event_trigger_init,
> -	.free			=3D event_trigger_free,
> -};
> -
> -static const struct event_trigger_ops *
> -snapshot_get_trigger_ops(char *cmd, char *param)
> -{
> -	return param ? &snapshot_count_trigger_ops : &snapshot_trigger_ops;
> -}
> -
> =C2=A0static struct event_command trigger_snapshot_cmd =3D {
> =C2=A0	.name			=3D "snapshot",
> =C2=A0	.trigger_type		=3D ETT_SNAPSHOT,
> +	.trigger_ops		=3D &snapshot_trigger_ops,
> =C2=A0	.parse			=3D event_trigger_parse,
> =C2=A0	.reg			=3D register_snapshot_trigger,
> =C2=A0	.unreg			=3D unregister_snapshot_trigger,
> -	.get_trigger_ops	=3D snapshot_get_trigger_ops,
> =C2=A0	.set_filter		=3D set_trigger_filter,
> =C2=A0};
> =C2=A0
> @@ -1558,20 +1545,6 @@ stacktrace_trigger(struct event_trigger_data *data=
,
> =C2=A0		trace_dump_stack(STACK_SKIP);
> =C2=A0}
> =C2=A0
> -static void
> -stacktrace_count_trigger(struct event_trigger_data *data,
> -			 struct trace_buffer *buffer, void *rec,
> -			 struct ring_buffer_event *event)
> -{
> -	if (!data->count)
> -		return;
> -
> -	if (data->count !=3D -1)
> -		(data->count)--;
> -
> -	stacktrace_trigger(data, buffer, rec, event);
> -}
> -
> =C2=A0static int
> =C2=A0stacktrace_trigger_print(struct seq_file *m, struct event_trigger_d=
ata *data)
> =C2=A0{
> @@ -1581,32 +1554,20 @@ stacktrace_trigger_print(struct seq_file *m, stru=
ct event_trigger_data *data)
> =C2=A0
> =C2=A0static const struct event_trigger_ops stacktrace_trigger_ops =3D {
> =C2=A0	.trigger		=3D stacktrace_trigger,
> +	.count_func		=3D event_trigger_count,
> =C2=A0	.print			=3D stacktrace_trigger_print,
> =C2=A0	.init			=3D event_trigger_init,
> =C2=A0	.free			=3D event_trigger_free,
> =C2=A0};
> =C2=A0
> -static const struct event_trigger_ops stacktrace_count_trigger_ops =3D {
> -	.trigger		=3D stacktrace_count_trigger,
> -	.print			=3D stacktrace_trigger_print,
> -	.init			=3D event_trigger_init,
> -	.free			=3D event_trigger_free,
> -};
> -
> -static const struct event_trigger_ops *
> -stacktrace_get_trigger_ops(char *cmd, char *param)
> -{
> -	return param ? &stacktrace_count_trigger_ops : &stacktrace_trigger_ops;
> -}
> -
> =C2=A0static struct event_command trigger_stacktrace_cmd =3D {
> =C2=A0	.name			=3D "stacktrace",
> =C2=A0	.trigger_type		=3D ETT_STACKTRACE,
> +	.trigger_ops		=3D &stacktrace_trigger_ops,
> =C2=A0	.flags			=3D EVENT_CMD_FL_POST_TRIGGER,
> =C2=A0	.parse			=3D event_trigger_parse,
> =C2=A0	.reg			=3D register_trigger,
> =C2=A0	.unreg			=3D unregister_trigger,
> -	.get_trigger_ops	=3D stacktrace_get_trigger_ops,
> =C2=A0	.set_filter		=3D set_trigger_filter,
> =C2=A0};
> =C2=A0
> @@ -1642,24 +1603,24 @@ event_enable_trigger(struct event_trigger_data *d=
ata,
> =C2=A0		set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flag=
s);
> =C2=A0}
> =C2=A0
> -static void
> -event_enable_count_trigger(struct event_trigger_data *data,
> -			=C2=A0=C2=A0 struct trace_buffer *buffer,=C2=A0 void *rec,
> -			=C2=A0=C2=A0 struct ring_buffer_event *event)
> +static bool
> +event_enable_count_func(struct event_trigger_data *data,
> +			struct trace_buffer *buffer,=C2=A0 void *rec,
> +			struct ring_buffer_event *event)
> =C2=A0{
> =C2=A0	struct enable_trigger_data *enable_data =3D data->private_data;
> =C2=A0
> =C2=A0	if (!data->count)
> -		return;
> +		return false;
> =C2=A0
> =C2=A0	/* Skip if the event is in a state we want to switch to */
> =C2=A0	if (enable_data->enable =3D=3D !(enable_data->file->flags & EVENT_=
FILE_FL_SOFT_DISABLED))
> -		return;
> +		return false;
> =C2=A0
> =C2=A0	if (data->count !=3D -1)
> =C2=A0		(data->count)--;
> =C2=A0
> -	event_enable_trigger(data, buffer, rec, event);
> +	return true;
> =C2=A0}
> =C2=A0
> =C2=A0int event_enable_trigger_print(struct seq_file *m,
> @@ -1706,13 +1667,7 @@ void event_enable_trigger_free(struct event_trigge=
r_data *data)
> =C2=A0
> =C2=A0static const struct event_trigger_ops event_enable_trigger_ops =3D =
{
> =C2=A0	.trigger		=3D event_enable_trigger,
> -	.print			=3D event_enable_trigger_print,
> -	.init			=3D event_trigger_init,
> -	.free			=3D event_enable_trigger_free,
> -};
> -
> -static const struct event_trigger_ops event_enable_count_trigger_ops =3D=
 {
> -	.trigger		=3D event_enable_count_trigger,
> +	.count_func		=3D event_enable_count_func,
> =C2=A0	.print			=3D event_enable_trigger_print,
> =C2=A0	.init			=3D event_trigger_init,
> =C2=A0	.free			=3D event_enable_trigger_free,
> @@ -1720,13 +1675,7 @@ static const struct event_trigger_ops event_enable=
_count_trigger_ops =3D {
> =C2=A0
> =C2=A0static const struct event_trigger_ops event_disable_trigger_ops =3D=
 {
> =C2=A0	.trigger		=3D event_enable_trigger,
> -	.print			=3D event_enable_trigger_print,
> -	.init			=3D event_trigger_init,
> -	.free			=3D event_enable_trigger_free,
> -};
> -
> -static const struct event_trigger_ops event_disable_count_trigger_ops =
=3D {
> -	.trigger		=3D event_enable_count_trigger,
> +	.count_func		=3D event_enable_count_func,
> =C2=A0	.print			=3D event_enable_trigger_print,
> =C2=A0	.init			=3D event_trigger_init,
> =C2=A0	.free			=3D event_enable_trigger_free,
> @@ -1906,45 +1855,23 @@ void event_enable_unregister_trigger(char *glob,
> =C2=A0		data->ops->free(data);
> =C2=A0}
> =C2=A0
> -static const struct event_trigger_ops *
> -event_enable_get_trigger_ops(char *cmd, char *param)
> -{
> -	const struct event_trigger_ops *ops;
> -	bool enable;
> -
> -#ifdef CONFIG_HIST_TRIGGERS
> -	enable =3D ((strcmp(cmd, ENABLE_EVENT_STR) =3D=3D 0) ||
> -		=C2=A0 (strcmp(cmd, ENABLE_HIST_STR) =3D=3D 0));
> -#else
> -	enable =3D strcmp(cmd, ENABLE_EVENT_STR) =3D=3D 0;
> -#endif
> -	if (enable)
> -		ops =3D param ? &event_enable_count_trigger_ops :
> -			&event_enable_trigger_ops;
> -	else
> -		ops =3D param ? &event_disable_count_trigger_ops :
> -			&event_disable_trigger_ops;
> -
> -	return ops;
> -}
> -
> =C2=A0static struct event_command trigger_enable_cmd =3D {
> =C2=A0	.name			=3D ENABLE_EVENT_STR,
> =C2=A0	.trigger_type		=3D ETT_EVENT_ENABLE,
> +	.trigger_ops		=3D &event_enable_trigger_ops,
> =C2=A0	.parse			=3D event_enable_trigger_parse,
> =C2=A0	.reg			=3D event_enable_register_trigger,
> =C2=A0	.unreg			=3D event_enable_unregister_trigger,
> -	.get_trigger_ops	=3D event_enable_get_trigger_ops,
> =C2=A0	.set_filter		=3D set_trigger_filter,
> =C2=A0};
> =C2=A0
> =C2=A0static struct event_command trigger_disable_cmd =3D {
> =C2=A0	.name			=3D DISABLE_EVENT_STR,
> =C2=A0	.trigger_type		=3D ETT_EVENT_ENABLE,
> +	.trigger_ops		=3D &event_disable_trigger_ops,
> =C2=A0	.parse			=3D event_enable_trigger_parse,
> =C2=A0	.reg			=3D event_enable_register_trigger,
> =C2=A0	.unreg			=3D event_enable_unregister_trigger,
> -	.get_trigger_ops	=3D event_enable_get_trigger_ops,
> =C2=A0	.set_filter		=3D set_trigger_filter,
> =C2=A0};
> =C2=A0

