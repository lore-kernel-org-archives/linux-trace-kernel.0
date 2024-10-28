Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9AC1DF990
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139137; cv=none; b=iW4zCJMDNcMSp7PaUnA0oTj76Imj4h4O37HfKVzwoHVE1RGiDlLwgXSEuRE7kmVbSpdnWu9B1gy0MdeYDObzmCM7UcqXt76sVSlwW9pvyg9dACNwwww3GM1B7ERsbZKM+v7SnVYVfzLFhaD8RnoC02JD18RyaHH0YWZlMLs1hww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139137; c=relaxed/simple;
	bh=mDrRQj1Mrib9/EgojunqyD42XEGRcvIiFq/4nXqWp9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSeUkXdsEINOYUoLL7VX2aCU6ZXZDmIbmg7Q7eE7cE39VjwxX355Rr4o3zJersxCArqT0JbRQwDMg51LAis3s7T1OmpEm1tvY8biTpySB7vvYjAM5qbJ8nPudCEX9Da3Ip4SzFehj+jH8YGT3H/dffh1/dUBaR3XwS5YmG/HV+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e4lBm7sq; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e4lBm7sq"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539fe76e802so5538284e87.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730139131; x=1730743931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5Mp+oG6fw51RJspX3eEPAbfvpSkKVhKdPlkTR9F3Y8=;
        b=e4lBm7sqxKu2iiM+Lu2SbGkPV7zd8ocXvEZFIjyxrEyPUlu709p8/D2ialVDUrgjvc
         opff/eti08pPzmdbBVLSXIiheBYCQVNSo7Rn/U0e4Gx+itkQOJKMn3vw/1xe/G1RBg1Y
         zGPnKr2nTcdXW6U/9MD5FNc9JD3ORYVArifFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730139131; x=1730743931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5Mp+oG6fw51RJspX3eEPAbfvpSkKVhKdPlkTR9F3Y8=;
        b=jMwv3g66wraO2ue4X4sXDgx1dJoQtzAYwBnPPkD+o6kGlFIrIRH9CFMriuvB6q4ads
         xB6U5Zk0bIsIklzMJRnwuRKU+U9f1DRuz7OGiFITqqFRuqOh6X5XMNQ6K9tb5HEM+8+U
         rX5RcX747omvsE87k2ggLvllyxDIblgLNBFr3q0MmKfoZDCA0CISm5ISYFtxBtnylRqt
         b7wMO8zH5kZmbXreOFCB9zjAjZNy205n0ZWVlLa7m7jEqEHJhQWmnPge9Zdj+wMC0xZN
         dl8yStw2rk+mEZX9mV+ThTFLoK8pUSeYXQRh5Oocne8p98JCLqwAA53uVGOMA/z/MzoM
         7biQ==
X-Forwarded-Encrypted: i=1; AJvYcCV16A7HtiSqUn2+1gOb7Mqk2/FY2Vtxruk1J0oCL/2bMbC5rvFggRS6GE1H+WqYYjlBHwadzsw0RGOSBMdxc0nOhA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/gLTKlGPf6Y90K7beirL67P+RhsUbKP9SmwtQltk1ARKgcSfb
	shmRRb1DnOFwLVFURnvyeujdjl81QP3D9gs6cw9KUNEUw8nTgd6bX/cSHFEcuK1dMrdOVQAxqdz
	TpA==
X-Google-Smtp-Source: AGHT+IGq9zu4YWlSSzAJM82mvqTmJXKQu63TY/pQ9GTXuQef5FcpKBh4DBld4r+WL07IYMraDUqVtw==
X-Received: by 2002:a05:6512:1384:b0:536:a4e1:5fa2 with SMTP id 2adb3069b0e04-53b348de8c1mr3838604e87.26.1730139130722;
        Mon, 28 Oct 2024 11:12:10 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12bda6sm1132594e87.105.2024.10.28.11.12.09
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 11:12:10 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so46236771fa.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:12:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU71RCkyP+X5AcEljkC9+6PNM9VYTsEzYf8EDzcP0k91imgQ0Vb9BJ0f5aq9wRzMXp6BRNzibNHw8YJho1+uH97ugM=@vger.kernel.org
X-Received: by 2002:a2e:4619:0:b0:2fb:5504:794d with SMTP id
 38308e7fff4ca-2fcbe0bddb9mr33372431fa.44.1730139128714; Mon, 28 Oct 2024
 11:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026144724.GA892311@lichtman.org> <20241026145417.GA892629@lichtman.org>
In-Reply-To: <20241026145417.GA892629@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 28 Oct 2024 11:11:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+YLXs8GugQUhqK9aQM_eRzoJwLc0Yb_OwW9baqHkPKw@mail.gmail.com>
Message-ID: <CAD=FV=X+YLXs8GugQUhqK9aQM_eRzoJwLc0Yb_OwW9baqHkPKw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kdb: Replace the use of simple_strto with safer
 kstrto in kdb_main
To: Nir Lichtman <nir@lichtman.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org, 
	yuran.pereira@hotmail.com, jason.wessel@windriver.com, 
	daniel.thompson@linaro.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 26, 2024 at 7:54=E2=80=AFAM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> @@ -2083,15 +2064,10 @@ static int kdb_dmesg(int argc, const char **argv)
>         if (argc > 2)
>                 return KDB_ARGCOUNT;
>         if (argc) {
> -               char *cp;
> -               lines =3D simple_strtol(argv[1], &cp, 0);
> -               if (*cp)
> +               if (kstrtoint(argv[1], 0, &lines))
>                         lines =3D 0;
> -               if (argc > 1) {
> -                       adjust =3D simple_strtoul(argv[2], &cp, 0);
> -                       if (*cp || adjust < 0)
> -                               adjust =3D 0;
> -               }
> +               if (argc > 1 && (kstrtouint(argv[2], 0, &adjust) || adjus=
t < 0))

Between v2 and v3 you regressed. The kstrtouint() was supposed to be
changed to kstrtoint() here.

-Doug
