Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E3F438019
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786656245; cv=pass; b=LJmbv1NJRmcaY+4a952Emf2gWe43WJKwIoTNdSDRcW/7XHpoY928EMNLihLIZf2A87JkyCsg0r48/JwtEjJVj/OFXyhmf037c/wmnMfrRjRQXiNhkpN7cxvIp8LQ5n94PI+EFn/7Gx+NmWL/R3IW9T35C0hwR/fVvtru5gt466s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786656245; c=relaxed/simple;
	bh=qX1IR39uVwaDaiwu+D13suWfX2py7eKUr7A0OiCh9ro=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abUTOZZww6QiVqmgP9Fjbak7IlRNiAT0F3ThNgEu6CcL5lNEssKL2wXTWRVi8deRsa7IFbo5bQ2gD+B6GTydfY4YjbddsRDcZkrE7G4CGPksJXcBJYtQkBbxgpyuMotvAe1iD3+LQIAROq3aPv9PYDUroeAbe5RJXvgzMq52GnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmlSZbTm; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmlSZbTm"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso4045535ad.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 14:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786656243; cv=none;
        d=google.com; s=arc-20260327;
        b=A12lxQDjbXTkH0V9oazuF9Vn13OxqrafSR1bvOZGxMZCH7XjHbYWtAuHrNqjasCwgY
         LPs0jWwGVLilYmdcKg2CVcdjcRiQ3W+AvEKcurtc0jMUQ1qc7xoSuaX5llhLli4TDQ0Q
         UWPKeK7MpF4CEipqCAQa3WCsFFAGHQJQqQt5PxGvDI7fwgYBQ9qi3FvwzOAdHYUmxf9v
         Lb5VvyX0xU/WNBzjgx3R//v7KRYKZr30gNJDE+xWJGOZ7f1GPx3JJKXdBC0d3AUhZhU5
         EIGDA3D95C34QjgzGunUFf80tR3K4E60LaOeL2JYnGwy1cBKqhs4EKFBrD7BH8zOHfaA
         kDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=FJck1umI1gERxZKqi/mE4jPaeCUw7jHUSxZxlUOvdoM=;
        fh=TLWv6V7egxj56PADfVhpr9s1t95nys1peEL5wXUe2wY=;
        b=Zvs7Ucl7N4DGvDTHquYZweArITjoqjhLIALk/0+End1swJyvKXE7zHs0rTDAVzftAg
         rgvjNEEDFAu96MvmSUOQadZMyV+MbegaxXrdFLupyCf8PoVeG2RKSvW01fAizOSwA968
         COYM70gpVdcENsbXShra9AaREUTL+7LqFs7CAJ91CljbrvJc9dOTiTX4CYn7PlRCcvF6
         G1JWzgvgkCOe4nIkprwcY+EWoVaLBQBgzxIPBCn6dBAVBNNLQT/jC159KZIG58H8/4cP
         VrN0wyTNEb0uBrWRamjYs8nVu81UFViht1pQ4DCgwLqm3VvQsyjzliR+zwErnvBHDAyR
         4Z7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786656243; x=1787261043; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FJck1umI1gERxZKqi/mE4jPaeCUw7jHUSxZxlUOvdoM=;
        b=hmlSZbTmcwlzQzA4RAjRnm1zAMk0yOyDyMiwa5V5oYk5WEKaIOXTCuTjW/Jlww969n
         RaLdn6beYoaRoNFonZ+vIsG7xCCg850Rll5+UitkFZtfYQNfslPNDdeBtmwBg2rli2nU
         MXkUnasQN7YFrsk8p/jha01pyz9cF+pDF2TJhhkTEpyyefnyQE3q1OOsiPiRx7shpwi7
         kjJwqQkjUbmXB9amDQTCo1siV5u0ey8SE6OzW+nyNIZsLGZ6LXYqWXWz3tM1rOwqUHZo
         66SZmjsv/sgA4jd5zAufZ8uZGxGdzR9I3b4fyErxjshJDf+8pU2H+m/XeDZ4NTnRVx4V
         Ef3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786656243; x=1787261043;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FJck1umI1gERxZKqi/mE4jPaeCUw7jHUSxZxlUOvdoM=;
        b=jMrcX+Q0JGKUyNJF0YD3I84wTdHfET1LC/X11SDibrFs4f3y0FxNFAshL+5Wc87vn9
         pvOvKY/UXTJH5Wgpe4/Q+BA7LVEAe8EGZB7/6pXnxt+LowjvA/coj0tQT7X+TqALoWN/
         MDUKpihSOy4dQKMQeMXHh8OnvI4hFJQgPN86ab6qLiB6XIDcmNk33Mb0+358I2wt3zuF
         wmgnzkWr2CQlufeG7I09rSkkrkQ0HCB3xSGvRz6QmYHXDiV9qHD5kIxB6aZeeQUEROJV
         wrT0pEzgwdDpbt6P2sLBl6k29pR5BO9K71O6o2FpfDxrqsP2mJC+2/D24Tb0a482AfAM
         /n7g==
