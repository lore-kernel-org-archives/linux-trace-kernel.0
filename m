Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AC737CD37
	for <linux-trace-kernel@vger.kernel.org>; Sat, 19 Sep 2026 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789843372; cv=none; b=VznN7/I6ilu0gZ2NLJrw62l/c3+3/RMK5qxyL5pKcoyCNVsefBJU/+Rp65tB+FXVYM0ALf3YmmhkhjSUFK47hjYCh6lyrZnfvo9Q/psnSeE5O2wc0QQpKP+p1GuSI0DgkNdaqDpb3/zGw3D/RjpF4uy2/yR4hXMvkr6r0TWVnNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789843372; c=relaxed/simple;
	bh=L0cJg8bEa3JcDAFMwgJ+PXyC/ThA9AhiO5G7soyuk4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfUSh1eXYOWAcLfBHY3ERGXWzAuhJG2ZxIaiHpLgAqzxl7VUkxt6XWqrN1BuHKjHA26My9jBWQpSsLKqhBeK/UsGxc13Z/qBHBOfJBsH5uxATJvOpsxCMiy4IO4k+li+1mIyFrZVLqgM37LZP3WWPLMiuyHoZp0RksSOoSpJicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+rhnWa9; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+rhnWa9"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e620fa473so10340925e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 19 Sep 2026 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789843368; x=1790448168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EUaG58XyyXj2IYGxruqsBjrWu0FDpmLYKW3X9EM+9DM=;
        b=L+rhnWa9nQG2h6Uso3aXhrUb1+pFdsXRFDMx5XcAo69q9fXnDxwpUAnp67jjx05WOh
         UlHlMf0RCkzMdqFJJyX15kVA7PDcV2cDKzmhkkO3id15YNJF8a3BVbLTlGsK/XPtQM29
         065odsPEekw6UhF8ik+AQ9gQfRZ/kObO4TrxSbY5+hcsn2cCh3iA11HoNAznCt3ea5HY
         Fv82E4PjgXTB/1vEy1hauB5j7z+9KyIHJvrA0aEP3zEcl69oTsyDYBZWrNnz+Ggvb/th
         SYtRL3+ZnGtvfXPzXi81+71BDGhMs0KnxACyG2QGoegKiUDa6P+tUSBBVGabEodUxRWn
         D/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789843368; x=1790448168;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EUaG58XyyXj2IYGxruqsBjrWu0FDpmLYKW3X9EM+9DM=;
        b=w0yQAtq08xhfs0ARF6wBqyfS8eLYRUwLVU1UAD4gzNN8lq5faqWITtcc3N6vwO7/KD
         0OPNOUligYijfWEG+OaQnyzqZoaxwzCPBIC/YCybByADvBsqFO6PCjDVyamr3qp47amn
         X9s/ZKV6LIc7Jxm4PJM7zv5kZujs/UtOONZ/kE5Lx4muguHB9lJoMgVZXYpzOeOAlxCl
         pqevyHxV4qKuo/yDnyB31SDybFLqaetYERZ2eGEyY+USZpO19XMgdrqo1Hbw6jLMaabe
         PEj5aAovkxC0UbXrq0eRGO/AuJFCUK8ntphparWRKk/qviuOKy3++8TJ45UAAZYZuB3e
         S2Yw==
X-Forwarded-Encrypted: i=1; AKwUvBzSHoiXinDzebu/xj0rYotcXOwKv2RMh8FwPoCL56WWU//kH22xVsmcHZfiuoeVV47DJkFunlaHbqhWdlq2qW9izVY=@vger.kernel.org
X-Gm-Message-State: AFuF++mun2QXfWm/o8ovYUy0v9Ew5xjXVTP2484beQyo4X48sBsU4kfn
	F3iMffCQnQ+ZEMS56GzZAPD4ohukmLgb+V12Js5VA1jRdOdA7/C+s8wI
X-Gm-Gg: AYBFou1XBk2u2cFboTQzqdsAsmt+SMyj04Ys7fmEVWHj99jTsoEdFVljxNaHasLyfdY
	NXFp8aoHNA9bVSEtksDHDOxrXeWD4i/xPP+X+eG1svoyM1X7+HiC5maym/W/6qMkIQ9WF0zWI9Q
	88opde8EW/eBuGhnl5yG2LCr4M0H5+24/FSOCfVVQiG3Bg7WevPLulegfKhqPgLVLrxGmsYtkjS
	ccsb7FTBWFyVK/d+wrJlhOgYs+nQ0pxt+JUB9oOMrIl/cHvs2l92pzOl8xPc8pEjAQGGAvR2467
	b/BIwmsTP2X1TfFt5MZjlULf4rsNAl+7eZ8n+RqWyqU3PUCgugdhiXx+HTj3HPnwk4hQIGvPkiv
	FX17qc+hykGczknSy1+5FKSICS8zhxCC4NbW9PZ70VdJ/3T3z345MyUS4ChOsKum9IQqfWfTdm0
	P5T4wSV1TNYcD6khLyjHVF1yqkaHFFdlwRVb4yScuohv1o9l26sf2eM7pW71IC4SllGqJ3FqZCB
	ksaRUvrEMrGPXPNeO/Mw+XrkrHa
