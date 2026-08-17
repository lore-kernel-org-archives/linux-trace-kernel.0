Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AB63EB0EF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975745; cv=none; b=GBX+i9LST/a1BcLrO8ccxzdiBsP8TJx0Hizn7JEIziZp7uULxDBPhsqpck+oayyFZYF6ftKqCcYxCgBb6+T0EtRS2FcMTLtfBZ4ZycuMzcAqeer55hGdEjzc+m+X6szprfy0fa8uwq4nCnQxh/Qxk4oeIOvu9kHs7a3KS8Ao2ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975745; c=relaxed/simple;
	bh=YzXGa97lpBAxqMutZwJoesyvxh8CSYjHE958VcnJzIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R7NioxldckhqsBgdqC9s9n2B+8PwOnxZLzsMG6jgfG2/enNNGMuXZG7sYoYCdhyAh8UUuP7DnsFLRfZiryy+MYbVcnRI5xpH+SNKLNMYX5JB+yvNbSj5X+Ug8/SAm5NNV9wpq0DWS8pKWUey4oVrSaF5eyxFcwNT2161zQ+W8bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaDFU+SA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaDFU+SA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDFB1F00A3F;
	Mon, 17 Aug 2026 14:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975743;
	bh=fqQDc+dEyDSRlNZkQ6+0SMc7D+C28h+ppEwYMP7rCLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EaDFU+SAa2asbT9h+yJGfyMuBKnSR8YCOW+1AOkGVXztkw2adKniV36ejsjJoqbcm
	 pmlyUMSwU9OdCss804asi+omgXc/egS31DhpRqo5ACoa3YDWR95onN6P6qoZg2OmsZ
	 To5cMQT69TrKVyvMIC+kVxz2giElEFMbiVggAZUvUz+5XSyzotoh/o6k4vAa1pFTPN
	 7rIxTxUVAp4B9EK2jxIX0wild7ALAAs14GAuL1nVLosVdy41k31wGiY9cBLKox/s6+
	 ehCJCPxvN7hH+Beyb2GQa0nXkPh77dRp7V2LGdjrYN5jxSAZZ7y2ylMHNbKbsqm8QA
	 8fcRU1kPM151Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/18] tracing/remotes: Add dmesg tracefs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260817135517.3919534-7-vdonnefort@google.com>
References: <20260817135517.3919534-1-vdonnefort@google.com>
 <20260817135517.3919534-7-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:09:03 +0000
Message-Id: <20260817140903.9BDFB1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Infinite loop/stuck iterator in `trace_remote_do_dmesg()` when `=
CONFIG_PRINTK` is disabled.
--

--- Patch [6]: [PATCH v6 06/18] tracing/remotes: Add dmesg tracefs file ---
commit dcbacd33ccf7193b3ba94b1298b0c78d75002d92
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
Does this cause an infinite loop if CONFIG_PRINTK is disabled?

When CONFIG_PRINTK is not set, pr_info() evaluates to 0. If that happens,
!pr_info() will always evaluate to true, causing the loop to break early
before trace_remote_iter_move() is called.=20

Could this leave the iterator stuck on the same event indefinitely during
the next polling intervals?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817135517.3919=
534-1-vdonnefort@google.com?part=3D6
