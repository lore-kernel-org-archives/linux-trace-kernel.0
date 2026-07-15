Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7781624D5
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098931; cv=none; b=sp/fHo37h9HXDWnNKTbOQDSeGD9B7mZ1B8I3d/GZ8+dN+UESUKSwU1qb1R8iOkZFyHFhqQc3ZPfy3pTLABC8Jx3p8QsEjDSYo1dmR4LoBw/ZdNaC9DyG+fxY3h1pGyzTug61GozFujRZ5ryx+eECsdKhAs87E2m/IOJgVKUsM94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098931; c=relaxed/simple;
	bh=K8Z09c8keYLFAAjLLvgoTCvuOG8XYLGwxUYjXA+MBMw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=IOUs8nB0BnW56FNDHl4T5yf02DSgwY6pZSO4j1dE07+3q7HR4D6Rq23tLvm1gnWkRjH49639rng4/kaajpEYyIdTV7NXM3khO3WMELwdcAmkF+jDiAQR4dbZ5bfOSqPC2+YqtOOoxfsS0zhrlHl83aiuwTRat6x6/l0qF9ODqNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FjSsDVCk; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FjSsDVCk"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784098926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poSN/4vmyecrIilJm3DdDNQun9SF/TRsGusoecLa1EI=;
	b=FjSsDVCkCU/5KCLIb05sXhEGjq/UYQXwbKydnstZsqA0d9C6DVBxqGkMfKwMi0QLT72fU5
	vYTP9a4UGZcV+Q09INrqPdKl4v8HgFz0VYhHWz0+0p/U7o8GgoDcmDQYIEVM/OWgbbYazy
	8Kh+ctKY+JCvIiCQOBg6EL5XVKzIXS4=
Date: Wed, 15 Jul 2026 07:02:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jackie Liu" <liu.yun@linux.dev>
Message-ID: <f9050a5ba183da3c9071c5be5172c4e814972836@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] tracing: Propagate errors from remote event bulk updates
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <alcsNLVLhWOH3KbJ@google.com>
References: <20260715060448.17674-1-liu.yun@linux.dev>
 <alcsNLVLhWOH3KbJ@google.com>
X-Migadu-Flow: FLOW_OUT

2026=E5=B9=B47=E6=9C=8815=E6=97=A5 14:44, "Vincent Donnefort" <vdonnefort=
@google.com mailto:vdonnefort@google.com?to=3D%22Vincent%20Donnefort%22%2=
0%3Cvdonnefort%40google.com%3E > =E5=86=99=E5=88=B0:


>=20
>=20On Wed, Jul 15, 2026 at 02:04:48PM +0800, Jackie Liu wrote:
>=20
>=20>=20
>=20> From: Jackie Liu <liuyun01@kylinos.cn>
> >=20=20
>=20>  remote_events_dir_enable_write() ignores the return value from
> >  trace_remote_enable_event(). If a remote rejects an event state chan=
ge,
> >  the write therefore reports success even though the affected event r=
emains
> >  in its previous state.
> >=20=20
>=20>  Keep trying all events, but retain and return the first error. Thi=
s matches
> >  __ftrace_set_clr_event_nolock(), which permits partial updates while
> >  notifying userspace when an operation fails.
> >=20=20
>=20>  Fixes: 775cb093bc50 ("tracing: Add events/ root files to trace rem=
otes")
> >  Assisted-by: Codex:gpt-5.6-sol
> >  Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> >=20
>=20I have sent a related improvement for that here [1]
>=20
>=20[1] https://lore.kernel.org/all/20260605163825.1762953-3-vdonnefort@g=
oogle.com/

Thanks for the pointer.

I checked the v2 series. Patch 02/18 handles registration failure cleanup=
,
and patch 03/18 changes the boolean parsing in
remote_events_dir_enable_write(), but the loop still ignores errors from
trace_remote_enable_event().

Would you prefer this fix to be folded into your series, or should I rese=
nd
a v2 rebased on top of it?

--=20
Jackie=20Liu

>=20
>=20>=20
>=20> ---
> >  kernel/trace/trace_remote.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >=20=20
>=20>  diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remo=
te.c
> >  index 0f6ef5c36d84..5212e685f0a3 100644
> >  --- a/kernel/trace/trace_remote.c
> >  +++ b/kernel/trace/trace_remote.c
> >  @@ -1149,11 +1149,22 @@ static ssize_t remote_events_dir_enable_writ=
e(struct file *filp, const char __us
> >  guard(mutex)(&remote->lock);
> >=20=20
>=20>  for (i =3D 0; i < remote->nr_events; i++) {
> >  + int eret;
> >  struct remote_event *evt =3D &remote->events[i];
> >=20=20
>=20>  - trace_remote_enable_event(remote, evt, enable);
> >  + eret =3D trace_remote_enable_event(remote, evt, enable);
> >  + /*
> >  + * Save the first error and return that. Some events
> >  + * may still have been enabled, but let the user
> >  + * know that something went wrong.
> >  + */
> >  + if (!ret && eret)
> >  + ret =3D eret;
> >  }
> >=20=20
>=20>  + if (ret)
> >  + return ret;
> >  +
> >  return count;
> >  }
> >=20=20
>=20>  --=20
>=20>  2.54.0
> >
>
