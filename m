Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2000935DA65
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016204; cv=none; b=ZSlPH4/4ZefTGaRjG/xdRzQvu1EjGYWl1VjTwmhQnriR3+NrF0bI37rBilWjTWVXkD5ad4+pQMZsQtqGKTtDsffWdNJYxhPcesSLIYM8WphhEUe+YMNB3HRn8KGmPSjeWMOMjk1S6gtqmCfREjph3t7ozeAhcyKH2olcx48cG5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016204; c=relaxed/simple;
	bh=Y92YhwUPJv/2h7H2Q6e9DHow9kcLoMvdAckDZ2rlfCA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oCqIoOXd84InUdAasPXX3U8G9CjQk8xDQxVk/Uk5tuUiErGSZ9B31yKrvlyNKnN9wCY8JsJhTeLCqXBKgiZfDqFQ27W8xZE2SWxkU+yvvYT3Y1+/mK9w+FHUQll7kbCErWYFUfrekiDZ3swrPBuT11IqwgsIZdjwAu+XvCiZoTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxFxf07w; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxFxf07w"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-490c1915793so37997165e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Jun 2026 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781016200; x=1781621000; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5wPRNbXYNk+CemuXK96At7KwYoVbQHOG25Mipgi4x8=;
        b=CxFxf07wmaCxZEoyuTCK5RMGcNPwGEamu+G1CoY6KQuzzDmEl5u/4yuiMmbsR+OfBN
         dTr8fl3WVmRqfn+DzzV90CEvlsdO2VjF4Zd+nG2N6C8RARk6fTydMY+usPFsLFrWCBjA
         nStpY4XlgGvHcTVqWWLI2SZTl8XogzeROM3zm1hiroQe81qwHvg9HSg+8kF4kcOPQbM2
         AzD4vt8gzVLVCuRwYcxWU2hf8LCeu4yYLrQebnREUdr5xjUnV9a7/OcRjbDwuap8BmaY
         n3PUT5MkACwMy45KNlozJ2mXLAMHPES24qkMoZGYzV1gxU8X0BF95RUImGUBc08A7WWG
         Ftig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016200; x=1781621000;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5wPRNbXYNk+CemuXK96At7KwYoVbQHOG25Mipgi4x8=;
        b=prk5HwrHR3alHvBVGF9RfliZsRZWKBk9JNlLDl2QS8gzSLsg1m2FhcDYHDm8cJVz2+
         8trcOutKGvhNtAlqnaKW/B6H0QSDzpkUvkiHAG3Wf2CeqrVckZXUVTVWXTXQF/dVN5v5
         E80Preof0KLFIEWW6EEWYP49UeoiOFkgQfkHnUrvLTbcbk0nWe0OQxV1B0h7PbUJGrKv
         OEmRmDtX1YK9zBh/blsMsSNztSy/SByeHl45rn9B+++N/Ytz4g+We5sXeBi+5Mo9Ode8
         r/levs1c0zvQoNP/bjKoQ9kje9G/eq/abekm9srHh9OSwBbAhz3v98Y8Oq+9VeYDpVCA
         QR8w==
X-Forwarded-Encrypted: i=1; AFNElJ+pMTvpKzTPQbwsjNLUd9YOddBSGMR+B/HFsL47VrCpaAgRSgqxBI9zJpZ2232ZNY4MmpwJLzSHPv/guWVaXqhyrLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKISWsmh7zWRidq/VHrOCmPQcBfn3nK2VqFdXyk+7BEbhNETVf
	V+LpyZybq15sh8GXDZ764+o2u2NxtKRYKHOm2r/f2c1WlN5t9cVLlTkQ
X-Gm-Gg: Acq92OFPxK5OLaAnhnB61Es5Q2fD8x/6WrNNKVDdHZEjhPAJrtfTkO9p+rgscH+wwkq
	5r86do8uj3UYG414VvliosdlzxdZnfKtEdoaJ37Z7nhH9+6TH/sM31aCVQDD7QZQpjh0TsiiLJq
	AgxcooIKnDWGeB2jbtEi2AbwAM2fzAHDyLRbACMMlzOQGopMeG7dp0dMNwPHdYikZ4Gucl+CXJd
	4w2tPiErUhg+sVqwtsbOAOny7y75Ufafmo+HqCAloJLJBvJCuNdHnpKFDPeL/j+viAq/R4QVjaP
	aWzUn51JPodrE3vb6xHJTWjbdv8D5lqJvTMYL8m5Yqco3wALeCHj8SPRAtx+Y494K8U/gne4rHI
	yjjuC4fhDx+fDj9GkKPjjzf7q5zfvPix5KHHg2cJ1JFrKU2bwJoBhKo7ugV0m+r2SxNlYYoVFAW
	jhMV9tmwbUlf+AU2AkzZGJB5a4OPtvLeQh1W23k8D/0wg5I1QU2P1wBarTCmtCQu86+Bl5PkIBn
	T1GxoU1T8FVxMnoTqJDlp8gpLvMsFpxhesFL2PF3SKPYWCg2fklbUplXYIY/sYHtQOZTON8z+s+
X-Received: by 2002:a05:600c:3e0d:b0:490:a1dc:e542 with SMTP id 5b1f17b1804b1-490c25afe6bmr330636105e9.6.1781016200339;
        Tue, 09 Jun 2026 07:43:20 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a87dasm473111435e9.7.2026.06.09.07.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 16:43:19 +0200
Message-Id: <DJ4LJUWPD2BF.1TY4Z3WY2V0H5@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>, "Martin KaFai
 Lau" <kafai@fb.com>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu"
 <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>, "Menglong Dong"
 <menglong8.dong@gmail.com>
Subject: Re: [PATCHv7 bpf-next 03/29] ftrace: Add add_ftrace_hash_entry
 function
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Steven Rostedt" <rostedt@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260603110554.29590-1-jolsa@kernel.org>
 <20260603110554.29590-4-jolsa@kernel.org> <20260609102922.3c489f76@fedora>
In-Reply-To: <20260609102922.3c489f76@fedora>

On Tue Jun 9, 2026 at 4:29 PM CEST, Steven Rostedt wrote:
> On Wed,  3 Jun 2026 13:05:27 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
>
>> Renaming __add_hash_entry to add_ftrace_hash_entry and making it global,
>> it will be used in following changes outside ftrace.c object.
>>
>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>> ---
>>  include/linux/ftrace.h | 1 +
>>  kernel/trace/ftrace.c  | 9 ++++-----
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> It's getting late in the RC release and I'm guessing this series will
> likely not make the next merge window. The first three patches are
> rather trivial and since the rest of the series depends on them, I'm
> happy to take them and apply them for the next merge window. That way
> you can continue development in the next rotation without needing these
> ftrace patches.
>
> Would that work for you?

Hi Steven,
Version 8 of this set was already applied to bpf-next.

https://lore.kernel.org/bpf/178085644764.273544.8250000589480262551.git-pat=
chwork-notify@kernel.org

>
> -- Steve

