Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE748F019
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262755; cv=none; b=Q7znLYkVt7hyeWCjZu+crsdEg2Flagq5Z6iPnHlTh4G+CySqxhXJkNLaopgOWc6Cw6T+g1Ak4zWQkJFB/use1x+z6kEjHCVuOF7yfa0ullN9EDHVDWSDN3TV7kD7PwFhPVV7TTz+P80+jFO9kps5u8plq36z1T+Ky0RJiVl0j+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262755; c=relaxed/simple;
	bh=hwkrq45WxUvULe3AVwUtyAVlm2nRIdbYVQHDrocmjg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HXTw2NH1LPVU61oHOwg+CcfizH2++Nw05zp1liHblYS6lESdHFMIDlgNbyusKB9384VV2QMjgNAA3xrS8PEbP8DUqztuUerDaKwc/4uO9DwZ7Dn2P3PxXclMyyOJGK4F3j5O7rdU//LD6/Aoh/kk8kQfcJHKkjM6wAG7xYF7nps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9wcabxt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9wcabxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D7B1F000FF;
	Thu, 24 Sep 2026 15:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790262752;
	bh=5IozuEqsZSN55EPkt+tazsJa9AnDq/Nm5aZWl15TKTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O9wcabxt1yjN9v7gE12dhbNXnt8aIIWhXsEqsflmov4n3l1cG5ISZvdgMAMNx4KdY
	 o2k/9E/nolYE0u/p3ufZohfu+0BAorcnxmDo0IXy84qjV9uLYSQDzU1m/6ikrLFb0Z
	 Ze8KWehXUBT+b+plshjbPTML3zUfN4Kg4wM1B7ir/u7yRWs3vx8kdZFzinQ2mJNiEA
	 YmrfJN9aauWfU0nPhme++mLcaFb7YYclTcXVn8nh0dlNnzDpwTpxD8cToY8PtmuITf
	 8umeXNMR6ExrPW1LHcMTyhMpQabeEUbEa8ZgEA8wSlCkdGZyHH7EoyapIYYfWOBovC
	 SL4t5FN3EXflQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/20] tracing/remotes: Add dmesg tracefs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260924145754.1285146-9-vdonnefort@google.com>
References: <20260924145754.1285146-1-vdonnefort@google.com>
 <20260924145754.1285146-9-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:12:32 +0000
Message-Id: <20260924151232.C0D7B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tracing: infinite polling loop when pr_info returns 0
--

commit 84b99572dcf19a3615c7c7c55a76f23735f8f5c9
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Add dmesg tracefs file

This commit introduces a dmesg tracefs file for the tracing remotes subsyst=
em.
When enabled, it redirects all events to dmesg, acting similarly to tp_prin=
tk.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c

[ ... ]

> @@ -883,6 +909,87 @@ static const struct file_operations trace_fops =3D {
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
What happens here in trace_remote_do_dmesg() if the kernel is compiled with
CONFIG_PRINTK disabled?

When CONFIG_PRINTK=3Dn, the pr_info() macro unconditionally returns 0. If
pr_info() returns 0, this loop breaks immediately before calling
trace_remote_iter_move() to consume the event.

Could this result in the same event being infinitely polled without making
progress, wedging the remote trace integration?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924145754.1285=
146-1-vdonnefort@google.com?part=3D8
