Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6E413959D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711642; cv=none; b=BfnUW19z+I3QkpO5IzipjIOekovHBq/h9HvDrttlQ3zQq8PjUSnOImgWLBq4ZhRZIT0HnJIMPnPznH4OXGn4IMgjg74CdC/G7LcDLbURUYQpHxU84fRn1ARrtP7qj47q9F0pbM2gkoy3dEfeCWqG69vgvc5p3UiZhIKyJlDedrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711642; c=relaxed/simple;
	bh=A52a0n6mXX/vpDsPDw1aYNuXCv9EMo1cdZdHaWNhQXE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oqBd+DylPmpn1b4bJqJ75aVP330ru6nbDxx0DtbKflkvP0SVpKjuwDWf1QRwFImVd14LyzZ6iJAEcYWxUG/qZFte5tbaJ4Qk/7zuJ8qFRkuSCl+jGjv1vGh7NrzLyIJ9pnElm0mfY5u7UKYG1vF0UmAnwgOifsh/K74/w6FKaso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEOJNTjf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEOJNTjf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769711640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1KTQVsHamBVnOnmhCi9myxR4ebuO1ZMb0FARjaKcqs=;
	b=cEOJNTjfEVBiTzTPF4YUBlUGSjMHxd12eBQW9bLJW1Zd8BjdTRWPkxTXbUdwk87NMXqRGw
	AqebLern3UihMOYDPdcuBeZSzM0sSNBdKK7DDcDL7GztZspv8/kb7mP7wPXKIb//9ydffJ
	7dYhyqgzz5Fts+V/OKYdVi8EcdGQhMk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-5ztSFEblNa21f99S2sQKIw-1; Thu, 29 Jan 2026 13:33:59 -0500
X-MC-Unique: 5ztSFEblNa21f99S2sQKIw-1
X-Mimecast-MFC-AGG-ID: 5ztSFEblNa21f99S2sQKIw_1769711638
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-894727de401so45450986d6.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 10:33:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769711638; x=1770316438;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1KTQVsHamBVnOnmhCi9myxR4ebuO1ZMb0FARjaKcqs=;
        b=X0Mfkb5FBG4TzgAS8rVsv8IktwHxFulJC+RHdbLBw92W2aKaK0etpynlhV6cPKAswh
         Z3dbSaQf2fJaAgQvs9buTL7gCMtC8coF/8zHMO1yf+Pyt22k+tpDbRyswZSj75OwVw0u
         gXp4LKF8OTA56Oj0QJlZIramIN0FRdLAIKXJ02rsxJNmB123IxprTZzbeq/SGvahV3iK
         KV7aic7S3PZvx74zsa3oY6HvubGslOEQtiqzVHanrLSvhXQEmBPNhB72PPyfCQrw0Scj
         o8QQhZdVA5jflLWIbnqGUDQlGm5AqPt2kH3DOwA/35+pLQgLDm4cUX8sPs1Ev1eyURX7
         oJvA==
X-Forwarded-Encrypted: i=1; AJvYcCX3TYXswXU53R5QYox61ZTHA1XhDQjoMZsieCVY+1/esfUWrgMe3FpcFbR+DrR26iB/bjlJKiRv1YAC16hRi2NdazA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGb4yVNfl1F1ZxljQXNr22vwLilrCCd132mkWu7d5lm1ghqmyQ
	ytiX7jiZsCk0BvM2ZREmk1/9bKi1g2gVlz5PBJCEj3snr+ypddFAHLKTVCX5iVJly0PLvmT5Jyw
	F4zLL1ImTvFNXLrpEdAt8ta3b4FXJb07KVqMPsTU5Ls5y9C2cb6l5lXOmrMCVAe93w+WUUjrPIA
	==
