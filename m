Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197230E0D5;
	Wed, 12 Aug 2026 05:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786512218; cv=none; b=bdmrd63jsexjoYDov6IZOi6WuPV64G7rIJSzTkPqzVUnTDmjhNh289j0+G3rRjhwGvJXraZptYNS36+1TNwUAFI7UY9+NVBXqLcN4qaO2yyi5ZM8dv0TSiGdTnwOdPIqQfxdvz27UuSDx2M/YF30UMl+FpBduV0uo3mIMFWS9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786512218; c=relaxed/simple;
	bh=iE7WD9cC5Zp1jYTzEd47muCzZZ8TB+7wVvVGgHiezK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mt2L6NRLrG552O0PJ9TeCASsRXrcd1uHte56S68isSHvqCjJ6Pd99PI+0E4zvNENMs5F6kI37zDF10ZZnSDk+REfBaZZY5v/FqtwH7YeaMmT75bkhbg9EWjscVt9y4qAFeyMv2okxrdTm2uMVeQctojo+flXPQmyfwF6iD2JP7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OpukalZq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OpukalZq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786512216; x=1818048216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iE7WD9cC5Zp1jYTzEd47muCzZZ8TB+7wVvVGgHiezK0=;
  b=OpukalZqB99QR2lt9G7Jvp3zYAT49pMhvUi8wyft/VbD+LtwvS3CnCuH
   a8++2UOLJqD+lNgWaDTVWmW+Ox1nNM0yX4YdyMWwg5yZyf5i6tg1m8Dr8
   3v3BOP71aSCI6pA9sgRLPPgAjSTeT7QW1EKxT2ZdYpih3Fhcrg4WD87F+
   E0/MmLMv5ACH6IpKgBvDWP5CmoUY7Rh504JV7uNYA7gYuJz3DKcrzmbHa
   Hl/yfOecoDVIL2yyUSj8uZz3kRSimAypc6XLJkuAIdkZPV3YQtXNo9fF8
   LTyYcbACAcqPhlMRLvPjiCHdOiW6fhXbSENYT+x+/0cme1u1p96mskhZy
   g==;
X-CSE-ConnectionGUID: /22aGNHhQUWsdlK4SS1HZQ==
X-CSE-MsgGUID: 6Ss/GOxLRICCtziHgNoB8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="112600181"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="112600181"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 22:23:35 -0700
X-CSE-ConnectionGUID: 1SnU3e7vSsmcahYLs71EJQ==
X-CSE-MsgGUID: KGD9BSXaRIiKAaUKOK5hpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="261785396"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 22:23:22 -0700
Message-ID: <3722b4d2-ef2a-4ab8-9a24-7d61a776b05e@linux.intel.com>
Date: Wed, 12 Aug 2026 13:23:19 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/41] KVM: Rename memory attribute APIs to prepare
 for in-place gmem conversion
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
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com,
 Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev,
 Xiaoyao Li <xiaoyao.li@intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-5-2fc18ee6d3ba@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-5-2fc18ee6d3ba@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Rename memory attribute APIs to add a "vm_" in the name in anticipation of
> moving PRIVATE tracking into guest_memfd, to allow in-place conversion
> between SHARED and PRIVATE.  At that point, there will effectively be two
> (potential) sources of memory attributes: the VM and guest_memfd.
> 
> kvm_vm_set_mem_attributes() already has "vm" in the name to indicate that
> it is a VM ioctl. Rename it to kvm_set_vm_mem_attributes() to show that it
> is setting the VM's memory attributes. (Drop the VM-ioctl scoping since it
> is a helper local to the file.) Update the accompanying trace function to
> match.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Shivank Garg <shivankg@amd.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
