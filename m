Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A630CD9E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 00:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782260082; cv=pass; b=MkawkZAJQhTnw/yaiSvFLe8IPYyPbyiNiU+qeT7JLCBiXTzQmKEHvJtFNn56yvvfcwjMDZcvmYsPxN+JggKHOnXs7wpsPWaPc7tlSLxtRR++MeVRgP+Jl9Bgow7jQUAco23n1ohXPb/nxDsh9ZJKTj9dKazS/9pN1kaECWgWrVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782260082; c=relaxed/simple;
	bh=kcSIA8QoE0LN3l35tQtfo0jow3WHaPbc3lLYMPju8ik=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAckUalAg5suVgJUltV+f/Jz2/SqNfmfBaBbOm1fCOnPUAg0adAyyVV0fYXJvPabz6q13sRSuEo44kgVLp0WzxAF6TZ7j0uFGt6tQiL5bl7CUgLNl80IjSapEBy/JtxqzYaGISAMAQNZdIHB9m4qzpC30mRYXZwK8lpuWqsLWZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LLQGNMZN; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLQGNMZN"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-13986d61b4eso901023c88.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 17:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782260080; cv=none;
        d=google.com; s=arc-20240605;
        b=FW2C77C7+iqwkXiKIJXTCZBTNBkHLT4pj3ton5wUnHk4QSScwMA1Rnt7CYng4eIman
         mu9kPE9reXN4ua7oEZdN7f2849NSTBX0fjIrZ5yORDC54+496zi/jOOstisaDVHXTj0u
         Ue0HmMn6V6u42lG4ht+aSsapEeQosylhG6/kwiZ5JBVhWBlFnHCWNalBYJx/TaHWa9pr
         oP7YRfgyrlN+ny561d7TPcJR3d5PjRyFpj+mWzbzWLit3mfg3bSYnbZGDQ76v5tCr0zz
         eUcbCNFgnOwBBKKAAmS+ShULbmlqmbWLsavfDH4D9+1UZkzlMHPi1OANzB4giSFvT+MH
         33PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=5cZCA67GzL1hK3vWmOV/udgJCrdJrxhZ2WqGtT4YW1w=;
        fh=TTIoIMf0WikSw2blXLqV9HeAg+oxvBNXvDnnkV5n+Io=;
        b=aivviDofFr5Qs6cKaAqYrCg5H8B/OTCYGLUqXh9etc6SgcPcMPS2eAq1exZQCq52YL
         q+/eGp8uEgepEVQI4pWvhxQQhqDs883xsnYq/ljmq9/rrflhM3TBNHhxdjorVNUQyZfQ
         LmaCRj6ZRJzUy0ZYij3m7fJQLFSvG7gUzNBwCM2IjDL3WxKnIA5ShHDP30t4fq+0US5B
         oe8okxqLZ7vdNRKBtIBqb2AfvUbpm/81Ejk3nTnxw4mHepIE86rWYX3bB3oMbZfzFTWW
         UwYizecxi2g4RqUp9lpuuVaNzrwajtUls1F6yQYtf59zTB0IW/jhX6n30CH4ERh/5yOo
         4ZWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782260080; x=1782864880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5cZCA67GzL1hK3vWmOV/udgJCrdJrxhZ2WqGtT4YW1w=;
        b=LLQGNMZNBVde46DeOm10QrXFme7gPCLlmzfdjn1u29omu4Ul8I2WMRqAGvKGTWmeug
         p5SzL/dv2Jbb7ZxUU94M9T4VuzT5pDrNWMNqJJJQqzwPd9Evc/PLxdGdpyzdE8Zkwalc
         YSJ/2mV3x9o8WUDzo6vvCjoX6OgPDmoiVdpZ5ltMW2w+SsdnDRolaRUgug5/gZhWLI8n
         26qEZawRYF308lK36dmIOVAm0+eXufYvwMrmcumR62LukVdGOw4+U3dhIfl2YXAYS+MQ
         ZrW5i607QqoyZ1k4daJMagtAkfWdMAPjtxsMWAb2BbuI99lzK7cZviFIBLoI8+LZhjrO
         K8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782260080; x=1782864880;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cZCA67GzL1hK3vWmOV/udgJCrdJrxhZ2WqGtT4YW1w=;
        b=dFgZItBoqYTS2lWqIDHsqoROXI03rBZHoGlfxI+vmTdZm68Oi/rXixnfBbU2zCRkz1
         DcwW68GYYSS0hp1Q59YZDhO+epXNa0i35EWOXU4VDM9RWazOtL8OVNsLHjf5pHai5A0Q
         GUX1LksHiVKO0PbCNnssg22oXbjF0oYGwTNuI236nqeE6ByeX8BeRiSdmLt/1qzl7CIl
         dcrUUlYKb6f6p+XKZ1JOvSc2scMTbgwEDqHcEn5oXt+x9LRVTY1CRAC+R01bOteOlu2a
         fO08gqKrZlE3ut6hSdA5HB3yQNnCo/d/sUw8J5wM2pP3IqnBI8O7pWIltZ+bHO9Fi6YQ
         87yQ==
