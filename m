Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF461CFBA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Apr 2026 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776456973; cv=none; b=Btq74kSJAFHJLYCaRf0pMenQNj0kH7KbQzp1JfAPvCn/ewAkCu/mPnFF8qV6jKYrvl+h6Onq4uuzcmc5KO9ztyO1vgxuID+jSUbLIznll2KeyO7oNOyq0bMtKZiCdK7mTnQV1TIFWnKSOZflHcW6zD7mGD+4Kf6eXwQsLdaFkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776456973; c=relaxed/simple;
	bh=9/uDzK/SOjXU4mSKbw3OpUSLDaawOW13d96k/jF0MlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRltKoKlDnS+RfPNe48YGFXWZIDP4BTRq843d7VmyW/bPjm2iwHDZ81Zl7H+4B544ur9gMQdEcKUnUBc2IpXCaJ68Va4W7g6sgggTRzGuo0QWnaMbRKrHZlaLHpLncFzeo7jrt0lTcC4bUuuOa+hLhFEwrjQgAOhymSW4kZYtH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=WELJL46R; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="WELJL46R"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d9b21d1461so1177083a34.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Apr 2026 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776456970; x=1777061770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wR3h0fB21v1lOefDO4Gu/l+DJ7H1n/CMTlqrzlhma9Q=;
        b=WELJL46RrO9LlTrUNQ66XMpOWld5QRqd3+dYXXxJbXki/5SR9UD8fDTVs+3oufhsnw
         PHh+ofmYpTZxiNNLakant3qhYHfbJkbGvUocOhQa9MKavH6f3EmNaIpXXboPV8ckps9W
         G0p1RCyZUaKvxwDsvWgxf0Ej5RCjpCN2aeibdku34bqSrg1OiowO0BeFGqigeGSKcqsh
         v91Ebq8OMfi01+hxftCmUtNP3v2sQ76G+lIVJqlp65WKYlH+7AN5d8PKTOpHbcqOwWZ5
         2TnX5Q9tBijI1SIX6bxK0EL0Jw3mW7rcomR4azc4TxL9X/Z/61jzwf6wtMPnTdm8He//
         waaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776456970; x=1777061770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wR3h0fB21v1lOefDO4Gu/l+DJ7H1n/CMTlqrzlhma9Q=;
        b=MVRrkAe5LBJchzD4xn7AY01Fml0oEFmuw4ukOKEV1v/t70e+ciGfcradCWLbUenxz8
         XhFoDNNB6NHhezP3e7yqtUpa7J4rNzohw9PudGQT6yl53OphxaNMaPHuZR0udc7Efvt1
         j3R8bGM5JXbkwKRLxG4MSvGqORS0UAThbKR18j7S3s/xrWx7OKvzB2kifYTokL+y3gQm
         7EUEWq3weCX25CKZ+sR6IouyQtwYJ0CaC9O2p5DKoWU2Y7bWhWLdtnEynJ7JY5dw5UGZ
         Mev6KL5HWlCqqzma4di4Sq52qvmYBK1nmIrOmAU5NmL/TDEvoeLWJkbARpGi/wDC9SAH
         tPIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LgOHu8cqHUvs/a8YVRtVUXoBpzyvIDVhJmB6h6oyeCthUzqgOh8l4B2LJiDaddYqjlLlZZUguJf1TUmrXlzMNsQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9AUM9A3kCUOIKwuXw+lpUuVJ28NpOam4ikmZbb4MBZrgCzTb6
	yCrAq/NnC7DVRWG7pRa1+zWsows/8tefCr89B+n7jL4fhH8gFBhqZtwrjklmYWkHuGw=
X-Gm-Gg: AeBDies69VFnbGMcwVoFC+OoiHj2EHES8Crw4wjWmmAllxGovqon0zy9pd+BvvOkcW2
	kSLFuS/EYTg78x8pKz51kkNgO8zs4K520+m/bigKvOu3xyuIA+C4qNxJe7Tb3bX8uX/w3n3aeri
	hrTGpHC/TuRwxHo4RCam1RaU6LgVZaSNSLvKhiGl7RsnsqoYIyj38IWR7C9c69+yTKK6F0fW2mu
	ZO4yVA6bFYxGMVOJSxn8kMz1kipimQokh4r+CoSTCTl/wycApGFudyPX4r09Mk7ZnhDbSp4yA6f
	NKDumFT046TUkHntIw2IyQGNTzloQJbdj/IOvKBrNYAYTz+YSaHbzcNrn99yDucY1zjZwtMAeJj
	XWgn2BLSIRX0DNL+rIFOxcml8b1oR7DBKlAUMUjRLlRrCwfEOW/lfhtsEHgli05Embtl26RuDP7
	zVitSJ2jqhEcsB1LtA3GspDf2Y2N8iLlADO+gJd3WXJOAUmogwX9udTDG55ep1/R1t2cAa/PB3G
	csoMJN73S+EoBDjPfjx
X-Received: by 2002:a05:6830:668e:b0:7d9:d3f9:a82f with SMTP id 46e09a7af769-7dc955cf42amr2480101a34.10.1776456969837;
        Fri, 17 Apr 2026 13:16:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc99425167sm1585605a34.16.2026.04.17.13.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 13:16:09 -0700 (PDT)
Message-ID: <424110a4-4e14-4e40-af0d-59ca7a30d904@kernel.dk>
Date: Fri, 17 Apr 2026 14:16:07 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] blk-mq: expose tag starvation counts via debugfs
To: Bart Van Assche <bvanassche@acm.org>, Aaron Tomlin <atomlin@atomlin.com>,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: johannes.thumshirn@wdc.com, kch@nvidia.com, dlemoal@kernel.org,
 ritesh.list@gmail.com, loberman@redhat.com, neelx@suse.com, sean@ashe.io,
 mproche@gmail.com, chjohnst@gmail.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260319221956.332770-1-atomlin@atomlin.com>
 <20260319221956.332770-3-atomlin@atomlin.com>
 <ac8d9fd1-15c6-44cf-ba5a-85bd4aefce9b@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ac8d9fd1-15c6-44cf-ba5a-85bd4aefce9b@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/26 12:28 PM, Bart Van Assche wrote:
> On 3/19/26 3:19 PM, Aaron Tomlin wrote:
>> To guarantee zero performance overhead for production kernels compiled
>> without debugfs, the underlying atomic_t variables and their associated
>> increment routines are strictly guarded behind CONFIG_BLK_DEBUG_FS.
>> When this configuration is disabled, the tracking logic compiles down
>> to a safe no-op.
> 
> I don't think that's sufficient. Please use per-cpu counters to
> minimize the overhead for kernels in which debugfs is enabled.

Agree, this is the usual nonsense of thinking you can hide any overhead
behind a config option, when in practice production kernels very much DO
have CONFIG_DEBUGFS enabled.

-- 
Jens Axboe
