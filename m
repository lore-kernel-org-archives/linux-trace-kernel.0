Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795666231;
	b=uHsHrQeWWyawhit5ZSTLDaUYFUXyc8DG+sSW98+odiZ1PaaXhqgTRPnwTSqsxRGU+zx7
	 zs1cdKLL8bE54xgGXi50yJVisfxbEv8nJQzSdeR8EET1CTAFceYdJXpfRzLTlJSUdrGjL
	 D4HJ+jsaKwUZmBDPYoQKheusAWkTG/gYTkIj3+gf+Bi3WN9THpoWyiyGxok2A0zo4fDM4
	 V7fxh2o4AYxhfvgLtvcs6qnkSGwi7WzQeNXP/JLYSqSC7rEbEkmMllHPWEfGa/Q7lCJXY
	 vuezCqy5h1YJr0RYaDYQ0+KlCZ1YdZeEK+rdpFy18bhgnhkboV7G+agOnIdDhjFXcmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795666231;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F7rL/XEnYwwNz78cfW4sDwD/+cBz+WFmrg/6daX0krU=;
	b=G0oCbTT1i7/bl4c4iUQmBO7cKlBWHDUUH+NCFpSo7Xmo12C7TQ08v7snLy7eiK+j35I3
	 zNZE+h0z7wYrZkK4G7ttQFkBKLV0Mz0tWSHe/D972VuZuV6PBwHnRYGqEpSvp5p5hZmMr
	 9sp6flgeTnstd0occdsWY25p7ah21I9IGwT6CycucfZ3bMS3mzSFOr7i/RErmimQuDkMZ
	 8tx63Xsoy6AEqYyRv0s2ZwxS918gNmP9AQ1O3Eb9Jb8OU6/etMjI1oZXgceSY3VA++IZI
	 Pe0wvVsIfRru5KMT8OrIc8taat8dcrQKP3c5KNG1azNwYdH8SmKxFFxXfiPM0t9BreA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mM2zdfZZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695FA606A31C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mM2zdfZZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D582F1F000C6;
	Thu, 26 Nov 2026 04:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795666231;
	bh=F7rL/XEnYwwNz78cfW4sDwD/+cBz+WFmrg/6daX0krU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mM2zdfZZgGPNUQ1VN51MWsHQSyZFwLn0mmDFh3avnqma+cQUS8mX3eaGt3/JnjyWV
	 wBQRGYHwxqq9r/UthPEdm3DE64agqopC6YzJ3allWZZe+lS7VbMdZjIfVWG3wTTsx5
	 0d1ElZNw2rRwrPXZ/RCwYXdtza1jz/xcbaxTCuUvTm4rz0Qj+EC6zvVNSM+FNnhnH4
	 Is41+GfJyiwNPa/H4XpRpFA1SjvmzRrKfGB64TvGaWzR2BLt4BFWlZCX9JK5HaFL6f
	 vJrpSG6lLJemhqtXwOFpK22NEm/Ob+QcdIWq1DfWh8QiYvrwcpZw2QaK5lKV+VFolQ
	 DtZjAdIPrXQcw==
Message-ID: <sashiko-outbox-234724@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing/synthetic: bound dynamic string and stack
 stores to reserved size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dominik Maier" <dmnk@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261126035553.406453-1-dmnk@google.com>
References: <20261126035553.406453-1-dmnk@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 04:10:30 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] tracing/synthetic: unclamped stack frame count in
  trace_stack() causes OOB read
--

commit 1ad0830d62adf86896f0b684ccf1009777546151
Author: Dominik Maier <dmnk@google.com>

tracing/synthetic: bound dynamic string and stack stores to reserved size

This commit passes the remaining reserved dynamic buffer budget into
trace_string() and trace_stack() so that concurrent updates to histogram
variable buffers cannot write past the reserved ring-buffer or perf-buffer
entry.

> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_event=
s_synth.c
> index 8492a5f285c4e..ccec67813e41f 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
[ ... ]
> @@ -479,6 +492,7 @@ static unsigned int trace_stack(struct synth_trace_ev=
ent *entry,
>  				 struct synth_event *event,
>  				 long *stack,
>  				 unsigned int data_size,
> +				 unsigned int maxlen,
>  				 unsigned int *n_u64)
>  {
>  	union trace_synth_field *data =3D &entry->fields[*n_u64];
> @@ -489,16 +503,13 @@ static unsigned int trace_stack(struct synth_trace_=
event *entry,
>  	data_offset =3D struct_size(entry, fields, event->n_u64);
>  	data_offset +=3D data_size;
> =20
> -	for (len =3D 0; len < HIST_STACKTRACE_DEPTH; len++) {
> -		if (!stack[len])
> -			break;
> -	}
> -
> -	len *=3D sizeof(long);
> +	len =3D min_t(unsigned int, synth_stack_size(stack),
> +		    rounddown(maxlen, sizeof(long)));
> =20
>  	/* Find the dynamic section to copy the stack into. */
>  	data_loc =3D (void *)entry + data_offset;
> -	memcpy(data_loc, stack, len);
> +	if (len)
> +		memcpy(data_loc, stack, len);

[Severity: Medium]
When len is clamped by rounddown(maxlen, sizeof(long)), or when len is 0,
can a histogram trigger keying on this synthetic event's stacktrace field
read past the end of the reserved ring-buffer entry?

If another CPU grows stack[] or an earlier dynamic string field between
get_field_size() and trace_stack(), memcpy() copies the truncated slice
with the original frame count in ((unsigned long *)data_loc)[0] (or leaves
data_loc unwritten at the end of the entry when len =3D=3D 0).  A histogram
trigger on the synthetic event reads that field through hist_field_stack(),
which uses only the 16-bit offset and ignores data->as_dynamic.len:

kernel/trace/trace_events_hist.c:hist_field_stack() {
	u32 str_item =3D *(u32 *)(event + hist_field->field->offset);
	int str_loc =3D str_item & 0xffff;
	char *addr =3D (char *)(event + str_loc);

	return (u64)(unsigned long)addr;
}

kernel/trace/trace_events_hist.c:event_hist_trigger() {
    ...
			if (key_field->field) {
				unsigned long *stack, n_entries;

				field_contents =3D hist_fn_call(key_field, elt, buffer, rbe, rec);
				stack =3D (unsigned long *)(long)field_contents;
				n_entries =3D *stack;
				memcpy(entries, ++stack, n_entries * sizeof(unsigned long));
			}
    ...
}

event_hist_trigger() then copies n_entries frames from ++stack, reading
past the reserved entry and, if *stack is uninitialized or concurrently
corrupted, overflowing hist_pad->entries[HIST_STACKTRACE_DEPTH].  Clamping
((unsigned long *)data_loc)[0] to (len / sizeof(long)) - 1 when len > 0
and checking the dynamic length in hist_field_stack() would prevent this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126035553.4064=
53-1-dmnk@google.com?part=3D1
