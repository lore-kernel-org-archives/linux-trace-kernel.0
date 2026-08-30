Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB27299931
	for <linux-trace-kernel@vger.kernel.org>; Sun, 30 Aug 2026 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788099580; cv=pass; b=pPilcac4Vtd48+d/FgCMIt25zbfnmjWUrc2k1otfiql8SuxA0GIdqRIIgvvj5syPxnH61gObZOkNxSQFe9WsVrObFVot6vF4P/5mVIY70q7hXv6mhV25V4TJfiQZy+H+Uytoa1hmNZWu4y+u9mJAnaApunoC1zt8zGfKFp6AElA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788099580; c=relaxed/simple;
	bh=ucHaSmmK3HDJRBDMZKovNeMryNnaSYvBg6uxiM9ku9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtW4f0BC7V05zrLmUW+nTkJ1fvT9TRhxOiZHOv53rKSPox9LOIibT9eVSX5nuUtc/ICPzjynf/U2saUIp1ZzX8LcPwr5OPX7uCEKRH86pONhoakVaxAtTdhQlYRPHqFWNE8wwdCSl0URHH6CQ/7mljPTaLlq7vOICRqV9rPMIGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bozai+pb; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bozai+pb"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66bd7857841so2938449d50.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 30 Aug 2026 07:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788099563; cv=none;
        d=google.com; s=arc-20260327;
        b=ec8lRVo2MMQSvvrrX/+GAEnt/uzCXizhICvzL4E2EoI3g6lw0NRyDg8+rDuyHZP+nv
         zwyHqANgc+eJ9dRDNoEOToVZtcxMRtLRSZL96T+GCuR4eNapJHpl1i/vJjf2B4Bajh/I
         XctjGqlNmDmCXuzIfsiNnCe+zTsyT5bw8Uo4MVd70DM3PQVO/2dqENb6LhhYRB1mangs
         SctnY+lsOlTGmHfHPv/PabdchgTH1SA3LbKCaLfhMAtv6BlXaXqmVK0BtP7mVHWE8wBP
         X7ay3j6bjokW8p5+Ed7egOb0ScL2gEvLe0sbuI3Z5usXlSwddULlYLTXp7ySDeiPVrN+
         KP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/BVr42MRUVRldWx4XHVEPdrXKSjB9vqpAshQuqAdcyg=;
        fh=C4GxuF7BfCt9NDfuqYVL8tMnN6bbvaicjDS3jSDqjCQ=;
        b=jNoiqWLXYJV9co0ado+7a2h8R+CKPFkMYWJR8uTTF8OdmalLeYdtSgDB8MpkAz9tY0
         HtVwWqnLZMWUPVGwDFORPOVUqxvezn8lAKT8qBQ7jto3w8wK7D4UPF8+a6Eoz98aXKyw
         9vS+CrZrLE3v8dv72D0swGE4dyPeSPlk7kXjrM5EQ5UcEj2VIUjzNxrrzrEezUvc+X0W
         OB7AzFn2556BAz9wDZ93oUTF61gLMrdqTa5Xk1XYWlHgGQT6Y9x6QwspiRjx1ZX3/UsG
         2dbOURw2Ne4sT51zjrkQe+I3rEoIPPwjGJWhy/KYt2sAa/X5wRMq2HUqwt36GviLNriv
         gHFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788099563; x=1788704363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/BVr42MRUVRldWx4XHVEPdrXKSjB9vqpAshQuqAdcyg=;
        b=bozai+pbXtXPXJN59yfTjO3bk2GR4URfD+2FP/ciwhmpKEobjra/zeP7bFrbwxeaw0
         6VlFJyfFObreyjNd0ibkE8O+WbweDRcyuNmZjQ567ZSkO8Wq1wwolUm5YEAFdmkCs8OM
         2vZNS4SzdGStZhADJupMsScnenzxf29l9CReRced9eAsJlq6Ez8ij0h8ZeLy7voh7HOv
         KwSs50Mvyy4b6t9qQ39R3CvIQXKTGkVmp7oZGmPPZnm8ASm5yaMt+VnnxVD+EAGyhgPC
         iWSeydYuFGpoOzPosVjWUK6T0j6Bqna2X3dImuGNaXfCwLQ9N895hjmHV8x+upbss+CQ
         MRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788099563; x=1788704363;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/BVr42MRUVRldWx4XHVEPdrXKSjB9vqpAshQuqAdcyg=;
        b=PaQqplzrt63jkgM2YizroXsF641yNLYOkK/1XNHdEwX/DnOTwc5lp6SjPzapFYMFiW
         q/TmMTf48lE6nAq1Aj1wfgU6aHmORdoBon/w7F+dNTUIMWq7Atos/d8zUEiDjBf2UpTN
         C2A1PFzGbe1+iPRkfjyWS5Q/UXpOQyi01P9wDBYiWXjFzp7CpzZlEMC7ZB6bEmTcsEOl
         4nW1PHs3F6td4psxEIvwRqYyVHgAqvHiaUoZv9UvbTkx84i3l549XVB6ciSOUGOrYAG3
         lAE/JQWik+jpHgimNbRWRt1Uy8fntRsnr5hFuJZ6XyJJowtxCBNJDl/HhLjBSF1+3Hpw
         VENg==
