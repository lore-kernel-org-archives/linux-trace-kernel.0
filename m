Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B332F5A22
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jan 2026 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636874; cv=pass; b=PouiTIepRyeIKTThhxFDIlb6Qogvmi48yMOeQHMF7rnoHNY2J4Vh81xyGtDmgJDb1pum0TBW/qHWbTMcZimP4ZWj5DBOX9y90M6vOydK/0mA3IfqtMyEfs7rjv3tuvGBjcjTX8eBlnY/uaJI7uOJNehoITqAepFv2+1u8/c+PHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636874; c=relaxed/simple;
	bh=YC36ImuZe9JdqUv+pVkMpluokr4Llii9CFTV9lQL1NI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ws/SDkoa1ZNAe6hK0/NuxIUajgXX5Mox3u1+yYq9oLMXXiW91GwCAW/hIQ5xiibJulPBMBz4iEVOMiMN1c1D+tII614OJuRPIG2Xopy4NUWtHv/VuSyjVu+RaFxeR9MyUin4Urgbvp2uLgJogU87pOpUWSi3AIQ2ovW4j+l2ul4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x4/lfl4R; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x4/lfl4R"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-566390e7db3so228061e0c.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jan 2026 13:47:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769636872; cv=none;
        d=google.com; s=arc-20240605;
        b=j6cBaV8Z8ag0HqPaLoMZEsmWkXz1+iKiZL4FfP8+Gx4vktHDJLBDYU7KOD8ROFqL/U
         p2nv9DraZgJCHY7QYSldnLL5S/4l/Y613EXHkrLuAQENM9c+yYBNzKCgzhz46N3AnirK
         9t6GzWgH4fcsAHEYyL5tV8KePVyoQDopFrM2YsofcdiuLlE26ILFn3NHkDBIkGV2uJPd
         0SkhT2PcQMa0zU2XiUX9nZbvrGJFbxo3hRKzhC4AWSXWRjHZDtjMOol4EhiIKShfnvvt
         x/8jJAorgdx257qTgqal582XppMTQa8H+6FPxIbkNTJYivQsfEiSSIXeUXuz8iVCb7JB
         rk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=8KRtsUWTPrRQfD/St3Ag63nt0POKWslcjlDyzaxfyec=;
        fh=m7rFAu6KdMVdPNKfvRPFbPuyAahe6QguVI0K/wvp+lk=;
        b=D24p/z2gut3BnY2e+lMoVZlEonaWqfiPiuoNCqjPPkIxiOCdJ2m8Qmud0AO/X/I+eT
         PrFgMo2ruWhPVuEeUFgnRHT+EKuJbMnIgtdqSiZYuf582MLnlmIW67TkHBTEDIyQ7vwT
         dI9tmlP4+z9XW2nO8VMgRvq4Cq1OHnGbw147iGgAHUejwIwENnT0rRqHCykXctc4HUGB
         kH7+9eM9M4/j3+m6Tt5YAbUIOmsGeyR90Udv7zHSjmx8cBLHSZ5gqO53h3EFQEs35Vh7
         aPNCIgRHly6FbCQwGDMLCmtY1Dm5VuX4KuuxD+NgjHuRK/PtZeKhxCOkXEBvfG/sSFaP
         QPNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769636872; x=1770241672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KRtsUWTPrRQfD/St3Ag63nt0POKWslcjlDyzaxfyec=;
        b=x4/lfl4RC4R6AZIvM1WTIKqANtJTykk9eIGt6qOukMOE1QRTKe0Nd4Kufq4/kTBDvg
         O4gLZ1kkXS5Wi30V8TZbW4QI2U7WSmlwAyOQseQ0Kk86PWxdg+SbVc3mEsim2I63sEvG
         auosx2itHw4eTN+FT8gJmnxpeIRAt/VFWkDpCj2LWJtWlU7MoxlQCFH8mZdrCaD5JeMn
         Eri6ZQ+0pAdOorAluQAH/B4RRioCPqJ6ECaJ0QKnEW0i5Oi8aieYvFzIVSLRMFe+CQHE
         UXxnGatvUwlrhNlh9IwMSkTcDBMYXAFS38Ys5DU1A4L/wOz5EVnX2gsj+2vKxJXrZFW5
         CbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769636872; x=1770241672;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8KRtsUWTPrRQfD/St3Ag63nt0POKWslcjlDyzaxfyec=;
        b=RpZEthxiv6yJN040mQ27ZL5sWEn0guqiJwoG9IoPOpaf8wF7sWSWlzPYUMs0L1VEJt
         1d6C5lrRDC7CMA40cEP//XKfxaETLpyYQdy9NtHradPSFWdiWyS6mCxB0lfhLn8R+1lz
         ASrELoBSM+aBOBE3reZhY2Ff6XAnq92bAFbmrWrUNTFgHs2zfiJhmwfWSBpbFFY1iNKH
         1KY5hxEErFfTPDoqKcyrnp9JUJvOpuF9Bv0mzPMFDeEXWXPT01MdFAuP2m/Aw26L+sOi
         RnDEeZxfuNofHYA+g9h9Papw+yBoBesTIpSM9XAc3D0fbfOweezwmFcMbyuKWIjdCiSf
         iQIg==
