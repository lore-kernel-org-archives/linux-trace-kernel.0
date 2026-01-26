Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326513EBF2D;
	Mon, 26 Jan 2026 04:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769401311; cv=none; b=H/OOWJoon+W3Fnm3kb3kx1zxAs0I483xMUNLrIGLUlbvDZhiSnwmzbijZYvlya9UqWEh21C7xQYYHFQUnODp/U3JqI5lwZ+gkGTVyn1aidCzUb0Jy2b//18O38WxFc9VpZ5beT4dHXtu6oEVs7Sce11i4J4sSVjD35bTS6NI8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769401311; c=relaxed/simple;
	bh=L7T0YqQWyxghbfsXlz/uKE3hC4fr+BRvc8hpMQuHiJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAeTolZhdUNBlNXCdkbMblM5iu0lwWjIKe2m9s/rQfE528a8o/Qlv21xuij5kQzbtPjB5MoSwIxMN41HcHUmRuAqaDbkOpiGFZ4JwDyyTj+Vh+ljw2xFh44+7L3JLJDqaxhChAImfhRBLgH34HsLlpSfIgdicOMqATynioUTUhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 1C60F59FB9;
	Mon, 26 Jan 2026 04:21:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 24FD918;
	Mon, 26 Jan 2026 04:21:41 +0000 (UTC)
Date: Sun, 25 Jan 2026 23:21:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sunliming <sunliming@linux.dev>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, sunliming
 <sunliming@kylinos.cn>
Subject: Re: [PATCH] tracing: kprobe-event: Return directly when
 dyn_event_list is empty
Message-ID: <20260125232139.0e971011@robin>
In-Reply-To: <01b1d5a3-8be0-4d9a-45d4-4da7c3edf746@linux.dev>
References: <20260123013641.23066-1-sunliming@linux.dev>
	<20260124120233.17926a82@robin>
	<01b1d5a3-8be0-4d9a-45d4-4da7c3edf746@linux.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 24FD918
X-Stat-Signature: 6oopbaaa5rsizeif3ix315gpfzkanf9a
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/puuICIlQVktCo7STrt9LHlixR+pDOXS4=
X-HE-Tag: 1769401301-956519
X-HE-Meta: U2FsdGVkX19riHIXwwPdMoelskLEucbYFhxLjfomwYOwD11e1Ibn8/h0weA1qIKbxOt9tCXNcNiY++L9cW0NPxE6NVoPtJZ2vz9blqEI/N8WRKiey4oihYVTyuD7VXsZ6fv2bH1XYj8BTItz6v5Iz/B167K+4qpnF8WAV8POZb/8Hh4cjhpv8YGRYueRUa3P6QBxZ6ku4kW6o1fyP7rToA+0NpeebJiaCYGzi+2My1r9htaYi/MN8kZw6l6ADj18bxBHe15pw95/RVGo1xrrFBRtM2qpOAQgHoJKjsFBmPkqEehgOC0LE65V6nFmd3zyxJE3r3Z+bWyFGiVHVbJKHAXEbQUOF56u

On Mon, 26 Jan 2026 10:56:59 +0800
sunliming <sunliming@linux.dev> wrote:

> During kernel boot, the setup_boot_kprobe_events() function causes
> significant delays, increasing overall startup time.
>=20
> The root cause is a lock contention chain: its child function
>=20
> enable_boot_kprobe_events() requires the event_mutex, which is already
>=20
> held by early_event_add_tracer(). early_event_add_tracer() itself is=20
> blocked

Ah, early_event_add_tracer() is called by the work function that sets
up tracers (and the event directories within them).

>=20
> waiting for the trace_event_sem=C2=A0 read-write lock, which is held for =
an=20
> extended
>=20
>  =C2=A0period by trace_event_update_all(). trace_event_update_all()=C2=A0=
 is=20
> runing in
>=20
> eval_map_work_func() in=C2=A0=C2=A0 eval_map_wq.
>=20
> On my ARM64 platform machine, the latency can reach around 200ms=EF=BC=9A
>=20
> [ 0.268848] trace_kprobe: try_get_event_mutex=20
> kernel/trace/tracekprobe.c,1902,enable_boot_kprobe_events
> [ 0.268849] try down_write=20
> kernel/trace/traceevents.c,4114,early_event_add_tracer
> [ 0.482382] done up_write=20
> kernel/trace/trace_events.c,3074,trace_event_eval_update
> [ 0.482386] done down_write=20
> kernel/trace/trace_events.c,4116,early_event_add_tracer
> [ 0.482868] done up_write=20
> kernel/trace/trace_events.c,4119,early_event_add_tracer
> [ 0.482877] trace_kprobe: enable_boot_kprobe_events geted eventmutex
> [ 0.482879] trace_kprobe: enable_bootk_probe_events release eventmutex

I take it that you are aware of this work, as it comes from someone
with the same email domain as you have.

  https://lore.kernel.org/all/20260122032051.386331-1-tianyaxiong@kylinos.c=
n/

That is moving the kprobe setup into the same work function.

-- Steve