X-Forwarded-Encrypted: i=1; AHgh+Rrlsu6Gqs7OquSRNxovu8y++F2p6oyxOyQ7DQ8C8V8RuQrFK6yuWSfarJ7qIUQl2HsCs9Ea7YOqhnusB3oJrwp9r/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrE9rhuBz36bsRm+s5XQGO2WL+eEOkUPwNn7i/6WlNc5fEqlwI
	4Li32gt5pluQZ3yr7E8ld/S8dZ9NEUzBq74Dhs0eLGqqz4flcgfS5F2wIcknpaw9YZ9roBq0PJ8
	R/iKP0wwMhk07ckz02D/uU7qxbiFTC6IbxFkvbgO8
X-Gm-Gg: AR+sD10NtO2XXMX4ehhuIhAZqVH9Ufk3GwFC8CObZC8X1TtV2a0agXRJ8DQxSmFpfa1
	0ZJ+1yqEkbzr+KrfqMf7AjKekqv5WgAoQ1TI7LzR2FGkZpsXq73TNTIdxtqEyGRkrXukqz3UtHh
	ctsTKeBxdm3tHVI4++MUvm0GwHWVu4+y83f562icLcIdBTo8D0nbzRuHSkPcTV4En3XTx4+lbdR
	f7yHXyejpJPW7DLgokwVKt6Z6aa5OScAPD4QoxR/Y1RCgFRupP1Kkj1A/HDjiPzM55IRB/vkuhB
	EKxAIe1u4vO63qzyo/nH7Ck7AJ7Fc6cIjcwwx9Cqko8TBym3ay/3j7tS3bDav1Gv5hsSOPqN7yF
	KGZbwUI0vqRUC2/laqQkyuUl7FVtKmQ==
X-Received: by 2002:a05:6a21:a4a:b0:3cb:d156:d362 with SMTP id
 adf61e73a8af0-3cc7196e785mr831997637.3.1786656241969; Thu, 13 Aug 2026
 14:24:01 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 14:23:59 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 14:23:59 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <82ded1ea-e0f6-48d9-8bcb-38a6bc5e9176@kernel.org>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-20-2fc18ee6d3ba@google.com> <82ded1ea-e0f6-48d9-8bcb-38a6bc5e9176@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 14:23:59 -0700
X-Gm-Features: AUfX_mzbri1ixV_zlf2Jna8d8Me5Qvc_rxP8xrcIgsSaQjjAlnxnniHAuo3sYt0
Message-ID: <CAEvNRgHpy52iynKfXeEkyCixhhu0_Hnu5jSNT8i+BNxvEoG7Cg@mail.gmail.com>
Subject: Re: [PATCH v10 20/41] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
To: "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> On 8/7/26 23:52, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>>
>> [...snip...]
>>
>> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
>> index abb108886733a..2c3c22aeafa54 100644
>> --- a/arch/x86/kvm/Kconfig
>> +++ b/arch/x86/kvm/Kconfig
>> @@ -81,13 +81,21 @@ config KVM_WERROR
>>  	  If in doubt, say "N".
>>
>>  config KVM_VM_MEMORY_ATTRIBUTES
>> -	bool
>> +	bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
>> +	depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
>> +	help
>> +	  Enable support for tracking PRIVATE vs. SHARED memory using per-VM
>> +	  memory attributes.  Using per-VM attributes is deprecated in favor of
>> +	  tracking PRIVATE state in guest_memfd.  Select this if you need to run
>> +	  CoCo VMs using a VMM that doesn't support guest_memfd memory
>> +	  attributes.
>> +
>> +	  If unsure, say N.
>
> Hm, does that imply that a distribution that must support both, cannot ship a
> single kernel?
>

Did you mean this as a documentation comment? Should the above read:

	help
	  Enable support for tracking PRIVATE vs. SHARED memory using per-VM
	  memory attributes.  Using per-VM attributes is deprecated in favor of
	  tracking PRIVATE state in guest_memfd.  Select this if you need to run
	  CoCo VMs using a VMM that doesn't support guest_memfd memory
-	  attributes.
+	  attributes. Select this to defer selection of where PRIVATE vs. SHARED
+	  attributes are tracked to KVM module load time, where
+	  gmem_in_place_conversion can be specified as a module parameter.

	  If unsure, say N.

I think we should do _without_ the above clarification since using VM
memory attributes for shared/private status is intended to be
deprecated.

Is it fair to say distributions should not support both, and if they
_must_ support both, they need to read code to figure this out?

> --
> Cheers,
>
> David
