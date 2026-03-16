Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8238CFF2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661468; cv=none; b=Ey1scaxSvtc6jyx7fV2DWlj5WINz9Xb3/ISSkUduac+HBU50V6P0E4LnWalNuGyZezY0JUc5CHq/2lFNZ3r6fdHe4ZI4dM4DTWzYOWdD4e8OzQ3lPzVq5bewuCU02IxHT2uRqrZCLs/672msNgJm+OA3x2yj9jFwPjSkbd7g/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661468; c=relaxed/simple;
	bh=XYZ/Z8E6vtXI8ekr+HAC+mYeXCVml7M5yCUGxNj3tfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQKwDn+qMCBDWnhVBifciQCahUjXrpXHs0n2XvWoNrOryagKB1jNf2qBIStOE36epm2oGl2xYv9giJMLJa9pxCyB69rabz8n37vdnhbT24sors7Rdq7b/ulFc9SfeAOgBxzCLPPQHyk7fvcD3ukYUgGMDq3+TgLLpQfLWS7wNpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLdiH2iA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLdiH2iA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773661466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BjOWdH9YOd3q5jDpZy3h9DKwR4CFECAPPaRdY128lqI=;
	b=WLdiH2iA1Fj30KikWqsTr882TlmQNJPxWsd0yhTZuWtCrsmTWGoe98gePWbWrQ62SYG6x0
	VQGKKM1la8NrwjL/yG5UQzFfbbI/xKgbkJB1xQT0r5ntW+WkifUQzM/MX5IhIpbXwo2b5C
	Ls4NSIj5HCfVsA39eD/a2Dpf0JKsyYQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-ks6npEFqNGu1NqQK5KcStA-1; Mon, 16 Mar 2026 07:44:25 -0400
X-MC-Unique: ks6npEFqNGu1NqQK5KcStA-1
X-Mimecast-MFC-AGG-ID: ks6npEFqNGu1NqQK5KcStA_1773661464
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b979df03fc8so138370266b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 04:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773661464; x=1774266264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjOWdH9YOd3q5jDpZy3h9DKwR4CFECAPPaRdY128lqI=;
        b=d6FXeR29ZIE5fiXJASU/fx6prwfAnD9QOtx49QI1575HDmr6kvuTPPBtaURazzeTYs
         gavad6CZE6V1OtQYuMJ40ReBUXdNlkUIPuTcwECx+h63ARLbzv7qKg8smTXB++2B/amn
         JokgC9eGCphbBzlxZFYcB88LcZcUnQQkogsX/w2J+Nh+fdv7URETVKlqCaQl7FRnOt7f
         FJEY/7fIH+XznpQH0xXzP43rEGdGYEPVbjA0P6yA+x58evQ7TEnPnb9fAJXI2wSy4cy8
         /tzbrxxa75a77Kdf4hoROzVoCcwE08HqOKDdWuT49ZTCWR4ufwH+grHZE8tSonMjPdyp
         ec1w==
X-Forwarded-Encrypted: i=1; AJvYcCX/eZlCGmj4Jyg3hO1sGt3DmV7VUY1Mob+YHNwvAFXpofonLF/SOy5kZhRLeMPir5KOeU3PyVcoqPx8sKrYW+9y1eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXhSQHBe1I/CWNPc25Nugz6fv4xbiDP/lXvCU2taaawOo6SE4v
	944g9dYSwSMETEIbCJmNduPVdYb4iLA2DGHh+BN+RuVEvYyjIbO+3bsIg88vxygmR3R7Y+HbPSS
	gmR+qSGvBjjJQJez89k2tcJuCagaMJv7mXdHdntYCRe1BUx5nJ1S+Xp2f1GSO1jkuf3gfaACHGA
	==
X-Gm-Gg: ATEYQzw/Dg7HTaVUj8SA2ZA4A+DIu07Kim7xu8IcLyooeeCmakPwz8oruccMkgq3r10
	LWYwUr6l2FWUHAuGa7Iz3By3w+p10r4FOC9LeopX2jq2KGoOXpHGMxQIPYC8BGHVfev4UoU0UJw
	T5KPepgtbyAJOb0OicHy31D15oC3OxlDH9ej5MQuSO1Dov9MjPjeWNnY1dosToeEtfLHz8oIhPB
	fAZ6JqjH4o6XjQyoqP02Yz5XpwiHcdUDXl+Zq53K3eGjpRGXJmwxAKcz1lNrnUKs6+u3JDkJHBs
	RkciZy+B5BH09Lb2EQCf4nEtgnNTzoDeGed9hJUYe+HFyZfG3uiJ/KrX+OCumiEWeV1uuypdEYv
	H0yte/68Fa8Rxuza6r3GnCzkM8xRgYBIC9J5+PBS7o4A7QBU84p6OE14=
X-Received: by 2002:a17:907:3c90:b0:b97:acca:fcf4 with SMTP id a640c23a62f3a-b97accb064dmr285765166b.11.1773661463838;
        Mon, 16 Mar 2026 04:44:23 -0700 (PDT)
X-Received: by 2002:a17:907:3c90:b0:b97:acca:fcf4 with SMTP id a640c23a62f3a-b97accb064dmr285762266b.11.1773661463375;
        Mon, 16 Mar 2026 04:44:23 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976d096d58sm533417666b.62.2026.03.16.04.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:44:22 -0700 (PDT)
Message-ID: <dddab568-a7dc-472c-8799-095ab96cef0c@redhat.com>
Date: Mon, 16 Mar 2026 12:44:20 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 07/14] tcp: honor the maximum advertised
 window after live retraction
To: atwellwea@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, ncardwell@google.com
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 dsahern@kernel.org, horms@kernel.org, kuniyu@google.com,
 andrew+netdev@lunn.ch, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 skhan@linuxfoundation.org, corbet@lwn.net, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 0x7f454c46@gmail.com
References: <20260314201348.1786972-1-atwellwea@gmail.com>
 <20260314201348.1786972-8-atwellwea@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260314201348.1786972-8-atwellwea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PEQ88zE3T_DK_ugrXbmlrdZUT-zT4F3Bqf4mTIF4eos_1773661464
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/26 9:13 PM, atwellwea@gmail.com wrote:
> +/* Sender-visible window rescue does not relax hard receive-memory admission.
> + * If growth did not make room, fall back to the established prune/collapse
> + * path.
> + */
>  static int tcp_try_rmem_schedule(struct sock *sk, const struct sk_buff *skb,
>  				 unsigned int size)
>  {
> -	if (!tcp_can_ingest(sk, skb) ||
> -	    !sk_rmem_schedule(sk, skb, size)) {
> +	bool can_ingest = tcp_can_ingest(sk, skb);
> +	bool scheduled = can_ingest && sk_rmem_schedule(sk, skb, size);
> +
> +	if (!scheduled) {
> +		int pruned = tcp_prune_queue(sk, skb);
>  
> -		if (tcp_prune_queue(sk, skb) < 0)
> +		if (pruned < 0)
>  			return -1;
>  
>  		while (!sk_rmem_schedule(sk, skb, size)) {
> -			if (!tcp_prune_ofo_queue(sk, skb))
> +			bool pruned_ofo = tcp_prune_ofo_queue(sk, skb);
> +
> +			if (!pruned_ofo)
>  				return -1;
>  		}
>  	}

The above chunk is AFAICS pure noise. Please have a more careful local
review of this series before any next revision.

/P

