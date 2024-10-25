Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294731D8E1D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895510; cv=none; b=fRZWBXEoHcf+tcOuFTiWK8548Ytjuk2tp8WQDrFwweDxfNuYq/flMSG2vX4TOzTwADJTllrgEhsvfdsfnVJK86i+031Mw5887Tk59rgKasvGBKvQ3VOV7Ox7QOxA3rHnBLztfrNDW65VpCj5KlBjr9AKbu32cUagBQ0ELxvzlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895510; c=relaxed/simple;
	bh=NkHx6XgJkMV6CszYdB/P297/hMHuzzGQvrdB5FeGWxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ew6x9fRpfejDdw/uz3skMhqWnEh390AlzOg2NU3CQfRtjam3Y9olcj+depJ1vRAVlmDe3WMaZ7Y7FlGBj+u+Z6jt3gt1XeqoyMy1Yq7iHak3NHST4b4cHnRml0FpSQqufnDhRP60YaF0yAaAAGOwXBRPmiX0mMA+hSS3atyyrAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R2vq4Vur; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R2vq4Vur"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e13375d3so3064452e87.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729895503; x=1730500303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFr8zCuXx7Qa1HYksDWyqy8DL1qhBnHCzBZwSDddfWM=;
        b=R2vq4VurDtGII7xm/P4GCfCPrr8tWbOuATiWwDtQMxsVjMR2jD/kgRMvX5j5TT/zps
         ekjDGT6KLdPF5n8gCnr6voy7kZOfZE9o76bid/NOYpgyfaGf6IpQnBBhABsHRwVwvk/E
         m97AwAUzPM1jnr90xmCHfE6XQAy4EC4IwqkkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729895503; x=1730500303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFr8zCuXx7Qa1HYksDWyqy8DL1qhBnHCzBZwSDddfWM=;
        b=sqEtK+YWQeAQGwBkC7vbGc7T732YFk36JYLZ69e73w9Ar8Ox2tU7Zd/ZhynRgPGaet
         naoMw/YHinq2zwcwx2yh4Sk6R896Se66fLC7EvusJ8IqOqjNuTU4XiqzwocQTBrtNk3Z
         Mvjb6l+tpZhG4IA614wct9FDJxFo46thcIY4wUk/KhPN5mxxD6Mn6P2gpCWGdoRMVh1M
         PKbBATkwUM54QxPSpki/2W/2me+nfREKPgU91g5tL0wHGknYM3JUBxp5FmRw5tvA3AEj
         +WsNvRHvxqqYySW8CHvuF5JuACo+Kn8wxxs12ehNzKRImDT5fpvr6BOIKyXiqJ7Wzk+h
         i/GA==
X-Forwarded-Encrypted: i=1; AJvYcCV8xVKgC7U49ELoSFXgcaCkIWJsCiHBlXAb5TCCw39ZStU3kws4jE0wB8opD7WWF/QE3BTlMwXp5Yi7E2vFX0vfU5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwfyWIjF6yB2vE2s3FGk/WcVVWJlFq+k3VpYo8NN3MqFnDt1PB
	B+FbymHdkUYYVD8kCgEyytR/wb2BU/Ay/DM+nRcVAbha6PICx+ZuVTac79xiq8jlsNDqkCcPmu3
	PrA==
X-Google-Smtp-Source: AGHT+IHfWokoa19RCa8ggCIJ1Bo+H2xoOyafd/L355CoqDbtOc1OjOKeEanH5eZ88TW+KpdcEkosDw==
X-Received: by 2002:a05:6512:1189:b0:539:ec87:bc7f with SMTP id 2adb3069b0e04-53b348d63ddmr437663e87.19.1729895503148;
        Fri, 25 Oct 2024 15:31:43 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1adf1bsm331961e87.177.2024.10.25.15.31.42
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 15:31:42 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so24432121fa.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:31:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhh08CmWXAcf/fuUGeaSh3v2MJle/0s8gShJgEptC7i+vV8xRx79D18uTbzJ1bBo8cM9Kvmc4VmwbECQK7wj7FSFI=@vger.kernel.org
X-Received: by 2002:a05:651c:b09:b0:2fa:d604:e525 with SMTP id
 38308e7fff4ca-2fcbe077e48mr4065661fa.28.1729895501542; Fri, 25 Oct 2024
 15:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021211451.GB835676@lichtman.org>
In-Reply-To: <20241021211451.GB835676@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 25 Oct 2024 15:31:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WJsUZ1+v5Rd+Pcx+3tO18ivgax4i8XfRg2BZJ_OEEu+A@mail.gmail.com>
Message-ID: <CAD=FV=WJsUZ1+v5Rd+Pcx+3tO18ivgax4i8XfRg2BZJ_OEEu+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kdb: Replace the use of simple_strto with safer
 kstrto in kdb_main
To: Nir Lichtman <nir@lichtman.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org, 
	yuran.pereira@hotmail.com, jason.wessel@windriver.com, 
	daniel.thompson@linaro.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 21, 2024 at 2:14=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wro=
te:
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

Since this was Yuran's patch originally and is still substantially the
same, keeping their sign-off first was good. ...but:

* You should have kept Yuran as the "author". This should have
happened automatically in your local "git" repo when you picked
Yuran's patch and then made changes. If it didn't you could manually
set the author with "git commit --amend --author=3Dblah". Even if it's
right in your local repository, though, it won't be right when someone
applies your patch. This is because when someone else is the author
the first line of the commit message is supposed to be "From: Original
Author <their-email@address>". Your message doesn't have that so when
I grab it it looks like it came from you. If you use a tool like
"patman" or "b4" to post your patches (or even git-send-email) this is
handled for you.

* When you take someone else's patch and make a small change it's nice
to mention what you changed in the commit message.

If you want to see an example of where I took someone else's patch and
posted it, you can see:

http://lore.kernel.org/r/20241004171340.v2.1.I938c91d10e454e841fdf5d64499a8=
ae8514dc004@changeid

...though maybe ignore the fact that I managed to accidentally add a
Signed-off-by for both of my email addresses--oops. You can see that
it has a "From: " line that patman/git-send-email added for me and you
can also see my mention of what I did:

[dianders: rebased to modern kernels]


> @@ -402,42 +402,15 @@ static void kdb_printenv(void)
>   */
>  int kdbgetularg(const char *arg, unsigned long *value)
>  {
> -       char *endp;
> -       unsigned long val;
> -
> -       val =3D simple_strtoul(arg, &endp, 0);
> -
> -       if (endp =3D=3D arg) {
> -               /*
> -                * Also try base 16, for us folks too lazy to type the
> -                * leading 0x...
> -                */

In my original response [1] I suggested that the removal of the base
16 fallback should probably have been done in a separate patch (in
other words change this from a 2-patch series to a 3-patch series).
That keeps the "cleanup" patch separate from the one that's changing
functionality. It's not a huge deal but it would be nice if you could
split it out.

If, for some reason, you didn't split it out then you'd certainly have
wanted to mention it in the commit message of the patch since it's a
change in functionality.

[1] https://lore.kernel.org/r/CAD=3DFV=3DVZ61XFb1Ks79BHr1jL1jwf_36wYXryy0ZX=
Oz1xTQ9zOg@mail.gmail.com/
