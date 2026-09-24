Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0B49F114
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262810; cv=none; b=j+nyxYqxkozIuQG1jvrsA5MZ4MadmI6Rh1w1m2m24lhR7BtCZZRRMlcwCad8L4hZskVDBcT65IBEHmeRrWGkExhzbCviQe531EVAC7wGTXi0u0BfBCy510Z8hlr5ipESG/3eF8f3mbg+78k0sToe1yGKbJ/5MAUBrVMCtN7I9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262810; c=relaxed/simple;
	bh=0jSXEkd6jEqcLCqFn9SNwNpuBggZ6qtIkdSN/fUIIHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MHFWAv1yOKVX14P8x99dJ2s7nhTW1+FWZBINDEVlsTitkKxuLmhJYgXc3dc2MyDyb8qNNK7yNjsEdGqNepxePbu3OJEEit/VN4Ajm5PjCT8PawBgbF1T+sZwTehHTLJPmP0HCJq5jWDdLVywZLQ7Q2pUdDYNzx42n+W2XWMQtcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq617Ww4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq617Ww4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644AB1F000FF;
	Thu, 24 Sep 2026 15:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790262803;
	bh=A7BKoIN2TGV2qPo8ecdoEpXizUXACQ06EzmYKVZANYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kq617Ww4Hiy4DTwda4eye/6JcYV7r+bgJfNxU4lJQAxv6Rr5gelpHGxX77J/93PDT
	 6YKgKrUcv83076JpWzDOE61zjQabauFvgMW6D1IOpReY0meteTePhz1anKXPTFcSaZ
	 iWEhtFiw0vxDs08h2Z5amcGORLGp+P9OWzuBz4je8UWi//RpSRKKUMNwrUEZ+cSjX9
	 +Q60ZoL3eTkDrWtUqlUtdMy+T/BeYAW4rgjPsvmRgaHicFYLqlO4ONWKruLY0K8pNE
	 IgASAh3aQR5yU6omMwl3p1IRdUR1JKQPht4IZnjpUVO5GpF6m871Q6el51go0JaS9s
	 2bUUN8w4OvdBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 17/20] tracing/remotes: Add poll_ms tracefs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260924145754.1285146-18-vdonnefort@google.com>
References: <20260924145754.1285146-1-vdonnefort@google.com>
 <20260924145754.1285146-18-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:13:23 +0000
Message-Id: <20260924151323.644AB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] tracing: delayed work rescheduled with old poll_ms value due to race
--

commit 8789c4fba42732f9e8b7a1922700dca27018009e
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Add poll_ms tracefs file

This commit adds a tracefs file to configure the trace remote polling perio=
d.
It keeps the default value to 100ms.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 0a360690b174e..b2547eb117f85 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c
[ ... ]
> @@ -1138,6 +1139,40 @@ static int dump_on_panic_show(struct seq_file *s, =
void *unused)
>  }
>  DEFINE_TRACE_REMOTE_ATTRIBUTE(dump_on_panic);
> =20
> +static ssize_t poll_ms_write(struct file *filp, const char __user *ubuf,=
 size_t cnt, loff_t *ppos)
> +{
> +	struct seq_file *seq =3D filp->private_data;
> +	struct trace_remote *remote =3D seq->private;
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D kstrtouint_from_user(ubuf, cnt, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (!val)
> +		return -EINVAL;
> +
> +	guard(mutex)(&remote->lock);
> +
> +	if (val < remote->poll_ms && remote->poll_cnt)
> +		mod_delayed_work(system_percpu_wq, &remote->poll_work, msecs_to_jiffie=
s(val));
> +
> +	WRITE_ONCE(remote->poll_ms, val);

[Severity: Low]
Does this code introduce a race condition where the delayed work reschedule=
s=20
with the old polling interval?

If the delayed worker is expedited via mod_delayed_work(), and it executes=
=20
before WRITE_ONCE(remote->poll_ms, val) completes (e.g., if this thread is=
=20
preempted or the worker runs concurrently on another CPU), it will read the=
=20
old remote->poll_ms value.

The worker trace_remote_do_poll() schedules itself like this:

    schedule_delayed_work(&remote->poll_work,
                          yield ? 0 : msecs_to_jiffies(READ_ONCE(remote->po=
ll_ms)));

Because it would see the old value, it could reschedule itself with the old=
=20
delay, effectively ignoring the user's requested speedup for one entire cyc=
le.

Should the new state be written before the worker is expedited?

> +
> +	return cnt;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924145754.1285=
146-1-vdonnefort@google.com?part=3D17
