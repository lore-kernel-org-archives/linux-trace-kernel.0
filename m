Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A957357A25
	for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Jul 2026 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784377242; cv=pass; b=UCNWkUTW3Tbcf5eemq9JWEyq1PPRDmCm3txN1vw9mVOoEN0wMBohWQf3XtVV5/iE51oPYfHpKX8CC94nufCgCBZHKRRfpkNekRG8Nzb1WO/4cFZ9P6oztA2co6jOUV99ykq/CadHm2Fe0lFlQvG1jFF/TASeCDXjXFmv5VieaEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784377242; c=relaxed/simple;
	bh=j8iEuECYo6l7WVl2wNPuCGnpEoiSM6iRxTLJh9xMSj4=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONkjTDYen8Aov42ll+Cwa1a/XLpkaMeXtNAUnLA9nzu1fnFCs2+/2DEwivZlRkt3tB55wi9ld/iWCHV1uTU6eJ6WqWrtO7xKqeKdHaaU/WzVbwO4DDo+W1RvqslqE0MZJvpe2Qk2HnTLBjwobxxewSwzNBfs5Hco5UYI5ReINeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USk0Gr7z; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USk0Gr7z"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66843536f94so587618d50.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Jul 2026 05:20:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784377240; cv=none;
        d=google.com; s=arc-20260327;
        b=Pj1OlRRh+Pnjgxr3f417k7nTPUhpxUya4kFIVzUIjKMrw9vJJe44Z7DdfH+oEOUE/G
         pITBTgMwcpHPqxvwnCv35R8H5RJah1qa/JQFbi6X6f7Gl/r3Zp6d5BOPOEqdHfjXd7WT
         lZJxMGs0kNEZ1g25agXWIuvnx+qbYX0EaVE3nit2eWonfR5qZvKJMxFA/eG+XLdt/F8Q
         YEEuOMSoM6KWYygE5wHRY7SyRSiBJeOBB5CoUaT54IXs15m+Gxb7LZWAI5pf2roFSKhE
         onnHAppAIZ7RpQcSlfco0v5NAKJqWaA8kQOVEYGByMNV9JR4FWy69EtQ0LMOT2/NrIdO
         R6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=j8iEuECYo6l7WVl2wNPuCGnpEoiSM6iRxTLJh9xMSj4=;
        fh=ONM8WrjWNSX3cF4Aw7scnVYZRsmndUqtzxjiokCSQhY=;
        b=MBFe5rPRTGgky2K9NXLqvcMuTdiENhZX8z9iq2e/aFBo21n2rjwsjX1pQpzKbUOJYv
         cIQ7A9WIMPjHf/jrJGuE71PUw5pfpbY2YeVNqgAu1YvIxn5dItfmZUqBSFBxql1Gi0Zm
         eUa7Fd1WC0Ih5Tn560JcWloZG4u1y/GaIMFulXq1BFNr/+JjOn3tQPoWak8lMTvXFi5o
         zVzPfY2+mF6FX1ozbEDDffyOlISXnprpWT9AheIaDWFriWY5LIGmEMaVVRz4SabdASKD
         8z+A4kkdFWTc8lQgpU6K5zYF9xie4v6GWXupPAshIvcnlOh1SG3A2o+nG/nGFCN34nrE
         xvVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784377240; x=1784982040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j8iEuECYo6l7WVl2wNPuCGnpEoiSM6iRxTLJh9xMSj4=;
        b=USk0Gr7z5lFQWi5Mg7FQ+8LRVSf4cID9HbtEyjrnpyo0yLGO/hUXS4ldFx4PgXdzh4
         FJ9Zn4Wg2YNuQ73YVVCX+V8aHCNZwXFEjhkJ0ZSJORgvnT/5wyhfZF/P47LMaMsNPiEB
         HcN+dhACsEv1U3q1HUFqE5XeUeL5kZIdEGMMAfpFB/wFYHOKzoi9BkRrN4XjI9FTGb3v
         FSa1+cGj2HYARvCPX2mQFtQzJd9x9CE5WLqqYoBlJz6t5ZGJ+5Zbze1+IgvWJCE29vtj
         G7S6By6aFrm8CpBqL0RLIp8HBjeype3v+FmUfZVpSMQvuBlyrPMjW+wsHYuLA5ADPhiu
         gomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784377240; x=1784982040;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j8iEuECYo6l7WVl2wNPuCGnpEoiSM6iRxTLJh9xMSj4=;
        b=E1FCtmaITvn4kIVBz5xpbjWIbsajxjcaKlT5asYHJaCxKXeKkFmHr66dTcXOdw7eN8
         uFHrsRtNpHBCvk3AKQWwYzR9rlcgLZjMIoHDv/fDeUxnqJj4dYarjV+ZdX/yk/Vlu6V6
         DscBBfhJ97ztC0SA1mvtj2TI+inpQET1zx95Pf5TmXZ+uwa10pop5vdOIWaGXQX8htwh
         A6TcYTO8UmG3F9+mLUEAcTWyDNdCOIEhfF5XUf5erbMxDhtqtnlvbEGTnil6YRLQwlnn
         BkYrLDoXCSRnjILIVMZxoFoo0+jRGRYcxHq9EIR2wmyW59aFcs/EYw/LHvj1XcuNGuUK
         m7Vg==
