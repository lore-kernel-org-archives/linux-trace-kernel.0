Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776EA1E832D;
	Thu, 27 Feb 2025 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686009; cv=none; b=bN31Dn94+wwDoQE+X/K9pGnEfd5EN6L9afnLUfDn1Hphff2KYj4RuN4q/ImXxCHzKCTSGvJxVYvxGS7V3O2/cDxuqhLr9AX+xgOKaLChYEni17EG++hk8foPcFlmoRyxN1exsuLVliISD04O9WzRUTHfB1jkwuriNMk3QWyEWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686009; c=relaxed/simple;
	bh=Pybs4UBoKUiyRMTbYO8kBDo7Uwc8g6SoPNrJghcwkX0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jkBOh26B7tt1/6ydo30r6tG+Ro94nS5RZg82Z0dl2J+PXOCB2FzCaebSyVfM7a4ORthqkLZgMsj5lPfc1nREPJ+50PwqSQN6XUp5QHIGd4WIuxAN/qEGUJiUGKmTLb0aTeIeTDG1zbLQvKUF7INWJRMws8PBNLw94+LiwOmAivY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1FheZU2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1FheZU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641F1C4CEDD;
	Thu, 27 Feb 2025 19:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740686008;
	bh=Pybs4UBoKUiyRMTbYO8kBDo7Uwc8g6SoPNrJghcwkX0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=h1FheZU2m9MmaMkRZYDWhM1KYHFXHc1TpEzMtsbhQVH7Iq0KnCAfl6l+bswhgX6RY
	 aLUwWkO38/dkK2WFixD/fZMeeUBmm5ZTYAUV6Yb+0JXc3/EBrZs5VHO7SAVgomJq0P
	 SFhCRh5GzzqNfWK/vAYSke/KwJ1715AkdWxAe0sB8QQbLYMsxOWNUXmpGfNYs8458T
	 iYh8ZhXsBSNPCJTzNYWpGtqdieBSjWUoG5IGs/6xArhap7CCu/6Cxqv66OHxEvRDSS
	 4WkGehXi1ixjFi1o87ZhvTEFHG6uG5wJ3Nq6Knsu2M77rNKKm4/yDQlfASjueYTiCd
	 Ipq9yj3Kd4O9Q==
Message-ID: <0af3b796add9016c6e34b0b9b3eca673aaaa3a7d.camel@kernel.org>
Subject: Re: [PATCH] tracing: Fix bad hist from corrupting named_triggers
 list
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, Tomas Glozar <tglozar@redhat.com>
Date: Thu, 27 Feb 2025 13:53:27 -0600
In-Reply-To: <20250225125356.29236cd1@gandalf.local.home>
References: <20250225125356.29236cd1@gandalf.local.home>
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

On Tue, 2025-02-25 at 12:53 -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> The following commands causes a crash:
>=20
> =C2=A0~# cd /sys/kernel/tracing/events/rcu/rcu_callback
> =C2=A0~# echo 'hist:name=3Dbad:keys=3Dcommon_pid:onmax(bogus).save(common=
_pid)' > trigger
> =C2=A0bash: echo: write error: Invalid argument
> =C2=A0~# echo 'hist:name=3Dbad:keys=3Dcommon_pid' > trigger
>=20
> Because the following occurs:
>=20
> event_trigger_write() {
> =C2=A0 trigger_process_regex() {
> =C2=A0=C2=A0=C2=A0 event_hist_trigger_parse() {
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D event_trigger_alloc(..);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event_trigger_register(.., data) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd_ops->reg(.., data, ..) [hi=
st_register_trigger()] {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ops->init() =
[event_hist_trigger_init()] {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 save_n=
amed_trigger(name, data) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 list_add(&data->named_list, &named_triggers);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D create_actions(); (return -EINVAL)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unreg;
> [..]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D hist_trigger_enable(data, ...) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add_tail_rcu(&data->list,=
 &file->triggers); <<<---- SKIPPED!!! (this is important!)
> [..]
> =C2=A0out_unreg:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 event_hist_unregister(.., data) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmd_ops->unreg(.., data, ..) [=
hist_unregister_trigger()] {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entr=
y(iter, &file->triggers, list) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!h=
ist_trigger_match(data, iter, named_data, false))=C2=A0=C2=A0 <- never matc=
hes
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 continue;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [..]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test =
=3D iter;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test && test->=
ops->free) <<<-- test is NULL
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test->=
ops->free(test) [event_hist_trigger_free()] {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 [..]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (data->name)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 del_named_trigger(data) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del(&data->named_list);=C2=A0 <<<<-- NE=
VER gets removed!
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [..]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(data); <<<-- frees=
 item but it is still on list
>=20
> The next time a hist with name is registered, it causes an u-a-f bug and
> the kernel can crash.
>=20
> Move the code around such that if event_trigger_register() succeeds, the
> next thing called is hist_trigger_enable() which adds it to the list.
>=20
> A bunch of actions is called if get_named_trigger_data() returns false.
> But that doesn't need to be called after event_trigger_register(), so it
> can be moved up, allowing event_trigger_register() to be called just
> before hist_trigger_enable() keeping them together and allowing the
> file->triggers to be properly populated.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 067fe038e70f6 ("tracing: Add variable reference handling to hist t=
riggers")
> Reported-by: Tomas Glozar <tglozar@redhat.com>
> Closes: https://lore.kernel.org/all/CAP4=3DnvTsxjckSBTz=3DOe_UYh8keD9_sZC=
4i++4h72mJLic4_W4A@mail.gmail.com/
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks like a good fix, and is cleaner without the goto as well. Small typo =
below...

Reviewed-by: Tom Zanussi <zanussi@kernel.org>


> ---
> =C2=A0kernel/trace/trace_events_hist.c | 31 ++++++++++++++++-------------=
--
> =C2=A01 file changed, 16 insertions(+), 15 deletions(-)
>=20
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 261163b00137..c32adc372808 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6724,27 +6724,28 @@ static int event_hist_trigger_parse(struct event_=
command *cmd_ops,
> =C2=A0	if (existing_hist_update_only(glob, trigger_data, file))
> =C2=A0		goto out_free;
> =C2=A0
> -	ret =3D event_trigger_register(cmd_ops, file, glob, trigger_data);
> -	if (ret < 0)
> -		goto out_free;
> +	if (!get_named_trigger_data(trigger_data)) {
> =C2=A0
> -	if (get_named_trigger_data(trigger_data))
> -		goto enable;
> +		ret =3D create_actions(hist_data);
> +		if (ret)
> +			goto out_free;
> =C2=A0
> -	ret =3D create_actions(hist_data);
> -	if (ret)
> -		goto out_unreg;
> +		if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
> +			ret =3D save_hist_vars(hist_data);
> +			if (ret)
> +				goto out_free;
> +		}
> =C2=A0
> -	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
> -		ret =3D save_hist_vars(hist_data);
> +		ret =3D tracing_map_init(hist_data->map);
> =C2=A0		if (ret)
> -			goto out_unreg;
> +			goto out_free;
> =C2=A0	}
> =C2=A0
> -	ret =3D tracing_map_init(hist_data->map);
> -	if (ret)
> -		goto out_unreg;
> -enable:
> +	ret =3D event_trigger_register(cmd_ops, file, glob, trigger_data);
> +	if (ret < 0)
> +		goto out_free;
> +
> +

Extra space added here.

> =C2=A0	ret =3D hist_trigger_enable(trigger_data, file);
> =C2=A0	if (ret)
> =C2=A0		goto out_unreg;

Thanks,

Tom
