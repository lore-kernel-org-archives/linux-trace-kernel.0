Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47DE4F4750
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414088; cv=none; b=X+8BA0y6GCxvHnyCJJuB6Yu29W/efxKSheDIiYwXAEvFN4MSwrZU+MembiU1STFywY81MoWgHH8TYIOt11H41s6fd/r1TMTAocDFJZdDnmhelao9igDU0cpIwXbCRsuSW1dqTQxHGlDlVC5ql2npZ1ThFCUxgXLbsdTRanuLr54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414088; c=relaxed/simple;
	bh=86nGS9uPfGg9gcq8r5vJAaUgJrDwOhpChhHeWKpARi8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmA7XoqTy6jgRor+gYjCKD38wUPlUHBOfsKXu0oDl/zEL2Yo8jKRp6K8Gh6giolRX7BjSIKOSAt7uww2bJkSY6CtXMDeiBJ0ZikDsolRDF6ycWXuO//KHlVcT0+PjmNR2NGh11SOzykKlwL2kP841M80gbJFlzslViZv7BwRd28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJB30n/J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJB30n/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792414082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OLGg1AUZIaGlF5KY0eyTieD5+shq6f3blrp1e976rzg=;
	b=cJB30n/Jwtzp1kwX7foox0P7r25n8bawCpKtk1+rZ4qoFav4tmDwypYx7SQZirkkFiqjAa
	NhATE3Mkeejm+zvKfEt6mmk/MEdYzFo4K/Be/dKt71cqmjDAEnMAVQLGA76EYOgKunLqA1
	Rt/J/xN+QRNxExOoWOtUFm2lbgzNZ54=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-aS7xyLQhOiye4o_NAthrgw-1; Mon, 19 Oct 2026 12:47:54 +0000
X-MC-Unique: aS7xyLQhOiye4o_NAthrgw-1
X-Mimecast-MFC-AGG-ID: aS7xyLQhOiye4o_NAthrgw_1792414074
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48df02e6b40so1267369f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 05:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792414073; x=1793018873;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OLGg1AUZIaGlF5KY0eyTieD5+shq6f3blrp1e976rzg=;
        b=2cY5Ek1BmVQhfoQ2RUhrJC8Hq5sjDkvedpYIGZU2KKylpy+oY797Ln0YHfNk3l1fyR
         87oIMru6qE7IsNoPwL33HylcGZafwigHfUOy/OEkEg+4CxtOGpOKGyBJeM0oiCg2biAB
         YiDtx25t+3e2k9LgIUoR92eI9kL7Z3UKldicFYEinnhVhB4GmHhsZ9KXKPW8ZhoC+nlm
         qvG6ojXke9CcW6N3Oif8DlcyPYXtKYClz9B9yMT/wBmjJePp9YLBB3cpeyfN8baGFxS+
         iCOgFgAtySqJQgEMVDuziytBuAQG60/Uhsm/PssfjysScvKm1bMEAopqmfukrVdkwEf3
         B+3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwv8etCKEhznJGX2Bc+WrHuCMT/G7RDCVce7uHdzR0BX/hr8F5LCLP+vj0f0u9hJ+Ei4EI4IKM198idaJjiBfSp6PE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjCDpGbvsx+NgGOl+3Pj7eU5m4TjrG95HslYdQkEeAUFeRfLFr
	6pHU/8xjOdWDxN27cBs9lf05QGDYfnJ3aA3wTv9k0+INjz7RQqWmpJczPS+nGF5z2dVVGjfQtqX
	zAH62mSWH82uHWobyAVIklwVrnR6mdy7opk8yUriXG5G5ixX3+zzaLUP4ZNiUxEybsPjLtbwxNg
	==
X-Gm-Gg: AYBFou2D4oSyP3BUrnJwrEmGfFHw00EAyWWwd7sSiIFpznV5alTEV4XYUbFu9dExrNW
	MS71kLpETgKfvFwdRB6C/JVL3zuD6dphiKCMN6NAHoFcLyX4KaO0V2totb2rq6MT6860UInRLeW
	gl67o/4F+3krJplIluTlqpqkKEVoq09e+59ubmVIzVhQIklWukCFIQeXOqtoj8j5wQgFh0jZHl9
	BmbMI1P3c80GlGs3/1Vpge3btq/S3kRLXu/H5uV6pzaJscfOcKqJc5ayF+Rv067LTimXhT5WLn+
	DeFtdlEaG7JK2KfXeqT4ffi9vSOD+aNP3+OC6cq/l6HwHtwIAYkwZt+rv2yFHNyolNk5Kh3WdqH
	GTMwBp9f1NNIXAFZ458PL8tljcw==
X-Received: by 2002:a05:6000:1448:b0:486:f6dc:52c8 with SMTP id ffacd0b85a97d-48e07f9fae1mr14668798f8f.37.1792414073227;
        Mon, 19 Oct 2026 05:47:53 -0700 (PDT)
X-Received: by 2002:a05:6000:1448:b0:486:f6dc:52c8 with SMTP id ffacd0b85a97d-48e07f9fae1mr14668720f8f.37.1792414072521;
        Mon, 19 Oct 2026 05:47:52 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5008e7sm22653462f8f.43.2026.10.19.05.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:47:51 -0700 (PDT)