X-Forwarded-Encrypted: i=1; AHgh+RqVrnjg3qhm7Figf4eg31nWEeRfYsG2/uPFYgqdHF5Plsjhmk8jfiAb4CYZXMSn/H4CQkIrrnwa0T5GEpsjmeAfFdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz9sCig/lDmfpkAFc/pbLga2SrZuxjSkZR3AKE/R0qSN8Fc+YS
	oZ7zkPuiwSEQBMuN0Ki5bJFHNNxsQqoKypJ7uUizVMu7A63EoLKP8/zq7V0teTN+0Wh2OGPwVsu
	zSKimHarP+RJfkLX2F+x6cPCreqb4dlCWkO6S
X-Gm-Gg: AfdE7cl+AfWbJHxHq76xg1evC7BXbCBoopAobL30QHoAg3YppMGGb+rlmapcAN5vBJt
	kY+9JeWsgj73gTWyXAQz8XGoReuV2OpDUQ3MaEuPhF+rgCGB4I8uvk14bZCGZ2dBwbebz7/N8BJ
	TiwjsufHBEEyX41uf019eSmJ5MmpD7q9nNiK5IGV45M9VpQoWMQYNLsjZibKcAlPWTmbcOnOT05
	rapjMNCS7MYtCs5NI4OODTWibR/D22c2eF1O/ddSFSBQwXk3b330Npi+zLW+A==
X-Received: by 2002:a05:690e:158f:10b0:667:9ae7:8d24 with SMTP id
 956f58d0204a3-6683bd5d983mr1535630d50.83.1784377240401; Sat, 18 Jul 2026
 05:20:40 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 18 Jul 2026 05:20:39 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 18 Jul 2026 05:20:39 -0700
In-Reply-To: <20260707103619.43b8b553@gandalf.local.home>
References: <20260628004653.28065-1-alhouseenyousef@gmail.com>
 <20260630101425.2f7cfbea@robin> <CAMuQ4bV-HJWbS7NHPGtoyKz-_+LR335phbXeOi83EbV6kn+3gg@mail.gmail.com>
 <20260630171603.26530150@gandalf.local.home> <CAMuQ4bUNbCM7oxnrXaT_oAoX+Guoo4_Bu0eO5dLR3OZ62Eu0Xg@mail.gmail.com>
 <20260707103619.43b8b553@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Sat, 18 Jul 2026 05:20:39 -0700
X-Gm-Features: AUfX_mzYRPRwtiRkxWgROyCySY9G0MNXCIFVfxdUlFAWf-46IUDKnIVkW3m0iKg
Message-ID: <CAMuQ4bWw1mmwK+aJN3024s+rGWCx-WfxvmpqkR3c_u8JND7fKA@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: serialize read-page order with subbuffer resize
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, petr.pavlu@suse.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Not yet. The mutex-based draft isn't suitable; I still need to
implement and test the resize-in-progress flag design you requested.
I'll send v2 only after that is done.

Thanks,
Yousef

On Tue, 7 Jul 2026 10:36:19 -0400, Steven Rostedt <rostedt@goodmis.org> wro=
te:
> On Tue, 30 Jun 2026 14:16:48 -0700
> Yousef Alhouseen <alhouseenyousef@gmail.com> wrote:
>
> > Agreed. I=E2=80=99ll add an explicit resize-in-progress flag, set it ar=
ound
> > the order transition, and make the external read-page
> > allocation/free/read paths reject work while it is set. I=E2=80=99ll ch=
eck the
> > flag under the locks that serialize each path so it cannot race the
> > transition, then compile and test the resulting v2.
>
> Did you ever get around to sending a v2?
>
> -- Steve
