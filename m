Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929F3A7582
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332082; cv=none; b=Gv2z96zkqyHNCMGHh+rEoUjZeBxk9HEhEuuV5U0XxZ3NFAHKDFQ9UX+X0ved9krumQgoNRa/zrhw0BCOk+G9nIhrHX8nSxrWPFvLeNrFfN49V5VCXqolplS4AqptvxusDLdlWZP3EnqESFkwaOvP3iTUNyLEe2KATHhw0y1Qmnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332082; c=relaxed/simple;
	bh=fXTxUwCZmJVFYi1J/6EVeYQIBefr2h4jUxSj4cAjYqE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BgL9Fcs0NDXyI1bb7trYW+e7CBxbJ9jHv1V6DAhFVLfPd0YaCGlshph5YpfYKtpNVu5RbK4LyTWC+8TG90WLJszYZnqe/ktJBn2NSKxoSGju7T8DPiBmTWLVNwrauXWqAeywxeGO1MHxeIUUhu7reBOEuUj6gPGNaYE2jNXPt0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqN3ChIs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqN3ChIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6361F000E9;
	Wed,  2 Sep 2026 06:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788332073;
	bh=7tmJ4U03EeRZVvhwOsz7+KPAkmPYXZfdSxFSf6DpQHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hqN3ChIsL0kDL1/VAD+ZBFFENSdZ6iRmwwAsmlcQRv+ZhaXL7qy53jK3TM2PyMi+N
	 hKSgAklCkcAh2gfR8hxNtLOHYYu91S0JLawEDiDpzCHT640OeQo8s0X9tnGsZc3gR7
	 yIARpFa2m9nYN2L4H8lQQIdonh0vX55czrRnA9QmHpvet71asrXhXzld6YhOfEbiWt
	 uvZVprPJ4XeNaZsbl8B+BbytctT75xVW9tnIiOUDwxrWp/rt6Ulsmm+XjIwHBGS7+C
	 DVLl2vIlDc+a4uDz+SiYKMudDC5OCb8tRCUtPnx89X1KiLhEwpxq94gkgNgSuRrXXa
	 ckwyeNhOollwA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 2/3] trace: integrate stackmap into ftrace stack
 recording path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Pengfei" <ljdlns1987@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260902064242.28606-3-lipengfei28@xiaomi.com>
References: <20260902064242.28606-1-lipengfei28@xiaomi.com>
 <20260902064242.28606-3-lipengfei28@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:54:32 +0000
Message-Id: <20260902065433.2D6361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Commit message claims ring buffer is reset, but code explicitly =
avoids it, leaving an unused exported function.
--

commit 1c84dfe93f15f95df9476204e9b82e02328ae613
Author: Pengfei Li <lipengfei28@xiaomi.com>

trace: integrate stackmap into ftrace stack recording path

Add TRACE_STACK_ID event type and integrate ftrace_stackmap into
__ftrace_trace_stack(). When the 'stackmap' trace option is enabled,
the stack recording path stores a 4-byte stack_id in the ring buffer
instead of the full stack trace.

>     - ftrace_stackmap_create() takes the owning trace_array so the
>       stackmap can later clear that trace_array's buffers during reset.

[Severity: Medium]
The commit message claims that the stackmap clears the trace_array's buffers
during reset, but the actual stackmap implementation avoids doing this.

Could the commit message be updated to reflect that the buffers are not
cleared?

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 18710c190c924..0210dc597f77d 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
[ ... ]
> @@ -1562,7 +1564,7 @@ void tracing_reset_online_cpus(struct array_buffer =
*buf)
>  	ring_buffer_record_enable(buffer);
>  }
> =20
> -static void tracing_reset_all_cpus(struct array_buffer *buf)
> +void tracing_reset_all_cpus(struct array_buffer *buf)
>  {
>  	struct trace_buffer *buffer =3D buf->buffer;
> =20
[ ... ]
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 80fe152af1dd8..95db43bfc747a 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
[ ... ]
> @@ -689,6 +695,7 @@ extern int tracing_disabled;
>  int tracer_init(struct tracer *t, struct trace_array *tr);
>  int tracing_is_enabled(void);
>  void tracing_reset_online_cpus(struct array_buffer *buf);
> +void tracing_reset_all_cpus(struct array_buffer *buf);
>  void tracing_reset_all_online_cpus(void);

[Severity: Medium]
Does this code unnecessarily export tracing_reset_all_cpus() outside of
trace.c?

Since the stackmap reset functionality does not actually clear the ring
buffers, it seems this function is left completely unused externally.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902064242.2860=
6-1-lipengfei28@xiaomi.com?part=3D2
