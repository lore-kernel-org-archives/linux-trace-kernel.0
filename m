Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA8A384242
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773390806; cv=pass; b=ZPUsJBHSWNzlcQ3nfdlEtHFi7oRiWIkAD56PWv6kptR65vhJ1nwR7AjBUVHOoHlTK1VN5iPtblcrJsaRL0HTM2g6O4LeayLdIyqmi2Yzm33i+LCWEIpTHt6aDIpd7MooJeSb4dJ0AREEDKb/7USfNJ1Qq1d8LmsQteixVP8+TlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773390806; c=relaxed/simple;
	bh=Nhlp+IHXNVySMgNUt1ii8X1l7FQ+Mw0ootJ8uYr949w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b09S/aCG0KftYkPX2XGOQy9o+x7u+J186uiWN5ibJy/ANO1pMP8HDEUVM1dp7PglEs+ix+3eGwSrM13LuqRnWagIBPUEtD004MjupHbf2cT4qOENjCkyjE44bumRjcy0BbPkSGMWGxCx3QVCXnWrrLj5fH4R9beGbRqci8GBbKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c9D/VzDW; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9D/VzDW"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5091ed02c54so295471cf.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 01:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773390804; cv=none;
        d=google.com; s=arc-20240605;
        b=d5U9OilzSfu1LEX2TRE7C8M70B8F58132XvVh/ITf0Cf8QbzcASBNYf3obH/7nGwaV
         N9HwUq2n8nWyeNBJQJHG4iQicQ5YUgULQFJ9ruu4JA7fgQ7yS+6CIK7LbGOQGbVhCJcY
         B5qmP/uvXtgbzAiC2aoi7P5fi0/XWqpFY4mgPZ2UpqQiawYlOV3VNclitqXn8dILPW9s
         4xHTwmfZy56OpQIIFIxk5TQTofk3PymSp6yeImpJvHe7c2gQhR9xdjZsmtS4LbMYOusW
         Ajjz6anA0f3Muq5YbQE3EtmRk5+LUCFvURBQCpBNXzaMXhAFAlQMfeHgPywfZI+qe2KS
         x6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cD8HoG2tID/gH/E5EhaBddCA2irOciAAr3AbkzzwhPM=;
        fh=OYNKFrC7TYZGK1kta5QB1u6WdXPzWzRBPs47nmZz600=;
        b=jBYTxk6mFkAMJn7nMLAZdV6JsRecZpKTZ6pQFe2DvKkv1Mz58h6fmREa1HSfN9cKH/
         7DpsKMdcEGUxgCjoXMfzIlEQ6Pnc6AJGnZQIJR2UKC+XD6kcilhcaRqyLYMWAooCa8Ig
         RI8QJkbzp0R+9piTZ4K0OpOA8UDNmfbjwjGiVHW+5m2rl0KalPI+OlHxBobH9mfWYj1I
         3HvQ10f9fh3fMkQZZR8vu3xK8V/HOtBJk9sg3EGq8SeNKZRvONheIyNd00UdAzlEQYJx
         ARtM84cVh/WvjMb//pmEE0BWTefCTJk6SEfw8Phffl5Mw61ggyoCHReysZF2Cb1RPt8k
         dzeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773390804; x=1773995604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cD8HoG2tID/gH/E5EhaBddCA2irOciAAr3AbkzzwhPM=;
        b=c9D/VzDWddEYOEl/qqVUn0JX68GdlzwfOfZhNhJj99a6H7e91FWh9KS7WWMiSTOJ8b
         nJNLbmAgCGVi6yqHknAiKqS7tHdzpPuoU4hqpT7ICSwkITBVRVH47aE6wjtn9/wS4qz7
         +G3QmyEuKp+YhXBCo1tYeoJ1gdVhtWIKiOTFE6vChvFB2yUbDIovAVDjsGf7JvFECERS
         IjecdMlRYCnMceeO+uLt05Qzya7mh9ro7MyUGbvcVrLbIKtXDRwYNr8P5nR4+aLV+sGp
         X0odav7G38PrPtzmMrlCejq1v+Yv/OYGDSG8WQ33bfLlwXhzLBzeUOZ01Fb20jQBEKnE
         WIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773390804; x=1773995604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cD8HoG2tID/gH/E5EhaBddCA2irOciAAr3AbkzzwhPM=;
        b=aCMnGwub2Pke7dnktqlG/TAFwqMVG/nU+wXb3LCdkdE+YiETDGM6pSx4Yf6QhaQa8H
         9EY8Nl9FeXoG8Qeumy8N6hxrjlqlfMstA0gosSXGLOEXoPYau/bVUOZuwlPPug3TPeZM
         1kplhSXWlDqfdm/H6RFgJx5Aul6TCKhPD7yC0rmWYNNfLgb5fWgvGfRXCNa0tOhRI2LO
         9qQUj2mNRWLikUgxaSyJXf/4FeL3mc/y+mIgsZy6cYyJwkOj+YFdadIFxhclFVlUgfXZ
         XhoXYjC9BHd8COgfdgXYSAtQapyrQ8W/sak1H7bgTTnxBnxqhBbXYH5rLfDhPlFFjgzZ
         FD4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOWh3QfXdKnHBLIXRBJj19l2EFj0OCum/d+le3uMP+aSPWnfFBWylm2q/shi9LQNsE+jl5oADKG/qJdjTnHElveoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/BM8YoX+4CSkqR8nQnrbSowB4DhamA7x1d/Iua+NxEf72RRG
	3vLF3kd9sTFiSZIP2CK2qPiugY4iZ6atYlQOXcf3lEIBKzmQQlvp8xVt/inLOzGnh8ZyUiwx1lF
	WT3z/TpqhE5nNsXGxDNH1RHQOzZ/Xnc627x+8TQJc
