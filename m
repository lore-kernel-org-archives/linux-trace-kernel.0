Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795204969;
	b=tbh0HWXpkF8Mvd3ODXC96ZZGYhMg+b5v+UrJjWQxc4jI7UZJ2Lw/5OfOZrtSSctG9iYV
	 KpK/1AZ/3FyXVQ7F2BLp0YRtJURU7b/R9NhHPlnmT23D9XjravSOc7TvIIr+nfuU817cr
	 d/A8/Yyqe+3ZWT5txr0C+2vQ+4ao0c1wcZ6cx1GiFG3zLKNf06uH03imDVku1nNH1k3qg
	 2v8YaosUupKgxzI1aqWz+F6sBVJuPZ144/DErteXFLztWGLjqXApL4hpcQY8p4loXbzEL
	 Sy/IMctMVtCyCzvnKOjgQYH1DGyncB2Hx+8E+96xmHEl6TVTbt7YmTI9LKCn5Uxum2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4V7U58O8sKkT2FqZynxSVbl9uHZQNKqD+q26N4wEsfM=;
	b=tuc+6E0hszARVadnHAvA9oFKUEIKE3lCut6iVqrWrYszEtcSd1kkU3PK7mi1wbdDWeyf
	 379aG/hIDf2V0iW+ktZdJUmb04ZyLU6zDhyIKs9mxtyEQ9Qq/A/rA8N8RTr/YF6QlvwTC
	 nMP5/s4SksRcW3jDh7JSsG1AxGgXkVz/S7hCsFpSMqfMmZOgY00GS76ClrljUCcZl7Unc
	 BgRCoLEecym+hBF8pXphKKqW7nOEtRnboaY/E19RVwWFtAdWHNToWKVhnKCwQL/q/4WMj
	 I6H6WCqUa+lOsTLD9DFp5MBvxtk0e4X71gwYMgNSvTyQHUi6/rIqnesANXlmhnsLjBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WaMYcHhB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2B60A2614
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 20:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40A2B60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WaMYcHhB
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67dae7d3f7dso1772863d50.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 12:02:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795204964; cv=none;
        d=google.com; s=arc-20260327;
        b=FIe9H8wl67dAa1wjAxA1TxSqNpNYunNsV13DcdxAiF6HSanfwrLD/N7WTY2hSTEda9
         2AgZw14Ui8Luv5HcJg79Q1f0bFoOGTddyq6wcl6oyG5hJ4sJu5LBuQc4sMRKj2dh4Uyo
         p1egGvCElaU4l9OaIrLOA2ugYCm47X+/gVHkZKSBZ5ItuhlNpFNe+ORS+NK8SC4Vs8Bv
         ebjOAfHLZrM6S8pi6RcHfGlElsuFQw1urjm+uCPJxJiGinNEkFLMpoXieD4pU0GfkPjF
         xU7LkiGO3iH6pOTbJweKZtGhYAb/6Oq8c07rZgbqu+iiPKVgfaxWDpWxtVutbSrN8u9n
         s2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4V7U58O8sKkT2FqZynxSVbl9uHZQNKqD+q26N4wEsfM=;
        fh=VyfxG737j5DvgVSgSr9ih5xFlX4Gi7KGcwQTkPhzg/c=;
        b=A6P5vRg9IG+bB1jwFMJ4oHmg60RVHTju+3Ui/MWPR7Hn5w80Ro8AmsOfTgfQkJgkkF
         EAY/6kT/CMO2Gf25PLqgPQso2w0A2A47Yhstf6q3ih/Wa7NjorMAMUYgV2D46YTvrRtP
         AUXNSU+Ex4tI86IyRMOkp3W29+DNX4H4gyXVJbpg7WegKpb0elWmHPJS1DCnsQagd92z
         hAHpWkYg638qKfPB/7Oh2q27Fubm46SWxKckUMAivuk4kYl0Q5gTpg1No7HnzEfeAdDk
         2HDvJih9nygNDNdkbzjnB+LKLvgE+LP90CoWtqdq7rHseFpo4Gf3cDhqa4SwGbELh8JE
         YJPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795204964; x=1795809764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4V7U58O8sKkT2FqZynxSVbl9uHZQNKqD+q26N4wEsfM=;
        b=WaMYcHhBNZ+35v+6wpg2naLtL6eDcZGWsH/op1cQD4c03wrQ8D9MdgfrpovhVdIVdA
         2vQEBszX+L485tw/WsOjNI6nY9CG5gIGG0K7OjZRK2gMC/7bEIPYyrqsu7ZYpm9MYQC0
         3I6OnJRjbJW1M/wIfBUqPj0fZpDXE7cn+bncY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795204964; x=1795809764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4V7U58O8sKkT2FqZynxSVbl9uHZQNKqD+q26N4wEsfM=;
        b=0qbzwzu5IlFqab5WvXI9ZTwEg9ar/wZSYl4NlriMoxCfJ1K2XQYjvuj1lGZQux1BC9
         zpJPw7VmnVzqiPrtlEJlbB5Dc7x+L8vUhR+0V2F/YdMBCWa732QpJGm2rLLbw8oSt6fl
         Hc/ElzhIIbd8YU20HWRuEew9c9waPToDfub84EmoCmac7Wu4RzFxYB4Y3b+Bc+rLtUSO
         fxVgfP6RfsDVqAMQWawCjzNINH20pNKIp46uaF0ySxeonK8Ll80YjwNADiuLtgjCF+mk
         cANd5qkAGuB5w60NhJIR1NwNNXbHDQrsEIzwY/3r4lkAAINvMJKH8Y87ESJUOhwtnOTo
         thuQ==
X-Forwarded-Encrypted: i=1; AL+hErGE2OsRV/KQtpGPOPKQexmefp+YNq7MT3roosd6DB+Lif4S9AtXIS4n+ga4KauReF54oF5JjtpkNAcIh58Y9qgwBGY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Biix++b/B5pMdN1OCJ5+F2pToVczU2t9W1ZVP2bF1eQjPBFe1
	NRNOdzeEPQAglHWLWBxNRKZFxEwF7spFkECDv23n0x5f/qmqNiUvo5wR6XpMef5qfS4PhU3nAE8
	YafM3b9Dw1QZQntNZXJWxMnqT16kTKPAhQmXSEhI5
X-Gm-Gg: AZFdTZc/ZKu9/3ens6nifS4iy1OJ72Uqt3Nk/gfQWNzuSFgERVhmllP9Cfv4jKb5R+V
	phPB+ZX9sLatQ6jVMP3gX8cw7lrOFZ+IQgThjuF4qlEhj+7niWLc5TGb0eMNDPKGMbKQ+0F7tUb
	Tt1/aeCZUtLdufrWeA3BTF0tPKM97cum86+q/i9293Kh4ATfZ5im6tpBCS01s27PYgDe1+Fgf3j
	ZSjLuxYAgSYgO2MD9g2Mm1I49CNgKrePGn0mBm7eKygbI9aBvc0loHrS2rpi6mR37xg1kGaN/86
	dgwqU6eWWcM0hlrRLSTF3ibCv89Y6UijtK0rY7QzIcwFV+lVnnIuoAVyplWzPj+4rqhZKYGyhgC
	gwZDZC24fVIjZkQy6R+6AAhKsdt9Cy+ccgcnKBJDYOlpoJ8jz72hml/pP+o/4bt43uEz2
X-Received: by 2002:a05:690e:4008:b0:67d:e36c:6bc8 with SMTP id
 956f58d0204a3-67df44c1825mr1431647d50.146.1795204963908; Fri, 20 Nov 2026
 12:02:43 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
 <20261024-send-upstream-v7-8-abad13174b43@chromium.org> <20261027-silicon-unvented-a0c8dc394e87@spud>
