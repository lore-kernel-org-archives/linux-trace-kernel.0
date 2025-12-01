Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4A02C1598;
	Mon,  1 Dec 2025 22:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629807; cv=none; b=hE59+ErbzPOE2HplrjpeqDxvDezmFhH08R2mLyuJzY7UMLEZhGKTkROb5fh3ZDsiSFhDcvEJUdA3eKiCHpKq13TuhUPKWZjzCeRNLO4LOyX2HYqV4Nk7c3wEQTq25fQjPqDd62f0B+DHkCh2vdqpdefMQ7jVNluglTCm8ZU1HlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629807; c=relaxed/simple;
	bh=uMbvBe3vpQoG5Kb1HyyE9kZDzURsLnDIs/K5O3N+i/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tl6C+mV4sLeIfopLO+p4BRJqdTAwdolMs3KU0S78A+4+VlnVC0YMq2hxkfXQlLawBXOyvz+MCvdMXEt8wqF6Vih8o+rAHvqJzor8ZJ8bx6LfSpPJLQWj9Hp4IKgHoKap3jGiQ+0FgL6VNwqogMhAC4SztcHmxdJ7iRq6ZZQZEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW+fW0pz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW+fW0pz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB593C116D0;
	Mon,  1 Dec 2025 22:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629807;
	bh=uMbvBe3vpQoG5Kb1HyyE9kZDzURsLnDIs/K5O3N+i/s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UW+fW0pzc1T43m2KbXc0k6F2hJPaPUOHeNUJY2uer8nWCmDfQ4iXWNt66aJwi/ksd
	 Y+3jhLvVhTQIIw0Y2evEryyj8+IR99WzIUhYmpPvX2r2iLO1iMFW5XYU7hfHik1W97
	 euoJKF3t8+OMQe5WbloH5yk/4SFr3J12vIczMe/AOWrYiAj3V0RlHX7fqFbSpnB6QT
	 AZ8svB+egVca7pXM1x2Jo+MkJNHmJqLNtfLh6mQEa080qFxEmf92O/EGWOwJQvzDce
	 RIKtjG54pwYZIQ4mg1Q6/guWcCM/8p8yHL08/mGus2RTikoutitzC/FissIdhcur7Z
	 3aaLYF3dJbHtg==
Message-ID: <64672c94fe19f0e87fbe9832eb26507ecaad50e9.camel@kernel.org>
Subject: Re: [PATCH] tracing: Add system trigger file to enable triggers for
 all the system's events
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>
Date: Mon, 01 Dec 2025 16:56:45 -0600
In-Reply-To: <20251126152404.21a8e3c9@gandalf.local.home>
References: <20251126152404.21a8e3c9@gandalf.local.home>
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

On Wed, 2025-11-26 at 15:24 -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> Currently a trigger can only be added to individual events. Some triggers
> (like stacktrace) can be useful to add as a bulk trigger for a set of
> system events (like interrupt or scheduling).
>=20
> Add a trigger file to the system directories:
>=20
> =C2=A0=C2=A0 /sys/kernel/tracing/events/*/trigger
>=20
> And allow stacktrace trigger to be enabled for all those events.
>=20
> Writing into the system/trigger file acts the same as writing into each o=
f
> the system event's trigger files individually.
>=20
> This also allows to remove a trigger from all events in a subsystem (even
> if it's not a subsystem trigger!).
>=20

This looks very useful! Just a couple comments below..

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v2: https://patch.msgid.link/20251125200837.31aae207@gandal=
f.local.home
>=20
> - Removed unneeded NULL initialization of tr (Masami Hiramatsu)
>=20
>=20
>=20

[ ... ]

> +static ssize_t
> +event_system_trigger_write(struct file *filp, const char __user *ubuf,
> +		=C2=A0=C2=A0=C2=A0 size_t cnt, loff_t *ppos)
> +{
> +	struct trace_subsystem_dir *dir =3D filp->private_data;
> +	struct event_command *p;
> +	char *command, *next;
> +	char *buf __free(kfree) =3D get_user_buf(ubuf, cnt);

nit: I think you could move this up a couple lines and keep the reverse
Christmas tree.

> +	bool remove =3D false;
> +	bool found =3D false;
> +	ssize_t ret;
> +
> +	if (!buf)
> +		return 0;
> +
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
> +
> +	/* system triggers are not allowed to have counters */
> +	if (strchr(buf, ':'))
> +		return -EINVAL;
> +

As mentioned by Masami, I think this would preclude the hist triggers
from having this enabled.

I'm guessing you didn't see the hist commands as one of the triggers
that would be useful as system triggers, but there might be a couple
cases where they could be if using the common fields e.g.

echo hist:keys=3Dcommon_pid.execname:vals=3Dhitcount > events/syscalls/trig=
ger=20

or anywhere just

echo hist:keys=3Dcommon_stacktrace > trigger

Just about everything else would error out, but these might be worth having=
.

Maybe you could just change this check to look for :<number> at the end of
the command?

Thanks,

Tom


