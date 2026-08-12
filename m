Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A999F44C64B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554786; cv=none; b=QYSj2pwBShS83rKMAPUdN6XLy5T+YZEitmcggOXpBBwj7IyboXRHe2e2eDfnHy1XNHsf03FVaBs3rLJNc+ZlY3eJkMckfTEvL4OpmjE538C9bpiTdU0aF1dDkotrDc9iv3FkMSJAhyFmmQENqxhSb5Ok2FqrR4voyJFSV7sWQK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554786; c=relaxed/simple;
	bh=hiAGRsCivzpccjXcG6ZNISZyFoTtxPkHAbDbxOsw4OU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=faq8ihU8atdPVP6J8t6ENugto0mwyfN1jWA7LNUT+orHRJKxcRTfq7AbNs6HhBsqiMtlnZk9BiZJG/w9gGB3Yn0EvYbBqkwSTCH+mtPzqxD4g2xr9DFULzfs2vPu0rlRcRk2rhenrZVXf1dAqpQ8z5Hm+htUeJmRd8QemoNhdos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBK6M5wp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBK6M5wp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47D41F000E9;
	Wed, 12 Aug 2026 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786554785;
	bh=to4HeTM6+CDT5yfQg05Tf3UveDSd7+lt7MtOsunFTzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cBK6M5wpneLJr1uWC+/StQD7IqqKAN7DRIj1SWIKUWVUnejS2mzHYAdjzf9P/3y4I
	 TH9ZCZT/NJ0Uyown/264wsrmBxn3RhhP1jR8Aehrk+VAMLgA9m5ybpey6ucd6kTtnr
	 fom0KLvKpLJdF2jYajNnRus+nMDBG5rUq2H5E2DqV0IYPr/XtsrLxVgCRBLHHYwFJO
	 Mp7CoHjRjRoQ9Ai8aqb01o63pZgatUtdoO8c0wL9dT3V5wM6ev420H32toMB0oJBYb
	 T9hLQ3lt/cVeAnqfF9t0DeeHsPnkXlhH3m1nYi6n/9811nya9G5Wru5OD3ml2XCs5C
	 el5wOlQe+Y2uA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/18] tracing/remotes: Add poll_ms tracefs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812161340.2417322-16-vdonnefort@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-16-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:13:04 +0000
Message-Id: <20260812171304.A47D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Data race on `remote->poll_ms` due to lockless reads.
- [Low] Improper mixing of goto-based error handling and scope-based cleanu=
p (__free) in `trace_remote_iter`.
--

--- Patch [15]: [PATCH v5 15/18] tracing/remotes: Add poll_ms tracefs file =
---
commit a661ee191c6d806ed0a716f67237aca890febe25
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Add poll_ms tracefs file

Add a tracefs file to configure the trace remote polling period. Keep
the default value to 100ms.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 5536e0df43795..b1c75666ab638 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c
> @@ -1135,6 +1135,40 @@ static int dump_on_panic_show(struct seq_file *s, =
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
> +	remote->poll_ms =3D val;
> +
> +	return cnt;
> +}
> +
> +static int poll_ms_show(struct seq_file *s, void *unused)
> +{
> +	struct trace_remote *remote =3D s->private;
> +
> +	seq_printf(s, "%u\n", remote->poll_ms);

[Severity: Low]
Does this code introduce a data race on remote->poll_ms?

In poll_ms_write(), remote->poll_ms is modified while holding remote->lock.
However, in poll_ms_show(), remote->poll_ms is read without holding
remote->lock.

It appears this could also cause a data race with lockless reads in
trace_remote_do_poll():

kernel/trace/trace_remote.c:trace_remote_do_poll() {
    ...
	schedule_delayed_work(&remote->poll_work, yield ? 0 : msecs_to_jiffies(rem=
ote->poll_ms));
}

Could this concurrent read and write cause a data race, potentially leading
to torn reads or violating kernel concurrency expectations?

[ ... ]

Also, looking at trace_remote_iter() in kernel/trace/trace_remote.c:

kernel/trace/trace_remote.c:trace_remote_iter() {
	struct trace_remote_iterator *iter __free(kfree) =3D kzalloc_obj(*iter);
    ...
		if (WARN_ON_ONCE(remote->dmesg)) {
			ret =3D -EBUSY;
			goto err;
		}
    ...
err:
	switch (type) {
	case TRI_PANIC:
		break;
	default:
		trace_remote_put(remote);
	}
	return ERR_PTR(ret);
}

[Severity: Low]
Does this code incorrectly mix goto-based error handling and scope-based
cleanup (__free)?

The cleanup subsystem guidelines prohibit mixing goto-based error paths
with __free() variable declarations in the same function. While it does not
appear to cause a concrete resource leak or double-free in this specific
instance, could this create confusing ownership semantics and risk future
bugs during refactoring?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812161340.2417=
322-1-vdonnefort@google.com?part=3D15