Message-ID: <d2622f5c375ab26514d059b5949dee28f3f9998d.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
	 <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, Wen Yang
	 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Viktor Malik <vmalik@redhat.com>
Date: Mon, 19 Oct 2026 14:47:50 +0200
In-Reply-To: <CAP4=nvTc297yQHz8aumZFAQ3+JK=5Z_=416WdosT0S6nHEeNfQ@mail.gmail.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-11-gmonaco@redhat.com>
	 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
	 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
	 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
	 <878q3xtptq.fsf@jogness.linutronix.de>
	 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
	 <87bj8s8ih9.fsf@jogness.linutronix.de>
	 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
	 <87v770uuyr.fsf@jogness.linutronix.de>
	 <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com>
	 <87ik2zryzo.fsf@jogness.linutronix.de>
	 <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
	 <CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com>
	 <8580176d216258e9008c344e0529509117dcc18b.camel@redhat.com>
	 <CAP4=nvTc297yQHz8aumZFAQ3+JK=5Z_=416WdosT0S6nHEeNfQ@mail.gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8JpZE-Jkxfa2ay4xul6GeGkvwCEqj72vx9XaZOGBk1U_1792414074
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-19 at 13:05 +0200, Tomas Glozar wrote:
> On Mon, Oct 19, 2026 at 12:43=E2=80=AFPM Gabriele Monaco <gmonaco@redhat.=
com> wrote:
> >=20
> > > One disadvantage of using bpf_trace_printk() for RV violation
> > > reporting is that the event will be caught by every instance that
> > > enables bpf_trace_printk() and does not explicitly filter rv out.
> >=20
> > Yes, that should somewhat be mitigated by the glob filter, though event=
s are
> > still generated.
> >=20
>=20
> Do I understand it correctly that the idea is to modify existing
> tracefs instances when enabling an RV monitor to filter our RV-related
> bpf_trace_printk events?

Not quite. The initial issue is that the current iteration of RV BPF monito=
r
don't cooperate well with trace-cmd/perf. Alexei suggested we use bpf_print=
k and
filter out the desired events with plain ftrace glob filters (from trace-
cmd/perf).

I believe this would be usually equivalent to having a dedicated tracepoint=
 for
RV BPF monitors.

E.g. you'd do (roughly):

  trace-cmd -e bpf_prink --filter 'bpf_string ~ "rv: sleep: * violation"

instead of (with a new kfunc)

  trace-cmd -e rv:error_bpf --filter 'monitor =3D "sleep"'

Now, I didn't try either way and don't know what implications there are eit=
her
way (you seem to know better about this).


> > > I can imagine an RV-specific trace event for that, however, it would
> > > require a separate kfunc to generate it, and ideally also distinct
> > > labeling of a BPF program eligible to call that kfunc. The "rv"
> > > userspace tool could then iterate over these labels so the user knows
> > > which violation events can be expected to occur on the system.
> >=20
> > That'd work too. It's what I initially envisioned but I'm not sure a kf=
unc
> > producing a tracepoint is something BPF folks would really like (and
> > technically
> > any other unrelated BPF program could call that, unless there's some ac=
cess
> > control mechanism I'm not aware of).
> >=20
> > Not sure how much it matters in practice against the glob filter, it
> > probably
> > really depends on the other bpf_printk users (and a mildly better
> > usability).
> >=20
>=20
> bpf_trace_printk is already a BPF helper producing a tracepoint, this
> would be equivalent.

Fair point.

> Of course, that does not mean we want it, but it
> is something we already have in at least one instance. I know of at
> least one quirk: you can have a BPF program attached to a tracepoint
> that will call bpf_trace_printk(), and a tracefs instance tracing both
> bpf_trace_printk() and the original tracepoint. That leads to a new
> tracepoint triggering while another tracepoint is already in progress.
> I don't know how it is currently handled; from what I recall when
> testing RTLA's BPF actions, the bpf_trace_printk() event might get
> dropped by the tracefs instance, so I had to use a different way to
> signal to userspace in BPF actions test.
>=20
> As I said, to prevent unrelated BPF programs from calling the new
> tracepoint, you'd need to recognize and track RV BPF programs as a
> special type of program, similarly to what your original RFC did. I'm
> not sure if that's what we want, but I see some advantages.

Yeah, this last step is probably something we don't want.

Although it may not be such a bad thing: if we require enough privileges to
trigger this tracepoint, then the worst we get is root trying to mess up wi=
th
monitoring, where it could easily mess up with everything else already.
But it definitely needs more thinking.

> In addition to better filtering of reactor events, you could separate
> reactors from the monitors entirely: you could trigger the tracepoint
> unconditionally, and attach reactors as tracepoint triggers to the new
> tracepoint.

Something like this was already brought up actually and isn't a bad idea, i=
t has
its strengths and issues but would somewhat work in-kernel as well.
But as you said, that's a bigger reactor refactoring and beyond the scope o=
f
this submission.

Thanks,
Gabriele

>=20
> All of that adds complexity, though, and requires separate discussion,
> so it's probably not something relevant for the initial
> implementation. I just wanted to mention it so that it doesn't get
> lost.
>=20
> Tomas

