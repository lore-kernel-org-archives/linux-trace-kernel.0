Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5CF54DAC7
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924559; cv=pass; b=kSSvyW6n9Y4dvlCxlfPxxu9QxzXEkWJqeLG8c3fXr+Q3rIo2CLFLuobo8/MlFTyX27hPyJ86DkDvD6UrInMSNG+kWr0QGDpJS508mZ7ynvJnycNAogrONSgtEQJWRVqBlxeOID6g6+6QPq47H9e3gFihX355K801pdX1vN+bnls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924559; c=relaxed/simple;
	bh=N4S4WhX9y1egfYubZD+cGlmH0A5CORT1pqeSQxAxxVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbjUeuHN717XgMyzxwn/mUIjKJ9WGWxZbUkzI7E9a8IX4mz7arFnisaaUFnFFFhpuuWYIoFVTPvj8bU/TN+4BsV7dh7nhgtVi2K7DtsXST/9PwTXNqsAe+HvBtbPOf2l6bP/Mwwz9AqZQFrXzlj5uFyvzGbMjuWTQiZvcnCtTnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I1p9abS0; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I1p9abS0"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b0a36f1c95so3848557b3.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 13:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791924556; cv=none;
        d=google.com; s=arc-20260327;
        b=YGuyc1dfd/ZgS6KAjWMq6uPxlrDZA3FqbgEfkhTHF9jshrUC8vbE7UC72hg3pxra6Z
         acfXgsGPvItV7xxJXY77b9rvMmX6mF/4zwmcRjLwkTObEhUnz2rIMuTuz6/lNmxTMJdi
         kxN9hNOAl/kFssq6P4NTrbwDtw6toD4sJCQVjaxTz993ySTuhOTsXDL0EFCd9UtqKoDO
         vZQmQGhPkKiaypyTD9IzxGNl8rv0oCOx38tjghSY9G6Z4JGaQkn+gyvDeMgCTE+4eH47
         wALSOi9zUkS1b1X5U1U7yHHHUfazh6kpcmJ3WgOjBXPtbfYzMgm3A2cNCfF4Ir06jziD
         MjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dRtKBgWA0Jhd431B/P66jOflMrkNQBh/GJ9zmcjureo=;
        fh=69Gl9JwbIp+Qxj/ESBYsNLfJnZx5XJFC20LNL4TfwmA=;
        b=oYTJPIU9lf82y35s/53cLNMhBWCWR3DwlmspmryFYAxZNq0Z2JAWRBbhZsh9JG6YOL
         szYOsHgduS+rysfToeo5fw+5PwOMgjE2n/wLu1aBC7J7wlcKmK7vKBOZLIiV83vEiqKc
         QSIeCuTpPXejQ9DrNcmR9IX5t4jq6mmpA77Yle/a4lrj2rOt/MmGzjLSU1NTFSwVDrJV
         RHMUfwM1INp8sguV3XgmwB8dyB7+jG5AZE2qkuidJaHoWVh1DTXvfHQJKdjlfLN7EOoA
         lubgz+t/rnmYsiIX+wnrQupaCgEEjnvDcNm6VY7JIK74oyOEQj0fGmy/tmysqiKrAJ+M
         jKyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791924556; x=1792529356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dRtKBgWA0Jhd431B/P66jOflMrkNQBh/GJ9zmcjureo=;
        b=I1p9abS0I03ydil5tw+1+oHm1ZRrXzApJ/AyHzRfe1fNjgAPynndgF9MlwKwcXtX2L
         mv22K4aWNMCfrPIvMq4w60WpmeecYq5YZpIubkwPRtTSUv/nBo0YaqkqQPdCbwChnmNh
         C6H0fVgHya/BqUURY0utSk+jRiTHujEtwkfBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924556; x=1792529356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dRtKBgWA0Jhd431B/P66jOflMrkNQBh/GJ9zmcjureo=;
        b=bt8ytwN73xBehOaJXT/SuCmzFTY7525x8+NVFP1OujwevQNXAwvbARs0m3LLiOaDpx
         Um9RaUhdv9Qcuevfmx9EAYfVt8OQNvtH/WaQ1ap1WW20DHasglwTJI3TidcgvYM/BVEx
         +6hRvE2v9odZq1etf1zmzs5pPNMmPifwZm15zkHNBUW0lZtphg20XwvMX1wFRzBjPRQt
         4bjirWsJVXocZp4RJVJ08PtUUZX5EGIKEY4YXd29gebZtjnC2w7uqQ/K9OxXdh2AoIF8
         SBjKuzxdKJWvlG7cpkh6uuvYoTE4DRHflmr1jh9g0sa9QmJPgbb6otuMnVKEijsqLFBa
         4rew==
