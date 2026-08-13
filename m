Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C493F0767
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646452; cv=pass; b=jhtcBe6ftTlxtoFQ0QsHEZvdAdz+OAgfUAMNTMKw9qxHhhe1OjdCxkxSwkY2/jJJO+fxLi68jEOqnzqSx5PdqnCVK2ALCkz4A00FgKXO7eRaiVdJd0W7RkEHjpsBnztwugKo3pp4IIBWERHmeLPeE6HB5fgREYmfaJAtgYc8ePg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646452; c=relaxed/simple;
	bh=SmuHUPl640dUfP/T8wiC16wCTI5Yqb/6dnMHylHeXNU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo8dJsZNV3L1t5L7Te5uPh24XGZ+SP2NHBm3+JU1OLTqIvHqcYaNeOo8J7fdPdvNdOdL3HFxr/FS35JhqIVCtn+Ju43XVRKeh6M48ibiOZzmsY8ER5vQ+0tehLDtxldAk4ydDyCxbAMXYR6uoGUzeeXORsHNtR01LFQoSDz6LuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rtH/gMxx; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtH/gMxx"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e08baf860so155559a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 11:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786646450; cv=none;
        d=google.com; s=arc-20260327;
        b=Ef2Sm7GqHJ8JUweifumpjDovKj3qnLGC3HJ4YS6g+lFHpk+bZebQ34I+dlGCtcxF2Y
         fDp1Gj1OTRl/cXh9LFUZd5VYIAs5QR0WOqDuvVu/1Hy62ZImhH7l+vfTD3ub1EYvf83U
         v4730K6e2R33xNjHJTT7zJw/gn6DjrkuUcTsmHEANpQ8f6eHijo5cPATP9E9gyMlccKS
         uXELOaCICY6LaewjBvd6Z2lLXkQlpvndum/GNAB1d0w5zAb9j858Y2IspQUPAWAarNs5
         I7aP6PEH7Uzix9EXqKkpwPKhMoJOUMKOj4Nmc9iHGzONbasVoSGXks18gmZ0vx6azzDC
         cKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=FfCarHoh7qSi7mQScz0h/iOmFe8yy6xC72Pgonixm98=;
        fh=8RflM04NQEHwZx/M0APpl4fdBf/TkU8hp4J2tHPgxUQ=;
        b=hHRKVdeewsjEqIZOsTQAnbCGjwjVc4J+/p+101S2jMUAuG0Yu/38JRBczzWT2GC0CK
         ajjCW3e3OxVAFyJf8XyB5McbtaJmfJZDt4/6iLH/0xIDOl+Uo6V+dRJtIU0hIkfPUyZX
         vGLpu2P4dGauUifxL8nkc+Ghs9hUiazHtuo32mOvUVE39h3j9jVPIPCoBbJcpf8cLVM1
         +gCLayK+EkzGUjDt1KAM6QX02og4U3OgVqvPG5GQ2ekc0rhk2OsViZ0+ffJKAXQV1wSO
         AvYbAtQvoXlglUAVLih/twieN3rH3pioOg6GkNZGLYhOzFli6DLAI4DlVSJrFocoMQ/q
         4CCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786646450; x=1787251250; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FfCarHoh7qSi7mQScz0h/iOmFe8yy6xC72Pgonixm98=;
        b=rtH/gMxxvOe2cU1ddqq4AyofAT0g/9O7Nm6G9AFpyc+uZP0jsMvlRGGCAE5IBoNkZB
         0diVPyDQ1x3p14dcs1583lrDRK3j45lg1uw0+J0o8+bRphMPncXVJsOAN17QZEReqvBY
         K8eTzDaGtAHTc6Ps1tEvo41etvQTw1sTDz0fh3MmpoaGm9jPcg7HwjwoYMCEaLtwKga+
         zOfQ+5xL3qxCtUD63k7wyp7KM2uHTzjBxs+tzuphLoCYJZTogggHTYc13cMz7ERNxsPJ
         Q1MakAvGm8oZmjKTMQU2lsN1VuF0xggalJl4t6iSQxs9pMGoeUoJr4OApLPSS5tGyxX4
         /SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786646450; x=1787251250;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FfCarHoh7qSi7mQScz0h/iOmFe8yy6xC72Pgonixm98=;
        b=QjCqaF5v5mn55riOxhq+xWQ2EMjgdDNHU5rHX389jjMJizVjR4xPkUdqAjD6DZIHqe
         t/XHXgDoIp2H0K5AIgL3iFQCyX/CEd3AOuhSbE5O8CtzHSoU0BysJwUhPBiaa3aJ294U
         1MnxFqak48dvr8rxnScoYwGQr97OEI8aNPSqSTHM49r5LpoRVhNekSIj0PILe6/nDltu
         RKd0VtniYjIm76MyqyWrZre9ktFPVNWBxPSdmuR2ZOG8Vo32CXaklZCNsDnoVFMXkjEO
         JSA7HIt62B0LWyBT+UJacN0+CNRpGmtB2Uy7Ji1ZVric/KBMWTB6l5RmYBSoIP7cnPvI
         zJuA==
