Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41421FC101
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984295; cv=none; b=ffQzNP52s/uD/lFipGInI6ssoduygqdLey3LVjb3zWFt2zZ4JVjybdkbwDcQ9CDZuoOXW7D9NL4vQQ+zot/3Xc74/neeT9Wp4e4WMhrChRSSjMMqtYbFJQN2tgJmgUt0juKiiGa8VMMuhlWxbiD59bv9xepq2MyesKTiDXWzdbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984295; c=relaxed/simple;
	bh=ARCXlgcBj7iXqgl4sGBs1kqXwSUW+g14rp947PKdQec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSX/AE3refioMw013E1aklGeUBlcxqbg/U8Y7fBskwwZyDHPxxG1ukz1i6lNz5cYT8d5KbkrkDtldWIWSzz0MWZzEUyPd5Cf29uT1pLA5gif/FSaXk++IYmnGjA9lnEDHzvusS0LRd0rda9s8jmjELk8sHPfYNDaW1pC/NE7maY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmx481Ts; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmx481Ts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776984292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzGKFLOEunQq2amrjlgcItgMg4F3fj2KAQL8+IiUKzw=;
	b=hmx481TsDAAWbtH0wl+19ae/C6cKKM1uIJPb4G9dMkCVVRzbo59KqKmD9gBKaIW3IOLhDw
	ZQAmydJ7vRgBLr09ZMmERFKA1nyiIrE2wU6EI3o3rHbGGEEqZSrTpRSD7iZbdBB77VkBHf
	WwgdwU3h6WXukmP6oSkA7lDlZ6yNEaA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-sV1xqYmiOJWHXVSXt6DtLQ-1; Thu, 23 Apr 2026 18:44:51 -0400
X-MC-Unique: sV1xqYmiOJWHXVSXt6DtLQ-1
X-Mimecast-MFC-AGG-ID: sV1xqYmiOJWHXVSXt6DtLQ_1776984291
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8aca4660827so210182966d6.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 15:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776984291; x=1777589091;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzGKFLOEunQq2amrjlgcItgMg4F3fj2KAQL8+IiUKzw=;
        b=fyRdldvZzxnd73zI8Pl6Fuqmf9oQwOAJtBj5BbPYP65FjKA5211qfYWCH1JvqDyRAJ
         T6rCHVGJlkzxHTRFQYhB4LLdKBgBAlhYMsopLkBHYLqFlldipUlQj8pAft05hSLK7AtE
         IRR5JZhN1iNEUNLabrL/PUdGsACDfK6jlWNZUSs8fDiui/ww+CfYWSz4giqlkIA9vl48
         LXV53Hi1sImFbCeT6AyYtwWN3d4vTxcXcLSqPiRY8qjLtieaD6mCaO42dGDPDsAjuwHR
         hv/5p/a2wbhEqxkKTIWchX6U97hybxTaYz48DFLJRHJSdizMAKAPdlvPlcfBC5euXymE
         eUWg==
X-Forwarded-Encrypted: i=1; AFNElJ8CKWbRoTnuRkec8dMuhSgXNrXUnZ0MGnY46e7T8ATF+b4rjRJChxUtRhu4pr1FMU3j/Lvwe9ra8X2V+V0lkpzy16g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+kB4+gzyYOjDoqvG8FpbXfyjW34mdpUJN1dEVKNliZljEAqrk
	U5aO+wRggT/M9wm24+fC2MD/0MXqsa+TnsNgu9GGUqA3ZR+JaxqUwceuir85yULijE/T6JCsdD/
	nLGZBuQctGM4U835rxmluLnyDbVLHyeXdPHx17yk2Kku6zHdC0I9GvK44dSlcjGv0fWpagy0igQ
	==
