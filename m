Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C28438330E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785443709; cv=pass; b=PntyYZZRYrIlsT4dCU7CuwEzncI3wtyHs3Zmy6BjnSPvxisvAz7EboeyLQQuoqLgk9kQbNVQkYHtsKEnaLc855cJ7Z+32gggHjdCAWN9zWo0GeFPz1XDYEax8LDAVMluw0sNPvMdo3f62FoE70mKHFL3cXXyV6e35KjCLguCPWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785443709; c=relaxed/simple;
	bh=30g6+52vpLwa+w0jwIJQYFnjqb/F+49RsIdPCA/cCGI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2LPmC1JrB68wsuC8Wcwninpo/rGi+woX45Zuh5QR72Z2xsepYhMMGWlz3gSlroFeWuxSU1xChf3Fd43uGPdNYlw91EFjTyW2UikOr/JZCLx9sBnbFcjOvSKghRn/mEW2l/wPvPPekXjRQ3QbyGQPg676dfjZbdeuLjYl3cDhM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FgE6wtnm; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FgE6wtnm"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so326439a91.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 13:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785443699; cv=none;
        d=google.com; s=arc-20260327;
        b=jSO/3M5ILKMRP5lC67faG3x9WcDKQdFqZZvaAUCmYWh3sasLMzHPmYtWzjJu0ruF40
         ru0l+t/znCixVI5q4qgAN+GviN3RYUEyVaP9TyII45/ekCvyRl8cGWW22xZQYIWBGD4j
         U22PkeEVb6DVsLfMuh+7W8JuvopnK/1E3JKRmimltUZhhFljBN+vxHPOzUL0QlPOVTwT
         0bA+CRwPo5hU+oSqTwyunZKYMxzLrl6qjeSeiF/R6C6uDU3/rSnxaQzhlQpF+FgtJk5l
         aEPpjDRNn3uVJSzxzfGWk8hY14p4yd6w53u4Y/QyYXiPUgurX4PHw4hFLeVaspAElVy2
         bB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ZeYSeUDQaPUMgdnk0OR676C/F3UEN+xBjEeugnIWfJ0=;
        fh=gEHYfu0ZwL5alEFwqWiHYWoasYomtI517QeK2jeNHi0=;
        b=EPMQ4Kja5Mf9F2jgUPuxN1/u119bwpMrEEgHpcdZqnZ3aFlev1NDzT0syebXO/UyMc
         O0NXdSCa323/jSnYGvzqcb1E6loM+bhsF6cW25rS20drYG3yiZ/nNrV/583qW7SCMu1w
         WMuUhgStPgcDfYLFoH/fS7Cc28MgesikqMiVWquziCCEdWUPQ/cTunIURlDxQdBN+QCh
         tdpxyzKXMcG1ahtcWhGTkb7KTJ/saV7JSnxwsilELAZKO/bJhLtcBOeOqH55x/LkpB53
         94Gjm6kOOQoomtiUESzH1EMLcCZvRZEPwFnXcyNIBkYNpffFfLUR7Bd2FjKTbKimm60l
         hNRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785443699; x=1786048499; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZeYSeUDQaPUMgdnk0OR676C/F3UEN+xBjEeugnIWfJ0=;
        b=FgE6wtnmAFYvzjw5wFWRd6huJNE8KA8k4l1SKooUBzxMVVwd+7U7VXuCU5YcS8WEaD
         Vrwj8/c1KYuw8fdTLncr9hVfiFepcy6j5dRZ9fvrnW83jJ19GTz2sSIBW5+2Q4pS8K9E
         UMd5Cbdf8rR/SH0v4tJFusrjrjdeJC2sNbMGc7S8mBDr4DcOPl1y6QQ/mQ7maFIYlOxc
         s6IGf8HwDp9a14sShNX41524Nmf94qkwdPAAyMei1hm6JRQTUL/5daQAaLelttfr7ZtD
         0BL/uLBgdiJNBdhVo0kkOdd7FcaoTCcJqUMGRL11vNgFqkNQTxkeQhFa6HrH7JjPNZNn
         hfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785443699; x=1786048499;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZeYSeUDQaPUMgdnk0OR676C/F3UEN+xBjEeugnIWfJ0=;
        b=rUSCgB6+banKiV7CMkXs1qn1kdvAWZyPugtmrXzTha9jh+SpGebGbv5JQvnA++At8j
         dj+eC0U//Z11ldIVZkeXfr9m6+Lx+IGKMc9/MqF5HDbO445mvK3uoYhDgJwQ+8rsHeIE
         43INBGxw31t9cFbBbeB3TY1diLBFOoY0XwGvqDsbE2WI+WM6/NjeimiHP+1UDYkwi7lq
         e/u5MP0/T2ApK4arJ/x8A0A8b80U1dHaPhakQsddrwP/hrfMbXbfN1mbvjXFVIDJ99Jl
         ToRIuyH8bNZTKy/Uf/6HepeYUifWlyD1SjCng7bLyCpatlYaMm/m0q9/cNQWGmojxVEH
         Hftw==
