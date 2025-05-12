Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CAB1E25F8;
	Mon, 12 May 2025 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747083001; cv=none; b=AHhKbDPduvZEcegPyokTUCO1VCbhlw931VSCUJqQjqYpAgJF5Y7P6Zo1LV482bD1tMhGx3ZD2w9s9WTfU1XPxizK0Muvkk9hYFGs1kHbJOuQbL2VTJH8Vq6Qx9D5N4n8Y0gL40jiycU0hlR47b1vki94h1PCpMaBbB6/FNvKusY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747083001; c=relaxed/simple;
	bh=JkzXdx/RF//QFrL70n0K2hKP/MaNaI/4AI+sjCmGs14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0Acr+KBUxMznqQnqbn+XjSmP3/vTMb/ydIZTJKZfl8iEf5DbRwH3MSBbIi9LxJMSeiAxOu+Fmm7eFIxvuqtmCZIx+sd2+/fjV9OPKundgUq0irCuct5pDAob+kDouiJnlWEmvXCCZQmlIXfQckpLzyp4whWD2a9OjdTURmUmKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DC4C4CEE7;
	Mon, 12 May 2025 20:49:59 +0000 (UTC)
Date: Mon, 12 May 2025 16:50:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <zanussi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] tracing: Some cleanups of event trigger code
Message-ID: <20250512165015.713270f5@gandalf.local.home>
In-Reply-To: <cd64a829c2c76279ccce2640d55b97ecdb6368a3.camel@kernel.org>
References: <20250507145305.730136036@goodmis.org>
	<cd64a829c2c76279ccce2640d55b97ecdb6368a3.camel@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 May 2025 15:47:53 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> > Miaoqian Lin (1):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracing: Fix error handling in event_tri=
gger_parse()
> >=20
> > Steven Rostedt (2):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracing: Rename event_trigger_alloc() to=
 trigger_data_alloc()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracing: Remove unnecessary "goto out" t=
hat simply returns ret
> > is trigger code
> >  =20
>=20
> These all look right to me, and were probably the original intent.
>=20
> For all 3,
>=20
> Reviewed-by: Tom Zanussi <zanussi@kernel.org>

Thanks Tom!

-- Steve
