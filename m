Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C188F77
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 22:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736979378; cv=none; b=cFwps0CuW/UF52ZNEM3qJTXxIyuIHwLWj3ED33cOA0sOuiL9YofTXrEWtO2YSegrEXWJppy65z2HYbBSldalXN3yQLORIx0CD3gMuWg8pjA+lImiwzjurHIVah39bZnueLYZjo7FvncDybei7yLLfkh/sH1Kipt+Xm3evSA2V8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736979378; c=relaxed/simple;
	bh=N67sDbbflcEdW19mQcwY9D4ZCVINMqZZ1+fiq62kp08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRkI6ijl6T+GeCqxJcFRho29xRSNY6ButwzUOaOhLsHTbdbd3umKzviwQWNu70Hz2tra6mCO4EIQJC+q4hI5IUUglu7KQeSE08trCciEJ/U3G6VeJrcxA5c3FEKPs/xBrYzxbVxKD2Z4lWoJMgVZU7yuEQxwutFHgPhFSrxODAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VLdexnc6; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VLdexnc6"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71e3167b90dso161126a34.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 14:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736979375; x=1737584175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=blhd75P5LVSb0RvwWEycm+5Nbmpdu3jhlbsT8ohSXM0=;
        b=VLdexnc6NbvfEjPR0Kt1TjKE9YLSVOBCGOjmSC/YYK+gyiRrMt6aAVF8qzl7mipd6g
         XrfMiC1L73jgzobFOO5pKn39LfMuriYNoIZWbuOClwSFhDNu4lPBQXxJY9Fd5MH/EpdF
         Ucju/ZUiLjSaa9I9jM3MIRKjyZgJHDNw0f3o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736979375; x=1737584175;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blhd75P5LVSb0RvwWEycm+5Nbmpdu3jhlbsT8ohSXM0=;
        b=aGHHzdSn4JjhQhSQwm+9FhnD1iyEyib6kmslz112io00YJ2gAshFLcwNmH5QGPenlZ
         mVxEfRE/hAJdmoMOnqgUgGir3ptr14kBIq/20oaZydi9FuM31s5Pi7D4wCy+rwCPy9Kl
         JmttCcGFyNVoDPYbr6SC7DVQ5aN9UTozs0MuTSC/6qQ8wlWOk2XkEDfHm8scmBR2/w6y
         g8/9NgVEAYdiOLlifNOSuxESuZ6Q+J7XHpyfW2qE29ZLqoslqbK5T45VJPnC6kMYk5+U
         +9R9c7gUyPSTo5kv9XgGf2vyFNu4AVrPqMHYgH/mrC7P5gloDNK1oTF6u+2Kwec5bKVx
         B+IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuzth/0OjieFoutSNb9bZ1vgg/Ys3zAtx/j/VVZVLL92LMp2+Kw6Ot0PL0iMnNKMYv80493XE4rjYFn2J45WobD84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzptBwOXawtKy/mG6mO/Nrw4134pIzX+yvRzo4P8PhLNHexMDf+
	IXPGYbg/FOnvdpODh3SIMSxy1AVsqyNi86EspP1ILawe+PnDNk+nQONkG7gKfQ==
X-Gm-Gg: ASbGnctIz6E7aGYDZpuhbeGNAEM/wuJUVYA39juDEcZ9j0husHRQAWwva7i55tyVllJ
	7qKzGiWwmQqqBRRrTgGO5VSlQR6LdMsxBH7qx3o61XUQtLyXq9DJ9r0SbeksbycVL1S+13IL/r5
	k7b6k4NulVnxpbkmtTb7njpb0tK6AmBP6mGnoomhwfDtVDnJrcSCbDfOufxu+ffJ3X/GVHjqH3g
	jDIFoHDw9PMH1zuXzVy9csBgXELR2vHPV1c0t+7jgNjrXPXMCvDkdBpKRdV12rLsPux32ZTmvxY
	2EgBQvU1E+EV6cpeEVfv
