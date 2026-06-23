Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7B37B40C;
	Tue, 23 Jun 2026 06:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195597; cv=none; b=mWNgN3jsexIlcsa3yH3n7zz6pJKkk71zUvh1u1dHMhc7Lyo9oUqQIH0lgBwCMha1F9taM1O+/TWnT6iQLQ/Gro2T4xUwm/1JfDV2YREmNFesQEZCKjWYjBtN6rDPfSizuiZ7jAMPdCxA2A7FYgn9Dgen2f0/VBOa5pKDFEmECZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195597; c=relaxed/simple;
	bh=OVl0lauamZ9UP82xgjaUBVhU9XMWc3+GnTCVk+DPPMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REI7sv6jWcW0SfpgGvP6NTMUgH5t1YJP6sWMBcr+WX+o1AQ3gZc1R3V7PmNsoN7T7G+++ZP/MMnbnre+AR/HUpkopzYKWV5rvXMsEF+XwgdlWbk2N6QxBMTvhYx0BGnvjSOVTxHz+RneWJUITmx/aEYxaqfCd8W9Xwiys2HTYJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TERLac2S; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TERLac2S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782195590; x=1813731590;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OVl0lauamZ9UP82xgjaUBVhU9XMWc3+GnTCVk+DPPMA=;
  b=TERLac2SaCJt8ng8/OiCxjT7VaZN/MXAwbUc0fnkeDZaXSY+Gv6j8vl1
   foBxEsoxX14B+9M6FY/ddM+M86cpovUTBic8vadrYdO3Trzg8GmmfV/Di
   EwlOeIqU5U+WQYCE4QoxkgVz3G0PAWJ1lU0JHoxB5qrqRULZkHhg022wu
   jMxu+e3RWOdK1zBE4A6Pe5ibJZ04lqAp2NfGplKvw1wlZX/kYKC5hNNEp
   xAkveGH+oN0uYLhBWttGSMtQXyeYtjbvkvUwSAOVqWF23cL7MO9ZIt2do
   uyVESymvc0vXDfFo0lTCX6W8ddP9R32woXIm08l7MiPOegoQNiIs0+GKB
   Q==;
X-CSE-ConnectionGUID: 5ZK4yfkIRwmINNWSgPr5Mw==
X-CSE-MsgGUID: TIqqBXnaT4iEhncQYFtcdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="93293804"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="93293804"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:19:49 -0700
X-CSE-ConnectionGUID: 7CTGyGSsSQeyst4z2E8mrA==
X-CSE-MsgGUID: 3FFN9xRISGGDv0urrvE/jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="248279937"
Received: from unknown (HELO [10.238.2.81]) ([10.238.2.81])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:19:36 -0700
Message-ID: <49cee70e-86a4-46b6-b690-0d48aeb94221@linux.intel.com>
Date: Tue, 23 Jun 2026 14:19:33 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/46] KVM: Consolidate private memory and guest_memfd
 ifdeffery in kvm_host.h
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, brauner@kernel.org,
 chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com,
 jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org,
 pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com,
 rientjes@google.com, shivankg@amd.com, steven.price@arm.com,
 tabba@google.com, willy@infradead.org, wyihan@google.com,
 yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org,
 suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org,
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
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-11-9d2959357853@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-11-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Move the kvm_arch_has_private_mem() stub and a few guest_memfd function
> definitions/declarations "down" in kvm_host.h to utilize existing #ifdefs,
> and so that related code is clustered together.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

After fixing SoB ...

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

