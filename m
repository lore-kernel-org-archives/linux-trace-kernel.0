Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D701235948
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Apr 2025 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895836; cv=none; b=RATxPhZM7N/EBohMxQajxmgSvfdWJNMS2AIe73Uc5lBAWzAAvBaeFmJyc/YozAb4Et/49hGqy4Nlyrcd4YgErkkdEjbcJIjU11U9V3/d4xELMaUQ0tJ5BSnJmlBwIDiZEy79j3ITXIJb4F23DBT4+N9O7C5jO5oh9irpS+QaqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895836; c=relaxed/simple;
	bh=w1gNiTdtro19oJd8N1VuhyxJwViS9e9fOs1UAKkND3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6tQtj4Z0vpdMzvASYZqxxHVAj1j/toASgJNIr6TY7ZrMu482Z/0+iWtDJ3gcBIPE+Q7PgudtDqfxkSBAwv7Nx1/8wkz3340LZbVm2opSbC4X244NOp0wqEfdtssi9Z8c2dCViPC1SCyQh5p5Q87E9oTF3Xk8tjBTCB+33oB4rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ho3gNK6F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ho3gNK6F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744895833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhyHByvuNmnkzLLWMwyPda0e7IshL4F1qmQONxtFvxA=;
	b=ho3gNK6F1OqnXZyyO18x8/iPiQKezVZVlUsGitHGqjXuvDQupUVI1RDovHIZQv7YOR5wtz
	v8CfyrDB48ho3uXQOvSgxbLBuiAlg4TojIdq0MO8XpIcnfBvA20D0X21liXJ3iKzOzH5dL
	mUDSy2Q98zpW4zqcQfCQ9GxXAWA/G+g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-pdIt-WBsNrSJey1PFG7f0Q-1; Thu, 17 Apr 2025 09:17:10 -0400
X-MC-Unique: pdIt-WBsNrSJey1PFG7f0Q-1
X-Mimecast-MFC-AGG-ID: pdIt-WBsNrSJey1PFG7f0Q_1744895830
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e9083404b7so13090586d6.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Apr 2025 06:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744895830; x=1745500630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhyHByvuNmnkzLLWMwyPda0e7IshL4F1qmQONxtFvxA=;
        b=ayeopLCkePVdtN3ZsC68pQlg23Qx3BphYgyhnc2Pe8ZUMGji2OTrLixDM/OzmL7uzg
         KKVtCTCoSe7iqotL0B3VwT5gLjZIdvm1ZV42I+wvXb8yYVFWvy7pqvi0N477NcDvQTw7
         Q9sLa5XPPh6mK0GHC8t40ZH5cLPR8BX6tOeDlCphBnXAsGfm0a9gOnd5lr8BeyoPM+38
         HpG4/bcQO0fnpGvnCIuOJk58MWGUFcuikdvr8XoM6ZpWseiREiFuCnq8/+3ehw0hgQm1
         J3QoHyzkzn7oMV60i34lqN87/AtUkX7J/eyRitqWIGKixdZSg+WSZEGtIp5moc2MXAiU
         swDw==
X-Forwarded-Encrypted: i=1; AJvYcCVYkA+7uZv55nhU9duBlao0RqiHlUY719U/L9nDugLTcqoXTfJc8TxkxzNAgo+4eUmFq8zc2cnb+kEaFeFEFgisF7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2+wGvpGjK+VOXiq4z/NbRWtjyAc7FzEzs5eS/9/RjSZCGeMfQ
	NYPikJ9htr6jNqouyBdiZuNZiPk49dkHARDvB8jnJo9MGWNIAbwLBA1jaCgytVy7Dj84H1eFXMv
	px0mB2j2MzzFAYnstZ+qhTbLyoNUuv8Z7POCs9vOryznk2YVAroXRPQrOv3+HfCbXLWS+3Q==
X-Gm-Gg: ASbGnctJpnDZJ5vDhGW6ffvBI0G+DI8NCqaUv2xGcSQi8W//eLRMDnaJatzjbb6xHzo
	wxP7Hrc/GKzsQyC8gdPS7JB5sqOdrjywlGvqoPbCyEHf/geNEiKmj5RtDKiCu9eng+MGeIzyx50
	y8Ie/z7wOai+MefDqXwY9NNnMpsfvv4YbB8I4AnHjnpbjnKCRjmjhBWvCWZSul5NXjNPKf8YzOs
	xrhPPf+GJy2t+HrVlErs7FbIeqhDicRIkCLxmRw05F7LIxA6CMZ9inGh4PpvX2MjA4gyMm8ig2J
	9PPHwObi5jpdsj3O+7DmCCTRJHNTPbsn/4yeqbgD0A==
X-Received: by 2002:a05:6214:238b:b0:6e8:efd0:2dad with SMTP id 6a1803df08f44-6f2b2f4290amr78455836d6.12.1744895829924;
        Thu, 17 Apr 2025 06:17:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAmv1LbYEq+ryV1sjdA7s1b6xi/JjBxP7J1Dpv+giy9IaehE8vpbhOIDRrQSohSJsu2RT5dQ==
X-Received: by 2002:a05:6214:238b:b0:6e8:efd0:2dad with SMTP id 6a1803df08f44-6f2b2f4290amr78455536d6.12.1744895829629;
        Thu, 17 Apr 2025 06:17:09 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de973221sm126961266d6.42.2025.04.17.06.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 06:17:09 -0700 (PDT)
Message-ID: <0f67e414-d39a-4b71-9c9e-7dc027cc4ac3@redhat.com>
Date: Thu, 17 Apr 2025 15:17:05 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
To: Breno Leitao <leitao@debian.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, kuniyu@amazon.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 yonghong.song@linux.dev, song@kernel.org, kernel-team@meta.com
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
 <67a977bc-a4b9-4c8b-bf2f-9e9e6bb0811e@redhat.com>
 <aADnW6G4X2GScQIF@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aADnW6G4X2GScQIF@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HxlBNYfFxfxFynJ56Gpfc2MmhEy0OKh1hEaQR5qu4U4_1744895830
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 1:34 PM, Breno Leitao wrote:
> On Thu, Apr 17, 2025 at 08:57:24AM +0200, Paolo Abeni wrote:
>> On 4/16/25 9:23 PM, Breno Leitao wrote:
>>> Add a lightweight tracepoint to monitor UDP send message operations,
>>> similar to the recently introduced tcp_sendmsg_locked() trace event in
>>> commit 0f08335ade712 ("trace: tcp: Add tracepoint for
>>> tcp_sendmsg_locked()")
>>
>> Why is it needed? what would add on top of a plain perf probe, which
>> will be always available for such function with such argument, as the
>> function can't be inlined?
> 
> Why this function can't be inlined? 

Because the kernel need to be able find a pointer to it:

	.sendmsg		= udp_sendmsg,

I'll be really curious to learn how the compiler could inline that.

/P

