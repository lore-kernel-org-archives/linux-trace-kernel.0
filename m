Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E26536C597
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294614; cv=none; b=BXOBJyz/MYHwy3Lwm9QsaNxMu3/nnQseyiqLsFhfmkREdGfzp+P/X7zaQPvDVo1NZFCRKEcSPejAymEKPzlro7CFYlCorxD1XyF6HPwqbJfOTvnr4XAfYL9IWf0fOq/rvuJowhnNltlVvZY+rRiGbUEdb2fQjJpUSojSlKUPBdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294614; c=relaxed/simple;
	bh=KedIuWX1a4sKhpzql75Dew+nPjQpg/hAa4LZaYM7SwE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVsqHvEcwGq0lV5gLIkHp/PNt49Elu9Ct1JrJGtYWpT4hI5xJCMt7aJNePpaOenyuqHTIdAY4rGuULqUlrombqvlH9Vv8Z+9hJ8s63Sop4QbGp57G7uH5KtEBew7kekc7/2zUSHkW/5AO+QF1FPH/1SSCC42xDRB9tQB/b/VE50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0UhSOVy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0UhSOVy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777294612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KedIuWX1a4sKhpzql75Dew+nPjQpg/hAa4LZaYM7SwE=;
	b=E0UhSOVyDqE47e4eWs/cOa338IG6ro9qjnw88HAPjJcPuGohgew/N53+CdGJ700DmAv7Hh
	mDIYRPDHAv0Q+q0Ig5+kCMr3+RGpcqWr1z4jYfFV9OczDKvhsHDooJqfEe84mtCFctKvPr
	Sat/mhUJowaCMbMmLxryqVhMGz2Kek8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-bVq6IPgqP0m6F4eAb8kFfg-1; Mon, 27 Apr 2026 08:56:51 -0400
X-MC-Unique: bVq6IPgqP0m6F4eAb8kFfg-1
X-Mimecast-MFC-AGG-ID: bVq6IPgqP0m6F4eAb8kFfg_1777294610
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8a5f6110c1cso238185786d6.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 05:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777294610; x=1777899410;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KedIuWX1a4sKhpzql75Dew+nPjQpg/hAa4LZaYM7SwE=;
        b=bpFGPdfuq/Ma+9hB7d6HxWr8GSoENKN113Od+mMqTGwYh/ym2YjmqI/lav4V4E2nR9
         EMJjUItdsZgMF0xiGtbr9lHPqvAkLh944VTfZcTWtGXWuKD4zy/WkCoxjY85o+aBGAwV
         4MJM2PZlsjFi/WD9HPARsze6cO+5byFrhgCBfn/jW5YFho0fu15vuXCxxGO/z8FKSM7M
         2fgufnsdSCPEkuqjNq1yXfEPpAYFWZC0fwiVuvCtQnKK+qcDdkyFzoicgBECDgiaaK3O
         sA4foVcUVqSLtS+c9vToQFxJni2Sp+EE9DFVNW6CXdKRot16UMpgMbjrrHNRfqGKneI4
         M8KQ==
X-Forwarded-Encrypted: i=1; AFNElJ+mwolku//e0wOXPR4f9qxYPfne5kFWUj8zi/Cg0qr46s+1UhwgUAYyZCuwhHBtYSJELOebKit0m3YvtmqM/bTSPwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/jgvjblZKACV80cCHmhraQ+MS6rmQ+JHmMwiKOcX+JoX2fPh
	aRudFR+oySWhCK2uqnTevssHhYVNk5kHsWCUIi11Mc92IaIQ5sbMQ6e6tZLLixsnR+k6rwYQse+
	hjCUTrfJn3Q/KQatXkZVtkqVzDPV3vBNLyshUb0BrsEor4+CL15yoN2a/+62/cYf5Om9awBg0GA
	==
X-Gm-Gg: AeBDiesxfBRoEZxFMa0+JoxHKqy3882D9K8vQBWRwqs+z2lcgQowywaM3n5r7zgyGn+
	zZxey9G9kYoeq7hpXqI67Grgk4POgnor63jYYQw+ZUzItctwDaHRs6GDJYF1eYboKJzFsEMTPEM
	rWiFoPWA7+0MnV7mwBhCL3WA8LxVNMh14DbQ6ZcBI+82Hnjc8ozYsq7SRAhmaaDq8dnd8kjqVne
	N2o6G4oFnZKthcP8iIU/bPSNFBmZEvRK50t2KcX77MJ7ptYjqOHgLcP5yvV9Ke/Hp+M4jRkvsFw
	ALxDL6PBEuOpTmajUCn0LIECFAx8xhaqS2xJn5fq4gwPm35o/58DFa1vLvMIOAT6yC81nPNfdfN
	+gOqfGgEMeHL91nVggstRe2ZMiOLbAB01hKgK
X-Received: by 2002:a05:6214:e4e:b0:89c:cfb1:b59c with SMTP id 6a1803df08f44-8b0280cc0admr676933596d6.23.1777294610378;
        Mon, 27 Apr 2026 05:56:50 -0700 (PDT)
X-Received: by 2002:a05:6214:e4e:b0:89c:cfb1:b59c with SMTP id 6a1803df08f44-8b0280cc0admr676933216d6.23.1777294609829;
        Mon, 27 Apr 2026 05:56:49 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5ec2dsm266550076d6.29.2026.04.27.05.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:56:48 -0700 (PDT)
Message-ID: <93666b516d93f880ed14c3b9309e203014a7deb0.camel@redhat.com>
Subject: Re: [PATCH] Documentation/rv: Replace stale website link
From: Gabriele Monaco <gmonaco@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>, rdunlap@infradead.org, Steven Rostedt
	 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: matteo.martelli@codethink.co.uk, skhan@linuxfoundation.org
Date: Mon, 27 Apr 2026 14:56:46 +0200
In-Reply-To: <87340gpvdg.fsf@trenco.lwn.net>
References: <b845c448-1655-4860-9b6d-93d6f8426740@infradead.org>
	 <20260427085526.111835-1-gmonaco@redhat.com>
	 <875x5crb4g.fsf@trenco.lwn.net>
	 <6d7e529c7cb0ad599669e3f33e5b6168e92a8861.camel@redhat.com>
	 <87340gpvdg.fsf@trenco.lwn.net>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vlzjh_Tc6zVnpBR7Ki0chOjG-ReCnysyG4X767Fctuk_1777294610
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-04-27 at 04:09 -0600, Jonathan Corbet wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
>=20
> > On Mon, 2026-04-27 at 03:44 -0600, Jonathan Corbet wrote:
> > > Since, as you say, it can be found online, is there a reason not
> > > to include a link here?
> >=20
> > Mmh, perhaps being overly cautious for the link not to break again?
> >=20
> > The paper is published so I assume it's always going to be
> > available in some way. It is currently hosted by the university at
> > [1], which may be unlikely to change, and can be found via DOI at
> > [2], which should never change (at least that's what I believe a
> > DOI is for) but brings to the publisher's website rather than the
> > open-access PDF.
> >=20
> > I think the reference to the paper I included is robust yet easy to
> > use with any scientific or even general purpose search engine. But
> > if you believe using either of the two links is more appropriate, I
> > can send a V2 with the change.
>=20
> I will defer to others in the end, but to me it seems that we should
> make life easier for our readers whenever we can.=C2=A0 Providing a link
> seems better than requiring them to search for it themselves.

Alright, makes sense. I'm going to send a V2 with [1] (the open access
PDF), in the remote case the link stops working, we can update it.

Thanks,
Gabriele