X-Forwarded-Encrypted: i=1; AHgh+RqxJqwn5Rmw1vGwMaKF0t22yDKP7qzb2bPPuZAwIXRizgnN4IrCxB9h0L4ksFzyv+kmiGfmeoJIXUJrGZ2YqIbowNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsG4cF7ejxRqgng03DZzAxv58D0zoHEbv/oS3Eu4gf9ySCislb
	tQ67agMVfsR9hCv/stJNXN9rnIAkOs62bb0YRfKEw7bF7zDwlxUQ6auFC18Wy1f6g/vFqhaDM0x
	t6qmqYwg10et05I3+MdoKYj8oXjawORz64hHlIGmt
X-Gm-Gg: AR+sD12bK+8KddGBBhK2Heocv9AyEy39NkLFrStMSBH+Zl71dFw1pqHdmyuQUJHS6lc
	xdO5XFseMQOfw9iuET5Ul57b4Pz/hJev0g8VJafgyPFDzQft/d88IBf9xGHuJRdeIVYVwzRh9zM
	muxPjPN94nfygZVicqpeYbPdqJtHD1RpQ6obZHPsOviqrXKj47c9VSuywrdLhH4837rTgqeMij8
	K2O6Kt6kTZOwR/CXIeTkvW30JKPNpmxQf4Ko3ffDTtb3UUpONuTtbW72Hasgywh/NbcCYCGk481
	mhsSB/NofZbqlAH3CRiaGTV2Gi1jac+AEVEnFBxC3f6im0mC0xSzcMxvg9QfmQSMEZmCBzv7KDv
	EUysVLshLqY3yHq9q03WIk6YE8vcy+3ZxK5w=
X-Received: by 2002:a17:90b:2c88:b0:38e:2c8f:a01a with SMTP id
 98e67ed59e1d1-38f9bda173amr3473378a91.11.1785443697893; Thu, 30 Jul 2026
 13:34:57 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 13:34:57 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 13:34:56 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <7dafaa90-f3d4-4be4-a5cc-472163f18040@intel.com>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-3-35f9aec2aed2@google.com> <7dafaa90-f3d4-4be4-a5cc-472163f18040@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 13:34:56 -0700
X-Gm-Features: AUfX_mzoiUtQGNkPMfuHgGb11yV4gcaKdQOzK-P2tpO8oMq-FVBJLM1nZe0Ady4
Message-ID: <CAEvNRgG3qXrG2ix2MEcyVo0GXaen-Pte4gFAwEN+9AY=VtGU5w@mail.gmail.com>
Subject: Re: [PATCH v9 03/41] KVM: Enumerate support for PRIVATE memory iff
 kvm_arch_has_private_mem is defined
