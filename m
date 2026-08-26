Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085913DAAA1
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735929; cv=pass; b=Fghat5fWw1ZPIbhbMmJsdOe+UGZ0ji/dzjXMJGld4JvoUdGo4h1pG5FmKU9+BD5/3Ni4rBYxCoTr5nHHIgXWQDhMqk3Fpk2q1sDYPEWTJ1lJNfGl870udwmml2NLFyobUFHCQGyjJn79Ocbr4zeKvfkfW9EVQvl4zbX9YRJRSGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735929; c=relaxed/simple;
	bh=PXd4FJsR6tKMFA56Q6aHGGrl17ypmJp1VW4g24+xHhM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ow2J41Rh5reXytWAIFeNZ5wSs8Fo3bbwhHh4XwG0oIhYXTRFWUEQfzOkK4GGKqdvn6ZiAzbIpEsnmO7JfW5fGcnaCOBGzpmJZDs/1mJ4s4mHo504SG++6TylvtT6jhvUJPH7qSG3YNQESSpTMNqdOozto/uktqOL5L/UBl6gBCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wOO38D6J; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wOO38D6J"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-908a2ca5becso7078866d6.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787735919; cv=none;
        d=google.com; s=arc-20260327;
        b=PLMYDrKeHwIjmHxwkFjuDYOLQ2LOayLrUTC3uqBmfBVtt2VjC//u7980WS5+e7PcpL
         1s/A45tRUxb1pNkAlT5kxJe+dW7eXfWp9Xw2ft9J8hhiApDXCBdwmkE9nugbbMcWFbQ3
         kZny2eZRmsDprbK3owTcvmTy6PRAAum848K4WdLyxRh8Z1GrQGt/Yhh26Z4WkeX15K7x
         uzCGCZjFxfvtmmUX01hAwYjqcR3awBH2WisVkTGZoHvi2xAb2eZRA+S6C+2juRaCoMr0
         tM6R4bTI5RSj/a8nodVuBRY+LeB9I1Dbmq+t24HWHYW6BviT2dMvsiNditKSZExVyJas
         r2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=W29gLyGYJCPLMB1l2BXhwer1rQC/3q6nHb6nCzKL89k=;
        fh=qtjce1yjgeDzfEYcs5pE+KCwMedQZjWcts8fHQT7Zdg=;
        b=JBWdqjt97XVaE8YLUsZbH5IKOxL3cwM1om/EW/ANP2zln3bE99LJ1XQR1SStWK4CQI
         SEucmLAYDY3+jj4C5rPjKsSQKjU6AWQl5E3RTweiddRgcmsHE6JkJRvNsu0QVvIIAYm1
         h8qySzXJMOkcRLHvzrh8fU+8u5EGb85i00rJQV9LI42K6sjCx+529parLxgzPnqA1uzK
         EA9rXZhPzlP269LqXKpyYXe/MogkxEd/0An3S+e08jG2yAAEVp4Lx38apY2vVn0za3as
         77FDpkmTT3PrVHSMGlSHOGwVZQiEfvOVYIxB8kWvSdJM04KRhOqc16OTU+PQR+XmMPOI
         HD8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735919; x=1788340719; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W29gLyGYJCPLMB1l2BXhwer1rQC/3q6nHb6nCzKL89k=;
        b=wOO38D6J17F7wLoGSjmqHJqGG2iU4xH3Jq8NKDeOZpGjR+sQfTPP6zBpKK2jBGlC1j
         8svNJV413v2Wd0IdofAGVQnbFumK7ur8t3y2kkuqCDIrhGKx1KAGJC0K+bx6R3S+vTYj
         MRFJ7avLxXwYRHcftf3DQaltYkHgbPExnknklGttUjFNY5hZmVntDLGSjyYIbMF20Y4B
         WCRcsvq7VhCjvr27pZFDQjdQLyUHQf9zoeNDQ1YvlPEHXvLDKseTM6CjXPL1lS4Fd6Ea
         9To5K/g2J9vrk81jpZ9/XbG4Y8vLoKo3cYErQD8RbS9ttgqSie2jYkLRzUpzK+w6phWw
         t8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735919; x=1788340719;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W29gLyGYJCPLMB1l2BXhwer1rQC/3q6nHb6nCzKL89k=;
        b=nNiAoJnjUXngomeSBuVTgC63pntVqhz9hI71P7UK3RotQMV+VHSWxpUKLR7Di9moUt
         XwyTIIMqyNzyqdQ8nTsMsI71H1C+nj36c4c8tc0Z6fV6aKjMhJ6qHXAeRh+FcPQb50Ci
         oyJcH4A5rRauBFy0WsYjpmRB/1iyv4eV7vir7gIIiqJkX11VzYJSaLm0DvncZKxEWQb5
         8c8Kfyxwe8dis9mLliGUTNQ6Z9I8kWEsrtu+hR3VrjZk+0rPbWCuRP9Sa6bskneLrhh5
         q1Rnyr/1DnZ6ryHjQp6xY4m6/svA0v/g7r6fOx8LdDv6WvSia7LRJLF5QKf4Xd5cAOah
         S69A==
