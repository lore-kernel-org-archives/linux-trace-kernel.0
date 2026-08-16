Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF833B14B7
	for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Aug 2026 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786920372; cv=pass; b=ftaTdc250nkVODzomEfqNy5ey08Z9KzEi55ZCfhcaLInSAPYxRkyVHZ8e020+YoyC0FaO3n55eEis0s6dWT0/cMvbXycsWNGj5dS5RSP9QRDI/mq4WuTeKkKSecwkEAsF97lgj2lJBThaLf2hG0SuSsdQ/TVCSSSYrduQjj3uU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786920372; c=relaxed/simple;
	bh=QkgiH3G3Af5xKaMywxZpXRusrZaexRQ9voIYx/ir3fc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btaNMP/+AUPuPCzg53vg3ntlyt0GGyXTqUkyqxNAdMxE4VBwFnA86vwGnBgX7hJd2rgIIWC0b/5ilJflqVBdmdZMisPij9egvx9heEtf98HMltKfEjklesetmQNdIbFbC60vQlvJgy351BtornBFIbKh6R1rOuHkpxY3DgX8cH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yip2+s4d; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yip2+s4d"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso1661163a12.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Aug 2026 15:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786920370; cv=none;
        d=google.com; s=arc-20260327;
        b=AvsNWFso+rKTz3eVNzbYFVCKKmhPG+F7XN94K+F+y4Y/q7Se/8GpIadMNYJKdlFB5J
         hxnW7GNuKXKqdVllhCWbMluNgihc3QnqF4UkWmlJNP+esIdBtZtEIUh1rcwOVSSnjsj+
         WPHcVFtKZuRG9FogvE221LBda0irwhKZtWCAWCTnRjFx9jKZX+X5f3qfqw00PMg8lsTx
         y9tL+Xe7e5nBFVbQModCIV9Rvx4L6yIdmMk9a1Nmgc4r00/gLP2YVdqSm+uB3t1Myl20
         e63mr7ylfeef/6PuZf/wqNp36LTUF09s+5hRaEWLc0cOmwdwVe4CnJ174hMxYkgap+43
         YiTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=uRJG9crnjSHGaiMl0ul/ePIhOSVGvO5xGqUR928BxPs=;
        fh=Zkxrwy6QpfIke9bXzupvXruCNGIcvgX9YfT3rvzes7w=;
        b=NzcsGJ1lsFoOZtxrVBr3FBwU6LL6+rWXjyq46RD+5CwBv/lu8F/QVMG1Q/efq1TuyB
         cEkqhXk9AHfR77BVXZvCIVrtggq0iJtzGTbPD8Rz5Yy9BS+JTsYfP++vaS8EfNNrU/eu
         1YJW+cjHYKulDqJ68JaDFYsdOWhj16YE7K0VO2sSSQmyOh/2I6+v7hVOExezIcE/qYp7
         hsOqv0+iZWeuUgedhVEo0gaPndZ/FsYoMnejbYdJdFjn+stQ9yeVI0kuIUrcyoSotveN
         KB1XfTAfOTmr2MMStFpqlE5guFJ3hq43K7bVVT+AxyS6cztxf3XB1jGUL3gomiP3bb/I
         KTdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786920370; x=1787525170; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uRJG9crnjSHGaiMl0ul/ePIhOSVGvO5xGqUR928BxPs=;
        b=Yip2+s4d8QHI3UIQsgsj9fUdJpouYlvOJuNu0cS/2t847N14HEwMGA9Jom6FuFcIqw
         d24Aj1UUPuOACk/LeUuoifGHs6ulNjadyo98apS/To/NfWJCflV44+5rZ767en5qAQOA
         ZJocIjrI+bfrQO7fpkVjvOJxzjxG/mHK4cNE2pkp0tYYXuQErtdM7nrL8TWDOrOCkt23
         8ysimKO7wH7gDO450cBAKS+LZNtPvpCk1gocw0diG1q7UbeipMfG3KIilN8uJmRCObly
         pijTaP3tqtM0SJ7HIFo6JhYF0eQA0iwQYf+76fULlznhRn8Zf+py9lMDweJshvbuE+QK
         uFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786920370; x=1787525170;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uRJG9crnjSHGaiMl0ul/ePIhOSVGvO5xGqUR928BxPs=;
        b=H+xHcl5YKvowQ77Qwqn8HCi12eUHggKrXTvhS9Iph+ai6BrQTVeVWJqye5DFBmAEQ1
         PEZHhWXxuaDByMetaTtTFQwmLV48apuAA+juLF9qErz4wnoIPls3tOuOyisw+iOXYvdV
         Ct6CqFWxmnFK8fXBjzFL+dQDunFETx7N0zTv50J3OC2xLeTH8uXhJS5Px3wEGf+EyHX2
         SawCZ+nWuZ1Etth3pxg4rFS2zS1uExKd3IMB/dt9HOUUCkZljH3h+BTRDtExWwZRyB8S
         KbXN/TMKxa+BGU7+xueS0Evi21nQKVpG9L+I79xg0PTrhptNyrGOVYSIPljeFi0eWBop
         fZzQ==
X-Forwarded-Encrypted: i=1; AHgh+RpqigkkOpnu9H7LixkHiTRfoHAFTZ8ylspAuNI+h058BukYgYl1cuCHLKZgi5zREUBtmJCnEdaO+4XTexQNauDx5b8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0yyqWibrpdW3c+8sjpFK0AmAPPPVe95cIR9pinpMkSLBIliYp
	jilUdYkjYj/9PDrcA2lTrcJ5KnK5y0fh3b116QbtbT7fb4BG+YL55Z7Vw4G4lbGuPVkPDWhzbTU
	IVxXcyoRRMuQ4lU7ND2i5g2VdIFeTmHII/smVURPa
X-Gm-Gg: AR+sD128d/ucVRq33/q66QfTXcDj9AtkGwsHjYB7urPWOGdAuqi7bGPLJkNN9iLNVPh
	E1MF3zfYeRZyM4gI0Sq16jWNqVTtOeMlb92o7V3VQPhiFtxaY8iNJ3bs+HHjkKz6zyVlVzk+p1M
	tkS30hXdeimpT1zC9RHZlhFQcJdm0xtZFoh0oeR2bP0tIjVi/mjdEtoqMHxT0NfCjKp29399/4U
	3QrZITDlILa4Hg62ei3gRZbqDmOF+9cB/cyHZYfN2oTx7fUO7piXQX7ytAM5yC7Glyx83xfl7f7
	OJfaG/lqa5STJx1sur3/Yn9JO3awIkJm11yy/3rZxv2LcicySpmRG1K0lmtNmsY+LCNqlIQand4
	raQ==
X-Received: by 2002:a05:6a20:748a:b0:3c3:a9e1:a819 with SMTP id
 adf61e73a8af0-3cc71fb5781mr22866718637.24.1786920369447; Sun, 16 Aug 2026
 15:46:09 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 16 Aug 2026 15:46:08 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 16 Aug 2026 15:46:08 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <an8umm0qisEidt4n@google.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-12-2fc18ee6d3ba@google.com>
 <1ec08cd8-3072-4753-ad5e-cd34956647f8@linux.intel.com> <an3o4h-E8mj6CUaM@google.com>
 <CAEvNRgGpCVCGVjc9jCt9Yr+XypF=71h6eBahkXNkrXhfrtGY+g@mail.gmail.com>
 <an5AcEG9mqDgnBYk@google.com> <CAEvNRgE+05c9U8C=Zkm1S9hLw3Lw6YMmijZhEe7J4rYQAuNyEw@mail.gmail.com>
 <an8umm0qisEidt4n@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 16 Aug 2026 15:46:08 -0700
X-Gm-Features: AcwNN1VMiHczbSFfHuHVB6i-2Pe7bEu3JF_t6lQmU1zbdAOxcIWciSwKVy8tMcE
Message-ID: <CAEvNRgFNCDDSeuvbwj7pD_d18o1TBXo4TNR2dXHxpm18KPfR5A@mail.gmail.com>
Subject: Re: [PATCH v10 12/41] KVM: guest_memfd: Call arch make_shared
 callback for to-shared conversion
To: Sean Christopherson <seanjc@google.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, aik@amd.com, andrew.jones@linux.dev, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Fuad Tabba <fuad.tabba@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Aug 13, 2026, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> > That's why I think it's worth analyzing the cost: if it's in the
>> > noise, leave it alone.  If it's meaningful, figure out a not-too-gross way to skip
>> > the entire thing if kvm_arch_gmem_make_shared() is a glorified nop in the end.
>>
>> Is noise defined relative to the entire conversion process? Would this
>> benchmark look like
>>
>> 1. Convert 4G to shared on TDX with CONFIG_AMD_SEV defined
>> 2. Convert 4G to shared on TDX without CONFIG_AMD_SEV defined
>>
>> and then compare the difference in time taken?
>
> That'd work, though I was envisioning something even simpler: use rdtsc() to
> count the cycles it takes to iterate over various ranges of memory.  Do whatever
> is easiest for you though.

I made some changes to add rdtsc() for the conversion process as Sean
suggested [1], and exercised conversion like this [2]:

1. Initialize some memory as private
2. Get the guest to fault them into Secure EPTs
3. Converts the memory to shared <<== this is being benchmarked
4. Converts memory back to private

I made it build the VM once and convert 5 times:

./gmem_benchmark_tdx_convert --iterations=5 --size=1g

Here are the raw prints:

