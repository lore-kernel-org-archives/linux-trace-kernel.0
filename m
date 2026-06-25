Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC51FBEA8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346791; cv=pass; b=fKDrUZ3RZfof7RE1kOacZIABUIubjdUF42acRrfEjtYdSR5dvP33JBGXplR0aIBiDRHWjIKY4DQs687NtoyFkS0QmXe22su+OiJpYTnFeTPVileka8WWcc1E5jPC4SLZnwqI6YiX4ljsx+afqB0vNUKn0Mh+0wl2ZbJc1IBNuLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346791; c=relaxed/simple;
	bh=rLzvOJxIQU3Ts0wS9KKJCuJPkhIJBlsf6U32nXubaQQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcldMCHh4Oub++B8+ez9NUjZtknknJjupH9jshEPFxci724UZ0vLXG4tVpRo7uwa8pAU5+zbloSgIyHbbJll2jco9BaZTWiQ9KyhvscEBy6rpE1CiiuFTTFZ6szHQzva6S7MyAJin8Ec8F8Ty+svp/W+gNlrT+5VSWdnWMHR3NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d6SJ8T8b; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d6SJ8T8b"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-139b914bab6so1871120c88.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 17:19:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782346790; cv=none;
        d=google.com; s=arc-20260327;
        b=KFLQhA9lSbP2/FEDOGZDCRFLJQVF120lfu+ENYciqurhzGQPBtAqcgvf4xW0SwU1aY
         Jk2hvTjTO7lg7vDl1FAGDPj2507i7PfWnCmxx1NuZVQEaQrrMPFfGeKnqnu5hqUkiZen
         vqoxYy5kHhjw1qyS82iITIFE40ULHlOqMyupaapCVwfuwFtoWCtkD45ZKJH/RD0HQfvR
         4Q1ObsS+fc9UVuAVkj7kNSEVVgOCJNHXZBqNfwX9YIqWkdtLeVKrF4KERArctZWgZY9k
         WBjiZunlILUED3zzQdmtHRiKYeQRefIKhXb6E1qKLYScOka9MxKPkt1PQaDF6JZkkGAi
         GdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=CdGA3bllvZfq9+oq5ATtnUq0c6NavELb8bI7ZCuFA30=;
        fh=xT9+c/hs45eUEmYqxK7jM/N46w8G7kft/TM8CsxDH4c=;
        b=lJwmZC2uXf4Bs2lYHQvzGuFV1Dqeemr4Xf/HKXBq6JlDb7i+DyVEFaebFTtaypf8gR
         ZhHr8vYD09xmFg2YLb3DeuH3wZVv5TOW++q+G0sTKrcl7guIi+4O9aQgXX7M6cvkqG2l
         BEG6EbLR/u+TnJO42Npb4tFBBtEGuw8UW1FLm7ipZbGi3MORRhidpkNNK3w0XxYZnjAB
         ozXyJpNGGmgtCVcfYiGSNzF2gYObCWzlxgkLtjFyfmggtV+v5tV4NNOiwulvcv4Gqd0c
         gOrhlxTbdN0pTgjBLHEwXmi9yMpMrcMGFpCm+W16uU1cvpZ59RtKgfVRjCjSbB372lli
         +74A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782346790; x=1782951590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CdGA3bllvZfq9+oq5ATtnUq0c6NavELb8bI7ZCuFA30=;
        b=d6SJ8T8bFXONBDv8sWkZAq4UxMY1A+sKJAuHT6rEAa7dMvyVDEJrMh1ltaIaSfuquJ
         edvG+HIKuITzIffmOLmoKSQLPZ/dt54ReDIf3J2wnsRdhVmFvN9X5RQdKHO3Hjrz3o2L
         fpjxSMr3L8Ohxdl75FruWF6/Ned4s9TUgu1wtKXLR0M6y1ZjRFiAvapds5FbrNstpsZq
         c7r0yPZqNWvF9p1/Ps+v4YJby45kyjrQpZNQ4yJ6vDfcLnF1EkmBQRaia3NGo1HqfLIV
         h/9MjPaFQ88X58vnGtO91tzkrlUTPflsbxRF27DR7/Fj6XdjYStQIF4j7f7WMalRPUIJ
         NC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782346790; x=1782951590;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdGA3bllvZfq9+oq5ATtnUq0c6NavELb8bI7ZCuFA30=;
        b=Q9gwq79bUacs4nnQTFysQ+NO+GCiXKCpjeLAkBJABrG2Q4SZ2MekVM1ZHERYIu4s4P
         Zh07qkRkKkE//KJKFkUl2OtFg1qnnXX+XA0OCh2dIXSwl7x0QBHFjfXLKjtr6r+qInpr
         p0+ct/0N5zHbPiAPFRXkqVVpCNyCgqix7Ry3Off+5DlP8aNDPOt7cMW3DYkKXl8ua4Gg
         7wlR7YRlPkKbL12zUUuuQqZsTz6wt1haHhP2nzEIKG/yjL7DnBvhcrx3eqNAO/71Lllo
         u8jXou2A3T/nMu1dZM166Hw6W8+1G74Aq5goJEjDmEz7V8dkSNDUi7Mk3CCpAEb7vvB3
         yilw==
