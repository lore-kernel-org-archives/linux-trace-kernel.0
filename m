Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C0B3815E8
	for <linux-trace-kernel@vger.kernel.org>; Sat,  4 Jul 2026 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144227; cv=pass; b=p5fmTnLxVyDRdiGa7Gdtw7XODKXJvphUVAYSNLaOsndfjpiZ7kClNQl3SOqzoqhQWHaAeIa4DSc6VaEryt31eYAtohiaYopP9SXhbz8/u+M3TVUGIdgyjBf4RvqQr7wGYKAr+2blCWc6dFOFZ74CyVuVSTu4xGzUjegmPSbvZn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144227; c=relaxed/simple;
	bh=ZRYk8rUc0v5PjnNM82oYLX9kGjn4ucYipOPsdxWXZY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/+s/4i+WIlueA7O21JVXPX26Q+oGmp1apxZ28jaA3tfxZSoHNR4pHP8YkdFBZIFRGNkNmn/ek2tOdIsDDBBI3iULmrpkn2MnqeRr3IP6oYf+Vk71RBVLBRnqAhbfgBiHQNTcZnN+9BuJxx8CiVHQRDmhSJ6ZXY/OtR4q6y9Q9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UICjz+Bg; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UICjz+Bg"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-473dc4cf238so719798f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Jul 2026 22:50:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783144224; cv=none;
        d=google.com; s=arc-20260327;
        b=pvdIXj97M1hghVvzwNEHrv7P8S/npC0YFlQ/e7254wSJQGNSQMW1TDelMkszhA8sLw
         6B38b3KngTkwZSu4DJFURnB8IOukkzSvo694CuLABcwwoDqspjWwzSHKY5GDR315gbkP
         fRLHI9wfmgqbbP2Qnv9SW/+57HiFdbP+1i9u3tWmcQMYGa3qxFonebevOtueeOLf3aeh
         qM0sreGoBj42TKRPJ+JkxOYFk/uXjiGd/rZp9doDdMSwXFHrKugE8Sfo2BxAAVC4Uo44
         XhcO/hzcXssjMZygduTjYNP1YXL5UJicVa3/FlaU8sY/U5kqL86OXUBr0UQuLxVsv3xo
         NXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6+6YmgpaeM5juotgbcQnSfBdzNCdrt/VISxrQFcbQHI=;
        fh=onuF6rYrBsj1E7QNf11Vp3bbY68/TPsN7kNuo95VT54=;
        b=Kn0qQaEOjDQ68XqGDlGhQv5p5SXhBYqUljZ5H6tF52vpOMJ5uvX57WPWhaAWdxCT2o
         RYs6476CUr2Ymmc/nW20sMdx2wF4f3g3FyIxAgR9goClqS/Kb6WsHKB99UFAxYJ/DJub
         OQVot6R4KV1aqEiH/j4NLmpWIqpOgp1poPa+tobUAGtm6LOVOuUSTT0kLUTEvlGyaWYI
         9QyKQbL7O5EGuZCJEFtsWkddZpRo7Rses4p/OTFyYbrB5x8qXl221Tc+n8XRYMKeW4Zd
         3vRmiFh/mqNglC9OC5INuBWq+PAstvppn4sjL0QAkI23f1uFQCVt1IERatXMU0/NFHHe
         xsjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144224; x=1783749024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+6YmgpaeM5juotgbcQnSfBdzNCdrt/VISxrQFcbQHI=;
        b=UICjz+BgMiVkxsRUgIRFD7YiUTb0SqaX3J8Rh6llMBEZjZTFWs4lAClWnMhy8vJCv5
         UKEIqqq8RGFQsNEwR22b+LmHWk+sG0UbuQCPoeJHoatoX6GxnIVkMh6YEFxxmkvU/PXr
         +ifsOTrkLVQzJAiiOr2RSGAv/LGNDsj5QhQAdBtXItP4dU6rPAPcEJynKw13Hy/2yFiX
         q2w6gYwL3JCuIVYHgx2zakavJjo3+T0XeEGLvD6c/Iap35A83F9YxFmp/wevnUsPbNzj
         JlGFkcHt0wXhwxoU9Z0N/zXrpClyGP4H+oSMglGNT0auSEyzdanNsxYD54jpEtdw9kPi
         KOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144224; x=1783749024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+6YmgpaeM5juotgbcQnSfBdzNCdrt/VISxrQFcbQHI=;
        b=IF1HugFLI3DMDSyyTBSl/HnxWkOYyBZqbucIjx4cBEVbBRxa0Eqzv2sFgmyonqAdGH
         z2B3d/Uynu1vlCNjich2K6S5+2uaewJv1cg8pO4LWjz3UWDfYunRJPsw4PsXZqYlZGV1
         qxN3J+UzBmBYuMLLLrrdRJOMHc/wP+2LXMJLwVM5NQp8LjpK4hQosnBGKWYHb0C0PX+w
         W48KMH9pR/uTS64yEjz+9unu7bZDT0RwmiRtxx8BwpEwKnh/LrrHNb+czJQkq0VR8Zji
         U9qAn+uKmgEiXdEiMLe13ejXt1ca6uZNuxEA7ujOBORj+ZP0FW7RRjEvHA7REJBHP22q
         L/vA==
