Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564452;
	b=u4Z6YhvkLUI+XeF6uWSo1slV+VcAnOQB1Mz7eScGdiRaxe4LZGz0TPLLInJoewLVe5Na
	 cegV8LdW2DqjalBmdQReSKfWV61uOQh1DczN066fwYnQ7XWqDGIIcP6cbYryfW/Jp47Pk
	 Cnm4a8OqBYtO4zsXfF3OblcMm9uIEMrtGCOVg2bCxijA1SrcJC8dtKWdH59oJwAn+rkwk
	 9s8xaPeJGmTx+Lu3gyMowsUmrJYM6bWHlJwC0NBSxJ64JTftotCW8hDFSRuMb51CQiyl9
	 l0j3qy4Z6Tkf6dlmAiAzHCbfN8EniMaAfcjlgKhXwDwMDr6s4YcfQvTvWGMIfvytgbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564452;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=kW9V6R8t9vC4O2koqm2kdeNC91zL+6JVsXCGsMvMxSg=;
	b=4Z3TGzwekpQt1hjVUYdLElfxDSSe4jhZdQu6xE+5jvmW9mNBMfsnSiHJah0Tr0FxPu4+
	 lAl/xlkN0EdNRAkRdpn0bjFEUCgfDZ88ilgNrmouLFDUykSFAUogGcfa/a9gg1kYqK/Hz
	 bIXfNefwZDNuHr4p/eEiPJ7v6jrCriVmbRvlsbhtRZwM21nGeU6gx9pxg9ibtMWaGQTw7
	 rfa5RF6tLFruKoxOs/1lB8CtNSegz6avzfoSPprnN5uQNijMp0rUDsV2wx1wrJYCDEpNk
	 1c69TnN0pbIMnPyCzu9oNyS0RTzxBSvG3yHh3VPtgOlDJ5yC63JA9+0zjMXghxHPwGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cl8v9+P4;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39F606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 10:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D39F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cl8v9+P4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794564451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kW9V6R8t9vC4O2koqm2kdeNC91zL+6JVsXCGsMvMxSg=;
	b=Cl8v9+P4SifJh6ew3/5lAKQeOLQXUcmh/PoCgbaCQtIpEifeB+LiAnH7YWtoV0oXMTaaQi
	a6+G51/ssaTUSisPrcifJL+x9/RqA7Hfr7N6iWv2ntF8pte+nMBAjo5uGPNaNNqWjBLkbu
	OvaQGoQ39g+IpGbeFdkT5OiEPOsgSiY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-irYC2llTOaiCVXREjSt9-Q-1; Fri, 13 Nov 2026 05:07:29 -0500
X-MC-Unique: irYC2llTOaiCVXREjSt9-Q-1
X-Mimecast-MFC-AGG-ID: irYC2llTOaiCVXREjSt9-Q_1794564448
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b69b8c6dd5so1167427b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 02:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564448; x=1795169248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kW9V6R8t9vC4O2koqm2kdeNC91zL+6JVsXCGsMvMxSg=;
        b=ewmnSDAoGvYsO9koeS5rCoGhVlQafvjj3SzYJCLAIlK471iOFxQ7SZaqrYAJgVN5wM
         xWl6mOFj4x8zhwMCa4N8KnfsXO2Mk2jS3qLgAiUs868MQlpKNWDjUAsyDL7guYhAvnpk
         ctTOOonzfiazEtk2TafLElEs0qxOvQ0PozkOdkKl3Gailfd2gbBS+87ouawvUbDLzYZ+
         UAxMhWIBM3xbrd2FLgQeBrd2spglOcoEGuDQ0x/PHh9Ya/ND8PL28dkw8c9ZLtGgBoFh
         PrEAVtFn7ebDM6SAeVw5LMKoUyEKBXBdzJM/S9+TYe+cLl3DUS09F5HicSqyKdeM4Nfk
         PMLg==
