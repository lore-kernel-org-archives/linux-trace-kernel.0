Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61FC4E06C0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407921; cv=none; b=LGhN6DmjgNlvLhSWUnHtM4Tf69p7f9CK5Sr9XeWXnIXpPcGA/AevuTo5poG3yr8z8JHNUFpC4B8Xh0JcxOYxhRALdxd1yz7jEk7MA07+cGbFDKtAkJpHNnkivuCwS6usknSEM6SrnvxTN9ymO+2ETjvmFd4PRT62qu1B0uUBveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407921; c=relaxed/simple;
	bh=jUY85gSFYv44ajD0M92QfBXDWEtyEd1ElmdqhoNdS8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnSNM9x36sOhjtjeup6Vj0ecYy3acmie1+YtZv1kBNuDJRM0MeA/K/xOaeAlgA5M+1aZlH/scFX+7ngKoZK2DJ+BhAQVSv0IobpQoUX/UgYhdJItrj+Zz0Ou8sEPIj9iE8doOzw7+RZ1qSSpdEzBW333BpMnJVHpOVXghh5pYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdL6lqQi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdL6lqQi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792407918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUY85gSFYv44ajD0M92QfBXDWEtyEd1ElmdqhoNdS8c=;
	b=SdL6lqQiYPOExcnMY5rJeU7xX03FGpj7lkDf5lqY9DxfmcTDMXpZjsHMQdFkh4S+F16Olg
	xo3/dNrRRyBic8V8nzpPdwMta9AUjUtFHCRck9DkQ2wNUszb/riwscse2jMOxPU638+GJh
	OxPgJkZtlSlz+g3T8DiXhQP/S6YlazA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-mUS6Eht8OFiGsUjAVEOz1A-1; Mon, 19 Oct 2026 11:05:16 +0000
X-MC-Unique: mUS6Eht8OFiGsUjAVEOz1A-1
X-Mimecast-MFC-AGG-ID: mUS6Eht8OFiGsUjAVEOz1A_1792407915
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2942fa0995so201659666b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 04:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792407915; x=1793012715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jUY85gSFYv44ajD0M92QfBXDWEtyEd1ElmdqhoNdS8c=;
        b=xGDcvqecFI8Gzgiu25D7nF4/1Xjb4yXFWRdl9L1WIlkHPxO/kgpwmhsEI+BWueVf/N
         AwZCQpTv99jU7FNn3wtcSbNFX+t66H8lJ5A1tE3j+RNVPih8aWejNFBiPNu8hZYiFvjC
         G5Eba/HI6nHxjESnB1eGfAHWO8iPow/wg8FEa2lZu5II3Q7/wvGyeTJF9zy1zf/+rPyq
         Vf/43e7/xHeDJQHG4qWKv8rsbAL9U1qfy4zIwV1/MFoH4K/pGGiaRO6i0u3xdA6JZ3nE
         68jwqKHtOLBxAKY4EcmFN9pk/a/5/1g2owbuzby38GK3D0YDvQM6/QveHdjVnNF55Vcl
         zMWw==
X-Forwarded-Encrypted: i=1; AKwUvBwb47N2rvoUITS+iB6oBldIue6Hxu7wLbWYv/1c4xzNcByrvQZWeN8ck3HMDHXHZ1Zt9JbcFq6htg7sqdSeXosikYQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6m6evaU3EQP+hoL/dqvF5wu3T9KsASe6TdPN70F3ruO/ST3St
	U9E67D/opgv5MxsONPV36BqAhi0BWVG1LnNp6zyrQjeIjwVT/sK0zErc8ezZ2v1s/suUzjspTj0
	zoAQIc0YlT5B8s+gRasanYbOTYjsoDpZ9u7O+pt3P3C0XX5wGacsi3Kuzd7qUUYQpVWaXT+i2BJ
	uje1dWSF6WGu5erqU70lmnvEQ53LpvdoZS0XofeiXJxR02a5Nr
X-Gm-Gg: AYBFou2oo4rv6B0SR7S2OPX9WzbeISlE55hnq1WQIwJnvUKlbwutViWAhrugqqg2UMI
	VN/NciZlhNcLOhcrqaguXdG3sVodho5/OOiLJWcsFMQt4hE/4Yi8gTlWBHN8GQdD7uySMwflws6
	RB9mdxhkUFjKm56cswlOYULpEeg67/c5BIeEIw3/SFsbtHMfsFKxU5CeyowPps+ZNUoFKOUZDYN
	UaETOPkvZdCRPA=
