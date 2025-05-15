Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9FA25B66A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 May 2025 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333176; cv=none; b=YT9LTcZ6pcNdf/SadiCaXUBgfkoGbJnbO2Q5oEPKAd1msUlNjf626CSzC11o64gg0AGSS6KbvZU7jomG2DdujWnGQH/sJfQcJKF9foKH3o/UNSjR0FsRYvnMyBJObmRa40FewGrE9R3CBU20nnAutxub6SJQMpiIbDSRbgwTnkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333176; c=relaxed/simple;
	bh=s/QjyZzY/EnfUUvNKb7Q7l8bqIG7rG8gTYAL2oTY5W4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLbKurSazXjp6QBFfsbwp2sDFwhZDZ+L6LDu8LGdzkuKTgBJYvvrFdIc9H7VUfydyDVjBlGSKYzh9WtKA0oWUqggMrdQ97rMyhwf1avqGeZPhQjgASrTFuSpPClcKhuJV/kjHWjP1722uilr8uZl7pCdi7snGOeA3LqgutJVxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kcVrGY0w; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kcVrGY0w"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85dac9728cdso46172639f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 May 2025 11:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747333174; x=1747937974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=96xY6/n/0fhqAkgNUIqk6HeWQCuRjQ3BV7nB9J6drQA=;
        b=kcVrGY0wNLRo1y5Cwo33gWpbq5GjPez55xOZNbREb37HEmycAbB7rVLVpCxbACLB5q
         cgzwssAQwJCD4OvEfySDH5KN0D1R40rE4pde8RnGubvGHUFuZH0lX2tstOEFfazio8M0
         uKrICjXQimEoCY/pxavBVSwdp3jXxct+N5voc71YYvCkv/QmHyQONfGgBd2NZTDxnhYb
         V5Jv81v1nvCxH+tjUShYTI5XgDQAUIZrSsIZsPdNA0eJt3wsAMU+gHy5wJrc0DtRENzN
         ebjFCFOz07QnJss4w6HZ0V7aGAuIhoghl58bRoIPL0rECc97S2WAyG0VryWtXUsF21rq
         ueKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747333174; x=1747937974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96xY6/n/0fhqAkgNUIqk6HeWQCuRjQ3BV7nB9J6drQA=;
        b=qb2+HoKprsWluTCBuqACYINF//VrPgX1nCdeoWZOvzE8ayYe2pzASfcgc3NhQP3dvb
         qNNvlQcGvqhR9cPql/jMQhFBm1AdFuIfdfScQ/EZAB0tN5j1/nEoTftng7U4sDDxeDpb
         5gQApYQbP7VSoSYNTzYzEbCdYcvHoHzbgDjPEA2wmCd3zj6swX2JvcPYQbTaN81Kb4Qp
         g8ebGPqxCGwDGYtcFRzGK0WsXJ8H3VFZnQ6q7KaXcl7dHyVpJPXQ8iPft7zqa8j34DgD
         qmuue16q+NTfKiVNYOUny3LOiwzMYqD4M273tSmtT7FKkzMpqtgg05ydQq0WZKywM0Os
         NBkg==
X-Forwarded-Encrypted: i=1; AJvYcCWEQbQDm7tUuItIM1ibhqgTD9cXHTLknWNE6Fw6H3OP34oQC3wCEO4j6m24mZhoyesEhQJ6pe0eDLNwX03XG65+MYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoslACkKCWkdBtH/cD+Xn86anIqPfw1X981fh+9sFpBNbLwo/S
	4kDMhXMI5u8Lu5mT41ZI0DC7apSp/VfH3RR8B7mEfte36gHzZzLKYLFK8NUhXfWBBXqO6I91AuA
	W6pwj
X-Gm-Gg: ASbGncvSUbZmbtnak7NkicgiqyFufIAyd5mNSDXoHMdGQuWeWiz3JgnGiRy6iBQB1mD
	lhNsJ/xE/aOS8D/J3bvFt22T4V51hio0myjWLKKLuvzfzEHuhk9BToxPoMXKf1am9077i+X4845
	rzDd1Sh11iDAQ95OGZz2vy3HPoVWtALjg+uq0DNvqfznX8wDe8Oz9pl88eXTZh0tpX11PCqJwv9
	EW7+F2HwHtksy/HgkscSAdKWxAuCgilXsfkXcL47WOUDk2K+DHdTtQcLtQ3BydFEBCv2xCq5dqf
	Btvq0kINRcRpo5Wo3bx8hl0U3O3sL73jgnHYbmJ1rthEzTo=
X-Google-Smtp-Source: AGHT+IH5rh3RaD+mXxl/U/ED5r/PqNk+HsLHF/ipKK7WOh4aSk3GsClD76p331wCOo6l3ZpGehK4jQ==
X-Received: by 2002:a05:6602:6a48:b0:85b:3791:b2ed with SMTP id ca18e2360f4ac-86a231c3ee4mr95598639f.8.1747333173762;
        Thu, 15 May 2025 11:19:33 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc4b1715sm30431173.123.2025.05.15.11.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 11:19:33 -0700 (PDT)
Message-ID: <e65279dc-3054-42bc-8365-2065769d5898@kernel.dk>
Date: Thu, 15 May 2025 12:19:32 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] blktrace: use rbuf->stats.full as a drop indicator
 in relayfs
To: Jason Xing <kerneljasonxing@gmail.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>,
 Yushan Zhou <katrinzhou@tencent.com>
References: <20250515061643.31472-1-kerneljasonxing@gmail.com>
 <20250515061643.31472-4-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250515061643.31472-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Looks fine:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
