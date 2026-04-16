Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EE63E3C6F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353748; cv=none; b=GuiGgWx2pjFyWmCIOtoaf7mgkteE+6l6bLl73Je3xPOms/pn5cvsjrXN8YyatRnZIUojsn/hlSRontQdR6y9PRlgTV4mYOM+Gt8dfB/Ke11pUd10yP7cW1o8RcZT4Gi52wR9YrkHXviyBHkxgajCG1YaZ+h1dzjKhqCXrNIN0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353748; c=relaxed/simple;
	bh=XEwfouN/mEoK0svKioMcH+Kd3RNNkSzqS9p5OIt4xow=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJuBwXQzzvtfpNIsNd/ASlGVU4CfwPHYr9fQ9qpuvdJk8sVtdJLOPDM7dnaPD3HSFGOakxEaSh5ppraZILRMJp6I4BJ+s/HB1u7/1a+BEifGFYjU3YT8zJZlhr3/AUbU6KSbajaYLH/01KvQIaxRxTAplQJDHnNR6Xz1QsDGoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RIvIgPnw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIvIgPnw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776353746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XEwfouN/mEoK0svKioMcH+Kd3RNNkSzqS9p5OIt4xow=;
	b=RIvIgPnww/jun9Dn67P30hc7w2BZfM165zxV3M6e2jvXlu1OAU7rgCToF1K4qQENnrVBPN
	EoNidijkSo5ohvDbDndYhQPCI6R4G8VsTcrr6W9BZoTrKclVwIKoIJv68najaMWYpZ5+Lj
	57D+lk6Bxn5wKAVnENST9Dljv897s68=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-BOmUpqBfNmCReqe84JR_Sg-1; Thu, 16 Apr 2026 11:35:41 -0400
X-MC-Unique: BOmUpqBfNmCReqe84JR_Sg-1
X-Mimecast-MFC-AGG-ID: BOmUpqBfNmCReqe84JR_Sg_1776353740
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d03db814eso8602111f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 08:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776353740; x=1776958540;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEwfouN/mEoK0svKioMcH+Kd3RNNkSzqS9p5OIt4xow=;
        b=OSF5fqQZ8exl/viUUC1pZ1nrsHJ8kPh/zCBudOCi+EbXFG18UO0vAwwPVSPvZyHSGk
         XDmXdvSs+Do6qWdneLy16hpsyAj8aLrDF9nEq03kpaxymW3uFZguY9bI782LgRvrggej
         y3Yl1yyPB7gFDA2pFxvLUbehMsvoDRazNB4xigiTwTGhz/RhbS2hnV4TkG4/JPD95sVd
         1vhx6GtqphpwwtUTRAIohrBO/ps1OzktIJ+1tHXiX65lb+EMKomNJvAwpvgZnq+Tke+m
         uw+DxK+TsftL6r40KbN3T+0NYnh8vWa35i9IRPkkHrqmtynQIKeyXDAIbuZQ9+OctB8R
         ySSQ==
X-Forwarded-Encrypted: i=1; AFNElJ/WVPuSSsbKSKZ3Jm8N2/YZIv1reW8mpoQOSA9xyk6/hJ7nA8NB3vb9+utUFEX+WWTul7lCOEHiUcVyFJ1nou+K+QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRAGZXjK8Xv+RlixyxI4eA1MXTib5VBNGtmN2+ipnAD/QzGmFK
	U5fzCz0VPVkRC730lkek3sJSK9/hp8veWcrrIW7KKQ3L9TpRdPVL03gY/0htTNt5VZAmT4YdiwE
	4SpyRT8v1kTKQ4qU+NFc0pDM91lI/L0HrYJwvqXN1qSZPmIu+X40e9mt+9K82YeKSHXama5ifqq
	xrWtqDlu+y
