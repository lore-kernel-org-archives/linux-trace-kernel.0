Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6486B451982
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388392; cv=none; b=pNu3afIOZtsmvUALgekujYm+Lrad6nhnLCMHcG/u8ViE7cMrMEznVjwL1ycO0+s1QGWOWoiNkdBMtqgfLYJIlNr/Us02na8jZsCxmlqgnGqeKzojcWF4JkyLmQhW/+xF+Kshoa1UJlXpsKDbwxPUta7GivjJYdhrJMVXz8iAcmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388392; c=relaxed/simple;
	bh=eeRItUB0SKWeM7RCyFdOuICI6kxktnCIuLCLXkG9px4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZx3+Mw+pDTf+5n8ItTI+hpZkk1qU5mvuvSWl0QNDUIFkdUn9U5Ynv0lKJ5S7kqk4lDj2vCy5FUVQEC0feEPAh0lSdd6OOV7YNHx+lE4VfPPIzmWafdggrUdItXo8qq83yeVlR/dZWKAPZRQ4MWxi40CEjvKrUKNVbxnvepMS1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f++EZOng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f++EZOng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A941E1F0089A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 12:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789388388;
	bh=eeRItUB0SKWeM7RCyFdOuICI6kxktnCIuLCLXkG9px4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f++EZOngV+KQ6P8a4fRPKZ8M8KorE38aO7zH6dh9ssZka8v4xc7QMeqQD0UGv7Yns
	 bqH7r4SEO7dXwTX1E5hKqLa/FRBVBpTwMR001g+C2r3AolFdMzVuBfBxdXPcTC4peM
	 V/IXS6xRPGX2C3vhYT8k5jDxCF4COFh2jNH0rEJ0VrkjTIowhft+IlZ6AJAgygBdgP
	 01tr2biAyGu6iKRhTSIiR+IKQ5Le7CdPjQFU4APduR371c1QJqu8jkLebbvwyitMXA
	 0pTgqnDHOIifXdLoCA9JHWaHaQBZy+4ztIhLXMbrNhb+lW2Ly8vhn5HHgfosN2sBmd
	 sk+7KRKrlRvjw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a5938ab935so24137941fa.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 05:19:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxoksDsZxesT1zPSKACYF+Qir5F2u1yRLilBh7uzaqbOVM8HfhdkZrusRBfNql+TIAe0kJncyMCqhPxg/X4mA3QTZ0=@vger.kernel.org
X-Gm-Message-State: AFuF++kBgVUuPamTt2LLUolR6Tr/43jfcvIPJMl6XeQKBG8Y1I+LX9M0
	k8IAPTS9dOVmiLTNiu0XxqOxLapDylCazeB9UXZsO+1YPkURa6Ztm6JhnaIAPnSdny6c+EnaMtd
	/jTNTEADbY7bPT1icZUIG+Wb7bkHpk3Q=
X-Received: by 2002:a05:6512:3d8d:b0:5ae:ba8f:f9fa with SMTP id
 2adb3069b0e04-5b8ae6899c5mr576202e87.18.1789388387340; Mon, 14 Sep 2026
 05:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com> <20260903-i2c-fault-reporting-v2-2-fedeb91792e6@mobileye.com>
In-Reply-To: <20260903-i2c-fault-reporting-v2-2-fedeb91792e6@mobileye.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 14:19:35 +0200
X-Gmail-Original-Message-ID: <CAD++jLk1HGeROeeofBb61BP-sYSimOmMeAYQOp8HqV5cD1Bkjg@mail.gmail.com>
X-Gm-Features: AcwNN1XsXRmmAsjKAUdlCFQTuHSxsVr6HzbI570jO09tnVrZgTvieadHZeOTTSE
Message-ID: <CAD++jLk1HGeROeeofBb61BP-sYSimOmMeAYQOp8HqV5cD1Bkjg@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] i2c: nomadik: optimize struct layout, change
 unsigned char into u8
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	=?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:38=E2=80=AFAM Dmitry Guzman <Dmitry.Guzman@mobiley=
e.com> wrote:

> Change type of `tft` and `rft` fields of `nmk_i2c_dev` structure from
> `unsigned char` to `u8` and `buffer` field of `i2c_nmk_client` structure
> from `unsigned char *` to `u8 *`.
>
> Put two bool variables `xfer_done` and `has_32b_bus` and two u8 variables
> `tft` and `rft` together in order to reduce struct size wasted for paddin=
g.
>
> Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
