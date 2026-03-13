Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F621C8634
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 00:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362197; cv=none; b=dscmxLGmKKw9wFL1pVrpdUeLNoox41tDEYdzaVECpe/Kaagt8XJXHmekmsxGB59wqYKPy/MMimm7POrcjV2EcDUVQTDmVMkzCKUJARYac4AbcH1lvDfncK5Rs2BfI7rDiqwpapLPTN/va5q+uPNGG8dJNCXcpxTAjw3Mjc7NBZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362197; c=relaxed/simple;
	bh=9oIvEgCdqEl+AGZYDSEAFBDA6RTB3elZif62x1BQroI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Noit4/C6EKC+RVoAqWrttf5mkOi1AMezLgHow6gNFpaXb1r5QmdR94WYKC0SjWmcj5El2iBkFgRJdM8kk/wC1QDkSA9TWVZq0usfJ/8i8n7HLYFD1tYsCIp6B9OTAFEQva7LqbwLhya0WS1jPBP4eoLefAwIMyy3Iyz1xlb41ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tbr6d3rA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tbr6d3rA"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35a0b51eb23so1053464a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 17:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773362195; x=1773966995; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=msDdWC7KsVzGR7+a7KYP2KJHZfc1KrX2g6o6c66TQ0I=;
        b=Tbr6d3rA2menzviTRGUxxZ/si/4YqVxHLGAIIYU6rftjAVvS4DqBQFBP+SNle6fuGw
         BH61TbGgpLa0hrFoPxm7W2WyN0FxrzKw5wj6dfMQ6molTQcALy10kT/SA2kdGdB487OM
         8m7OKaFZjLA3qfFIr9iGtEhB1zTiFJOGY7lM8+lbg31xmTBOytAlDlV1uiFKnIz70yoO
         ymOdFRtG1OnQYqpdEXjqrUdzwgSeY4IuS9YuG4qXBbv6KclUNvdx6yBQ3N65rfDmFUBL
         xSd4h7fnjC7mYOcv61a9sHykaFyLshubWOaXp6RJ/WzVOFLy2EBwWmrMUFPW/ye2Groq
         wY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773362195; x=1773966995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msDdWC7KsVzGR7+a7KYP2KJHZfc1KrX2g6o6c66TQ0I=;
        b=p/o/85WcdBYlU0mC+TedUbf2Nh466fMfdtQ8aFki0SlaT4XHWshDOtC5SUBjr8JJHm
         hwQHk5/ANBUsbZYmC7m2l2rftISBa5BLRjuq7xYvatvnHtxDjcDheIqwgMOE6H35z+UL
         4YNbm8DxQQEAHep0+aP2rg3YpRP0Yts1Mrji059f5sPQVDPwid6vbx2Xmcf+Wjr1OlNi
         MhWYlED00zd3y8hBiEjs0xvCoyR+DQpjOdYzw4kxU6b//EbF1/TL1/dZTNWIRkacAXHl
         NP+0D5hcwAxxUz1II1Z4YPK3a8KkdQxFg6+2xRrZMr046ulRt0IOt2bjTKWbmmTWs3UV
         aFPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVGeIwIUTAR9Zp/GmYz9vKR/3z/tMebZ2ENlYDSsZ++s//gIE9NvsA69wQSWXhx+qmN55U8aBBKxdVEJGMSfJYqsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZbN3FF244noWDvBGSWpo2nXKbVA172usTTkRPLiJUR+0mFgDg
	v+YUl+gv3gFnmYvY6qSK5BE/7HCRr1fllakBb7XGuYW24mP/eXuMMXaFFnZvH2HXu74FY8UClgC
	t4jWIAA==
X-Received: from pjdd8.prod.google.com ([2002:a17:90a:2c8:b0:359:8f01:6c5a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c4:b0:359:fcba:6517
 with SMTP id 98e67ed59e1d1-35a21fd7ab5mr1194105a91.19.1773362195351; Thu, 12
 Mar 2026 17:36:35 -0700 (PDT)
Date: Thu, 12 Mar 2026 17:36:34 -0700
In-Reply-To: <CAEvNRgFUc+9xCoN9Yo5NThHrvbccWAhPwp9nNM2fvx7QqrcJsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com> <86ad28b767524e1e654b9c960e39ca8bfb24c114.1770071243.git.ackerleytng@google.com>
 <CAEvNRgFMNywpDRr+WeNsVj=MnsbhZp9H3j0QRDo_eOP+kGCNJw@mail.gmail.com>
 <CAEvNRgG-L+GBcm+u_thGvXAxV-Nqzu5VtgXy0PfND6SG0FiyVg@mail.gmail.com>
 <CA+EHjTy2urW2Tj5czQDKUHdri7FCLfw2mafTgmmtFs+-7ueoiw@mail.gmail.com>
 <abLfWHf89TxWqeGZ@google.com> <CAEvNRgFUc+9xCoN9Yo5NThHrvbccWAhPwp9nNM2fvx7QqrcJsg@mail.gmail.com>
Message-ID: <abNcEkNseDEBIhop@google.com>
Subject: Re: [RFC PATCH v2 09/37] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chao.p.peng@linux.intel.com, 
	chenhuacai@kernel.org, corbet@lwn.net, dave.hansen@linux.intel.com, 
	david@kernel.org, hpa@zytor.com, ira.weiny@intel.com, jgg@nvidia.com, 
	jmattson@google.com, jroedel@suse.de, jthoughton@google.com, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, shivankg@amd.com, shuah@kernel.org, steven.price@arm.com, 
	tglx@linutronix.de, vannapurve@google.com, vbabka@suse.cz, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 12, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Thu, Mar 12, 2026, Fuad Tabba wrote:
> >> Hi Ackerley,
> >>
> >> Before getting into the UAPI semantics, thank you for all the heavy
> >> lifting you've done here. Figuring out how to make it all work across
> >> the different platforms is not easy :)
> >>
> >> <snip>
> >>
> >> > The policy definitions below provide more details:
> >
> > Please drop "CONTENT_POLICY" from the KVM documentation.  From KVM's perspective,
> > these are not "policy", they are purely properties of the underlying memory.
> > Userspace will likely use the attributes to implement policy of some kind, but
> > KVM straight up doesn't care.
> 
> Policy might have been the wrong word. I think this is a property of the
> conversion process/request, not a property of the memory like how
> shared/private is a property of the memory?
> 
> I'll have to find another word to describe this enum of

Or just don't?  I'm 100% serious, because unless we carve out a field _just_ for
these two flags, they're eventually going to get mixed with other stuff.  At that
point, having a precisely named enum container just gets in the way.

> I see you dropped any documentation to do with testing.

Yes.

> I meant to document it (at least something about the unspecified case) so it
> can be relied on in selftests, with the understanding (already specified
> elsewhere in Documentation/virt/kvm/api.rst) that nothing about
> KVM_X86_SW_PROTECTED_VM is to be relied on in production, and can be changed
> anytime. What do you think?

KVM_X86_SW_PROTECTED_VM should self-report like all other VM types, and shouldn't
support anything that isn't documented as possible.  I.e. we shouldn't allow
ZERO on shared=>private "for testing".

What I do think we should do is scribble memory on conversions without ZERO or
PRIVATE, probably guarded by a Kconfig or maybe a module param, to do a best
effort enforcement of the ABI, i.e. to try and prevent userspace from depending
on uarch/vendor specific behavior.
