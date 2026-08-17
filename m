Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF14315F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976486; cv=none; b=OZ02imO6kAbDOvrUBW4kDnmnydzF4Z5TtLlWya+nHHFgFHfMBpgnNyuuavOJp5R3K7n/U9/hadEsDKi1E2czT8P6YLtJVi+yqW1jB0mbr4rZfx22EFbLrPisHjQ9esAIO7TLTYua8+QeIPZp+sttdTH2jBhBWMrbN7hknAUmdj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976486; c=relaxed/simple;
	bh=2wVzuKQIfFaM2o8iqB8BCkypOeL9jjw6g0xKHHtEcyg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LGwb/vgNyJj4DoPKg8jdBLEPNxE7rcFjO7Qlxif8/5iSLBWGvGuZ117mmKr/KIoiGWKrrjwlyk74sswUFNp/Wp4H8fqKBmy1AwmKv3h3AslRwcr/To/C3cmhflO7SFenafeueQQ3LmJGNL46ee6UT+f9l/0q8frvpP1b3i0DoF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaMy+pDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaMy+pDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB481F00A3A;
	Mon, 17 Aug 2026 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786976485;
	bh=38L4AM1YfReQXprbVyvhlpvpQFENmg69BhVp9vaDxek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YaMy+pDkn/NHPZeHFbqQTRr2e2frdPBKyCQNM5f9psTtdWvpBPs5qe+oqsue1pyL6
	 L3r11rNV4JIKkTxOAZQAUhrqhWe8jor19tdfpmL5H/4FQ7AZIWR/fwNf186vsFxI5i
	 R6Vrj0MvUUjdIRF0zB7Ip2vddvJ2D8maIAqqjVyB1rdoJnO9j8YL7eR5p9q7rGqKsV
	 9Arn+6EnUXbtaCPnKPMYCFrXgejP9K+yN7vCXb3q9HoeXW3Pz0hPnuIfSHY0Dhg5Rf
	 6n9MbOcRkosbnqzTgVXLiC65soSpAy1wDhKgfIhMy0RTYG/fy8LIjR8s6Xu5/HBTh0
	 OVRnFFCnNPoJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 18/18] Documentation/kernel-parameters: Add
 trace_remote
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260817135517.3919534-19-vdonnefort@google.com>
References: <20260817135517.3919534-1-vdonnefort@google.com>
 <20260817135517.3919534-19-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:21:24 +0000
Message-Id: <20260817142125.0FB481F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The `dump_on_panic` command-line option silently fails to regist=
er the panic handler if the remote buffer was already loaded by a preceding=
 parameter.

Pre-existing issues:
- [High] `trace_pipe_read` loops infinitely inside the kernel if an event c=
annot fit into the trace_seq buffer.
--

--- Patch [18]: [PATCH v6 18/18] Documentation/kernel-parameters: Add trace=
_remote ---
commit fb8043141866facf6319346314d1e6305e601a6e
Author: Vincent Donnefort <vdonnefort@google.com>

Documentation/kernel-parameters: Add trace_remote

The trace_remote parameter allows configuring a trace remote on
registration. The syntax is similar to trace_instance.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index e6724f947170d..34847463d9e43 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c

[ ... ]

> +static void trace_remote_apply_cmdline_opts(struct trace_remote *remote,=
 char *cmdline)
> +{
> +	bool dmesg_on =3D false;
> +	char *opt;
> +	int ret;
> +
> +	while ((opt =3D strsep(&cmdline, "^"))) {
> +		if (!*opt)
> +			continue;
> +
> +		if (!strcmp(opt, "dump_on_panic")) {
> +			remote->panic_on =3D true;
> +		} else if (!strcmp(opt, "dmesg")) {

[Severity: Medium]
If the remote buffer was already loaded by a preceding parameter on the
command line (e.g., via an earlier trace_remote=3D that specified dmesg or
enabled an event), does setting remote->panic_on =3D true here silently fai=
l to
register the panic handler?

This differs from the tracefs write paths which dynamically register the pa=
nic
handler if the remote is already loaded. Could this cause the request to du=
mp
the trace buffer on panic to be silently ignored despite the configuration
reporting it as enabled?

[ ... ]

kernel/trace/trace_remote.c:trace_pipe_read() {
    ...
	while (trace_remote_iter_read_event(iter)) {
		int prev_len =3D iter->seq.seq.len;

		if (trace_remote_iter_print_event(iter)) {
			iter->seq.seq.len =3D prev_len;
			break;
		}

		trace_remote_iter_move(iter);
	}
    ...
}

[Severity: High]
This is a pre-existing issue, but if a trace remote generates an oversized
event whose formatted string exceeds PAGE_SIZE, trace_remote_iter_print_eve=
nt()
returns -EOVERFLOW and the loop breaks without calling trace_remote_iter_mo=
ve().

Since the unconsumed oversized event remains in the ring buffer, will
ring_buffer_wait() return immediately on the next read, causing the task to
re-read the same event, fail to print it, break, and repeat infinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817135517.3919=
534-1-vdonnefort@google.com?part=3D18
