Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5091E32938F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764094175; cv=none; b=LTKjwWNWzSt12W3dyG9W9I4uDhu+URztFTbXy1i7gwa+0/9aW8SgDh0EC78pSXMzdjj0q9yG85UviSlT+Olz2Mw9mtKHBB2ornGMjlJTcaxppg/rvTeGWssYs/JxKmVPQRho0q/9G1b4MTdcXpgRJvZzNgsHFJN6jBYtVcfS/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764094175; c=relaxed/simple;
	bh=ZaCWiMgstn7nTBo+iZMAGV8wK/vR1o5i3IH5dDzLN/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrMKUDVXGsBOI1gKx4gOjkAE7fGp9i7ZdnClqmbPM55bc0qsPyxKG7oQlDr7ce/Hci2febQchwDhv2lxGpTeke3HXQmOPp05xUAMUTTMhqHGTNO6frBaesEOiuaKNi0pSFUdJCp8WSMXz9J/8ffFkpQrIkceAXeUK8nnf7sow/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XE9KCIPw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE9KCIPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764094172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VaP5r2WF0NQOUygG1QUNsqxGUL+netXL3q2fn1MfCgE=;
	b=XE9KCIPw3HMlUuaklVsMfglNGi6ZDU0oqb+QYDrFMSJE0AW13gXKCSmG4vo0UXg4nzfaHR
	oNNUOj4XhOZjGmyJ9LTqwOhMLjk3ZLnHYZVTnhoAOho/L/bYs9ShCHjaqGHxCqWQAvQ7NR
	0tH5Tx4MJ5vmbT5MUQJSuvOmMW5GOng=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-uSPbv1I6NM2nCUVJhjCCEA-1; Tue, 25 Nov 2025 13:09:30 -0500
X-MC-Unique: uSPbv1I6NM2nCUVJhjCCEA-1
X-Mimecast-MFC-AGG-ID: uSPbv1I6NM2nCUVJhjCCEA_1764094169
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5957ecd65c8so4669070e87.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 10:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764094168; x=1764698968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VaP5r2WF0NQOUygG1QUNsqxGUL+netXL3q2fn1MfCgE=;
        b=kDfE3JLkeXW3Ph49NZzsu97o+lWcxd2ab7GzL9xxunaI0xeMpm4JFdrFO0SC6kLHln
         sAW19NYHwO//pnk/ygxJpTHbpZSHe0cAn030+2EgZMJ7hIzyHq7FT3soMl4G+IRO3TaX
         bZZDokS2CwMv8fT+NTbgyYNlSn0kxV6L869r9zcOh6DqjiEsLezWA01bHuTQdrGvXGeo
         JoMvAd7toXj0op3KzQVcRk+M2SfejXEvbbPVDpxzhoF9s55udLJix0h13Hu3aq/REd4M
         bgUXvgt1JCDEyoKDBUZaihBVECRmnbkVt28mKziHsuBliwjDaa9iEKbiRC2Ni2a1uT59
         bfjA==
X-Forwarded-Encrypted: i=1; AJvYcCXBo25xgnIVoOPPJeaI3O7Jya4Q7xNEsiRTCiu4AWNNaxiGVdyjuMStFOPdE62MI/JrQjaFTGX4Bcm2gXN/IxxIjOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGBar+zmD5Bfiv/57s5gMjTOxiSziOFCZvcF0QDXVkpsgyaNx5
	9fq7gGETd89/LeQLS9Dn9VJAwmfuDqmZ3sJa9L+wSZV2nWAnAdcgD+GJB3iXkuxM2A+jex9FKVi
	vDF+VqgEQMmSQ58uuLIt36nyJuGVvKAya22dg5m4SVMpE3OIfHACzjGDd9BdBlJXMQtVdYZYzKl
	iO1xNTZbx4FRSDp+9XjTn7+R/DBfrTC61aYcUcxNuTp+bBToac
