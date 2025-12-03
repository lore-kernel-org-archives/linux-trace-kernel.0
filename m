Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7732E764B;
	Wed,  3 Dec 2025 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801606; cv=none; b=YJWdqTsRSbfWojKLkCoGo2v3Rsh6/Mud4ZD+17dfkZCk9cPhNSmxhYrG8isHunKbfDm5+FGHEcLMZaJvqRL5LAqiGON3TyDU1p5G6Svi/HRyF13ohIDFNLRBhQ9wpe7Bt+/+4voBOVs3k7XuhgVKD8FwLkFk9G6GwE5+ChD7xdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801606; c=relaxed/simple;
	bh=8g1OSYjyONOKiqLxJIs7rESRRIjffUNJ8it/vEABZ6w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A9fGF8AkEZp/2zIA4KJic02BX5npCbkgArtIh+8A4VfwoQpOJ72eqcjvvm3DgFA9g1rCtJ0E0kcws7Yr7k51Rr5U8AqpQyZFU0ioysdkaEG+39kbaLCEknOJkm+k/V9EdJkpdE3NZ3WrXftcPwWVPFO5ViwmOuJ8m34OWJNrcWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1bOt1Az; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1bOt1Az"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EC8C4CEF5;
	Wed,  3 Dec 2025 22:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764801605;
	bh=8g1OSYjyONOKiqLxJIs7rESRRIjffUNJ8it/vEABZ6w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=T1bOt1AzHnhYL48iiURWFwsKaaoKekaj1jDwVonF4uhMUXYLHnk0aI56/0z1VmD7/
	 Ix3QjZKXPiex6zcITuE5j7+vGBAAg/Rt4PkHsOjwBAehkMrnk9uA5NpTtiuafmF/hX
	 UXm+eb2pzRxXr5UNRy471/IGK2s2s1UlABkTAzlAG9XeFBfwYIyHspw09NuGeaXzL5
	 i7XI8/FvUptEDd2dApHhLZezlM6+ZSYsvn8rma6MhKg5G0yBq1o0IkgRcJ0KGehiAD
	 nHTvbxSabKoBID8W1rHNy3bRoSA5A8e4ZpC1xfRxZA0S1bHgM63iMaV8QTDZW0PkBC
	 K4keekv/iQRjQ==
Message-ID: <9393741d90fff46709a2c9b0b04f406d5245d000.camel@kernel.org>
Subject: Re: [PATCH v2 3/3] tracing: Use strim() in trigger_process_regex()
 instead of skip_spaces()
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 03 Dec 2025 16:40:04 -0600
In-Reply-To: <20251125214032.323747707@kernel.org>
References: <20251125214004.396482401@kernel.org>
	 <20251125214032.323747707@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-25 at 16:40 -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> The function trigger_process_regex() is called by a few functions, where
> only one calls strim() on the buffer passed to it. That leaves the other
> functions not trimming the end of the buffer passed in and making it a
> little inconsistent.
>=20
> Remove the strim() from event_trigger_regex_write() and have
> trigger_process_regex() use strim() instead of skip_spaces(). The buff
> variable is not passed in as const, so it can be modified.
>=20
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

> ---
> =C2=A0kernel/trace/trace_events_trigger.c | 5 ++---
> =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_eve=
nts_trigger.c
> index 3b97c242b795..96aad82b1628 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -308,7 +308,8 @@ int trigger_process_regex(struct trace_event_file *fi=
le, char *buff)
> =C2=A0	char *command, *next;
> =C2=A0	struct event_command *p;
> =C2=A0
> -	next =3D buff =3D skip_spaces(buff);
> +	next =3D buff =3D strim(buff);
> +
> =C2=A0	command =3D strsep(&next, ": \t");
> =C2=A0	if (next) {
> =C2=A0		next =3D skip_spaces(next);
> @@ -345,8 +346,6 @@ static ssize_t event_trigger_regex_write(struct file =
*file,
> =C2=A0	if (IS_ERR(buf))
> =C2=A0		return PTR_ERR(buf);
> =C2=A0
> -	strim(buf);
> -
> =C2=A0	guard(mutex)(&event_mutex);
> =C2=A0
> =C2=A0	event_file =3D event_file_file(file);