X-Forwarded-Encrypted: i=1; AKwUvByXgytxzeZs4mDUoVLDoWi8XPVxpRdYNfAzF5NDyO2E3V8IIViYrz1fuNzxuZ3llbwhtwlG+KvWih7Y5lIWEZp0WaM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3HBQ+lErn+wg6ohe7SftMktMRc2sULlwJhFcY/iydPokwigKY
	Rw9iSe+5M6oxlbSaUkbJFVZI5HwFT8rJR/okzz09Sji2OgSjuUpHFpjcp02f0pURO/CEujP/PCa
	GkxPYMb5mffEUWEDBV1tKAHnKhmfsttqIFqcPGPK6
X-Gm-Gg: AYBFou2hkZnRlTg8qSSlMpjDGvaNbLV/AHW7wz/TWVnZfG1r+gzsmdiZ60hY6HT2KEl
	wi+smWrfDA6CDQ3uQVV7hj1AllfMUYq3BnET1CL33qTwEZ3pU/kYCHhrRI+67XLMEUS3BRAhfP0
	voKhG1UG2rd6ScER0KZtIQXgg00CmIOzCU5Hk9CXyClYoE1wum+9j7ZOyjZGcYvvkEv/GFAAJ2d
	xiSX5b2YG9fZ9sB/rHmwGWHVNJR2l9Kz/MhbE1y6i6+52IEbzsg0HlUaEq9awRDtg5hnYOR4kUN
	/xaRuO67YbgeIC1DT/SO4393NtF2dk80elwiVU50j0XDnHKiEkrGkFBMJMWtQHCp9QhjssBs2xp
	sU4WZTCJsjg==
X-Received: by 2002:a05:690c:c513:b0:8b0:a8cf:f424 with SMTP id
 00721157ae682-8b0a8cff8d1mr29927657b3.41.1791924556355; Tue, 13 Oct 2026
 13:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-1-384af01da3ee@chromium.org> <sashiko-outbox-166133@kernel.org>
In-Reply-To: <sashiko-outbox-166133@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 13:49:05 -0700
X-Gm-Features: AclHuK9FMbu9JZUnRnsoojppgwhlqyo5kwjgao5eIiFBqF9-3uTME2iK-puHtSM
Message-ID: <CAEe3GZGi02TbXmPzFKKdf_nU0qejx+xeRW_2xKQ0B7RTk-VqEQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] Documentation: Correction in HID output_report
 callback description.
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, robh@kernel.org, 
	devicetree@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 3:29=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] hid: documentation incorrectly relaxes asynchronous requiremen=
t for output_report
> --
>
> commit 6d8fa62fc058c7f5630a13cc92c85b7867bc9869
> Author: Jarrett Schultz <jaschultz@microsoft.com>
>
> Documentation: Correction in HID output_report callback description.
>
> This commit updates the documentation for the HID output_report callback.
> It changes the description to state that the callback might be asynchrono=
us
> rather than strictly requiring it, citing i2c-hid as an example.
>
> > diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hi=
d-transport.rst
> > index 6f1692da296cf..2008cf432af12 100644
> > --- a/Documentation/hid/hid-transport.rst
> > +++ b/Documentation/hid/hid-transport.rst
> > @@ -327,8 +327,8 @@ The available HID callbacks are:
> >
> >     Send raw output report via intr channel. Used by some HID device dr=
ivers
> >     which require high throughput for outgoing requests on the intr cha=
nnel. This
> > -   must not cause SET_REPORT calls! This must be implemented as asynch=
ronous
> > -   output report on the intr channel!
> > +   must not cause SET_REPORT calls! This call might be asynchronous, s=
o the
> > +   caller should not expect an immediate response!
>
> [Severity: Medium]
> Does this documentation change contradict the strict architectural guaran=
tees
> of the HID subsystem?
>
> The HID subsystem design rules mandate that the output_report callback mu=
st
> be asynchronous to prevent latency spikes, performance degradation, or
> deadlocks on the high-throughput interrupt channel.
>
> By stating that the call "might be asynchronous", could this inadvertentl=
y
> mislead future transport driver authors into implementing blocking,
> synchronous callbacks where they are not permitted?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-ups=
tream-v5-0-384af01da3ee@chromium.org?part=3D1

The "must be asynchronous" rule doesn't match the in-tree transports.
usbhid and i2c-hid both block in `output_report()`, and hid-input calls it
from a workqueue as a "synchronous output report". This patch only
brings the documentation in line with existing behavior; the actual
requirements don't change.
