Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792435992;
	b=0mA8M2ZyUAGvtCpsP8nWzVpROkQNEbXTB0ldlitIaefwtBosDXLiIhwGkPQbJRYigWTQ
	 ZIGL3zwVVPyAN6P5wpxZn1uliQS1eFlJ807QNCAEeMBHAoiZ7w7hOGhDAymYakTKlBflQ
	 K1O3/W3BuPrZE6jfO8NmvrGdhTkfj7daTxydgFtBHkpqC3SCBfxHPQB8Qp2Fj3qHhz5r9
	 fsys/yPJxRMbTvDfAU3dd+BNfyS9okDqg+G+Fkpt25OvdZrHgBGWlgejwyeAYVi8c8jLk
	 X1tcTFOV7fEhttd4+kOm9pkWkT9mWkght1Pxpo6gelBTq6CVNMwX9Nw/rKU1vodJoAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=U0OPXpDCVqLBQpzhnWrzkRzYhRBBjTJwu5vXYqV+PdU=;
	b=ZLfWDFfWCbkkqWZBtuSNoTLYNvrUU6OIwXxSJjn1dgtD3QEnxoh0VQuf3bYoUVAdue6J
	 lXDWNBs2g6CFXMTjaEyqllptlt5odWqtM8mp8qYcNk455TQNzTNQXXzIpi5HAYDuvSycU
	 DJ8hL51rl0RmAlIGFJZRYVBWOiwUoT10A8/YX3Dnfh2rqjPnS1QTTZl9kf4p/NCLZ6u5a
	 HBYV3R+u7rZjvzgSOwQ0kz9+WMFVW+mE/oYxofu3AZljZ74a94zqJsWQAtx0cPhcXhrcz
	 pFRwi6LFEoxHkMA4/tVprPZPr0sDiY6hEDjdv05fYmumoDgp2jbLvHppabDfRSQWXZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DOsT1NNS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF85606A322
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 18:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EF85606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DOsT1NNS
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so2125092a91.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 11:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792435992; cv=none;
        d=google.com; s=arc-20260327;
        b=mstvrcE53+2OKe2EYQE3hZT4FoegshtJulYY9hyGQBr+e7PdSu5THlU+0Lm5FylvGb
         Mmg83Rx61swkXvMLjzVsXtBtQ5wuL72rCzPiyJ5VAOUmTZKBR6hpUSlP5yLS7P0xU3EK
         MS2/agyK2Uv9BjIFpU7zWiYAKJkmDQQbVdaIVhOVR6KO186TD5fWf3bWcg/aYdnz1spx
         DktCBwc8v3chT0GbfWp2g0i5U1Kfw90g3i3xmzUpK8LgBP6WBT2yYKQQ0BtSXFKXHPWX
         Rti+WAAh+synvtiWd9ArIQXFGaM9IHnEEJlM1jIyBs5h62uShc628OXTV11uMZXGp8Q/
         ySEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U0OPXpDCVqLBQpzhnWrzkRzYhRBBjTJwu5vXYqV+PdU=;
        fh=dA++PSJb9l+IQv4KWWC6j/heuMw72ZfMR0/wxn3D0Y0=;
        b=FjCczCoRvYPPKscxgoFwO4o54Ej3O7aaCNHNUK7SC4h/BxWvdKD5fci19Ii5hVukXq
         6FwtYCsAtmJ+H+AlSi2wXTrr2a6Nh4EXaP+9KVk+JhlFtSUWQtVrHIN7axNpqLSJ0nRk
         H+pWMDEVhPu6qKrJzfskDfSJ6Befpox5FvgP32muttVw5r4Q29d4iewzJyS3ONuFrbJB
         wooNm4HvA7WxWG3NcitFjqhwxM4UY73csDEjxiBX8T5CY14uvJmZODGNCwVeqY3zcHz9
         tdDkjJsCNyog3akLEKXZaaCjcjqNGuP6q5tBXPha/xxKsAJjupcrlI/0hRbYfQPwwOH6
         ehGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792435992; x=1793040792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U0OPXpDCVqLBQpzhnWrzkRzYhRBBjTJwu5vXYqV+PdU=;
        b=DOsT1NNSJKlA/uY2lImfOMWlM2PpdpUfyChND1lpSPqVsgMsk1pqU/rY8ral8PHrbW
         lofgdd2YHUQfG3pK/1GbMc6xWMLdGiT+Bt7mK5shbNnRna/Ot8SuE95csawvabM/Czut
         e8Zn79YeiiCo6l3bpwSdnKuX0YSzzvx4Q7m9HpxpqTKUO7H8jRFbBzrAeT1bfqwQKRM5
         HKLVX8lUh91v+Xulae5VuAr9lMgBw1a/jM+II6bU9LeLbqfWStJtvu7tmQKdoJfeJQin
         CIumq+YZKWqjbjgj9DtSYzuThRhcvpe/v84fLWXI034/2pDO2py143GDXS9JFnZxzlya
         VPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792435992; x=1793040792;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U0OPXpDCVqLBQpzhnWrzkRzYhRBBjTJwu5vXYqV+PdU=;
        b=OtgNen4cQM6l/xepOW1Dou0RdQTl9MZbxqPyckWKDkIUTupEJyvUs1KfeNB65Q9ZFD
         JL+SZkZs0KuPnLDsS/9w1InXaYPENAdfCJXsDz94iYb43rQb/6NQNRyZxEKa120Z+vf4
         fHT3fJ5aKi6xG2WTHuF0De4ldfOHPklq6oBAyQEWGYxkiK+97wO/NMIkNIXDwCqNOrCh
         JU9SEvtnmOtq8hc30K2dVBI54ZR3fw+83ORWOA16SBfUsgZ2ju5Xsdb+76SjV+hBo2Zi
         d74FIbYA4wEOg5CmIV8iDMXuHbh23CGaGuyizG0IH0fzpFQOZNsTWF+rD4YuVqJWsJ82
         TNHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJ5DTbaxXHLNtQSRhJve1v1SblVLaPmVa/GNfEBba8SgblxLgFgYw4sstL1tSCV8sufW12DLD5DbGWrcLux3h3YkI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmyxDoMyOA8GZIiX/khB20mYqWB8LKfFNrA3HRbBYM0H+xKZIG
	PBSq0P5Ijd3b3thwX0WmTOO+/1UvscTHMOdTmPsVMPu1/ldZnIOa4hMiXQKMhwnvy0d+Twdq54f
	7vRJqZ2bJa7lT4GNpj1BhzWtG9f1kHqI=
