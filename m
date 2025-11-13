Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC2F7E792;
	Thu, 13 Nov 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047835; cv=none; b=RR7n2Okc/FdWX7zXEO2OvMKsEClQoyKICbd8xbCnObumtDgPIvy3XOFS2qlPOj0JPzJ75ANd9DK66CtFPEqKGfPqdtOMvdneIQsUf/Js63IfGTO4mGIEJWISDPE1q0Dxo2gF6gHmyxJPULoOtJO8egBTJ5JtDvGkwaSxnwqQTzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047835; c=relaxed/simple;
	bh=tGGALCCjS204ssR6DDHUnCXjhFK8nMBYVU+owIpKMMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZVNAQvAcGGjyC7fyG9D5HO9Gib+cbG1YkZzZXYs3F1HsGt3alu0KmHIJMPbYYp+W/S0OOepM1fuaQsUXPk/2vybLE55gapxaDfBr0sjKIjv9IYGFfcY22gcJSDs3q/BkmqzlkAr5v97B6WUgGqiGYrCg65uvE+HHS65uxx+yVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpEFMGxf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpEFMGxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1AAC4CEF7;
	Thu, 13 Nov 2025 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763047834;
	bh=tGGALCCjS204ssR6DDHUnCXjhFK8nMBYVU+owIpKMMg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kpEFMGxf0CQGJGG9BMrBulPuHLSsbaZmz2F10q+U5lQNVex6ThzpOGw7+DyIt2PnK
	 JV0/5CVAlX2KfTg0ks5PYMUa+Oi5pyphqsK2EErkq7wlNXdUGarSi4HWS75zN5v+Qk
	 G++EoGJzrq+W5oj0gLFTPGyJl7KOSGp9Es1OUOubdrYn6UDDO2ETHBHpwGs1MUe+Jz
	 U8C+XjZX88rViP4mw8W8o3CedxRXAd6OP4hzOp370+Z18EJ7ZxaQk9jfZhrU9mNPmK
	 OUuZT3OTj//qPL0mMpoarjHmHdDHd+blv1yaY7uZfsNvXE+QcomCJPrRBh6t1+NqdA
	 Gy4FgH8ONHsZw==
Message-ID: <0c9f5b83-10db-460f-bdee-897396b49838@kernel.org>
Date: Thu, 13 Nov 2025 16:30:27 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/khugepaged: do synchronous writeback for
 MADV_COLLAPSE
To: "Garg, Shivank" <shivankg@amd.com>, Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
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
 <b7313a45-c36e-4390-a0b8-46f412474f86@lucifer.local>
 <39c8a4ed-53b5-48e3-baea-f67cc1e8be4f@amd.com>
 <aRH2pdhMBQ-20IC9@casper.infradead.org>
 <e38e8059-a62b-4ad5-8316-5af02a0cc1b6@amd.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <e38e8059-a62b-4ad5-8316-5af02a0cc1b6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.11.25 06:58, Garg, Shivank wrote:
> 
> 
> On 11/10/2025 7:58 PM, Matthew Wilcox wrote:
>> On Mon, Nov 10, 2025 at 07:50:17PM +0530, Garg, Shivank wrote:
>>> The issue is copying those binary to a freshly mounted filesystem.
>>> The page cache folios remain dirty until background writeback completes.
>>>
>>> Reproduces 100% for me: fresh XFS/EXT4 mount -> copy binary -> execute -> MADV_COLLAPSE fails.
>>
>> Yes, but this is an uncommon thing to do.  Really, it's the kind of
>> thing you do when you're testing something (like, whether ext4 supports
>> large folios, and whether that yields a performance improvement).
>> It's more reasonable to change userspace than the kernel to solve this
>> problem you're having.
> 
> Fair point.
> 
> You're right that this is primarily a testing scenario, though it may also
> potentially affect JIT compilers writing executables (also uncommon) but more
> research is needed.
> 
> For userspace workarounds, calling fsync() before MADV_COLLAPSE works.

Right. But do we want document that any caller of MADV_COLLAPSE should 
issue an fsync() if MADV_COLLAPSE fails to try again?

IMHO this just reveals a problem that might also be triggered in a 
container that just got downloaded or after upgrading a package, no?

-- 
Cheers

David
