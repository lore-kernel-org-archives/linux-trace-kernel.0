Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F47B262FC7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962691; cv=none; b=XUecwlZQSixv8f4/ABVTVVJPZhiHp1715Aw5qzrPae2iRhhdezGw9a5om2MxTFY/qPT2+i/MUbNnICdnVUkaeY7TmLcRIvCOOvN1DjZMrHzFtKhau0EnEP0KdStYIJD5yF9p9nuUvBIJepDIZVoUhJUufof8SMTH3w4ccgAizuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962691; c=relaxed/simple;
	bh=RtjA44yZHNRS0kFnDDXuQqTB/tfgoZjwkeL9/Dk+NHs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsZv6kw+KK5tLTQL90O07iI4S703E3ZXLHmaQOJer0+apGvrjZUPsxj/7q2oXK+lq1pn4IyOapNEzSW4bOPQZVJV1mD1wi1lBct8ZYMcbCl0oh5hmWwshHnB8nz1g3pg1++72+bHFrCjPmmErR1B+chY80m5G9xPGNdG7HT7Q+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYw986C7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYw986C7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762962688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6SbkVI3Yk0stVlEf+upYuCduL1ZMW+aTOIq962Ce9Q=;
	b=TYw986C7zZdGG5PMXxXsHbl0L6sD2/lgC1kDfKk+r73YJkTGo/5kDPZogloK1luGueoVVz
	9WhGVY6AfzIlP8A5H9pobioeA2Rmfj+Cjt4ycLanMO3VWE1PN1fWtEkLiUNAoNMrMPEiop
	EU1waCm1R0hGsbNsTRzj/9stASvlRAU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-aD0_HZHLMo6pGbQnhOJnBQ-1; Wed, 12 Nov 2025 10:51:27 -0500
X-MC-Unique: aD0_HZHLMo6pGbQnhOJnBQ-1
X-Mimecast-MFC-AGG-ID: aD0_HZHLMo6pGbQnhOJnBQ_1762962687
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-882381f2092so48512596d6.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:51:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762962687; x=1763567487;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H6SbkVI3Yk0stVlEf+upYuCduL1ZMW+aTOIq962Ce9Q=;
        b=oa96kP9CltKtoXFLr7EF/HYHFhxN2qLEtG+Bdtnmx/bEknKtmu4bLuZOAEkEvLwoMC
         vSZjHPwTEnfWhfHPdxK9jPIjbYEtvM3STbY0tboBB8md69sNYcddLo/amd997eHAQxOO
         7oZmQ0XNGawvEkII3KI2+6mDIa8UrSgScuKNLehjwwIb4Fdzu6si0Tgc6+nTLWI/X1a7
         9ekf1NfEA6YYS2ldJTZuyXWOz/6W2eEI5j5AyudHeuOuNXtFPu1hDTh/nObLsYFgKmrW
         3aRrMd6+xAp1XZYP8gFLjJzXB8jPc78cxPhBrOLOgAsNPcmZ7hlYCaFLfahyNYoYpeDa
         R6nw==
X-Gm-Message-State: AOJu0YwnajVkMeLSDjHfIGLlNG+bGvj4oChdYdvCiCSpd/nvn3yqdN6b
	INkWU9Qz1gmony1AS37Ex7q2xoWWNOaByrFCVA3i+d6zYh28lLOEhkWbuVo/9BnDlbur0bejCKq
	8R3/BqEdTA7e26J+4DToAxxzutzFSuc2xiahKw/wqxibRVPz2qZTLsrOdZh8wAhSV7R40isnbDg
	==
X-Gm-Gg: ASbGncvB0L9yrf7LNQNljDBWej+3gakH5cavXKRC2dFDARwNd5mHDHV1cITGD/8Lznv
	L32fBNfi3l30J7wQZbnyNgtamXFkpZi5w0rRu8uDVyrsRW0X20nD5C1Xp9vWBfe8f2LEChzNkq5
	lTW3Apo7MUzo/bcI3eHLZb+iSLMoT1I7PI31OepM2Ff6f01P3H1st6XwsltNJR251Hok5UJ2r0w
	47AHZMXtqChaE1jo+JmPccqcexABj7Le+gLU/XbAtKY9kGsdxEFd+MHZ/z7WkmXicma8myJzQ8Q
	2Q/elTJ8cajZyjVXRzAVgAjr2i6EQ1wEflInwMEpZOhjvDF3XvtdM1PLDeGAaGO0pQd3uLefBWG
	6/SCpr8jT5s/vjShzvi/VyWjP8V/cuCA=
X-Received: by 2002:a05:622a:5a09:b0:4ed:e4b3:f154 with SMTP id d75a77b69052e-4ede4b3f60fmr15513521cf.79.1762962687077;
        Wed, 12 Nov 2025 07:51:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2O5WOQoQmjZihHMDNVPZAEtJPCfBoGTaLokSzagp7NlP+UqfxzDgKXHSqM91D4BHkajvEZg==
X-Received: by 2002:a05:622a:5a09:b0:4ed:e4b3:f154 with SMTP id d75a77b69052e-4ede4b3f60fmr15513211cf.79.1762962686742;
        Wed, 12 Nov 2025 07:51:26 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda561a030sm86883231cf.3.2025.11.12.07.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:51:26 -0800 (PST)
Message-ID: <776f5024499738fcc4fa1d6e8322a2ae9eb38d0a.camel@redhat.com>
Subject: Re: [PATCH 0/5] rtla, osnoise: Fixes to address intermittent test
 issues
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, 
 Tomas Glozar <tglozar@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa	 <wander@redhat.com>
Date: Wed, 12 Nov 2025 09:51:25 -0600
In-Reply-To: <20251112152529.956778-1-crwood@redhat.com>
References: <20251112152529.956778-1-crwood@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V2enZG7AohvOaqfQ7k7J63Ios4UGSMjdpQ78VwZ5glA_1762962687
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-11-12 at 09:25 -0600, Crystal Wood wrote:
> With these fixes, I'm able to run the tests in a loop overnight with no
> failures.
>=20
> Crystal Wood (5):
>   rtla/tests: Don't rely on matching ^1ALL
>   tracing/osnoise: Dump stack on timerlat uret threshold event
>   tracing/osnoise: Array printk init and cleanup
>   rtla/timerlat: Exit top main loop on any non-zero wait_retval
>   rtla: Set stop threshold after all instances are enabled
>=20
>  kernel/trace/trace_osnoise.c          | 46 +++++++++++++++++----------
>  tools/tracing/rtla/src/common.c       | 20 ++++++++++++
>  tools/tracing/rtla/src/common.h       |  4 +++
>  tools/tracing/rtla/src/osnoise.c      | 17 +++-------
>  tools/tracing/rtla/src/osnoise.h      |  5 ---
>  tools/tracing/rtla/src/timerlat.c     | 29 ++++++-----------
>  tools/tracing/rtla/src/timerlat_top.c |  2 +-
>  tools/tracing/rtla/tests/timerlat.t   |  2 +-
>  8 files changed, 69 insertions(+), 56 deletions(-)

Oh, forgot to mention that this is on top of Tomas's pending patches.

-Crystal