X-Gm-Gg: AeBDievv86Y6ASiNFo74LkEvP9B+uuJHszHxr9V/kdJouJWRKW0+rR5uAE20sVc8L2N
	mR0a7KNKQWGaMe57qE9BRPs/86ONRhZtKjddXJ5P53K/L8E9pGNxI6npS7yRNscFeXce0sQJBFr
	wBuRVv0gyYTvGS13Cat7rkuffJ8cbQCJP9JO6vr1um/EgBbNHLxBY9EibNP+35Z7AlkVN6Z47VQ
	jHbHLxScBIOrFH1LFdUDz/r8F1wWkNFUfEU3Y9UwYj04ZlcKGUpsUSCxMShHaRN63f0lC3SGCdG
	UxgBIm8P7SvqEDdpAJYbdWYemVhwpEHDoVqYo5Hg66NHez0nDcj1XfuTLqGLx5p9u/Sb4ytR+dj
	GbmqSOUvmC+Y0J4yYS4Gu3lZ3Beb6ghRBLls0GVOTOHh2NhZvqDiwR0fdoPEFUFWriLC3i7HLvZ
	fK54OjTm1gncJ+Hykz/upnxQTggA==
X-Received: by 2002:a05:6000:18a8:b0:43d:71b:204b with SMTP id ffacd0b85a97d-43d642cd3a0mr38257655f8f.39.1776353740375;
        Thu, 16 Apr 2026 08:35:40 -0700 (PDT)
X-Received: by 2002:a05:6000:18a8:b0:43d:71b:204b with SMTP id ffacd0b85a97d-43d642cd3a0mr38257590f8f.39.1776353739819;
        Thu, 16 Apr 2026 08:35:39 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3e0091sm12796946f8f.25.2026.04.16.08.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 08:35:39 -0700 (PDT)
Message-ID: <8c173ddbe2c7e5ebf6d7dfa05d14e68e88422896.camel@redhat.com>
Subject: Re: [RFC PATCH 2/4] rv/tlob: Add tlob deterministic automaton
 monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 16 Apr 2026 17:35:37 +0200
In-Reply-To: <228deda8-3685-4f07-afd5-d3f3ca531154@linux.dev>
References: <cover.1776020428.git.wen.yang@linux.dev>
	 <ccf53a89b3b65e5728403dc097fde94ac2591d98.1776020428.git.wen.yang@linux.dev>
	 <74a624434b59c00f9407909b8696f041536d9418.camel@redhat.com>
	 <228deda8-3685-4f07-afd5-d3f3ca531154@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7WXs1OigNU1ifzu8SH_uXn4V1ofM87TXhvJ7dWC9AF8_1776353740
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, 2026-04-16 at 23:09 +0800, Wen Yang wrote:
>=20
> Thanks for the review.=C2=A0 Here's my plan for each point -- let me know=
 if=20
> the direction looks right.
>=20
>=20
> - Timed automata
>=20
> The HA framework [1] is a good match when the timeout threshold is=20
> global or state-determined, but tlob needs a per-invocation threshold=20
> supplied at TRACE_START time -- fitting that into HA would require=20
> framework changes.

Not quite, look at the nomiss monitor, the deadline comes directly from the
deadline entity.

What I meant with using per-object monitor is that you can use your custom
struct as a monitor target, that has your per-invocation threshold because =
you
set instantiate it on start.

Now you can simply do ha_get_target(ha_mon)->threshold and you get your val=
ue.

You can define in the dot representation "clk < THRESHOLD_NS()" and rvgen w=
ill
do most of the things for you. It's probably better to use nanoseconds so y=
ou
avoid conversions when dealing with hrtimers. You can do it transparently w=
hen
initialising so the user still passes us.

> My plan is to use da_monitor_init_hook() -- the same mechanism HA=20
> monitors use internally -- to arm the per-invocation hrtimer once=20
> da_create_storage() has stored the monitor_target.=C2=A0 This gives the s=
ame=20
> "timer fires =3D> violation" semantics without touching the HA infrastruc=
ture.
>=20
> If you see a cleaner way to pass per-invocation data through HA I'm=20
> happy to go that route.

The above looks cleaner to me, what do you think?

da_monitor_init_hook() isn't really meant to be used by monitors, it's more=
 for
the infrastructure to extend da_monitor.h easily, sure you can use it if th=
ere's
no other way, though.