X-Forwarded-Encrypted: i=1; AHgh+RrYrEbYbesinttKdKKkC4lQR3W5cifDnDhzfEzKBYsVDKk6wdxjjGOc+yop7isJfps080SWrzBQHMWKxrjtQSzHm94=@vger.kernel.org
X-Gm-Message-State: AFuF++kh2yo8YOaa6HhksgGimaTEuFkSnJv4vRxhLXDcs3p6Wtzhuc95
	ujH7XAcmybNCEEDgp26IQT+V6f8Xt/Z1ip9AsjTKlgiSQvs45MFAyHfivGp7z+ZrqSMpKlc+/vD
	iZTzZQYdrjKbr1jButUgK/4Esd0hb7vwWIM46bwbO
X-Gm-Gg: AR+sD137m1Hhqiync3UMXe3HeRF0M8cgzmD0ERHjjqWagT0iYjepDpqf8WxkwkQYMjO
	CHlwGrXfqDeW5rb2QfVxcZIbfsFnN2W/bYOuxlMuKlJicasVsgnfrNUK59tlmbY297xxUjuL/Ht
	F+cem+KiiwEo6Hl30Rr8O130dxe+YZT146XjXUl9B7sITXMcn1In7nYRwBjKrgIkYEalK5gs/KV
	RqpkygJ7sXRMCymaeRff3MRWIHEJCge1VuCDI4uFbfnySjfT/3sIR0Po77tRuJ+7kCNnwkAPTuj
	J8vD3O4eideFgnuxsDG06NK/4F9005GHP2nvAgUpwBf8SYrw8wAU/bhYvQCSHoXL/tQ8rwLp+ve
	NNzpfGn4I99eRRmiMZNGDRK0BWOVT5g==
X-Received: by 2002:a05:6214:260d:b0:907:94e6:f8bc with SMTP id
 6a1803df08f44-90cc79998c3mr49415816d6.15.1787735918598; Wed, 26 Aug 2026
 02:18:38 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 02:18:37 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 02:18:37 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ba8d0441-b52f-4357-b2e7-1e352aa385a2@intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-9-2fc18ee6d3ba@google.com>
 <13ca60c6-e154-4397-8092-09f861e90fe0@kernel.org> <cbf5f7ca-a960-4fb8-a760-2d2794eb6864@arm.com>
 <CAEvNRgGOyQHnF_b8dk8E0d7_=CcwXtYUdU3ko7Qbep+_O7UC0Q@mail.gmail.com>
 <aoZZMQ3Uc8yQWPNA@google.com> <7eba513d-cdae-4832-abac-038dcdd88517@intel.com>
 <meww2a2uf3yeevsfpicyrlg3hch2x4bsdqv2lsv3vfjxg4qzes@co5eogmhkxrk>
 <ao3lOu8-wpGTs2wd@google.com> <ba8d0441-b52f-4357-b2e7-1e352aa385a2@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Aug 2026 02:18:37 -0700
X-Gm-Features: AcwNN1VwWEAXm7Hyp9OqQou024-MyvsmSKreeFDqqoFiEfe8rutDN4-Z7NuYwk0
Message-ID: <CAEvNRgFXJbV78ktsg=b4srFp1OFjtQWQGuNPjr_MmWD-wOvjgw@mail.gmail.com>
Subject: Re: [PATCH v10 09/41] KVM: guest_memfd: Filter both shared and
 private when invalidating
To: Xiaoyao Li <xiaoyao.li@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Michael Roth <michael.roth@amd.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, jmattson@google.com, jthoughton@google.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, aneesh.kumar@kernel.org, liam@infradead.org, 
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

