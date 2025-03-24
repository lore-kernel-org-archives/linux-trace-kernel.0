Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9686D26136E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841567; cv=none; b=lISzalOXMYs79a9ewsubfL2jp9dsE0ouWRwqIDL+rm8XctKgmKfgbVsSt/oPvoknnLbmohRxKvVq1AQWquK9q/lnm700EfR8kzIPLSgOqe79jSoxAwtkayXP5zWSRj05Mw8cZi8NVEmNDGgrxVkabXMKaT7Q1vDn7hoNkONpdl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841567; c=relaxed/simple;
	bh=Mhdsp+fu5yOA8uNU0KEF6NpseSlEi/vhaSmiOaRFYhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHIik5q91qgWRCtwEbWy4N0WwOYXfDp+WhDHPQvA5kxu0vN+XK9MFqe2G05PosBAL95sUfLqEointY8pQTKkPKT532jcFKuoT0BNa/yWJ+lWAahfWEOX/u7ynIDYxSCxzp95tE7NQTgKrBY+3Wg/C7Ub1UMMGupU+wz148/0Yrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=SMc1LQgu; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="SMc1LQgu"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bd21f887aso41722771fa.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1742841564; x=1743446364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dSvgAoR4X2jTKgjY/gxrCZ59LeK/qq4/9hAjzpPZyo=;
        b=SMc1LQguv/X/HEYybEEkE+wpFdZKyxq/le0OxkuN0wkn/QiE8RIonharMlRlHeQJAE
         7E2dkZ1wyklTAE7OFUW6kUyXjgQqMk8RAQv4Qgwqj3mc89dSsEtfFeo43+ezIFpRUsxU
         dCOwUYtbsJYWovJxdg+vZPC9fGkLb/tqeUwVYzOlyfuPNL80z6cfBY8lYE4idCev/qYl
         Q/O3gBeNkSDwI8FDa+b/lqfDe+eES/q4XmcqTYtAokHFqowM2I2rqcG9/5fOJqcmI2M7
         Q2BJgEl2mGmftzLP10U9NiAMYpT/nsg4mCl/sGlyjOeBNFL935Tq/uGTYig6Sv0sWw/I
         wBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742841564; x=1743446364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dSvgAoR4X2jTKgjY/gxrCZ59LeK/qq4/9hAjzpPZyo=;
        b=Gjgg7f90R01ck6WJrT4qQtGbPnkJJm41kZpD1Mih99Kh375YDqe5rYpx/oeNaFCX7y
         heGZnjdf9XjJBTJ81cjxaZbTyuGKwhjAiHWmWA5F2PclvHU6ShnhNSRY+grFGbSuxCGr
         MNXCMoaiK2w+w5B9CflkTAf9I4vH5iIX2PlzupMMQ9wG4t8Xo3xWYQYxN9/+emva7zHa
         4WMvaTi9L/b09i3S/eEpftJcQxwEUs6qHn0je36oyBZ3AnyblwUekakIwh2hGZqam2/d
         OKlo+0yB4C6io3RTAy0g7aWUXZBZ0jskddn29oh6RTUGj+uV46TIBg0feeo7JJT9NjYP
         f0KA==
X-Gm-Message-State: AOJu0Yxlrgrtm4zd5FKq+9xWhAH8XHi+qnn3YIPU6dFb0aEP+p68XO7g
	XGLqzpBvUXjip0DEz6cviW4G9aNUEVMrmbZeCtU1lMbcjp26px2sYt12/h1yIIyDyVbL11u7EvB
	jXKQxZIXS6kGodoWy9gfwoLAnaw+VM3etkMKjRJK5eLaEit/6lQ==
X-Gm-Gg: ASbGnctVk9PrcKMLj0HwamHB2P8hcLMzFxiFkrSbONPu382PRxE/zB4ULhjlSKrdLyb
	oHLkE4xn7ZQUMPzUhTVk24FNc98N0PsBCEHl3g6OWIdRQNVT4HuixlslH0VQ6vuV+Bmt+xZM1xj
	SXAYpqVwMSUlIq3ieAfWtBqgVM
