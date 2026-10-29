Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281490;
	b=DuY1F3L/PnSw8pUY20o8EWp+DJMyevHjAraJMXvddou+2IARtmaL4Ed/EzONFSbyVMC2
	 XxE7N/jMMNF2WtgJ6jqCCuyrreSmJafERgjY8YZI6KzzXP/afMET1nzE6Nu8GmAdZaseP
	 MekgLPRQRi5TRsy1S0NvsuLy9+AXhYhGPfPoFPudMsAEajnmOEXQgA5GRcm3eszXW7s9O
	 0d4cMiYo5Gczp1vrz0y2OEsCe9Hp5KR3ge8Nw4Y48d8GnX/NYi1ki0yn2bjihKZ7io3uR
	 tbcJSReKAig7rwt2WKfuV9kplO7UTUovHSwUtYBDM3vrP4oG7fUbgtrYW2QRe0pSTqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=r9Yjn03pj845I6dvouQuyeLdqWNVyS+hRwAp++oHECs=;
	b=zJB+8HFH25MN9QWEjT5k0JWzRnksIbqiYD7SX8OeleUsj/rLg9FHDdj0pk/SF6esHIV3
	 KZ6cKg11U+lI1ctTt7hGEot1iK47bkhdykWV1LLdFH5b4alA6xtpSx1/yBKkgtNEFEP93
	 QuSoFj3dzIfm+9guNozTxBKzqsO8LUWpeuFvyppwU7P30lrRPIYCdh5bMWQ9BwzczTUC2
	 1Y+CnLzFTER864r1YaaRUOPEzlskZgd2fNfkFI5ZV2nmjYizfndxZroO3VIZKsEBQQ6I6
	 NkzdLBF5mPkuneKZVR2jaaFaW/wNha+kv1MyNnpsjPmPghZgoxdYPajwvHO1BxP72Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=t1jGd2wP;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E33606A31C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 13:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E33606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=t1jGd2wP
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36a18fc7a38so4296056eec.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 06:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793281483; x=1793886283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r9Yjn03pj845I6dvouQuyeLdqWNVyS+hRwAp++oHECs=;
        b=t1jGd2wP7FlHqhzmTXGMAvuTeVcRzBygvgwkK6YYcGJy//C+hGySWO7TU8DaNDK4S8
         l0flg4KDDpWc8i4IhrrKvC4w+jUb14sMNyjEzTOr0DONkCQzbgK9+8BbKYuGiXXD+Aom
         iJzZhvniayMx5de3s22t6ZyFplh3tR5zb+VEVSKx8hd7VlKyuAFiK+05SA5+wOwbH3KR
         8+01y4WGIUcgwBDY+K5Xek0IFb2Ih32teGQ3smyx6oF2EKVhxectETtW9wNRfLuR53Jo
         wUnYUQyU6/kcrUMZYTwYR5LoTFkyk54tbOoCOzlPzm9a/gZmFWawqN2VXML4AFDfUxJp
         JQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793281483; x=1793886283;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r9Yjn03pj845I6dvouQuyeLdqWNVyS+hRwAp++oHECs=;
        b=yaW76iBDzrHfOJAQKNFGACon8eSQlnN2YojO3PAl2wPD689TP6X/a0DzEQlPJ4953z
         gulJyXJRogxhmWWY6eYeSdmBzyIb+En3Zd2rqtUMe4pLLNF6kqgC2QjLaS4czoNLTxJ0
         Jvypktt8OGMpAJCAaySjaTSjlHcjD8U8zzjB6HXk+6+TagJaw/V95gdFC67VLU3Y1ygl
         gPINEG8doykjjVjJC/kYsiXUpDBdqydLs+Yf4JC5/y8QvOoTOuINGL6WjZk7w6zEOKtn
         1mrAo3fqZ9y52Kb1q5HvYbJY1Zjl/Uvg10EOXhf8q8ARRLgmvsdPilex/oAFWM0VqGkX
         +53g==
