Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767748F84A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729787; cv=none; b=roKIo8zPVyeVrEpYfzsmerDZKawsY+UVArdnSdI0VWsCcvoebXlLwYzt63sLO9HBVF48caxkCI2Js6ZYshgPpHD3pweQifRLXTHFIOdVYliYgnJrPBrQMDBK/hLlIZHAy8YuwsejrZqiiJeLBGSYGoITsrxruZHeQeYfsgku8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729787; c=relaxed/simple;
	bh=JyKy7mnAmUw8tnHbEwiiGFVJCd1yhCZDBWylOQNKIUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3kd4Gkby60N5L7hCe0yWq2w9cnvWxU/JXdPyOPQVVXaTwZzJgQKWkROjwpIf6zYLCAXpTN+L44geT2+JXRYAMmukPcoRA/RFTJUUe0MVXb/yxjAGaea8MGYmm59CBR7XXFy78NkPm2ducTV4WdDYXleG3yige7QWYES9GTIBKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hv+CPWml; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hv+CPWml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786729784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyKy7mnAmUw8tnHbEwiiGFVJCd1yhCZDBWylOQNKIUQ=;
	b=Hv+CPWml7IfytB/E35HGnMCkeSR8DwZAOuy++FI+LgDFgawFoVSQPLgYrnS6XXOrtN04CO
	CZUYZzGeNH40k/VbNO7icA+SbqW2CUT91ue7eZuiKRUm/wN/7ZMYSnAffHgqDMSuEK9r33
	3ODaOQbW/z4NSWGBwsPTrCS8eWPWxNI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-S7lc9AwWMFCBOKqMF3vSpw-1; Fri, 14 Aug 2026 13:49:43 -0400
X-MC-Unique: S7lc9AwWMFCBOKqMF3vSpw-1
X-Mimecast-MFC-AGG-ID: S7lc9AwWMFCBOKqMF3vSpw_1786729782
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c20e1599870so153669666b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 10:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786729782; x=1787334582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JyKy7mnAmUw8tnHbEwiiGFVJCd1yhCZDBWylOQNKIUQ=;
        b=MB/jKp/0rSxRYd7gO4WKLTQiCzlFSkUmq5Tq74LqBZJQsernU/LtXVWvg/Y+cUtXUR
         tjS4mvZSoi0otpOB2ke4ABJ7Ny5MooitYvWcvh0pyJN5SS585iR4xPNwpoYJAx+6+5Co
         x81qGU370Ih/SK9smPxHeYpfp7nXrjUKPcCXb+PNSz4/cWt4bPgmHlVC+Q1k56OQjxS6
         Bm4pf/hsD9YhxlsVyZUBu+QbkFa8po94BieH7A0n2/DDvI2stwrcWiO4nXFDE3Y3Y6C6
         j9yZejAuH98LNzxt7PTljS30KTp72Pobj//T8iO4lUbuk9oSZG6aasH+hjaC3wchWjxA
         slJA==
X-Forwarded-Encrypted: i=1; AHgh+RpkENI2UvdxwkqsCWq8hZokrWGxMLS4B9rk8ncouKofjhQqAoWo2/PtiB6WD/vujnmaxwHy1CVRGy3RZyZiHOFR+bY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmxyfXrmsKw9M2kzAKRZWo30CQgQCFIUqYC8GUpsScKktG+RHz
	PrEgKRM8QxbuOTseSmOYn5bwb4NOn2ipbYZHiRMaDXRQyxt5BSmtEEaoi3g7lxwL7tii6SlX6Zn
	nQ4mLOsghQuf9ZigpzQbHuEocqJi2oyh7OckHnlRwFUwdAVyg55rKSsz2iJBrj/N5ZDWCjZQMp7
	LDcplNLTQGNA4PFDuzC4GLPmylxyKkVOyXYA2WB14bWzk5xD9/
X-Gm-Gg: AR+sD10OGK0BQhKUcTGBbMVevVOOd8yarosvim5OdJGJYlg4cDopvKFFZdjMhPEJfRl
	HbjWhr/ez0TvslKSa1AEerebe38mIlMtxCO6tWNQcGRnynq0UWkF9dxW1ZgBsxEXlSjAAE5UNOV
	6oKYgJs5wq8SkP4Y8Pc+6+q+XQ/M3/+amwv1QUuyTD4vLVIxcYLtFFKoO9+4eea7GpSVEjyAwxk
	1gU3I1qw90clWM=
X-Received: by 2002:a17:906:100f:10b0:c20:af9d:454a with SMTP id a640c23a62f3a-c212a2b2dfdmr257299466b.16.1786729782248;
        Fri, 14 Aug 2026 10:49:42 -0700 (PDT)
X-Received: by 2002:a17:906:100f:10b0:c20:af9d:454a with SMTP id
 a640c23a62f3a-c212a2b2dfdmr257297966b.16.1786729781913; Fri, 14 Aug 2026
 10:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814135511.2207190-1-tglozar@redhat.com> <20260814103045.6efc2514@gandalf.local.home>
In-Reply-To: <20260814103045.6efc2514@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 14 Aug 2026 19:49:30 +0200
X-Gm-Features: AUfX_myWFj21cw2g9YuF_kwrwmSP3f8gxOtOiHVltDklc-bfujcbQVF4wYz-OQY
Message-ID: <CAP4=nvTb-6f9PmhZzA0fp88FrOEtVjr0Hr5UdEzCbt8igJ2n2A@mail.gmail.com>
Subject: Re: [PATCH 0/5] rtla: Implement more robust nr_cpus handling
To: Steven Rostedt <rostedt@goodmis.org>
Cc: John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7YMXumH3Zx6dSx0ebF58zfFhBx6DHnZ_oTgeMtOZZjQ_1786729782
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 14. 8. 2026 v 16:30 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis=
.org> napsal:
>
> Note, the merge window will likely open next week (Sunday) (and of course=
,
> I'll be traveling). If you want this in the next release, please send a p=
ull
> request today. Otherwise it will likely not be able to go into Linus's tr=
ee
> until 7.4.
>
> -- Steve
>

Thanks for the note. This is targeted for 7.4, I generally like for
patches to sit on the mailing list for at least a few days to let
people give feedback, unless they are trivial and/or urgent. This
patchset is neither.

I will try to leave a note next time when sending a patchset for the
next cycle late in the previous one, so that you don't have to worry
about it.

Tomas

