Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4293387585
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094161; cv=none; b=IgzIYJcT6aRSEcUt6GVF8KcHzHH8buMrXbHHRQHoQswt4dhq9sEJoq/zVxiNUfT1p7CYy+CSOXeLB0+OmtPKQqQ7bp56ncsgXObCU1mOKAJMHINXhVkoWQxQLBV0s8n3pvd8JsHMGXKFWLYmlLCl87bn3BkFwNor0wBfv6e+7l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094161; c=relaxed/simple;
	bh=aLA/knjmibPhqx5edutgVTW/qy6sHaJBZ1fp/9sD/5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNgGhw6xWxqOyO2neSC1IiuBi69mKAXNDulZ9vrdv+cGswR/t+iSs2QcOdUW0PS+geMz/xrt4J5/nAK552Ov7OehQ+UjNsJdZGbExjCCACx8/f7oXZlFMudonuTvvzpa2ZmPRwu8auveoHwddCJgQRMkNLc2H+Enf7Emvjvmasg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ILYzWKIe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILYzWKIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779094158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yqh9Tea0PdHo57cIdWtzhqoD55ehWx9NwrX24zWSIyM=;
	b=ILYzWKIe4lJeD7iHGRjuouy0SjZNlM5+abmBwigcYoh7uXy41NAP7bxsgrFwNnL0X+HRy2
	LqQOphQsvloVYitEoy36nHeGCocpTvdaqYhT8JdnakHg9ukk2GbUfSPBwp8kly3Tj1wBCb
	5wUO1MP8EFDu9YL3E/y+a/UDY/yPHgY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-3nQ4sE41MJqWmLIomTK2Ew-1; Mon, 18 May 2026 04:49:16 -0400
X-MC-Unique: 3nQ4sE41MJqWmLIomTK2Ew-1
X-Mimecast-MFC-AGG-ID: 3nQ4sE41MJqWmLIomTK2Ew_1779094156
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bceb2b8bc2bso132290166b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 01:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779094156; x=1779698956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yqh9Tea0PdHo57cIdWtzhqoD55ehWx9NwrX24zWSIyM=;
        b=hd5HiCTzjYkNGuKqqdlP0rym+W95vQZi0iFXC1Mgvv+kaisTP1j/fHekDMqwc1FATO
         EFjtaQ3ri8TUashF9kJGeWoR81oLiyKjgGhO0aYicPGqW/xipUnw4Z8ZieBvlIWZkila
         hbVvwlS+qsNRsfKw/91NWcoAXXQIUgEIb7IktSLsGS01gg1KM7Tct3bngrjyzGUerU5y
         BZe4oWs0RUX17OZ8JpEYj1oIJdL2yVd2Tbtz8oityiIhSXIrt16OEeWs89lxwXjJ3aEw
         jgyvYJDucxQmbRkM8S3cWP5UvdtOqC2UDYCov8xeSXkuoQJ/wBR2k+YBW5I7jFns8KBZ
         C9Bw==
X-Forwarded-Encrypted: i=1; AFNElJ9heo0hMXAKB4Q9db6d0AOHBOVZRJDTZvQ1UGRIKBjW+HdyZq/lumSsWC9kmX2LvSeUbFc8CQ/Slt0LIiaaSfzmFvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGwvoW5KdNmmckqAK5vnXR/FEMUqkeKo6vQX/3lMBrMwtZAmz
	1nnL7k20biyjVd7mJIlPN8VIbC0kQxfKiAm1fHrctHpOr61tmIvaYptk5wKD4wxZ8irTo1DUnfm
	mbM0dYG8avUZ0rF2iy+8Ya89NcCU9LZR6J+5H2+Q13zIuS44I7t7Zn9QuPMy4arnJvEuuwvJysq
	VV8r8RgGObtyxMaxevAxfzEIpsz/7SZK3VNnqIEmnFWZivK8Qo
X-Gm-Gg: Acq92OFXiBMlmER9SOriPyWVxztlsXzzKuLikpWF9UggeFAtviNt8oh2/uhREPPqBN+
	d6aGRfBRM7SRBdvFvndSvi0iEJRWBjULKL8auNUm+qUzFm4XC9P7FLsam4QEI6n9DhLZGMhzE0w
	OfpNLCaeih4sFpRiqISeuJw82Fp3YKlzWsDuA/GgV/0ER9Eo44nFF45f+Qv9EvdZS4bqbqOqAFg
	9Q/4w==
X-Received: by 2002:a17:907:c80e:b0:bd4:f814:dbbe with SMTP id a640c23a62f3a-bd517814c55mr746950466b.19.1779094155602;
        Mon, 18 May 2026 01:49:15 -0700 (PDT)
X-Received: by 2002:a17:907:c80e:b0:bd4:f814:dbbe with SMTP id
 a640c23a62f3a-bd517814c55mr746947266b.19.1779094155025; Mon, 18 May 2026
 01:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414185223.65353-1-costa.shul@redhat.com>
In-Reply-To: <20260414185223.65353-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 18 May 2026 10:49:03 +0200
X-Gm-Features: AVHnY4Iwt0Z2YjRxrqUIRvhIfOomOa8ZA34Y4GfqfXHtgPShz7GzLQiXmmILzVg
Message-ID: <CAP4=nvS+xoATmEWL7Yzu6ORh-vxOX+gTBHBP2fbqvcOT6O2B-w@mail.gmail.com>
Subject: Re: [PATCH v2] tools/rtla: Fix --dump-tasks usage in timerlat
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C2fJgqMuD0RTTmA6VHFFNdv6qHWQkEjBFGN9uhLUs3M_1779094156
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 14. 4. 2026 v 20:52 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> Fix --dump-task to --dump-tasks in timerlat_hist usage string
> and getopt_long table for consistency with timerlat_top.
>
> Add missing --dump-tasks to timerlat_top usage synopsis.
>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
> v2:
> - Address comments of Crystal Wood.

Please also add the link to v1 next time when sending a v2, it makes
it easier to check what is being addressed in the v2.

> ---
>  tools/tracing/rtla/src/timerlat_hist.c | 4 ++--
>  tools/tracing/rtla/src/timerlat_top.c  | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>

The runtime test expanded to hist in [1] now passes, thanks! Adding:

Fixes: 2091336b9a8b ("rtla/timerlat_hist: Add auto-analysis support")

[1] https://lore.kernel.org/linux-trace-kernel/20260423130558.882022-2-tglo=
zar@redhat.com/

Tomas

