Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D3143BDDD
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137372; cv=none; b=gds2AQSk/TZVnhWsPk9DA92wjIw4tX5mHq5B9mwmcmnIXSCKtMPZ8D5K7a0LoMhswrENi8M6lVUXJzuAQpqnv1MK8YvE5njhiUUATOMCF/LYDX3J0LvsH8ACuvschAgsciccyZDZ1RMsQflZV14U+XbK3ZUqsI3EA0RmQEBwXnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137372; c=relaxed/simple;
	bh=ziqq6YYMfce74jf9FZPUM7krJ+OUHhVgDE3s4m+tBAM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pb06jMVQ4xrPloT8hgQwXHeQ12l15QEQuwZIQUd0RGFAWna04XVgpi0e4O2a0m102Dh+qkpJEOuCzAz7m0tGvlww4HaRcx106bAAkuWVsmxVzQqXde/lDo4zenE3QuQklt6aPIOKYj2L/Ej1JRbge0dZ+33mkqlEk7ZEnQQSIHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6KxMA4V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6KxMA4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296E51F000C4;
	Fri, 16 Oct 2026 07:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792137370;
	bh=JTlCFsbHCLIqbpFJjDz5wpYCfwpmUzSDry+R5TzIZyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l6KxMA4V5yOfyvLWViEZBwcBrynuvI+XfRQno3S965Oq3XnFeTMYXMuJCaiiCZYrp
	 S7YYRX0MkVKNB3f5nxQrdJO+tpfSFsaC2fdCkYpcxZ6aiD4V5PByhrdtasnYAVh+6I
	 9GwuYNGofYHDBPauBSv9rzdsP6fdQC20OfjkWVUxQGJXdTm/LVvqvTurGJb4id9sPY
	 Fqy+Wb/WWhM25Ry6TIL6fRStlpQRTZ8GubAaT+HPMa+GMWOLE0BiboxImwNfd1xAfX
	 nHqRqPVZM6BIQqvW+EbAhrY7yEd1doSarY5HXW4n1Kb+gZMaryv9njUCGQcFSEx7MS
	 uasE/z9Fsd9Aw==
Message-ID: <sashiko-outbox-173982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: reject trace events with an empty
 TP_STRUCT__entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoran Wang" <haoranwangsec@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <6ad1d48d.a461c41f.282b8.7a97@mx.google.com>
References: <6ad1d48d.a461c41f.282b8.7a97@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:56:09 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tracing: incomplete fix leaves BPF OOB read exploitable for zero-f=
ield user_events
--

commit 4bc63c3e7a59307c8dcbd3d4bfc283a9c62599d9
Author: Haoran Wang <haoranwangsec@gmail.com>

tracing: reject trace events with an empty TP_STRUCT__entry

This patch modifies event_init() to reject trace events with an empty
TP_STRUCT__entry by checking if the fields_array is empty. The fix attempts
to prevent an out-of-bounds read in trace_event_get_offsets() when BPF
programs attach to zero-field tracepoints, but it specifically exempts
events that implement a get_fields callback.

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 30c0ddf90887f..4bdd31dd24234 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3406,6 +3406,11 @@ static int event_init(struct trace_event_call *cal=
l)
>  	if (WARN_ON(!name))
>  		return -EINVAL;
> =20
> +	if (call->class->fields_array &&
> +	    !call->class->fields_array[0].type &&
> +	    !call->class->get_fields)
> +		return -EINVAL;
[Severity: High]
Does this leave the out-of-bounds read exploitable for zero-field user_even=
ts?

The added check explicitly exempts events that define a get_fields callback.
The user_events subsystem defines user_event_get_fields and therefore bypas=
ses
this new validation.

Since unprivileged users can dynamically create user_events with zero fields
(for example, via echo 'my_event' > user_events_data), user_event_parse_fie=
lds()
returns early:

kernel/trace/trace_events_user.c:user_event_parse_fields() {
    ...
    if (args =3D=3D NULL)
        return 0;
    ...
}

This results in an empty user->fields list. Because user_events have the
TRACE_EVENT_FL_TRACEPOINT flag, BPF programs can attach to them.
__perf_event_set_bpf_prog() then calls the unpatched
trace_event_get_offsets(), which dereferences the empty list via
list_first_entry():

kernel/trace/trace_events.c:trace_event_get_offsets() {
    ...
    tail =3D list_first_entry(head, struct ftrace_event_field, link);
    return tail->offset + tail->size;
}

This reads out-of-bounds memory, bypassing BPF context size validation and
potentially allowing an unprivileged attacker to load a BPF program that
reads adjacent kernel memory during tracepoint execution.

Should there be an additional check in trace_event_get_offsets() or should
zero-field user_events be rejected entirely?

> +
>  	if (call->class->raw_init) {
>  		ret =3D call->class->raw_init(call);
>  		if (ret < 0 && ret !=3D -ENOSYS)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6ad1d48d.a461c41f.2=
82b8.7a97@mx.google.com?part=3D1
