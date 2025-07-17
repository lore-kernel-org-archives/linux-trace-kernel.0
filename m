Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403C2FA64D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763815; cv=none; b=N2GvdUQWW0tdg6sEsMOVOHbhdZzf6adZWR6L+WpLT/30kFvKr3Fia4JgJZqSE2rmg2BDspdCmnYR7DgQ2xillXJVxwZQfFpAgaLRtGHDYDu79VVE31mwHeMLo2My4KOQU6YWRA6ix35z8mOSeGSOy6n3IOzYsRAeo2EWBOfiNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763815; c=relaxed/simple;
	bh=FTK15QAD4wYbnsAKEbIpOFo1TaHSBvVbVxRaoSZpye8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzoBhRlUwKPnHRJF7/qk+2FwYxtnxYV9wziFZujfbh2Huld3dFwKVcLYdlhR9g/NcpK6/9lm4a+C8dAKgA+y7fjk4IG+Jx78jfvMzTa9wU6YmgRPAawvbWftC/jL7sVDCGrlWBmPLF9dKGTtw/tyQ0iR/n1MGnSXld83IhYlX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 11F8E1A0007;
	Thu, 17 Jul 2025 14:50:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 642BD80012;
	Thu, 17 Jul 2025 14:50:10 +0000 (UTC)
Date: Thu, 17 Jul 2025 10:50:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Fusheng =?UTF-8?B?SHVhbmc=?=(=?UTF-8?B?6buE5a+M55Sf?=)"
 <Fusheng.Huang@luxshare-ict.com>
Cc: "mhiramat@kernel.org" <mhiramat@kernel.org>, "GuoJin =?UTF-8?B?RGFp?=(
 =?UTF-8?B?5oi05Zu96YeR?=)" <GuoJin.Dai@luxshare-ict.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: =?UTF-8?B?44CQZnRyYWNlX2V2ZW50cyBsaXN044CRcmFjZQ==?= between
 trace_event_eval_update and __register_event discuss
Message-ID: <20250717105007.46ccd18f@batman.local.home>
In-Reply-To: <3c1259275c784bbd9e2f33e1b2d846c1@luxshare-ict.com>
References: <3c1259275c784bbd9e2f33e1b2d846c1@luxshare-ict.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 642BD80012
X-Stat-Signature: qr1b975i7pw3bt64t71ey5i1t4xb7jih
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Z6P7b6vUHiCtJcXAv4KJ/aGaBTnThIjc=
X-HE-Tag: 1752763810-708762
X-HE-Meta: U2FsdGVkX1+HS3ftjKc/xXGIqynIDqHi8mzBpYITT6ugSmdbBJdAGpvXlsz+UoT7l8t5/nECITfRuNSUOOtlyJXVMW4/cCwivWBlcy/ybxVZMtorpWugaJWGGpqjIXFTaORB1EN8JhyznRZeK4ipwtyRBFddnMW492QCBe95b1UgDezDN7sP+Qz8cHUrYOVDRt6cxQX6NOeBLxlJnjcjXuYM6q0o6jd+VVPIPQJ23k+yOXWMJcFopj4V511Zd4mYCjnThYD/27vbyHlmuMcwRIfetuSORBuksorKRPtV5YMMAJcdWRyx3WmN+JR1B1kHGTMlThTS430Hoq0pyt4/eRTMmCbXQb9V2PcvPcg9H6WCsl7r+ec8jvn3co2OXWjN4IYYFT710jd6LxiIPFx1JA==

On Thu, 17 Jul 2025 12:37:37 +0000
Fusheng Huang(=E9=BB=84=E5=AF=8C=E7=94=9F) <Fusheng.Huang@luxshare-ict.com>=
 wrote:

> Dear rostedt, mhiramat:
>=20
> We encountered a small problem of ftrace module, and need your help .
>=20
> =E3=80=90issue background=E3=80=91During the process of starting and load=
ing ko in
> the Linux kernel, we encountered a crash of the CPU 7 null pointer
> caused by the synchronization operation of ftrace_events list, with a
> probability of less than 1/1000
>=20
> =E3=80=90call stack=E3=80=91
>=20
>        CPU7
>=20
>        load_module()
>        prepare_coming_module(inline)
>        blocking_notifier_call_chain_robust()
>        notifier_call_chain_robust(inline)
>        notifier_call_chain(inline)
>        trace_module_notify()
>        trace_module_add_evals(inline)
>        trace_insert_eval_map(inline)
>        trace_event_eval_update()
>                      |
>                      |...
>                      |---down_write(&trace_event_sem);
>                             list_for_each_entry_safe(call, p, &ftrace_eve=
nts, list) {
>                             /* events are usually grouped together with s=
ystems */
>                             if (!last_system || call->class->system !=3D =
last_system) {
>                                    first =3D true;
>                                    last_i =3D 0;
>                                    last_system =3D call->class->system;
>                             }
>                             ......
>=20
>=20
>             CPU4
>=20
>         load_module()

Hmm, for some reason I thought module loading was synchronized and
couldn't run in parallel. It may have been that way long ago, but
apparently it isn't now.

>          prepare_coming_module(inline)
>          blocking_notifier_call_chain_robust()
>          notifier_call_chain_robust()
>          trace_module_notify()
>          trace_module_add_events(inline)
>          __register_event(inline)
>                      |...
>                      |--list_add(&call->list, &ftrace_events);
>                      |...
>=20
>=20
>=20
>=20
>        Function1: trace_event_eval_update --->traverse the ftrace_events =
list
>=20
>        Function2: __register_event --->list_add ftrace_events ,but no wri=
te lock protect.
>=20
>      Function1 and Function2 are running at the same time.
>=20
>=20
>       We want to know Is this a small bug or are there other consideratio=
ns?

This looks like a small bug.

>=20
>       Should we could add write lock protection to optimize this issue ?
>=20
>       __register_event(inline)
>                 |...
>                 |+++down_write(&trace_event_sem);
>                 |
>                 |---list_add(&call->list, &ftrace_events);
>                 |
>                 |+++down_up(&trace_event_sem);
>               |...
>=20

Can you see if this patch works for you?

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abf..f00d3901cd3b 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3675,10 +3675,12 @@ static void trace_module_add_events(struct module *=
mod)
 	start =3D mod->trace_events;
 	end =3D mod->trace_events + mod->num_trace_events;
=20
+	down_write(&trace_event_sem);
 	for_each_event(call, start, end) {
 		__register_event(*call, mod);
 		__add_event_to_tracers(*call);
 	}
+	up_write(&trace_event_sem);
=20
 	update_cache_events(mod);
 }

The remove takes that semaphore, I don't know why the addition doesn't.
Looks to be a long standing bug. Goes back to 110bf2b764eb6 that was
added in 2009. Probably because I assumed load_module() was
synchronized :-p

Thanks for the report!

-- Steve
