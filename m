Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA33C414F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790082; cv=none; b=l0RaoYy4eCR1vgAmkVrzpX2QNHddFRi9ESayjl4dIdpZvv3K0kXScWDGzXtOX48HYXPEbmnUi9UE0xYHpWyVOtfagnXPgYIabXvzGGgzvGDBoSTNW62AE18BsfqFaCYYmI7gmPqXZ5Qy0knCdYx+78YIapDsQk23QkbQcsQNKjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790082; c=relaxed/simple;
	bh=UhEIIQ/fF6JUzP2E7jtUaa6TUP1Hc0Cfz/k0EoiURMk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CNgmCWFy+h4xC6XqMjZopTm4maNsnhUkhKgIxw8eF9A1zsuZMPbofMsgglMgO+F6YN/X54lfPta341UNvjPGfNxNqYhtVN2/XesUriSGlU5wIRIFTPD/mOUTZ6buYqTgcQTvSRmAhKkn8VxqAQvI17ZEhTOKEv0c+JGXA646Jw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhM5d4PB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhM5d4PB"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso40033905e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 03:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779790079; x=1780394879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UhEIIQ/fF6JUzP2E7jtUaa6TUP1Hc0Cfz/k0EoiURMk=;
        b=nhM5d4PByi4xSAS3U27yxW6KF7L/hBEubEIAYTggJ7kZsUjlNlRmhewLoXbG4Nvtpg
         gUoAYxvkEGaXOK800aKwD9aSU1yQDk75udsSOC0l00GpyDLcgMDcqc6CDDJ3EZiJWT9k
         BhAFSDTUKVCphiWAaryStKMXl1KYZkGs+vF6stY6TsxLjSkLKg0H80s+mfBTL7ClDQxi
         wrh/oNB6+vFekhmJv5/NNq756L8RvneHRa4K9RxViy+hRDot6TAack2lxRoRuO+e1Era
         7M4UcTDFPMnWsTCzzTeGHJp/F2A27v/iijQ/SIQp5PA2vfyWk6Ly2m4K59/Esw6+hxHN
         cXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779790079; x=1780394879;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhEIIQ/fF6JUzP2E7jtUaa6TUP1Hc0Cfz/k0EoiURMk=;
        b=gr7NJz+dn4A1GVLTLEla4PFaPFgasF3kP+mYZ2ib4+a2IFcoB1Dd+3GNlHQOEPWmr+
         yf5x3rCXzyDCRiVSyvBVaqyzlceb1YjE+zgxBqaxkO6DN7srNvTojKX7cJPnd0t8L+e7
         EimwJZ2FVZy7FqmdLTuztIqUDEIsoTUdg/Fz9DZcX5ySuF0GTnmPAHGBBq/eL71YE30k
         8ntz1xlGF+FAWpvWt0+lv6foTXmNVIxfuDWdfdeU1bZO3A2kSZQzv3utLbm+B70uCVho
         BSvMj4DeEa/HKsAGonYCCNLkp2tatbPDICf+jg/EEwwzRLG03dsb8ousMQ+NfG7ZQqKo
         rRPQ==
X-Forwarded-Encrypted: i=1; AFNElJ9tM5WMdeeNqDsmEVhLs8vzVG7FT2pdCrrEJ2y9JF7TU8lfDBBPxtN7IwUW7qkdr/oK8+afHK6xSE8M8fIP+ZoxtKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/F2idJTJ17Z67h9LgI47UnazdqWdhFl4wK9UoCRkuuSgtBkH8
	Bd+IlXJ5UK3sfpOGasPm3Dmi/a8Xec26nTf49x9HIx4nJ8gMdnNx/cOB
X-Gm-Gg: Acq92OFKwmX1rNTKMqsrutFJLqLYuxJwdi0a9N4hbNH0zZ26NFFj4w0LgGGu5CdkAJM
	Fo5W0JLiiMuuF32xFusAPWioqtWO7uLu/Bgx3Tn6mKCuqZl6cXwFEygjxQjSTlKSN2tCYfLRV4f
	SByo/4wqA2Xz9IDeBZMyhPFRFkFujsDdxeXj/gvY3LJ+9PXRHUsvGpFx76yAxo8gGFccbBZ3y9i
	Y0UI9/kv1ugreEunQLt9udFtppA4A9lYVoKxlX37cYJjMurBUgBCDWCDzcq0BcjA+FAa3wROYxx
	CtEjMjTPrazcdN6UdjSD8YUsPYotSb9LSm4vOO9CVuzrqKG+fC2wV3Zrein5cHXZj2UQFDF6NfG
	bSTVzMq/htvWXsQsZ/VxL0UjU/oj7CDQCHsy9+PfN+65aEbCj0VzjXJbZv/5vcFtoPTJNToIN/c
	+Fd43yvHtqdw3Mrg/ItgYaJH1aCpi9Ycgl7cwppXiVaUyjHCnHgHoXVL00fQTSALGuyOtlRctCF
	/RaF+H/Pfs=
X-Received: by 2002:a05:600c:530c:b0:490:5527:3be2 with SMTP id 5b1f17b1804b1-49055273be6mr204156145e9.32.1779790079105;
        Tue, 26 May 2026 03:07:59 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f? ([2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c60b5sm344635055e9.1.2026.05.26.03.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 03:07:58 -0700 (PDT)
Message-ID: <eed59d12-969f-4135-a84b-4965743692cd@gmail.com>
Date: Tue, 26 May 2026 11:07:56 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] tracing: Expose tracepoint BTF ids via
 tracefs
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org, rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>, linux-trace-kernel@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>
References: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
 <20260518-generic_tracepoint-v2-2-b755a5cf67bb@meta.com>
Content-Language: en-US
In-Reply-To: <20260518-generic_tracepoint-v2-2-b755a5cf67bb@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Steven,

Gentle ping on this patch from the series.

Since this part touches tracing, I’d appreciate your thoughts on the
tracing changes whenever you have a chance.

Thanks,
Mykyta
