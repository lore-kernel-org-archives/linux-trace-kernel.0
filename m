Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53462DEA78
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188918; cv=none; b=CWoQ9H1fU6xSh7rLYWw8H+OHvbjpqrL34sZYrmQzzhVY7uhlycNfQaxudJft65dwGuxLUrWIxDznIL2Kf9t0piGOF3fu6BBTKiHNbaJtAByecYduUTiHrmhJwj/wzDPcDM66/s3uxPNcSabg20pUXQ1gpZNDtFmWzufvG9zCyyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188918; c=relaxed/simple;
	bh=EmInYaunaNmV/6zUcr9DfS0VIdcW0g5PF82BwwIUQSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StxNOvczHkB5QP5hAueoaRCeRdsRJwA421TFE6clslwBCrnx053bWNohOPSP/rNfXiOVSBA5C11XXHMaA1jF3THtfmuvjvwOKzMsvw1AD9KQhL9yW8E6QiqAmGfV798tzHiLU/V+aBw3wyaVD+CmVTukFV9lhDoyOFzl6t11u9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4eRl3Wo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4eRl3Wo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758188915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmInYaunaNmV/6zUcr9DfS0VIdcW0g5PF82BwwIUQSI=;
	b=G4eRl3WoPI7HTgsvpIPI4nxq1oCMm54NFOkJeZj38odHyUXCknHfEbEsOLZ1tSmtkjXtGd
	CIBCgU0Vs7Vv6FCk97cJ003GuIbk0sOq5zs0W6srVMPRU1Sg8gFzdwvWdRyqTVosj/NGSP
	bpYNOGkBSmocgS3MsJ6lHyHEaEfwZa4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-uSoxx01BO_WOmOMQzYS3tw-1; Thu, 18 Sep 2025 05:48:34 -0400
X-MC-Unique: uSoxx01BO_WOmOMQzYS3tw-1
X-Mimecast-MFC-AGG-ID: uSoxx01BO_WOmOMQzYS3tw_1758188913
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b04a302fb7cso65919766b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758188913; x=1758793713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmInYaunaNmV/6zUcr9DfS0VIdcW0g5PF82BwwIUQSI=;
        b=XbIEcPvv4t4t5in4Z41e84/ttR65PNxCTWnj/5DdOop41d0zVdw4oyhsfK/YgOSZTc
         FZAZn3jl3e0ETNtqHBq5RHLrGBkL0Z11Tp4Vzw/bF/OYbe1HERw5UPhMh9SkdUCfhxI8
         QYFMHCtEMqEWMsEeQ25D2sun+rxvsvMkuGl5+cZpWh9KC6se1UnvPwjr4HJlw+lPzUNH
         jeQv88Oaqf0Uf6MUrj/8XI/Gsae5o0XKXXBtw/bmVGATqPeDxwL7A+xBsGQG73R0+qzm
         aa34odxLw5bPHVVq8L7pAu6TtlTrIc4wuflF1Am1aEgPEz8TcmqYvpxvtarw64OOaYjU
         NOyg==
X-Forwarded-Encrypted: i=1; AJvYcCXOvtDKgOkRQWjGxfVQ/3M/KhVTjYIc7saVNdeQ3hsZXd3mHsTRVUO4CQJJnUteFpmh8LjWEwfHz1uJ0R5eqQbCs3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSuYzlf2iYk54IhplrPEgRWkhY2mKAMF6ahs8q876jiJGcUmAo
	eLQq9wZ+iiKx4pIw9SLJPhbh7a/XbZOtRlrCLwS9c9Izxqbv4wOU9NTj6uXeTRBhK4uI3FSPUIn
	0VG1l7CKYcWFOaR39zFYxUq89rEUSueBPMLEKdkuxRgNLmp60vzbDpMz1pcPCzbRSPuirg9tmk6
	WRybcn4P1Zw07/2LZ2PUHAi3qNyyOyGIuGzQjtYl6dFrMtwxyL
X-Gm-Gg: ASbGncuoYm6PChhsJuru/ZZvfU5TyeqLKilWC1qybr9EtXDP8Nx/rpU8sIPtngxQzhx
	SWWpo/kl+cHY/1Fi3RJfaGfVWGjNjXnllo5UnaOhHm6GUPVGE/Cndvu36ILxO1h9ssbe5TSlkQ8
	aBIa6qnZe2yVqd+iGkSq4=
X-Received: by 2002:a17:907:3f92:b0:b07:c1d1:4b66 with SMTP id a640c23a62f3a-b1bb0a58881mr550058666b.14.1758188913002;
        Thu, 18 Sep 2025 02:48:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiFiNaHlnga0hzmdGivv/VedW59DyeYKuiSLPjD3GzzmXqIMvv3g/i6ajr9VY2rJh92Ycr4RY/sk9qzxInqNw=
X-Received: by 2002:a17:907:3f92:b0:b07:c1d1:4b66 with SMTP id
 a640c23a62f3a-b1bb0a58881mr550056666b.14.1758188912626; Thu, 18 Sep 2025
 02:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917125733.2346923-1-xiujianfeng@huaweicloud.com>
 <b2c19df4c5036e956e4e892ac983d5488a8b9614.camel@redhat.com>
 <87wm5x18bf.fsf@yellow.woof> <4e8bae6a0ada1d52893381e7542220973f0367fb.camel@redhat.com>
In-Reply-To: <4e8bae6a0ada1d52893381e7542220973f0367fb.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 18 Sep 2025 11:48:20 +0200
X-Gm-Features: AS18NWBTcF6lx_o9yCpPYKeSkiitGQUYQd42DI3f4Yb72dBJAlSdumPnJotSE4U
Message-ID: <CAP4=nvQubUmOVivgzOtYRhMmZaq75WRmRdBnsn0HYJfHHZhzmw@mail.gmail.com>
Subject: Re: [PATCH] rv: Fix boot failure when kernel lockdown is active
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nicolas.bouchinet@oss.cyber.gouv.fr, 
	Xiu Jianfeng <xiujianfeng@huaweicloud.com>, rostedt@goodmis.org, mhiramat@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YDhE3c7h9ohC69IzCqtKlh49v_T_5piVWEZUDKf8Sgo_1758188913
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 18. 9. 2025 v 10:36 odes=C3=ADlatel Gabriele Monaco <gmonaco@redhat=
.com> napsal:
>
> Yeah totally, I have the feeling that with the kernel there's no such a
> thing as a "theoretical bug", kinda like a good consequence of Murphy's
> Law.
>

My understanding of "theoretical bug" is that it's code that is
semantically equivalent to a bug-free code, but becomes buggy after
doing an "innocent" change. The bug might be more or less
"theoretical" based on how "innocent" that change is. Of course, in a
codebase of the size of a Linux kernel, this tends to happen quite
often, and is not always possible to get rid of completely...

Tomas

