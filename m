Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BAB2E1F00;
	Wed,  3 Sep 2025 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886331; cv=none; b=AEhoSy/uTi1UlZvSiKAUPdoVuTQu+Nle8m45W+FIuBDtuvJzJHoTI8sh809CUb6sJE8CMxeO/df2oVYAWG4NAKZEnu6wLXXrqE2j1DpjsImn8y4ULDjZbjowy9ZcjXr7pIwuVqlK1HGlkzUBGwJaBPzjktxW44UCXcVngsGoRrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886331; c=relaxed/simple;
	bh=9M40q4YTpAKUWWKOZk3yBp2AmAuBG+AtGIsqw9nrZb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7ywnJcXQ6k2ygvoxECrp39WBltFL1wAyWUwS6VPbjwdOJRTAkJzBM2VKSeoGTF6X58fAzWB8Ov7HpTZAArdun09d9/plDrkLn73k6a0DFnyiRTVtsNSyv5P36i6/R+snAvcxI6qyqTFGmEGbDfIYx2DBGxQ1c62nVZq6rNATKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWWKC4RN; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWWKC4RN"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-723ae0bb4e4so15505227b3.1;
        Wed, 03 Sep 2025 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756886329; x=1757491129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yhAVnScp5EkAabs+130F6qkoMdoZHl96tw+d3Qg0Q1c=;
        b=jWWKC4RNg6pAg+iElWooEo5fw4BYP4jDH/V9MK6dTv9jkm83mNT38ZkXYsCm6nNJkp
         zeWr4zbD3iXgkUIqyGwqYm7a2fax9I3UBEGtzl34Gyvc/QvbYI229B3TeT8GzWBBGdvO
         q0u2AckBJdbQ/QKCx5pZ5NZuPGmDOgfx69ZPHA3p11gIT+oGYNx1sf+buHwcsTqySn/f
         PMTJbTjY9y8cv70TKRhmG6O6LnM0BVATevQHtmREOAqKfwN+mZLEY1aV5sOZh8P9dvxe
         h++38DoZrpteoRWxuxJi5Ija0sNJ+kBrtCDfsqF+YUKVz5qkEXUAkLLWWkccGON07G7S
         aGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756886329; x=1757491129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhAVnScp5EkAabs+130F6qkoMdoZHl96tw+d3Qg0Q1c=;
        b=g0pMf2BpS5GxARGRxssH/YFJvkCVz8N9mz4GP0NIbfffpFRWFGCRJLGswln7uajkzz
         fNqBQYAY08eSplKs+xNtsFMpjS/5iqOY4k94XIZdsB6+80C51WZBlFbgqjTRNLbKJu5D
         C+lnFT74EfgTX83KJqlUJ0jhru3QGmQ0IYNCEmOgliz7q6xbXuc/rFMB7vX7MKOu4mPq
         5B9yKAutqa88vU6lrOysjZLsADiknITj1hO46Vz8D1CQuK7lk4ShRZWkokUQhkhDDeCn
         0JSNQC44hFGnQjvK7cKJZReQEYWSDCFkq7KG2Ob4NMaDGjl9Gbk01Aij2QTL0ajCyhS/
         CoIw==
X-Forwarded-Encrypted: i=1; AJvYcCWjmCOr+rMcmYdUuS6Kk8+NplOyGRCi5hF0xP7mXvz9hzbWqYIm6K3pnHOOjbnItIh9O+HqxFWUhQOHu5A=@vger.kernel.org, AJvYcCXKt2R6zh5+K+5PcatDUWE2glcvDwgIRYZ4oE345gwv2F/Yt5761Ky1oJ4JsAHuy0boAKnzFVst+d3Zbzp08N0o7jQc@vger.kernel.org
X-Gm-Message-State: AOJu0YwrcMeZ1uQmwc2ZvQChW8cETvqil/0NJMHzuXhPjA8qM9jL0K89
	o3dmHFh3CvaKmKkyCPhomfHOcAjOUwYKzhYbwZYKEUN+5l/qQAHssSQuhopGX5UGjgw1Bg==
X-Gm-Gg: ASbGncsOX5V9Ctwa3daEzpKQJZ0EjPUGslmpTpnrxMuBRURxB9WHc44BhIMktJVhzlX
	M3UVck9TpQk3HK/2OnB76xtF/JPlyCp8mUMXBEliMiCrH/z+3e4FkvIDZ5EF4X10UGvHn+d0NDZ
	F8TdLjBduawfHwsBcdkcJ0tJ7EIGD3mkEyR4wv0FePoBDbbwDe7cX1h/Dd1vaEQuu3Wo/4ghS3l
	JGxoaUJ4PKv/ZA6pLfiwgNHDXAulGKb05aF0Lz8LsIRox9Ok6nb32lTpbo9WmyiaEAPe0CKaiS4
	Fctt2TEzrstnfGMmJsG6jx6Yjs6obIiKpZR/+FBVep5tBl7Gmmflzc7LRu5uTjZW5KpQfMOLMBb
	O4JmUCnL6w2R3MU6957kUAGz+1blQdw==
X-Google-Smtp-Source: AGHT+IEx4yv1FTXUxNGpW0sEZ9ARp8JFX0NW96PCFD5SvnuIG7mMycDbU9MFc55AdRFLd4MlHcYEOA==
X-Received: by 2002:a05:690c:688b:b0:722:6a42:5cab with SMTP id 00721157ae682-7227635cb7cmr150931017b3.3.1756886328733;
        Wed, 03 Sep 2025 00:58:48 -0700 (PDT)
