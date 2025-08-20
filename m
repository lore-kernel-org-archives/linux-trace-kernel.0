Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C081C2DB2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674465; cv=none; b=m4zPlRs0f9HfTx3mGuyG4jnvvMVldgv085F2v3CebeKWedXEVDG8mLW1AAdiFOXP5g9FmcFVZ/DR6fWnEUbkvlWEqCtlU1yt1Yzn3/LF+B8iMPeTpaIB05Tfw0o+Ibg/0F16YmJu0Z+CQhv+AgP4XOE7VqT2qQyS/s7qesajZ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674465; c=relaxed/simple;
	bh=ktoR6uVr+iqN83IhJ5uhhx0UJXCbOVpaCx9WSC2wCOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEPFs/Un0EuuTSkk2TusAeu6eZ9xQcvEAqXvht0DOM1oY3D3BcMlKyPrwC6IoDvQgjq+SaG+w51V8JshWoiR6TnBTHF1t3w7MSb2RLKQHMqHV6sVog6sxNS+T/q8azpxtMj8QXUTrAPCBUatY3oFV1EtDFyAoYeaVspyZSe/x9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XPA9prft; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPA9prft"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ce5287a47so5574252e87.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 00:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755674461; x=1756279261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktoR6uVr+iqN83IhJ5uhhx0UJXCbOVpaCx9WSC2wCOs=;
        b=XPA9prftLuy2LUeCXJFfPi9up8lChFnZXckFGIGytfZg7Fgc2Z4zBGYkNqNW4NHpsV
         MAqkftxo3R+hWUViexcKwEM8X1GYNcFw6qnL+GPnH/SP/XtPiDIfOl+UIEQLPkUiXb+K
         rNyirFeHazkkC3QLbZmhRAGd3Lx3i1NTBei4aVKeRvQ8mhefQsQbU8FTf8i5aLET2LxM
         5fdRSM5DcEO370rZL2fYjgmRA0BDL4dMd1byWC5+h6poSFhHFe6PIqk41YviNGlpnyVL
         3HWM0xAGpJm/uXQeO1uXytNTkBaOeZMtQrc1GlYOQlXeDje8Iewj9FrlAuOqD4l2RKqF
         2WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755674461; x=1756279261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktoR6uVr+iqN83IhJ5uhhx0UJXCbOVpaCx9WSC2wCOs=;
        b=TFMLyjX9lF4MATa/Zzo0K6wckL5Ax/0lWOF2QpXqSU1SZp4lSCtLojEkFkjbeenm+Z
         kw3CeF+aOFYu7wm0VWdZ8F0Jm+NYkhzyfqj9mHRZzsNDH8ztEUtrYs6gcHAptlXF5v4A
         +FuM66qVs5zXvaikLBWp1u33jP7lvTBBNt/UGtcE52OrPH8UL4WZZs5gx2XkIE9o9dgM
         YTCCdW+qglbyGhLiG59EyyvwS5nj1JsbEJ4D/jOMltjCZc9Z4D++nRtnfiuTzBiWWmqJ
         cH3JfqQpfVvsEq0W+n7oo2bZ42mtX0YgMQdytXL0nASuhfmbZEkY8FIvNwzK8maurKRh
         McKg==
X-Forwarded-Encrypted: i=1; AJvYcCX0/Q5EhaARRggqX4MijCGhe4MJv5RKkBh1c9ZRl5qM1UTG7eWH+77+/Cof2q5+PePD9V5aZzMyKwA4+CpMSHFp0P4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr6SgbXSGmlXaTshv87UCxll9cwXwVza6IlrmlImg5PDXTPjnZ
	wCNr8qdiVwyqWP8TKwRGTcYnuL/4MRHI8wD1cXKKPVpsOOqhEs3gRzNQLR6dEUqvz3f2eowGune
	w1Kddqd1kevTXmjt7ldNoF+dujrq/AvMxqAAaTnMQ6w==
X-Gm-Gg: ASbGncvDaaLspfpyqKVFhvCItaYMmYUWh0Mv7qq9s8X/kghPjEWnay/Z0X9CmLJsZHz
	EAlaLe6qylNOA5NEIfx0KGGQsTY2Aam5T7HxI5wayGryhloYYcwrVta4CloXMnW1o6wEnU6pkmn
	Am3fPkbMNt48am0eKdV4X12A69MZxlCTi8xWYmOKXOX8lnKRLAi/p6bKBl5kTA5zKbXfzpN/T39
	ur8xuM=
X-Google-Smtp-Source: AGHT+IEhSxjZCfw4a8mb40d3FzcM6vUrSgKvHtgC3xcWemUkmbdkdCwfNVxjfPSijs9xEWS2bBLeXc6JSAQOzBY5S3c=
X-Received: by 2002:a05:651c:4104:10b0:333:ad65:c524 with SMTP id
 38308e7fff4ca-3353bc145a5mr4014551fa.1.1755674460071; Wed, 20 Aug 2025
 00:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818103931.1100084-1-richard@nod.at>
In-Reply-To: <20250818103931.1100084-1-richard@nod.at>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Aug 2025 09:20:48 +0200
X-Gm-Features: Ac12FXwVe2yaYSWObSiIPH5gEnk6wo-BPXw1jBAn3u10wAfLmNVzja2ouijgdDo
Message-ID: <CACRpkdYYTe0YArbheo3msd6r+CNrt9oSZWNjkiwb=ZNWfJ1dkQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: ftrace: Implement HAVE_FUNCTION_GRAPH_FREGS
To: Richard Weinberger <richard@nod.at>
Cc: linux@armlinux.org.uk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mark.rutland@arm.com, ardb@kernel.org, ebiggers@kernel.org, nathan@kernel.org, 
	dave@vasilevsky.ca, ruanjinjie@huawei.com, liuyuntao12@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Donglin Peng <pengdonglin@sangfor.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 12:40=E2=80=AFPM Richard Weinberger <richard@nod.at=
> wrote:

> Enable support for ftrace's funcgraph-retval feature by capturing r0-r3
> and fp.
> Since ARM does not provide its own __arch_ftrace_regs structure,
> we instead populate pt_regs with the registers required by ftrace.
>
> Cc: Donglin Peng <pengdonglin@sangfor.com.cn>
> Signed-off-by: Richard Weinberger <richard@nod.at>

LGTM
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Can you put this patch into Russell's patch tracker?
https://www.armlinux.org.uk/developer/patches/

Yours,
Linus Walleij
