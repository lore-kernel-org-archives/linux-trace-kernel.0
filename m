Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B85B43D51E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389118; cv=pass; b=j2H3jP/7GoiWmvfn5mhYLW/bgCjyuiWc504yid1njt9yPuG99607icBIOsKlZU0s8zcGr1vWI28c1Kr61HrQmjTDp4Y9sW9MF6r5dqd39yc0xOeH7qYD6c86sEWW10iPItWzWtsrPP+Vf72LIooqKlXLh6YWh2/z33398wBudRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389118; c=relaxed/simple;
	bh=qAsxrt4aKm/2jD+D94DvWn6jQ/0j2S49WH6opo5RYcg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6/do8TepiyhcIixq6qbzCXY6h+1Ag/nUyC+RF+dNFz6Yk2w7Ik2Qe89RRBGP12ysEV+6Zn4c8fehCAU3BrU8ntEh2ykV29Tid4fQyqkc2dNoBuoWWClNdYklHWC0lhMcPHBW9NoOZWfqUqof7XH2vMsPi1uVYci8XVKOhCkcfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXAez1Gn; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXAez1Gn"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a051904222so112475a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 12:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786389111; cv=none;
        d=google.com; s=arc-20260327;
        b=UlZVmTWJ5HxdnpxB80NBIBVRQGL5UNwD/GsxpWmHg2YcJ1LkHzT+UhHJMlguYnlbzd
         d55qrXO4gRuu3xpqY1vvdQclj21k4HKHAG5+5MBTgcGev0awWTgQETaEYgmM+Ijl77Z5
         M1vmAux0MNYjB5PqEhfpwnvcQsrgGLEWDUf64YZQNYdtCLdCyGjEbFn71rD9EknqLMPu
         MciMCoBS/A6808pWIz9MtMeZm2wppMP74VrUlQnCraEWK1LM7w+qU+Gl7LKcbYEVxtX9
         BvTo4npJB5zvKdkw+MAo53MquBMRAUBQRKyYPwyMcZe7Fg+fnbEd+A3i2bMqnuCd2oik
         NoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=lTbNU28ri9zZ2toTUiO4PyOFIf9m/AozcuO/ntOhi+U=;
        fh=ronmhLWLIXsge29tsJdsZYwKtmX6vURDxWM20rSuthU=;
        b=spn7mC+tzjvi2d00pjBIK6L+rUwOc1t+STHWpkm3NZz4BSaLdqtpx/kMc2ebh7TPpD
         VNXWYueHXTg4MpcP32FcW48cTBmq5hSoSwlFBl5bVVOiVmS2KaJdt2pJeQqO4hf/t7Jj
         bzLtLEX+BfCwwTEs7+CoE62ALgZJjEE0JrPWuSP/PsWkwHsuAEVSi/Ic6ez3AxH+QqlS
         kyAUjPhuLMSAmhmY0AlCYf6YAlfQPsG8dotYkY3J1JgTPzYi+hhMSGT4qU02NliWmubw
         q/fOHajqvoro32k3p/JULrhCpbI7gbPsjAnl8FvGhA8ViEifValLYG+qOQc7H0oX/1UB
         lX/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786389111; x=1786993911; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lTbNU28ri9zZ2toTUiO4PyOFIf9m/AozcuO/ntOhi+U=;
        b=WXAez1Gn8WFaaa1yLwWbXAvcPJcVlFoVGkvFId/nBQP264AMsqJUXlnn6aIIcbAE/3
         wplIyNvKCWcyBde31WptAUgZe2qyMic/Usc6sSAk7u+UgAJrwxXvH5uVh5BVcL3xhcur
         1j9UQY3xpW5/w45p4jpdYeHy2Io19AM672ApBZktfDEEq9sBrZM3xIzdhYfuqfI2tJNE
         0Jc7f2wfd5Rr+BMLBpfbGWJLPaMmfz4QD6ziIRVQoCeZQwZ1LlJDeVXNC8OpxoAT7N0C
         kC+aIjPw3DpiusfvnJUUVWI9CODun8ZH9qx2s/KHiW0vcHjQBw9mmR+6GJHJ7wiVWdT3
         xo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786389111; x=1786993911;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lTbNU28ri9zZ2toTUiO4PyOFIf9m/AozcuO/ntOhi+U=;
        b=oW6rXwFcguMAKc6uNA1i+RCMS1VJv6zznUpQ13Tisy3dZdfdtf7RxJPTYYCfkmP+lY
         8n1I6nQBWnB3lJ4BEbjDBrHWglN77wG2zvgQKf1zw9eTl95QjaUHXueXpQkXbAUMGLdG
         p7zahjz7AfhZGg/vlvjyHa8QkUUdkrZIeQC6+9nMrmllSL7hGJvIXBdpmbPX+izS22gi
         9HiVFn8yf9vhAVdmLrRRu0aSlA8BQshxX3yhlqOwXkBJQOetDLv+kQIp2QqOCWfkh9uX
         UumwQKc4XbJfpWTDUNiWXPEg4iVFLG1GANNYQKoEyUjHBHfPbUM0pMjIt5aeyiLcB3Op
         jB7A==
