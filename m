Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7CD331A7B
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 05:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773035094; cv=none; b=QNA12u0SwMPRpafx8nZinImP2MRpIzR+arMalJ2NmFUkWqnPPHmkmzbk5U/wJE9XBdJfpX2ck0BFOoBSdcGYhlingqGjV9qmHy/mHNNB/krwGvF/z/GTYufAxg2oN8LybWqgJtHDsTp+ggytW01Jpl6TYysQJZhes1NCTf9GPMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773035094; c=relaxed/simple;
	bh=hqi/Df1JPDp/BlPm0GTdyjJF+qjIicQyIWh3azQlrf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLu6UsuddlqucznDvXNzGNzzuPORlG43iKi94EhkuHLDDB6nZOruN2YgSrOUGHd6U9mbtOIIC9pR7K4PRhhF5cD+FelpNWmg1963miXfVjq875Qn+sruffACdHdfjRc/4sBcjuBiKoaTOWYZJjRsjHIaol51TCqOQW2dvM2U+Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH9kTvFY; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH9kTvFY"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12776bebe9fso4362591c88.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 08 Mar 2026 22:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773035093; x=1773639893; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ug9w3Bfo3Ur8mbdFfczjnMxT2pbrXyiERJeMtAuIh8g=;
        b=PH9kTvFYazGcAHB330To/OeFzVVVoAetzeAqLqtqgO8FTevOSlJFg0vBVgSis1D2qx
         ei4tNvhFPmh9rlOXr2szTzSoqAD0b7HIcOIrEvL5+ngd6IVklpLZT6rHLnG7PimKZxJ9
         WNgr1m+pUKPVhXczgU5mbe5tNGgj5xXXBCyEvkqnAFWkvr0DnL5lcVxj8bcLuaBKAWQj
         nuRXFxAHJBYhnJ9oofghicqrvnLlnsy7xl+xR5W6CAGNw7Ab3S8+FdKBlMHTEgwLb98/
         MWsGRvDGo8vDBF/Va9cyyNDPmbCaaATQfCaHXHHlieVPDqYlbgqs+bSBorjqAbNtezJr
         wD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773035093; x=1773639893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug9w3Bfo3Ur8mbdFfczjnMxT2pbrXyiERJeMtAuIh8g=;
        b=bcyAxX8MdEiuk/+5jg3+9nBfVa6jkt+6QXsaw1ZVX2Iw8Qbe1urAB28TmTceCQ8uom
         Hz3Gn6XXKUWDh682FAkDWJ3LILOEmUO+IBUe++lnwepJ6QSJ63/Vb5VotCUd3sTGUkQ0
         838UJ7HoNgj2Hw5yCkhuPPWPFAq1JV4+Zr9pKzyjlXrJ8lZBMlZspq/pcObwKU25UtOx
         m2q42L+Y+u6yfgsY8BBa/SQOCPt7Pn5SNbNvVJXIQq87b89wp5cwd92x48vm4yrz2vpB
         HB38hfGg0EZ0LZ2sbthgSBvvDc+Vajof4uPDoXjMp3v8/47NpyXdxk/13VsGqyw1BORP
         xn1A==
X-Forwarded-Encrypted: i=1; AJvYcCVNFeM93K9ZqnrNbIpUUiHVzuHW4xQwz24LtH1p3LDzx8ubBlXCFtP56lVwvlCy+6/6UDPcC79ao/s9Ah9AY6NXszc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/5HZdbQI8nYg15n4kaQbcvLgZh/RlQhbVk8zOfiqjqVIJTzK0
	d2BePhYNsB1FRGEGNfQNdyTFOn4kgGUUMXGakbd7bi1NbceQi7mbzj3r
X-Gm-Gg: ATEYQzy6ZqOjvOD2w/Y9D5j9B1po9mlM4ehYrGoAbzbURQAKbUMaBFKa7FLU83Fc5mr
	uNA+kuEDXV+eNDuBJ9JrjuHxJS9/wY0t9mw5WlG09lam+wSaP8X+ZY8df6ek7lAeaRPCugQdvAS
	HcmF5wYKCEJl59q6Si78YzBkH4eOJGNS0C1HyL+YG16FTmgBta0SqetdumrXo18qrajMzsyHd4a
	SasWmuxMMlcyzdut/KaRWzDI2LpahScG7dbpzmbg6VHgGDYTfsarxpHMZiJyXO5PFeZwK4P7esy
	UzhPk4SLFQD9eXiCCtmE1YnLi5n9A656J7xKrHxgwIEis7id/sehOKAGDD+/QydV3i+UtyoD6q+
	s65eTde5Yzi/ERJg9mDLhyL+xEFwnWuj3KyP1YUIF/bTZV/Vi6/1E+z2S8m4sQ/zDeXlXed8cJ1
	T7RhhIv5Kn2Zhw4qrFQTnWx6t8yz+YD8Y=
X-Received: by 2002:a05:7022:906:b0:127:5cfd:785 with SMTP id a92af1059eb24-128c2d8f553mr4232707c88.4.1773035092704;
        Sun, 08 Mar 2026 22:44:52 -0700 (PDT)
Received: from google.com ([2601:647:5e00:4acd:af9:a43b:9d9e:841c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3f43593sm8122381c88.9.2026.03.08.22.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 22:44:52 -0700 (PDT)
Date: Mon, 9 Mar 2026 05:44:48 +0000
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Val Packett <val@packett.cool>
Cc: Jingyuan Liang <jingyliang@chromium.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, hbarnor@chromium.org, 
	Dmitry Antipov <dmanti@microsoft.com>, Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH 09/12] dt-bindings: input: Document hid-over-spi DT schema
Message-ID: <aa5cxFcZrI89g-8s@google.com>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
 <20260303-send-upstream-v1-9-1515ba218f3d@chromium.org>
 <1cc6de61-8b56-492e-ab78-e3aa448f58ad@packett.cool>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cc6de61-8b56-492e-ab78-e3aa448f58ad@packett.cool>

On Sat, Mar 07, 2026 at 04:25:44AM -0300, Val Packett wrote:
> 
> On 3/3/26 3:13 AM, Jingyuan Liang wrote:
> > Documentation describes the required and optional properties for
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > supports HID over SPI Protocol 1.0 specification.
> > […]
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - microsoft,g6-touch-digitizer
> > +          - const: hid-over-spi
> > +      - description: Just "hid-over-spi" alone is allowed, but not recommended.
> > […]
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - reset-gpios
> 
> Why is reset required? Is it so implausible on some device implementing the
> spec there wouldn't be a reset gpio?

No, because it is mandated by the spec:

"HID SPI peripheral must provide a dedicated reset line, driven by the
HOST, which, when toggled (pulled LOW for at least 10ms, normally HIGH),
will have the effect of resetting the device. If a HID SPI peripheral is
enumerated via ACPI, the device ASL configuration must expose an ACPI
FLDR (_RST) method to control this line."

The spec also states that the host must initiate reset during
initialization of the device.

> 
> > +  - vdd-supply
> Linux makes up a dummy regulator if DT doesn't provide one, so can
> regulators even be required?

There is still a supply line to the chip even if it is not exposed to
the OS control. So as far as chip is concerned the supply is required.

Thanks.

-- 
Dmitry
