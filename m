Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683643DCDA1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330271; cv=none; b=tgxjkwD+NyaDjCy9Yg9RDQ/LYWqAze3AHs8DXC2JPLPgF0i8PSuMPkCKfUSUxTWb5HPsDawSMYmkbEEjTyJ6VYwGga3b6fKVvu69SFjnIQNKeMezV9C5TQiSffFslB/sELeFKNAXE75zMvm4/xKrPiCof1QQDqeMNEavdxMhtLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330271; c=relaxed/simple;
	bh=576TIn2jifWj7C0GPxk/j0rxm6nFEdPvdqAY5vC0peA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fdycJlKDRR/nhiVT3LWlgzbgEopi5gIHUuTZi10to1jaqMQbWU1DZLWKsLpJ7wLdUpODuFnMipifObW3jie5aGSigqwpk/EYwolL/WHp+oqBr+34bT4fTAADI37ocrDA5cSB30Kt3ZYSxXYUMBKM3EiMhuqfr3W+vBa9y3rUc+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZDoJ4YMz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDoJ4YMz"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35a032cdd78so4895070a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773330266; x=1773935066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfjX+chjGEd0BK+/hAaiX1yXd2SlEDAudQ7PcUmbUhE=;
        b=ZDoJ4YMzUjZdLiA/xuOjahkYsfmqCW43oQwBDZBPoK5GTP72YA/ZZMaE40BGGWsz35
         r3qsjKhQANm8Y54Q5HKNP+4EQRPj3RNasRoUdRHy3KM+NlO6JayRtiDOumCZuSRnpiWl
         v8pSWK9CPfxk9bwDOIoxz0WYsIHeqF6JJxio3fh97yUuCYYOSxwOqbirfc+sq14/FxEt
         gfF6HjvHqtlZQuHS/w2rdjkpdQl9Bi6egv4U4nhaenpqJ15wMk7CzmFTqdSEZzgK/o4s
         BTYrDUTA7Qde5FxYLZqKrXri39s+nPAq4i1Zdr51opM3qwvXu9KRRyiMEWfhyKHe+evw
         +eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773330266; x=1773935066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfjX+chjGEd0BK+/hAaiX1yXd2SlEDAudQ7PcUmbUhE=;
        b=NpysgdYbWONKicB7tSLSUUjnu0H2asd84I1aiN/NVYIpixYHVApHz9WHUGvI3OtNRX
         Lap79Pt1O+YQgEFteEBLu23MiHcqciLa8sff7MNeilxXYvg2sUIV4+5OzwPMCFaDQ2lk
         1xvyh+1wVSO9x4xv4vMoFXnMZiE5e3cI5ZBhI7cOS+qk/qAMNNTr5HBpTb6c6xM/5s0e
         dnxTep/AK98JFVysK7zv+c9GzVlxVFL+tkoZTwhAn6oj7Jw/a2RpmuZiJqowPcClPi36
         F1JO4s6O+lpKglDCR4Ccx9is2JKZnyP4auYoLL+3qQ1ozfhJyDzHgq2S1zNhjFNycuPK
         snRw==
X-Forwarded-Encrypted: i=1; AJvYcCX/YECRgjP5CR86jG8uvfntDVozQQquVcDErnVyxnE1Gtap+CInViCMy3tzTtht/DiMYLvMmea0RbQZV0j43w0rSg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfseHAWVifIvEVvh8FetKYCw2WrHMOWG/Sv6C7IlLeqRlYlfCC
	K72fFGojDVEBiUJzQxNvpTQW6lQ8JIMKyCU0x5W76650wumtnSXVf3L6M8EZrdUX/vFsi8fCsO0
	CdqGDwA==
