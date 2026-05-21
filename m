Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5961B401A3F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374415; cv=pass; b=QNgHzS6Q1Fp0/4/5sJfJn2lC2iGcfrh5t0bO940o/yi+WsF2WJEY3lg0nIYtFQmfmmzmoUMs5+Mixcd8pZgBlYyne5+9PR8NcmcvRihaBQZeDOLRFyq4f0DIPqHLJlNpSuxXOkB6EBRspN1ov4ufjhcCzMHRC6AG3XAMDqJ+L7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374415; c=relaxed/simple;
	bh=RPARozcT6UfC6sMpVhy6r4Aiv8XaW0DBJyjeK/ufCb4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpH5eG+gCcMJ9hilPohU2DtqlkxMWL8VxL3EmhXAKXECl6UHUNzL9tXSAOB3aUzIgNCRoKhjO5hyOiFt3zjPrzgLqxmmyKk3KFrdVb8LcPqmt4G3JCpviCelyoBxLJdpMhbeIywEBs8IrZxLPCMAlWnfJR7isVrsMQVSV4zO7KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V9p0GPMM; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V9p0GPMM"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-631ca15d35aso5560582137.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 07:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779374412; cv=none;
        d=google.com; s=arc-20240605;
        b=TR1NYUK9sNNEOgArEzUlQrBx1Zp9QeX1ssadIh7/VZtRRvOfthjDHOyAp63soWDCEV
         D4iUfceLndw18Jg0zpRZyv3BCoNorkFkZawcax3A/e7GlROBcXOtXpvvhNtzfRqJZKLD
         VlOcDRdKlqbgWhxflf71doulUqPY9Yz1EIunf58/i/P+2Ub/7o3UGUFNVA7ayQnpBAnB
         4Cv5JpPlySbbNlc5YB86JIWU0PpCmnaZahCxmhRwr+poEEGB3V5a1dTwmc/8sVTW/Df2
         +ZkM+Q+K3vSFN8sWvTTy/GfqfeYBY4pJQ10tDh7F9FSfwI22ZCuNq1LARsBzmyCvONJi
         ogOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=pETZ8fM2HZBGp3r6phdANPEwcKJJ9mevi9pfUImaGvM=;
        fh=535rmBGBK66+3QWmsecAJMaZxfHWoToF3mgQwo8Fg80=;
        b=YeBLP2uEQhW1Sei9LrtSFzXkuStXZ9z3Dm9cdTZshRCBzzlTK0HpLD3bgfABcjRIWq
         R5t+3DmmHN3WvYnfHkm8pOe6AcsL9xJknBR3j2v8NrhZU0F3bBNvLND8NEMJm4nEHNRo
         78N2OgEQmmER934iA888Ej5yZLl42lz62fbnOXaIWqx0MimCv7yFedSy34lEyQx2ExMn
         ZjOd4pkggJ07cPUQR9xv7jJJ28YBJ2M6iVTwM/Q8Ej7Nk2RgOjzbnwvDUPKn6q7rJAUa
         zdI9m5U3p07DtVOMwfPYRTqWUEAD+enYSrtEeek3kN7hHbkfmTL+7m279gAKXVffPSZ6
         AFPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779374412; x=1779979212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pETZ8fM2HZBGp3r6phdANPEwcKJJ9mevi9pfUImaGvM=;
        b=V9p0GPMM4JoAoxY0vDgPfychMd8I2dNla96qYqWgPvlZ0DjapntWlKuDNmOjfW+/XW
         +IMGiGnTtURerCqRqPJQrpRxyxBf/qdaQIONZqce1kHnH+9efXUw0bi5zweZjavzLg53
         DLSTVoI/XsPLkgdTjBzww57u0BKReUP3QNqC6y9NxCJ4uigCAAqF1xD1Ckt2XEbuX4lO
         i9MRjTpHgb+xv7cdKHe9yZJ8ko17HPICKtxup56MY8yixmjhhW5iItr94mePc3x+Dpm1
         KM2Z+jwV41cHy6IulePecYceVwzzuxIUO1BCOuDRt+se4qKkmsh/i9pwQ0urySguHFzV
         GvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779374412; x=1779979212;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pETZ8fM2HZBGp3r6phdANPEwcKJJ9mevi9pfUImaGvM=;
        b=T7kHRVqHluE/9jLGicTfm0lhGRgjehrlF3H1kAejFUqu4LcM9GOqC+mEyg3bdo7pWT
         G+PoNhDiXQmNhArB2+S4GJI5tVw6NqjwnZtM4oSgFYL7a4gadmxKNSjJDlKEpLIyIWJR
         o/jlEbSdIBxK9ZBgeQewXHiSqZQsTat/IQcg13mMmbpnXRlfYiR7j3z6QvtKZ+BM7WKg
         49tjFauToPKTg1FR+/bWIEQInQIodwlQuqfy5eKi5mvLAwB66oEc+2EoRGMuiJpPfWiG
         oo0fKJo06WIWsTQbYyC+oHVhiUc17Hd8zhefaEzSIZGDeKqjPfiY6RO5/7UQFTjcdZ+6
         1DFw==