X-Forwarded-Encrypted: i=1; AHgh+RoJQA+1fxhNCgosWkTgilBU5xYX6Xa87g8DNso9HKZBrypC5Kf+HFLL+s9NHP5QbJOL+MtVgeW7c4xxAo3nZ6XnCZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPP2ZrE/uyqTkhSVrQpjZ8GGcKkzmJ3lDk0YZxW1NwEpa8b4Ka
	w7dkNmyLMieUyvzOWagbCzm5wBt4re4C01T6qV4J3k4SeI2FODwfgBjtM8ueKVHencfn0wy7CJ+
	5SlPsy1Ekc7v71cY7NPIoP/BfIqGafnKs7hVZGXYJ
X-Gm-Gg: AR+sD11fDiihK66waIPuU1XSsCfc/qj/MR0Hik+l6362N8YQ0zu9roND4ut6TvafYwJ
	6+RFRk5T+Cs+Cryk23uLIYIOS7amgoNk7sUkX5x0h8f0yb4C5XadAqDrB4ZTV5b30ACpuisutX7
	bbHsAhCYrXgaHV4F+RH/0HwRmvCL05nm+1rToEuEeodAXohSVMAZ53QrEHvBevvIEEC4X4NSjyM
	/En21h1yocOyW5j/pSWSDHfz09VB6RHvDLa21px5C24dj0bgeGh7JE8Q2xbI0Cv0R4vEPYfzjzO
	pe/5zwu48KrBVWDsuXmvbjF+gFOCwVuKnIHy1H+0sAxcyaNr8gxVtZNMBgzgOY1x+PMO1lTUnpD
	c73RpQBkf+3K44x3KE/GDLwsm/4xz/3mDvqs=
X-Received: by 2002:a17:907:1ca7:b0:c1c:4adc:31a9 with SMTP id
 a640c23a62f3a-c2039e3fe56mr2131203166b.28.1786389110165; Mon, 10 Aug 2026
 12:11:50 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Aug 2026 12:11:47 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Aug 2026 12:11:46 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <cbf5f7ca-a960-4fb8-a760-2d2794eb6864@arm.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-9-2fc18ee6d3ba@google.com>
 <13ca60c6-e154-4397-8092-09f861e90fe0@kernel.org> <cbf5f7ca-a960-4fb8-a760-2d2794eb6864@arm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Aug 2026 12:11:46 -0700
X-Gm-Features: AUfX_myM87U3S8SmK_og8xg6GGyI1_yRBB52uSNeH53JSCFRKhcscCat1IpW7LQ
Message-ID: <CAEvNRgGOyQHnF_b8dk8E0d7_=CcwXtYUdU3ko7Qbep+_O7UC0Q@mail.gmail.com>
Subject: Re: [PATCH v10 09/41] KVM: guest_memfd: Filter both shared and
 private when invalidating
To: Suzuki K Poulose <suzuki.poulose@arm.com>, "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, aneesh.kumar@kernel.org, liam@infradead.org, 
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
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

