Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80521309EFC
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773363644; cv=pass; b=KT6CpPmBgQ4JYbGNNzMVROiY+0WC9c/hpItKmsoPYLWL7Xf4Rk3hO/LfFCNIrTMjsmRitXRxlM20LPfzXQuYp4BcASSF+Ym08WmAc7SWcWl27sOuqh8FTScuGt6eg5qXEWZzuoNeC+ZYSdr4XRwMSFFHJY0emI1MGdUG9rFA9XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773363644; c=relaxed/simple;
	bh=sWXbHUNWyCssRT+Z0j94kKl4zmDZN0doACSqgWVnHEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAHvSHLOyZs008CnvU3zPnDxGUmSJIOnNmjpF4t8X59DQSK4arvfymOBa1kBMTSa19oeDWSyo2JBvlhiLA6DFG+asYQHmsHdhxpFjdPGKlYriOwngQ6z/zna7IH0irksRZmNVhxhY4ssgbh4wBvcWJDqyG49x9z+n7B2ZFFjM7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZA/lz0jz; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZA/lz0jz"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ca4dfdd88so1883031d50.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 18:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773363641; cv=none;
        d=google.com; s=arc-20240605;
        b=RK5rRlGh2n0ju0UJ1U0XZpPO/6agxViuF7h2WoJNWpjw0F6FlJqK81jabfBohLHGIo
         DTT9GT6jX4vxAxokEECsOvAi+h9qHkNOTOLZ/c5acuK6Ou8SpxLTFromLahpwUMDz5qO
         7kF+YbT3wI4CbBkgO/GBW/G2Ifqmd4EJj8C4xiv8usfkMM1bRYQtrvm8OnKpziS6FpJ+
         l6kPfw08bArC3534MK19EZiT0S2L7ezElH2L7iBQFlnINr+Es0CZUvj+YC/3sUiRb/7I
         yu0uMZXfA+L/4bXVBRPCojQ4jrl74qhm1lAPC8Im83DKTGh/shDJjWVfKdc+ejwjKNRf
         CNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WEIoHUDBRKW7sPjWtgozpXFsqYAeqWilfaHlivAXGTA=;
        fh=xXIksGeIr2PPBMbi8aEldw/dRyzKChHfb1UjbVdNIaI=;
        b=SimzIV5TKE+2BrnOENJGcvFRRe1Fh7f1bUYoH0epaCrrRZ0oAmfbeAHyK8D9aT8tlQ
         oLEsfOMNhKBU/HmlYQ6dAVTt6aSrBbNcPJ6trgm076B23/mx7VQpZm8BivvMPeWDlPaw
         sqh58A5oYJLy/RNinvEg5OSlYZRbwf0QiTIn1Jxluh+np7Yv3Vy7ZsFHRl9sJn7pdX92
         49Z+8tBYHhNvgInpxDkjV51UoGzjpFjH3KYN+jeijPqA3D61RNkrTkQ9S1byRL8fCS7z
         gqjB8J9/PX5gkp399lfW5MntuBQauFpiDTGifSZA7T0OKMdLtK8zzdcU+XOVI6GxpYVQ
         /gSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773363641; x=1773968441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEIoHUDBRKW7sPjWtgozpXFsqYAeqWilfaHlivAXGTA=;
        b=ZA/lz0jzZ5SnEt27k5mt290nazi42vhGGnOyNcbDIrJk0WzjSHSUXA0OXFphwHSWli
         WNhDUXBka7oi/+/SldIRtUuf1Po9CwQ6Y0+CSBiC/7rRru2Mvrwgy2C7Lvu84y8UZU3c
         nmLVa2qKS2YKHBiYT/MZ/bSmE8EFdQz3BwQto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773363641; x=1773968441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WEIoHUDBRKW7sPjWtgozpXFsqYAeqWilfaHlivAXGTA=;
        b=O2EBBmeR8NZmZlTbVfFmpU5ndbyNvF+MSNVhMSqQ8K3LA2+h3uabW0kqkakgMVUaTx
         uHot9et91bwt78jYaXnOVQYQ65239WOYpZYR2rA5K+oamKpSlvMScTjEMnFysyZRdY+j
         0vdKet/Sp5XxCCMxejKZytRQco7BIcpCK9u4pacCsPeqT7U6cA3tsdaOt2W5Wr6XNJIg
         Y7kMAxFkkOWC5EhhjbC23Yb3LkHbhQc1zAi66grMg4GmqjlnFuOAjxiqtEQX1xFB8OWX
         VppYNgXm+RxtDD6d++AcvsVccXszQT7ssp/G5yiSWncN9rUFVupKjePKiM877nXn1nlW
         R7HA==
