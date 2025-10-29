Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2748E1BC41
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747826; cv=none; b=ZZgqo4yqN+L1AUuqSEtjEiTlFIqS+VBR6InhgFeLJuKd0gHgM2PxaCLaCKNnujnB93wyzQJ8hnHPZ4dUmrtoNPcKNgxNbRTjfFCwddfzRkE5fGEulEGqhifQVs/WwXgXF7TO1CtbEfXj71WDC0g3+Q7m03eCIJAmwDh/qEgACLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747826; c=relaxed/simple;
	bh=DNo1hgqNvRCyVfNHnBGy4JS7DKjy9pyFK/LBe0nXLBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0xnWR8Oy9WspK7IHfMNglP7PBxo4cbhAUAPPfgmiquNH+IfMltenzW4q7vwJo0Mt7FwptmVNYnoXIhJ5fI4FLXtRK0RPocmQSBqTx/yc96x1MEOc0orS2M322FbGDGoRafwV6+VlGFbFYWWOpzAUeYtKFMxTgDQhNiqn2x0nIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kxh5ODqH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kxh5ODqH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761747824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRvYYOi3Wkd2PUfDCfc7B7Ic5qwV5aXr9YzsvzLTMYY=;
	b=Kxh5ODqH70vONys+M1SGbHYCWK6OKUgpIxDk/ocznfQQo10Dto58ThRIh0otRVsTkb3pkB
	LXiu47fz7CvAyGZXoL0mSeOmIl72NeatlNLot3PZUKdfIZ/piQlaViz7qKTOEu8pv0e+35
	KtylDnAIT9TzUFiLf0peMmEbXLzHYHM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-tuzuTkI5OICbMhNeH1ehRg-1; Wed, 29 Oct 2025 10:23:42 -0400
X-MC-Unique: tuzuTkI5OICbMhNeH1ehRg-1
X-Mimecast-MFC-AGG-ID: tuzuTkI5OICbMhNeH1ehRg_1761747822
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-63c0edb0593so7725706a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747821; x=1762352621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRvYYOi3Wkd2PUfDCfc7B7Ic5qwV5aXr9YzsvzLTMYY=;
        b=bBSiGForm0WNxTvBjVIRbnh3qgdgzIly/LC484xopZgFf2auD5wx0VofmT2WxDccMX
         KKHcL41SbRA3Eoyk25gkwi9LdcoKzY3kqjgtXkU366Zd8/3SsNCTQGxneu5+5TvokFq7
         GEylsbIvlkZ+9vMQRIr4DcunBH7hCWtVOocMGlVhaorsp/OmfOYJ/4/RT6NRlxmbfNji
         Id+iudrAZNPydy47J8t4d3n/uMhdlGbfkmJeiRDj+WxwnGATzfapPph/WGs2kjxQddKn
         sTL6fx/N446sXLphy4l0snKSylcM6J+nOboDeryrzo1wfl7WFcdRLw/wF5ZFhYZFVDBT
         Lj9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwC/ZS5mG4BXvtkxyGxFdO0DC1dDnAhaMzxCPoadx1Q8Zn55BdFMZsqAWJ/D14NtWaH93jSGwPSZHVyEzxzC1MC9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWVVU2ZCqPvWCML2bFP2U02GE1/WhZP2VFZSatpheNws/DaD4X
	r+pjI2eqcZ7RDB80SbJWhsPCwPO943S2D44psOl1lNFukVfBWayLmnMEUidsOaDW2b6UCboz6b2
	aPV+eM4pwFcp1jVfYf2jwHeyRYQkxioA/LacmwZJUwAVJt4cFCvQOfWmg4BjUI9BvZdSeyj5d/J
	kLNzfXGXGcCE96CqeDbZ4Egb+dPJyjwwxhHtdTNERim/Nu915Y3NzQA69W
X-Gm-Gg: ASbGncudWqMNmAfDa09Ml56+bzID5C5mIizC9ZevZKNz++kpCxVQSt/ppbJRLYkcS0P
	Vf8kDj6T5CjPgaEiP4h2js7fQBo8OBAjxMS1GVap9bgDIZor5alpFhzCvqG+N/GKH644XZ0KiqA
	vb1m1IbKcUsD/AtCxYp96CzjAC3PHE5jt5zWTu28ZZ5/5GCVNbPcUh2P6Hl3F5GndCjSLx7m+78
	/wYbDeKrnxqpA==
X-Received: by 2002:a17:906:f5a9:b0:b6d:c3b8:8611 with SMTP id a640c23a62f3a-b703d5b4967mr287114766b.61.1761747821392;
        Wed, 29 Oct 2025 07:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExh0b3u6BWRWoAABr1Huy6PhU+hinwtnzc675AfZTC2+zrSaIIz72xAgHbBa56QuCvP02Fk/rwvNoJCpS7CqU=
X-Received: by 2002:a17:906:f5a9:b0:b6d:c3b8:8611 with SMTP id
 a640c23a62f3a-b703d5b4967mr287110666b.61.1761747820414; Wed, 29 Oct 2025
 07:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011082738.173670-1-costa.shul@redhat.com>
In-Reply-To: <20251011082738.173670-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 29 Oct 2025 15:23:29 +0100
X-Gm-Features: AWmQ_bne8eATCgcz-kIZPYttDtQkP6BK84Xmqvl3A-YIoIrM1rI1wUSAK_U5m4o
Message-ID: <CAP4=nvT_MUKx5JzsLBg1XoFMmku3z9NZ4NjY1WFc2QKaGnPZVQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] tools/rtla: Improve argument processing
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p6DVSX55Wmido5irHiajA94m7EofDl54-gErR6J1QqU_1761747822
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

so 11. 10. 2025 v 10:28 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> The long-term goal of this patch series is to reduce code duplication
> and unify argument display and parsing across all four tools.
>
> Costa Shulyupin (5):
>   tools/rtla: Add fatal() and replace error handling pattern
>   tools/rtla: Replace timerlat_top_usage("...") with fatal("...")
>   tools/rtla: Replace timerlat_hist_usage("...") with fatal("...")
>   tools/rtla: Replace osnoise_top_usage("...") with fatal("...")
>   tools/rtla: Replace osnoise_hist_usage("...") with fatal("...")

It's perhaps unnecessary to do one commit per <tool>_usage() change.
On the other hand, separating changes like this helps backporting (not
much relevant here but relevant in other case).

>
>  tools/tracing/rtla/src/osnoise_hist.c  | 74 +++++++++--------------
>  tools/tracing/rtla/src/osnoise_top.c   | 68 ++++++++-------------
>  tools/tracing/rtla/src/timerlat_hist.c | 82 ++++++++++----------------
>  tools/tracing/rtla/src/timerlat_top.c  | 76 +++++++++---------------
>  tools/tracing/rtla/src/timerlat_u.c    | 12 ++--
>  tools/tracing/rtla/src/utils.c         | 15 +++++
>  tools/tracing/rtla/src/utils.h         |  1 +
>  7 files changed, 128 insertions(+), 200 deletions(-)
>
> --
> 2.51.0
>

Otherwise, I agree. Especially the timerlat tools have so many
arguments that for a typical terminal size, you won't even see the
error message, as it will be pushed outside the view. I was not even
aware RTLA prints error messages in some of those cases, I thought it
just prints the help for some time.

For entire patchset:

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas

