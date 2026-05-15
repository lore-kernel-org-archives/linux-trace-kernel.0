Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B2317144
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855158; cv=none; b=rqImpwjXIZl2co832lmad0ZvJjVBiXEavNqxFPF5BqSC3fTwV4koPYIMeJ+/sU2EGhQP2Yglau1TX+BZDX+qF3D2PL8VHRZXOR/nUlqBlWiArkzCRdNhGQvgzhn41u66kqfiZtW85YTIA+TwgOOkjZld6O2DeqHMrNKK3KxsI9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855158; c=relaxed/simple;
	bh=29Y0wYJExC+tDsgdL+FXy2jussQ8NgPmHuSQLuRlfwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDz24ml0/tvl+KhV4h5I5+bvXlZLAGljkyw1WZcTfeM5/SpfGhGj5WtbhH3wT32jA96DsPjhMRIwOgzWMuHCj/u6E+MGGUno/l3UG3GI6wZWZcVggkCto7Kx50KdMKnTQ1f7OTxO046ecMUD29c+HFLkzp2gsehBAJ3anNMKVkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=oedLu+mL; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="oedLu+mL"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-47c941f6bdcso6098101b6e.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 07:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778855156; x=1779459956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBE4jEe0xrfGICHOnYQSGqa6swCPVXLwhT/By4Uo0xc=;
        b=oedLu+mL9oixPVHBywotKYkDIA3fwAIOlJYFKud0RTZtJ/a/9qOzhciZe9xVN6djIS
         XlkLQKxf9QkMQByiin1ehq/wDJkZ5SARcrQzyWqaWvcr3riDM//T2mUzcAgGqb8TX2WZ
         PAh4Dbb1W+Z2JR6GmKH1MbPVZdtioktDeavHvQW4q4gXInBAxdTUxuvIJOGZZMizKyVQ
         yqszOE97IFDaXuEwJwTMNtDAbh7GjkQa9DFTI+m3NPQJPbURLwwUGfQ8sMyZlJkzcpLK
         uOQt/L192+OuuvNYtBlfJcDA/yxtKEmn3e8rvJXfoKkJcxPmPSF/a0MpSZ6HR/pl8P+s
         3sNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778855156; x=1779459956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBE4jEe0xrfGICHOnYQSGqa6swCPVXLwhT/By4Uo0xc=;
        b=h+X1NUvXMcWymmR1+qcf4v7uiKtuS8CrZJa4DFQGftzkYFOSe2PoxG3rc6HO5zAbO0
         miUxN8NVQvGP8g8/CpEw1DwUqAd85T6/LIrRefJcfXP5Gl/JObzaQ0SbJ/6liLVZXXDm
         r3pE0h/OsfJPci1y8Co0PSJbQJH4QKKduBba6ftBYKIHJrMxwXRv3QZSs3SADIrvUh1q
         dpMNfGY6TLC3ejpaCb5AfePyn5hI9CD9VfBHzxKr8lWKD87g2HoA7mhmcGduZWoWWuUu
         28JsSdag3O9S8okEhVZV0JciNCpMmaMbYpHuINbOLHM0EGRzP7wM16NhqPiLNJbV7jYB
         a/8Q==
X-Forwarded-Encrypted: i=1; AFNElJ93VmlJJ1Xp6kt+5RDfEF9DF/wqrqFs0eF2bEyaE8Rbglrwkx5zQlhxEz2Izh9CEZfLkIPIp5U7nP2SQkVF7WZi55k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5R24GF8WVlfyo0eTpwKyLdP6mk3rA/aqJCAq16y36xIkiC5Y
	fjd/i01uC/4Q+2fhGv6cHxWA7lQMtG61pxhi03hLd/0ecrw/lUuLft1gRDDu0XRTiSM=
X-Gm-Gg: Acq92OE8226tTr7AtaefRYYNeOF2/E/I3BxUBC9/0lXYEi2OCdkBc4ADO3zOCSVKVNE
	X6Y2mZdE+DVCT7DqCLiQ12cpu/eQotpscnH3Ehsb+6/X46tc+I3EMRUpwCLTn0kcPZ5vcIwutl9
	m3PnRZRqqxpLiculHa4cUrHKGKO2Augkb4TK57o1n71QAbc7dt/m6FBOVvjAQ7ZnfY8G7aP+b62
	jhrc2FRZuDYfLqshaLibSCcLBEFTDarYLIhcWplP5SKr2Q3QQxDc9E3yB9XzC864otcwWT+Jp9s
	dSitOs4Ufg6iOQ4xxhSc+YWZTiZPgKqvz6KCEfyqrwnQVCmebjFUMOvVa+2AQyJGzJpRXzIqP1b
	Dtde4K9QXzvrtvevDSX4EwP0bgWiiCOmwxK4ys0id8BRJDPuUYS3Kk4QUWRe/y9t7Ed+cVLC1b/
	GdcNW20GX+SHSDLPa6gYRWJuuUO28utgIu/TEDfFpIi2lSe9hVjfTV66WL3r6BSjhXIr+G+y1/y
	eKiU5FF
X-Received: by 2002:a05:6808:4484:b0:455:f0e4:4f89 with SMTP id 5614622812f47-482e55c5d73mr2438433b6e.3.1778855155629;
        Fri, 15 May 2026 07:25:55 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b507cbesm1404344a34.0.2026.05.15.07.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 07:25:53 -0700 (PDT)
Message-ID: <e6e5d079-25f2-419c-a992-5651ecae26bb@kernel.dk>
Date: Fri, 15 May 2026 08:25:52 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] io_uring: Use trace_call__##name() at guarded
 tracepoint call sites
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, io-uring@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <20260515135903.2238731-1-vineeth@bitbyteword.org>
 <20260515100448.715589f6@gandalf.local.home>
 <49e77605-6227-426e-8103-329474bf88f9@kernel.dk>
 <CAO7JXPg+MJXF8smC9qXs93YziJT_amQwWKVW38L7F5XdS9-SaA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAO7JXPg+MJXF8smC9qXs93YziJT_amQwWKVW38L7F5XdS9-SaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/26 8:14 AM, Vineeth Remanan Pillai wrote:
> Thanks Jen :-). I can probably send a follow-up email directly to the
> maintainers to prune this part, similar to what Jen did. I guess one
> more version might feel like spam.

Jens...

-- 
Jens Axboe
