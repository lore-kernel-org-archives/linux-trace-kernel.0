Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8AF3E2751
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Apr 2026 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755015; cv=none; b=UkWgjrSIsVZAUqOaitOocRQPaIrM/+gO7nohvN73fAwYwbOhnNx/Kf+kVShiMSVU0pBcB2ckL1GGl7MbCVV0EBxz5aCC6R/bc0dp2PAkmzKq3OXHNL8hQnBpUsPybyy7QCLgdqh9xVJJory3BpSC2l7x9OfEWB+m95Iqdywqe5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755015; c=relaxed/simple;
	bh=S60+iELf201hWfWsA0+5HzASsARSxTciNv62Lq5+S90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q86OSEAiKtqKREpGrO6l17VfrsNwXDe+qttHV701JPCJc19irOk4t1cCjzjy6vF8QZYBvKCOZwO/kb4vzH7bgmSUeuvqb0dJiX3q91C9xBAp1HMXt4CjadO3YXmuEXZvHUSZzMs+ZQUtW7HrQAD2v8N+6RIyRuzVT5Cdt3aOzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ix9GuZZA; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix9GuZZA"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2cfd69b564dso1554068eec.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Apr 2026 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775755011; x=1776359811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OiUmxJypMk7dUgMF/8X+eU6lB0Kg/0QHff8vgI/w/kA=;
        b=Ix9GuZZA7oD3oe45n0dpQmNG+x2p3bO3hgebWxOV2WoySs6B/HLyE6lPOdXKM1guQQ
         /O31QDbYhoG+obtxcw03evTeIhKf2vU5JrIIsH3ylr6+RunTX9vpy5NCRAbgZwSIpp/S
         7jftrBtpowJOe9riVQ60YmAm4o8MBNkll0nXQSaDvYZ9Dks9RVCswpJNh69uNQWg5q37
         zfMGmpM1OMsSrCn2tU+iFMQ9X5gjw3DBc0MLFOzmkCCaLM4qbjjVHhdfAphEfet8yso9
         yrjwYi+No1UGdcvaX5/yv2aYpsEGlQVhs20REHeZWDCVsnDWKMBRiuPw86e02y/L0Cps
         WQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775755011; x=1776359811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiUmxJypMk7dUgMF/8X+eU6lB0Kg/0QHff8vgI/w/kA=;
        b=WL4cYSFAbURyxQQhO56bfvtmvwWCdZ3fyBQ6keQIwQDNyO4fkq8rfOK/zin2PNoAXg
         fixWXQz8Da03F5sP+eIYfiF6l4iXwKhFW7oHwe9QrTqGzXYtVMWe+vY1A8emApUYH64b
         x24kXiMw35oQtjfMbDQbWj33j32eY0GhNlQn9X8l5quOvChK6wdOOnFFlUIPDmYf8MqC
         5/p01TOGe0fy5IvciPoimH2rWxGEuusMBJTFBmD/CeD7krkCOVLv8Ew6CComJ5bi96R3
         70rwYqKWbNGDmHsD6seNrEdS4sea/P/U3k3WItW9ZgjvStZjEDbpEB22iG6P8Ub1PSDP
         fbZA==
X-Forwarded-Encrypted: i=1; AJvYcCVrSnM1qMKKLZcbqwYeLNTYyZj4or6+COmZJ32j5NTWPa03rorqb+z/CQvQ+SAsGEkuxPBPfSUHSBMgWb2GBwny+qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXDQG8o9WdQ7in0jcCk4fkM/2NelYsmhUKsKv3aKNWyPB4unGd
	esg4dWcKKxLMRHiPUvsIvi9UeRAFLbN7NB8xReXkONp2BTvssUZQLBa7
X-Gm-Gg: AeBDiet1KPCRMBLdnUH777HMItawlGrpZM/GvUt47qyOGC4Sz2L9SGcuuhWVfoS0MMm
	oL1QFzrs0vSdC9GIa0DHKzGoGzx03rYjF4b59lubjcp0XOvOuqGEiMs23XT50Xlyu69f9Sg3fNe
	RTwG+1jB2JJxeAK9BSJcvrTWMh1xk5igUmsT6tsdGb6IVvgRe0ig93XNax/bgq0b4YSsMfGKziC
	vlF0tObOgl1f5MjpcLlto1w6MDFZgxQKgbc558uavmYP4sCnORpO6aCSZoK528WoXUWwn7ljwH6
	rpD8R4VADgW2aBnfdUaNpKcpfEHaI+rC2BZVAmoYQeZg9nB4Pv1nxDOx2F+LAnTXXkrhmtQs/3U
	dd1e24vSuMjmRn+FkNZh7sn2ZWUQKSbsLQ2J91In8tZLd1kBBGq8EnoIC66lXBT5qyqyDhivPm2
	AvLrl8t39bVrjomdnBIvSVunkeJmYy8fciDTG5SB8Qb043RDoZDU85skR+BX4hjUMG
