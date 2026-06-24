Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941C15695
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 00:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782259769; cv=pass; b=ipiRakXqC9sAJQQIMFQT7LbF2lHE1I3j9Cfpn6GXsFYBYIqyra3xaw9z0vpn1usZ3CgHaS6voPhQW+ptiwy4t4+ZNpl+QB/s0OE1fzUXOFBsXriTQHQXkhIhz64ataSsAlYLwA03oySjBlpUypVWVwVGQpr3Zj0xeMXIQty1dxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782259769; c=relaxed/simple;
	bh=rQfqkBaw/xkmyQgEiFlC2Kezzoeugio7gq7U/cPAgVE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPB1FMLW8v3gHs7goyyVcQ28Nv8DCrjR+4qU5FdNxYyOf94yV9FWYS5+3LTNl4/NQKVEmGlW6L094l/xa1omDqC+4Czc6pAQLt4isNDhI+eeTXK2M9Z+Jha+YLxIlQCRH+UHXT/TR8I7RxPiHYT0M9OWXVcy8iK5s7/q22e4qPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=veUsiC1C; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veUsiC1C"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-139b5e604b9so540333c88.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 17:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782259768; cv=none;
        d=google.com; s=arc-20240605;
        b=kmL70uEd3vZBagSjFV2tItS0MDfQAT6k/1G+z7nN7Is4FDnLQd6ccY3bjj//ZWTw9C
         ANyeUiGCCWQYkQkAjq+irt9ybQXwijyvsadfF3VBjoK/WcqAyZ9TtxvFdMdkeQGdB5XB
         mGA21PWApCMvye7CiTpeqjoTvpDV1XA06oshrx43ARD9Ek2egjfmYLRuay5e00t6c0pu
         jRFR4iaFBK8rqukV61i2AajimAP326Cj2z3YBVJfhIKktPOtWK81n5o3aN4WJRXlC/eC
         6kcZMP1rkvsIh/BqcBx+p1AIFj2UYQs76xd/P1zvyjPvUqKQ1AOmU9q0x0i1IpgSvDyM
         2q0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=LOf9tviNFkAeKYv+XoLw2pXVKZU7weWckYUjDtw8Ax8=;
        fh=M4eND1TO6RB5IQh2Tz4SzWUJ1abHVQ+c+E9Fw/mLTbk=;
        b=azXXo/5BrRZIxGHiOJnf8WZhY1W5qTmktW9fZKUdijEuJds7tK1cqHXMvX6EZPxYN3
         aXZzs8KhSP8gvKH9u/US8BDPmzSkGtK4xQUcVafkBYmsUxEZcuVLUHKNuqIqCBt4WhMA
         tlg4BDxbPltcyL02QJQDd+TfaOccN70aN4cLBhq/k8dJ0WTqZb4yxbOzaUxUY8YSNz7q
         uo4bSd06wct4GmhCDFUlGG0pS8AVWfUv/k9IF3kqTe3FHeWcgg8/QhclT4wmKwC90N2e
         lDDjad6PDHXRDN1+XOV0tX7cCqu7K+6hZgpOQmN5qXhHHOXJ+2cuFNpB2/vmgdGKL0/V
         QMeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782259768; x=1782864568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LOf9tviNFkAeKYv+XoLw2pXVKZU7weWckYUjDtw8Ax8=;
        b=veUsiC1C69EY+fW+phEEcbGGJR1QtHjfW0d5G1V91rsvTaqXDyiTLhXXS9KvXQDxcZ
         oWZfD4aPELOrcjBl0S4WaAofqhRsh7rEZ5pQO3FCfS3ra6aku162Pf0qCkXR+xXopq1O
         IQKeS/G6Yi915cxG1Q5coGJU9a+qvcY+2pF5iSXRniVzMo3wiX9bpO5siiQcu5hv10zG
         IRNmijyT3ZTFPax8idXSgIdxbUpbhO10FVExLS2PxXXeKQXDrr99e5Cw7mM91YAKYLN/
         5W7OT8L10Oa4D+7xzkF7MBH1sJvrlSEyXhHEhhSosvwz7SMH4/WDaSXCQlJ4lOg1Sf2i
         XC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782259768; x=1782864568;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOf9tviNFkAeKYv+XoLw2pXVKZU7weWckYUjDtw8Ax8=;
        b=l5TdpUxO55n6jOBG7VieeI0qYdAzZ5Enr8CF7p+J4ZP5ma/r9srPPiPn0gQZpbI5up
         0dxZlczH7q/ibSTDMUzDJTL4YgTm/kBSAHj1YlaR9b/K/Zjq2k0IgOVN1vCVXc1FyqEL
         9CGGpD4Us5pwRNKYsXA74i1TEqPwT+0dZogBRNmUbmBeh/9PIUlHeVcE7yIrSyjJdZj2
         8iu6OBe5xF3oERMTpkl+qjyAPwu5ZPSidxtXQ0zHmnWKBOpz+6v5fXWuUYRTqAxPM/EU
         vR38UjxTjcLlk8yY+WLEFjDRfMfcAcUyUlaVWsP1B8zVgM/jMeUnaZoEDcNdz4gc9F7v
         6I8g==
