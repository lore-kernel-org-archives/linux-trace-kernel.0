Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4F5322A25
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733803; cv=none; b=eZ29+AV5PVmhM7+5s9qSZ90/+Iq3mPjdErUKBuBWz+/hjvRF26aK5Rhbdf0784kcQvZAB94yqaj566IZ1UUl75rWL45in+jrZKxCtZXUrMg3tA5bFniB0zEb9v+HNLEeUkUdOeSbchiGdS4RI/Evfp7dspW7y2POEX3IFp/aoiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733803; c=relaxed/simple;
	bh=1xvw6jnS9dphQU0A+xYtPnJM0bu8KsBQ5+TFi+aJW9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S41wF/hAYf0RWTGChhz+bP4AxOS740ahZ7lscrGOnTk/p07xNZ5f+e5J3gxBf2PhDhV/O/agjNt4AQNE93IEeLFlczyAZCRRZZ3DoaktYk2AwD/BfZMWlsOADL5R0XARLmZgJKU/yT3/WnUSeS9p824xoSvZlUuwGakZd+l+yaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bg2j4d8B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bg2j4d8B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761733800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOr0TIPF44tJyJqYfe12OzLBv1F0AjLtcIhaWVvzF8I=;
	b=bg2j4d8BwlIJ7hz2S7ZGWCDqje5f8Uylf5BHjCzcsFDW1PAXPIzDd3MXJp4yd1pRtzcqnQ
	+lgEFW4YkSyRU0+vcJyONW1vhGNDQthRwGeTO/v2vD+BgfjFECX9/qZJSG6tjqb3VSvqbN
	dwmAvj/vK6TGIFi2pOj7GlNIiRWSUZc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-foZ2-63RORK8-53lJ_kzRA-1; Wed, 29 Oct 2025 06:29:59 -0400
X-MC-Unique: foZ2-63RORK8-53lJ_kzRA-1
X-Mimecast-MFC-AGG-ID: foZ2-63RORK8-53lJ_kzRA_1761733797
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-378d61ceb31so39507161fa.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733797; x=1762338597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOr0TIPF44tJyJqYfe12OzLBv1F0AjLtcIhaWVvzF8I=;
        b=KWYDFFUhLb3w19E6QyvdMy+pPavEuNEnhrfBQiGcZrCfVx6icqOjNTdgy2zeNE47A8
         S9J1yKqM1QdaNWK5zW8g/riy0rEAc3VbfhgFqikYto1iRxsMlu19lcA1O7QGev01PhNu
         E6zdluMqDWKt3hPMHTRPzTvIueqP2uuQVAQAmUe5YgL+jwAk2oxBu8k/68cLzyIxomSh
         ZAcO1Kk5jFmM2fhuXa4MrYxWYE2cZsPZmYuWJgJswoBp2UvbU9h4ruN0yhgKZ0sHW+Ml
         5WtGrD2OjKe+N9Q+Um02+zwKDk0Mz5wayzhTvBQoJ5WdNTKrxj6stzTyBORWtztAa0Cq
         VJ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6BGDMM6V0bvSZ1flyw3TAsG2bCWJmDNjUhQQhS5z9FCtv3IKxs4XzM8j58AnygPDJHAeTnuIOTa5DveVUSzDsz+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzo0cZ1ye4xKXcwC+WST0dNnRtSInpgKtuGggqgYGECGScShja
	z5sPOcy77RE8/wNu+fR930okIAsCtW2txNdtJV4nbWQ+eL52gOR7mArCw4G2jgW9BKUSeT7F1Gx
	2WxrYDsPfX6mytCq5zRW5I4ArAiHQKKG13rbdj9Ga4uZYS8ZnsNGix3WOOkOhzKHTqTWdr/b2+U
	CEW8IBRePkCe83qZCzkT4D1CLmBKx4QICWL4TjMwkqe6reu2wm
X-Gm-Gg: ASbGnctRfuGPCGqzreRXC+0/xZqg4GZ61AvCc5jmOJKeDh2bz1YJlqhgfhMGmFz9H+C
	67emPG+kwo2uS3/2lKAvz0I0cZ51O5dKkQ/eTt4uXwdEXvVeF8zp/RyhxS4HbB+4D9yJvIFEmbR
	B/+uX30Us1RM/0NPMq4GgYe5lAtJkOqbCQkeukMHOvbyDibJFNdiazzqN6IZuOSWb2bShSg7jDU
	LAN90vgqzsltA==
X-Received: by 2002:a2e:a912:0:b0:372:88fa:b680 with SMTP id 38308e7fff4ca-37a023fe4dbmr7196301fa.29.1761733797405;
        Wed, 29 Oct 2025 03:29:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEmI7OhiZ1DaoF0/cxs1ZCK1+ak753Z2dzk11glrhPicvhcrDjwhlHyltg40JzvHXiomdTvuMbjo4fn2pfDVs=
X-Received: by 2002:a2e:a912:0:b0:372:88fa:b680 with SMTP id
 38308e7fff4ca-37a023fe4dbmr7196171fa.29.1761733796930; Wed, 29 Oct 2025
 03:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002123553.389467-1-costa.shul@redhat.com>
In-Reply-To: <20251002123553.389467-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 29 Oct 2025 11:29:45 +0100
X-Gm-Features: AWmQ_bmTMI8Oo-s2wgCfKYhoIUrQHQvFY47fFfRRzWpWMdM4FSdSOWEtRJKcdR0
Message-ID: <CAP4=nvQbr5Adrk6_TDLge0TfqOwOhE9Q4iRzCqQKpwx29d_QHA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] tools/rtla: Add for_each_monitored_cpu() helper
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Eder Zulian <ezulian@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iopWLrfDtA0Mx_7B6yXtkcvXjLr1M7Kf9gCNp4P5s44_1761733797
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 2. 10. 2025 v 14:36 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> The rtla tools have many instances of iterating over CPUs while
> checking if they are monitored.
>
> Add a for_each_monitored_cpu() helper macro to make the code
> more readable and reduce code duplication.
>

Yeah this iteration is repeated many times.

> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/common.h        |  4 ++++
>  tools/tracing/rtla/src/osnoise_hist.c  | 28 ++++++----------------
>  tools/tracing/rtla/src/osnoise_top.c   |  4 +---
>  tools/tracing/rtla/src/timerlat.c      |  9 ++------
>  tools/tracing/rtla/src/timerlat_hist.c | 32 +++++++-------------------
>  tools/tracing/rtla/src/timerlat_top.c  |  4 +---
>  6 files changed, 23 insertions(+), 58 deletions(-)
>

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas

