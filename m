Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C205678C6
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Sep 2026 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965568; cv=pass; b=VVouUI+hma7ne2tRfJce8wbudQaasrIazdNr7Gb4dIJRPrXoxLGJKOUxEE1x8VPC1QWcMXSqeRc24A/yuskRtaZO2RqB/BrrraCy0npgHocqjR0daJHc8YrKRmwf/UwodNrtXHn7HC76VzNi8uUd1iUbsfNwDX06H6noDNGKfVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965568; c=relaxed/simple;
	bh=nlL495Rwgq5pTxpggaWR4Kyh0bctH6OQcmcJP4kB+LI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwr2wtXcaVMQYjOzsTRWg2d2xfuVp2HnLmQJityZy5+JNyH730Z74fDDL+mEPrQDF/ddCqkVrTqvRJId5IA3pAVUeVeNnyTU6T3NqhPOfQNg35gi7mvaVic4tB/mLtpmiElJ7mZS0TE4NnRWUoNyJ/b/qXj35UF6VHu8MBI2KKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q8i3qMhU; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8i3qMhU"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-878ed0f17bfso38577377b3.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Sep 2026 07:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788965565; cv=none;
        d=google.com; s=arc-20260327;
        b=B/wm/yc/bUD6FhgBfebxdQJlAwX/0uwkxMUiIHX6kVisN3rn7aEIiZ97tZTHWVzI5P
         NKenOMd7pgwJxEOOngDWSA5H+FxmOkS+fG/iHjr1CH63N5ZqFNVRNNPrQ3GXEg66Ye/1
         Krwe+ykJ9HY/7uW4/IW2Lg/NTlph8qtY9SBOhuMlWH5aMXULI137Lt8+YhinFRJhu7XY
         Dp2/agHh4Snx0Q3pieDkkV/gfzWwaO029gMO1IN47p8/tMriqNe2qfBuCJSXB7ApMXri
         EskmZolXs2j6Sp66wnB5GRextkDUFyMbB9EAP4jlJaae7iI8CbXN0QjmYx976RdOISCt
         3gBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=QRvd1Tt7kpHM/AxQHBaJz2yfsVBadJLI9GFkxk7vpJA=;
        fh=YhwWGSPSBIx67QNbEAqntzkBB2Q+moUlW+hrUfV4crI=;
        b=YEdOcjIIHnh8BXqP5yrCaDudiYyzUkmuXhpySvdTEQ2C44iTYHbRDIyvU5HdqRwtwb
         ZZSY2zyvyuQsPpilGZhXjAU5PQVeIf+i/4pQYUs3/LZrd7PbOTpPqPN58LcnnKSG8HYA
         RyRfTaNmUxO+TOrHiDu3qHBqX6RgJVDBshtMxWURkXeRKVg4zC3fisl4iOz66E0ZH3mr
         59+Wh/Wmn9MhLq42tu9ypZd3LmNJaCrhYjQaRgNmzWCRVa/Hj1d3g0UJVfGv1ty4hk91
         tME8gajIP+pNAFRrUBBPVup9VRhI7UHLCznLibo3qrflz1+hgee4sJLYn+3hBbGa3Sq0
         FNMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788965565; x=1789570365; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRvd1Tt7kpHM/AxQHBaJz2yfsVBadJLI9GFkxk7vpJA=;
        b=q8i3qMhUp5t5ZXPUqJ2Q7wyst4pkqzz6PPNiA9qPABvr5TxyN6xE+mJfG4pvM4uaZ1
         hXgisclAU/Lka+Zv9mMs6hWHgsuGeUiSnXazvtjRlDl+mRcyhK0QxGsFG2fOHKEJuLDa
         uSnTA6nhxga6hmxGoPw6Bvm5LBSqKV83ZZFkqSv3vX8KHfOO6/t2ZvUNFNJbwxl7oaU8
         cGzs9DnJlC6Bly13MaOpMSLyMWnKPMOMtGDtRzL+H4BuT2m4ucPCGKrl063UZ+FXGWOO
         HUnv3V4svnbBaQst4Gv9XvhVy8D2/4PMcgO6j6/BMPC0aGQEZjOtYe/60bQqzO9HDEVV
         X3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965565; x=1789570365;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QRvd1Tt7kpHM/AxQHBaJz2yfsVBadJLI9GFkxk7vpJA=;
        b=DYYg12S8ur6BIqtDPp6YGIPQv9tsf/umFA2A5oW3JgcFhb2o0PYYWj9ETqhXrsHwJd
         9FZWUX5k0IrsYA0piydeHOG8fkhB43S0yv6rM+fzpI1Dyb5k9tCsH+J8i7v3SBvAseLh
         wQvLl8rpnoLrb54NcGbLWEBE9xQhxhWhJmWVvmOW6Ovi4MK1RrtpL599OQ7fct0ugQRv
         63BfjU4uKXQsA7kiTgq5btyfHcB9Za1493TU6nG0a1o1u73DA3WVzRnOMfcLMo8JuPZn
         kdFbqCwoBIDjkA/MinlDDKiJwRoTbTVPgkDwAWmHlyyhSYbllIm4I4koOCBLtE2zekep
         aK5A==
