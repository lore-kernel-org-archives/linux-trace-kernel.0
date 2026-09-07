Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31ED48F847
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786084; cv=none; b=ObQ0I8R2GIEGnNVJ2XniAvOJApAJaa566kzPjujJeZ1/n4mM+E5lVCtK8UQNXarumjJPnjWFpiC9w0P3crX+vb6app2HR6Ok2Z9PmSBN024hzw50ARcpxpjBoagRdLJ9V/4bbdTNfuxcusZcsf2SUHw+qwLJR3deNgXxPHSZ7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786084; c=relaxed/simple;
	bh=I3px2uWCARHJEeEsULck9JQFo8jQOGi3pJH0y+eroZw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o/6co3hXD7dHWPuVx/KQy1M/AdeqdPx3L/CrQxvHy9XEUVLx8UoB064bGIKits0Vkx6kFIRT9QetU2BshPw52ZIdSTgNCZdEWyavH0xeuArXdXKuofyYpVDHKlqCj/IlFPcVQjPxlPKkdaKoxlNvic2drWbLH7Ry/JLX+gT96b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAmRMePr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAmRMePr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DD51F00A3D;
	Mon,  7 Sep 2026 13:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788786065;
	bh=bKsBDzcZ3xNmPlXJCmaZyZaVBKlWkNcBMr3dRjyIs0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MAmRMePrNcCy+7g0DhoTpwCAWEdQnwLrKGtHwXdG2GCb1lnnE1bNVrdKwxoJRnp/k
	 0QaHVOWx73aZXg2uJ0nH8EtS8yhAqG8YJw902JhirAHxyNlt1jq2Ng7AOljkni/M7A
	 PmUUGUqvqWmPL6zpQYTOPDC3c15GVUPTy9WJbJH6Z0BHHsl5krfX07/DB5J2m5RG9z
	 BVesKhj60PfAm8IqZwFNVrD6vWm0LOr9sz7oIi52m8oZgHJODgwTRQ+uk2vwZ1/+Bv
	 GFJ+F37iPVg1S/oK0fjZdA2l+2Ox1jOckEIPGsdQ/bw5PL7fd4VOJoBFBmAQoTiPCB
	 HR3RxkvW5JLwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] tracing: hist: undo the registration when enabling
 the trigger fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260907124420.607097-3-donggeunyoo.kernel@gmail.com>
References: <20260907124420.607097-1-donggeunyoo.kernel@gmail.com>
 <20260907124420.607097-3-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 13:01:05 +0000
Message-Id: <20260907130105.94DD51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup in hist_register_trigger() on error path leads to =
UAF on named_triggers and memory leaks.
--

commit 49cdf06bdd569065174c429403dc447ea4cdf44e
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

tracing: hist: undo the registration when enabling the trigger fails

This commit fixes a use-after-free issue when a trigger fails to enable in
hist_trigger_enable(). It ensures that if
trace_event_trigger_enable_disable() fails, hist_unregister_trigger() will
properly undo the registration, preventing the trigger from being freed
while still on the named_triggers list.

Closes: https://lore.kernel.org/linux-trace-kernel/20260907092944.3950E1F00=
A3D@smtp.kernel.org/

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index c6c04926bdf0c..1de224a5a2bba 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
[ ... ]
> @@ -6972,6 +6973,8 @@ static int event_hist_trigger_parse(struct event_co=
mmand *cmd_ops,
>  	return ret;
>   out_unreg:
>  	event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
> +	/* The unregister frees trigger_data, skip out_free */
> +	goto out;
>   out_free:

[Severity: High]
This is a pre-existing issue, but missing cleanup in the error path before
this label can lead to a use-after-free on the global named_triggers list.

When hist_register_trigger() fails after successfully executing
data->cmd_ops->init(data), it returns a negative error code without undoing
the initialization. For instance, if tracing_set_clock() fails due to an
invalid clock name:

kernel/trace/trace_events_hist.c:hist_register_trigger() {
    ...
		ret =3D tracing_set_clock(file->tr, hist_data->attrs->clock);
		if (ret) {
			hist_err(tr, HIST_ERR_SET_CLOCK_FAIL, errpos(clock));
			goto out;
		}
    ...
}

The caller event_hist_trigger_parse() handles this error from
event_trigger_register() by jumping to out_free:

kernel/trace/trace_events_hist.c:event_hist_trigger_parse() {
    ...
	ret =3D event_trigger_register(cmd_ops, file, glob, trigger_data);
	if (ret < 0)
		goto out_free;
    ...
}

Since trigger_data_free(trigger_data) is called unconditionally under
out_free, it frees the memory while it remains linked in named_triggers.
Could this missing cleanup cause memory corruption or a kernel panic on
subsequent list traversals?

>  	remove_hist_vars(hist_data);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907124420.6070=
97-1-donggeunyoo.kernel@gmail.com?part=3D2