X-Google-Smtp-Source: AGHT+IFcaetuHA6DIkj3kAXjduVbqxIMVKwUIZc/R3JyCmhsKrtvaI0q3aW4I7lonZ63FuS5dMLZKQ==
X-Received: by 2002:a05:6808:1b0b:b0:3eb:5d3a:5b20 with SMTP id 5614622812f47-3ef2ebedb60mr22793347b6e.4.1736979375362;
        Wed, 15 Jan 2025 14:16:15 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f03769a8f8sm5355142b6e.26.2025.01.15.14.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 14:16:13 -0800 (PST)
Message-ID: <ecf3d8db-8533-4b0d-ab49-3543a766fd99@broadcom.com>
Date: Wed, 15 Jan 2025 14:16:11 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swiotlb: Introduce DMA_ATTR_SKIP_DEVICE_SYNC
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
 Justin Chen <justin.chen@broadcom.com>, Jonathan Corbet <corbet@lwn.net>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Petr Tesarik <petr@tesarici.cz>, Michael Kelley <mhklinux@outlook.com>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Eder Zulian <ezulian@redhat.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <20250115194659.618438-1-florian.fainelli@broadcom.com>
 <9582878b-1ce7-4fc4-9b45-b72bba722f49@arm.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <9582878b-1ce7-4fc4-9b45-b72bba722f49@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/15/25 12:12, Robin Murphy wrote:
