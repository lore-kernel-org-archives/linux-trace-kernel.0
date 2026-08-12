Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF84307AB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552980; cv=none; b=YYLA4y8/G7L5AAyh06GVsuuPMIu9TrXjKvrs1H04mrGgGHtmDSIhBr7hzCbBiZ4yt+5gOt/I/YphAXU2T0wSEB7YYohhLw23scqvaVrm4Rsk/08v1l1UMJDJ+6GqmEVhBteX4+g/b1PeE+4OMRf+ydDs39rH/bPqD0lOhxsxADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552980; c=relaxed/simple;
	bh=C+qNAXA9bYU10bW+UFNGB26HVdtyRKdW00lM2XZ95fY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cag/AtRlK5ElWY187Rdchp56hd3czuVo1jZO1qMIjPUfTpmcMLEhwo1NG7CzWdfJHlIkqygls0HSMU29MJhRg+3Sb6VleNAp3+7HF8C4ug6DsPytmcHGgOx4hPLGExFPsx0me8MoD7QvlGIiX7w3d8+dy3Oc37HGsUnNCuae6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/sM7fWt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/sM7fWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3A31F000E9;
	Wed, 12 Aug 2026 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552977;
	bh=IZUXVdiXa+CJhkmTKFQU36oSazg4+DU+q0KcMqcm4jc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i/sM7fWtRiUvvnGczpIJWZXH9cdNJHdxr0xFjYhJmKDGjkCMuopPgVMI6qBY/fGdH
	 Vq8WvvXIlODGhJOxYyHrI/umuJV84xxI1Wrqjf6t6dI/VHtJzQ7oby/z5qrjaAX32t
	 SJSOCGu42UTPs4F0pGWEyNEWNTKuilUmf6ZNi3bw9JEWvHet6XE/lQ7DphJwSloSHS
	 h5SFNyn4xJy6/JPWW4GzUELacVUvJaTuZxxIIDZjNmmcT6vCx+vpq3E0/+qJIpQNMY
	 K8Lp06G8sy4scGeCvT2mrV+WY7HykdGgcw6jUae2kAMNayueZEPZjUIcTtrQtXreM9
	 fKBQXLJ5TaIsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/18] tracing/remotes: Add dmesg tracefs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812161340.2417322-7-vdonnefort@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-7-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:42:57 +0000
Message-Id: <20260812164257.AD3A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] When CONFIG_PRINTK is disabled, dmesg redirection stalls the eve=
nt iterator perpetually because `pr_info` returns 0.
--

--- Patch [6]: [PATCH v5 06/18] tracing/remotes: Add dmesg tracefs file ---
commit b41c280df86084ff7600dad9b61a6fa3dbbdf1dd
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Add dmesg tracefs file

When enabled, the dmesg tracefs file enables the redirection of all
events to dmesg. This is similar to tp_printk.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 1fbe2f3f20e99..3a5e0d84c1722 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c

[ ... ]

> @@ -882,6 +908,87 @@ static const struct file_operations trace_fops =3D {
>  	.release	=3D trace_release,
>  };
> =20
> +static bool trace_remote_do_dmesg(struct trace_remote *remote)
> +{
> +	struct trace_remote_iterator *iter =3D smp_load_acquire(&remote->dmesg);
> +	unsigned int max_events =3D 1000;
> +
> +	if (!iter)
> +		return false;
> +
> +	trace_remote_iter_read_start(iter);
> +
> +	while (trace_remote_iter_read_event(iter)) {
> +		trace_seq_init(&iter->seq);
> +
> +		trace_remote_iter_print_event(iter);
> +		trace_seq_putc(&iter->seq, 0);
> +		if (!pr_info("%s", seq_buf_str(&iter->seq.seq)))
> +			break;

[Severity: Medium]
When CONFIG_PRINTK is disabled, pr_info() is defined as no_printk, which
unconditionally returns 0. Does this cause the loop to always break early
and skip the call to trace_remote_iter_move() below?

If so, it appears the background polling work would continually fail to dra=
in
the trace remote buffer and run periodically without doing any work, as the
iterator never advances.

> +
> +		trace_remote_iter_move(iter);
> +
> +		if (!(--max_events))
> +			break;
> +	}
> +
> +	trace_remote_iter_read_finished(iter);
> +
> +	return !max_events;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812161340.2417=
322-1-vdonnefort@google.com?part=3D6
