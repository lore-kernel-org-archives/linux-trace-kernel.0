Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795488673;
	b=YKJ9XX8ij6YB8q/YRVQVg3ZavhRTNBOnzpL5ijPfb2pUewVx2hdSRV//UOhPPanPJ9Kv
	 R5vHA/f0fBvn9AROu1ea4egsk1FqgdH+pHJMG2QowFbDlaTPioMVc5FvELvRPoMzZXII7
	 JtvrdGQhhH7Z5sUJams+EPkhw6KbvHy7BtLJ/PkiQix3XXyD+C96vWVsmJSRD16FkaMxD
	 6DaXOaj3F62dAogkDKoZopetLUZmk/ab50fg4gB7zpYJuRptC7dFo7OVZtkFZXmqBpDTJ
	 Q83vL7WNrPEzTGlOXRW4pX99POyvSVem3PR6y3KvBC95l2clVwE1h6SwAbSULhhJpTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795488673;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A74P9h6KzbRj5ORALzWFjjkL8QyFK60xcdooq8Itpvw=;
	b=uRzEdY1WVrtuR/m7IpXShD36jHXjF0/0kTDr6z2VyWdkcxBg29Y8rwTe5oYSwn0d4U/N
	 UWNtRdFd3yLUVAxzszQfkbN+Af3NOmhIANqQED3+KEKQbyhMi/cAiaYW5dZBYklV/94E2
	 mDWheGEVRHmGuPTFCzN3DBoyTr207MFwp0Kc+spejM9jPB6wURaPcDzgxP7KJkKMzSdzH
	 6yc3YlxtVUZi+JS6YsGuV+tSMcXy7ziMUYYgxkP2eH98M1yFG3dzdymkkONEwp1y2JpB7
	 6ieUaLqF/qpCY0OvH7Tfz0WW+beZp7wgkADfyVNiUv38CkpXzyAJ8BWEAxpNF2XZGeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UjiZhPnb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFF8606A31E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 02:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UjiZhPnb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA2F1F000C4;
	Tue, 24 Nov 2026 02:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795488672;
	bh=A74P9h6KzbRj5ORALzWFjjkL8QyFK60xcdooq8Itpvw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UjiZhPnbwvf61Vmt/reN/2Ki7q8akOMlGtcwhwLT+Ob94v76S1NABJpMqulLorWdu
	 ie97L4HnAGjSDoyrkslVWRpX4v/enz0zX3pTGYM+QPba/wzDCh/NiTk93PybULlLHl
	 Nax3SNlqulbAcztMfWmlhk2gJZWLT8VKlHujyJGgeuwBp61Gs5k3uk6BH6GA5tNOjz
	 oVdV8AeC5KLSAiY6UuF5d4PtwW07bjvGiOKt5WiBGDUKDsUeSEd9aCaD7wYerLSabt
	 iSW3DgilYpw9yzhhJGfh7a0dmYd31YS9vxxUPVDuT2RYBcKlDYPGWZ2w6fEymQeScG
	 xDAJ0YVsWNdVQ==
Message-ID: <sashiko-outbox-230424@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] tracing/probes: Zero out faulted dereferenced fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>, "Linux Trace Kernel" <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261123213246.00440bfc@gandalf.local.home>
References: <20261123213246.00440bfc@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 02:51:12 +0000
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
- [Medium] tracing/probes: do_probe_mem_read() dereferences NULL in
  stage 3
--

commit fd104aec084b16bdb5ef3c044c9c69e47141c17c
Author: Steven Rostedt <rostedt@goodmis.org>

tracing/probes: Zero out faulted dereferenced fields

This commit zeroes the destination buffer when probe memory reads or
dereferences fail or encounter NULL pointers during probe argument
fetching.

> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_t=
mpl.h
> index 8acc0f0ebd7a6..9672474b067b3 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
[ ... ]
> @@ -133,13 +135,63 @@ process_common_fetch_insn(struct fetch_insn *code, =
unsigned long *val)
>  	return 0;
>  }
> =20
> +/* On failure, zero out the destination */
> +static nokprobe_inline int
> +do_probe_mem_read_user(void *dest, void *src, size_t size)
> +{
> +	int ret;
> +
> +	ret =3D probe_mem_read_user(dest, src, size);
> +	if (ret < 0)
> +		memset(dest, 0, size);
> +	return ret;
> +}
> +
> +/* On failure, zero out the destination */
> +static nokprobe_inline int
> +do_probe_mem_read(void *dest, void *src, size_t size)
> +{
> +	int ret;
> +
> +	ret =3D probe_mem_read(dest, src, size);
> +	if (ret < 0)
> +		memset(dest, 0, size);
> +	return ret;
> +}
[ ... ]
> @@ -193,27 +256,30 @@ process_fetch_insn_bottom(struct fetch_insn *code, =
unsigned long val,
>  		}
>  	}
> =20
> +	/* When val is NULL, so should the val + offset */
> +	offset =3D val ? code->offset : 0;
> +
>  	switch (code->op) {
>  	case FETCH_OP_ST_RAW:
>  		fetch_store_raw(val, code, dest);
>  		break;
>  	case FETCH_OP_ST_MEM:
> -		probe_mem_read(dest, (void *)val + code->offset, code->size);
> +		do_probe_mem_read(dest, (void *)val + offset, code->size);
>  		break;
>  	case FETCH_OP_ST_UMEM:
> -		probe_mem_read_user(dest, (void *)val + code->offset, code->size);
> +		do_probe_mem_read_user(dest, (void *)val + offset, code->size);
>  		break;

[Severity: Medium]
Should do_probe_mem_read() and do_probe_mem_read_user() check for a NULL
src before calling probe_mem_read() and probe_mem_read_user()?

When val is 0 in stage 3 (for example, when prev->mm is NULL in
prev->mm->pgd, where finalize_fetch_insn() turns the final dereference
into FETCH_OP_ST_MEM), offset is set to 0 and (void *)val + offset passes
NULL as src to do_probe_mem_read() or do_probe_mem_read_user().

Because neither helper checks for !src, every NULL pointer hit attempts a
real memory read at virtual address 0x0, raising a hardware page fault on
every event when page 0 is unmapped.  If address 0x0 is readable, the
read succeeds instead of zeroing dest: on s390 it copies kernel lowcore
bytes from 0x0, and on CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
architectures probe_mem_read() sees (unsigned long)src < TASK_SIZE and
reads user-space address 0x0 if mapped:

kernel/trace/trace_probe_kernel.h:probe_mem_read() {
#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
	if ((unsigned long)src < TASK_SIZE)
		return probe_mem_read_user(dest, src, size);
#endif
	return copy_from_kernel_nofault(dest, src, size);
}

Also, in process_fetch_insn_bottom(), offset =3D val ? code->offset : 0 is
computed twice in stage 3, and in stage 2 offset is only used inside
if (val) blocks where code->offset can be used directly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123213246.0044=
0bfc@gandalf.local.home?part=3D1
