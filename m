Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39B81AF0A7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Jun 2025 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749773907; cv=none; b=MsBFiNLYFkPtCEBCmnTLV9WSEJ1z35EPSyrhySPQnSv8+NwsOIrkQOmCD036xjjbLeQi7nEDsBmqtXmNePqObBglFdVd2vnEwkEn8+kNCScS+Ax1ih+eHQtdj0/RnOj3eDkaWxXe2yoZmsIJE3/WHGc9ZmcpJbGvgK8CjpZ/vVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749773907; c=relaxed/simple;
	bh=5i/Kz9zGPQ4r2PwKaFldoSkJCG5Brxf1/boOz8euMfE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a1bPIToksg2OnmrjEJ2Y9eTWqZRGCodbz8cRYD62Qx4eQKyd1eTBClQB2R72/ontg/MBUSTfPDGeYU/YOvIBv8N0Q8mVYdkCTgfL899B5OH+fd23KAwsu1cOwzRblw0m5J5y5mXWg1tpeOrwtPWPWXXNwEiLXYWKKj/KNdT6/rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v0bVswyv; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v0bVswyv"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2ede156ec4so1681808a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Jun 2025 17:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749773904; x=1750378704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H43IbeUL3QFdvA9+BVZkV6ea988HyH6lrK+/f8SpcHA=;
        b=v0bVswyv2MwfI6R407WGrzE/AeLvfGDRbjiW8fslXmdOoexLf9lMuJ+HH4GSdVuckF
         3DbtCOi1S02wFPJ0DmTyp/j9ch2bKyHuvXNRm0gMRb33am55qwXQ1ilGAhEHl30gnkUg
         sX11YyrGsLY1n+SU59vwItsg7BS7C4vrABjkBUvaHfNHI2slynFjSDJpq3fE/0V2YhKv
         bqgnt6nVwYxE+yUfa44qNKJ2Wof+Lic9pVLZqgmhfIU0rKMA2Gl0LlHZH06Ik5RsFY4F
         5WdmxaTce9pGLTH7IXsihmkNrDpWsXoe2SbiYNYbhoF4N+Xbl45yQGPUP3RodtlWXr5h
         oXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749773904; x=1750378704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H43IbeUL3QFdvA9+BVZkV6ea988HyH6lrK+/f8SpcHA=;
        b=bFugBkwSPo+bgLj3jmQOHva6N59eCPqORIhI5zfL1RgCkeLFiItQAv6JIZFFGDNkXC
         46ahC7uVi0tVMVrYhuggh+3Pwnp0lhcOGSIKCcADj7xpL0HOntAaYw6fCv/3oxXn5pxH
         1VDNFybP00Ql0tZrjx7ZxU24SqNCbnhl3u167UTKMiaW+Xw2H0JY5EGLomDYH7NveM5u
         hgik0wgeIY80TWIrY61VbRLHa1EEhI9rBsnTYuzNUowcTcJhZK8hj4QezkgTrlRaf63w
         0WKF7ee/0BukfJP13vDMywu2iNUnfswDebzux9UoN15n75mfaeeCzFpYs+Be2m6LwK1J
         txZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJZ57Qg3LZaScz1EbQ+OWQwmXENWqDKZkYpMG8XLlTaHH+9o09Z1Zvy/hUFkvxX5IjxV0CoQ10AyxKuCUcDv6SyIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLXubZ2lncWzSMRMmIXtFTOiJ1hfQsXmUrtkUDEyc2yQu5y19
	MEGvhZWaEACEie9V1uFGPnFMMrhK5MDa1i024WW0c3X2xXfPWQ63KFLQz5lq3PRAz9RzzTwwLx+
	H3XovXw==
X-Google-Smtp-Source: AGHT+IFztzIN+LhXHtkHmf4/zD8JypbwgxvzBHTruUdV5ogDCnmgwrGuDq/b/wwTYKI3W48kBDJVSoH+wA0=
X-Received: from pgbfy15.prod.google.com ([2002:a05:6a02:2a8f:b0:b2e:c15e:3eb7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2352:b0:234:ef42:5d5b
 with SMTP id d9443c01a7336-2365d8a170amr13173945ad.16.1749773903965; Thu, 12
 Jun 2025 17:18:23 -0700 (PDT)
Date: Thu, 12 Jun 2025 17:18:22 -0700
In-Reply-To: <20250612214849.3950094-3-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612214849.3950094-1-sohil.mehta@intel.com> <20250612214849.3950094-3-sohil.mehta@intel.com>
Message-ID: <aEtuTrybjLKiNctB@google.com>
Subject: Re: [PATCH v7 02/10] x86/fred: Pass event data to the NMI entry point
 from KVM
From: Sean Christopherson <seanjc@google.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Tony Luck <tony.luck@intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Andi Kleen <ak@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-edac@vger.kernel.org, kvm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 12, 2025, Sohil Mehta wrote:
> Extend the FRED NMI entry point from KVM to take an extra argument to
> allow KVM to invoke the FRED event dispatch framework with event data.
> 
> This API is used to pass the NMI-source bitmap for NMI-induced VM exits.
> Read the VMCS exit qualification field to get the NMI-source information
> and store it as event data precisely in the format expected by the FRED
> event framework.
> 
> Read the VMCS exit qualification unconditionally since almost all
> upcoming CPUs are expected to enable FRED and NMI-source together. In
> the rare case that NMI-source isn't enabled, the extra VMREAD would be
> harmless since the exit qualification is expected to be zero.

Nit, instead of "is expected to be zero", something like this 

  harmless since the exit qualification is architecturally guaranteed to be
  zero on CPUs that don't support NMI-source reporting.  Per the SDM's
  "Exit qualification" subsection of "Basic VM-Exit Information":

      For all other VM exits, this field is cleared.
--

to make it very explicit that reading the exit qualification on older CPUs is 100%
safe, e.g. even on non-FRED CPUs (see https://lore.kernel.org/all/aBUiwLV4ZY2HdRbz@google.com).

> Suggested-by: Sean Christopherson <seanjc@google.com>
> Originally-by: Zeng Guang <guang.zeng@intel.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