[  396.403818] guest_memfd to_shared: nr_pages=1, make_shared=930
cycles, total=39278 cycles
[  396.412087] guest_memfd to_shared: nr_pages=1, make_shared=252
cycles, total=28060 cycles
[  396.420379] guest_memfd to_shared: nr_pages=1, make_shared=176
cycles, total=26952 cycles
[  396.428643] guest_memfd to_shared: nr_pages=1, make_shared=176
cycles, total=27038 cycles
[  396.436921] guest_memfd to_shared: nr_pages=1, make_shared=176
cycles, total=26980 cycles

[  400.338157] guest_memfd to_shared: nr_pages=1, make_shared=1072
cycles, total=37236 cycles
[  400.346509] guest_memfd to_shared: nr_pages=1, make_shared=316
cycles, total=28338 cycles
[  400.354805] guest_memfd to_shared: nr_pages=1, make_shared=176
cycles, total=27182 cycles
[  400.363090] guest_memfd to_shared: nr_pages=1, make_shared=176
cycles, total=26972 cycles
[  400.371349] guest_memfd to_shared: nr_pages=1, make_shared=176
cycles, total=26886 cycles

[  448.761474] guest_memfd to_shared: nr_pages=262144,
make_shared=15041018 cycles, total=6616067680 cycles
[  455.807988] guest_memfd to_shared: nr_pages=262144,
make_shared=14937462 cycles, total=6608542680 cycles
[  462.848856] guest_memfd to_shared: nr_pages=262144,
make_shared=15138858 cycles, total=6599494898 cycles
[  469.885694] guest_memfd to_shared: nr_pages=262144,
make_shared=15721972 cycles, total=6610219850 cycles
[  476.928399] guest_memfd to_shared: nr_pages=262144,
make_shared=15000406 cycles, total=6615114540 cycles

[  762.980690] guest_memfd to_shared: nr_pages=1048576,
make_shared=61902982 cycles, total=26400884028 cycles
[  791.022885] guest_memfd to_shared: nr_pages=1048576,
make_shared=61746114 cycles, total=26401170984 cycles
[  819.054580] guest_memfd to_shared: nr_pages=1048576,
make_shared=61096794 cycles, total=26404409058 cycles
[  847.120994] guest_memfd to_shared: nr_pages=1048576,
make_shared=61446290 cycles, total=26447461896 cycles
[  875.219750] guest_memfd to_shared: nr_pages=1048576,
make_shared=61774646 cycles, total=26444608360 cycles

And here's the above, tabulated:

  nr_pages      make_shared            total    percentage
----------  ---------------  ---------------  ------------
         1              930            39278       2.3677%
         1              252            28060       0.8981%
         1              176            26952       0.6530%
         1              176            27038       0.6509%
         1              176            26980       0.6523%
         1             1072            37236       2.8789%
         1              316            28338       1.1151%
         1              176            27182       0.6475%
         1              176            26972       0.6525%
         1              176            26886       0.6546%
    262144         15041018       6616067680       0.2273%
    262144         14937462       6608542680       0.2260%
    262144         15138858       6599494898       0.2294%
    262144         15721972       6610219850       0.2378%
    262144         15000406       6615114540       0.2268%
   1048576         61902982      26400884028       0.2345%
   1048576         61746114      26401170984       0.2339%
   1048576         61096794      26404409058       0.2314%
   1048576         61446290      26447461896       0.2323%
   1048576         61774646      26444608360       0.2336%

Looks to me it is within noise.

I also actually tried measuring the conversion time from userspace with
CONFIG_AMD_SEV enabled and disabled. Converting a 1G-sized TD was faster
by 0.2%, which is in line with the above table. Interestingly, when
converting a 4G-sized TD, skipping kvm_gmem_make_shared() was _slower_
over 2 runs. I don't have an explanation for that. I think the code was
correct. (If it makes a difference, I skipped kvm_gmem_make_shared()
using a custom guest_memfd creation time flag and skipped make_shared if
the flag was set on the inode.)

I thought adding a kvm_arch_has_gmem_make_shared(), defaulting it to
false for all archs and having x86 override with
!!kvm_x86_ops.gmem_make_shared is not too bad either:

+ doesn't leak anything, since the function being called is
  kvm_arch_gmem_make_shared and the accompanying function is
  kvm_arch_has_gmem_make_shared. Or maybe just a little, since all the
  other ops don't have the accompanying _has_ function
+ it's a kernel-internal thing
+ not too many lines of code, not too complex

Sean, let me know if you prefer to add kvm_arch_has_gmem_make_shared()
and for my learning, what your considerations are regarding adding
kvm_arch_has_gmem_make_shared() or not.

[1] https://github.com/googleprodkernel/linux-cc/commit/3295072cfeb8920e48d9e80c98fd1695d4bbad99
[2] https://github.com/googleprodkernel/linux-cc/commit/a644618f270f02c832fb7e8402fcae98bc91f4e5