X-Forwarded-Encrypted: i=1; AFNElJ+mBEk0/T3YbczbJIRrvygnhUQI8zCeRN1sw/napcv7GC3k2GTFUK+DJUI/QtuVBg/tbgh9FHjRsRlAt6sBuHWsLII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkgvHyeleUA6M04/HNe8poY8UjcOidgR8pg5nCb25L2abs49uy
	nk15nqq7x488uTozp07GJms8zOBTifLLqnyV2IM7MOP666qes242FHKK132DoNEGyP/WbWVo05b
	5VGDjJjvDnSik7htUuMVSuiQAubBYDnH8yvfOht9z
X-Gm-Gg: AfdE7cnX5zHcVT01m1PynT3D/B7gg1YFMGL1UbzrTPjNnYct+oBs7vU8d6L26dKaIif
	VMFErWow4brwsxLb2scs9iKeSux7rWqWJQR0FduDo1EKReuu1teQ/zWhkuvXkCNqXwqDK8nTIGc
	JBhEMXKQ3dN7NpCx8G45aDfmNTRWzIzCw2VqU7K8iCSTAVb4HxUqCbUkdJwffjRv7vl9ISgbK27
	P7g9x7VS21cArdtGn7MxEF+8pHomJFoJJQ1F4jKm/+QfYAnD+pcIt6tBoxmvV7N7Tk+G4xt+fdM
	Z6DnukLi2EpsJUBpfy01POBkgblum7r1ADfdxWiEUHNsUiTDO+9CMtL5zmI=
X-Received: by 2002:a05:7022:7a4:b0:136:5e4c:7aba with SMTP id
 a92af1059eb24-139ad6ac8ccmr13781633c88.16.1782260078995; Tue, 23 Jun 2026
 17:14:38 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 17:14:38 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 17:14:38 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ajnQVkLvFl_lMuGB@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-5-9d2959357853@google.com>
 <8e53844c-f2f8-4a4b-bf72-f3140c170d43@gmail.com> <ajnQVkLvFl_lMuGB@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 17:14:38 -0700
X-Gm-Features: AVVi8CcXn2j2iTyhoMEqe261E6HKS7rSa97Iz0Ayq-UgAfPllC9cKLpff9jWWSE
Message-ID: <CAEvNRgGhWL-tWfu8EHf-zsU4C127xKT2wyV7wMBnLKs8g=pEmg@mail.gmail.com>
Subject: Re: [PATCH v8 05/46] KVM: Make CONFIG_KVM_VM_MEMORY_ATTRIBUTES selectable
To: Sean Christopherson <seanjc@google.com>, Julian Braha <julianbraha@gmail.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Jun 19, 2026, Julian Braha wrote:
>> Hi Ackerley,
>>
>> On 6/19/26 01:31, Ackerley Tng via B4 Relay wrote:
>>
>> >  config KVM_VM_MEMORY_ATTRIBUTES
>> > -	bool
>> > +	depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
>> > +	bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
>>
>> Sorry for the style nitpick, but could you keep the type and prompt as
>> the first attribute in the Kconfig option definition (like the other
>> options do)?
>
> No need to be sorry, I've no idea why I put the "depends" first.  I don't even
> know if that qualifies as a nit :-)
>
> Ackerley, if you can provide your SoB (for Fuad's feedback), I can fixup when
> applying (assuming nothing else necessitates v9).

Thanks, didn't notice this when consolidating this revision.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
