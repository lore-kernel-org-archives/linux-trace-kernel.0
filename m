Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0047330C37B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684215; cv=pass; b=Gf6+IK+a4BaPeXColFuaONXkCkurgMN9wPRYHueYIPrripLuUbf7Zv03kHjx5/renZkcRlW2wqFFAooj2GrsqhIqN6d/nKLDN5DZAwZ0qdjLMEP+YdfDpimUEMcn5vWpXo1vcKqKAamhSnn1W8V+yi98gcTfIIniFUKcLjLPU2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684215; c=relaxed/simple;
	bh=KNzIzyFdGwoJAVx7hy0kRK+gY5zPmTyPzd0Wd0WQTas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJHV0UvQfQy1bC6y+RVF0QTzBO+7H1OM2JQmiJIIcdHGG/MlInkIGaBJE6iorVaNohUyfiTbFB14wL1Y+t2TmXA8Z+9BF7KRf4AYR0kK6cvytf/rFy92oe5oXxflEZTGunQPdV0n2GdHq4neM9BgCnuBZZaWRXOWtp44kAWgzUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O07WQe4D; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O07WQe4D"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12776bebe9fso233563c88.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 11:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773684213; cv=none;
        d=google.com; s=arc-20240605;
        b=eDUix/UZAYQxy8jHW3Nnkr/kwm3AOqlhfoeG9N1kgzPm9qBnHhojeYY2izamXL/Mf5
         UdzfAn/WjOIsl2jYB/om1UrQJPQ9PJBq/oAW4vlggqKNn5mQD5PIZZ0DDzdrVxRwtlks
         S5ref3B10ys61grX6J31GrgQzany33Ok1LTemkVxzDlJrCw/YWuHiHCrND9EMpO9TbT5
         RNCzPalrxgrQk40vJD2VGU+krg9j2RcDjqgtl5SlIUcmpFrLElOfF3Z7f3SVUW/dMvVz
         /8RnmWdYdlVB+atVCCfmBxxb8btOBajMLMJvCK6H4QNjaA7ogqkKsFX98Y2jc2ZLH2i0
         YYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KNzIzyFdGwoJAVx7hy0kRK+gY5zPmTyPzd0Wd0WQTas=;
        fh=6+f/5HWUSmJZU1w2sH7gHmuCjiewyYLVE+LIHincExQ=;
        b=UyhmG1CRAEw3q83dVGUFj9PPDfVVrdUNBpW+1EqadYFjjL7etMNViiHa57lG5yn+S1
         qHnGf4PwnNg99wRTYO8ArPBEWt/EUH5TMjSbvjBayzlUGeSUxFDY5FI093k1ijimlaqK
         j5bPyKm20Y7RZXltiVJwj3eTT8j8i9ormX4COweQqZT9eL8pk4w/h45h877MoZn9hn5T
         qBwQS+B8+dKrFDWpEFe3pbYl3DbDmNsj4RexsXgMxt81MLBmTvUUA+dHpf6hSTQr8Y0v
         mBzh0nBV9Zy7Gt8qdAlzahdNY9b9K8cFjx/pots+fOmZNwhQ/iLr849vDkHeuuHeIpmO
         941Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773684213; x=1774289013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KNzIzyFdGwoJAVx7hy0kRK+gY5zPmTyPzd0Wd0WQTas=;
        b=O07WQe4DY8rR2TalssFliMhJMUanx8+Nj7/aoptmrFfrw6TU5RopcWFn1u2FSG5wj6
         WJdIdUVc/Jz6eCnjmFHsBrDLej9HM6xxU5LSAYT7wY1Nr5J1bsnTeGfQSWq0kfBKqxrp
         XvwlEB7du/N87ct4LCBjpa9pnRhybUocVzNtb6uI5T8kJQanDtMKVR8UhHxsl/SADP5T
         mzxmC+H2Cv7X9Hwrvl0HMDq4KajhQK3qoZVZ+9UoKOeh3YY8ehoAS3oRIrSqQ7/gFLMW
         2kRGTnGFAmkfbrRP7PH1q65ynTPsQ0glkjdQYpyB7zlLTEroJput4cJbSf77Ec7xTZ/n
         vr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773684213; x=1774289013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNzIzyFdGwoJAVx7hy0kRK+gY5zPmTyPzd0Wd0WQTas=;
        b=ip9fzeRCLT0pNnXtZOiaiarKPL9eRXR/01IsWnbResxFWVXqKk8cFlHrokg5dPLB1V
         vBMoWyOL6O367oGp/CpTYXQYJH6lZAspEkrMj/AO5TJOcVGF05FydPGW4ahMaKSJmq0W
         crPGQxSTsNh0mvbrfCb0TOiy1Tm6XFndCMuNiX3zAfEXrBshyKRImMiyA7FmOBGmNqvw
         yn6C8kJvKwUrxc5QPtk9b+/5c6Y/z6tqtCr+PPSyH3xUsk7XiTgYk6OdTxIB3Z1Vv8YA
         gAEyhN1Oq6Bfe+KIwFhiVSCQ9Mszu5gZb/GbIBiiMHWLkaPzt72Q1XnjJf0DRl7Sctzd
         9Urw==