X-Forwarded-Encrypted: i=1; AKwUvBwNchyy029BhZZZtM23l12LibWFOlW6JXO+g3aXhmrAan2+Cl64TcKgvjYUzFYzFOJ3hrdiIJD4zLtkgJPV3o7STcM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuAGq5L752GuhAnnXXhv0u0wuuV47qBEmuhaSd+SsgiSwj5+JB
	+jw7T2zkC7echOFvL4jQnY8IgCG+O59LITN9JgNknKdYh5fHhtZUU5ojrxH7eFbk+LA=
X-Gm-Gg: AYBFou3M3OEquKLLamDie+ON5kuBPObosVQXcaOgP8BbWRZLqHCKSGhrxHzYcux6R3/
	wr2tMLS9MiAZtUYbfPhdrlXNnoFmk4+2bcoZfMT5O4a09l6Ymv31n64hYbuBS9dXSJrqwSTHysY
	Dc1ch3BZA+Jx5ozSIp6WMRdKOQvE2u94e5BCF6ILs8nsOHS8troUzwQBejdKwhtvzAF4U2hLylE
	+t1iyHM5oKTgL67yz56gooWmseW8RKWKSmoMQKN/43MNRk01HJzEXDfcyir4l81/L5mN1KIkcpj
	ROGlOL7ErXjIXOPlHpGih8D6biyEVmxLii+pZZu281YiNhm9gStI8uFPt7MThwaZr7MiuZ/xhbt
	+diXx131OlJBoG9yXRqgRpQRC/0tmsuvDvZA6CuTNC7HlIXzQ8O8ev4CY/+ajuIRf5erJg9Otrm
	EgLaT2lXfyHj/jzU+X/UCJ1qQKaYrmIv39WrDZVc9TNM0W4dg6UzQahKXI5mYmmICBHmdNHYvBh
	iWcGCYHc12Z1Ah1NEVg/rDg4kmh7icW4C1KOuUhkpku2zf8wjYmGIZMYoz/1B845xEeRIItHcjb
	bjegu1Z6Z26DlL3rH1Bnz0oYgQYvakiYYRycoiVRni1+Y8UkDVbNZOzNXHBjSxy2FFpQPwnOXSf
	9pJ8OOd+gokpO
X-Received: by 2002:a05:693c:41d7:10b0:356:b370:a0ee with SMTP id 5a478bee46e88-36a2044d2a0mr7712963eec.20.1793281483283;
        Thu, 29 Oct 2026 06:44:43 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2390929asm21976894eec.12.2026.10.29.06.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:44:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, Kunhai Dai <daikunhai@didiglobal.com>
Cc: josef@toxicpanda.com, yukuai@fygo.io, cui.tao@linux.dev, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261019125412.3123895-1-daikunhai@didiglobal.com>
References: <20261019125412.3123895-1-daikunhai@didiglobal.com>
Subject: Re: [PATCH v2 0/2] blk-iocost: fix hweight cache publication and
 donation fail-safe
Message-Id: <179328148122.1447413.1375912231299331612.b4-ty@b4>
Date: Thu, 29 Oct 2026 07:44:41 -0600
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 19 Oct 2026 08:54:10 -0400, Kunhai Dai wrote:
> This series fixes the blk-iocost hweight cache publication race and adds a
> fail-safe for invalid donation weights.
> 
> Previous version:
>   https://lists.openwall.net/linux-kernel/2026/10/15/1954
> Replies:
>   https://lists.openwall.net/linux-kernel/2026/10/16/1431
>   https://lists.openwall.net/linux-kernel/2026/10/16/2798
> 
> [...]

Applied, thanks!

[1/2] blk-iocost: abort weight transfer on invalid donation weights
      commit: c810ee88cdab27f443c32270dc7c0eaad2cca3f8
[2/2] blk-iocost: publish hweights as one atomic value
      commit: 0150554a3f38e1850d5964102eb89a720c5fe789

Best regards,
-- 
Jens Axboe



