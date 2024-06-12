Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FD12C499
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Jun 2024 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718232783; cv=none; b=Iw1B9jaSNctYRk7tkaAvbuiJ/NbAE2JsFDOgYpugMD8VNM4Di4D2Y7iID1745+9KfUjwdRHRBanO1Uw5vFrBywRcmW2VyhTAAqLjneYbKcTeka57w06+DRmXY9xhx9ZHchKsIcV+D3nRpum0GRRf768fxgOsJCLS/SmOeFds61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718232783; c=relaxed/simple;
	bh=L3qaXQNUUVxh4Q0Q3RMUhGqp7sJ7EFx4+fzYvA3H52A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnhABadrxbBGOFToVx7B8LkVH78mkG5MUei6ePJj+BDmVyp1ds4KlQFsDj0AsFMdegpc5X3YPQqpAzTqNI+n+SH0fYpM70/Ams3QApC73bQSnz5L56hJGGE8S8AslywrOSorzShcwC+QZBimQin3/5dSclXZpi85WJ8laDbi9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jK/qHLGv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jK/qHLGv"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f737bd5cfeso566915ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718232780; x=1718837580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCKGfocKzBU0+xeBiPtl1Ex5TwQcMh3k2EBSdA3xSn0=;
        b=jK/qHLGvI0kV5kxk0TrIxYpm7MMWZSt3v741kn091VcRmXCARzl9rtz9vI0V4zfu7H
         GR7OsA8rw93QhkXvQIEMPEP+ta1DBYG5sB4JUmu07Tv/2GANeCt1pLwqhfXTP0ahkAD5
         ZTQg4WCW4uehb5S/Ej6DidDnexG6/OhTOov6AbzeQ+7JnKgZpxmW153617GINF5uGI3M
         bvEbqQdnnimNSgV49Rv813WRNApxGQj6/2ZP1jfsA74AzF066dcloIIa4indI8oXIvGP
         goAx3kwz5WfjuKZAE4S35MwK1J/RTxvBGAzcxGcOoDyJZ9mlG1dAmdToy+7D2b5ryiAm
         rhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718232780; x=1718837580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCKGfocKzBU0+xeBiPtl1Ex5TwQcMh3k2EBSdA3xSn0=;
        b=m6h64ocVe95jT+X0W+ZIEbKI9sx0ggMcpPHz8Zb87rxVd/xw0TQK06Kzv61PGYxndd
         kfysZTnQfz4MGqHioQyYMa+9yx5B3PqhKOQ/79nsIt3QOhO7nD6uVc9iwJsmjwF0YqRs
         iq+vmg8Jy5Hn9P/h/NuA1WxjJW6G5L13+iosW1QBZJe/6xXVoRs/iyxTrRj8jiYjNFj4
         kun2md7+UJnxFLje7AaILPNUWpNLp6ar9zNgdrofL1ZwkBO5sC09oB9rn+GzsNnSyW2H
         uR//s1T8SYiuEnRx0wbYBuaYFnZlRr2aAQYip7Ml4H5fFCJZ09Mof/KeKV3vcdUTChXI
         ZiLw==
X-Forwarded-Encrypted: i=1; AJvYcCVPIsOrCJYurI44zxU0ZALBJCHZt15cU6rFRibcS1x1LbASRvB9SIwJNWVZ8rwZ1QOA4pNe8mKJoMWqDu4TgKN4Zwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAycDZNZKRKhopgqZ7+pOq5eSrx9pmFwXKYpRUkvcLCdu50cpv
	9ISJmL4zta2uKOjifjI7L0HQAtxPsWzzyLSKcQ+MSh+n31ddUlwVaA/eFeOSjks=
X-Google-Smtp-Source: AGHT+IH5UZSMoyLCwmMYbQsnXovMsmtOxcZgzfit4qNG1yAnUakar4EveGlx5xiJfFg6llU0rCt4rg==
X-Received: by 2002:a05:6a20:5647:b0:1af:acda:979d with SMTP id adf61e73a8af0-1b8a9b4e85fmr2859600637.1.1718232780575;
        Wed, 12 Jun 2024 15:53:00 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d2c5sm73821b3a.105.2024.06.12.15.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 15:53:00 -0700 (PDT)
Message-ID: <7e58e73d-4173-49fe-8f05-38a3699bc2c1@kernel.dk>
Date: Wed, 12 Jun 2024 16:52:57 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
To: paulmck@kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, linux-block@vger.kernel.org,
 kernel-janitors@vger.kernel.org, bridge@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Nicholas Piggin <npiggin@gmail.com>, netdev@vger.kernel.org,
 wireguard@lists.zx2c4.com, linux-kernel@vger.kernel.org,
 ecryptfs@vger.kernel.org, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-can@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 Vlastimil Babka <vbabka@suse.cz>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240612143305.451abf58@kernel.org>
 <baee4d58-17b4-4918-8e45-4d8068a23e8c@paulmck-laptop>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <baee4d58-17b4-4918-8e45-4d8068a23e8c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/24 4:37 PM, Paul E. McKenney wrote:
> [PATCH 09/14] block: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
> 	I don't see a kmem_cache_destroy(), but then again, I also don't
> 	see the kmem_cache_create().  Unless someone can see what I am
> 	not seeing, let's wait.

It's in that same file:

blk_ioc_init()

the cache itself never goes away, as the ioc code is not unloadable. So
I think the change there should be fine.

-- 
Jens Axboe

