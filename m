Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F573998A6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787727228; cv=pass; b=Gh7iuHmubs97Q7OYaDttzi3yogfweOOKwKEP4jAP4rQsuLYZThZ+j04tUfOundL8tvuM3bSFCyvNjVXwl6KO+Yp5WaO+7IzJ7bbuYp5qEtHjNZBMjS7D2cpwvwttP4Nygvj4/3jiI2skf+UfcVV8hrR2EQ2ks9zmFBsS45CHTZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787727228; c=relaxed/simple;
	bh=/vyKACkfCL7rXCyIYMwbLdrFfGENnqR/w0Bj9SikPUU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVG9fiOuAVJvmz6/EbDDtSkT96LBMyr8Mkfd5ysypvtvQuPa9eKQWaHkxGMwmjTyf/2b/s+sXKsIhL6b9WEZa51ZUaIgWIGc5MUDNGO0M739vvEu59m1p/qBV80QZnq7mMJaa77Pq6qDVn+Xd/WuUh7zD3W1YCEY6d5psLb17BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bm4A6INi; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bm4A6INi"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c2cce930cso7076701cf.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 23:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787727225; cv=none;
        d=google.com; s=arc-20260327;
        b=n4UTtfxUDHcPrpNHhNtXwY6ohEJ6ye89xDq1zRTpR35rmBFpKnEujYS7EZUesbb6Bx
         +31WoKh5OKshkKEFXEYYYTbMZx/RkkW3HDwKsK6cFjyuFNZc1UwpEapNhKWHDKLrpqBq
         Pv9XZC9t2lMQVnRjkRxrVgQ6fXLpPVTUgCc2n30oLqGi1ijSxSIRsXamPaMVb/yohgMN
         H0IPxr25sTspdITkwLQXnG64V5IXbxHMf2Tlx9PslHrGdKgg34L1kU31ECgvMvsKK7Dh
         UUUoAa7fe1GU0G1qezWc474OXMnNrjhoZLSR5hrLmMBoLrvFlFzdgq00GMXdeAiZrRL7
         CCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=gunoR0/5m2ShIW1cBAYYWni95R3wXjfnlI5bo7Tk+30=;
        fh=Oio/UIsizQ2H/ls+zEx9LY66LlybLzCSSf+yRsO5Gog=;
        b=eYGDgQYo0vZ5sCcazK5NFzjuZ5rVTZNzIBpSJvN2BKif8ard8WCLuDFC4TmzQq09Bd
         rcepXwoSrP6xVrU4kKZg9hVjPdJa4QUaAeNfv/YL22vx8jlC0oirzUNkpoBslYsuVivy
         iCcLomfRq52cXhuBV+IKt0QS2tXNO6D4f5olkEMM5o2QrfmqPOIStD/nywDSWJe744Ms
         JxTTIoWVci75wb+1xryoxWeoF9OFwAQS71Yy9E1Mv6S2NAn4J9ybx5ZjiQM+x6FduhCY
         dlOvfeSRvZ4gH53HDBlrJCwWklaWFrQJB+d5pbyQ78EdbBGk6LQvefsl+vshUeC72mvs
         cAWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787727225; x=1788332025; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gunoR0/5m2ShIW1cBAYYWni95R3wXjfnlI5bo7Tk+30=;
        b=Bm4A6INiIvlrIYG3BZeaxd87P4ldXOztZ8a7bNAl2HvU01024nRBW4IwbkEZwLBD7z
         GVwXXamxuDMINoHIXgawtxrPSl57PFbimkE42Wp7RBaDMKPcfJzIrsS6j/75Sa8gYnRt
         LMgaLSTCgNdXF4Fx8NA5WitVhT8ziA8dpWlBRUSHVVGrmGWJCIfba67QmmVZ+8TIuXgA
         dPa5lmh0ANKABgJ5E4uQjPv+IVQNrSvDo+QTCpqggb0AjLCMIgknWBm7Hko+vwPp4VUH
         BsaoPiuFObRudRZdPIWOu+RVVmcaqCW/E9Rl1eCoXFnjg6icXue8CFD/ICyxvUpma9Ds
         k3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787727225; x=1788332025;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gunoR0/5m2ShIW1cBAYYWni95R3wXjfnlI5bo7Tk+30=;
        b=clQd/bv83uP5TSLZZMOpeoVCY12STL2xBaiAM5+JTLSd5AYlLUdYbFlQCmoN9sqmsh
         BHaQVKU5sQs3HkGOVF1tvB5BQ7RzNi7nIBnUreriZWvEszzIPYe3NYzBIwGEkJ5C+SFJ
         W35FnQFkUnwgATuKLgLZbWVjdJsj3CjiBAI//+MaCEkUSHLp2Vr8zl/ieQza1YjBINpF
         Gzo53dedZ7mgDOT4xqGoInEi6mB+XaaAiwuP+LpaLFxb18kSU/rPKecucZk/ddBtleUr
         3zJCfJA5hi2II6KmUN3NNoesBFe+UD7kx6hfFW2Lrjhxau3DYHOVHBodglvtVXHS07J6
         hZxA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8JYhBvaKkoDFvPtvP6Gs2D38VgU/TaAPmy+iFi3Z0x4sYEPTVaZ1WxL5ioyEbgmdnD9xhipr+9bPDIyzqyuysSYk=@vger.kernel.org
