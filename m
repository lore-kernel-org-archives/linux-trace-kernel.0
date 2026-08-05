Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0A42AD2E;
	Wed,  5 Aug 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927128; cv=none; b=Yc/UORB48r55JaZtIyD8UGm69xL2e0oBtkII/AGJ7zM30rEJ2K9rKuWNwpOhMSCOJNKfMTwoFte7k4SP+60qE8Sj7xLJ/iyup7NK/13siUpG++dLHUgAvtpr7Mh5mVhMP3djKcsOUJyfJeXQDheGikZ37O08oh1g4k0AdXQ/J0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927128; c=relaxed/simple;
	bh=osqcgEZrB4tIRuddtFyChcekiAZrXeFH6SN6KLCXUeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvOsIV7T3at0VUBo9jkuBNMbB5iJeG0y25BvSHOUhJAihdxk+IPMvuc+TPiZAcgZWLMpTliDvNXYGnpczZETQr1VIY5+8eLSNTg6H1wsqe1qoDsdhvhOSqRIwY+M7PvnL84bubsofztc1bpaG2Cxxzqluw2mZXMcxXT0f4FQFWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MccCTMFj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MccCTMFj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A7A4153B;
	Wed,  5 Aug 2026 03:52:02 -0700 (PDT)
Received: from [10.57.44.180] (unknown [10.57.44.180])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 743203F632;
	Wed,  5 Aug 2026 03:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785927126; bh=osqcgEZrB4tIRuddtFyChcekiAZrXeFH6SN6KLCXUeQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MccCTMFj2hIMMjW795szcS5FxXktDxGWArGGS9xJv4VDpKX5Fq4pBTHZ+Dqo3dGwn
	 I3za+Zt5GbrL3mgj2p5MRpqTGbT/okZGd5AlVXHozUBVFgINdiUcI9YZ5TtSpFFehy
	 9K99FQyL3HUPo3MkG8rpZnXuHfDYEsMZGyYwsLhU=
Message-ID: <d2584ac3-51c7-4eac-8f37-ae29d899169c@arm.com>
Date: Wed, 5 Aug 2026 11:51:55 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/41] KVM: guest_memfd: Filter both shared and private
 when invalidating
Content-Language: en-GB
To: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev,
 binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com,
 david@kernel.org, jmattson@google.com, jthoughton@google.com,
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com,
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com,
 shivankg@amd.com, steven.price@arm.com, tabba@google.com,
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com,
 forkloop@google.com, pratyush@kernel.org, aneesh.kumar@kernel.org,
 liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-9-35f9aec2aed2@google.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20260728-gmem-inplace-conversion-v9-9-35f9aec2aed2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/07/2026 01:35, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Before conversion, a guest_memfd could be either all shared, or all
> private, configured at creation time using the INIT_SHARED flag. Hence,
> when zapping pages from stage 2 page tables, guest_memfd can filter which
> to zap based on the initial shared/private state.
> 
> With conversion, guest_memfd tracks shared/private state on a per-page
> level, so a range can contain both private and shared pages. Zap both
> private and shared pages for simplicity.
> 
> An alternative would be to iterate guest_memfd attributes and only zap both
> if shared and private pages exist within the range. Setting both the shared
> and private filters lets the zapping logic do that iteration instead.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