X-Received: by 2002:a05:693c:2b17:b0:2c3:5dc0:a06b with SMTP id 5a478bee46e88-2d40defc97fmr3118618eec.20.1775755011019;
        Thu, 09 Apr 2026 10:16:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:12ff:7738:6560:2618])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55ff826dcsm484882eec.13.2026.04.09.10.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 10:16:50 -0700 (PDT)
Date: Thu, 9 Apr 2026 10:16:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jingyuan Liang <jingyliang@chromium.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, hbarnor@chromium.org, 
	tfiga@chromium.org, Dmitry Antipov <dmanti@microsoft.com>, 
	Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH v3 09/11] dt-bindings: input: Document hid-over-spi DT
 schema
Message-ID: <adfdkwq_bF9dirAq@google.com>
References: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
 <20260402-send-upstream-v3-9-6091c458d357@chromium.org>
 <20260409-defuse-thank-4b038128fac5@spud>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-defuse-thank-4b038128fac5@spud>

On Thu, Apr 09, 2026 at 05:02:11PM +0100, Conor Dooley wrote:
> On Thu, Apr 02, 2026 at 01:59:46AM +0000, Jingyuan Liang wrote:
> > Documentation describes the required and optional properties for
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > supports HID over SPI Protocol 1.0 specification.
> > 
> > The properties are common to HID over SPI.
> > 
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> > ---
> >  .../devicetree/bindings/input/hid-over-spi.yaml    | 126 +++++++++++++++++++++
> >  1 file changed, 126 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > new file mode 100644
> > index 000000000000..d1b0a2e26c32
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> > @@ -0,0 +1,126 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: HID over SPI Devices
> > +
> > +maintainers:
> > +  - Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > +  - Jiri Kosina <jkosina@suse.cz>
> 
> Why them and not you, the developers of the series?
> 
> > +
> > +description: |+
> > +  HID over SPI provides support for various Human Interface Devices over the
> > +  SPI bus. These devices can be for example touchpads, keyboards, touch screens
> > +  or sensors.
> > +
> > +  The specification has been written by Microsoft and is currently available
> > +  here: https://www.microsoft.com/en-us/download/details.aspx?id=103325
> > +
> > +  If this binding is used, the kernel module spi-hid will handle the
> > +  communication with the device and the generic hid core layer will handle the
> > +  protocol.
> 
> This is not relevant to the binding, please remove it.
> 
> > +
> > +allOf:
> > +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - microsoft,g6-touch-digitizer
> > +          - const: hid-over-spi
> > +      - description: Just "hid-over-spi" alone is allowed, but not recommended.
> > +        const: hid-over-spi
> 
> Why is it allowed but not recommended? Seems to me like we should
> require device-specific compatibles.

Why would we want to change the driver code to add a new compatible each
time a vendor decides to create a chip that is fully hid-spi-protocol
compliant? Or is the plan to still allow "hid-over-spi" fallback but
require device-specific compatible that will be ignored unless there is
device-specific quirk needed?

> 
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
> > +      GPIO specifier for the digitizer's reset pin (active low). The line must
> > +      be flagged with GPIO_ACTIVE_LOW.
> > +
> > +  vdd-supply:
> > +    description:
> > +      Regulator for the VDD supply voltage.
> > +
> > +  input-report-header-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 0xffffff
> > +    description:
> > +      A value to be included in the Read Approval packet, listing an address of
> > +      the input report header to be put on the SPI bus. This address has 24
> > +      bits.
> > +
> > +  input-report-body-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 0xffffff
> > +    description:
> > +      A value to be included in the Read Approval packet, listing an address of
> > +      the input report body to be put on the SPI bus. This address has 24 bits.
> > +
> > +  output-report-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 0xffffff
> > +    description:
> > +      A value to be included in the Output Report sent by the host, listing an
> > +      address where the output report on the SPI bus is to be written to. This
> > +      address has 24 bits.
> > +
> > +  read-opcode:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    description:
> > +      Value to be used in Read Approval packets. 1 byte.
> > +
> > +  write-opcode:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    description:
> > +      Value to be used in Write Approval packets. 1 byte.
> 
> Why can none of these things be determined from the device's compatible?
> On the surface, they like the kinds of things that could/should be.

Why would we want to keep tables of these values in the kernel and again
have to update the driver for each new chip? It also probably
firmware-dependent.

Thanks.

-- 
Dmitry
