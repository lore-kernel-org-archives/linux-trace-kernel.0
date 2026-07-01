Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7702634CFC6;
	Wed,  1 Jul 2026 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896665; cv=none; b=eP+KWhs1O56ye7sBBU0Pb+cTF3pjNKoufvrxYiYg7m6MYm0oWfRiCr90Nu0mQORQYR1jznRq5tYAxtqfaVOa9vU30E9T9wKSc9WHF8NelrItJ/1oB2HaY6BoXj5M9aIPFFZf27uYSYyYio+BSGyF6ZP1un8qqWZIJGagwMbg3Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896665; c=relaxed/simple;
	bh=o6HO5yighH0lbPMGOWuebg9WNrWtRExEVC5nSB71uk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GVxEBjr45GS+l+TKj+HN1DoT3OygeFeZX3TxTGAsNS6nzsktiD0/8W+CnHjluw3xh9wO0iHZHFZhdGiUgsm+xJKHVHKfCWVtPv3RJjxY5fwSs5s4XfwOt7cUf7sn/GPvtHBiy3iB4RGqnIv/2WDPkYx0YCDvLGSfP/qNU0ZIFyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bkktkk3L; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bkktkk3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782896664; x=1814432664;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o6HO5yighH0lbPMGOWuebg9WNrWtRExEVC5nSB71uk4=;
  b=Bkktkk3Lltr2ttw4gghBuNxutlTWIbHY6gy2R8pRdO9Lr7piUso5vbCh
   r10RPrPai4Nygl/oIVkmHkiq/r/ENtfy58rcC1AEma/Rehuycd7I189UJ
   8YdTrE+dty0QDKGYMk7rzUmoPmTbUt8d72zanjJWpC6KiMFCadmx1iA0x
   yqyJhsJvnYgAjGe2kQrHQtaRyy/05hNyG1bUDiu4iShc1uFAxz1fd3t6/
   qd8f7yUGUk0ZKBUYbVpzIvwCYOMy1MxJaoUuLGzGaUNAK23Wb7Kp8bNyv
   0yNW7nRCDyLGYYabOfpSVM6972pD7GS0264xKhvt76hfEI6eHFAO2KS2I
   g==;
X-CSE-ConnectionGUID: 2/u/KVVpQYClfO2eAZzqZQ==
X-CSE-MsgGUID: qaXHPnuLRMa/+1Gh4I1ECw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="71146239"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="71146239"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 02:04:23 -0700
X-CSE-ConnectionGUID: RfVhV5zfSDWv+vMwhlsJyA==
X-CSE-MsgGUID: bSAPRm+uSA+mXv3+cFiw0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="252641956"
Received: from unknown (HELO [10.239.158.49]) ([10.239.158.49])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 02:04:02 -0700
Message-ID: <584a8f9a-1538-4f8b-b576-75ef0fa961c7@intel.com>
Date: Wed, 1 Jul 2026 17:03:59 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/46] KVM: guest_memfd: Advertise
 KVM_SET_MEMORY_ATTRIBUTES2 ioctl
To: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev,
 binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com,
 david@kernel.org, jmattson@google.com, jthoughton@google.com,
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com,
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com,
 shivankg@amd.com, steven.price@arm.com, tabba@google.com,
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
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-17-9d2959357853@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-17-9d2959357853@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
> @@ -4969,6 +4973,11 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>   		return 1;
>   	case KVM_CAP_GUEST_MEMFD_FLAGS:
>   		return kvm_gmem_get_supported_flags(kvm);
> +	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
> +		if (!gmem_in_place_conversion || !kvm_supports_private_mem(kvm))
> +			return 0;
> +
> +		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
>   #endif
>   	default:
>   		break;

this looks inconsistent with the

	case KVM_SET_MEMORY_ATTRIBUTES2:
		if (!gmem_in_place_conversion)
			return -ENOTTY;

Well, the check of

	if (!kvm_arch_has_private_mem(f->kvm))
		return -EINVAL;

is buried in the following kvm_gmem_set_attributes(). How about moving 
of kvm_arch_has_private_mem() check to put it along with 
gmem_in_place_conversion check in kvm_gmem_ioctl() in Patch 13?