X-Gm-Gg: AeBDieuJNgh4M+e75sH55BjSOw3iSJPJ6MQ41HeDdcw2FkLhORFuLpDeW7T1N8N7Jvo
	j2WH1jDJXuJFfWukNFG0k6KocashsWggjRCOfk2aEKRyvVluJlsYNdaN9xwrFodcujpzxYrFnvc
	UeX8GN+iu+K5WYLVf6LNgpwO1ypNdXClca1EiBsxyoV7Rgeit9lvwfBLqLbxmRkhIWNgCy4aWTd
	tXpxbY4FiNJ5EpMW41BS8n2Zxr5cTWSywJHdr4MR8gysgZb0RdwlgUMdUk44YcHCi3X8duVgTU8
	Gbn2k20mnWdQNVmfXEfdJQ1io8O4DksQOsoVycaeSAZQsac1vK5mZoD2awqH7+RdI1Xc6ekuwrE
	1QpWhrdz7firiaJ1c4X7CxhhsIujwZ48424GlMGuMez69qZ3dSHyb1wic7XffF7QB
X-Received: by 2002:a05:6214:cc1:b0:8ac:b4b3:3ce2 with SMTP id 6a1803df08f44-8b02813ae21mr440651586d6.41.1776984291297;
        Thu, 23 Apr 2026 15:44:51 -0700 (PDT)
X-Received: by 2002:a05:6214:cc1:b0:8ac:b4b3:3ce2 with SMTP id 6a1803df08f44-8b02813ae21mr440651306d6.41.1776984290870;
        Thu, 23 Apr 2026 15:44:50 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac4260bsm165590886d6.4.2026.04.23.15.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 15:44:50 -0700 (PDT)
Message-ID: <c14e603b447530f65ea48274388f68bb2ff0086c.camel@redhat.com>
Subject: Re: [PATCH] rtla: Document tests in README
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
 Costa Shulyupin <costa.shul@redhat.com>, Wander Lairson Costa
 <wander@redhat.com>, LKML	 <linux-kernel@vger.kernel.org>,
 linux-trace-kernel	 <linux-trace-kernel@vger.kernel.org>
Date: Thu, 23 Apr 2026 17:44:49 -0500
In-Reply-To: <20260423130759.882247-1-tglozar@redhat.com>
References: <20260423130759.882247-1-tglozar@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FD_eSZI0sdocFDkA0EXwsHEgWJjorrgrbPnvUkzchUU_1776984291
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-04-23 at 15:07 +0200, Tomas Glozar wrote:
> RTLA tests are not documented anywhere. Mention both runtime and unit
> tests in the README, with instructions on how to run them and a list of
> dependencies and required system configuration.
>=20
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/README.txt | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/tools/tracing/rtla/README.txt b/tools/tracing/rtla/README.tx=
t
> index a9faee4dbb3a..8a782cd2c171 100644
> --- a/tools/tracing/rtla/README.txt
> +++ b/tools/tracing/rtla/README.txt
> @@ -42,4 +42,34 @@ For development, we suggest the following steps for co=
mpiling rtla:
>    $ make
>    $ sudo make install
> =20
> +Running tests
> +
> +RTLA has two test suites: a runtime test suite and a unit test suite.
> +
> +The runtime test suite is available as "make check" (root required) and =
has
> +the following dependencies, in addition to RTLA build dependencies:
> +
> +- Perl
> +- Test::Harness / TAP::Harness
> +- bash
> +- coreutils
> +- ldd
> +- util-linux
> +- procps(-ng)
> +- bpftool (if rtla is built against libbpf)
> +
> +as well as the following required system configuration:
> +
> +- CONFIG_OSNOISE_TRACER=3Dy
> +- CONFIG_TIMERLAT_TRACER=3Dy
> +- tracefs mounted and readable at /sys/kernel/tracing
> +
> +The unit test suite is available as "make unit-tests" and has the follow=
ing
> +dependencies:
> +
> +- libcheck
> +
> +Unlike the runtime test suite, root is not required to run unit tests, n=
or is
> +a tracefs/osnoise/timerlat-capable kernel required.
> +

Should add something explaining how to install "Test::Harness /
TAP::Harness" for those who aren't familiar with the Perl ecosystem.

-Crystal

