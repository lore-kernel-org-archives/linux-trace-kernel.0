Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF20277037
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659380; cv=none; b=bpOrwngyEq1jSWIYmpafb7+5L6RG0hue8bns5KZiFxNjaArkYbMRz3ab+FvNRiCCG9JKHQ0s7+tvtJxXifC2bF5vf3Q+4XdI71J+R3H3md8UctLUvA7Fwy9OZGWh1HgEAouMGwdnge9oeeEEQsv8Lm1ilbdUImNHBwNz9qVpCVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659380; c=relaxed/simple;
	bh=4jmmhwQ9HX1nE0wu5X/8gnKDvmvDMxjNyuG7KPrwFyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WP0OYMjiJrGgs7oKsQB9O0EWl9MhHLs1xeDBjKTVHMfnNBKEcHdOlj1QnMzOZU1P+S+VYBtRWueCJayMdEPHiZ2AIf/xqXUtp3m6LOdkd5Fj0E2IWyafXu7okpBiGnSwU9oUwKACo9ufwRTZRXh6NeZnba+IVEIXcWaJXR/adkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwdQWneu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwdQWneu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773659378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ1qCUPpj4bfVKkIIWkXXV0ps2+j94E+3GVF/7CvIho=;
	b=TwdQWneuxH+XPY5fg4W31LtUzZwvs9cfCZ9dRdFiRTRqPq5HjSQG3cmFuV74Ua76gsC4uR
	U0F1zxc2w6xIU79k5AOg6R2+CobJckyBOc8SM+sXtadubrjpU2TpI+f72fTtKOoC2vE5hb
	d+egVbs6e5h63Ek4ToRyjGYUzu8woQQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-Cq-GBZLuO66Ey0qHJzB9zQ-1; Mon, 16 Mar 2026 07:09:36 -0400
X-MC-Unique: Cq-GBZLuO66Ey0qHJzB9zQ-1
X-Mimecast-MFC-AGG-ID: Cq-GBZLuO66Ey0qHJzB9zQ_1773659375
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48541cac34dso41925845e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 04:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773659375; x=1774264175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJ1qCUPpj4bfVKkIIWkXXV0ps2+j94E+3GVF/7CvIho=;
        b=ihCmsUQQiaxHUOteA07axuby0bu019JKpGFN7K0fYKbuVbfbLhRk9OsLzFozV6XzXu
         JSf4vKkogPj8Zj07G/c+vINoI2IGNZBAelwvVw8naiKgBIUpWdje7RaKhYaTh7vjgdOA
         EdKvUKYOd2kib5nULSNrkipfMdvwCHIow7fiYEUSKjd81ECPcIkO3ZaaOqAnJrNot+Vr
         QgGJRRPDg8WZZ9G6ued5EQjr40atMLH9JvDjLgiLTnOC5poYEQAyHofEpBBnLGN46chZ
         QZlYIet/WZKLrs8PkNc8GHVbJVrjtMu0c6T2Prqy0D+77ypJpJiSNiHkzgb1CVFgX5Of
         suKA==
X-Forwarded-Encrypted: i=1; AJvYcCUDf4YCvlteAoa8JhfsHEVl8jdK+3YPlmRMC+36YAoDNEeBbbIBXZb8niisK8Wv8p/PS1xnzb0W/nTNTlyhbx0YDVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmdlPfA9VbgnkeMfD9aQxy4Pf7M6vSVeYiBVkrPATQ1iCRcAks
	OoYCJzZDyb2Fo/+gXy+dYvklHIp3XsyTqjmdFI6fg3uvQLLbTs/ofjiecxv3PaGOyKzmB9lGOQG
	mEVsiAGqi9goGbuci1j+2Z9QkVIZmzF/9JxOtjhQwdVKCzcfP6GlZMoi4IwzoCC6iOpsLPVUhvA
	==
X-Gm-Gg: ATEYQzwhQm1wJcmE/hNemsExst9Tj3VCUaaxVUshHiSYaypQIjGUuXZS/DOhcSZpR5Z
	5osIhK4cCbnwmfditRZo9Zwt/CF24ZMSvhjjCAvVOH72HHJKh5HTQgAR/DpeLQbFTujl8xehh36
	C1Ya6aRZl46I9zI46/JfmXt1L+RLROMk8iN6im9TkutJIr5i7/cLB0GZcDULNCxM5xguKQWn9eA
	cKAbxt7hvbAPxCS1XanZeTkR/fXcE9PtKC062cg59UFDq+17VaKnaWfWwQRd4qyQQqTM7fiLKuX
	WvTbEkzpVQ3D4rDHgR/xlYOBvwzxbXygFH3JyqezhzfLYJpVxeysYk2LJQjI0YIPvInNgPqVBj0
	IYUxZTh6tFqwLCcqzrB8V+en+HUtzsG8dTLgwisSyNcEa75O2Fg7Hg+M=
X-Received: by 2002:a05:600c:a4a:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-485566facc8mr211849595e9.19.1773659375352;
        Mon, 16 Mar 2026 04:09:35 -0700 (PDT)
X-Received: by 2002:a05:600c:a4a:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-485566facc8mr211848875e9.19.1773659374904;
        Mon, 16 Mar 2026 04:09:34 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73dasm1212991845e9.2.2026.03.16.04.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:09:34 -0700 (PDT)
Message-ID: <b042de90-79e3-4976-9bbe-b6df3266caea@redhat.com>
Date: Mon, 16 Mar 2026 12:09:32 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/14] tcp: preserve receive-window accounting
 across ratio drift
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
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vqqB6bu03Ps79hnno-3tfqPev7WsC11ekyP2Rbp_jW4_1773659375
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/26 9:13 PM, atwellwea@gmail.com wrote:
> From: Wesley Atwell <atwellwea@gmail.com>
> 
> This series keeps sender-visible TCP receive-window accounting tied to the
> scaling basis that was in force when the window was advertised, even if
> later receive-side truesize inflation lowers scaling_ratio or the live
> receive window retracts below the largest right edge already exposed to the
> sender.
> 
> After the receive-window retraction changes, the receive path needs to keep
> track of two related pieces of sender-visible state:
> 
>   1. the live advertised receive window
>   2. the maximum advertised right edge and the basis it was exposed with
> 
> This repost snapshots both, uses them to repair receive-buffer backing when
> ratio drift would otherwise strand sender-visible space, extends
> TCP_REPAIR_WINDOW so repair/restore can round-trip the new state, and adds
> truesize-drift coverage through TUN packetdrill tests and netdevsim-based
> selftests.

The series is IMHO significantly not trivial. Can the end-user meet the
relevant condition in practice? How? What is the net benefit in
practice? Is that observable under usual conditions or require
exceptional circumstances?

I think we need a strong motivation to merge this kind of changes.

/P