X-Gm-Gg: AZuq6aLi15ptlDYS2pStKytUzWkouswa/I0mnf8Vcrj3hD1LXmNeLhEJ5iYdFInGt3W
	ZigmUzUZZWJ4a6uXZqos88NkSW8v5wY6p1xhx5OsyXU9dt5f4rJwfcP8raTG1FpFps9va+F7siU
	F1qSduwT9GyWa2PlBWf1eF+VsRuYpH8Ba0BOPgKSPCYbveumcFN3gzhDR/o9eOE8FdS9n3DVVmj
	Blz31xx3ONXTOOwn99djU/NO8rSuvixEohQwL3gQzrL/g9dl/xofhmbFlupw7/RHtdVYS6e6MRE
	W+mmo+gcKAwNKuv4Jo/iWcNVvj/G4ONZCuX5jnVcIexOxU2fun4znLcyQvNbQ/100pkwq06/UFl
	9esMoagfgo+P1e+elRCsji684+5GWvjGD13me+BDrPeDbdkAMwcvzbmVD
X-Received: by 2002:a05:6214:1304:b0:894:74cf:d2fe with SMTP id 6a1803df08f44-894ea8c1941mr2388066d6.1.1769711638492;
        Thu, 29 Jan 2026 10:33:58 -0800 (PST)
X-Received: by 2002:a05:6214:1304:b0:894:74cf:d2fe with SMTP id 6a1803df08f44-894ea8c1941mr2387736d6.1.1769711638134;
        Thu, 29 Jan 2026 10:33:58 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375ce71sm42775696d6.45.2026.01.29.10.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 10:33:57 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6fc1fb93-7010-4381-a9a9-68a9b81acf88@redhat.com>
Date: Thu, 29 Jan 2026 13:33:56 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: increase maximum subsystem count from 16 to
 32
To: Chen Ridong <chenridong@huaweicloud.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, inwardvessel@gmail.com,
 shakeel.butt@linux.dev, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20260129063133.209874-1-chenridong@huaweicloud.com>
 <asryf3kk6c337l33faqpeznk7d4a3rxblzmqrawxffq7sfbaf7@5yfzzdroltjq>
 <3a12eb16-3a91-4278-9dfd-6c6f424e7f9f@huaweicloud.com>
In-Reply-To: <3a12eb16-3a91-4278-9dfd-6c6f424e7f9f@huaweicloud.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1Afl36A1NejCIPc2MbPqZg5pLV3SHVRjYBv7SsZrsns_1769711638
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/29/26 4:51 AM, Chen Ridong wrote:
>
> On 2026/1/29 17:23, Michal Koutný wrote:
>> On Thu, Jan 29, 2026 at 06:31:33AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> The current cgroup subsystem limit of 16 is insufficient, as the number of
>>> subsystems has already reached this maximum.
>> Indeed. But some of them are legacy (and some novel). Do you really need
>> one kernel image with every subsys config enabled?
>>
> We compiled with 'make allmodconfig'.
>
>>> Attempting to add new subsystems beyond this limit results in boot
>>> failures.
>> That sounds like BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16) doesn't trigger
>> during build for you. Is the macro broken?
>>
> The BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16) macro worked correctly. However, I
> only modified the code to allow compilation to pass, and the system subsequently
> failed to boot.
>
>>> This patch increases the maximum number of supported cgroup subsystems from
>>> 16 to 32, providing adequate headroom for future subsystem additions.
>> It may be needed one day but I'd suggest binding this change with
>> introduction of actual new controller.
>> (As we have some CONFIG_*_V1 options that default to N, I'm thinking
>> about switching config's default to N as well (like:
>> CONFIG_CGROUP_CPUACCT CONFIG_CGROUP_DEVICE CONFIG_CGROUP_FREEZER
>> CONFIG_CGROUP_DEBGU), arch/x86/configs/x86_64_defconfig is not exactly
>> pinnacle of freshness :-/)
>>
>>
> Can I propose increasing the maximum number now? If we switch certain configs to
> default N and then a new subsystem is added later, the default configuration may
> work fine, but it will become a problem under allmodconfig — which some users
> actually rely on.
>
> Besides, this shouldn't be a major change, right?

Yes, I agreed that it is not a major change. I count the number of 
SUBSYS() in include/linux/cgroup_subsys.h and there are exactly 16 of 
them. So introduction of a new cgroup subsystem will break the current 
limit. I remember that there was talk about adding scheduling cgroup on 
the GPU side. One day, a new cgroup subsystem may be added without the 
awareness that the subsystem limit has to be extended causing issue down 
the line. So I support the idea of extending it now so that there is one 
less thing to worry about when a new cgroup subsystem is added in the 
future.

Acked-by: Waiman Long <longman@redhat.com>