> On 2025-01-15 7:46 pm, Florian Fainelli wrote:
>> From: Justin Chen <justin.chen@broadcom.com>
>>
>> Network device driver's receive path typically do the following:
>>
>> - dma_map_single(.., DMA_FROM_DEVICE)
>> - dma_sync_single_for_cpu() to allow the CPU to inspect packet
>>    descriptors
>> - dma_unmap_single(.., DMA_FROM_DEVICE) when releasing the buffer
>>
>> Each of those operations incurs a copy from the original buffer to the
>> TLB buffer, even if the device is known to be writing full buffers.
>>
>> Add a DMA_ATTR_SKIP_DEVICE_SYNC flag which can be set by device drivers
>> to skip the copy at dma_map_single() to speed up the RX path when the
>> device is known to be doing full buffer writes.
>>
>> This has been seen to provide a 20% speedup for Wi-Fi RX throughput
>> testing.
>>
>> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
>> [florian: commit message, add DMA-API attribute flag]
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   Documentation/core-api/dma-attributes.rst | 9 +++++++++
>>   Documentation/core-api/swiotlb.rst        | 4 +++-
>>   include/linux/dma-mapping.h               | 6 ++++++
>>   include/trace/events/dma.h                | 3 ++-
>>   kernel/dma/swiotlb.c                      | 8 ++++++++
>>   5 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/core-api/dma-attributes.rst b/ 
>> Documentation/core-api/dma-attributes.rst
>> index 1887d92e8e92..ccd9c1891200 100644
>> --- a/Documentation/core-api/dma-attributes.rst
>> +++ b/Documentation/core-api/dma-attributes.rst
>> @@ -130,3 +130,12 @@ accesses to DMA buffers in both privileged 
>> "supervisor" and unprivileged
>>   subsystem that the buffer is fully accessible at the elevated privilege
>>   level (and ideally inaccessible or at least read-only at the
>>   lesser-privileged levels).
>> +
>> +DMA_ATTR_SKIP_DEVICE_SYNC
>> +-------------------------
>> +
>> +Device drivers can set DMA_ATTR_SKIP_DEVICE_SYNC in order to avoid 
>> doing a copy
>> +from the original buffer to the TLB buffer for dma_map_single() with a
>> +DMA_FROM_DEVICE direction. This can be used to save an extra copy in 
>> a device
>> +driver's data path when using swiotlb bounce buffering.
>> +
>> diff --git a/Documentation/core-api/swiotlb.rst b/Documentation/core- 
>> api/swiotlb.rst
>> index 9e0fe027dd3b..3bc1f9ba67b2 100644
>> --- a/Documentation/core-api/swiotlb.rst
>> +++ b/Documentation/core-api/swiotlb.rst
>> @@ -67,7 +67,9 @@ to the driver for programming into the device. If a 
>> DMA operation specifies
>>   multiple memory buffer segments, a separate bounce buffer must be 
>> allocated for
>>   each segment. swiotlb_tbl_map_single() always does a "sync" 
>> operation (i.e., a
>>   CPU copy) to initialize the bounce buffer to match the contents of 
>> the original
>> -buffer.
>> +buffer, except if DMA_ATTR_SKIP_DEVICE_SYNC is specified and the 
>> direction is
>> +DMA_FROM_DEVICE. This is a performance optimization that may not be 
>> suitable for
>> +all platforms.
>>   swiotlb_tbl_unmap_single() does the reverse. If the DMA operation 
>> might have
>>   updated the bounce buffer memory and DMA_ATTR_SKIP_CPU_SYNC is not 
>> set, the
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index b79925b1c433..bfdaa65f8e9d 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -58,6 +58,12 @@
>>    */
>>   #define DMA_ATTR_PRIVILEGED        (1UL << 9)
>> +/*
>> + * DMA_ATTR_SKIP_DEVICE_SYNC: used to indicate that the buffer does 
>> not need to
>> + * be synchronized to the device.
>> + */
>> +#define DMA_ATTR_SKIP_DEVICE_SYNC    (1UL << 10)
>> +
>>   /*
>>    * A dma_addr_t can hold any valid DMA or bus address for the 
>> platform.  It can
>>    * be given to a device to use as a DMA source or target.  It is 
>> specific to a
>> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
>> index d8ddc27b6a7c..6eb8fd7e3515 100644
>> --- a/include/trace/events/dma.h
>> +++ b/include/trace/events/dma.h
>> @@ -31,7 +31,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
>>           { DMA_ATTR_FORCE_CONTIGUOUS, "FORCE_CONTIGUOUS" }, \
>>           { DMA_ATTR_ALLOC_SINGLE_PAGES, "ALLOC_SINGLE_PAGES" }, \
>>           { DMA_ATTR_NO_WARN, "NO_WARN" }, \
>> -        { DMA_ATTR_PRIVILEGED, "PRIVILEGED" })
>> +        { DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
>> +        { DMA_ATTR_SKIP_DEVICE_SYNC, "SKIP_DEVICE_SYNC" })
>>   DECLARE_EVENT_CLASS(dma_map,
>>       TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t 
>> dma_addr,
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index abcf3fa63a56..8dab89bf5e33 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -1435,8 +1435,16 @@ phys_addr_t swiotlb_tbl_map_single(struct 
>> device *dev, phys_addr_t orig_addr,
>>        * the original data, even if it's garbage, is necessary to match
>>        * hardware behavior.  Use of swiotlb is supposed to be 
>> transparent,
>>        * i.e. swiotlb must not corrupt memory by clobbering unwritten 
>> bytes.
>> +     *
>> +     * Setting DMA_ATTR_SKIP_DEVICE_SYNC will negate the behavior 
>> described
>> +     * before and avoid the copy from the original buffer to the TLB
>> +     * buffer.
>>        */
>> +    if (dir == DMA_FROM_DEVICE && (attrs & DMA_ATTR_SKIP_DEVICE_SYNC))
>> +        goto out;
> 
> Nope, we still need to initialise the SWIOTLB slot with *something*, or 
> we're just reintroducing the same data leakage issue again. The whole 
> deal with that was that the caller *did* expect the entire buffer to be 
> written, but the device had an error, and thus the subsequent unmap 
> bounced out whatever data was in SWIOTLB before.

Do you know how common that assumption is within drivers? Could that 
behavior been hidden behind a flag, sort of like what is being done here?

> 
> A memset is hopefully at least a bit faster than a copy, so maybe there 
> is still some life in this idea, but the semantic is not "skip sync", 
> it's "I'm OK with this entire buffer getting scribbled even my device 
> ends up never touching it".

Sure, let me test with a memset(), any suggestion on a name that carries 
better semantics, I do agree that "skip sync" is not quite descriptive 
enough.
-- 
Florian