X-Received: from pjpq11.prod.google.com ([2002:a17:90a:a00b:b0:359:803b:2e2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d03:b0:359:8f13:667d
 with SMTP id 98e67ed59e1d1-35a22055567mr113663a91.27.1773330266114; Thu, 12
 Mar 2026 08:44:26 -0700 (PDT)
Date: Thu, 12 Mar 2026 08:44:24 -0700
In-Reply-To: <CA+EHjTy2urW2Tj5czQDKUHdri7FCLfw2mafTgmmtFs+-7ueoiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com> <86ad28b767524e1e654b9c960e39ca8bfb24c114.1770071243.git.ackerleytng@google.com>
 <CAEvNRgFMNywpDRr+WeNsVj=MnsbhZp9H3j0QRDo_eOP+kGCNJw@mail.gmail.com>
 <CAEvNRgG-L+GBcm+u_thGvXAxV-Nqzu5VtgXy0PfND6SG0FiyVg@mail.gmail.com> <CA+EHjTy2urW2Tj5czQDKUHdri7FCLfw2mafTgmmtFs+-7ueoiw@mail.gmail.com>
Message-ID: <abLfWHf89TxWqeGZ@google.com>
Subject: Re: [RFC PATCH v2 09/37] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
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

On Thu, Mar 12, 2026, Fuad Tabba wrote:
> Hi Ackerley,
> 
> Before getting into the UAPI semantics, thank you for all the heavy
> lifting you've done here. Figuring out how to make it all work across
> the different platforms is not easy :)
> 
> <snip>
> 
> > The policy definitions below provide more details:

Please drop "CONTENT_POLICY" from the KVM documentation.  From KVM's perspective,
these are not "policy", they are purely properties of the underlying memory.
Userspace will likely use the attributes to implement policy of some kind, but
KVM straight up doesn't care.

> > ``KVM_SET_MEMORY_ATTRIBUTES2_CONTENT_POLICY_ZERO`` (default)

The default behavior absolutely cannot be something that's not supported on
every conversion type.

> >
> >   On a private to shared conversion, the host will read zeros from the
> >   converted memory on the next fault after successful return of the
> >   KVM_SET_MEMORY_ATTRIBUTES2 ioctl.
> >
> >   This is not supported (-EOPNOTSUPP) for a shared to private
> >   conversion. While some CoCo implementations do zero memory contents
> >   such that the guest reads zeros after conversion, the guest is not
> >   expected to trust host-provided zeroing, hence as a UAPI policy, KVM
> >   does not make any such guarantees.
> 
> The rationale for not supporting this in the UAPI isn't quite right
> and I think that the prohibition should be removed. It's true that the
> guest is not expected to trust host-provided zeroing. However, if the
> VMM invokes this ioctl with the ZERO policy, the zeroing is performed
> by the hypervisor, not by the (untrusted) host.

What entity zeros the data doesn't matter as far as KVM's ABI is concerned.  That's
a motivating favor to providing ZERO, e.g. it allow userspace to elide additional
zeroing when it _knows_ the memory holds zeros, but that's orthogonal to KVM's
contract with userspace.

> Although pKVM handles fresh, zeroed memory provisioning via donation
> rather than attribute conversion, stating that the UAPI cannot make
> guarantees due to trust boundaries is incorrect. The hypervisor is

We should avoid using "hypervisor", because (a) it means different things to
different people and (b) even when there's consensus on what "hypervisor" means,
whether or not the hypervisor is trusted varies per implementation.

> need to be careful witho precisely the entity the guest trusts to enforce
> this.
> 
> The UAPI should define the semantics for a shared-to-private ZERO
> conversion, even if current architectures return -EOPNOTSUPP because
> they handle fresh memory provisioning via other mechanisms (like
> pKVM's donation path).
> 
> How about something like the following:
> 
> On a shared to private conversion, the hypervisor will zero the memory

Again, say _nothing_ about "the hypervisor".  _How_ or when anything happens is
completely irrelevant, the only thing that matters here is _what_ happens.

> contents before mapping it into the guest's private address space,
> preventing the untrusted host from injecting arbitrary data into the
> guest. If an architecture handles zeroed-provisioning via mechanisms
> other than attribute conversion, it may return -EOPNOTSUPP.

No.  I am 100% against bleeding vendor specific information into KVM's ABI for
this.  What the vendor code does is irrelevant, the _only_ thing that matters
here is KVM's contract with userspace.

That doesn't mean pKVM guests can't rely on memory being zeroed, but that is a
contract between pKVM and its guests, not between KVM and host userspace.

> >   For testing purposes, the KVM_X86_SW_PROTECTED_VM testing vehicle
> >   will support this policy and ensure zeroing for conversions in both
> >   directions.
> >
> > ``KVM_SET_MEMORY_ATTRIBUTES2_CONTENT_POLICY_PRESERVE``
> >
> >   On private/shared conversions in both directions, memory contents
> >   will be preserved and readable. As a concrete example, if the host
> >   writes ``0xbeef`` to memory and converts the memory to shared, the
> >   guest will also read ``0xbeef``, after any necessary hardware or
> >   software provided decryption. After a reverse shared to private
> >   conversion, the host will also read ``0xbeef``.
> 
> I think that this example is backwards. If the host writes to memory,
> that memory is already shared, isn't it? Converting it to shared is
> redundant. More importantly, if memory undergoes a shared-to-private
> conversion, the host must lose access entirely.

Ya, it's messed up.

> Maybe a clearer example would reflect actual payload injection and
> bounce buffer sharing:
> - Shared-to-Private (Payload Injection): The host writes a payload
> (e.g., 0xbeef) to shared memory and converts it to private. The guest
> reads 0xbeef in its private address space. The host loses access.
> - Private-to-Shared (Bounce Buffer): The guest writes 0xbeef to
> private memory and converts it to shared. The host reads 0xbeef.
> 
> >   pKVM (ARM) is the first user of this policy. Since pKVM does not
> >   protect memory with encryption, a content policy to preserve memory
> >   will not will not involve any decryption. The guest will be able to
> >   read what the host wrote with full content preservation.
> 
> This is correct, but to be precise, I think it should explicitly
> mention Stage-2 page tables as the protection mechanism, maybe:

pKVM shouldn't be mentioned in here at all.

---
By default, KVM makes no guarantees about the in-memory values after memory is
convert to/from shared/private.  Optionally, userspace may instruct KVM to
ensure the contents of memory are zeroed or preserved, e.g. to enable in-place
sharing of data, or as an optimization to avoid having to re-zero memory when
the trusted entity guarantees the memory will be zeroed after conversion.

The behaviors supported by a given KVM instance can be queried via <cap>.  If
the requested behavior is an unsupported, KVM will return -EOPNOTSUPP and
reject the conversion request.  Note!  The "ZERO" request is only support for
private to shared conversion!

``KVM_SET_MEMORY_ATTRIBUTES2_ZERO``

  On conversion, KVM guarantees all entities that have "allowed" access to the
  memory will read zeros.  E.g. on private to shared conversion, both trusted
  and untrusted code will read zeros.

  Zeroing is currently only supported for private-to-shared conversions, as KVM
  in general is untrusted and thus cannot guarantee the guest (or any trusted
  entity) will read zeros after conversion.  Note, some CoCo implementations do
  zero memory contents such that the guest reads zeros after conversion, and
  the guest may choose to rely on that behavior.  But that's a contract between
  the trusted CoCo entity and the guest, not between KVM and the guest.

``KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE``

  On conversion, KVM guarantees memory contents will be preserved with respect
  to the last written unencrypted value.  As a concrete example, if the host
  writes ``0xbeef`` to shared memory and converts the memory to private, the
  guest will also read ``0xbeef``, even if the in-memory data is encrypted as
  part of the conversion.  And vice versa, if the guest writes ``0xbeef`` to
  private memory and then converts the memory to shared, the host (and guest)
  will read ``0xbeef`` (if the memory is accessible).
