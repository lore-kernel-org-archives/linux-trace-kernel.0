Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F165F2FCC01
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783238; cv=none; b=ODi40oHqyoGwUDGP9nOLYYZSthT/nScFmEC9uONzj/RPTPupCn0PhEjh6/Gh9ZG2TXzVQ+z810bWfRiH2L6SYrLd3yC8rtgkKx0qYNlVFEPGK0jF1iM0xX79NPNRJHhiMduAfznOFAAc1cE/AXI66HRzYXOh9PtqKsj0DISgSaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783238; c=relaxed/simple;
	bh=5aIm3j91ZTCbpZvr139X78Yr55miWzCUn8iBZ96dngk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4O3yMuvkhLKs9gZaB8Cg3INqBw+N9dySqsowEPOGB7MskLrv3e7uzWHJvchIr/Ev4e+SHMlOfcKlixtXnR3C4vFvJFLFeAyo3W/5rnBAaQ7ygaBTvanPrghhF37vGi7jiVqtU9eRATuo/S+Tpg5mHMeakkxxVXsoXnU2x395lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDjJgD6Z; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDjJgD6Z"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477775d3728so14526095e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762783235; x=1763388035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4l3M70pV0c14d1SIvE9JX7nk/ZPCIDubtc+GHmzBoAE=;
        b=mDjJgD6ZBSqE6ASgwmbRwIqap1HTPLTvPtkpg04BgPLog7uu/d4rVh5ugZ22FJTVYp
         1fphAVckJ+nNmocwC2uVE08mpw6yctDwsITrupyWTROhUPcexPMswMnATZE1gr+OaI2O
         gpXYOShowB3MMmxh9Cn82qRhyeMTehUk37IJ30rEpf9vABbDkNco6Fk7ddHnauR6ONyI
         gaNKjFe9XJcR/L4r0n5nPfJ0FgFzZZN+/D0xwZ/4e6dEOEhqC1JvpOEt3y2RkXUX4/li
         UqqThtMnR3y/K4bRe4W7OzFzJC/wXcOQv/zKPbNmlh46GIkZGZCKCkuw3odeZf2IO2q3
         gU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762783235; x=1763388035;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4l3M70pV0c14d1SIvE9JX7nk/ZPCIDubtc+GHmzBoAE=;
        b=YCk2wqrtmMXV0vY0+McUJwro20w427q80zYfs+cKp0Ay8CP3kkYQHfw9hQJ8u5rOed
         2NrVDcJTwsTfs4CrHvcPWHmBeTTOXpXtqkN99c1BfjS1hlfuC9/I43NdIoVhB/J0uMrO
         U02QjbYv28F5Y1b8zZfn3RrCtEfNDfgVm0hLwa2hbyvjQHyi+XvkPVWdiZcG4dwSIBHJ
         LiKXvQQ49ZX2LtonnVpCSi0SsAJUfW484TbcNbtoMyBFIjOS7prkkCsHbVIxJS/rRzbV
         sV7qK/Rv6DGrMQ0SZg/M3lXHecagt7uQqqDTPvKHH/+0c3ZAli7mMN1k/YFvTpQwsUUK
         Xd+A==
X-Forwarded-Encrypted: i=1; AJvYcCXrzFgs5WdQeBNQ/MmtI5HHHTmmeNpxBCjygAVead7pB9SEBfUW5vUsZqDdqoT2dq8slA7caLo54iF5tY6HYc60w4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YykV7dzftL9YuTbDBCLFrPeSP55l84inls4cjTgG/DV7CF3TyKl
	ExluewWDEGAuFUgcscUIwt31BrDkdsuHKz77hiLjYyNTe6oxzZnMjj24
X-Gm-Gg: ASbGncuZ7LNE6oD/WsC/ugKC8IJGPzt4jCYus9q6FmxA0YEhBVDMQ7knEEIoUtPL4ii
	uqByN09hxrdxipgnowCulEioATueP8fD/fvhzldS+NvQNBUNTQK/t+gtMnwWX2XWAhuFtwXky/7
	0xaWZoTB4bcfJ10jPDQ85JGm9sscHdtSvU+EA9DgE4pTpM+b5K6qhYXbIjg9RPC9kx1dTPV+gTU
	IxI8xJ23BZ6kCo4GAiWkjeRJUnCZhZy5m8ln7cOMf+8vT1OW0dXGcMPdGaEPAJ3kE18sXYGUOU/
	1j2MZHV0hfnYoTzK3SIguzRRanjPxTiMXm5cD+lYlfPueVUjNs/LIyBBY9Rd0cvZAEAPlV+RxYK
	9uFfZmHCUwmLBBSUTvb7fZ9rhZNOvh4FL58aG+8v0BSBra1q26kuwdc1Yruvb6O+GE+U/tAM0Il
	prM7sj+HIv83s/wN+xf6cELy1XBZ6c3W/wQESxb7q69t+LtQ1URutITpdtoKYoVrrHKHP8TaB51
	/ljfPbWpwhH5XPcbCIqunKNw403YUagAIupYYAlqD6LmvaR0GFbazvTBr5P
X-Google-Smtp-Source: AGHT+IF4UYzYuQ5gtNvkLSNSf73n/ZiCTwtuvYmTJtVCw6+PSGNCr+TyxhYSZT5k12Csb6f4YHcj2Q==
X-Received: by 2002:a05:600c:a6a6:b0:477:79cf:89d4 with SMTP id 5b1f17b1804b1-47779cf8b43mr33422025e9.31.1762783234986;
        Mon, 10 Nov 2025 06:00:34 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc33c8sm318303885e9.2.2025.11.10.06.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:00:34 -0800 (PST)
Message-ID: <9b622374-778a-4459-aca9-4eb406a58516@gmail.com>
Date: Mon, 10 Nov 2025 15:00:32 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/khugepaged: do synchronous writeback for
 MADV_COLLAPSE
To: Matthew Wilcox <willy@infradead.org>, Shivank Garg <shivankg@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Branden Moore <Branden.Moore@amd.com>
References: <20251110113254.77822-1-shivankg@amd.com>
 <aRHs3pA2kOr_uD3k@casper.infradead.org>
From: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Content-Language: en-US
In-Reply-To: <aRHs3pA2kOr_uD3k@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.11.25 14:47, Matthew Wilcox wrote:
> On Mon, Nov 10, 2025 at 11:32:53AM +0000, Shivank Garg wrote:
>> When MADV_COLLAPSE is called on file-backed mappings (e.g., executable
>> text sections), the pages may still be dirty from recent writes. The
> 
> That explanation derails my brain entirely.  Text isn't writable!  How
> can the pages be dirty and file-backed text?

Files are writable :)
