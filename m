Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1CE42D763
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975882; cv=none; b=WIZtDNICAt9X701gWKxg38bCDowsNbeJEoQH/lHNXlCARe//eNuq23SXzUjrCOPUbkdbRkMg/V3abaJKoi/Du3BJtauF0znhyErchtOqqVZSK46d1k3w6p/Jzvu+gvKAXqwm+jek83eHmsdovxtZ9gY2vfR8ZhR7FD0gAeXkt4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975882; c=relaxed/simple;
	bh=MHhlZFgVLZYXHNvalo0uPsv5EsSy6NuVh36akjQjOos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b/5f1k8bVSkI/NuAKbZkeFE21OlIr+ZKHKi94DL6MbnCtEk19Nb8BJoytglVViM4XPgkejoU+mwiRD0xr4D+62STWMus7E5BDZWdraZvNFyDapEga+A8y30Z4Rdg95yKH1Qqg2wlkS1OW/JV/z3D2Op337CPIDY/yWUb+y1jUlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fORXKYF2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fORXKYF2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E401F000E9;
	Mon, 17 Aug 2026 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975881;
	bh=AQEKOg1FDKffXbaVyzI4gX3xJFJXBNOFfNZReEP3AhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fORXKYF20MuTHPc9yz1kXoPNUh2I9b2E9pS6w5myu6TjblGTZQr8/+MpBvDcJ08SP
	 zU1HDtHcwc/NGksFTaMVN/wSSheu4lyHORoRYeDHKuoSz+VYMDtQtzPje7ZfIqT8OO
	 Pj+xdwE7WkF+GOQH0X5F9acD6cPSUrPybmgVj75+OKY9XeB476PQJW8UIk1RxpbAuI
	 bm8SyLlRopWHxLpYayyylgIKKL15uT2WiDpj3gt/igkVK8tiVvAVAKm4Ttobnmc6vm
	 QXNsQJJ1Tz1GTWivr3BmBpEKW2kXS1peKOBByL7ssj2ptzIkDKrrjYrEzGQCsU8XGV
	 JEu967ldKiP6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/18] tracing/remotes: Use kstrtobool for boolean
 tracefs files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260817135517.3919534-4-vdonnefort@google.com>
References: <20260817135517.3919534-1-vdonnefort@google.com>
 <20260817135517.3919534-4-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:11:20 +0000
Message-Id: <20260817141120.E9E401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kernel infinite loop when reading an oversized trace event from th=
e `trace_pipe` file.
--

--- Patch [3]: [PATCH v6 03/18] tracing/remotes: Use kstrtobool for boolean=
 tracefs files ---
commit 2c1ad77f49e430730de7a438ec955b0c042628e4
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Use kstrtobool for boolean tracefs files
   =20
Use kstrtobool in trace_remote.c where possible. This is more user-friendly
as it allows a better variety of input strings.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 0384277070b9e..0e4d41a93a7ce 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c
> @@ -235,10 +235,10 @@ tracing_on_write(struct file *filp, const char __us=
er *ubuf, size_t cnt, loff_t
>  {
>  	struct seq_file *seq =3D filp->private_data;
>  	struct trace_remote *remote =3D seq->private;
> -	unsigned long val;
> +	bool val;
>  	int ret;
> =20
> -	ret =3D kstrtoul_from_user(ubuf, cnt, 10, &val);
> +	ret =3D kstrtobool_from_user(ubuf, cnt, &val);
>  	if (ret)
>  		return ret;
> =20

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
regression in trace_pipe_read() when handling oversized trace events:

	while (trace_remote_iter_read_event(iter)) {
		int prev_len =3D iter->seq.seq.len;

		if (trace_remote_iter_print_event(iter)) {
			iter->seq.seq.len =3D prev_len;
			break;
		}

		trace_remote_iter_move(iter);
	}

When trace_remote_iter_print_event() fails on an oversized event and returns
-EOVERFLOW, the loop breaks before calling trace_remote_iter_move(). Does
this leave the unformatted event in the buffer?

If the event is left in the buffer and the sequence buffer is empty,
trace_seq_to_user() will return -EBUSY. The code then calls
ring_buffer_wait(), which would immediately return 0 because the event is
still in the ring buffer.

Could this cause a CPU lockup where the core infinitely reads the same
oversized event and fails to format it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817135517.3919=
534-1-vdonnefort@google.com?part=3D3