X-Gm-Message-State: AFuF++nIFVZHn1greuIXyQEmgTb3b0p5xdEIWN6P2FaLsO0cnH3O7z5B
	qdMoXLYHJiTEl0CcBp0Fowx1/H7VwbjtMHw2U+jKj6vDhc69rheJj6xyTccpi8aB94+5iQqKaFZ
	rYMAD5WmpUTeJovCHzYPKeooSvUijLWRGhLUjPXgA
X-Gm-Gg: AR+sD13Zs47e1qfGQtBFNUe9K+EOt9sRfNq4PYjfVEDEjU8SriUtlj3Tr8XaOr0vdqb
	Gz+SlYQUiZpGn+w2+7u1ZbnH/k2aQfSAJnTyp/jbCid/ePxTyq85OQ2lXlomB9XC9ScRoVdXUMw
	fIi/x5kTfQiH3jy/H63k1XOTroFWJEbjBsUAX1j3tpdlWtKAP0V0srBYAkVQJAvDR0cVp1P5bgp
	vdjYMTkhCWywUhW0/rWN24C9C1mi800ddoimQ4p1NHK9yXp27wjx4VAeBhc+ZE80uIH+HBfmvgB
	BAY5h9V9K6yk7yRC8bfeA3xpbo4/Ud3BYJjQiH0bHFV/4Ob3FpL6awVUzctGz57xbzyjM2vXatQ
	4owV4LxF8h71BuZPDyiPmkpydGG64mw==
X-Received: by 2002:a05:622a:1b86:b0:51c:fc4:a144 with SMTP id
 d75a77b69052e-52e4228ddf0mr40451941cf.4.1787727224807; Tue, 25 Aug 2026
 23:53:44 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Aug 2026 23:53:43 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Aug 2026 23:53:43 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ao4Gmn5tSZMhl_nX@google.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-7-2fc18ee6d3ba@google.com>
 <a410cca6-0776-44af-8353-9b7375e2fd4e@intel.com> <CAEvNRgGvxMus6pp=xuDYOumH3Ge4oi0=YKjTaFykFHwXuzRDwg@mail.gmail.com>
 <54d1bd0e-c27a-4033-ab97-02cd9579a620@intel.com> <CAEvNRgFhjbgC9Ng1qviPx4oE=qihUwiBcsYOgJG3yOU-nLG1hQ@mail.gmail.com>
 <ao4Gmn5tSZMhl_nX@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Aug 2026 23:53:43 -0700
X-Gm-Features: AcwNN1W7XYwPjQi0IwDu9VBVz85rJlKXjtpX9LauU0RxJJUn8oPq1JlhbiQWidY
Message-ID: <CAEvNRgEHZZLXyhQ5HiHcTbCk65Y2Lb-fYu0fZ+LRMm1_eWgeSg@mail.gmail.com>
Subject: Re: [PATCH v10 07/41] KVM: guest_memfd: Stub in ability to enable
 in-place shared<=>private conversion
To: Sean Christopherson <seanjc@google.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
>> >
>> > I'm looking at the doc of KVM_SET_USER_MEMORY_REGION2, which reads
>> >
>> > # When mapping a gfn into the guest, KVM selects shared vs. private, i.e consumes
>> > # userspace_addr vs. guest_memfd, based on the gfn's KVM_MEMORY_ATTRIBUTE_PRIVATE
>> > # state.  At VM creation time, all memory is shared, i.e. the PRIVATE attribute
>> > # is '0' for all gfns.  Userspace can control whether memory is shared/private by
>> > # toggling KVM_MEMORY_ATTRIBUTE_PRIVATE via KVM_SET_MEMORY_ATTRIBUTES as needed.
>>
>> I'm not sure how this snippet from the documentation connects with what
>> you'd like changed.
>
> It's flat out wrong once in-place conversion lands, because it assumes PRIVATE
> is tracked per-VM.  Something like this?
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 4eb7e75a7473..c9769e5e7329 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6383,9 +6383,12 @@ on-demand.
>
>  When mapping a gfn into the guest, KVM selects shared vs. private, i.e consumes
>  userspace_addr vs. guest_memfd, based on the gfn's KVM_MEMORY_ATTRIBUTE_PRIVATE
> -state.  At VM creation time, all memory is shared, i.e. the PRIVATE attribute
> -is '0' for all gfns.  Userspace can control whether memory is shared/private by
> +state.  If in-place conversion is disabled, i.e. PRIVATE is tracked per-VM,
> +then at VM creation time, all memory is shared, i.e. the PRIVATE attribute is
> +'0' for all gfns.  Userspace can control whether memory is shared/private by
>  toggling KVM_MEMORY_ATTRIBUTE_PRIVATE via KVM_SET_MEMORY_ATTRIBUTES as needed.
> +If in-place conversion is enabled, then the starting PRIVATE vs. SHARED state
> +of a gfn is determined by the relevant guest_memfd instance.
>
>  S390:
>  ^^^^^

Will apply this, thanks!
