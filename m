Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8C26FA6C;
	Wed, 24 Sep 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701502; cv=none; b=UsOXUWjzA4zoZpOtGHZJjiOt5W9wXHcBUA/vxAn92zYHEGUByktVjhkgtEz6QIO2PSbBOrVZaYUrSoo8+HvrPbZBOU0qN/RZyh8vVZbK2VyNmUdTOXKEKi+fAt7hY8MRrvpelLeoxLLBQvsDehm90NU5K2gwDPDUmwrIlaPnElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701502; c=relaxed/simple;
	bh=TuzfO1x5Qxp6XF6jkj6gG95IxepDneOJdR398+iRhxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFoGOC4QXAFahcLpctAMK0lkTJbwMaH0YDE27g8Gg07Z7yrmDxvGYrKPquA0El19FTas1YZMds0HeTMcuVkuziB6aL3xC7YqG8E7VHVCBQVWLhNo+/ut1+jUcWG1mGNKqL+N9sAJI0R+4akIurtNo/83SVdIJ6db+5nh/wiFgys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id CA9941A0765;
	Wed, 24 Sep 2025 08:11:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id AC1B820027;
	Wed, 24 Sep 2025 08:11:29 +0000 (UTC)
Date: Wed, 24 Sep 2025 04:11:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Ensure optimized hashing works
Message-ID: <20250924041125.268a4ceb@batman.local.home>
In-Reply-To: <20250923165908.2399256-1-mkoutny@suse.com>
References: <20250923165908.2399256-1-mkoutny@suse.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 46wzynmgsprcx5aojibikh3teuzyb7mp
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: AC1B820027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+/kNzYB6rvvZIbAZjGtVGQq1VwbFnmtZs=
X-HE-Tag: 1758701489-236507
X-HE-Meta: U2FsdGVkX19mbeoVmhTTWc6VqZFPoy5nSWEa2XqlSSBUL23RJLqCcF8ZYYYpo5kRuEZNHW2EVx7e5z/SUGIaloXGzJJW6Gy1DhwmbaXV3/nFJYtTvzfrx71KBx3p6ET1693JCJa68KwlThSHk8OP/eA3MjOB4aLq71LOfhQKLQtJ+A+wcbgC5yQ0CpoCo7Y4xQy90/NnlcMRK2K4sFGg8u7C8Mjz91uasjEeNkjW+AoyaVggBwX858/MlB2n5N2CJtXlSawIjpRfxSIFFW3E/sp1EYU9IT/1FEqw93zkwN+IE8xDQYKlPObVS1jaLnt8q2B/Bq8L7YbNzIbHUgfdav/St3r+Y4kGFDo2GKzl3DCmmJ3ukLxhbyuU5U7GVfFy8Toz5YVPR3cHzC6dYj13Ew==

On Tue, 23 Sep 2025 18:59:07 +0200
Michal Koutn=C3=BD <mkoutny@suse.com> wrote:

> If ever PID_MAX_DEFAULT changes, it must be compatible with tracing
> hashmaps assumptions.
>=20
> Link: https://lore.kernel.org/r/20240409110126.651e94cb@gandalf.local.hom=
e/
> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> ---
>  kernel/trace/trace_sched_switch.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> Drive-by flushing an old idea. Take it or leave it.
>=20
> diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched=
_switch.c
> index cb49f7279dc80..aabae7daaac91 100644
> --- a/kernel/trace/trace_sched_switch.c
> +++ b/kernel/trace/trace_sched_switch.c
> @@ -243,6 +243,8 @@ int trace_create_savedcmd(void)
>  int trace_save_cmdline(struct task_struct *tsk)
>  {
>  	unsigned tpid, idx;
> +	/* so that map_pid_to_cmdline indexing is efficient */
> +	BUILD_BUG_ON(!is_power_of_2(PID_MAX_DEFAULT));

Please move this to just above the test. And it doesn't need a comment,
as it's obvious for why it needs to be a power of two when it's above
the test.

> =20
>  	/* treat recording of idle task as a success */
>  	if (!tsk->pid)

Like this:

	/* treat recording of idle task as a success */
	if (!tsk->pid)
		return 1;

+	BUILD_BUG_ON(!is_power_of_2(PID_MAX_DEFAULT));
+
	tpid =3D tsk->pid & (PID_MAX_DEFAULT - 1);

-- Steve
