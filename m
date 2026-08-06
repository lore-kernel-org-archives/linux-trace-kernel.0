Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E263D8107
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001047; cv=pass; b=rwwWjzH6SC7aDPEzAIxma91gPQm3w/pyODNJAsNw6xKwS4xQlqH9LW+w07UDTSci42DReTGP1jLz4F4MC9/xxTz9/T0WObcnZ5xuYi32/M9Pe0czvs0dHJX+ZVScNgOHECKAjXYJ7kyRgd9YMpHPGb37/HYDr9G/gMBwsTy7/4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001047; c=relaxed/simple;
	bh=VCv0ANcrOawprxJX2FEsgU2OCe67YJq5nLEfEG4h5aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bchu3aLAqyF6F33kMhsu6Y9kcAPjkI8DMo8uwLEByOtJo6KO7RJM90h20CUofOfqp/775mPuyRAla/RxiPC6cALACReQ2ItHDbw+/T4jRr91l4COOa/pblzcSqThkMXX6wT6CImzQXVZhbTU1iSJytXHikyYAAdAg3P3o9HHqQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RRfcj1zm; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RRfcj1zm"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cede6375caso70075ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 00:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786001046; cv=none;
        d=google.com; s=arc-20260327;
        b=oU25f9klYdA5NTYqCQH1ErljYegKPvY7iOxTst4Rz85dc0ivqXF2C7ft4tOf7Ojt5A
         fRGuS6/a3xApXWUpESdmCLPmSr+9ctzphJUOwT1KJjl+4dM5kbju3YEoI2ZsIfcMW9pw
         TxxzcE4ixQsRwTQZIHJCtWLBvaoFXd+tQizvdOjSkcaB3UjEC8FkJA8KUkgwLIcSyJ37
         hUNBfF7qHZYuds0mOw2MhiVg/kFMMHAwilSqsugIxI0mZjydrpCL3qeXsAaex9pnJOe+
         6YiNuqxLpTdcbovXMPI+DTceWKczYo5HKpACifyukBD6hBuwGv4ucPGPJq6aQk+1Nu0p
         qQVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6GO61AgyeYNss6AmuhGpphoQb0AdKedalYJWr8324Y4=;
        fh=/Q2zr7U7g3IwCf48FyxoQ02lGklvKgXql7NphMHuaxQ=;
        b=g647ofxzXFqPnW/B8+N+Lsk9hKtiEyqc+9/q5PFdenUDPPnU4tMQJviBLUBJLi9KOT
         qjYzS5zILVaXVc+Z0qC5eikqKOKUdnmux0o790IaGmHr8PHYc73P9s2E+uEKko2RQVlk
         Pbu0nOAe4rNQG8B0rropCCdSpId3gYoQKvYdRHWz0EcLCKBhVxhzXz4fe7FqDzABXZQN
         UIdg9GR6P6OUo6hYGKLcLJDrSWm7c7sdBxWSIFhV1DRm+9iEocvU2PQ5TVKgD+7zVUYQ
         mfiLofwU/SXHZ7wpvssKTl3JVfdzjkhuWmks8ua/hdJhgnUiSW0wViwO8+2Ec1Ao1kfm
         ynAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786001046; x=1786605846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6GO61AgyeYNss6AmuhGpphoQb0AdKedalYJWr8324Y4=;
        b=RRfcj1zm3m3c9aM3DwRLmYS4CSNXL8ByilFrpduWO3qpMaj+pBMgoKiPsk5udfb7C/
         vokErcBc4Ps9vWen27kXJ9QnRBxFGy7YfMQkAzc42q/0h5s4+3W7qSWYpEzTxvcDHh3c
         WO65ueMofcmxI52A2/BFFlgls8+nIzdNHYs1gIn0hUr5X7gpJFohyI5jOSlAA7L8oWwr
         LOUnF/YRa4DUaVTxQxYnpZfVmCK/fyV1jIrYj0PSjAvHUG2wvjwdMSqpKdqcjnSCxGuN
         OutEX4nh9bLugPmAaNtjKU2LfUNNRgjtlXZMQRTl3b3Q/z4qNiH8asAyHXF0DwufVYsq
         ucng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786001046; x=1786605846;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6GO61AgyeYNss6AmuhGpphoQb0AdKedalYJWr8324Y4=;
        b=jnhCbSrGJStnFicFBKxmeDY2b8V3sJQvw8hmsQ+KJEbgf8BguhXljj/ggQ5qX8TuLF
         RAO0bHkuOZDtVtblDk7RCjS3uaFLJZ1ZRFq0zUKPvifsXn09OzdNEE08xUhv/65ZDq8O
         faQpD+LFvb7/fHM3QifOSDkiQwbmCWPm5Ird0D9eSz58S/8QezWhvcRLz1qJIXrkp9et
         fDNTcdUtDXPaXFWEfceEjMHsiAKEdmCrRDfpiGsPXe4/CpUp/Czgkk8GfvGIasqW4zLp
         i6DyEuJfRryn/xWWAcmwaT9DacyJ37ETlN1eAiKUETHXU5lfF+ICb87YlOB4ypT83M5/
         iJQQ==
