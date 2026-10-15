Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340FB486430
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055702; cv=none; b=caQoDfcV++l7D+t76vBxNVdNJvyniZHsQiHAuiF4hNbIJygVzP0rkkz/h/y2UTS65CYmrYftKDG+zSnxUNhMtmFyk9AsMWNOybzCelhKOh+N3Amc81Ub8vH/DxNZY/OT5Ff2xgeZcGM9uLJ/fhZfUoxsgwwGDR740nh4kRqZjac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055702; c=relaxed/simple;
	bh=0132B7LGb3HiwNIjr35wD9w8AZxIM39Gsm6fo3MsvfM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PM/LM/qnk26RuKO7Nx70AgLi40rBXFoWIRpfoSraT1UNxb/1YA4XrknOHj1k0q71vzKg6jTxJiOCzFyC5kdL3nQ11VO3oZ6rVr53miN5/Vr+HDv5f0g/6/odE9Z7hSA+E1BKAG+XVA+4AYIb/qKiCQjc+kT/rpubbz8B9PIBjnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFzSt0eT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFzSt0eT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63A41F000C4;
	Thu, 15 Oct 2026 09:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792055696;
	bh=NI5yxjtswHkbQKevvBc0y/gM8BnyDpOI0nYqIugVNY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NFzSt0eToa2papXdNz93SGlRno0hJWhBPvHyPXVNv5JzcmqVGVeqBIlK/z6uzxX9N
	 kJGS8LpZSQFmdV9ze+N092mnOOEVTDhDOR25pybIwACc+UXMMN22CdH642/uQCT/3m
	 dysqaLZW7bPlNOi4fJ+Y0oArhlxxnN5eiaDZyJRFIrK+r89AHBHwu5TFivD0Mr4XWD
	 CE8GIEZVCKu/IV+O/uyzso8diQVjUGnKS5jrRMoSpST8MDr8u/qS0JFkmGPrzzpSwk
	 uPb+4jK1+QF3c5eXI6Kt/tdW2q7dqXSh7e/+b32zInrUmJM72T8RHtq959mgzPjozG
	 3YfxG4rBwaaMg==
Message-ID: <sashiko-outbox-172552@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: guard trace_event_get_offsets() against an
 empty fields list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoran Wang" <haoranwangsec@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <6ad09433.a938ce27.3282d8.5f98@mx.google.com>
References: <6ad09433.a938ce27.3282d8.5f98@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:14:55 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tracing: 0 bound rejects valid 32-bit BPF access to common_pid
--

commit 5b3e91afc57d96231d6f6b70552ed4d6b24e6d5c
Author: Haoran Wang <haoranwangsec@gmail.com>
Subject: tracing: guard trace_event_get_offsets() against an empty fields l=
ist

This commit adds a list_empty() check to trace_event_get_offsets() to preve=
nt
a wild pointer dereference when a tracepoint has no event-specific fields. =
It
returns 0 when the list is empty to prevent out-of-bounds reads.

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 30c0ddf90887f..bf5377fbc7b71 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -241,6 +241,8 @@ int trace_event_get_offsets(struct trace_event_call *=
call)
>  	struct list_head *head;
> =20
>  	head =3D trace_get_fields(call);
> +	if (list_empty(head))
> +		return 0;

[Severity: Medium]
Will returning 0 here artificially shrink the context bound below the inher=
ent
8 bytes of struct trace_entry, potentially breaking 32-bit BPF accesses to
common_pid?

On 32-bit architectures where sizeof(void *) is 4, the verifier in
tp_prog_is_valid_access() allows reads to offsets >=3D 4, making the pid fi=
eld
(offset 4, size 4) structurally valid to read:

kernel/trace/bpf_trace.c:tp_prog_is_valid_access() {
	if (off < sizeof(void *) || off >=3D PERF_MAX_TRACE_SIZE)
		return false;
    ...
}

If such a program is attached to a zero-field tracepoint,
trace_event_get_offsets() will return 0. Then in __perf_event_set_bpf_prog(=
):

kernel/events/core.c:__perf_event_set_bpf_prog() {
    ...
		int off =3D trace_event_get_offsets(event->tp_event);

		if (prog->aux->max_ctx_offset > off)
			return -EACCES;
    ...
}

Since max_ctx_offset for this read is 8, the condition evaluates to 8 > 0,
falsely rejecting valid BPF tracepoint programs with -EACCES.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6ad09433.a938ce27.3=
282d8.5f98@mx.google.com?part=3D1
