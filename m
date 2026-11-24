Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795536612;
	b=RkV7IdRE18TOFiTHStzHL+3tPMWfJE2eB0ni0ZPL8aWYh5scZD7LqJHvqGOkkiJ0aSB5
	 +CHAxgOPb8HtlR5uIqq/hXBF2Q+ZyMF/vsCswkgd6pK4Ot3Jeupd6gbJc9YhvfmCI9e4s
	 le8/wQQfHUgmYqWyRXxutOsGolSbA70GulPA6Onnal/z+Z0O1AEt2lqQbcgNfZWkJNWsU
	 YsmNpNtE7Of34ylhpMOEuQbLram6vZXKAU0aqGnl8n82IU4rIRV4YSTqotQ8LyyzYsDDI
	 0h/pnoB/+CLajfreM57pmk3B0lCD2jMknAXDkaiCmDQjc0D/B2i7BwPYZbZeHZ2pCFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=pECHgTEWdmkP4oll75I2OEsbM2jKiS8QbJcrj5sLeos=;
	b=hRm329zfBIDodvQfM705tRuf4HCVtwbypxIL/FyMbMZP+Q0ZySpV1LRDYox+wK/eVh4P
	 0lrcwM5++KKmGaZKr7MY9V5GCvBHT9LR93vjF+TyLMpQQ+GbXly358lFcPxA4xr/iC1t6
	 TqpaOUHWYWYw7Xy4ya3aGhu2g8RT7AETW4xd6bs4sgMjrmgYBR2WtJihItcc/Pe8JYll7
	 fAFpwkvqaZTkXhAgtMojj0ymez28/PjEkbeY6j9yqAixKxnmr4o+41Tmj0rBQsT0D+91x
	 xhmvY+vWflKQdsYKfa9jiow59vItPM6oOMvUQCbo5aOXFDDgFYNm8onGXoJaZTvLNmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=S1yI3LI9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CFE606A323
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 16:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16CFE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=S1yI3LI9
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ea19c28a50so1917345ad.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 08:10:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795536611; cv=none;
        d=google.com; s=arc-20260327;
        b=eiY9NZ74MPaXG+B04SYgkZchTksuz77iywLBtoUeHL5Z0R85ri70Nbf9Lh/p8Xl9hz
         pRb6OrrAy2xcSpQ67kSLjrhTLtN0EUyO9fSMyCL2mZ184qafeXUX06M3uxkkcr7xXh0A
         vjKX5r+Zsudt38nzkM+QdMs+zdmoLonhfPSVZwZbyf1gW9Iy/0TrDpQg9VLtRR+gherG
         HonUnx4AvQb0RVZo9yiiP8Ef255ouxA7MbMnUHpN1u8r/3Sz5v9fhSxVxf/pJxzTLxY7
         UQ/TmSn4gnUEvJWrWoIgwKcYGeyAxiaRrs/abN2KOeK7SjX8VvxB0wF0CZRujNPhT4ys
         Ik9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pECHgTEWdmkP4oll75I2OEsbM2jKiS8QbJcrj5sLeos=;
        fh=hXjC0XfW78LUfFxAC2Swws6rKIGw4kFl57oVvtTdpw0=;
        b=mlPbvhwnas/KRl1LNtwKL/bIFi1TH42MxqXE2JPX+d/GebWpPUUo7OxC4dcJ2ci30M
         A84mYPEvXMAEkb3uSOWY6REik5FwA+Uons4ybW0vqzVNIpx/RXp55HOs2/EWkWGMV3Iy
         cuI5UCDM2VXjF4X3mMbFi9ef4s/XSXF5/1jRaAcK7Lr8G5verpg9U8vMW99SuCdh87xk
         L/lRIqmIExiBkKuZWntQCU8MTV6ZLHcUhd85E3X2iqTyqt/tYkpZg4DkvJJq9yb/iWhN
         5SFJ/6cPAk6XSJRYUt/AGyozrrfOCn/FCh8qA2kE5Dvy0jMgl502SEXVqEh3cdTtYuB/
         dv7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795536611; x=1796141411; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pECHgTEWdmkP4oll75I2OEsbM2jKiS8QbJcrj5sLeos=;
        b=S1yI3LI9vJyy+J/lqhmAi/pLCfOkD65WagY1iQb4FqSa9/NQOUQhUC3zXRx2dS0G0a
         j4D6YPfXYa8sQH14m9VdQn+hM9sNDg/nLHQkAwrc6figbutf1C9kToy4FvmxIIZD0zsr
         cm8CZZc7881CCSw+A8DXVSiRKbxJkMPmRa6NRYx6yOLUo1EhsfLvN8qQcBPlIbNFo5Z8
         z4U2YckqEaEffaLTBHFBmQmGuzMbVz/wm+gXCWS4vu5immdXYfMFMiMMqZ+62+upsskT
         Efum+Cj2AWlAyCBJEJZHE2JzKpCBngcJzUFQXSAOKfj854Ev5KdeSdNFCk0bEQPqpgc5
         lu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795536611; x=1796141411;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pECHgTEWdmkP4oll75I2OEsbM2jKiS8QbJcrj5sLeos=;
        b=Bms6GL3D9eaRiP6kDYMdZWqC2lo6F8sfKT8gZNElkiLIdIEwrs31QPG5M4XfsrypZv
         tncL2WnkIPl0AckG5IO2F/hoTSebRa1Xw9kyltkv2d77sCo0UFW9SCxOaqG+ePQfFAcW
         Q1cyQozaocNnnbV5V4UiuH9VATYxVHQHfrjvej8UJGCw4D1Zel14/dsbHiqyxLYx8yN1
         5Hu0GzINNOwYAKIT2wCeHr/haKVqpTrCENUf0Ig4A6heem7XCYrnMjuJWQVeYGo2P4KS
         k4wAYKO/xQS2U5nTyke8E3Hn51QY/OKxkYzVU/WICuSXwge0Yr3NCc1bA5jboxIPv9oy
         ViWA==