X-Forwarded-Encrypted: i=1; AJvYcCUouhNPBDxNiAlwRXQBuqEt1I3cVbog6dFbxfHlHj6XDsfDMb+wOuEVJxaNYG/xH75AaJNTq0LNb7B/Af/2Qs03Spc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0yDiD7ToRH+0NDQnoYDHJjx1gaVT9FSj54fVAJbvDpJZSCOnQ
	vZDroTHWZFQ3Nl96kAqLl33i5GhMHra1mdXRjfDzt435+jWDe6vsJdSs1Xtqc8vWCXkA6m+RkxH
	4Q2zVh/pMG+hSWdRNajkGD3FnswYFAjU=
X-Gm-Gg: ATEYQzzt2YFtkaqIWlsVE+Kq36IjmXPRMW49lSyCo3GgE72yGlADrtyw9MpBG6i7eTa
	YVJ144rEc2Relzn9Bmog1AOJZGhou9YpcyDU0GL+Y+0S6S5SKloS3O2bb5k2efnh9UnNoi3UNQj
	7L19WHdk3r+wjZ95wqcmFnkf791zYGdmpqD4nfsTggkee6M0OhUzwPf5nq3uxg1tAtqwgu7PZha
	FkU3szyuQ/bA1N+dl+DBjYSMFHA4qHy6I9hcSkxbmbCLnGxgnjjRu/Gi8GQkysYOsscoFKspkP1
	kSfHdwxHecSX7ads4So8DIgrFFn80bCpz2jHSEz+
X-Received: by 2002:a05:7022:e1d:b0:128:d786:8aca with SMTP id
 a92af1059eb24-128f3c6b032mr6448350c88.0.1773684213034; Mon, 16 Mar 2026
 11:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314201348.1786972-1-atwellwea@gmail.com> <b042de90-79e3-4976-9bbe-b6df3266caea@redhat.com>
 <CAN=sVvyNpkyok_bt8eQSmqc4f7g7QoZBUmRmNRLoFz1HasEzMA@mail.gmail.com> <e93ce797-4153-4e6e-89b6-3839a0b8bca2@redhat.com>
In-Reply-To: <e93ce797-4153-4e6e-89b6-3839a0b8bca2@redhat.com>
From: Wesley Atwell <atwellwea@gmail.com>
Date: Mon, 16 Mar 2026 12:03:21 -0600
X-Gm-Features: AaiRm50ReSwavo1j1ssacOUbWxtcgznlHmGlPHkMg2HYVcwTt0DGLUUEq90y36c
Message-ID: <CAN=sVvx8jNC-OAMkv19Wv13jTpV5_wVEabwUCjPLMwTvS4czow@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/14] tcp: preserve receive-window accounting
 across ratio drift
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, ncardwell@google.com, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, dsahern@kernel.org, horms@kernel.org, 
	kuniyu@google.com, andrew+netdev@lunn.ch, willemdebruijn.kernel@gmail.com, 
	jasowang@redhat.com, skhan@linuxfoundation.org, corbet@lwn.net, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	0x7f454c46@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

The link I meant is the netdev regression discussion that led to:

026dfef287c0 ("tcp: give up on stronger sk_rcvbuf checks (for now)")

The report/discussion thread is here:

https://lore.kernel.org/20260225122355.585fd57b@kernel.org

The revert posting itself is here:

https://patch.msgid.link/20260227003359.2391017-1-kuba@kernel.org

I should not have implied that there was a separate prior
regression report beyond that thread.

Thanks for the note on formatting. I will keep follow-ups in plaintext
and avoid top-posting.

Thanks,
Wesley