X-Forwarded-Encrypted: i=1; AHgh+RpIRK8b1R6kpwUkZyVHBiYuY/sbq4d5ys9cgAuNwlACLS5mD+vC68aFJlhTeqY69uUaAS2TSKLOLRmw+DV00lbby9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8hXVdqdWk4LcKlXWZUEAfOB6MXZfkt0gg36v2NkL5TFb9S/6E
	nAsH4II3tVRHFRiK6LcUccDwC/lPBhDh475XwMj7UDQ+a60kAinW8OYWzwgAviz9YrqRpxePZPo
	2P+5KQbnqPyIg3Opx8fBoCpy+3W1ieQCaE70HEheD
X-Gm-Gg: AR+sD12yFhWIz43/lrR0WHRkp5IXXRCbGAMuPgmzldWjAAX0b3/5Y/KaOUXJyKkQiCZ
	4NMOuzxNzYJB7upJzzSOqVqhPi4oAwBcnzmFw0b5VVfGx8z6gx/XxCZFwUFSAf/C7r1YFz4eSLS
	AuSv2XIX80li7CqdlBxg2KLjhdvi/0ZAWDgvWOzcMdfJXVIaRlGR6jEdt+jiywa6rX4jZ9oCqqy
	t5A0DWktORse8ssFsHwb2Ua5z5IepbRlHXsM3jRIPQdYcdr1DCs8FomqkXB8XtYFYREA7Odolvp
	PnfR3W/rrgWD1ooFewRfsheSqWRWyFcLcqlp9wo+QHvoX0mTqctoFCyATAkllsmnoyQ05Ujtb7x
	wJ9wPbyMFwMF+robtHSYAJcYY8atCU7Y=
X-Received: by 2002:a17:90b:1c03:b0:38e:2860:253f with SMTP id
 98e67ed59e1d1-3931e25f24fmr8532991a91.12.1786646449351; Thu, 13 Aug 2026
 11:40:49 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 11:40:48 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 11:40:48 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <cc44c9d7-a6cd-40a5-9f68-4822fb9c9d0c@intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-7-2fc18ee6d3ba@google.com>
 <ed483d25-d908-4248-b8c7-862dd35dc6d4@kernel.org> <annnrGR1noVuBkCc@google.com>
 <cc44c9d7-a6cd-40a5-9f68-4822fb9c9d0c@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 11:40:48 -0700
X-Gm-Features: AUfX_mwbi2KKm_8JKoJYp71B4rnhRB-DpUSQbtCK9ZlqdFzmBXno1Ngt_qJ6KFA
Message-ID: <CAEvNRgFd-6-QxR7w8SxPRa0UU+AAF7pDupLP8cPbQ9y3m=2QVw@mail.gmail.com>
Subject: Re: [PATCH v10 07/41] KVM: guest_memfd: Stub in ability to enable
 in-place shared<=>private conversion
To: Xiaoyao Li <xiaoyao.li@intel.com>, Sean Christopherson <seanjc@google.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 8/10/2026 11:01 PM, Sean Christopherson wrote:
>>> As mentioned in v9, the name is confusing.
>>>
>>> 	kvm_gmem_mem_is_private
>>>
>>> ?
>> Ya, +1 to kvm_gmem_mem_is_private.
>
> So kvm_gmem_mem_is_private() calls kvm_gmem_is_private_mem()
> internallly. Ummmm.

How about

  kvm_gmem_mem_is_private(kvm, gfn)
  __gmem_mem_is_private(inode, index)  <== this is a static function
                                           anyway, though it calls
                                           kvm_gmem_get_attributes(inode, entry)

or

  kvm_gmem_gfn_is_private(kvm, gfn)
  kvm_gmem_is_private_mem(inode, index)

  (rename the vm stuff with the suffix gfn_is_private())

or (current, it is actually weird)

  kvm_gmem_mem_is_private(kvm, gfn)
  kvm_gmem_is_private_mem(inode, index)

or

  kvm_gmem_mem_is_private(kvm, gfn)
  kvm_gmem_index_is_private(inode, index)