X-Google-Smtp-Source: AGHT+IHJKjRfZPKCHpYA/C+a4MilUUuDoMDt0rm5JbwiUkg0eYF50TqERvRFrfPoKC0NOOPrPGP7fFsM+TIxjXeyf6E=
X-Received: by 2002:a2e:b8cc:0:b0:30d:7c85:14f5 with SMTP id
 38308e7fff4ca-30d7e28bdeemr65485861fa.25.1742841563616; Mon, 24 Mar 2025
 11:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABEuK15=+Bo7xkBn5ufytVowt0j3fVEsdGVsryn1zH8KxfoCyQ@mail.gmail.com>
 <20250324133619.6c3babf7@gandalf.local.home>
In-Reply-To: <20250324133619.6c3babf7@gandalf.local.home>
From: Sahil Gupta <s.gupta@arista.com>
Date: Mon, 24 Mar 2025 13:39:12 -0500
X-Gm-Features: AQ5f1JrZEIn-QvkFE5t66z1EmW-Fldzmdux5dJ-jdPLLCleUUHK19hQrC0GFe_M
Message-ID: <CABEuK15jWHSU8LaRXc1EzvhiLdBHeM9E+sKs7VyP47RRSxG6cg@mail.gmail.com>
Subject: Re: ftrace: sorttable unable to sort ELF64 on 32-bit host
To: Steven Rostedt <rostedt@goodmis.org>, gregkh@linuxfoundation.org
Cc: linux-trace-kernel@vger.kernel.org, Kevin Mitchell <kevmitch@arista.com>, 
	Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > Hi Steven,
> >
> > On 6.12.0, sorttable is unable to sort 64-bit ELFs on 32-bit hosts beca=
use
> > of the parsing of the start_mcount_loc and stop_mcount_loc values in
> > get_mcount_loc():
> >
> >   *_start =3D strtoul(start_buff, NULL, 16);
> >
> > and
> >
> >  *_stop =3D strtoul(stop_buff, NULL, 16);
> >
> > This code makes the (often correct) assumption that the host and the ta=
rget
> > have the same architecture, however it runs into issues when compiling =
for
> > a 64-bit target on a 32-bit host, as unsigned long is shorter than the
> > pointer width. As a result, I've noticed that both start and stop max o=
ut
> > at 2^32 - 1.
>
> So this has been broken for some time?

Since 2021, it seems like. However, this slipped from my radar since
we've been using 5.10 for the longest time, which didn't have
CONFIG_BUILDTIME_MCOUNT_SORT.

> >
> > It seems that commit 4acda8ed fixes this issue inadvertently by directl=
y
> > extracting them from the ELF using the correct width. I'm wondering if =
it
> > is possible to backport this as well as the other sorttable refactors t=
o
> > 6.12.0 since they fix this issue.
>
> You should ask Greg KH on this.

Sounds good, tagging Greg.

Sahil


On Mon, Mar 24, 2025 at 12:35=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 20 Mar 2025 16:54:58 -0500
> Sahil Gupta <s.gupta@arista.com> wrote:
>
> > Hi Steven,
> >
> > On 6.12.0, sorttable is unable to sort 64-bit ELFs on 32-bit hosts beca=
use
> > of the parsing of the start_mcount_loc and stop_mcount_loc values in
> > get_mcount_loc():
> >
> >   *_start =3D strtoul(start_buff, NULL, 16);
> >
> > and
> >
> >  *_stop =3D strtoul(stop_buff, NULL, 16);
> >
> > This code makes the (often correct) assumption that the host and the ta=
rget
> > have the same architecture, however it runs into issues when compiling =
for
> > a 64-bit target on a 32-bit host, as unsigned long is shorter than the
> > pointer width. As a result, I've noticed that both start and stop max o=
ut
> > at 2^32 - 1.
>
> So this has been broken for some time?
>
> >
> > It seems that commit 4acda8ed fixes this issue inadvertently by directl=
y
> > extracting them from the ELF using the correct width. I'm wondering if =
it
> > is possible to backport this as well as the other sorttable refactors t=
o
> > 6.12.0 since they fix this issue.
>
> You should ask Greg KH on this.
>
> -- Steve
>