X-Forwarded-Encrypted: i=1; AJvYcCUlHgA3D0CvSiM4grLuvsGzrtz7z8HwHi0zR6Pwx4625/qRVv7VkGizW0FlCeTGbkd6WZEJFuDwSy12Ht4wRshK+4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ff29qfnaBeP5gZPbBogUgKjvrAjrqtOPXgUATOdqn3l5C5ME
	HPaBDG0I3l3542+zQUHrZXnd9Hy59W6diMqUeqqFfQe9ETmc8H1thbHclihoEjwc58kXTpR9Opx
	VMGcCQjmeKOa7/fshD4aVwHONVdq25HC0lpR83ecn
X-Gm-Gg: AZuq6aKJMzp5IS17HXJZLN59gFjkZA0mOpu2PvlVKuBH0GXEmG/P3PoX5qkjFtzX3ik
	eZGruQ+4LxPl3NmF458++cKrDyd8W/GvWOAmd77+PCndj6Bs/ytKAssOuufSU62+TxyE+98T7Ih
	6DAlJhPTeBJEFdXb28OXwW29/wu2ccs63s5iJ2areF7xFhRj6DqaGjeGIZcFtkooMNsUIQqWEl+
	irprkGJR3QcyukFbvSDELEnKwy7D74sLBaBENIJhicOcOVh5aGAE/dfAZtRCYTo48QJwh9OctPa
	fcSuV3tVZ8ApsMRZ3iTlSRI0FA==
X-Received: by 2002:a05:6102:144b:20b0:5f7:24e9:ece2 with SMTP id
 ada2fe7eead31-5f724e9edc6mr2295689137.28.1769636871290; Wed, 28 Jan 2026
 13:47:51 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 13:47:50 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 13:47:50 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <07836b1d-d0d8-40f2-8f7b-7805beca31d0@amd.com>
References: <cover.1760731772.git.ackerleytng@google.com> <071a3c6603809186e914fe5fed939edee4e11988.1760731772.git.ackerleytng@google.com>
 <07836b1d-d0d8-40f2-8f7b-7805beca31d0@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 28 Jan 2026 13:47:50 -0800
X-Gm-Features: AZwV_QgPf8aOvxqDX4gr94R7SzOt27JuvroRVjSaL4ACWGO_5lJuitif3BKdULg
Message-ID: <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 05/37] KVM: guest_memfd: Wire up
 kvm_get_memory_attributes() to per-gmem attributes
To: Alexey Kardashevskiy <aik@amd.com>, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org, 
	hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, 
	mail@maciej.szmigiero.name, maobibo@loongson.cn, 
	mathieu.desnoyers@efficios.com, maz@kernel.org, mhiramat@kernel.org, 
	mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	peterx@redhat.com, pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, 
	qperret@google.com, richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, rostedt@goodmis.org, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shakeel.butt@linux.dev, shuah@kernel.org, 
	steven.price@arm.com, steven.sistare@oracle.com, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org, 
	willy@infradead.org, wyihan@google.com, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alexey Kardashevskiy <aik@amd.com> writes:

>
> [...snip...]
>
>

Thanks for bringing this up!

> I am trying to make it work with TEE-IO where fd of VFIO MMIO is a dmabuf=
 fd while the rest (guest RAM) is gmemfd. The above suggests that if there =
is gmemfd - then the memory attributes are handled by gmemfd which is... ex=
pected?
>

I think this is not expected.

IIUC MMIO guest physical addresses don't have an associated memslot, but
if you managed to get to that line in kvm_gmem_get_memory_attributes(),
then there is an associated memslot (slot !=3D NULL)?

Either way, guest_memfd shouldn't store attributes for guest physical
addresses that don't belong to some guest_memfd memslot.

I think we need a broader discussion for this on where to store memory
attributes for MMIO addresses.

I think we should at least have line of sight to storing memory
attributes for MMIO addresses, in case we want to design something else,
since we're putting vm_memory_attributes on a deprecation path with this
series.

Sean, what do you think?

Alexey, shall we discuss this at either the upcoming PUCK or guest_memfd
biweekly session?

> The problem at hand is that kvm_mmu_faultin_pfn() fails at "if (fault->is=
_private !=3D kvm_mem_is_private(kvm, fault->gfn))" and marking MMIO as pri=
vate using kvm_vm_ioctl_set_mem_attributes() does not work as kvm_gmem_get_=
memory_attributes() fails on dmabuf fds.
>
> I worked around this like below but wonder what is the proper way? Thanks=
,
>
>
> @@ -768,13 +768,13 @@ unsigned long kvm_gmem_get_memory_attributes(struct=
 kvm *kvm, gfn_t gfn)
>   	 */
>   	if (!slot)
>   		return 0;
>
>   	CLASS(gmem_get_file, file)(slot);
>   	if (!file)
> -		return false;
> +		return kvm_get_vm_memory_attributes(kvm, gfn);
>
>   	/*
>   	 * Don't take the filemap invalidation lock, as temporarily acquiring
>   	 * that lock wouldn't provide any meaningful protection.  The caller
>   	 * _must_ protect consumption of private vs. shared by checking
>   	 * mmu_invalidate_retry_gfn() under mmu_lock.
>
>
>
> --
> Alexey