X-Forwarded-Encrypted: i=1; AKwUvBzZ6VjLQXkBX6xHrn3cCQThbVje+WM6xkDKuwKkminOVLrYnonbXPwUH6LmmEVu8pUMFrPGp/q51JXXudscZLvk0yk=@vger.kernel.org
X-Gm-Message-State: AFuF++lUF1VKNJYvzoOXOk/ZQmEdRMjmHxwYBVOJ8uvRjHxpm9IlHV46
	CSapUTqF+YVVfMYo5aOOq64t03iilvaV32OQkq+6g+Ces9t0AiNAtqMMBnJh4Q2Cz4zZbEQQnov
	7m0ePsKpwf09ZBS9aPzSnv4gupdUVik/q/1mKdm4a
X-Gm-Gg: AYBFou1Pyd/XGaFkOh4v6zmzKotSoty1D9vjyBdvNhdkMwNbAgKaFD7IXTBtExQbgJY
	GTbVkZb3TKEriFC5d53tkS9ifcPOGmSVSzi5iXqmX0QKDP0VNgJ8YsV0AwqFtlTRGSOh/PYa1xr
	so96sbZKci9Wz/bDH5WEfE3n51TyYANJynB3h+sXNa10w4xdyECPyalyzFFrjTXzE7le/oQEMKw
	RMaA0f/8WERZjmqt2FYWcJ+cJCi+Z9sf2NmEdswK9iF+x2odZVkuboupC3nvrCo+uDUG+w5TNdX
	LqZMjw9vd+jfvJqNdCdf4HPHs62Zr76k7RJ9WknbZH4ggjf/FupIvef9uJoA4fVPAHcdIEnbH1n
	C9bnaRKxIKJ8=
X-Received: by 2002:a05:690c:6b88:b0:845:ddf4:a3a7 with SMTP id
 00721157ae682-87126aa77dcmr145268997b3.16.1788965563207; Wed, 09 Sep 2026
 07:52:43 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 07:52:42 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 07:52:42 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CA+EHjTyU1Ldbw-qqdQOx_P8jrt85QEcKSGae2h+AahsDQdbmLw@mail.gmail.com>
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
 <20260830-gmem-inplace-conversion-v12-14-85e5fd25252a@google.com> <CA+EHjTyU1Ldbw-qqdQOx_P8jrt85QEcKSGae2h+AahsDQdbmLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Sep 2026 07:52:42 -0700
X-Gm-Features: AcwNN1XhqWHW23-sQN5ajMsWY1WhBdcubAUAi4IgbeOekiJ8g-YJ7YTjJ4UYzFA
Message-ID: <CAEvNRgG36aXk8UW=Mi7ey-6vUe1EOKnkgNRNzdSUz-QJih4uAw@mail.gmail.com>
Subject: Re: [PATCH v12 14/45] KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fuad Tabba <fuad.tabba@linux.dev> writes:

> Hi Ackerley,
>
> On Mon, 31 Aug 2026 at 01:25, Ackerley Tng via B4 Relay
> <devnull+ackerleytng.google.com@kernel.org> wrote:
>>
>> From: Ackerley Tng <ackerleytng@google.com>
> ...
>> +.. _KVM_SET_MEMORY_ATTRIBUTES2:
>> +
>> +4.145 KVM_SET_MEMORY_ATTRIBUTES2
>
> This section number collides with the existing 4.145 (KVM_PPC_GET_COMPAT_CAPS)
> below, so api.rst ends up with two 4.145 sections. One of them needs
> renumbering.
>
> ...

I'll add KVM_SET_MEMORY_ATTRIBUTES2 as 4.146 below
KVM_PPC_GET_COMPAT_CAPS. Thanks, good catch!

>>  4.145 KVM_PPC_GET_COMPAT_CAPS
>
> Cheers,
> /fuad
