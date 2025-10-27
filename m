Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A74F30B522
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578787; cv=none; b=u8QbeTmL8GODnRg0jLrb1wsrHrDqXs4Tp8pqaScGTeP1rOn52rbhMYTm5G1llTEPp6batBDBSQDMt6qy/tKqCsMnk4IKrj8wQGnqApGSYiJApKKl8o0E1313SxDuOEWzsJMXLXNErP1plmTgmM+6vZ60zhT0IWH4oquTF5IvwGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578787; c=relaxed/simple;
	bh=EMBraBs8daNiJCKlZz99Kc9Uwh/7oGCL3rnwj6gVCVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1iJZV/1Z+LcTVgRAa1z8xNoGg3xq+jn3mYGpcUUfEwOBLi58eV1UfcXoCdHjPN81ZEYgFSG0ihmkeBxniVZ86keE+U3O1o19oh334bs+boPsZF48JfDu1dFcvs53JW8/Agl0Vy/HmZ6R7hwMJEyZbw8HuZD6tCgNJbY8uXV+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5Nr0614; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5Nr0614"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761578784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wUoSKh4ptdU13ldJNqwZ2zHLjAmqFPPlpDyTGSZSyQ=;
	b=i5Nr0614xs3dMmvSsg9f/+DV4wJu0duF5SECnf38NpiZ11QqWSdpjon3H+DkD26XW7C6Od
	yWAc+nGMROhfUn01GmqEIapO+TwtJqv/f1o8wZFc9OO8b9aGhW1WbNiBeMgsFjR3T9zG7w
	eNXFr581MdpR1s/+p9kx1ND9FJonOaE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-Cc3VpR3vPFWP73OudqDU9g-1; Mon, 27 Oct 2025 11:26:20 -0400
X-MC-Unique: Cc3VpR3vPFWP73OudqDU9g-1
X-Mimecast-MFC-AGG-ID: Cc3VpR3vPFWP73OudqDU9g_1761578779
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b6d52387ebeso480430766b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761578779; x=1762183579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wUoSKh4ptdU13ldJNqwZ2zHLjAmqFPPlpDyTGSZSyQ=;
        b=GbIN63H2PH5v4yaRpKMBOGG5psb0NpV5tID1+8Nt/332GrQg6FRodhr4FTRcp+Bfgj
         mpt5/mjBsm92+hX3xM4BiJyE/+9TGh3Jz5F4MSsomxzk8dwafrQc1wGNcPrvAP/8XRSm
         GlohV09SIRCwmHs8qXWgGayZKODOuhB2sYx6k104/Bj/j+H2jezuhC3w1YAcO7o/aPi9
         PM0MaMKD0t/6v8a0lLwB3h8g8Y1a55qX547OhoamdIgEMeswmMO0bBIxj0N9HkkxFKop
         nk7P2tZ/rMoDgENNqsuWve5eHsaXJgZJ9kYzPtmrgR9zZVNC9WbrwRVDnChrwiwVPdq0
         d2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWGqrOPF4VDkK1wuOp7CrXCUAeKDgs8VUVvqNpGk6S6xQeLTjOOycgZoSpoR3EhAKZOr0QETNKHD8HZyZ9lzlc6ZeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpyX37fss1fDyoeU0ezDE/nQNRAy6pzPCdnuALajFtaRFcZC9k
	Q9ynJHCHB0/Q1ggliXmt1xzkfC1Jk5U7mvIfzaWakNegvSz20woLPxIs4VCcQwUYoQzBidS4k7q
	+ytAc//kiV23otgCZ3WzbIGCk9YhvF/pKTABbT91YODGwyDWkIvRzTyawniAih1JCxfljLNqNh1
	guVp/Yyuuy0irkFxpfOnpb8bYtoiud8eqaW+Zs01VHxTPlKEh3
X-Gm-Gg: ASbGnctDr6jRTcGLfhwRqoPvBv4yS6s6nEeZpusxzRuMedepukgds97uCf9SPEHDTht
	w4u2sklpJ0A9hh3aARm1fixra9oZfY2PaG2D6NP7plfyfuLOpuYvMt2vTel2fgIoDE1XfxVGQfi
	fT7rY0bOuXoQH7ABKk/+6/tRrqe6q/NTaFe81Rw/p14gvVxgZpZqnsz0SLYWW7LVjBHedbPkIM4
	9ZAuAxiCfDJ9w==
X-Received: by 2002:a17:907:3da3:b0:b04:2533:e8dd with SMTP id a640c23a62f3a-b6dba610ff5mr26357766b.60.1761578779311;
        Mon, 27 Oct 2025 08:26:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLo1ZwaZIFeuJXVwFzBBQ1SpO66mEAfnYV9CYSHn1od6IOfi/WXaTASbeK7sdUdigXxhHX38jLLYZ+j/v7l7I=
X-Received: by 2002:a17:907:3da3:b0:b04:2533:e8dd with SMTP id
 a640c23a62f3a-b6dba610ff5mr26353866b.60.1761578778781; Mon, 27 Oct 2025
 08:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027144819.1034041-1-tglozar@redhat.com> <20251027144819.1034041-5-tglozar@redhat.com>
In-Reply-To: <20251027144819.1034041-5-tglozar@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 27 Oct 2025 16:26:08 +0100
X-Gm-Features: AWmQ_blAhCDUkFOO5Ihq_UEhuUW_4WgK_7PG_2rl87mzwI4N3JTIUNzoUYRpVGo
Message-ID: <CAP4=nvQOk_3_YqTFrLfJVPf5xU+SB2X5AUyUu3T8-GPkTAQbRA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] rtla/tests: Test BPF action program
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Wander Lairson Costa <wander@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aGF2FDeHMjCU5WWF78tHnCa8nG7mx8xAKo0D1sj4Hrw_1761578779
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 27. 10. 2025 v 15:48 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.com> n=
apsal:
>
> Add a test that implements a BPF program writing to a test map, which
> is attached to RTLA via --bpf-action to be executed on theshold
> overflow.
>
> A combination of --on-threshold shell with bpftool (which is always
> present if BPF support is enabled) is used to check whether the BPF
> program has executed successfully.
>
> Suggested-by: Crystal Wood <crwood@redhat.com>
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/Makefile         | 10 ++++++++--
>  tools/tracing/rtla/tests/timerlat.t | 15 +++++++++++++++
>  2 files changed, 23 insertions(+), 2 deletions(-)
>

Oops, I missed the actual file with the test!

I'll send a v3, sorry for the noise.

Tomas