X-Forwarded-Encrypted: i=1; AFNElJ8o1zJjkCsnwAk/kHiZMXR7a7FcrwAhR2yVaLcW0UwXOBPnE0XaQoK+5xtPqh7peJw9eGBk0fR12OK68/eroS+MXM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkMlXOXbZQdf3J3SlqlR2OZ66G61lvS87NPZMomvU2SRpB8n3l
	n/jnG/f0V1+qWf1UZqrzIrsfqu4XN/xxH9UkzkTHmHWxHJeKcPtSvJJFVN1ZTZe+2JMbV97X+hM
	qxTnLp5Ttyt1SiMLk3T8Q2FuCij1yySs9X3eGrBMo
X-Gm-Gg: AfdE7cnbJq2aT99OmY156aIwrIgHEa7ATaOsAy7Nm1rjv6222L8yLqeQJbp2nQM3vXx
	iZCx0ABplR2H3e2u9RTv34eHjit2AlXfLrSGIYZNwLYxGLi5rksOJ3dH8n6/p9cMj1FrKJ/2oHE
	31KoJUs+twEmFejMFrjb/AiCC+P62iqaVsUwv6PFOrUBUQ3ghOXdQdmaySHoSsgCUoMcPtj89mL
	ke0+elgLaEmj5N678ZqkdGFjNVPlYSWtCukE7MDuIaVLIPOftatRkJXFJW1oiWpy0v+tZ40xOkp
	aQwTalfDVZTrefkLdozA38WxF71Ov1Q+7clu55d8IPpmnxh7WEWtuEMyYkw=
X-Received: by 2002:a05:7022:611:b0:137:f001:fce2 with SMTP id
 a92af1059eb24-139dbbc564bmr255822c88.33.1782346789006; Wed, 24 Jun 2026
 17:19:49 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 17:19:48 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 17:19:48 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <9f81ea12-98c4-4ce6-a95e-233851dfe8dd@intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <9f81ea12-98c4-4ce6-a95e-233851dfe8dd@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 17:19:48 -0700
X-Gm-Features: AVVi8CeR8FAzeQAvNnM15yag_GxBRrpO8H44tlQVk9R637S1b27Bxjsp2TDXvkw
Message-ID: <CAEvNRgHR-6X72fvx-4s+RrsMHohSCBu53bVX4G3x-=XGLnOxiw@mail.gmail.com>
Subject: Re: [PATCH v8 00/46] guest_memfd: In-place conversion support
To: Xiaoyao Li <xiaoyao.li@intel.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
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
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>> TODOs
>>
>> + Retest with TDX selftests. v7 was tested with TDX [12], but the setup there was
>>    wrong. Conversions were successful (no errors), but the shared memory being
>>    tested is actually in a completely different host physical page.
>
> Glad to see you knew it already (I was going to report this to the
> original POC TDX patch)

Thanks for reviewing!