X-Received: by 2002:a05:600c:4505:b0:49a:a101:4157 with SMTP id 5b1f17b1804b1-49fc56db92fmr86686385e9.7.1789843367901;
        Sat, 19 Sep 2026 11:42:47 -0700 (PDT)
Received: from [192.168.1.13] ([185.69.144.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd07cca6sm91087395e9.11.2026.09.19.11.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 11:42:47 -0700 (PDT)
Message-ID: <8427de42-2cdf-4acb-a439-d7c99cd249ca@gmail.com>
Date: Sat, 19 Sep 2026 19:42:43 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] Add spi-hid transport driver
To: fQwQf <fqwqf@fqwqf.xyz>, jingyliang@chromium.org, jikos@kernel.org,
 bentiss@kernel.org, corbet@lwn.net, broonie@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 hbarnor@chromium.org, tfiga@chromium.org, jaschultz@microsoft.com,
 dmanti@microsoft.com, acz@semihalf.com
References: <20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org>
 <010601a0b3ff1cf6-944e2ad5-0ad1-49d4-9e89-c8ab03bbc62c-000000@ap-northeast-1.amazonses.com>
Content-Language: en-US
From: Dale Whinham <daleyo@gmail.com>
In-Reply-To: <010601a0b3ff1cf6-944e2ad5-0ad1-49d4-9e89-c8ab03bbc62c-000000@ap-northeast-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/09/2026 11:10, fQwQf wrote:
> Hi Jingyuan,
> 
> 
>> This series picks up the spi-hid driver work originally started by
>> Microsoft. The patch breakdown has been modified and the implementation
>> has been refactored to address upstream feedback and testing issues. We
>> are submitting this as a new series while keeping the original sign-off
>> chain to reflect the history.
> 
> 
> I am working on Linux support for the Surface Laptop 7 (13.8-inch, Snapdragon X series), whose touchpad is a HID-over-SPI device behind a Qualcomm GENI QSPI controller. I noticed that v4 (June 9) is the
> latest revision of this series and has so far only seen automated review feedback, so I would like to coordinate before preparing any upstream submission of my own.
> 
> Current state on my side:
> 
> - I have a working touchpad using a downstream Qualcomm GENI QSPI +  spi-hid stack (originally from scuggo's x1e-nixos work, imported  via ELLX-Kernel). My local adaptations move the transport to spi-mem and add framing, response matching, and DMA/error-path  hardening.
> - Normal touchpad use works on my machine. The latest hardening currently has only build and software-test coverage; I have not validated s.
> 2. The SL7 adds a different transport requirement (quad-SPI via GENI, through spi-mem) on topuspend/resume, and I have not yet run your v4 series on this hardware.
> 
> I believe our work may complement each other in two ways:
> 
> 1. The automated review of the series raised DMA cacheline-alignment concerns for SPI transfer buffers and unchecked reset return values in the init/resume paths. Both overlap with the hardening I have been doing downstream, and I would be glad to contribute fixes there.
> 2. The SL7 adds a different transport requirement (quad-SPI via GENI, through spi-mem) on top of the same HID-over-SPI protocol, which looks like a natural fit for your generic driver rather than a standalone one.
> 
> Questions:
> 
> - What tree or series do you recommend working against? Is v4 still your current baseline, or do you have a newer development branch?
> - Would adding the SL7 quad-SPI transport requirements to your generic driver be the preferred upstream approach? Is anyone already working on this?
> - Are you waiting on maintainer review before a v5? A second hardware platform may help move things along, and I am happy to provide testing on SL7.
> 
> I am also tracing the downstream provenance of the Qualcomm QSPI code with the original authors to ensure a clean sign-off chain; I appreciate that this series handles its own history the same way.
> 
> Happy to share technical details or a preliminary diff if useful.
> 
> I'm not subscribed to the lists; please keep me in CC.
> 
> Best regards,
> Jizhou Tong

Hi Jizhou, Jingyuan,

I am working on Surface Pro 11 aka. Denali, Snapdragon X1E80100.

This series (v4) has enabled successful bringup of touchscreen and pen 
on the SP11, which also uses QSPI via GENI.

There is some updated SL7 QSPI 'glue' code at 
https://github.com/orvitpng/nix1e that reworked the original scuggo nix 
flake code to work on top of Jingyuan's updated spi-hid series.

With that + some extra pieces to wire it into the Denali devicetree, 
this series is working well here.

I'm keen to help move things along as the tablet functionality is a key 
feature of the Surface Pro - please feel free to CC me on further 
discussions.

Tested-by: Dale Whinham <daleyo@gmail.com>