X-Forwarded-Encrypted: i=1; AL+hErHqjhIlYy3hZDNRWwIGfdyHMbTT1Us9mHvob9oHWeq2ZwMo//H1BWduOC49sh0QYrFZwdHG5RrUp4j/JrxIVJvfv0Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z8D3ZRtAm1hy/Pwe1LcshL8T2K0EFAxGPIkq8ajVwme6O3B30sW
	tyrz+k3wh7qqelv1WH4RAOz5cL8rcIlLgNWXmvBQ+G+0FG5IejIQMFt3Jnkfog/lkzm8px3un5v
	oIWQjZ7garBzPLdNdr/uAQjcndaRUREJ4cdwU3aKDBCB2FGB4NlpBEsh87GGj4vkA64usWsxy4l
	54IZ7vbv816jiQypJBHHDl4mmMjbrhSv2gcB357UB3LI99j2N0
X-Gm-Gg: AYBFou2f3MA1fCv0tWkgvvRqfmwsUQqHDo1dJLj09UUF43Z4fSuaXghkyNetoSQZxNu
	YtAuD/0NIa2Yt01M0xA+z2Dj7ElgURI9Tahskt9W1aLGm5eB0jDhrLz5uzt686/tcZjf24CsXTZ
	yKPg/+dRpBROXNz5D1q0VWEdKvMg+hZwY7Q4BE/VHvjaWsxw1G6z6Ww0nl13h3hkNUYC5p8Vtwe
	VE8zxOpo7Ru3kM=
X-Received: by 2002:a05:6a00:a21e:b0:899:5183:acdb with SMTP id d2e1a72fcca58-8beb3b3e993mr1964428b3a.1.1794564448221;
        Fri, 13 Nov 2026 02:07:28 -0800 (PST)
X-Received: by 2002:a05:6a00:a21e:b0:899:5183:acdb with SMTP id
 d2e1a72fcca58-8beb3b3e993mr1964410b3a.1.1794564447687; Fri, 13 Nov 2026
 02:07:27 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-rtla-mlock-v1-1-418986711b20@monom.org>
 <CAP4=nvRQE+GKPT1-KgZ4OgcVV7eKqnkURaELutSMgK4T8YAZMg@mail.gmail.com> <20261113094423.xgAx5Goo@linutronix.de>
In-Reply-To: <20261113094423.xgAx5Goo@linutronix.de>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 13 Nov 2026 11:07:15 +0100
X-Gm-Features: AclHuK_AIphtSlPLaANmNgJ9inZQe0fAf97a-Oppqika-haxwWPY2pS6Dz2kyJA
Message-ID: <CAP4=nvSEfWgR1GQxVCctBVL_9HrAgkET--UhZ-mdx_uCpk_1_w@mail.gmail.com>
Subject: Re: [PATCH] rtla/timerlat: Lock the memory of the user-space threads
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Wagner <wagi@monom.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Clark Williams <clrkwllms@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yj_U6KpQOX5CaS3xtwM1z4TcCn6hl7g5AZb7W80E56E_1794564448
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 10:44=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> > > +       /*
> > > +        * Keep the measuring process in memory: the latency it repor=
ts
> > > +        * runs until it is back in user space, and a page fault on t=
he way
> > > +        * (its code, stack or libc pages reclaimed under memory pres=
sure)
> > > +        * would count as latency. cyclictest does the same with -m.
> > > +        */
> > > +       if (mlockall(MCL_CURRENT | MCL_FUTURE))
> > > +               err_msg("Could not lock timerlat u memory: %s\n", str=
error(errno));
> > > +
> >
> > Can we make this opt-in, gated by a -m/--mlockall option, like cyclicte=
st?
> >
> > We can add it as a boolean field into struct timerlat_params and pass
> > down to struct timerlat_u_params. See e.g. 2ff4464e3283
> > ("rtla/osnoise: Add IPI tracking cmdline option") for reference.
>
> Why make this an option? I would prefer a RT task doing the right thing
> right away. cyclictest has a history of several options to do the right
> thing. Is the reason why lock should be disabled?
>
> Sebastian
>

I agree, you are right. I was thinking about rtla setting
/dev/cpu_dma_latency to 0 as an option rather than by default (unlike
cyclictest, in that case). If rtla's idea is to measure the system in
its current configuration, it makes sense not to tune it by default.
But the rtla user thread not having mlockall is a misconfiguration of
the rtla thread (i,e. the measurement tool), not of the system.

Plus, cyclictest can run as a non-root user that might not have
permissions to mlockall. That is not an issue with rtla, which always
runs as root.

So I take that back. mlockall by default is fine.

Tomas

