Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A65A18FC75
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730149807; cv=none; b=UvcK6wvRsviKr7AIgX/423jRwsIJVLate7zSRNpfSuwk2GNo8/aGlYIZuov5tss8ZmaeMYKWRRayS77A7JcgSTiKrF4XLyi4Ht/ADtpz6B1KkRErjiNuzs8gDBycj/aBKElJSRV5MjC0ObEN3WR0iM+rYEi1/O/5ZQo0mwW0ntQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730149807; c=relaxed/simple;
	bh=U5fBolRnKer5O7b+t+buSpViHWFwAOhRMo1EaMEr+5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bx+MBMYp40jGHrI0osniIlqrZIFOpClwQushdszC1LhdYd6F+pD6qDwEUUbemRqgjFoJHRBHlc0a6yX0YrOG8fMs7/ny6ej6eIBkfoG8SkP3Kl4hSVzLQLAtnVPm4QKTDxX3ILgH6/PH6RVWV7lnLC5aoeIapKlOE040Lf8wNtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gK8kCnVa; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gK8kCnVa"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539fe02c386so5337173e87.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730149802; x=1730754602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg5LHsnihfFMeaE/D0viDwbqHN3M3/7wht3hCbvfo84=;
        b=gK8kCnVacaOTsybP5EmUXGNp7JNyaEEBp4JKXvuSIkQ2R57IJgvO9TbHvbkmPsdNG5
         EkFuenhR9CYabXcJYzhon7mIw9OtlLfTrBYf44K6r97CvNIlPw+x3JltXgHvGYShgFGe
         SxbYP/M/ogx4VspXgjaVmmr0iuikpUv/C5nrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730149802; x=1730754602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fg5LHsnihfFMeaE/D0viDwbqHN3M3/7wht3hCbvfo84=;
        b=wb5sTGB2Gd87+P2cDpPflgLVn1jB5obkDOFbEq0U5KKDpAAvU6b1Wyd/fuZfHuioXT
         +d8O0tXmgTAl/Ab8W0Uk5FlkL5f0gyEHYDWemAtOCngpSOBGrVId6vwSHMFxTtEC9mB4
         bHvXA4+CPeQm7ZyyUlGFj/4kevNWSK9xlJcFTkbOkq1wXI9nWGa+BsnbmOFjOAvZeyWP
         ALSxDok2dxwAIbaHNjpM1FHFWgnrq+pP89E0y86Y2YqA66Fp5aONUp73Ngf91g92n5Xw
         MqF//jcOuFUAn8/9/2qOVpo9Giz7JrXHQ4sZkGTYzVGiJl/WwF7EeI4or91mQct9wmAF
         k22Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0uDfDgdinX+ZBtd0YGbJ+tg4H7MQgeJ/3DidXL0ymXhulYguAGIcco8fR8aKpkgNAwoxeV57GnotCvu86kPBl0jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmXf9w/AUPG4ZU78T8IV4U1fTnloZS4jSNVFSgF0fDpyGgdmYG
	Ri9LP6HJ0U/ZwBgAz1aq2Eb+Nz31qLxNrr7iQQrldGh4zxS0LIf7b1Q6ksdSyWcsuLN7MTPDlyY
	iIw==
X-Google-Smtp-Source: AGHT+IGe3+vwIE9L0fwDnZlHC606Fyg+ZFx3YX7QNteONe0ah31WIeOEAUYFPQpz0EVDflQjqYlk2g==
X-Received: by 2002:a05:6512:3501:b0:539:fe02:c1fe with SMTP id 2adb3069b0e04-53b47437185mr252938e87.16.1730149801564;
        Mon, 28 Oct 2024 14:10:01 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1d5e73sm1178787e87.234.2024.10.28.14.10.00
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 14:10:01 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb5743074bso39137361fa.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:10:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU26XmBzNcmPSPdmLP/UZnxXrSWhEHkbP+MHyKGg95ay63ywDNGwc7qK2LJ8N5a8LFLGH2vg5v/JNCbCCG2CylD1no=@vger.kernel.org
X-Received: by 2002:a2e:be20:0:b0:2fb:50e9:34cc with SMTP id
 38308e7fff4ca-2fcda112689mr2795051fa.17.1730149799851; Mon, 28 Oct 2024
 14:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028191700.GA918263@lichtman.org> <20241028191916.GA918454@lichtman.org>
In-Reply-To: <20241028191916.GA918454@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 28 Oct 2024 14:09:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X0TYPpLow=GGAcNGz5_joKG7-d=-DorDcxh9ppgNdQaA@mail.gmail.com>
Message-ID: <CAD=FV=X0TYPpLow=GGAcNGz5_joKG7-d=-DorDcxh9ppgNdQaA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] kdb: Replace the use of simple_strto with safer
 kstrto in kdb_main
To: Nir Lichtman <nir@lichtman.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org, 
	yuran.pereira@hotmail.com, jason.wessel@windriver.com, 
	daniel.thompson@linaro.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 28, 2024 at 12:19=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wr=
ote:
>
> From: Yuran Pereira <yuran.pereira@hotmail.com>
>
> The simple_str* family of functions perform no error checking in
> scenarios where the input value overflows the intended output variable.
> This results in these functions successfully returning even when the
> output does not match the input string.
>
> Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> simple_strtoul(), and simple_strtoull() functions explicitly ignore
> overflows, which may lead to unexpected results in callers."
> Hence, the use of those functions is discouraged.
>
> This patch replaces all uses of the simple_strto* series of functions
> with their safer kstrto* alternatives.
>
> Side effects of this patch:
> - Every string to long or long long conversion using kstrto* is now
>   checked for failure.
> - kstrto* errors are handled with appropriate `KDB_BADINT` wherever
>   applicable.
> - A good side effect is that we end up saving a few lines of code
>   since unlike in simple_strto* functions, kstrto functions do not
>   need an additional "end pointer" variable, and the return values
>   of the latter can be directly checked in an "if" statement without
>   the need to define additional `ret` or `err` variables.
>   This, of course, results in cleaner, yet still easy to understand
>   code.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple=
-strtol-simple-strtoll-simple-strtoul-simple-strtoull
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> [nir: addressed review comments by fixing styling, invalid conversion and=
 a missing error return]
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
> ---
>  kernel/debug/kdb/kdb_main.c | 69 +++++++++++--------------------------
>  1 file changed, 21 insertions(+), 48 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
