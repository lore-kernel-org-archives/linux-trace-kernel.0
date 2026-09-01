Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD765476CF6;
	Tue,  1 Sep 2026 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254004; cv=none; b=EUD/0lap9dMAEmvoP9Jl67Ko7I4g8zCdK45xAzau57rx6JF5QwUtrLQK/C23NGj9fikFJYtjPA1XgGx9FR0qE7qufYE/9mvQdJAb2H+JJP0Br0mjgkq5QzVDB9mOiaDJywn0UHPv0u9zkgW36Z4MPzVZyhmwnG2x3Q6lmRiROHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254004; c=relaxed/simple;
	bh=pd1acZ0l+zUOeZobkaoqxgpVJGbI2mEIMZ+5P/Tso5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTnsiz5cuMxIldpvoSB08doMU/usu67yNmcdJ+gyZ0pSMnsvGYQsTXIqzjmeJOFaovRN5IUhuuL4NjjcSX0w0K7DQw6fxi/cnMisPqMuxNyNqDupRP6Y3GK0eUHT90pVGxTAtTlD9k1uELWW39oGVYYkzzCFqpLfpeXFkteVy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HawesVss; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HawesVss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788254003; x=1819790003;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pd1acZ0l+zUOeZobkaoqxgpVJGbI2mEIMZ+5P/Tso5Q=;
  b=HawesVss57UC3TnRlfBf846MlXGh149EyB/W7Hn4my5reukjOVC78f5a
   Yax3wykJsa1kmL8g7l4jnlXaYivsxPJaAqoYWX+x7ARme3LgkmXYLr5Jn
   Ki78cDrG59XOjDW/rWt8wzfNsUy/EHm8eu2QomwDMLiHFR4MzxNQ3DjZH
   si5Pye2eSaCdRe2B6N0IsOATAsxfLtEAaa8DHTikj3M2oe7Iu7SoSZEyP
   3letHdtkjf8ykblc4+HdeTy0iuU6xRbzwYycHX08gm7BLDzqXPRb0ACjT
   IWoqctqfTK+yyEMnAsSwOeHqOGDTIlUk62ipXtcA6FczGagiEKKIfLgnK
   w==;
X-CSE-ConnectionGUID: 3JESCGOeTFWEaFbUmpaIVw==
X-CSE-MsgGUID: pyfjR6k+T3ySeqG0ucz6eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88603758"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88603758"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:13:22 -0700
X-CSE-ConnectionGUID: 2eKjT+udSB6mMZPX1dBpZA==
X-CSE-MsgGUID: y9fKTNKyTUOUmNAApqtZXQ==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 02:13:06 -0700
Message-ID: <a11190b1-908f-48a0-9f75-1d4472b2007e@linux.intel.com>
Date: Tue, 1 Sep 2026 17:13:04 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/45] KVM: guest_memfd: Optimize away conversion
 overheads via dead-code elimination
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, brauner@kernel.org,
 chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com,
 jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org,
 pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com,
 rientjes@google.com, shivankg@amd.com, steven.price@arm.com,
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com,
 forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com,
 aneesh.kumar@kernel.org, liam@infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
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
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com,
 Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Fuad Tabba <fuad.tabba@linux.dev>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
 <20260830-gmem-inplace-conversion-v12-1-85e5fd25252a@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260830-gmem-inplace-conversion-v12-1-85e5fd25252a@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/2026 8:25 AM, Ackerley Tng via B4 Relay wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Add and use kvm_arch_has_gmem_convert() to guard guest_memfd's invocation
> of arch hooks related to converting memory between private and shared, as
> only one half of the x86 CoCo duo needs the runtime hooks (any pre-work is
> pure overhead for TDX).  At this exact moment, the overhead is negligible,
> but that will change when in-place conversion comes along, at which point
> to-shared conversions will "need" to find all affected folios prior to
> calling into arch code.  In quotes because very technically that work could
> be pushed to arch code, but that would bleed guest_memfd details into arch
> code and would be far worse than adding yet another kvm_arch_has... hook.
> 
> Opportunistically provide the kvm_arch_gmem_make_private() declaration, and
> rely on dead-code elimination to eliminate the call to non-existent code
> when CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT=n.
> 
> Reported-by: Binbin Wu <binbin.wu@linux.intel.com>
> Closes: https://lore.kernel.org/all/1ec08cd8-3072-4753-ad5e-cd34956647f8@linux.intel.com
> Suggested-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
