Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845ED1DFDE;
	Mon, 12 May 2025 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747082875; cv=none; b=bfMDEmbUyQmKiAU3qS/4XRrR1Rv+R41od6X2zjlv7K70I0cqUdNXvEJijxnZ+OQzQfAaA6Qkfyt/CX5W8Ge0Q/k0M8/VoMU5KeriTGzzd5BC63dhViOx3IIgNxRcEQpFjbChRxtFpvBJfNqKOtdH2/3n5cQgSa1AR/nEA9AsjXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747082875; c=relaxed/simple;
	bh=ncWRL4i/Fe9PAVGOtftxuuA4+OfWoKiO+91I4WPl4WE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i3SFCVs/xExx3Hbd5fItaYV4fnkr9Jfh0G5SJmUoCX6gYqiVqLvfpRG90ATaUATrESDXynLxyouvTupPAYFxDvolj8piC9d/9F2uJRGj3xjM9dQ9guHOwHzf4hqXyw6kxm5/RfeMGDabiGOF/tVFaGOwM52SfQQcG6tF0gsFsVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWVTaFoy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWVTaFoy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D73C4CEE7;
	Mon, 12 May 2025 20:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747082875;
	bh=ncWRL4i/Fe9PAVGOtftxuuA4+OfWoKiO+91I4WPl4WE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lWVTaFoyy1rvhF3eZVmKtn+FbylYqadJHEVpgpAdDTShaDNFEEeejjoZbWnq7T7er
	 ycjDzHbNKoYyCYJyL7OyeASoy2C+SBeU29/e9waV7l2dgHrfEPVWbS/0aJAuzaB7Vp
	 P1hyt/bDBgKoH/Hb6v4PyZMQmULPvu08CuoaOJdJ5bYkl27s4MVjox8UBtOgj6j0Lj
	 AYYxklh4mElkACVeEB2FzG3Hph86fbGQNZSGtS5JufE6NMcfpzx3N4kQPdJLTTmOOz
	 rQxKHicUmG4s76SGZO4BkOWw81yA5e4NoF6MeXlXfh4dtaCTjw9vxgus0BrPcsH/NO
	 HQ9uwc8QykcYA==
Message-ID: <cd64a829c2c76279ccce2640d55b97ecdb6368a3.camel@kernel.org>
Subject: Re: [PATCH 0/3] tracing: Some cleanups of event trigger code
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 12 May 2025 15:47:53 -0500
In-Reply-To: <20250507145305.730136036@goodmis.org>
References: <20250507145305.730136036@goodmis.org>
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

On Wed, 2025-05-07 at 10:53 -0400, Steven Rostedt wrote:
> These are minor clean ups of the trace_events_trigger code.
>=20
> - Rename event_trigger_alloc() to trigger_data_alloc() as it
> =C2=A0 is supposed to be freed by trigger_data_free().
>=20
> - Remove unneeded goto outs
>=20
> - Add consistent cleanup in event_trigger_parse()
>=20
>=20
> Miaoqian Lin (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracing: Fix error handling in event_trigg=
er_parse()
>=20
> Steven Rostedt (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracing: Rename event_trigger_alloc() to t=
rigger_data_alloc()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracing: Remove unnecessary "goto out" tha=
t simply returns ret
> is trigger code
>=20

These all look right to me, and were probably the original intent.

For all 3,

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

Thanks,

Tom

> ----
> =C2=A0kernel/trace/trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++---
> =C2=A0kernel/trace/trace_events_hist.c=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0kernel/trace/trace_events_trigger.c | 64 ++++++++++++++++----------=
-
> ----------
> =C2=A03 files changed, 31 insertions(+), 43 deletions(-)

