Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAA983CDB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712889; cv=none; b=iyDSEvF0aa+S8v0oBkuyG8r6ynK8lPfKNOP9RVRVcYl/iGhKALyheOFh4Fk1C+9U0c6N8MQ1Unw7sNdblFLc/q7dqyybX6b/C7/SzTlc3CSoZSQc3nacYg4IQkITKYpNHy66njNpBY/b17olddItQ0+aAI54rbC4GENg3+K33Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712889; c=relaxed/simple;
	bh=lDjFKNdSjktCWTnrP36guAx2KyT01h+vfaOsmV3kEqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R51k6XL/aPjI8BE5hyWKpWAJ4FuUbozOobLR6mTCkCXTwR9/n1jQn72FSWhSNG9lFX8GD+8u182Rp9v5l6hhHeoH9l1uZ7CEunq1WHexSlr3t5ugJMe1sZXan9tB4EQtvMUJtHk7zms02O4lrq9JPCvq50WAHu7LsgMWFNOwWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w008ksq8; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w008ksq8"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so28987339f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706712886; x=1707317686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHJQ/aG4p3T91agak0V8di4mytjOgAxT9qUMt5eIZHo=;
        b=w008ksq895OnsRl6funjwLly+BnNzUOIoJsAy7glokT5xdh9WiC3HiXLq/4NWrWJM3
         ajl/+QHmEzoPRFdgxjrK6oy43csOICn6UslNYP2uQnmilQq8jeeAOB5RqPeQs12vOGtm
         00vOD1DyKbgStY7l+2iL5m1XZI6RW/APf9HJwrYalYZu1SnZnSQEqrRxz5rwlKMPcLr3
         NRNItGERLIRHi5acm+L0EhgctJHPzPv57kFgvElKDMuYxQMzLBNZhTWcYI0pnlEeWVgl
         WtzRfuV/E+w0Zo019aoTQDvV+uuwyVHCRVIIRJ4Tn9hG8Lp6TuLFXsa1fsl8t72v+JUM
         Anag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712886; x=1707317686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHJQ/aG4p3T91agak0V8di4mytjOgAxT9qUMt5eIZHo=;
        b=c/nTHzkIvv8G8NTpXWRSFYGvhi9ie1CunmwoUYIlIWeImXpNC++dTkAthn+rfjXbVe
         Xv3uV7mr6MWhGmNc6joWlEblFGzcFHY5gtdU7VEF/+0na1eVA4oxKa1a+NjfAUb2ehcd
         Z9Ts7AMD9fDpJaPW4MJLG4DyLaZvtX7mdfS6RwH7Ji9xL6Zm61yvtKgxLh9lrp0nSTOL
         7E9tzF8gEFk6IViPwzVzLaawEfKDKH22sLCehB3VkxoJ1jupbG6lFXdCefoUYG6tX4PG
         C0CFIepVf6EGwjp0haSdQP89iwf19XjA7yEIgDchrCScp4MpZefJqGX1obj0eWkpnN/1
         ErDQ==
X-Forwarded-Encrypted: i=0; AJvYcCWC8qZw0pYETgI95nDhcBI/islg2dFzIC1cNl04Hvmk2q6IgBfYnwJFdU4/Bm43rY0/idoqcGoYmahqyvyFH0uAIWsteH61PhgoOnKk+mcissn9
X-Gm-Message-State: AOJu0YxA5lG/huym1r1L0CWhxxEtvl5s2NwM86D8ARaF0ewBK581mece
	QGyUC4BW7+qfUfYK6+3+Ebj+SO2bzuIiw55O2mYILSlNYRuBlgos1m9AQZrleps=
X-Google-Smtp-Source: AGHT+IEt1S3q1yxIamRX2NO+jB7ghgLZERhYPZgKQ/bWKhlHRf1N8j4BmbVE/+5xSCORU5L/shVDVA==
X-Received: by 2002:a6b:e211:0:b0:7bc:207d:5178 with SMTP id z17-20020a6be211000000b007bc207d5178mr2105418ioc.2.1706712886384;
        Wed, 31 Jan 2024 06:54:46 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x7-20020a5eda07000000b007bfe7b63a30sm2231455ioj.21.2024.01.31.06.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 06:54:45 -0800 (PST)
Message-ID: <27bf629b-7549-4f15-8d88-cbc2def86df3@kernel.dk>
Date: Wed, 31 Jan 2024 07:54:44 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] trace/blktrace: fix task hung in blk_trace_remove
Content-Language: en-US
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: akpm@linux-foundation.org, dvyukov@google.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, pengfei.xu@intel.com, rostedt@goodmis.org,
 syzkaller-bugs@googlegroups.com
References: <0000000000002b1fc7060fca3adf@google.com>
 <tencent_6D33089EBD1B9C4BEE1B2425C6BAB4BB9F08@qq.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tencent_6D33089EBD1B9C4BEE1B2425C6BAB4BB9F08@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/24 6:28 AM, Edward Adam Davis wrote:
> Delete critical sections that are time-consuming and protected by other mutexes
> to avoid this issue.

What is "this issue"?

-- 
Jens Axboe


