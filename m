Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0E468C18
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851185; cv=pass; b=bGDKF6c7q478xSO7q03XAMh97yooopTd8iQWK/SbrW+FVtQirzNCwCtu8kvNvyE1LLxyQAEvRQ06fkVSvDdRTO5Wx9pD11Nmdo9AwYj7Eq4+H0sAZ1MMxDEvjgGFi6nurU0FiLayP5d24bSdNH4NPOeNhJ0bXlIQqlBPbWof9Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851185; c=relaxed/simple;
	bh=G5AgHHHY9jv0ygOB7Vo21BSZnxPwBZqAq4GmulyN/nE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcoYXi17+lWdTMsSCDZ8fBIPmA/7890XDgCxKQxj20gci74Y0VOQeKxUk4lOOdNBNTGOmP2I5RvGHB9Zp6iyREO6wR/JSsegbbCUfeDQLM4KDOYrcj3v4ko6jQT7kNJFSrbypqoLN+eBfR683oUWNm8GmvNk4qwZK0/d9aj6yLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mWtq8nly; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWtq8nly"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso2840326a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 06:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785851183; cv=none;
        d=google.com; s=arc-20260327;
        b=czZwETg8jtNW+KdU6+3AElrgzMFhg3FhVf6BB03WWdOhTiS8sz6vGvgDM5eooKi7Vw
         CHfYJww8Rlk45PWleAauYLmjJCmOu9pWhcbtMWP5PdaVgXtzvraobf53kmvq5syB9gMs
         GSGNO0hOFelZgStelaWW8hT5M82GC+Aj6su7a6qY5GjYI8tJhbXOLzrPb5lw8M8FGE28
         QcPFEABmFt9wtcCHpmNjFcR23U8qhhnBhHbq+sh8jc6S71y78hFvqFAgpHcsYvnydS5V
         cZ9vJE+3koQcncVXenskE3GF5jKlpF4aztHmvKzpH1oq/cuFHkIjWcrCJ7zz95JtuC92
         XuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=53G6mJGAaV7ofRwgRemJGkr5zkTXgvKFenxfcvtRtyE=;
        fh=VbhTAk6CTfc9Ytp07IdDNA58KzpRFmQmbx8jWbYGJJ0=;
        b=GCy9vrUeGhd7h9J6ERQAbS3gt2jrCXBgG4ap15Y9Z/u0QrBOr98FQM0eZ+lZDBgLYD
         rZLBfvHBYk85nnN4kVgEcIoFe0ZJ2zMxB0xeHPfCT1FWNhJjyQZDe6YjUCHS7e3IVW2W
         jKUeM3GuHGiv0T+bE6VBrVi98CrhBi1nrvmNyhQWRDDtxK47OkrBrfWhMyt5qm+dIw4W
         usJCZ2P32TwhjDshOY0Br+pbRsmu5eRyrLIVIxOuBM8Ss/jzx0a9iwPRpcjLHZQXHqGo
         A7PJ/lmY0bXnLiT39/e4xzp3/y6L0QMuaT9nBoWwMTRwBABqEPucCYljYiV3ngUYhrQM
         VWDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785851183; x=1786455983; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=53G6mJGAaV7ofRwgRemJGkr5zkTXgvKFenxfcvtRtyE=;
        b=mWtq8nlyYrl23egWBWkK24KaXetJVtg8kZISMcfdOwRnWGcHvZELwtAmKzlUcugx3N
         5OxRIsf2aFLr0ihT4DWBT4uVPAINkrpOl8/fIQkglhwEhE9XTA4Wm0Ar+XCLk15cvUmk
         CBQe4T20SEfQYj+jNmOj7pBbcHWQ7Y2OlRS2X/Z1ls32NqAqagUbYEZ+5jW/guBtE34v
         cKDVmRsfIfwqaDf2oW758H6ferBgjJ8Jcw2MMqGET+n0sZt2IW2Y6us6UwRftFyLQ4v7
         Hk3bc6HbM9kbqmfF5uvgTGdRi/GSgnNTdOAI03Tx93fbMd0D0/tUTwNIUkAf2mOlwdKH
         X67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785851183; x=1786455983;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=53G6mJGAaV7ofRwgRemJGkr5zkTXgvKFenxfcvtRtyE=;
        b=Lb1Dq+Cl1TRoeSFeO2MaDtk5xQaA3p6Pqb8NCfTAkZKYBNmFy8YKXf9g4OnaBzGGcG
         mKGMpoWMDnQi+JmfN0jjfWa+WaKwelGyDC7Nk3YO3c9+qU/D+K/hmncHgKUBi077RsOX
         koLy6kZNLcl6wqvHf15d/c7ltj+UyB14wjn7iIH5l4UtAVhxIseFSLLjGTKYAGaUdga1
         mDqf5Pwz+xlGD8Sffu4iAZ9zv1m2SCLTf8I8Ytk0dpQLk9JwSk7gTtEnUbNZ9LkceddD
         9sQCWONpSn0Gej7pu3tHcBz4x0qFwWIo3uUYSiMesVMYN9/2iPbe6Vtiv1me2Z+cssNh
         v5DQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9TCept3alqGVB8Egxqn3FGIbjd3MmpspfG78ytlTWfL0chPAO360I2glMbttAMfiYomjMMK+ZgpBjFw+SZbCQrl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZhbpsD1S65sQO+MGBFvVfO+lcFf9UityXVOzpm0AmReKBBRDi
	ppNHKW9Z/ZXoAIaY508f+Vu1JK8I4QCE8bl26ILUZtMfJbjCtoeIv94NZPJ9qq+gZcf6V9TJ7+y
	Cd3qRB9eyJ95NEyOFj/nTu8HsxTY0THMC/0FEThV5