X-Forwarded-Encrypted: i=1; AHgh+RqIlajMjtCXWLsJKgTRw82melOtTO+Ko7gxdpvuOHfNMhSo10xncA52LyQuSTt5gFdG3uB4IhwtRLsj92TyH4X/kGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwj5kjVDIpDDyc+BX7MVA+MZDDi7mjjLPhspw3rU0xHy8ONGXb
	heULUYT7t6wT6N8UPtjiMspZbZQlnFRKw+wzRsLukpYA0SmmFXBDuzw7JQbLQhJ26rAmBPgJj4U
	PfNZdolKUckC7q+jx83hvtv1T4F9f647iTG3oETUn
X-Gm-Gg: AR+sD11VPtGSSJuaC1U0n0eRHGKVEna5cYmEGrzlg16ckJhLeAiqUQ0RiKQ9yQSAOxA
	yLYNoGGSICwqX8Z/20y8LK8CfxpZXZnd5Cva6AHfLJtQFVAUE9X+hMLFgYP5IFt+c2UosL+a3gJ
	AtiUwc7C8CsS/QUjgL4r3Oz9CmzlJusJCRhS1rVpjLuSctIQXBWOEPfO9nZdEJf2Kq5j6BFFlsb
	kMYiW5V+QrAOXjwVclxcIV4m8nVXq1wGMWM7oVB6wF04EYdrfqd+KDnXf16aH6hMrnNIgEVJEVt
	aTmGlufja+DXLnuafgL8BdjjdEZ5CbHbnrTEhiKnorzV
X-Received: by 2002:a17:903:3051:b0:2cf:9ec1:ea6e with SMTP id
 d9443c01a7336-2d0f2d3bd76mr4483165ad.8.1786001045064; Thu, 06 Aug 2026
 00:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805161221.2428623-1-lrizzo@google.com> <20260806090235.e40c75f84f8a01b9a80fd570@kernel.org>
In-Reply-To: <20260806090235.e40c75f84f8a01b9a80fd570@kernel.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Thu, 6 Aug 2026 09:23:29 +0200
X-Gm-Features: AUfX_mx4g79GLKapZffUutfYILzgozZvXKunnplH6OXGUXYXj6HqyF__7U1AEA8
Message-ID: <CAMOZA0+4dE0N3J35pTVTBgvFzP2a-b47Z_LZYwKNwej5jUx0zg@mail.gmail.com>
Subject: Re: [PATCH] kprobes: Fix NULL pointer dereference in unregister_kretprobes()
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Naveen N Rao <naveen@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 2:02=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Wed,  5 Aug 2026 16:12:21 +0000
> Luigi Rizzo <lrizzo@google.com> wrote:
>
> > In unregister_kretprobes(), rps[i]->rph can be NULL e.g. when called
> > after kretprobe failed registration. Under !CONFIG_KRETPROBE_ON_RETHOOK=
,
> > the unconditional access to rps[i]->rph->rp, causes a kernel panic due
> > to NULL pointer dereference.
>
> This is not a bug, since if register_kretprobe(rp) fails, rp must NOT be
> passed to unregister_kretprobe(rp). Or, do you find any cases where
> register_kretprobe() fails, preventing proper cleanup, and requiring
> unregister_kretprobe()? If so, we have to fix that case.

Masami, you are right, the kernel tree does not call unregister_kretprobes(=
)
on a failed registration. I was confused by the unregister_kretprobes(rps, =
i);
call in the cleanup in register_kretprobes(), but the failed entry i is
not unregistered).

So aside from protective coding (but where would one stop ?
null rps, null rps[i], ... ), there is no need for this patch.

thanks for the feedback
Luigi