X-Forwarded-Encrypted: i=1; AKwUvByD63IjLSlk16xCn9/I2KMpECeHYga/+LsSJtQ/MXxOsHE4SETciKAemiFrJfDSomcW+XC32O6LmBwben+Bvn31vYs=@vger.kernel.org
X-Gm-Message-State: AFuF++mN+E8UHVKIojjyAyq95barvdO7qWz4fPhTRDkwk180kP+ALyWb
	0wSqk20x3u+6gCU/05IZO/n0svMy5FmMiEHnds+X/tsr9Cdm0Fa8uxJa+M940Wp4JTYXN0xh9y1
	k3CVmE3eqF5+n8sA2wG1hhTCVkCdPRt8=
X-Gm-Gg: AYBFou3W+YPk67b1MCnvh3EELP+QnlNt4b70MMAYAYUNOFTGgsh8RIU6AO3TIMn0Ijp
	NyqOHaQT1tPqn3dhiERNzEpdxOrjcee+86ZM8oMTRwccULZ2+m/h0sma8RJo1jmu1MqoCy3ycFS
	U7j/BZGrsbdO3p464/67j2i9Q6Ws2HuuoZBTGLV30Tf2HUBTvYLWB8jURjOOq9liXX+FhLPi0OO
	kYcmFgBBSqPTkg9GA3WaFktnV2rPROmWI0A7aaHIh68/+5qdLDo+wajyh3MdQu5E5C6GuMHNYNI
	YLe8L5Z+xcspHzdnWFt6WGF/xcfGd6qUITNO3250Rl0s
X-Received: by 2002:a05:690c:e0d1:20b0:81e:ae6d:caed with SMTP id
 00721157ae682-85d6cbd5517mr53744887b3.34.1788099563185; Sun, 30 Aug 2026
 07:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829-tlb_tracepoint-v1-1-dfdaede7e741@gmail.com> <20260829212202.57db49ca@robin>
In-Reply-To: <20260829212202.57db49ca@robin>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sun, 30 Aug 2026 16:19:11 +0200
X-Gm-Features: AcwNN1WNdWcyYR1PyOdxtYXwKqRQnAQhNWg1LwpDWL57H9UOvMPUEn5qfIfVDMw
Message-ID: <CALsPMBMHSMLnOzO+a3gOMzD6x-+8-8fr61MOr3GVH9_LoY_dQA@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: Trace TLB flush path selection
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 3:22=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sat, 29 Aug 2026 17:44:18 +0200
> Roman 'Hedin' Storozhenko <romeusmeister@gmail.com> wrote:
>
> > +static __always_inline void
> > +riscv_tlb_trace_flush_path(const struct cpumask *cmask, unsigned long =
start,
> > +                        unsigned long size, unsigned long stride,
> > +                        unsigned long asid, bool has_mm,
> > +                        enum riscv_tlb_flush_path path)
> > +{
> > +     enum riscv_tlb_flush_scope scope;
> > +
> > +     if (!trace_riscv_tlb_flush_path_enabled())
> > +             return;
> > +
> > +     scope =3D riscv_tlb_get_flush_scope(size, stride, has_mm);
> > +     trace_riscv_tlb_flush_path(start, size, stride, asid, has_mm, cma=
sk,
> > +                                scope, path);
>
> instead of using two static calls you can use the new:
>
>    trace_call__riscv_tlb_flush_path()
>
> That is to be used instead of the trace_<event>() if it's behind a
> trace_<event>_enabled() check. That is because the
> trace_call__<event>() will always trigger the trace event logic because
> it should only be called when the trace event was enabled.
>

Thanks, Steve. Makes sense. I'll use
trace_call__riscv_tlb_flush_path() after the existing enabled check in
v2.

> -- Steve
>
>
> > +}
> > +



--=20
Kind regards,
Roman Storozhenko