X-Gm-Gg: AR+sD10hwgzR6cJ/k4/3H3qzyJ0lZjbkJo5PophFqhp6WV+Urxj++DK4xB6SHCAQ6rd
	TxpKti3ul6qFGwi7oYpVFzgce6jyd3DHL9W987f6WwlKKpvTlj6WOJbTmPnWLQNXubXw8KTQ3hP
	ROdkKjNZeg3osHpp6DA/hawrqz67gGqPSC8LZHVAbEi6oO4PNJ8N1cL8V0UwGt3Qb/do64FT/Bp
	TiIn1MTK61/+yB3vhMCdv26L2plFFdwPJ8HWV+vv/Igo1tnqsUe8QFUUByI4J4gBgwCS+HJxGji
	plP7nEtNnx7zfpU/p2V4kqhGZ/0SlGRZdUonoi7ckQyv4rdp9dbqzNarW7Q+zL1yrqlNT2Yjnq1
	aRpMsWQaIVFQ=
X-Received: by 2002:a05:6a21:9f10:b0:3b4:931c:3c7c with SMTP id
 adf61e73a8af0-3c92a7bb452mr15042590637.44.1785851181842; Tue, 04 Aug 2026
 06:46:21 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Aug 2026 06:46:21 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Aug 2026 06:46:20 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <amzIckjuwf0JfINI@google.com>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-1-35f9aec2aed2@google.com>
 <b78bfee9-29f3-4044-8ac7-f294b3cd0ad8@intel.com> <amzIckjuwf0JfINI@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 4 Aug 2026 06:46:20 -0700
X-Gm-Features: AUfX_mxGk5RmzD5OeFVHjblIz9X-b3hzxwJd1etRfElQwBfbfA_qJlZkICUGG7E
Message-ID: <CAEvNRgGJ4DQuOVafc8ipd8NGP+6y=dcwSZPGOjtrHBAGO7sB9g@mail.gmail.com>
Subject: Re: [PATCH v9 01/41] KVM: guest_memfd: Introduce per-gmem attributes,
 use to guard user mappings
To: Sean Christopherson <seanjc@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Jul 31, 2026, Xiaoyao Li wrote:
>> On 7/29/2026 8:35 AM, Ackerley Tng via B4 Relay wrote:
>> > From: Sean Christopherson<seanjc@google.com>
>> >
>> > Start plumbing in guest_memfd support for in-place private<=>shared
>> > conversions by tracking attributes via a maple tree.  KVM currently tracks
>> > private vs. shared attributes on a per-VM basis, which made sense when a
>> > guest_memfd_only_ supported private memory, but tracking per-VM simply
>> > can't work for in-place conversions as the shared/private status of a given
>> > page needs to be per-gmem_inode, not per-VM.
>> >
>> > Use the filemap invalidation lock to protect the maple tree, as taking the
>> > lock for read when faulting in memory (for userspace or the guest) isn't
>> > expected to result in meaningful contention, and using a separate lock
>> > would add significant complexity (avoiding deadlock is quite difficult).
>> >
>> > Co-developed-by: Vishal Annapurve<vannapurve@google.com>
>> > Signed-off-by: Vishal Annapurve<vannapurve@google.com>
>> > Co-developed-by: Fuad Tabba<tabba@google.com>
>> > Signed-off-by: Fuad Tabba<tabba@google.com>
>> > Signed-off-by: Sean Christopherson<seanjc@google.com>
>> > Tested-by: Shivank Garg<shivankg@amd.com>
>> > Co-developed-by: Ackerley Tng<ackerleytng@google.com>
>> > Signed-off-by: Ackerley Tng<ackerleytng@google.com>
>>
>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>> <...>
>>
>> >   static __always_inline struct gmem_inode *GMEM_I(struct inode *inode)
>> > @@ -60,9 +68,25 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
>> >   	return gfn - slot->base_gfn + slot->gmem.pgoff;
>> >   }
>> > +static u64 kvm_gmem_interpret_entry(struct inode *inode, void *entry)
>>
>> Ummm, I'm not sure on the name. It doesn't look like KVM's style?
>>
>> Maybe, just kvm_gmem_get_attributes()?
>
> +1000, "interpret_entry" is extremely vague.

Was a little stuck with naming, my frame of mind was that "entry" is the
attributes, so I can't get attributes from attributes. After you pointed
this out, getting attributes out of an entry makes sense.

Will rename to kvm_gmem_get_attributes().