To: Xiaoyao Li <xiaoyao.li@intel.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 7/29/2026 8:35 AM, Ackerley Tng via B4 Relay wrote:
>> From: Sean Christopherson <seanjc@google.com>
>
> Though the patch order and diff of this patch is adjusted to what looks
> in v7, per Sean's request [1], the changelog still looks somewhat
> confusing and part incorrect to me.
>
> [1] https://lore.kernel.org/all/akVGZOeR1ytfkamK@google.com/
>
>> Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE based
>> on kvm_arch_has_private_mem being #defined in anticipation of decoupling
>> kvm_supported_mem_attributes() from CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
>
> As I commented in v8, the "in anticipation of" thing is not correct.
>

What I think was intended here is that in patch 20 of this series, "KVM:
Let userspace disable per-VM mem attributes, enable per-gmem
attributes", this part

  -#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
  +#if defined(CONFIG_KVM_SW_PROTECTED_VM) ||	\
  +    defined(CONFIG_KVM_INTEL_TDX) ||		\
  +    defined(CONFIG_KVM_AMD_SEV)
   #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)

decouples CONFIG_KVM_VM_MEMORY_ATTRIBUTES from
kvm_arch_has_private_mem().

I get it now, so CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not actually being
decoupled from kvm_supported_mem_attributes().

>> guest_memfd support for memory attributes will be unconditional to avoid
>> yet more macros (all architectures that support guest_memfd are expected to
>> use per-gmem attributes at some point), at which point enumerating support
>> KVM_MEMORY_ATTRIBUTE_PRIVATE based solely on memory attributes being
>> supported _somewhere_ would result in KVM over-reporting support on arm64.
>
> 1. I'm not sure what "memory attributes being supported somewhere" means.
>
> 2. the kvm_supported_mem_attributes() will be renamed to
> kvm_supported_vm_mem_attributes() and it's still under the guard of
> CONFIG_KVM_VM_MEMORY_ATTRIBUTES, what's relationship with "guest_memfd
> support for memory attributes"?
>

I think another way to phrase this is that if we don't make this change,
say, on the foo architecture where there's no CoCo and no private mem
support, kvm_supported_mem_attributes() would return true for the !kvm
case, which is over-reporting.

How about this, replacing the entire changelog paragraph above:

  Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE
  based on kvm_arch_has_private_mem being #defined. This improves
  reporting accuracy by not reporting support for
  KVM_MEMORY_ATTRIBUTE_PRIVATE when kvm_supported_mem_attributes() is
  called with kvm == NULL.

  Give architectures full control over overriding the default definition
  of kvm_arch_has_private_mem() by removing the coupling with
  CONFIG_KVM_VM_MEMORY_ATTRIBUTES.

  In a later patch, kvm_arch_has_private_mem() will be defined based on
  whether architectural features are compiled in, and made orthogonal to
  CONFIG_KVM_VM_MEMORY_ATTRIBUTES.

>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> Reviewed-by: Fuad Tabba <tabba@google.com>
>> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
>> Tested-by: Shivank Garg <shivankg@amd.com>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>   include/linux/kvm_host.h | 2 +-
>>   virt/kvm/kvm_main.c      | 2 ++
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index 9f78a466c6f3e..c125d2e8155a7 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -722,7 +722,7 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
>>   }
>>   #endif
>>
>> -#ifndef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>> +#ifndef kvm_arch_has_private_mem
>>   static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
>>   {
>>   	return false;
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 902aa166c9c0c..9501dd8d015d1 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -2421,8 +2421,10 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>>   #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>>   static u64 kvm_supported_mem_attributes(struct kvm *kvm)
>>   {
>> +#ifdef kvm_arch_has_private_mem
>>   	if (!kvm || kvm_arch_has_private_mem(kvm))
>>   		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
>> +#endif
>>
>>   	return 0;
>>   }
>>
