Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BFF3876B3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 02:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043317; cv=none; b=n73ng380T7YegVrNxIXfnquc3EoT2s9fuBrSdS4YJOJxq5V/mbgjAtUcf95DI8UHgag+W9m8LnAbetwliTQ0O1wbG1ykxK4F9vUB4S0YcYN13ElVzFPnTDBr914qzHKge2RfYcktM3gXdVXhdAg9+HR6PHW0Xzl/Akdl2E+t0PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043317; c=relaxed/simple;
	bh=AhTnvLYcK5xfZkNFziL5C7zh7QLdPnlfBcIEDA5bqYc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=S5kY62CRVLuLs10meKZErl6iJsD75vdda7qkx35woiRsrIQuhzhEPAxNmBYfaw8jXkaIRl04dr5usxw3DxzTFzsxY75hxYCleLTOYswSl/ESFLk+ZO3NHmdXW7NKEXA/kPzX+a5sADqkoq3zWAXalKPKiVzOMLxHzfvM8sIvrbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcFU405D; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcFU405D"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48351e5bb47so1213799f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 19:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790043315; x=1790648115; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AhTnvLYcK5xfZkNFziL5C7zh7QLdPnlfBcIEDA5bqYc=;
        b=JcFU405DTwV83KSw7hx71D3KqEDEpd4H5VEVw9pWQ/5WDdfafr3HzilIKkypHxmiFc
         BronMpGoit8UZs/l4/2p0zPuc6gSujCOG4xVKGWGT6DQRyUQGWEPmymp8J01gBIwAxDZ
         uM6vL202+1ttILNLmumphbBcXgsVLoCIz53sFiClWezMzePRH4T8GTBnOUqrwAwHlBGH
         kmbxzpE66glYLvPeWDL9dYPlRG6AELLiBCq/nn+umfHv8JCgV5JmHGHWtC9dnaakvh9g
         24zR6hf4c45XSZycry3zkYGQtA/A6cj2gwTQFI2+SDi8/JCmJEJb9mDoB3wKTD2lSf0S
         +pQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790043315; x=1790648115;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AhTnvLYcK5xfZkNFziL5C7zh7QLdPnlfBcIEDA5bqYc=;
        b=R62EYA/USRAwPp+vPu5BTlJMrQX++FsuangLLQMROtAi3Yv6NugawSOhepNxWCEdyx
         F8DQI2SKYC4G85/AEAIfD0PaQbSb1rkoCD2dzWhgeYV7e7sUM8ky5MyeI+8oykvglb5o
         haXgFPygkyy+JYRp/zsTuBrP2+W+mzkbcvMZZtcSjWvsf4ZUyYw3yS/3d8IThx+yjbFU
         U8Zvmsq5LuppGRuHZ620WZ537K+t5EkBy1nGFom1S/jGKXeWox+XgQPUKnox51ukNmmJ
         AwvZFFkr/p95lIAfr8DCZyZ0yFCMQuiJmV2X/6GeUNJHHQM51rjc+oHHfRPmc9uSXSho
         kRtg==
X-Forwarded-Encrypted: i=1; AKwUvBw8hjFcwXRJwnku1hpM/s8hh/ZwKe3UuP/B0qHSNp1uqdjWqjqg3/oRDeBEdPf9suDyqPj/Gb2km8vBxof8Eagqwm0=@vger.kernel.org
X-Gm-Message-State: AFuF++k3MRTpaVQ69xDC6VCgKHe0nsX/NxdDKxwhCuJ5jX307VxEHnCq
	c1zI7xxuQoRXER5YGzZ11kyjPZKi2ox6Bo6thKDUla/yXSSDMgxy1Szr
X-Gm-Gg: AYBFou1eDHaX+i4n/HK/aM1tEB2YboZqhXCWqccN3p+T475izyS09iIyjG0UoNwLk+z
	xw3CsifJoZSJYcjWjLFrOpXnfJmQYyj7ToImBottqCv2+cFtcM8GY6cuLVwQ+PA4tH0d2x7x30Z
	ihJtITIYAWzgRIwz4RTaVz+7PSVWp0i75EP6FHxGYXWt2246doijW4PeHQZsBkzh4yWthx9+kws
	7hITK9UH0DqXArcGYg82qr2dSJl7gVGMnAX7vK7sIrN17xkUFqJvA/J2L7dSHsJOsqoJded22F8
	izIVZv8pXS31D7RXYcDtQk18a7Bf2PFK0mr1QKM0BbuS6bab+a4Y5oF4TpITqcIC8Ukifza35Sb
	Uv3t5lhCU58Jl7kPTBeQk6pGXSu29xCT8SJq1OJDwf0+F/WYtS4aI2m2O0Qymcv7Ogve/ibgWX3
	t7OYk2a+IrK9aMFGjrevHdndKFCiVPDhSCBgOVM9mr72D0Lwqy95vQkHlM27Rwe1SjAjuJ3LukY
	Mrz+0fjmCrsY0BX/Rvfkc0p4FKUJ9dXO+z+QNlVGRSY22bQpNw1Ga+npIQ0WCcGy80fN7YnNoPS
	TdN49OI2oSGYs50dUBZs19w6WvcztKsacg==
X-Received: by 2002:adf:e001:0:20b0:487:21a4:f617 with SMTP id ffacd0b85a97d-48721a4f785mr14858305f8f.19.1790043314473;
        Mon, 21 Sep 2026 19:15:14 -0700 (PDT)
Received: from localhost ([2a04:ee40:2228:a500:f8e2:3a74:69bf:2c6a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862731bf9sm1068404f8f.1.2026.09.21.19.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 19:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 04:15:13 +0200
Message-Id: <DLLHE9PBLDU0.XQGEOQQIR4HV@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Reject bpf_skb_output() from
 return-side tracing
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Feng Yang" <yangfeng59949@163.com>, <kpsingh@kernel.org>,
 <matt@bobrowski.net>, <song@kernel.org>, <jolsa@kernel.org>,
 <ihor.solodrai@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <martin.lau@linux.dev>,
 <yonghong.song@linux.dev>, <emil@etsalapatis.com>, <rostedt@goodmis.org>,
 <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260922015417.130869-1-yangfeng59949@163.com>
In-Reply-To: <20260922015417.130869-1-yangfeng59949@163.com>

On Tue Sep 22, 2026 at 3:54 AM CEST, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
>
> BPF fexit programs run after the traced function returns, while their
> context still contains the original function argument values. A traced
> function is free to consume an skb argument before returning, so the
> pointer seen by fexit can already be stale.
>
> The verifier checks that the first argument to bpf_skb_output() has the
> BTF type of struct sk_buff, but that does not establish its lifetime.
> bpf_skb_event_output() then dereferences skb->len and can trigger a
> use-after-free.
>
> Do not expose bpf_skb_output() to tracing programs which can run after
> the target: fexit, fexit.multi, fsession and fsession.multi. Keep it
> available to fentry and other tracing attach types where it is already
> supported. fsession must be rejected because the same program runs on
> both entry and return and the verifier cannot prove that a helper call
> is entry-only.
>
> Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Closes: https://lore.kernel.org/all/9d61b891-2d52-42b9-bc1a-ad963ccb675d@=
std.uestc.edu.cn/
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---

Sorry, this is not an acceptable fix. This negates usage of the function in=
 all
fexit and fession attach points. Unless there is a simpler way to enumerate=
 in
which attach points this helper should be disabled, it might not be worth d=
oing
and leaving this be as is.

pw-bot: cr

> [...]
