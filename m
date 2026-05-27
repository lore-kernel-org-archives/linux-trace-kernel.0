Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDFF40149B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896145; cv=pass; b=CvrLNziiWGhwd3YCrDEU7a/kFI/ByT6dGy3YH20SN9lqf/cwKE9OrsABQ6pq65oaUsFFj/EyVTG7vLdfYISP1MibVP2tK504ySJ+UaxY4ZfypJ+AwGe+vL3cuOPR6JYu928mpZGpPnGvlNANXM+YK1XR8qKLLZLy6cOpzJwP11E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896145; c=relaxed/simple;
	bh=/34ZEKo4WKYSNfKeZJyC5zY+tHi9Bq+q7x5tIuisplU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpNBGxl7hNXYc6+ZfMEh2NCVA2LBp5JDtpqIw0mHMcWSg7e2YQHP0FlJSzDNveRCdfqHBqPLqpv3S+WpTStOqZH90yzLox4EzA3hKUF7B4pdyVGy12TLTL0JVexuhRSeJXePKmTDJS6v//p59bOpzPK5Rrd59WSLkkiPZ6Yy85k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wt/O37Jb; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wt/O37Jb"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-133466cf955so31400483c88.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 08:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779896143; cv=none;
        d=google.com; s=arc-20240605;
        b=dw4OGbH2EiNv+vfaneKq3vLDY4V5SMcyc96dxfOW4sk+XbPCTmyuKaQkCBFWglPs7u
         Q2XXyoyOrGh49EOl5sSJsJ4Eps9iMN4jEWJ0RtIPWtSj+nG8SC0EwZwWumjhrfdXKfpw
         z0Y1tAAihw6E7GESva5qJ+15sr1JszEFJFkvSDRUnIN1oZtMXLoj8HeL764P4oe30wXt
         qqoy5z314nBXIKRUCOvdcNsN0Yut3BffZBhg3Exopjrr7BL56LfBACXrIeeLXx7t6HSF
         Z6UmvZxLungjGAbaHnYlle8Irf/VzQT1dJx0tJZ69RjL/GqSKHaWHqWJOV0oyscdi4b4
         4Etg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=/34ZEKo4WKYSNfKeZJyC5zY+tHi9Bq+q7x5tIuisplU=;
        fh=hdDTrDWdhMQokp2LnTdG6oygDqKMnV3XSu0h5paOrX4=;
        b=QGzpuFRyhaLM1fcp5mdP+CmQn3xF/JiCZnZUyb6iH7kvpZVfaZqHY4haIrqfh5IEa+
         gstSeGTzRMcIa8ev+WTmpZomRL2IJJJJo4CZ9O7EHmsp1Ezz+i2c/6WkZIFnl/fXn75g
         LdVfhIe0NwDpAwQYf1QBJtr4vR8iRJI/EH+zkJ15PdWlLif95KTZrSJddSN6pxYWxppc
         sRZd7oBiybF5V6I2Lp9k8B1uC2mpukI72ijVn8q63YSS6+phdA3qSyRkXvSCSrlBFpj6
         sORkcn+6/26lfPY2b75zk/oRuFkGKwq7m6gI5AKBbbh25foeueB7DtNxY0a7PLn/K+ea
         Z4Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779896143; x=1780500943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/34ZEKo4WKYSNfKeZJyC5zY+tHi9Bq+q7x5tIuisplU=;
        b=Wt/O37JbYDl4yd5Km/nAsMShHhMavvHfWq9StSAp3LFUK8CYUV2vcyGMtpJljM5qs0
         Qd7khQMbrj/j6jFUmQe978B2aqvrzoPTY3QZQ4/RgRYQ89Q4E80vFtVpbQO9NZ2Bg5pR
         +4qsbxc9rCrq6KCOTJfXAGVMVURwAC4qgrnyq+4DzHcDefdVDhuHBaGnyYNZxG2jrcbL
         ZjkXcv/Bgs8i7XG5WQ2YpJtAcoxPiI7qmbTWT6ErUA+Xw8LgVNvkUDAezHm9hxnTz5Na
         i8xQ9G5L9/03p0AXx4shZ5vSZN21ldaoptMhVgXgq1St7tlc3mg57Io5GxElZVbJ8Ftj
         BUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779896143; x=1780500943;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/34ZEKo4WKYSNfKeZJyC5zY+tHi9Bq+q7x5tIuisplU=;
        b=NvpS2vU25wPRihJnIOh0eE3aXvRLiUw3sCzz0pjQpI+HL5rnj0bwtwYTBHXTpf6NCb
         TgIlr2FIfmJZfvzvZTWz4v1lA6BF0tx5aq2jXnyk7940n65SdXSil0IcACwMfHOKVS0u
         JmlAixlxv8cMnv6NZtB9V1V/DvsEwMZbtlZtQU+PZDuYD+wn2LIj6lpJPSdsJG+RiBbK
         /DTuHwGi2KnaD0k6W5SRxdZr/qzzmDezPoA0si4CUMI2fJcu0vDfPIqNnIudYG1kJSLT
         ikN5ZG0/BZzkI7K/wt7Al9yjTwqZhqPwln1A5bja3MEPFXqvTfTcWWuKUQ9TN0dbiJk+
         272Q==