> On 10/08/2026 10:06, David Hildenbrand (Arm) wrote:
>> On 8/7/26 23:52, Ackerley Tng via B4 Relay wrote:
>>> From: Ackerley Tng <ackerleytng@google.com>
>>>
>>> Before conversion, a guest_memfd could be either all shared, or all
>>
>> You mean "in-place conversion support" ?
>
> Not necessarily. This is supposed to be :
>
> "At creation, ...
>

I've been thinking of this series as the conversions series hence this
description, David is right about being more specific with "in-place
conversion support".

I didn't notice that it could also be understood as "at creation" vs
later on in the guest_memfd lifecycle. I did intend it to be about
in-place conversion support, since I was trying to justify why we need
to zap both shared and private pages instead of zapping based on the
INIT_SHARED flag.

>>
>>> private, configured at creation time using the INIT_SHARED flag. Hence,
>>> when zapping pages from stage 2 page tables, guest_memfd can filter which
>>> to zap based on the initial shared/private state.
>>>
>>> With conversion, guest_memfd tracks shared/private state on a per-page
>>
>> Same here.
>>
>>> level, so a range can contain both private and shared pages. Zap both
>>> private and shared pages for simplicity.
>>>
>>> An alternative would be to iterate guest_memfd attributes and only zap both
>>> if shared and private pages exist within the range. Setting both the shared
>>> and private filters lets the zapping logic do that iteration instead.
>>
>> I mean, we just want to zap anything that belongs to guest_memfd, independent of
>> shared vs. private, really?
>>
>> IOW, it's not about shared vs. private, but really about zapping anything that
>> belongs to guest_memfd.
>
> Correct. But we want to control what we "zap" (invalidate range) when we
> do the "conversion". e.g., if some ranges are already private, we don't
> want to zap those pages, as they might have some data "populated" by the
> VMM. For more context:
>
> https://lore.kernel.org/all/114e2488-97ed-4740-a8e8-1edd991f26c5@arm.com
>
> Suzuki
>
>

Looking again, there are actually 2 changes in this patch,

1. Zap both shared and private memory.
2. Allow zap requester to request what to zap by providing a filter.

(2) is preparation for in-place conversions, where Suzuki pointed out
that in the conversion process introduced with in-place conversions,
guest_memfd should only request to zap memory that is not aligned with
the requested outcome of the conversion in terms of shared/private
state, to avoid over-zapping.

e.g. for shared to private conversions, only zap shared memory, zapping
private might destroy data.


How about this, I can split this patch as follows:

1. Update this patch to just do (2)

Commit subject: Allow zapping requester to provide range filter

In the conversion process introduced with in-place conversions,
guest_memfd should only request to zap memory that is not aligned with
the requested outcome of the conversion in terms of shared/private
state, to avoid over-zapping.

Prepare for that by allowing zapping requester to provide range filter
so the requester can zap private, shared or both types of pages.

2. In the next patch "Add base support for KVM_SET_MEMORY_ATTRIBUTES2",
   call kvm_gmem_invalidate_start() for conversions providing just
   KVM_FILTER_PRIVATE or KVM_FILTER_SHARED - no change to the next
   patch, mostly.

3. Add a simplification patch to always zap both PRIVATE and SHARED for
   the truncation, inode release and memory failure calls to
   kvm_gmem_invalidate_start()

With guest_memfd in-place conversions, guest_memfd can iterate the maple
tree to look up whether to zap PRIVATE, SHARED, or both based on the
range being zapped, but I think that's doing extra work if the goal is
to zap everything from guest_memfd.

Before gmem it was an easy lookup to check the guest_memfd init time
flag, but with conversions it requires iteration, and
truncation/release/memory failure aren't particularly time sensitive.

Sean, do you know if looking up attributes in gmem to feed the KVM MMU
the smallest set of pages to zap will improve performance significantly?
Or if there's any other reason to do this lookup (more complexity in
gmem)?

>>
>> So, couldn't there just be a KVM_FILTER_GMEM thingy instead?
>>
>> But I didn't quite digest how these filters are used.
>>
>> I can see that kvm_gfn_range_filter_to_root_types() does some magic to them, but
>> I am not a KVM MMU expert to know what KVM_MIRROR_ROOTS would mean.
>>