X-Forwarded-Encrypted: i=1; AJvYcCVpQppjx+0kAByc3RctHcSZSm0dno9XgZHOivhOEhUerSEofE8RmNK8jQ4L4FsV5R0sXHn4zbHDsABsgpKrcxEu38E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmxlA6n2dpsmI2SwrT4lPOtR9/Fu52gS6nxTg8tIP4ekZ/Erg3
	T3iyjoaGsClsCCP/blaiqxiZ+q8TII6asIkFsbVvtKwuUyjxzH1DjwE16NwuQyA872zNG3H2UHq
	7dBddlzFGMYb3bRrArzDyaNaKml74HJwd7dN6JTrP
X-Gm-Gg: ATEYQzxIFqAqdjJVXt8vmHB0ja2JY8K7DRjR/S9sWPrWC6vxoXTgxCvavovcTpA7G0o
	aR8ep0hP2mShW+6xrd7TBk1kXdx7sSN511yh2ZZJ+Yjv1pV5DqfJNjs6adQraAepc9YT7pPRry8
	sqwMNqwwP1eXB7DO0niBrZ5H8nMIRuKftkOZBaXIa5VOfqvCbBz4ZkcHPvsy7YAJijFlk2JZvPW
	KBecS1AUWyg1EcXY2AUWsuqt4uQKZg804mjNf/l6AB7c6kuiIeWDHyoDDSyI5SgztSXBXjjaY62
	TTQXDi/CwZ8U8ZUiRWOo2DBtIG8HSw4HwFLq4t5n
X-Received: by 2002:a05:690e:23c6:b0:64c:a815:511b with SMTP id
 956f58d0204a3-64e62f59679mr1215624d50.3.1773363641056; Thu, 12 Mar 2026
 18:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
 <20260303-send-upstream-v1-9-1515ba218f3d@chromium.org> <1cc6de61-8b56-492e-ab78-e3aa448f58ad@packett.cool>
In-Reply-To: <1cc6de61-8b56-492e-ab78-e3aa448f58ad@packett.cool>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 12 Mar 2026 18:00:30 -0700
X-Gm-Features: AaiRm529-VNRFl8j9TL1yc6G4h205p6aiqQ4Ar4V5wWtWy0meX15btognc57fcQ
Message-ID: <CAEe3GZF7ct1ZFH2Zd6AJnO1vBJQZobGaQKO+hTMJjFcCQddq6Q@mail.gmail.com>
Subject: Re: [PATCH 09/12] dt-bindings: input: Document hid-over-spi DT schema
To: Val Packett <val@packett.cool>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, 
	Dmitry Antipov <dmanti@microsoft.com>, Jarrett Schultz <jaschultz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 11:25=E2=80=AFPM Val Packett <val@packett.cool> wrot=
e:
>
>
> On 3/3/26 3:13 AM, Jingyuan Liang wrote:
> > Documentation describes the required and optional properties for
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > supports HID over SPI Protocol 1.0 specification.
> > [=E2=80=A6]
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - microsoft,g6-touch-digitizer
> > +          - const: hid-over-spi
> > +      - description: Just "hid-over-spi" alone is allowed, but not rec=
ommended.
> > [=E2=80=A6]
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - reset-gpios
>
> Why is reset required? Is it so implausible on some device implementing
> the spec there wouldn't be a reset gpio?
>
> > +  - vdd-supply
> Linux makes up a dummy regulator if DT doesn't provide one, so can
> regulators even be required?
> > [=E2=80=A6]
> > +        compatible =3D "hid-over-spi";
> Not following your own recommendation from above :)

Thanks! I will fix this in v2.

> > +        reg =3D <0x0>;
> > +        interrupts-extended =3D <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> > +        reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> > +        vdd-supply =3D <&pm8350c_l3>;
> > +        pinctrl-names =3D "default";
> > +        pinctrl-0 =3D <&ts_d6_reset_assert &ts_d6_int_bias>;
>
> Heh, "reset_assert" is a name implying it would actually set the value
> from the pinctrl properties, which is what had to be done before
> reset-gpios were supported. But now reset-gpios are supported.

Taken from the original patch. Will fix this in v2.

>
>
> Thanks,
> ~val
>
>
> P.S. happy to see work on this happen again!
>
