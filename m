Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87AC2114;
	Thu,  6 Mar 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273996; cv=none; b=FQhsk9q7Y/IUEPTVLKIr4X4HonJicPvk/YlNJciNV3pX9eqNTFQlhjcAb8SUZKaGxbBDhYK7Ahf2pvikEVMW8O9LEMU+1k11ziTwlshD5OznF7VDQVPD3AVOn7pJzRoU/6Ic955JV44ji90LfbEXz3w5NOqcn+RndbypPdIHorw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273996; c=relaxed/simple;
	bh=pap1xK5SnNKiiMrorspnPCO3wV1Ru3Gs/zhidkela08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEpodJD4LXu9R1A/URdcpLjFswudF+KbBFaGnCx1r3ucMHz99tdRuT3JGAUFUd00T6zEU6DaWC+t15PeqiP6O+kzw4vMYzEwpNlm8kGa3ULw3GAhCeODpxuY5h9YNJ9x3ynoqdjBLEGaspAE1EOV7a+Jrcoa394iOPPKNlztyIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311CFC4CEE0;
	Thu,  6 Mar 2025 15:13:15 +0000 (UTC)
Date: Thu, 6 Mar 2025 10:13:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Huang Shijie
 <shijie@os.amperecomputing.com>, patches@amperecomputing.com, cl@linux.com,
 yang@os.amperecomputing.com, peterz@infradead.org, jpoimboe@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH resend ] tracepoint: Print the function symbol when
 tracepoint_debug is set
Message-ID: <20250306101315.5a5f1d7f@gandalf.local.home>
In-Reply-To: <b098cbdf-394b-4f20-9dcd-393ad1b734b7@amperemail.onmicrosoft.com>
References: <20250305015505.14493-1-shijie@os.amperecomputing.com>
	<f600edd0-8855-46af-98ec-1181db1f5dd4@efficios.com>
	<b098cbdf-394b-4f20-9dcd-393ad1b734b7@amperemail.onmicrosoft.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Mar 2025 11:37:38 +0800
Shijie Huang <shijie@amperemail.onmicrosoft.com> wrote:

> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index abfd0ac1177f..5a5041f32cc8 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -127,7 +127,8 @@ static void debug_print_probes(struct=20
> tracepoint_func *funcs)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return;
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; funcs[i].func; =
i++)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 printk(KERN_DEBUG "Probe %d : %p\n", i, funcs[i].func);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 printk(KERN_DEBUG "Probe %d : [ %p ] %pS\n",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i, funcs[i].func, funcs[i].func);
>  =C2=A0}
>=20
>=20
> The output will look like:
>=20
> [=C2=A0=C2=A0 63.818829] Probe 0 : [ 0000000032848d41 ]=20
> perf_trace_sched_wakeup_template+0x0/0x20
> [=C2=A0=C2=A0 63.819287] Probe 0 : [ 00000000fe8cca4d ]=20
> perf_trace_sched_switch+0x0/0x20
> [=C2=A0=C2=A0 65.325638] Probe 0 : [ 0000000032848d41 ]=20
> perf_trace_sched_wakeup_template+0x0/0x20
> [=C2=A0=C2=A0 65.695631] Probe 0 : [ 00000000fe8cca4d ]=20
> perf_trace_sched_switch+0x0/0x20

I'm fine either way. Mathieu, what's your preference?

Although the above shows a hashed %p. Is that even useful?

-- Steve