X-Forwarded-Encrypted: i=1; AFNElJ+xlBuOlervP+R5ElHAjJ+q5ZNwjQOAO05ay1XMdk9PF9G+J4XIAIBB4l/SUyQex6IcWbfYyx48Z41Envv2r9YJEe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCX2/Vam4Zq/HOZ4Eh9DmlY3ERkAx4nkAjzSfKXHX9mO27P3cC
	ta/QdsTyDrsda3bJcJQ76P5j/PURM0PSBvp/z/ftbT8+tMOKo11CZZvmqWYl/VklxXp/sfIkrCa
	WIsrgVdajc7CsfCUAVAzYcPCyzvuUVLwwTHOi7wMP
X-Gm-Gg: Acq92OHYoADyWHdrj8mx+25wi7bKv3ci7vxN0R01wx03oZ2KJ2Cwur0LmmjiGpR6XRA
	OcaPwtz68Q8GQBDRuCRefKNp58CHOWpguPFOLVb6WgOjB00hN6Uviccas7TOAJVTUPq1tUQ1eZL
	N6LwJ/a58Sh9LbYCBMCa6hfLeFN8axCHLizPwOM1t8YfkBzZQ2PnojeuCQU8dIY9lTjx8tFjgS/
	/k0e8yhWpYwkPJT6ICqvwralAhl7UlKkoCZf789AW3eb8UvNWPaTm639EZYYf4TQRrvXeLphYOU
	A2yezW4nOcvjDBeMpb6/ZNXpqXkSElcIaFnw6fs1mOAyF/2d9A==
X-Received: by 2002:a05:7022:525:b0:128:d4be:7428 with SMTP id
 a92af1059eb24-1365fb4fa18mr10605757c88.19.1779896142087; Wed, 27 May 2026
 08:35:42 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 08:35:41 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 08:35:41 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgEZ9vCKkoMC11tVrueAonGWH2x6OeaYYxXGEj2gwHUaKw@mail.gmail.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-5-91ab5a8b19a4@google.com>
 <CA+EHjTw-cUM=FrJevtSDtR7K6MwUfGfOx21LMFDn7DAy5bFzYw@mail.gmail.com>
 <CAEvNRgGQvMdDmVfbk42EY_PGN0ybTp-x21Zj+pg_X1mk9iCRtA@mail.gmail.com>
 <CA+EHjTzLCD-dU-euZKgzwyEr2ecPqFDNutcaHm2fCDGA+MHVXA@mail.gmail.com>
 <ag8JIlHjohAOC3-g@google.com> <CAEvNRgEZ9vCKkoMC11tVrueAonGWH2x6OeaYYxXGEj2gwHUaKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 May 2026 08:35:41 -0700
X-Gm-Features: AVHnY4JKedjh8K8TNAXOjoVnM50DfBi_EKpudGArqGboylLRPDEHJZCPBXCFwT4
Message-ID: <CAEvNRgH_ToNJunEmQKn3wED1aF02hwg3GrQcRwwZTs_bfPVf_w@mail.gmail.com>
Subject: Re: [PATCH v6 05/43] KVM: guest_memfd: Wire up kvm_get_memory_attributes()
 to per-gmem attributes
To: Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

>
> [...snip...]
>
>>
>> Hmm, I wonder if we can figure out a way to consolidate some documentation,
>> because this is _exactly_ the same pattern that x86's host_pfn_mapping_level()
>> deals with (see its big comment below).
>>
>
> This would be great, are you thinking an actual comment or something in
> Documentation/?
>
> Perhaps we could iterate on this a little with me providing the newbie
> perspective. Do you want me to take a stab at writing something up?
>

Please see https://lore.kernel.org/all/20260527-kvm-locking-docs-v1-0-4fe8b602ff47@google.com/T/!

>>
>> [...snip...]
>>