X-Forwarded-Encrypted: i=1; AHgh+RrmnBc2dzFzIvUn4yal1yeG2mAN9fkpJ3alK8XMmg/f3JxJF8HlG9blGsdyVqnmVApRzvyW++zL2do7t3TnT1cYHCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIaV4yqSI58or1ly5xpD5tWIyWNbKZdQFaQK+yTCJfE+IxkFK
	oSVVEkPaQL8o0BeRIKALDStivWMDk//jZAWXssTa+H0ixFmpPfKqnr00AAPgTFmtuo4oxfOhY0E
	bsSSCDJszNbh9DJe3r5TrCik9lH3o5YcX4DBY
X-Gm-Gg: AfdE7clEvrZ4AyEjFjp1i2lo/IFPP78XRCI9DZe0Cp6MUVDFKAnCyUHapoUW/FG4PeA
	RySH/Q4IBDxAe5SKDmAgEgCAhtmxx1RjLRVz8esgNcjBA4MxG3B8/nbauV5Y0tA5XtKXYMRlXvi
	jXksRxxZx7ruDFkigzTuDtVM35MG2lx2A2kqqvFV9zWjLLS4JfRtfNj3jN/Cy/Sc8zGwZYdPfAd
	IKInD/pxfmA4fLhVEdfmEYoQCUsjxcBPqxlKBLfy0qLjdEL44idgJxTOJv4RsqNeiHpDA==
X-Received: by 2002:a05:6000:1acb:b0:473:975c:4fc7 with SMTP id
 ffacd0b85a97d-47aabb4cdf7mr2219612f8f.27.1783144223640; Fri, 03 Jul 2026
 22:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFk-A4mE9Jweo2hfX7y_85xbPyt0FqpMT1EvqX1OcYZ=LTLgRA@mail.gmail.com>
 <29129c40-4010-4862-9b4b-3bafad874568@linux.dev>
In-Reply-To: <29129c40-4010-4862-9b4b-3bafad874568@linux.dev>
From: Masashi Honma <masashi.honma@gmail.com>
Date: Sat, 4 Jul 2026 14:50:12 +0900
X-Gm-Features: AVVi8CeSvpagGiT9Pdk8CHkTxPDqdZD1f9ODz7VToeC131JQxDxF1e8qrCd_jd4
Message-ID: <CAFk-A4n9U0r07tn6XHHqmOZ++-bmM4bSd-SwdpEU-88gjKts7Q@mail.gmail.com>
Subject: Re: [RFC] xdp: add device context to bpf_xdp_link_attach_failed tracepoint
To: Leon Hwang <leon.hwang@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	kuba@kernel.org, hawk@kernel.org, andrii@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Leon. I think this is a much better direction than my RFC, so I'l=
l
drop my tracepoint proposal and support your approach instead.

Since a user-space dependency on the existing tracepoint would make it hard
for you to retire it, I'll make sure the Cilium PR doesn't rely on the
tracepoint either.

Is there anything I can help with on the new approach?

Regards,
Masashi Honma

