Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82C346E67
	for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964835; cv=none; b=krBdtNFy/k8uwPvZ4J64zexH+kNV0Jlij+IDZpsPH07XHboWw8inhpzeU2RFd/1PzfDogHRO6ZV3fHXxHJ/xHvf+x7rWQFUAe51yelfUY3y/AgpQdkPcggjyYIBGGVp5uNfg+WAVaGrA8/ydf/1nzfnXthPxf8aA770rJjB8mhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964835; c=relaxed/simple;
	bh=vjchB7DXDp/DNP8jdbuG1dpkBsuqws/XAI4XYcLnvlE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggAM8csJ1KHonzla4l5QlO0VGWpkapvnHpqO2QsIpxZPsX5X7YQQEztU7JX3cQrhbGVQNlIhTi+oOcST1CNbOclqxvrpgkL/roZdWT1bD1X90Xd8ZgMl3juFF4Ea/6JUYY05p8amUKevCSZd9TGMNmrAE6KzzPz+ZBcJPC+SMNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ao4fCylF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ao4fCylF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774964832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vjchB7DXDp/DNP8jdbuG1dpkBsuqws/XAI4XYcLnvlE=;
	b=ao4fCylFMJ25l8iUrLomFbI6ygfC0BRmQ89tZyaDXcIT1NTYUv+rtdS3MwNVQ659M0ljZu
	u6L6z3a/9EFMwlICupR4skuPt/f0laVa62uW5vXXZqAgBLFHksyxJiS1bvqNVt36+gCwUn
	ZuDGT9gnWRqIBsmC+4AixeCG8nKvBqM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-HtYx4ptqOl-bBdosTTa6mg-1; Tue, 31 Mar 2026 09:47:11 -0400
X-MC-Unique: HtYx4ptqOl-bBdosTTa6mg-1
X-Mimecast-MFC-AGG-ID: HtYx4ptqOl-bBdosTTa6mg_1774964830
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d03bad787so1477005f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 06:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774964830; x=1775569630;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjchB7DXDp/DNP8jdbuG1dpkBsuqws/XAI4XYcLnvlE=;
        b=a03ZvMU4xlEq0rWwM0VVKxDAiNnxkzjFNc1YcADUjFQNd5fiA90plQSoXdPWojDd/R
         eBanaaTtYXMLxdx+xX0/ITYYIlJYdntzcFAxb/aNgt6//puCgLvr3JFSmChY7rXW5Fbp
         ZO+oSURGg/zv31ZZFX8dx2j1Q9rvOUp7DCUrlm/WurKzX6CFZ6buB0ULJJBcVtpd7/TP
         2WbSnd14o2IK8ZvXyUCKKC/GhKtcCKRAFVKSGJjwGDiW0Xqpyf8WTU5mf5CaFlLOuLyC
         16uYsBjwV3V91nWbkV+KaLttRBGfSStkoZzkgnwF+8ohlh+I1FMmrzCz9tsgTZxPx0U+
         ccqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdek8wlCUUzK7STMI7fWTz3ZbdBfO4pmizKo8jEQW/6EGLFVOLw6Qc4O+i4+5FU4WZKGgPkcoU3O6utt9W9twpOqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsIsnjj1kPdeX7+d9XT9unKavWrOtzmW6o0q4zZiqtyH7Ag2V2
	PC0dXw4yw70RpNPU4pSusux/Ga7qakfcmg9Dw7TRpJ+03sWh9+AtdLAzgMfV0nqqvoKpxRAnofx
	7gujhQfXS4TuaB0eYtpxwRGhn49Bt0v1k7kA0r9ZZnpJbnfOstESOk2nOJ4ZNMOLt8gvvSyu1cQ
	==
X-Gm-Gg: ATEYQzxmqISEyx9IMRcGCsyxeJkW6n8ukXIrcCrb/KJWSZyyCN06XkKNcE/vaPO8fYU
	WjVhuO+FaEyUcT4rhdnhHLz6pjCdZxYUAjR0DNEi66Mr4109ktwK6kEQ2hArpvJhsWTsAA26SDs
	O+SUJrZIAtuyMpTiMh1BQ15MJvqq2HCs5imJxbwMbvJ1jxrgJQJtVb/6+rCJlMEI5mPPHkjW7up
	jUJbmgpcqGTHLam5wClhCngKElQ47LimU+vxYopa8vPFdFgeb3E8fzcJk7Hfb+Fth6+r53L084C
	xOJ0aVwLgNUemywjuGCRIcbApTHMS8uh9wvhJfRqIWuGppwKv/UnJdtCiia685WJgovqS+trn8e
	wz1ubOvLMDmg5GAPP90GMQUOY8DedXQSxXecch9GFiE45FT3s2OTyM3xhAsFKXjyg6S5T73JOvn
	aO4D8c/Mt/XyWMB/s=
X-Received: by 2002:a05:600c:c490:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-48727e908e7mr281469515e9.10.1774964829897;
        Tue, 31 Mar 2026 06:47:09 -0700 (PDT)
X-Received: by 2002:a05:600c:c490:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-48727e908e7mr281468745e9.10.1774964829327;
        Tue, 31 Mar 2026 06:47:09 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm63968805e9.2.2026.03.31.06.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 06:47:09 -0700 (PDT)
Message-ID: <100efc7522a019aa78834e99de94cb325750dd43.camel@redhat.com>
Subject: Re: [PATCH] rv: Allow epoll in rtapp-sleep monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Tue, 31 Mar 2026 15:47:07 +0200
In-Reply-To: <87y0j86rq8.fsf@yellow.woof>
References: <20260331104918.2710853-1-namcao@linutronix.de>
	 <4b47d5e7e9dde0c76beb1a9383a13553c2455d92.camel@redhat.com>
	 <87y0j86rq8.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 05xjPF1oEy_4XGTZcktjStDU54t7VFOrHt9n6DkQFJo_1774964830
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-03-31 at 15:41 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
>=20
> > On Tue, 2026-03-31 at 12:49 +0200, Nam Cao wrote:
> > > Since commit 0c43094f8cc9 ("eventpoll: Replace rwlock with spinlock")=
,
> > > epoll_wait is real-time-safe syscall for sleeping.
> > >=20
> > > Add epoll_wait to the list of rt-safe sleeping APIs.
> > >=20
> > > Signed-off-by: Nam Cao <namcao@linutronix.de>
> >=20
> > Thanks for the patch, looks reasonable.
> > I tried re-generating the header (sleep.h) with rvgen based on the new
> > specification and I'm getting a different order.
> >=20
> > Is what you're committing the result of rvgen on your computer?
> > We probably still have some unpredictable result in the rvgen's output =
if
> > that's
> > the case (no big deal then, though it triggers me a bit).
>=20
> Right, fixing this is in my list. The script uses set and set's order is
> not deterministic. You get different (but equivalent) results every
> time. I should start working on that..

Reasonable, no rush. I just noticed this behaviour when trying to write som=
e
selftests for rvgen and didn't manage to make it deterministic with trivial
changes.

>=20
> > I would still like to run some tests on this, how urgently would you li=
ke
> > this
> > patch through? I was really about to send Steve a PR with the other cha=
nges
> > so
> > this might need to wait for the next merge window.
>=20
> The earlier the better, but no one will die because it misses a merge
> window.

Alright I'll see if I can squeeze it in within this week, if not, it'll hav=
e to
wait. For now:

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