X-Gm-Gg: ASbGnctnwtyxQ4OxT+tBiCfF/UOzPXCf5Wd8kFREXLd66d72T7ymqWfxgZFQ8ZtJO4r
	DDvm7Cb564ZvvZXhTwA47ImQcxMmTRITHdO8bRJqTuxeOMfIP2j27rbmpKUjROQFe9q72sukpmW
	KV91BoJnIc5RaXrWWdwu9s4T9GvBsLvIqDRvhsjAm6one5e4upEXRU1Z8X3Ep5/0OC3Q==
X-Received: by 2002:a05:6512:39c6:b0:595:7bc3:133d with SMTP id 2adb3069b0e04-596b5046c83mr1598722e87.11.1764094168454;
        Tue, 25 Nov 2025 10:09:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj9U31QBJxo0s+PPFfLtHCeUvLeFgn6GBmL9Wl9fbFjEaVZ/6i/71QdkrtIFvmLStQP4lVXhQRcK330bgO9PU=
X-Received: by 2002:a05:6512:39c6:b0:595:7bc3:133d with SMTP id
 2adb3069b0e04-596b5046c83mr1598694e87.11.1764094167593; Tue, 25 Nov 2025
 10:09:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117184409.42831-1-wander@redhat.com> <20251117184409.42831-8-wander@redhat.com>
 <fb5b468b38ac9570a5f3fb948452d1b5b03c9f9c.camel@redhat.com>
 <CAAq0SUn=eK+9YZZhdL_bs0S2cfVMhuuV-v8DSRMkTOqoL=SEWA@mail.gmail.com> <99c2109dd8c4b65be34f5ee00575a267da10b002.camel@redhat.com>
In-Reply-To: <99c2109dd8c4b65be34f5ee00575a267da10b002.camel@redhat.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Tue, 25 Nov 2025 15:09:15 -0300
X-Gm-Features: AWmQ_bnRq1iq0xoYJwCmnH92Jl-x8xVbQmo2RiV7AnrVIx2PzbBwiU9tMK5MTnk
Message-ID: <CAAq0SUkchNE50vJEsZDBDQBp88KgzJNJdxaMz=p30h49mxFSHA@mail.gmail.com>
Subject: Re: [rtla 07/13] rtla: Introduce timerlat_restart() helper
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, John Kacur <jkacur@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XwxnrH-ysvGV0aYaBDryOOze4M9YTka5XEox6jLEHkU_1764094169
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 2:36=E2=80=AFPM Crystal Wood <crwood@redhat.com> wr=
ote:
>
> On Tue, 2025-11-25 at 11:20 -0300, Wander Lairson Costa wrote:
> > On Mon, Nov 24, 2025 at 9:46=E2=80=AFPM Crystal Wood <crwood@redhat.com=
> wrote:
> > >
> > > On Mon, 2025-11-17 at 15:41 -0300, Wander Lairson Costa wrote:
> >
> > > > +
> > > > +                     if (timerlat_bpf_restart_tracing()) {
> > > > +                             err_msg("Error restarting BPF trace\n=
");
> > > > +                             return -1;
> > > > +                     }
> > >
> > > [insert rant about not being able to use exceptions in userspace code=
 in
> > > the year 2025]
> > >
> >
> > I actually find exceptions an anti-pattern. Modern languages like Zig,
> > Go and Rust came back to error returning.
>
> Maybe I'm behind the times, but I see exceptions and error returns as
> complementary... not everything should be an exception and I can
> certainly see how they could be overused in an anti-pattern way, but
> they're nice for getting useful information out rather than "something
> failed" without having to add a bunch of debug prints.
>

IIRC, you do get stack trace from the error returns. I think Golang
didn't/don't by
default. Exception as an alias for "panic()" is fine, IMO. What I've
seen in production
is services down due to unhandled exceptions. One of the reasons is
that there is nothing
in the function signature that says if or what of exceptions it raises.

> -Crystal
>