X-Forwarded-Encrypted: i=1; AL+hErHB4Pj1ZYl/ZRm6lASM3fF1PJImYjmNR00yyxW5rNrIqrVppZX78uyMtqP2LWtHEa+evh7aqhrddI0hi5V5v70x324=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WnbwYNLk6JvvI7bHyT8sY000kUaksIJjOEQzYNxWdbSONLLrT
	aJgzo1gwvZTNlHaqdHzx2WHirSZaVd0i8/37C/Bs2yq0mQTcCQH3/FgQGyLiNQ7f6AdzjUx5ZhA
	X7iCVvDIWHWMcPGj/NFS51W25RlLOeJ/urHhTzWglmA==
X-Gm-Gg: AZFdTZc6z+o1jzhX+G5Zj0t74lTiEab+FdYj95pxgaYgS56fel8eLnsFsr47RCMi7BA
	80IKsweKylRXMHqBBQlLltOzq44xTRx3Ih5DOwYssr5LACWyCLJgXYk8JC50h+sB5Odt6bKBrgD
	WHUbpHoPw/pa6zuF2TcjcdN1HZPNSSUO/R6bU02d/Jao9T+TYFVo8Rh7yQNjtDr0m/ukyqEv22x
	Oyqze1FG9EzK2ZgMsqW6aTxG5eS1HoWYr43OIBfYDaIlaf0KkgzbOdtXiS1KipvGXz9KSX9kZpN
	IKsXm7QlS55ud89CyAuCO2Zkri8MQc94SiqfExsDlAwHzQLXVSEGDt3pNr9biW6pAN4UFVMd2Z+
	/v73nC+9dsSggVuI+0xhuvDxKbqzOKn+N/HDxWoRlGHKLu0hXZ0t5AHVe9g==
X-Received: by 2002:a17:902:eccf:b0:2e9:9263:a58 with SMTP id
 d9443c01a7336-2f03f0c2295mr244472215ad.1.1795536611297; Tue, 24 Nov 2026
 08:10:11 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com> <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com>
In-Reply-To: <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Tue, 24 Nov 2026 18:10:14 +0200
X-Gm-Features: Aa3M54onkUvGne4r5q9V5OFXU9IrjVkwLVOH89IS09aAR4OuvPfNMfZg3YhBdKs
Message-ID: <CAPnbwjpP9Fin=CyD0WiA2c4sxqbfyK7AziE64PCX4w9kbz55Kw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 24, 2026 at 06:21 AM Alexei Starovoitov wrote:
> I think this should minimize the breakage and fix the issue.

Thanks, I'll do v4 that way. One question:

Timed may_goto sets the mark, so a may_goto loop would run with
preemption off for up to 250 ms, which you ruled out on v1 ("with
may_goto they can take 1/4 sec"). Move count and timestamp per
invocation, in bpf_run_ctx, so that may_goto needs no mark?

Thanks,
Mike
