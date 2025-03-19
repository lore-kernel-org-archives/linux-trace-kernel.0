Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D940D21420F;
	Wed, 19 Mar 2025 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410986; cv=none; b=bGsozvgNKI/8rwYydt8iOv8HyYAzvTzmwqEO73kT/j3WWd1ptqxb8FG4NXZCzrVeZCgo/ig/e6Aw+ntzMvmKuJQrrWg7ROgFRW40hAmScOZ9862WphnNaoklzD54HlkMoHsAq+LSJZW/lUloRoqt3KJB534KFsQRCcQtX1KV8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410986; c=relaxed/simple;
	bh=D35b4j9CFL1Mc8HCuSxeJyE56B1TcVvE1e7E8+/SBTw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q6rKosq0a9EWh5KlWApp0ugW3rJ23wIyZjMeB2XZNtv6k6va4DnW8rTXVAlOfPcit1d1zozRkHNJcbP/Nu/AF9GUt5CSuvjkFGGEasgYZJZ6xwmVw9GyDoOVgEAHPGO+oOWjbekNsPYMfetByFwys3lwtPr5iZao6YJsMe3sCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+XQt0Gj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+XQt0Gj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C4CC4CEEC;
	Wed, 19 Mar 2025 19:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742410985;
	bh=D35b4j9CFL1Mc8HCuSxeJyE56B1TcVvE1e7E8+/SBTw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=f+XQt0GjaDUUcI1pL5vZM1th+rzkl+5k9MyNn4peQ0vAxmbYXIkRJwspgsNrGcV3s
	 1c9WiSkhauExm8Il9NmNc8ycFsm8jPvbqkfwVpDUMrzgEwMwLyT8UXEUdF3UYjB58f
	 QFxmIHny772Fpkh6H/Vm1eECjrFsQpSbwQBDHwwVt4S2O0S1u3U4BAboBcGAIYCqQP
	 jeq89f2nEpujVrvR9J++72WY1BQw2OUZkTOQ92UtTuTui8g6CfQbCfmCpu2jktKTc0
	 k4Qu3prnH5IuqyGv3twLljLNr8vJXT7swDyQiaOvPKW0QOO7RkD7x/PMZMKm20RuUg
	 ZQ2w/KfyW8K6A==
Message-ID: <02549e50e26565ffb54ea943af87c19f40692576.camel@kernel.org>
Subject: Re: [PATCH] tracing: Fix error handling in event_trigger_parse
From: Tom Zanussi <zanussi@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, Miaoqian Lin <linmq006@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Date: Wed, 19 Mar 2025 14:03:03 -0500
In-Reply-To: <20250319090650.fe63164eac3ac32bb559ffc8@kernel.org>
References: <20250318112737.4174-1-linmq006@gmail.com>
	 <20250319090650.fe63164eac3ac32bb559ffc8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Masami,

On Wed, 2025-03-19 at 09:06 +0900, Masami Hiramatsu wrote:
> On Tue, 18 Mar 2025 19:27:37 +0800
> Miaoqian Lin <linmq006@gmail.com> wrote:
>=20
> > According to event_trigger_alloc() doc, event_trigger_free() should be
> > used to free an event_trigger_data object. This fixes a mismatch introd=
uced
> > when kzalloc was replaced with event_trigger_alloc without updating
> > the corresponding deallocation calls.
> >=20
>=20
> Hmm, it seems more complicated problems are there. e.g. in `remove =3D tr=
ue`
> case, since the trigger_data is not initialized (no event_trigger_init())=
,
> the `trigger_data->ref` is 0. Thus, ;
>=20
> static void
> event_trigger_free(struct event_trigger_data *data)
> {
> 	if (WARN_ON_ONCE(data->ref <=3D 0))
> 		return;
>=20
> 	data->ref--;
> 	if (!data->ref)
> 		trigger_data_free(data);
> }
>=20
> this will never call `trigger_data_free(data)`.=20
>=20
> But latter part(after out_free) seems correct.
>=20
> Tom, could you check it?
>=20

In both these cases, the code calls kfree() directly in order to avoid
the WARN_ON_ONCE(data->ref) check.

In the first case (remove), trigger_data is only being used as a test
object and will never have data->ref incremented.

The second case is the failure case, which is also dealing with a
trigger_data object that hasn't been successfully registered and
therefore has a 0 data->ref.

So perhaps the event_trigger_alloc doc should be changed to something
like:

"Use event_trigger_free() to free a successfully registered
event_trigger_data object."

Thanks,

Tom

> Thank you,
>=20
> > Fixes: e1f187d09e11 ("tracing: Have existing event_command.parse() impl=
ementations use helpers")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> > =C2=A0kernel/trace/trace_events_trigger.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_e=
vents_trigger.c
> > index d45448947094..8389314b8c2d 100644
> > --- a/kernel/trace/trace_events_trigger.c
> > +++ b/kernel/trace/trace_events_trigger.c
> > @@ -995,7 +995,7 @@ event_trigger_parse(struct event_command *cmd_ops,
> > =C2=A0
> > =C2=A0	if (remove) {
> > =C2=A0		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
> > -		kfree(trigger_data);
> > +		event_trigger_free(trigger_data);
> > =C2=A0		ret =3D 0;
> > =C2=A0		goto out;
> > =C2=A0	}
> > @@ -1022,7 +1022,7 @@ event_trigger_parse(struct event_command *cmd_ops=
,
> > =C2=A0
> > =C2=A0 out_free:
> > =C2=A0	event_trigger_reset_filter(cmd_ops, trigger_data);
> > -	kfree(trigger_data);
> > +	event_trigger_free(trigger_data);
> > =C2=A0	goto out;
> > =C2=A0}
> > =C2=A0
> > --=20
> > 2.39.5 (Apple Git-154)
> >=20
> >=20
>=20
>=20