> On 8/26/2026 2:55 AM, Sean Christopherson wrote:
>> On Tue, Aug 25, 2026, Michael Roth wrote:
>>> On Wed, Aug 26, 2026 at 12:13:47AM +0800, Xiaoyao Li wrote:
>>>> On 8/20/2026 9:32 AM, Sean Christopherson wrote:
>>>>> And vice versa, a PUNCH_HOLE on a SHARED gmem (if userspace is
>>>>> using an INIT_SHARED gmem for the shared branch of a memslot) could invalidate the
>>>>> PRIVATE mappings (of a different gmem instance).
>>>>
>>>> I'm wondering now how this could happen.
>>>>
>>>> the requirement for PUNCH_HOLE on gmem to trigger mapping invalidation is
>>>> the gmem is bound with the memslot. But how can a memslot bound with two
>>>> gmem instances?
>>>
>>> I think this is for when userspace uses an mmap'able guest_memfd instance
>>> to handle shared memory, and a 'normal' guest_memfd instance for private
>>> memory. Each instance is bound to the same memslot/GPA range, and
>>> KVM_SET_MEMORY_ATTRIBUTES handles switching between the 2.
>
> What I didn't figure out is exactly how the two gmem instances are bound
> to the same memslot.
>
> The case I can imagine is
>
> 1. create gmem1 with GUEST_MEMFD_FLAG_MMAP and
> GUEST_MEMFD_FLAG_INIT_SHARED, and get fd1. mmap the returned fd1 to get
> a hva.
>
> 2. create gmem2 to get a fd2.
>
> 3. call KVM_SET_USER_MEMORY_REGION2 with KVM_MEM_GUEST_MEMFD flag. Pass
> the @hva from 1) to 'userspace_addr' field and pass the gmem fd2 to
> 'guest_memfd' field.
>
> However, with this case, only gmem2 is bound to the memslot while gmem1
> is not. Following PUNCH_HOLE on gmem1 doesn't invalidate any mappings
> because the f->bindings of it is empty.
>
> Do I miss anything?

I think Xiaoyao is right about this, the "vice versa" part is wrong,
since gmem1 has no bindings. Even after kvm_gmem_invalidate_start(),
going via MMU notifiers, that invalidation invalidates only
KVM_FILTER_SHARED, so only gmem1's mappings will get invalidated.

The earlier sentence about PUNCH_HOLE on the PRIVATE guest_memfd (gmem2)
is still correct.

Here's a repeat of the above in pseudocode. (I wanted to make gmem2's
flags=0 more explicit.)

gmem1 = KVM_CREATE_GUEST_MEMFD(flags=MMAP | INIT_SHARED)
gmem2 = KVM_CREATE_GUEST_MEMFD(flags=0)
userspace_addr = mmap(gmem1)
KVM_SET_USER_MEMORY_REGION2(userspace_addr, gmem2)

gmem2 has no MMAP flag, so that KVM will actually fault from gmem1's
memory.


Walking through PUNCH_HOLE on gmem2 again:

gmem_in_place_conversion=n:
  * conversions go to the VM, shared/private tracked at VM level.
stage 2 page tables:
  * private mappings from gmem2
  * shared mappings from gmem1

If guest_memfd invalidates KVM_FILTER_PRIVATE | KVM_FILTER_SHARED, then
gmem1's mappings in the stage2 page tables (which are shared) will be
invalidated along with gmem2's private mappings. That's not great since
we only really wanted to invalidate gmem2's mappings.

If guest_memfd invalidates only KVM_FILTER_PRIVATE (since gmem2 was
created with flags=0), so we will always invalidate just the private
mappings, which is what we expect.


Now I think there's an issue here: with gmem_in_place_conversion=y,
everything is still the same as above, other than where shared/private
is tracked.

gmem_in_place_conversion=y:
  * conversions go to gmem, shared/private tracked in gmem2.
stage 2 page tables:
  * private mappings from gmem2
  * shared mappings from gmem1

This time, the filter lookup will return KVM_FILTER_PRIVATE |
KVM_FILTER_SHARED and we will still invalidate memory from gmem1.

In conversions, a to-private conversion on gmem2 will invalidate
KVM_FILTER_SHARED, which also invalidates gmem1's memory.


Is this just a case of user error? That with gmem_in_place_conversion,
userspace should not use userspace_addr from something other than the
gmem for the same memslot?

We previously discussed that validating userspace_addr belonging to the
gmem for the same memslot is pointless since userspace can later remap
userspace_addr to something else.

One option is to say if the gmem doesn't have MMAP set, always only
invalidate (filter &= KVM_FILTER_PRIVATE). That means a to-private
conversion on gmem2 will not invalidate the shared mappings from
gmem1. That would break implicit conversions to shared, since a
to-shared access sees the shared mappings and doesn't cause an exit.

Perhaps we can iterate the maple tree and present folios and invalidate
exactly the folios matching the shared/private status and gmem, but this
is quite complicated and I hope we can avoid this.

What if we say, for gmem_in_place_conversion=y, set
KVM_MEMSLOT_GMEM_ONLY for all guest_memfd memslots. This way, the host
can still use gmem1 for userspace_addr (user error).

KVM won't be using userspace_addr at all other than kvm_read_guest /
kvm_write_guest, and for those, we previously discussed that it is a
user error.


Xiaoyao, any suggestions to solve the problem?


Meanwhile, I'll still post v11 to resolve the other comments first.
