Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9722C1F6686
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jan 2025 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098024; cv=none; b=I4wRBF5NgMmtZlYrqZ2rynPi5rqjhepzIXPVGVaN4YbCbKsBJskhhQmLX8FEKVTxjNH4hi4NBnFN2BKVXs5xM9LDjcAXChXYqa0/FH/QPLE+TVbrGZJv88g5Pm81I42AUbo1GgpnKDw20N3g2kYMHiHCbGewHtxVa6x4akecIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098024; c=relaxed/simple;
	bh=p0UVb1+U+c0kLgqVB84JbX8O/njeJA919Lne3XhPT10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dro1AFUPQr3IyOcqpMz1anHeTRgZ/n3ZHnx0MK4M6DdNLr6hDxvO+Wd5Rnj8XC27ZqZFfyb0mNJSg4PHCZgMz9DadsAUvKqLA9omYyjfOTYGOezAzy9fs8tcKShRxqY0PiwJzRJ2FKjF9HxrVbOifPxbiwvXUnDF2f8D6KCxr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jNbCCSWI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNbCCSWI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737098020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0UVb1+U+c0kLgqVB84JbX8O/njeJA919Lne3XhPT10=;
	b=jNbCCSWIKs+Vhfla6VKEbKhhhqLQiciYXPiEUhCu6c/FxqmT3CknKqMeiRY/p1FqMQPJSV
	3wRdo/tb3/UejzGvXRJ+ddpKmJjR/tQTiPw0v0JXpD+WXt7jl0OH/xFueoDmbKXagbUqni
	cmxP+undGCO1QRf8gDOhDS2EJKaA1Vg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Lfr4bj-6MAmGTxrCUZDO2A-1; Fri, 17 Jan 2025 02:13:38 -0500
X-MC-Unique: Lfr4bj-6MAmGTxrCUZDO2A-1
X-Mimecast-MFC-AGG-ID: Lfr4bj-6MAmGTxrCUZDO2A
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d3f3d6a999so2062647a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 23:13:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737098018; x=1737702818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0UVb1+U+c0kLgqVB84JbX8O/njeJA919Lne3XhPT10=;
        b=r466ITZoIHmkg6gtiy/fTHDD+ZrQQb9Hne9eVX3YttvuGEHHwOv3mBZprCa2TeUBi+
         KYX6WUNbBmaAPUnzC8k3dHGONm1OX81wASTYYk/qN/Jgid30qJTCvqS7ZfDz3YJGaxPZ
         WJ8Bt28AnuZlLn6dhGtl99sOrrn0LNaBRcSdYD9sWYhyQWH2CA15wpWr7MgXgvvwjA22
         +dIdUx+4rC321ojiYiO3WjNI0sL9VWii79XtPW6mTzwd+a0PpUkjEgEtQda2wARv/DKC
         Acx64zkKGzSm9pmxUHwtnNUJayZnk3M1XYsnkgnqQGrmP7YBXil/VvCAU9LYCdWIuryC
         nxlA==
X-Gm-Message-State: AOJu0YyuDd4RsgPJGeUYRetNNqRAu8HQUbXVMQ68al2ujb0IgYQyeeR8
	seZ1i/XqE5uON4sdIcgdDsNCu1v831BX++XjTFPlkvQhTyvMKnsnC8RVzoDm2pD46+ojTdCkr0d
	7N8jbeHnI5HuIvFxhIa/Wbjypp35CaAqHBSYGEri2ZZe2R0FAiJCLEJamQgWcoKm2os0luUNlJn
	iOv6dpAqDSlWqCTfl+7v2AcGRw58OVTsPweA41LTjcONIK
X-Gm-Gg: ASbGnct7v/aZaCel9DdL08dAdKW+EinaDj8i70jxPR0e0G6E4eAStXkGMb4FdTP9vZb
	9lPqmeL81/rRLxfer7Kv+n+yoF2tiYPXdN7B1
X-Received: by 2002:a17:907:930b:b0:aab:c78c:a705 with SMTP id a640c23a62f3a-ab38b3d4253mr155697466b.52.1737098017763;
        Thu, 16 Jan 2025 23:13:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnLI+OE26nZOdrcti83uPRCfKMZeMBt8oSuuWyoke83giGLzsQkgzuhEjpoDxQfRx2FsKEGpIgUZD080tK2uk=
X-Received: by 2002:a17:907:930b:b0:aab:c78c:a705 with SMTP id
 a640c23a62f3a-ab38b3d4253mr155696566b.52.1737098017444; Thu, 16 Jan 2025
 23:13:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116144931.649593-1-tglozar@redhat.com> <20250116144931.649593-4-tglozar@redhat.com>
 <20250116195600.60625aa1@gandalf.local.home>
In-Reply-To: <20250116195600.60625aa1@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 17 Jan 2025 08:13:26 +0100
X-Gm-Features: AbW1kvb6Ad2txH46yyzngjNXqu60O8rMCrU-I4WodmRo_DGM2phjmKGaE-i0iTw
Message-ID: <CAP4=nvQUugz723Qav2xBD97ud6sM=ajEeNqyAVyqL1Qf09ZX=Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] rtla/timerlat_top: Stop timerlat tracer on signal
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Gabriele Monaco <gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2lYg_146CucNNDHJq7arJI4VatERcR29JiPPnyLNnnk_1737098018
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 17. 1. 2025 v 1:56 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.=
org> napsal:
>
> On Thu, 16 Jan 2025 15:49:29 +0100
> Tomas Glozar <tglozar@redhat.com> wrote:
>
> > Apply the changes from the previous patch also to timerlat-top.
>
> A change log should never reference another patch. This is meaningless wh=
en
> seen in a git log. All change logs must be complete stand alone.

If you look up "previous patch" in the Linux commit log, you will find
a considerable amount of patches which do this:

$ git log master | grep 'previous patch' | wc -l
3006

But you are right, if I apply this patch for example to fix an old
version of rtla that does not have timerlat-hist, the log will make no
sense. I will stop doing it.

>
> I copied the previous patch change log here:
>

Thank you.

Tomas