X-Gm-Gg: AYBFou3SoykDyNRDhc68ryhvnOFxt3sRLIFL4zv72Pmjr2wv5BHozAyGYjGSyi062Fi
	50ql6ITggLoyXnjITcUClNutt3vNMJROGJKeEv8/e4wA67VO8RzkXH7raSbRsbRCp8y1YtT/XrF
	p0gJTQMr4I7i+9Ul5keYgSXLVfMeFWrMLSRYw14c42MCJcU+aoagLxStTitUAm0IYDvh1Qu4l2e
	Z7h7Is02wbQf5sYM3Aj1zoBAtgLkVygo/BE2cZnpqFGEJQOKM78QE5EoM2qGWgtgYrwoMT595AZ
	xLRdLdmRO7M/cIinGKUPkU1G0BNcfqtVWKjQlgqRWQ6phdRGhRe+Pa5C9WTE3HsSetz/AW/YaQ4
	P19S3fldznJwzEloNOp3AlLYknXllJSM3nOC6eF1m549DVdKS8jD8
X-Received: by 2002:a17:90b:4fc5:b0:3a4:a592:4cfa with SMTP id
 98e67ed59e1d1-3acef3d957bmr7542638a91.45.1792435991820; Mon, 19 Oct 2026
 11:53:11 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019080709.477548-1-18983559317@163.com> <atX2FsqHIkOvhrLy@redhat.com>
 <CAEf4BzbX7vmpd2da4eKphX1r8=QXGey_1m32-KP=-8FOkFk15Q@mail.gmail.com> <atZFvTrDIyBtzWbo@redhat.com>
In-Reply-To: <atZFvTrDIyBtzWbo@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 19 Oct 2026 11:52:59 -0700
X-Gm-Features: AclHuK_kIpsNmMuQwgIok0RUwcZKJw_O92TtNFcUdNT_GKShwZ_47p0XZYU5R4M
Message-ID: <CAEf4BzaxGie0JYKRLrEYHA5DdHjEFOERHU8_o3n4mxM+kN1x+w@mail.gmail.com>
Subject: Re: [PATCH v1] uprobe: Assign session ID before publishing consumer
To: Oleg Nesterov <oleg@redhat.com>
Cc: Binbin Deng <18983559317@163.com>, mhiramat@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, andrii@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 9:31=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 10/19, Andrii Nakryiko wrote:
> >
> > On Mon, Oct 19, 2026 at 3:51=E2=80=AFAM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > On 10/19, Binbin Deng wrote:
> > > >
> > > > consumer_add() publishes a consumer on uprobe->consumers
> > > > before assigning its session ID.  handler_chain() traverses the con=
sumer
> > > > list under the trace RCU read-side critical section and can therefo=
re
> > > > observe the new consumer while uc->id still contains its initial va=
lue.
> > > >
> > > > The race is reachable when an uprobe at the same inode:offset is al=
ready
> > > > active and a task hits its entry breakpoint while another CPU regis=
ters a
> > > > second session consumer.  handler_chain() may store the stale ID in=
 the
> > > > return_instance consumer array.  By the time the function returns,
> > > > uc->id has been assigned a nonzero value, so return_consumer_find()=
 fails
> > > > to match the saved ID and the session ret_handler is incorrectly sk=
ipped.
> > >
> > > I guess we don't really care, this doesn't differ from the case when
> > > consumer_add() is called right after list_for_each_entry_rcu() in
> > > handler_chain().
> >
> > that uc->id is important for "uprobe session" semantics,
>
> Yes, but
>
> > which seems a
> > bit different situation compared to barely missing consumer_add() in
> > handler_chain(),
>
> I must have missed something... If handler_chain() misses consumer_add()
> then push_consumer(uc->id) won't be called.  This means that then later
> handle_uretprobe_chain() -> return_consumer_find(uc->id) will equally fai=
l?

yes, you are right, and we are in violent agreement :)

>
> > but regardless, the fix looks good, we should apply it
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> Agreed, I have acked it too.
>
> Oleg.
>
