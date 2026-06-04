Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B843B3BF1
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572785; cv=none; b=kJAoDhzQJrKKUELThDDM1/sig3Qr/9f1aNUg7Bzl2Yx9WcTYVwOOIdr9cw2YaZgORKoaqN5m4wR8jRo9eUywbv18BDxvMUT2OdahrbkIPeJ0mVpi0mhVc/gpQeKt+4XdbGuYD+S+Z/tXcA5Ec9yEw6DwDTOqAglQ4bcOLzYcH/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572785; c=relaxed/simple;
	bh=YPHx0xIaU61yDq+7axLEEkd55S/6YCGfw7UaGqbHFxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fY9c14DeuctlM3heK8ggA1aMd7jyF05iy1M7qDwo6NrchXSu5ZfiSiQ0yVgXsWRypZk1fEHEUvaibSukRpSASYCvhdwRByzHj7MNkEUWh1Gxt5FQGa7V1BDxBdUgt9KRcnEimvS62XWfEL8PlFenJWwf/iZ9X438H/8mSBSQmRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESjqOsRz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESjqOsRz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780572782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9TU+T4gN3NfDzukxlra0zirVLAN6y/DV7woryQ1W30=;
	b=ESjqOsRzLxzTjj5LFP+H0MraOWneLZnRn6+p/ImssM5gMIQt3MZ2RiSdoa13E0Ubz8D38H
	cMaikhjwjFe2bF//c03q1OZex0K1j5OD5qiiw+vRe1zpF2+/fvPdOImEb6O19ypVRaPTO0
	vt95+2+F7ain8CwODsgc0a+ldYpm3kQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-aRpwY6TtNTiCWkLOBP2ISA-1; Thu, 04 Jun 2026 07:33:01 -0400
X-MC-Unique: aRpwY6TtNTiCWkLOBP2ISA-1
X-Mimecast-MFC-AGG-ID: aRpwY6TtNTiCWkLOBP2ISA_1780572781
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-beb86e54b79so57028966b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Jun 2026 04:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780572780; x=1781177580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b9TU+T4gN3NfDzukxlra0zirVLAN6y/DV7woryQ1W30=;
        b=ccSFP5p7z50QocyKT02EPMaGwfKFNB181KHzClQr4Vd6xWxUKLp/uUDV2VAgSp8UlS
         ggLrv3W6hs+DEy6n24MxOpxOY4KmmeZC8I6YTMEjeAh8fUEYxFe6fEbjNqaaOd26DdKR
         utn7CedUE4FvpgETTZC0phn3awe6I65CC3wp6X1k1AtYnzEizzXSL4RJPquOGlCa5sF7
         uMB7f7Ux0bJE6v8rzIyKAe8mYfnPaNMu3UdBS3YK4uluaMMx87BcpvMvTOSWyZ+F28hY
         2yIlr0EO8+mAEKEUd1Vv/Jeiqk0UnzdpYIBQifxO6zqvUjhoVRR8Wq6UKfmb8geAQw83
         TnKA==
X-Forwarded-Encrypted: i=1; AFNElJ/bDhb9m5YwTz3kzIauJudTzTfvxXbakpr1U7sVPpTUkQq9imdBv9AC6VNxFd2YNjKmq3ne54envhrw9zKpmqr9MP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/K52xqDAG42fehBau1/a6mMgrX4GrZ0ewo9N+FS/1Am1fYviI
	5CDZoSVoX1wGO+awcYcczKzz6bj6V46L9h0BvgLRlBRirT3KsPN7V8+EqQMVuPB24vlujRIX6x7
	oYumTOo3jwBsHzd0eMQs55cGTrdBsc+1O/WMaZ4N2ToRZAsqO0ygGdTC/i7sp4hSBpMc+TMPyKE
	aMgb/OalfbkweDVvwaVImUlVNMSfd7wrw52cF5pH/JlxpSV2UvjpiQPr9JBCA=
X-Gm-Gg: Acq92OGrjAc7u63LIeh5QGviGbJMRU4oFqguNjyW3y+zs/ijW5oC6GxjO5y96wCBnxI
	IbuVBKqdsYFiRrV9Yj90nq5bN8zOQ3kXw/klF3KKmijXTANGsOFyEuFBTDhJvc7R+k3eElx6kb3
	/T/3tLHOajWxOJX0RxNF6rCk00iHmG4Q13tvwmpQnvfvcj0qr9fyUCmq3yNtivKyrv4P864kARe
	BR8HgipWH+uaivP
X-Received: by 2002:a17:907:970f:b0:bee:bcf6:6a23 with SMTP id a640c23a62f3a-bf0b3ab4946mr426311166b.43.1780572780594;
        Thu, 04 Jun 2026 04:33:00 -0700 (PDT)
X-Received: by 2002:a17:907:970f:b0:bee:bcf6:6a23 with SMTP id
 a640c23a62f3a-bf0b3ab4946mr426303166b.43.1780572778606; Thu, 04 Jun 2026
 04:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603125056.75559-1-gmonaco@redhat.com> <20260603191627.5cb4ef6c@fedora>
In-Reply-To: <20260603191627.5cb4ef6c@fedora>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 4 Jun 2026 13:32:46 +0200
X-Gm-Features: AVHnY4IZXI6b570kjRYQYfRynAWZR9_tsCcpzwxrM3axq5IgVOX_zsbq31WJErc
Message-ID: <CAP4=nvQEF7BtsMSoDaVO+5MazsRGypUnxB8w0Uq=2sCy=g2HGw@mail.gmail.com>
Subject: Re: [GIT PULL] rv fixes for v7.1
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, unknownbbqrx <dev@unknownbbqr.xyz>, 
	Wen Yang <wen.yang@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wtkbe-sbTDRtN6r2DWdZOqpgjfrt6A32eu-duyl1CYA_1780572781
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

=C4=8Dt 4. 6. 2026 v 1:19 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.o=
rg> napsal:
> Hi Gabriele,
>
> What is this? All commits need to be authored by and signed off by from
> a real person with their official name.
>
>  https://docs.kernel.org/process/submitting-patches.html#sign-your-work-t=
he-developer-s-certificate-of-origin
>
> -- Steve
>

Is this really still the case? Note that the document says:

"using a known identity (sorry, no anonymous contributions.)"

It really used to say "real name", but it was changed by Linus in 2023
[1]. Note especially this section by Linus:

" It was 2006, and nobody reacted to the wording, the whole Facebook 'real
   name' controversy was a decade in the future, and nobody even thought
   about it.  And despite the language, we've always accepted nicknames and
   that language was never meant to be any kind of exclusionary wording."

The wording sounds quite clear to me. And I'm certain that there were
contributions under pseudonymous identity that have been accepted
since then, most famously by Asahi Lina, a vtuber persona [2]. I don't
really see a difference between that and "unknownbbqrx", other than
the latter doesn't sound like a real name.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dd4563201f33a022fc0353033d9dfeb1606a88330
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D2e2f6b0ef8551bf3bd8255729d27e3ad9451e562

Tomas

