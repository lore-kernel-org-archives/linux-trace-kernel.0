Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF51DFE21
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139107; cv=none; b=lWe6E43NyydvAaJKMrrmlq445es17Jbgcex5/Sq487SDTqsiI+OhuIa7f7L5BgRJtSUTscNusISiTD7KTDasCcw3xGiO7LlpPEvvD++LFFrIYLOMKqJM15vo40ppZBl3h9VuB6qNDdh0IY+vtLu72xVwuJAWO7jyxUcb69ULKtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139107; c=relaxed/simple;
	bh=fbnLJGdBoUXkG4F1kWM2e7N4J0NhnGUvlbGNvY9va5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLIABA7LZdm6ZsA770GQC/hnszDDjCLLszBWY+2jPuxkx/CfR9VbRbeInqEmlUg5DDjMEelfjCFvpCXARbZ4vqglKZrizD6OjFZ6L10WhTbur9QI9lY+NbsHKZkZu4x+s7/yRhSksbPZThKC0RYX5XkXEVCL/8Do29jggJ7kR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LE/aZVbJ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LE/aZVbJ"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53a097aa3daso4012787e87.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730139102; x=1730743902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5UI8Ycq46pSTtV4R594ykmuHChRzRyHTc8M42JBCVc=;
        b=LE/aZVbJLwgnrBDYGQrFq9Y5mUmp27ciMJSQ7nq0qs5dQB9CjMDgG/hgvIKSyF6xEA
         HOO259uMWscRrZZeFNtLkOw4MvV369GHT6TnkkNACo43Ao4V6E5u8kuHczywUBErVnfo
         XzlkK7SDzwZU/AB+lonGB0WHLdoYt2/Sb0vDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730139102; x=1730743902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5UI8Ycq46pSTtV4R594ykmuHChRzRyHTc8M42JBCVc=;
        b=CCvH6tZNDd6vGRmU2S/S3/nxHFFXaNtcb5H1jGufKvxl8vH8vHj0ftCIqBr+GgNYw/
         gXhnNfbSPR9tlmaFCDl1uJGi/mytwmuS4sQF+TMmd691el9TDdrCs3Kev2lNFB1+IE7T
         OKuOR2wXPMSIXksGWm/x/uv01xIKmd5BZQDoKc9q+dv7JVgwxOQckb5GVCzuvzZYtx6L
         tbp6XHhiS4W/tIilDO0EMiA5SbU+4rKX8J365gdPdP4buVACkeePMPS4a/KuJ+Td2UpI
         ulIUKDDxCKDXVI/EzVi8lEqLBIb5o2ZcXuby65cMCoQsz1Hb59ztUbjPo+cLATCDAmJ/
         ZngQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/nBOF2ZpIoyzXW6qn8PEQNlTu351nSpBdQiIFSS7uZXZ3OhVQ+ZISw2peM5ykQjJckw9d2LbE11RRa+Ity0B6E+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwUkEqwVzPJSEkIp2Ha6oZz99s9Ay02HxCN+gAm2FPHuOQzcnd
	y/ZrnGHGu30/EA1G/Mx2A8tg8K5z1p5p0vLN9hveqMacFUfisr+IzdxeGzk1gqkABGvKI6Uv0Sl
	tZQ==
X-Google-Smtp-Source: AGHT+IG/QFk0gGYO+iyXSxkOiL3YyuNaZBw/kQ5m4VqV/Pv41UKmP1FTn1g8PDoGxZm3mgzKZ3P5wQ==
X-Received: by 2002:a05:6512:3c91:b0:535:6cde:5c4d with SMTP id 2adb3069b0e04-53b348bc2a2mr4355219e87.3.1730139101783;
        Mon, 28 Oct 2024 11:11:41 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1f44aesm1132858e87.299.2024.10.28.11.11.40
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 11:11:41 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb599aac99so42206591fa.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:11:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyA9xOBOQWsqxJpKl69NbSK84Ug8VeWoXCdz8mFLHnGhIH5grpAoAhbuN825rKSO2GEH3N+kzXCgLwSdEw6sx9d9E=@vger.kernel.org
X-Received: by 2002:a2e:802:0:b0:2fb:2bda:3872 with SMTP id
 38308e7fff4ca-2fcbe0ae3a7mr28225301fa.45.1730139100482; Mon, 28 Oct 2024
 11:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026144724.GA892311@lichtman.org> <20241026150040.GC892629@lichtman.org>
In-Reply-To: <20241026150040.GC892629@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 28 Oct 2024 11:11:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X4Wg9fC7eqhV7sAy-QK6+oE49v2nY0+gnaZpDeA=kiAQ@mail.gmail.com>
Message-ID: <CAD=FV=X4Wg9fC7eqhV7sAy-QK6+oE49v2nY0+gnaZpDeA=kiAQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kdb: Remove fallback interpretation of arbitrary
 numbers as hex
To: Nir Lichtman <nir@lichtman.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org, 
	yuran.pereira@hotmail.com, jason.wessel@windriver.com, 
	daniel.thompson@linaro.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 26, 2024 at 8:00=E2=80=AFAM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> Remove logic that enables a fallback of interpreting numbers supplied in =
KDB CLI
> to be interpreted as hex without explicit "0x" prefix as this can be conf=
using
> for the end users.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
>
> ---
>  kernel/debug/kdb/kdb_main.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