In-Reply-To: <20261027-silicon-unvented-a0c8dc394e87@spud>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 20 Nov 2026 12:02:32 -0800
X-Gm-Features: Aa3M54pc-1DTIKZ-A-hc9wj9AlprRrg4PvxeOwd0_HsaV1fm3yOGyT9vmhS6ZyM
Message-ID: <CAEe3GZF+P2hHHAQO_eWq=yv83HYw9ebEdkO_RZ4zPkQ6e_bAeQ@mail.gmail.com>
Subject: Re: [PATCH v7 08/11] dt-bindings: input: Document hid-over-spi DT schema
To: Conor Dooley <conor@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, tfiga@chromium.org, 
	fqwqf@fqwqf.xyz, daleyo@gmail.com, Dmitry Antipov <dmanti@microsoft.com>, 
	Jarrett Schultz <jaschultz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:17=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Sat, Oct 24, 2026 at 12:51:42AM +0000, Jingyuan Liang wrote:
> > From: Dmitry Antipov <dmanti@microsoft.com>
> >
> > Documentation describes the required and optional properties for
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > supports HID over SPI Protocol 1.0 specification.
> >
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
>
> Personally I prefer how this is done now, but definitely worth those who
> approved the previous iteration taking a look at this because it has
> changed significantly and no longer contains any of the properties that
> cover the timings etc anymore.
>
> Worth noting that this changed since the previous version after I
> pointed out that the second hid-over-spi device did not make use of them
> at all and needed specific handling in the driver.
>
> > ---
> >  .../devicetree/bindings/input/hid-over-spi.yaml    | 75 ++++++++++++++=
++++++++
> >  1 file changed, 75 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml =
b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
>
> Typically this would need to match a compatible, but I think this is okay
> provided other hid-over-spi devices actually get added here - the series
> adding the second hid-over-spi device didn't do so but should be able to
> I think?
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Thanks,
> Conor.
>

Hi Conor,

Thanks for the review and suggestion. The intent is for this to be the
common binding for HID over SPI devices, and I hope more devices
get added here over time.

Thanks,
Jingyuan

> > new file mode 100644
> > index 000000000000..bed0746f004c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: HID over SPI Devices
> > +
> > +maintainers:
> > +  - Benjamin Tissoires <bentiss@kernel.org>
> > +  - Jiri Kosina <jikos@kernel.org>
> > +  - Jingyuan Liang <jingyliang@chromium.org>
> > +
> > +description: |+
> > +  HID over SPI provides support for various Human Interface Devices ov=
er the
> > +  SPI bus. These devices can be for example touchpads, keyboards, touc=
h screens
> > +  or sensors.
> > +
> > +  The specification has been written by Microsoft and is currently ava=
ilable
> > +  here: https://www.microsoft.com/en-us/download/details.aspx?id=3D103=
325
> > +
> > +allOf:
> > +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - microsoft,g6-touch-digitizer
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO specifier for the device's reset line. The HID over SPI
> > +      specification requires a dedicated, host-driven, active-low rese=
t
> > +      line. The line must be flagged with GPIO_ACTIVE_LOW.
> > +
> > +  vdd-supply:
> > +    description:
> > +      Regulator for the VDD supply voltage.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - reset-gpios
> > +  - vdd-supply
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    spi {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      hid@0 {
> > +        compatible =3D "microsoft,g6-touch-digitizer";
> > +        reg =3D <0x0>;
> > +        interrupts-extended =3D <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> > +        reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> > +        vdd-supply =3D <&pm8350c_l3>;
> > +        pinctrl-names =3D "default";
> > +        pinctrl-0 =3D <&ts_d6_int_bias>;
> > +      };
> > +    };
> >
> > --
> > 2.56.0.257.gf7497c7d27-goog
> >
