Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE711A9FAB
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Jan 2026 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769238466; cv=none; b=l0n+yZA43aaHDZO8DVn+yFHoa+CZzoV6+EOwS/lLlSrhzjkzKC9g0yEz4EG4VfHyNI26wsOrZDaujOmEVZaySFXyGOaOHHBI8b+XAq+A49z/tQFdn9QGEaOzTp1Cr2PnnpmcDtah56q7x5ssE6bx0Yyfn/3MBkz9CAzejPbtL3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769238466; c=relaxed/simple;
	bh=J3zHDYzfTTCt2dU5qEXpmS9XYoXRIWt7rSr+GnITUeA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=k8DUxo4oeGpweyNchVprT5O6H50nCGuYg0CuWodzffghyxDWszpu6CxeHzZo9l6CwuTnUR3Ga3A/NrpWKf4c0hapWSavCEhtwHAH3qfgIaNyQdKz1v/oP8+6VA5/Cg4te2OnRkFG/+eBkm/0iHTGx6LL1onTT5mMaVA7jY1J+fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWq7a7v8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWq7a7v8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769238464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3zHDYzfTTCt2dU5qEXpmS9XYoXRIWt7rSr+GnITUeA=;
	b=LWq7a7v8hfNkiaX+TMW1rbtPQmHHSDDUOuDXjSwgoaUKyb0dzEXnFeyrdGszGyQlaPadk+
	uitbVomfsRY23nxnGKYrwCVuDhvmCo0gTR/Yxy5qsT2Faaq/d6KgtgpXqNyKJeecEzSMzz
	xAjcey1rn9EMROK/Yjnj3ZL4l6BZBgI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-mnQ2yAU_NH6WqzCXJW79OQ-1; Sat, 24 Jan 2026 02:07:42 -0500
X-MC-Unique: mnQ2yAU_NH6WqzCXJW79OQ-1
X-Mimecast-MFC-AGG-ID: mnQ2yAU_NH6WqzCXJW79OQ_1769238461
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so33730215e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 23:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769238461; x=1769843261;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3zHDYzfTTCt2dU5qEXpmS9XYoXRIWt7rSr+GnITUeA=;
        b=crCcqKfkBhMvyOmi3bJ98EvGUzvp1p48JKXzzridAnVps9cHrp+lWNbk2RTJ3pBUdw
         Le9zC0Bemm6k7NLO1flg6OIfATzz0y+Nhe1UvIdzq36fhUqccL9mbh1VO/NBmchVUyWD
         iVk7xmm6LVpibj2SO7yDR0Vfeu3LApAPfmV2NVn+rBaz5pmopFI5cE8u86jPi9NDoghT
         ROP6IHzwWNyFuJNvgRe8houa7qoBpBMKhK2wn2woHWDzU63H2Q6ZWNIJHC+3do+QFupX
         Pw9OsvFDHr2Wj0axERTKD6B4KmDYL5+thQhgr4PDqM6n3z8QQKXmVGDILVx75yB7VpJs
         dhhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoAKWgn2PM2fu2hWUnvXp+pRGHFxvyncrRr2sezlA9GUZLbr6HmvKEt+HwFdNOjSdTFz9PFyfCteXqaOqTn20q5vo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx66RWXuSkqGu2PrrfG29nwCdz2qpLkLCHOjPLM90oZzz+lGEvs
	UWFFko8DCh2NNNjf1PG2xbZGqMhmSKyh0NbbxnjQKSWbEieGM5vACNkjXV0wMJ8h/SclXNoQ//y
	LeWVkpNjBQfs9LBAk2CMqd2fDnhLOK6+aDpL0N+zIR+Zm0Czu09dmgcic0m21wf4Y3lxtc+THRg
	==
X-Gm-Gg: AZuq6aIUyfgFgh38L+lF0WIsBCE6bZh7lUqjnZCg3eQ3pZs8MI1ysKOHE6L+IkyjsCE
	V/gAPb3naVqYzxlMaj+JkINxpsDJ7sWLPuBsVFfDQIP0KdOLXtCdbSao7g1G6/emUfW6nlmsTFa
	xdbeDHloIBtE9t4mXTLDJSfmCzaIu9SpCQSghZbHhpzmiMaRyvrsw8FK775SYQmEnvy8cEp9pDi
	3QyGe0wu/+B/nMRBXtpFgHxPl8Ch7vzM9gxRjP3pcukClDNBhYF1R1JzSE+vjgzYR+++XXWiChp
	we6+bFIvQhdFcXSivPtjV54n2+tCnDxbUqJ7RuB6BwNhRNW+ghAxeOp7sB1qHZJ+DZmlvcJhnSA
	DqKDXZg==
X-Received: by 2002:a05:600c:8217:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-4804c9bff60mr82792185e9.28.1769238461386;
        Fri, 23 Jan 2026 23:07:41 -0800 (PST)
X-Received: by 2002:a05:600c:8217:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-4804c9bff60mr82791905e9.28.1769238461003;
        Fri, 23 Jan 2026 23:07:41 -0800 (PST)
Received: from [127.0.0.1] ([195.174.134.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85cff5sm102409995e9.7.2026.01.23.23.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 23:07:40 -0800 (PST)
Date: Sat, 24 Jan 2026 07:07:39 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Soham Metha <sohammetha01@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org,
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Message-ID: <7350432b-f47c-4e9a-baee-b0d7d5dd1770@redhat.com>
In-Reply-To: <c79d4fbd-e9a4-4d73-a650-b01f437a4c0b@gmail.com>
References: <20251203202259.69116-1-sohammetha01@gmail.com> <c79d4fbd-e9a4-4d73-a650-b01f437a4c0b@gmail.com>
Subject: Re: [PATCH] rv: Fix dead link to monitor_synthesis.rst
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Correlation-ID: <7350432b-f47c-4e9a-baee-b0d7d5dd1770@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e8m01ZsuS1KtTJDVfOQEvEcs4VsmTine7-kGuR6_184_1769238461
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2026-01-23T20:06:35Z Soham Metha <sohammetha01@gmail.com>:
> On 04/12/25 01:52, Soham Metha wrote:
>> --- a/include/rv/da_monitor.h
>> +++ b/include/rv/da_monitor.h
>> @@ -8,7 +8,7 @@
>> =C2=A0 * The dot2k tool is available at tools/verification/dot2k/
>> =C2=A0 *
>> =C2=A0 * For further information, see:
>> - *=C2=A0=C2=A0 Documentation/trace/rv/da_monitor_synthesis.rst
>> + *=C2=A0=C2=A0 Documentation/trace/rv/monitor_synthesis.rst
>> =C2=A0 */
> Hi,
>
> Just a gentle ping on this documentation patch in case it was missed.
> Please let me know if any changes are needed.

Hi Soham,

the same change was included in [1], which is already on linux-next.
I think I missed your patch since it apparently arrived first.

Thanks anyway,
Gabriele

[1] - https://lore.kernel.org/lkml/20251230075337.11993-1-slopixelz@gmail.c=
om

