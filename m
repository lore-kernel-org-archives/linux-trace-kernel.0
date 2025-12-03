Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884832D6E53;
	Wed,  3 Dec 2025 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764802709; cv=none; b=XBakRRR3w5BboB6XkK0xt6jt5tjTpsH/lncmo4YkUwAMbYFV1gHrDssmmuaofCyjeAvosx4ADhH2HEXsKpNyc0vEK0L4gqLr0zN6YF9E8MUMYsfCKg3TBUALl71BHyIQMy4jvbxKpnRJUQ3t7B93rbv3vFrRdHStEkcMH7bXnU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764802709; c=relaxed/simple;
	bh=8ryuxdH6/u58lXULrYF2Iok6qNH5lReSAFGP6YOtwrg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ByMgfq3q8s5FId8+/Tpdn43daZcZz4kHyTlOhyFa1U7BM1U+xKe7J7g7u58ced1GDmTdapiQ6XhcViZ0DRH5sg/1iM64HMW4lKx9wE4e5Duvzvy5ntF5vmhCpLG3fjYEa8JmH9eQEOkdwYOpNhT6XgY6dxNM2pue/raD86Rlens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qW7fJX7f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qW7fJX7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A514C4CEF5;
	Wed,  3 Dec 2025 22:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764802709;
	bh=8ryuxdH6/u58lXULrYF2Iok6qNH5lReSAFGP6YOtwrg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qW7fJX7fJFNo5/g/EYiXNtRQCMSR+Hkgg9ItuAZjmjobqikYplnTvfeTHH5G8Kdes
	 Ayn/XklbTZ6E9SlRSweECh3+zlCHIrmBdlCBr92C//98kQjoBzElHHcxkHuCw1J2Ah
	 9Pene3pn8eCEKnxPgcjags8zOH3H6uzon3sggKUx4sYZuRXOpDt0TvnTTgR0N2Tcnz
	 X29wak4G8ApQozVr9augLvuDtyzv30A3oGGETipHGB+Q1jrxDmQ2Jg5/L0BoJt3+0s
	 ExZfDmR9H2lIvQ+JTAghXyV4ykh7JeFQyeYNum0AVMOFKPeYho/5uzTKzEreo4iH0K
	 cEM/PzKECy0bw==
Message-ID: <a23f604e791cee60e24efb0f415cab60d1de6176.camel@kernel.org>
Subject: Re: [PATCH v2 3/3] tracing: Use strim() in trigger_process_regex()
 instead of skip_spaces()
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
  Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 03 Dec 2025 16:58:27 -0600
In-Reply-To: <20251203174604.0405a90d@gandalf.local.home>
References: <20251125214004.396482401@kernel.org>
	 <20251125214032.323747707@kernel.org>
	 <9393741d90fff46709a2c9b0b04f406d5245d000.camel@kernel.org>
	 <20251203174604.0405a90d@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 17:46 -0500, Steven Rostedt wrote:
> On Wed, 03 Dec 2025 16:40:04 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
>=20
> > > Remove the strim() from event_trigger_regex_write() and have
> > > trigger_process_regex() use strim() instead of skip_spaces(). The buf=
f
> > > variable is not passed in as const, so it can be modified.
> > >=20
> > > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>=C2=A0=
=20
> >=20
> > Looks good to me.
> >=20
> > Reviewed-by: Tom Zanussi <zanussi@kernel.org>
>=20
> Thanks for all the reviews, but I already did the pull request ;-)
>=20
> Although it hasn't been accepted yet and there's always a chance Linus ma=
y
> have an issue with one of the commits (I had a lot of commits this time,
> affecting various aspects of the code, but couldn't use topic branches du=
e
> to too many conflicts). If it is rejected, I'll add your reviewed-by tags=
.
>=20
> -- Steve

No problem, my fault for being so slow to get to these. :-/

Tom