X-Forwarded-Encrypted: i=1; AFNElJ+FilQYxGZi3dNYMTB8ImcvrLBt0mzl92lkMeexED3UGqucdX4PaDd6EIj8rKXNjQimyLQjbdfScuvmCN80sk9xj/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJwNa2oYp4y4ecpgWVrnI8zyT1RmwYD9qdE6vYF5cVhKCsrw1w
	7LBiZ7MiqymeEVIV3PMTri4Hm3dc1ouoMjzr9xP2I+xRS3KID9v8t/WeA67P5oYJiHMaWhdHDyf
	Obpswfyql6+XDe3KL4s53cT+KI5AK4AkEesXcK53c
X-Gm-Gg: AfdE7cmGNCSW45gKs9FKxeuCEmOj2GuMknI0tFgD+C/vb9iHrm09IAuPSumZYMg8TkG
	oCzOGzXPfHOwNB8e+tFN/A0ouoXYLidNWeuOV2f+0YI3sbcelIdXRGZoM4zvQGHNRK6O4IcjHxi
	ZFwZkyJNhgwAXHTuSAkpcNS93PncpEwM58Tn6UgfXJ5RZ+IVr6nzgrt14zRB50o3NMs+kl+3S8c
	6pksD8gvVciVrDA1vm/15DwK9miVDnY8YQSS6dRV122K3hAQI/88e4JiMwYOby2krRByGVlBnAB
	GiH686Mih4rifYgP4mwVcPz5ZyBzqItzQ/V9K6lX+2FFNub8hjMJmhdtwIk=
X-Received: by 2002:a05:7022:45a4:b0:127:3f2a:af21 with SMTP id
 a92af1059eb24-139c5cff378mr4117596c88.15.1782259766886; Tue, 23 Jun 2026
 17:09:26 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 17:09:25 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 17:09:25 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ajnjTJdQKD1Kz3tf@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-1-9d2959357853@google.com>
 <aceb07e1-77bc-49b6-a932-5fd9b5a21727@linux.intel.com> <ajnjTJdQKD1Kz3tf@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 17:09:25 -0700
X-Gm-Features: AVVi8Cdk7fD1H5RbfHSz0rAk7YN_q01NbBdLx3di9F5nnt4X6vdgAPFTH7tGEuQ
Message-ID: <CAEvNRgFU4H5FrjQvLMQm9DOQ9ujiHfFfsV6zVKNVi-rzC_zSxA@mail.gmail.com>
Subject: Re: [PATCH v8 01/46] KVM: guest_memfd: Introduce per-gmem attributes,
 use to guard user mappings
To: Sean Christopherson <seanjc@google.com>, Binbin Wu <binbin.wu@linux.intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Jun 22, 2026, Binbin Wu wrote:
>> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>>
>> [...]
>>
>> >
>> > +static u64 kvm_gmem_get_attributes(struct inode *inode, pgoff_t index)
>> > +{
>> > +	struct maple_tree *mt = &GMEM_I(inode)->attributes;
>> > +	void *entry = mtree_load(mt, index);
>> > +
>> > +	return WARN_ON_ONCE(!entry) ? 0 : xa_to_value(entry);
>>
>> If the entry is unexpectedly missing, returning 0 means the attribute would
>> be treated as shared.  And then in kvm_gmem_fault_user_mapping(), it would
>> allow the userspace to fault in the folio.
>>
>> Should gmem deny such edge case?
>
> After several bugs this year where a WARN_ON_ONCE() fired, but was entirely
> insufficient to prevent true badness, I'm definitely senstive to making the "bad"
> behavior as harmless as possible.
>

I guess both are indeed awkward.

> However, in this case I think we're just hosed.  If KVM treats the memory as
> private, KVM will incorrectly do prepare(), incorrectly allow populate(), and
> will caused missed invalidations (though I suppose __kvm_gmem_set_attributes()
> "only" lies to userspace in that case).
>
> That said, assuming SHARED is definitely odd for cases where guest_memfd *can't*
> hold shared memory.  Ditto for assuming PRIVATE.  What if we instead fall back to
> the "init" state, e.g.?
>
> static u64 kvm_gmem_get_attributes(struct inode *inode, pgoff_t index)
> {
> 	struct maple_tree *mt = &GMEM_I(inode)->attributes;
> 	void *entry = mtree_load(mt, index);
>
> 	if (WARN_ON_ONCE(!entry)) {
> 		bool shared = GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED;
>
> 		return shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;

I was wondering if we should not only return the init state but also set
the init state, but that would involve performing a conversion to the
init state... Too complicated for an edge case.

> 	}
>
> 	return xa_to_value(entry);
> }

Thanks Binbin and Sean!
