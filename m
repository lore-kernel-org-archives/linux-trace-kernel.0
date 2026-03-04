Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4A63B582E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636233; cv=none; b=YYg80dTMp/D522fP3At4COUaYG1ZbMbivEKhYPzlCn0DWW2WtWiM0k+yGSYou/ttXWckB3FB2koaPLOXVfuTb9i9zk8V7DvRByj2kBYK7HrxQZi4iYVa00zyk679QatgPmVl2WCN4L/r27m1+H0eqarMQN5zQEI7lW5+H5q2dmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636233; c=relaxed/simple;
	bh=oHGf015O3HEFczpp/doR7GCeyn5AXcOYhDM9+nhRjvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VABzpZ6aE93E9gCmxRBrU+NIvLr9zic3qgBPukUjz6/Dr4n1QnkKlm/mkCt6nkofDTuMsOcO61gjSQL3R1TByGM7VJcxE/KPtB+lieG9P9ia8P/nNJQcmYhZEJM73yvD6XO/B76TVias64eYO2dIRFxioLiRZWoikKQz7pNaSD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZ0vTi/c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZ0vTi/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772636231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxcuwNQEbPJtChtRmmX8bmzTS5j+ytdkrBn203bf/CM=;
	b=gZ0vTi/cvWDc+O65/cI39IqNyvDoaTCKKPIcIRUqgH5JhTDmGftEGgUKDymZD8smDtAt1i
	RdzCbl0DMtBednk3XPlAGV+lJSG7VSDjZaHNCYhRgQP1nZxoKYzEIYI9rndZdGM85Jyf/M
	k/jrMj853L4zDO8MB2P3UFHHvbsl+SU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-ZcY8f-vAOpKJzxTxuO4apg-1; Wed, 04 Mar 2026 09:57:10 -0500
X-MC-Unique: ZcY8f-vAOpKJzxTxuO4apg-1
X-Mimecast-MFC-AGG-ID: ZcY8f-vAOpKJzxTxuO4apg_1772636229
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8f9599feb8so515479466b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 06:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772636229; x=1773241029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NxcuwNQEbPJtChtRmmX8bmzTS5j+ytdkrBn203bf/CM=;
        b=K1lmVQhv3vpFH0Uhus5rnDa57zpf9TEL5oftA2p2vDMu8m6j6qgW/QisYtFluVRPaX
         QLtLLmo97vBIZSa8GSH7oHds33ueSvitheKJteWBXcY0Xtrb9/Ljiti3Mfp+3w/CXxkm
         M24l8moIxcGLHG8eqSve4H5vA+NNjDGkwnJlGMjhi3MXjUswh8809iTZm+EkOG3Ac/fY
         p7R/eO2IcM6fpwKO0cArhBc/+HeRuzCb7+rO7hX8IO7jscz6od1Edr7YOEFaFJtjlEp3
         m4K5B3isx/X6GYKG6iZjouf/75IZ21PCg41Vq3nYThCx6L+LH0R5+evAFERCEUO1Ca8a
         kgVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr6WO8FsP9nVTMNFn5CuaB0uLbLtG4cP2WP9Yjj41fFs9OZ/YZ9rEZRsRj7wtOE8iFdGRz3JfBWJZPNa+IwHwJTPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl0nd5PHaFwLvqlqzCgvyrt+7jXF+MHWyVt8tjL2ZvgwJc2nhy
	YGG7jifYBU7bJmBb//OYLF4X98S6uOeEWaAnbPhn6wvKTDWXeeR7sBRPsMI1ZPrELzsK1y0Y+Bn
	36epxDVBUwkIMMlkdwZ8dFxXZVsbS7GG9uYglsPbwFt7bs7BOTUzI2taPMquk5w+eMHIInph8xo
	YSp/4vOvPtYAC2juX46WbssSNHN/+lmvsZyTI0WZ4xuRITM4Lg
X-Gm-Gg: ATEYQzx9yHtxZxjR8+DDW1dHSOTFgR3ohcKVbroQjWgCK7PaL3gkKBejj6XSWEFgGf1
	9IGk5Z39sdoSOekzeRebYaXC+X0BECFhf84Bug3EHVOqNfcif9Y8aC/ul8E7IwCOkxuNXMmfXV5
	hTMjTuPp/eXx54jMTqzc2FPME5khDU/4eo+unuPjwM/mIoamNzb2pk2JYJEF2bO/SxM8IM3TglI
	Ce2ig==
X-Received: by 2002:a17:907:d18:b0:b93:a3db:a6b9 with SMTP id a640c23a62f3a-b93f1584a51mr122661166b.53.1772636229398;
        Wed, 04 Mar 2026 06:57:09 -0800 (PST)
X-Received: by 2002:a17:907:d18:b0:b93:a3db:a6b9 with SMTP id
 a640c23a62f3a-b93f1584a51mr122659466b.53.1772636228844; Wed, 04 Mar 2026
 06:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213115234.430232-1-costa.shul@redhat.com> <20260213115234.430232-6-costa.shul@redhat.com>
In-Reply-To: <20260213115234.430232-6-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 4 Mar 2026 15:56:57 +0100
X-Gm-Features: AaiRm53z50JmqmT1o6Ph_54puJ9QJQq9UavtQvA3Nx1tVw-urpPxa1yu1HVK3Tg
Message-ID: <CAP4=nvQZT9GB85cHkkFBL+BRzsiU+15RG7a1aQ3jp4BPA+1Axg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] tools/rtla: Remove unneeded cpus parameter from
 timerlat BPF functions
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BwO23dottEcytPTISrgTgQmObuz4NgwJmKaC7KjV8-k_1772636229
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 13. 2. 2026 v 12:53 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> nr_cpus is a global variable available throughout the codebase, so
> passing it as a function parameter is unnecessary.
>
> Remove the cpus parameter from timerlat_bpf_get_hist_value() and
> get_value(), using the global nr_cpus directly.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat_bpf.c  | 16 +++++++---------
>  tools/tracing/rtla/src/timerlat_bpf.h  |  6 ++----
>  tools/tracing/rtla/src/timerlat_hist.c |  2 +-
>  3 files changed, 10 insertions(+), 14 deletions(-)
>

Is there a reason to have a separate commit for this? The change fits
into the "tools/rtla: Remove unneeded nr_cpus arguments", which also
touches some of the functions in timerlat_bpf.c. It feels strange to
have some timerlat BPF functions cleaned up in that commit and some in
this one.

Tomas