X-Received: by 2002:a17:906:9f86:b0:c19:45e3:2f57 with SMTP id a640c23a62f3a-c419d83af46mr514042566b.9.1792407915454;
        Mon, 19 Oct 2026 04:05:15 -0700 (PDT)
X-Received: by 2002:a17:906:9f86:b0:c19:45e3:2f57 with SMTP id
 a640c23a62f3a-c419d83af46mr514028266b.9.1792407913081; Mon, 19 Oct 2026
 04:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com>
 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com> <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com> <878q3xtptq.fsf@jogness.linutronix.de>
 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com> <87bj8s8ih9.fsf@jogness.linutronix.de>
 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com> <87v770uuyr.fsf@jogness.linutronix.de>
 <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com> <87ik2zryzo.fsf@jogness.linutronix.de>
 <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
 <CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com> <8580176d216258e9008c344e0529509117dcc18b.camel@redhat.com>
In-Reply-To: <8580176d216258e9008c344e0529509117dcc18b.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 19 Oct 2026 13:05:01 +0200
X-Gm-Features: AclHuK-0PstQ9qMVKUz4cfYOyqNQzLRuAx_unL8aytY_f_PVK-zyS2FFzXAzARk
Message-ID: <CAP4=nvTc297yQHz8aumZFAQ3+JK=5Z_=416WdosT0S6nHEeNfQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	Wen Yang <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
	Viktor Malik <vmalik@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q7JFan4X8PkXdyYg-VEDf0QTiwf67NELptNiEuCI3AI_1792407915
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 12:43=E2=80=AFPM Gabriele Monaco <gmonaco@redhat.co=
m> wrote:
>
> > One disadvantage of using bpf_trace_printk() for RV violation
> > reporting is that the event will be caught by every instance that
> > enables bpf_trace_printk() and does not explicitly filter rv out.
>
> Yes, that should somewhat be mitigated by the glob filter, though events =
are
> still generated.
>

Do I understand it correctly that the idea is to modify existing
tracefs instances when enabling an RV monitor to filter our RV-related
bpf_trace_printk events?

> > I can imagine an RV-specific trace event for that, however, it would
> > require a separate kfunc to generate it, and ideally also distinct
> > labeling of a BPF program eligible to call that kfunc. The "rv"
> > userspace tool could then iterate over these labels so the user knows
> > which violation events can be expected to occur on the system.
>
> That'd work too. It's what I initially envisioned but I'm not sure a kfun=
c
> producing a tracepoint is something BPF folks would really like (and tech=
nically
> any other unrelated BPF program could call that, unless there's some acce=
ss
> control mechanism I'm not aware of).
>
> Not sure how much it matters in practice against the glob filter, it prob=
ably
> really depends on the other bpf_printk users (and a mildly better usabili=
ty).
>

bpf_trace_printk is already a BPF helper producing a tracepoint, this
would be equivalent. Of course, that does not mean we want it, but it
is something we already have in at least one instance. I know of at
least one quirk: you can have a BPF program attached to a tracepoint
that will call bpf_trace_printk(), and a tracefs instance tracing both
bpf_trace_printk() and the original tracepoint. That leads to a new
tracepoint triggering while another tracepoint is already in progress.
I don't know how it is currently handled; from what I recall when
testing RTLA's BPF actions, the bpf_trace_printk() event might get
dropped by the tracefs instance, so I had to use a different way to
signal to userspace in BPF actions test.

As I said, to prevent unrelated BPF programs from calling the new
tracepoint, you'd need to recognize and track RV BPF programs as a
special type of program, similarly to what your original RFC did. I'm
not sure if that's what we want, but I see some advantages. In
addition to better filtering of reactor events, you could separate
reactors from the monitors entirely: you could trigger the tracepoint
unconditionally, and attach reactors as tracepoint triggers to the new
tracepoint.

All of that adds complexity, though, and requires separate discussion,
so it's probably not something relevant for the initial
implementation. I just wanted to mention it so that it doesn't get
lost.

Tomas