Received: from [127.0.0.1] ([2a12:a301:1000::20f3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8510229sm11638517b3.37.2025.09.03.00.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 00:58:48 -0700 (PDT)
Message-ID: <5a6dde06-11ee-4ce7-9cb5-f0b8096e42ed@gmail.com>
Date: Wed, 3 Sep 2025 15:58:44 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/13] x86/HWBP: Add arch_reinstall_hw_breakpoint()
 for atomic updates
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: akpm@linux-foundation.org, naveen@kernel.org, davem@davemloft.net,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
 <20250818122720.434981-2-wangjinchao600@gmail.com>
 <20250818122720.434981-3-wangjinchao600@gmail.com>
 <20250901160602.e25f0107e7b0ef4af1078fb7@kernel.org>
 <284d5eef-447f-4e12-a121-3742d708c96f@gmail.com>
 <20250902231152.442041a74774d888cec39201@kernel.org>
Content-Language: en-US
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <20250902231152.442041a74774d888cec39201@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 22:11, Masami Hiramatsu (Google) wrote:
> On Mon, 1 Sep 2025 18:23:44 +0800
> Jinchao Wang <wangjinchao600@gmail.com> wrote:
> 
>> On 9/1/25 15:06, Masami Hiramatsu (Google) wrote:
>>> Hi Jinchao,
>>>
>> Hi Masami,
>>
>>> On Mon, 18 Aug 2025 20:26:07 +0800
>>> Jinchao Wang <wangjinchao600@gmail.com> wrote:
>>>
>>>> Add arch_reinstall_hw_breakpoint() to enable atomic context modification
>>>> of hardware breakpoint parameters without deallocating and reallocating
>>>> the breakpoint slot.
>>>>
>>>> The existing arch_install_hw_breakpoint() allocates a new debug register
>>>> slot, while arch_uninstall_hw_breakpoint() deallocates it. However, some
>>>> use cases require modifying breakpoint parameters (address, length, type)
>>>> atomically without losing the allocated slot, particularly when operating
>>>> in atomic contexts where allocation might fail or be unavailable.
>>>>
>>>> This is particularly useful for debugging tools like kstackwatch that
>>>> need to dynamically update breakpoint targets in atomic contexts while
>>>> maintaining consistent hardware state.
>>>>
>>>
>>> I'm also trying to find this interface for my wprobe. So the idea is good.
>>> But this looks hacky and only for x86. I think the interface should be
>>> more generic and do not use this arch internal function directly.
>>>
>>
>> I agree with your point about the architectural dependency. I have been
>> considering this problem not only for the hardware breakpoint
>> reinstallation,
>> but also for other related parts of the series, such as canary finding and
>> stack address resolving. These parts also rely on arch-specific code.
> 
> Yes, even though, the hw-breakpoint is an independent feature.
> Directly using arch_*() functions (which are expected to be used
> internally) introduces a hidden dependency between these two
> components and looses maintainability.

Yes, I am trying to improve this in the v3 series.

> 
>>> It seems that the slot is allocated by "type", thus, if this reinstall
>>> hwbp without deallocate/allocate slot, it must NOT change the type.
>>> See __modify_bp_slot. Also, provide CONFIG_HAVE_... option for checking
>>> whether the architecture support that interface.
>>>
>> Regarding the slot allocation, I would like to clarify my point. I
>> believe the
>> event->attr.type should not be changed when reinstalling a hardware
>> breakpoint, as this defines the fundamental nature of the event. The type
>> must always be PERF_TYPE_BREAKPOINT.
>>
>> The event->attr.bp_type, however, can be changed. For example, from a
>> HW_BREAKPOINT_W to a HW_BREAKPOINT_RW without needing to deallocate and
>> reallocate the slot. This is useful for future applications, even though the
>> current use case for KStackWatch only requires HW_BREAKPOINT_W.
> 
> I understand your point, so it also needs another wrapper which checks
> the type is compatible on the architecture.
> 

I think the wrapper should handle the type by type_slot, something like[1]:

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 1db2c5e24d0e..6fed9521baf2 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -752,6 +752,7 @@ modify_user_hw_breakpoint_check(struct perf_event 
*bp, struct perf_event_attr *a
  {
  	struct arch_hw_breakpoint hw = { };
  	int err;
+	enum bp_type_idx old_type_idx, new_type_idx;

  	err = hw_breakpoint_parse(bp, attr, &hw);
  	if (err)
@@ -766,7 +767,9 @@ modify_user_hw_breakpoint_check(struct perf_event 
*bp, struct perf_event_attr *a
  			return -EINVAL;
  	}

-	if (bp->attr.bp_type != attr->bp_type) {
+	old_type_idx = find_slot_idx(bp->attr.bp_type);
+	new_type_idx = find_slot_idx(attr->bp_type);
+	if (old_type_idx != new_type_idx) {
  		err = modify_bp_slot(bp, bp->attr.bp_type, attr->bp_type);
  		if (err)
  			return err;

For kernel breakpoints, we might also consider introducing a
modify_kernel_hw_breakpoint() helper, similar to
modify_user_hw_breakpoint(), to encapsulate the kernel-specific case.

[1]https://lore.kernel.org/all/20250903075144.3722848-3-wangjinchao600@gmail.com/

>>
>> By the way, I have sent an updated series.
>> https://lore.kernel.org/all/20250828073311.1116593-1-wangjinchao600@gmail.com/
> 
> Yeah, OK, let me review the series. Thanks for update!
> 
>>
>> Thank you again for your valuable review.
>> -- 
>> Best regards,
>> Jinchao
> 
> 


-- 
Best regards,
Jinchao
