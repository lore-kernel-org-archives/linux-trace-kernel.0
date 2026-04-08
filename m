Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FFB30FF26;
	Wed,  8 Apr 2026 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668684; cv=none; b=sOhV6/7ZqHrdcN/aVQsr6LxMddr6UjBbTOnCy9vW5MBvstcm6XtUEP0xzWUV7OJ/jx/9H0RRjqtTNYaX01/pGWvn3rw/CIuLlELOE+hZXjlBI9hO7h+KS9wh4yw5r4XnoKuVifuAdIghuVBFYwlK9ac/+ykugZCCsY3R4ud2WtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668684; c=relaxed/simple;
	bh=vMveKG0CT6yaQBp5cdSyC0GlyBfV4qOBC+znHP6soho=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TIAvmqaQCEHjXuTTyl646OeR2fLwIejU+C7wAPzw4sgDS+LEYav3WtXcUsghcJlsT2Tan17A8ctn4kkKtTLN6PFe7zthsoPEjz+2W4052mLqvY3PcaySjJM7zMA13nxlJ9SowoIqohADVpHMESWHj2knmMzM6/IevrH0dyf6OBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6UM4ZfM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6UM4ZfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57935C19425;
	Wed,  8 Apr 2026 17:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775668683;
	bh=vMveKG0CT6yaQBp5cdSyC0GlyBfV4qOBC+znHP6soho=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=a6UM4ZfMQYP2/zqACgibCFAgoY7qW6T+CNSXX3z+Sp0dx1ThiAV04zje8L1mYLZ+9
	 uRW9IB/vv+UnxL3O0OZ4izWhcKysnSVY/3v0qwoE5gk/YQM1yWx1fALmULz31SvZo4
	 DZ5y2oEBc0viUUERolZSBivjKSucFV+AYL30k15q+l/I/P82p1RgSEGWYiFhZFctiB
	 3cKa90p/v6DWUGYWT9DF23FFpqiCze9i2zUt+uWKacofOHOPMvoWQxo+qXEQgyQXsM
	 q+3HfP3B2h1kYBvjutveDW0WlmrTbzGqa6pW/gF4q74XecRd85baGZBXcOJ2Rkeitn
	 tjvetz7l7cRBg==
Message-ID: <36cf0fc5ee3a4476b0a70536d212278a9ee4d380.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] tracing/hist: rebuild full_name on each
 hist_field_name() call
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Date: Wed, 08 Apr 2026 12:18:02 -0500
In-Reply-To: <20260408122514.60bbfd61@gandalf.local.home>
References: <20260401112224.85582-1-pengpeng@iscas.ac.cn>
	 <20260407210502.102e5d37@gandalf.local.home>
	 <f59d594ff21658db45c58a094edeab0f92ae8345.camel@kernel.org>
	 <20260408122514.60bbfd61@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-08 at 12:25 -0400, Steven Rostedt wrote:
> On Wed, 08 Apr 2026 10:58:06 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
>=20
> Hi Tom,
>=20
> > ->system is set when using fully-qualified variable names. For=C2=A0=
=20
> > instance:
> >=20
> > echo 'hist:keys=3Dpid:ts0=3Dcommon_timestamp.usecs' >> sys/kernel/debug=
/tracing/events/sched/sched_waking/trigger
> > echo 'hist:keys=3Dpid:ts0=3Dcommon_timestamp.usecs' >> /sys/kernel/debu=
g/tracing/events/sched/sched_wakeup/trigger
> > echo 'hist:keys=3Dnext_pid:lat0=3Dcommon_timestamp.usecs-sched.sched_wa=
king.$ts0:lat1=3Dcommon_timestamp.usecs-sched.sched_wakeup.$ts0' >> /sys/ke=
rnel/debug/tracing/events/sched/sched_switch/trigger
> > echo 'hist:keys=3Dnext_pid:vals=3D$lat0,$lat1' >> /sys/kernel/debug/tra=
cing/events/sched/sched_switch/trigger
> >=20
> > Here, the sched_switch trigger would error out if the unqualified $ts0
> > variables were used instead of the fully-qualified ones because there's
> > no way to distinguish which $ts0 was meant.
> >=20
>=20
> Yep I see that now. I never had a need to use it before, but I probably
> should implement this in libtracefs to be safe.
>=20
> We should definitely add a selftest that tests this. There's one case tha=
t
> does use it but it doesn't use multiple ones. We should add a test that
> does so.
>=20
> trigger-multi-actions-accept.tc has the system, but it's not needed here.
>=20
> We should also have a test to test the output of theses lines.

Yeah, definitely. I can try adding this as a test..

Tom


>=20
> -- Steve