X-Forwarded-Encrypted: i=1; AFNElJ+j9KsJcwBGoi+beqvLlNo9496jCN6PZgUnE9yTyK3pR53S4NulFInpOvf8iqiXhDlzL/uI3FqO7bk+plSNfQVW6uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxStXNoB9Ky+e5AFLqpCMXvyOzlceNOhf5G1aPBHucD355bDJKu
	JcQY0z3Jq66Mm9oV6wQqNH4YvL6WRHlCXW+4USrbLJFTIeE7GUG0DXDxUXd+fcNJMtrfOBlu4CK
	JVpXOc0xEO8/twz/70XF+prPmoCHZYpTlMCo0RlFK
X-Gm-Gg: Acq92OEgZUeWUUpFqZOcJe+jKv6asud9zHLfxgubdDANGNG/JkEngAG2hAlxNBPfpiZ
	WeuvRIP/GC+Mc3gBHGtasjbR1PjuSIBXPhir1/SQIjvRxoS/aFoUK3CI9SpWiTGOMcdxCk48RHI
	ZgcGfZz50N5razfWkLFk9IV/4Toxj38qtE2uhHwz9A9hH406CsyyDsp8LZLTsLRL21ozuW/wuXm
	8DENZcZIAmJIRQKmZTJWQCszzZ/0CAvYk1hWdnbY1peYojwzy/My+6YljGBVwmw7QsEIjrRABFv
	C0Nz9abaAkMyOQax3FGazc/MjI8my47zuJwSMkSXsQvaK9d6rA==
X-Received: by 2002:a05:6102:52f:b0:634:248f:bc04 with SMTP id
 ada2fe7eead31-673cbd0ce21mr1147276137.10.1779374411627; Thu, 21 May 2026
 07:40:11 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 07:40:10 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 07:40:10 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ag8BmtzxTlcuA_zy@google.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-16-91ab5a8b19a4@google.com>
 <CA+EHjTxcadguOfOo7RpJVtAzcY5JAFZTbrAT_wcN6akMi8gCUg@mail.gmail.com> <ag8BmtzxTlcuA_zy@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 May 2026 07:40:10 -0700
X-Gm-Features: AVHnY4KEEzPCaNbBUek3sDUc3FN_Enrlvw5CRgr6BoNKh9-pt1QUYC334HSuCXU
Message-ID: <CAEvNRgGDL=_XO3z=h2RLqb_gZFe9QtxwiMFJHCzQY3HEoaUfHg@mail.gmail.com>
Subject: Re: [PATCH v6 16/43] KVM: guest_memfd: Use actual size for
 invalidation in kvm_gmem_release()
To: Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
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
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
> --- virt/kvm/guest_memfd.c
> +++ virt/kvm/guest_memfd.c
> @@ -640,9 +640,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
>  }
>
>  int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> -                 unsigned int fd, loff_t offset)
> +                 unsigned int fd, u64 offset)
>  {
> -       loff_t size = slot->npages << PAGE_SHIFT;
> +       u64 size = slot->npages << PAGE_SHIFT;
>         unsigned long start, end;
>         struct gmem_file *f;
>         struct inode *inode;
>

My mental model was:

+ offsets => loff_t
+ indices => pgoff_t
+ sizes => size_t

But looks like loff_t is more suitable for places where return values
(possibly negative) matter.

Good to go with u64!

> [...snip...]
>