2026=E5=B9=B46=E6=9C=8829=E6=97=A5(=E6=9C=88) 0:26 Leon Hwang <leon.hwang@l=
inux.dev>:
>
> On 2026/6/28 19:39, Masashi Honma wrote:
> > Hello, I am re-posting this mail because I forget to add [RFC].
> >
> > The bpf_xdp_link_attach_failed tracepoint (added in commit bf4ea1d0b2cb
> > "xdp: Add tracepoint for xdp attaching failure") exposes the netlink
> > extack message produced when attaching an XDP program via BPF_LINK_CREA=
TE
> > fails. This is useful because, unlike the netlink attach path, the
>
> I really appreciate that the XDP tracepoint helped someone.
>
> > bpf_link attach path does not return the extack to userspace -- the cal=
ler
> > only gets an errno (e.g. EINVAL/ERANGE).
> >
> > We would like to use this in Cilium [1][2]: when attaching the XDP
> > datapath program fails, surface the kernel's reason (e.g. "single-buffe=
r
> > XDP requires MTU less than ...") in the agent logs instead of an opaque
> > errno, so operators don't have to inspect dmesg on the host.
> >
> > The limitation we hit is that the tracepoint only carries the message
> > string, so a consumer cannot tell which device a failure belongs to.
> > This matters for two reasons:
> >
> >   1. Correlation: with only the message, a consumer cannot reliably
> >       attribute a failure to a specific attach, particularly if multipl=
e
> >       XDP attaches happen concurrently.
> >   2. Scoping: a consumer watching this tracepoint sees XDP attach
> >       failures system-wide and cannot limit them to the devices it
> >       manages.
> >
> > At the call site (bpf_xdp_link_attach() in net/core/dev.c) the net_devi=
ce
> > is in scope, so exposing it looks straightforward:
> >
> >   TRACE_EVENT(bpf_xdp_link_attach_failed,
> >       TP_PROTO(const char *msg, const struct net_device *dev),
> >       TP_ARGS(msg, dev),
> >       TP_STRUCT__entry(
> >           __string(msg, msg)
> >           __field(int, ifindex)
> >       ),
> >       TP_fast_assign(
> >           __assign_str(msg);
> >           __entry->ifindex =3D dev->ifindex;
> >       ),
> >       TP_printk("ifindex=3D%d errmsg=3D%s", __entry->ifindex, __get_str=
(msg))
> >   );
> >
> >   - trace_bpf_xdp_link_attach_failed(extack._msg);
> >   + trace_bpf_xdp_link_attach_failed(extack._msg, dev);
> >
> > Before sending a formal patch I'd appreciate guidance on a few points:
> >
> >   - Should the tracepoint take const struct net_device *dev (consistent
> >     with the other tracepoints in this file, and lets TP_printk show th=
e
> >     device), or just the ifindex as an int (simpler for raw_tp BPF
> >     consumers, which otherwise read dev->ifindex via CO-RE)?
> >
> >   - For raw_tp consumers the argument order is effectively ABI: prepend=
ing
> >     dev would shift the existing msg argument. I've appended dev above =
to
> >     keep msg at args[0]. Is preserving the existing argument position t=
he
> >     right call, or is reordering acceptable given how new and rarely
> >     consumed this tracepoint is?
> >
>
> Good concerns. I'm not sure about these parts.
>
> >   - Is extending the existing tracepoint preferred, or would you rather
> >     keep it as-is and expose the device context some other way?
> >
>
> I'm planning to retire this tracepoint. But I think I cannot do it, if
> there's user space application relied on the tracepoint.
>
> I'm planning to add BPF syscall common attributes support for
> BPF_LINK_CREATE, including XDP link. By that way, the kernel will be
> able to back-propagate the 'extack._msg' to user space, when fail to
> create XDP link. Thereafter, the user space library will be able to get
> the error message alongside the errno.
>
> Thanks,
> Leon
>
> > This would be my first XDP/BPF tracepoint change, so any direction is
> > welcome. I'm happy to send a proper patch once the shape is agreed.
> >
> > Regards,
> > Masashi Honma
> >
> > [1] https://github.com/cilium/cilium/issues/40777
> > [2] https://github.com/cilium/cilium/pull/46546
>