> - Unmonitored state / da_handle_start_event
>=20
> Fair point.=C2=A0 I'll drop the explicit unmonitored state and the
> trace_event_tlob() redefinition.=C2=A0 tlob_start_task() will use
> da_handle_start_event() to allocate storage, set initial state to on_cpu,
> and fire the init hook to arm the timer in one shot.=C2=A0 tlob_stop_task=
()
> calls da_monitor_reset() directly.
>=20
> - Per-object monitors
>=20
> Will do.=C2=A0 The custom hash table goes away; I'll switch to RV_MON_PER=
_OBJ
> with:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 typedef struct tlob_task_state *monitor_target;
>=20
> da_get_target_by_id() handles the sched_switch hot path lookup.
>=20

Exactly! That should do.

> - RV-way violations
>=20
> Agreed.=C2=A0 budget_expired will be declared INVALID in all states so th=
e
> framework calls react() (error_tlob tracepoint + any registered reactor)
> and da_monitor_reset() automatically.=C2=A0 tlob won't emit any tracepoin=
t of
> its own.
>=20
> One note on the /dev/tlob ioctl: TLOB_IOCTL_TRACE_STOP returns -EOVERFLOW
> to the caller when the budget was exceeded.=C2=A0 This is just a syscall=
=20
> return code -- not a second reporting path -- to let in-process=20
> instrumentation react inline without polling the trace buffer.
> Let me know if you have concerns about keeping this.
>=20

I'm not sure how faster can it be compared to attaching to the tracefs, tha=
t
should be quite light if you just listen to error events. Sure you'd need a=
 few
more libraries.

I'm a bit concerned in adding new interfaces (ioctl), when we have already
tracepoints and reactors. The reactors themselves are not as flexible as th=
ey
should be though, but if required we may definitely create a ioctl reactor =
just
for this.

For now ignore all this and continue with the TLOB_IOCTL_TRACE_STOP, then w=
e can
think of the details.

> - Generic uprobe helper
>=20
> Proposed interface:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 struct rv_uprobe *rv_uprobe_attach_path(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
struct path *path, loff_t offset,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
int (*entry_fn)(struct rv_uprobe *, struct pt_regs *, __u64 *),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
int (*ret_fn)=C2=A0 (struct rv_uprobe *, unsigned long func,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct pt_regs *, __u64 *),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
void *priv);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 struct rv_uprobe *rv_uprobe_attach(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
const char *binpath, loff_t offset,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
int (*entry_fn)(struct rv_uprobe *, struct pt_regs *, __u64 *),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
int (*ret_fn)=C2=A0 (struct rv_uprobe *, unsigned long func,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct pt_regs *, __u64 *),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
void *priv);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 void rv_uprobe_detach(struct rv_uprobe *p);
>=20
> struct rv_uprobe exposes three read-only fields to monitors (offset,=20
> priv, path); the uprobe_consumer and callbacks would be kept private to=
=20
> the implementation, so monitors need not include <linux/uprobes.h>.
>=20
> rv_uprobe_attach() resolves the path and delegates to=20
> rv_uprobe_attach_path(); the latter avoids a redundant kern_path() when=
=20
> registering multiple probes on the same binary:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 kern_path(binpath, LOOKUP_FOLLOW, &path);
> =C2=A0=C2=A0=C2=A0=C2=A0 b->start =3D rv_uprobe_attach_path(&path, offset=
_start, entry_fn,=20
> NULL, b);
> =C2=A0=C2=A0=C2=A0=C2=A0 b->stop=C2=A0 =3D rv_uprobe_attach_path(&path, o=
ffset_stop,=C2=A0 stop_fn,=20
> NULL, b);
> =C2=A0=C2=A0=C2=A0=C2=A0 path_put(&path);
>=20
> Does the interface look reasonable, or did you have a different shape in=
=20
> mind?
>=20

Yeah seems reasonable. Then we'd need to keep around the uprobe for
deinitialisation, but probably having it global is the best way without
overengineer anything.

Thanks,
Gabriele