X-Gm-Gg: ATEYQzx0Ld6AQxLP/XYJks2yzSTUG228KMfYdBDjBdX3q5jFog20QgWAU68QHugB61s
	kcWmKXYXaMlj9w7SmWPGBKwjGfHYdWgrlxWgGlIQCMgYXW6TY2IlUQy7GMtfocyxBFFnmWkXEN+
	O6MRHss6jbVswb3RNjwxCbEJx+2FjLaZcjOx+HhrnneRaXZ13+SKE4LDDj3Zz3eE/D9m7lmz4EG
	KQhvKgQDimPAUXmJ/MzDfFOze+CA/TK2Of19iyWhBh3Pq9sBC+OUcqpkNb0YUzeedV/MZgZJUIJ
	cuXUyRet
X-Received: by 2002:a05:622a:1a89:b0:509:45f:fdd2 with SMTP id
 d75a77b69052e-50959e8684bmr8455681cf.15.1773390803655; Fri, 13 Mar 2026
 01:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com> <86ad28b767524e1e654b9c960e39ca8bfb24c114.1770071243.git.ackerleytng@google.com>
 <CAEvNRgFMNywpDRr+WeNsVj=MnsbhZp9H3j0QRDo_eOP+kGCNJw@mail.gmail.com>
 <CAEvNRgG-L+GBcm+u_thGvXAxV-Nqzu5VtgXy0PfND6SG0FiyVg@mail.gmail.com>
 <CA+EHjTy2urW2Tj5czQDKUHdri7FCLfw2mafTgmmtFs+-7ueoiw@mail.gmail.com>
 <abLfWHf89TxWqeGZ@google.com> <CAEvNRgFUc+9xCoN9Yo5NThHrvbccWAhPwp9nNM2fvx7QqrcJsg@mail.gmail.com>
 <abNcEkNseDEBIhop@google.com>
In-Reply-To: <abNcEkNseDEBIhop@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 13 Mar 2026 08:32:46 +0000
X-Gm-Features: AaiRm51ywXpTuOot2q1XwdhhIuZ40FH3GjYl4tPqPPT-m9I6kc4EDU_1p4w_okM
Message-ID: <CA+EHjTyjjTf26-ob4kPfQDrHN+7z_YGcvtO989SnEUfR+4fcBA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/37] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: Sean Christopherson <seanjc@google.com>
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
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, 13 Mar 2026 at 00:36, Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Mar 12, 2026, Ackerley Tng wrote:
> > Sean Christopherson <seanjc@google.com> writes:
> >
> > > On Thu, Mar 12, 2026, Fuad Tabba wrote:
> > >> Hi Ackerley,
> > >>
> > >> Before getting into the UAPI semantics, thank you for all the heavy
> > >> lifting you've done here. Figuring out how to make it all work across
> > >> the different platforms is not easy :)
> > >>
> > >> <snip>
> > >>
> > >> > The policy definitions below provide more details:
> > >
> > > Please drop "CONTENT_POLICY" from the KVM documentation.  From KVM's perspective,
> > > these are not "policy", they are purely properties of the underlying memory.
> > > Userspace will likely use the attributes to implement policy of some kind, but
> > > KVM straight up doesn't care.
> >
> > Policy might have been the wrong word. I think this is a property of the
> > conversion process/request, not a property of the memory like how
> > shared/private is a property of the memory?
> >
> > I'll have to find another word to describe this enum of
>
> Or just don't?  I'm 100% serious, because unless we carve out a field _just_ for
> these two flags, they're eventually going to get mixed with other stuff.  At that
> point, having a precisely named enum container just gets in the way.

I agree. It makes sense to drop the enum wrapper and the "policy"
terminology entirely. Let's go with direct flags passed to the ioctl
representing the requested memory properties upon conversion.

> > I see you dropped any documentation to do with testing.
>
> Yes.
>
> > I meant to document it (at least something about the unspecified case) so it
> > can be relied on in selftests, with the understanding (already specified
> > elsewhere in Documentation/virt/kvm/api.rst) that nothing about
> > KVM_X86_SW_PROTECTED_VM is to be relied on in production, and can be changed
> > anytime. What do you think?
>
> KVM_X86_SW_PROTECTED_VM should self-report like all other VM types, and shouldn't
> support anything that isn't documented as possible.  I.e. we shouldn't allow
> ZERO on shared=>private "for testing".
>
> What I do think we should do is scribble memory on conversions without ZERO or
> PRIVATE, probably guarded by a Kconfig or maybe a module param, to do a best
> effort enforcement of the ABI, i.e. to try and prevent userspace from depending
> on uarch/vendor specific behavior.

I strongly agree with scribbling/poisoning the memory on default
conversions. If userspace specifies neither flag, actively destroying
the data in software is the only way to strictly enforce that the ABI
makes no guarantees, preventing the VMM from implicitly relying on
underlying hardware behavior (like TDX automatically zeroing).

Cheers,
/fuad
