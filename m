Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8961FE45D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686702; cv=none; b=jyagSpbY11EOV6e6tHFq3/T/1sP4oCGGcfiGgd/NDnYOs7ODzT/ebEyzXJCns0JmDsb+y2d6r6CqvbBAc7wEVO6jBP1k4s7yxlIYWdA9fcTowlYiZMBLQRREj20aiqCyU1Ii9ajDyMautRRQVY1InuxVF5oPnNnXSt0I9EkKU3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686702; c=relaxed/simple;
	bh=1xR3x2p3tXsNA4DvviIFatm78+RRJrSmhV0Vasqy5JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaCYRo6nWfPNowtiwYn6wXu9+vAMr3OsReJZzXvg6Hudlt8PjWopjAVNn/fwglBZb6CAIgrB2x6Kc43bH5vK0MibRr1UCPKFqoSTDONSvaGBiJLqUkxj8iT1XpgxCPPGNrk0XAVYe+auX6qAXUFkFd5qWYT9J7D8WWc0kaugkaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vv2SXQAh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vv2SXQAh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760686699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwE3xOWvcSpkeyeMXo0ARX5UbAfzECMBwVn6tM+Q/Ds=;
	b=Vv2SXQAh8WzdqnakWbCRJ2mHMwkCFRtd6z1/w+DurUvfrESFROMcYkw1q6f6n1HpJYkdQo
	sm1qtFCVr99CYt35v9v7N8Mz8qAZhpDYpeQz8T0T5wCtI+3bBt0rSIoxtGkAwwHtWX4wrk
	/ICNHT0LfepYGfgeOmgPKJM+BtgyaLU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-D0jWjOOINiKCgttJCIj4rw-1; Fri, 17 Oct 2025 03:38:18 -0400
X-MC-Unique: D0jWjOOINiKCgttJCIj4rw-1
X-Mimecast-MFC-AGG-ID: D0jWjOOINiKCgttJCIj4rw_1760686697
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b5a8827e692so182014266b.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760686697; x=1761291497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwE3xOWvcSpkeyeMXo0ARX5UbAfzECMBwVn6tM+Q/Ds=;
        b=EMYH0iQfBKZ2Df8V+aLBXUR37yo68Itym4+GdGBvHgO91Iw94xDTG+nsTqFrSudjAR
         P3Ht1+QgSvmCEiS11pm0RE55C52D3cNamTkeQXWEocbymCD6lntidHZDcPx4Z+u6+jmi
         njJ9fV0vihRfG95UzkRhhlRM+I8seS0HehleHRoTDlL59mVmd0vQjLk4D/iIMZ7tsGtS
         pfm7P5Rdp0NsqFwKmUGosnOs4R14LDZQ9nr2uA7LubPQd89A2Y9IMWKOrxWvPQuzkZe8
         Lh/eH96ZWMGjA4Gh6g/pU0MJJ0b2rGJ6F8ubFkfae253dXbQwo4efdg8m5PyRFqxC+yL
         o6PA==
X-Forwarded-Encrypted: i=1; AJvYcCUWGQBBJ5dK/iaRR3O2zcihTY6tMjKJdZAaIshpK8DZTRktK/iPg/PzPz41gLalNilX+NG1XlNDMt1H3WOJWI2BpUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrclxqAsOET9PB/9J+6R6CGHqIZNTHFs/hNjcNmTyz8bHx0iNM
	E1PcvDqwkEhVwLGzb+C+fVskfNbdtTCxD5qphvBPdnmA2ctAXSnuKSsLbevyh7r4EQno0GkJqIx
	ceb6WOxZaOQ4SZCSvpOXRa0rEsy9Cmta+5MB4/tR5agBzApyh4lg9HdEGgvle/Qjb2OR8GLY2u5
	4BPRPRBCUZZRhm0r7Kf8sYW4gXtvfXKCf5TR49Y3KR/8yxIidh
X-Gm-Gg: ASbGnctec6WFkoJf3poRp2xicW7Z1aktwkjGTPR1j65fWZRxAsOdzyioLKOf2vjM21W
	xTEJezcUZ6y55mA4Jf9ipGRjKXuhzss8c/j9iiRRq6CUily8CWhlAmxsoKuRtMcOpPfflhJQf/4
	6wl62Ocs/eGY/ZDlJIqgMdhUKRofNUVfmnx5bFTF8FThn64j0vS4ADmNlU9aQB4PRzHDFvMOYCZ
	o7kmKe0P33WXg==
X-Received: by 2002:a17:907:9691:b0:b64:6776:1ee2 with SMTP id a640c23a62f3a-b6473f42d78mr267631966b.52.1760686696659;
        Fri, 17 Oct 2025 00:38:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETvQK8H1/2i5HNhE2R8KrdEFfqmdiqiQ1Yyb8MzQowPWJTSEJRTSXf97XI37+HGFw6Cuuibf+3ZWnRVCFNtKw=
X-Received: by 2002:a17:907:9691:b0:b64:6776:1ee2 with SMTP id
 a640c23a62f3a-b6473f42d78mr267629266b.52.1760686696193; Fri, 17 Oct 2025
 00:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007095341.186923-1-tglozar@redhat.com>
In-Reply-To: <20251007095341.186923-1-tglozar@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 17 Oct 2025 09:38:04 +0200
X-Gm-Features: AS18NWBD9D8J6fwp3TFhCJma1f647xufvtF8gv38JqAH5X5RFzQIY04cHnhavb8
Message-ID: <CAP4=nvSmJOdoO8q125sdzvR7ix1oVsNobSRtWb7ADUADdzEPiw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tools/rtla: Fix --on-threshold always triggering
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Wander Lairson Costa <wander@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KleWOIfH1C0EShuuzTghRisLpCtYERSOIXndVI3Yi5w_1760686697
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

=C3=BAt 7. 10. 2025 v 11:53 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.co=
m> napsal:
>
> Commit 8d933d5c89e8 ("rtla/timerlat: Add continue action") moved the
> code performing on-threshold actions (enabled through --on-threshold
> option) to inside the RTLA main loop.
>
> The condition in the loop does not check whether the threshold was
> actually exceeded or if stop tracing was requested by the user through
> SIGINT or duration. This leads to a bug where on-threshold actions are
> always performed, even when the threshold was not hit.
>
> (BPF mode is not affected, since it uses a different condition in the
> while loop.)
>
> Add a condition that checks for !stop_tracing before executing the
> actions. Also, fix incorrect brackets in hist_main_loop to match the
> semantics of top_main_loop.
>
> Fixes: 8d933d5c89e8 ("rtla/timerlat: Add continue action")
> Fixes: 2f3172f9dd58 ("tools/rtla: Consolidate code between osnoise/timerl=
at and hist/top")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> Reviewed-by: Crystal Wood <crwood@redhat.com>
> ---
> v2:
> - add one more patch fixing a bug noticed by Crystal in context of
> the following one (doing v2 just to avoid conflicts, the first two
> patches were not changed)
>
>  tools/tracing/rtla/src/common.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>

It seems that this patchset containing fixes for recently merged RTLA
code consolidation [1] has no further comments. Could you take it?
(Unless you have any comments, of course.)

[1] https://lore.kernel.org/linux-trace-kernel/20250907022325.243930-1-crwo=
od@redhat.com/T/

Thanks,
Tomas

