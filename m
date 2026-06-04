Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C7372069
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780599943; cv=pass; b=mcVGoLpXNvyls/ZKFzGtZ9+OX60ZfjFzBfl5Q074RNBaZwVsJKjfhOLZHFRv5ZQBbNn9ViZlL+xPDh5ZR15j6mZeha9rfwA6i2ZqhHfCpWdvyDjbii6BeaLahQ86RrGWQPm+3qYsXN8HnhLMBTP/9Zts8pJS6d8HdCSB1y7qFEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780599943; c=relaxed/simple;
	bh=fPhPRTQvhTqz157LTAZ7B67TGOApX5jgr9r/KxX7Klk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQMdSAuAJKcSZxmHMgY2w9RoVsq4iuaKYck/7kFOfAY5A8d47vB3Md45k/+dW8hERwhriAF4VIur6cJw9OiKVA8jCZD/3/Qs66r80PrT257g33gBMvF2cUbWGovSRg2C8yLtAIxzORAr+ReIoDpDCVma2yiOPQk7jT9gubGujtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hy1H0EXl; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hy1H0EXl"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-137f18f45dbso954022c88.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Jun 2026 12:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780599941; cv=none;
        d=google.com; s=arc-20240605;
        b=hfW1HSXMrD9xzFyghvCr+vKe3Q90BDWRGaH2T9OgZm2kDQSpZd0TRjyuIGZYnL48Tk
         FCHTn+xNt++b2tU+Pt9hY59Stu7D6MAhsFOmBgWtP/0nQovRjcsi09siimdjGMWKjcFd
         evq7P54kBsn4tF0KoH7llQnm46ogjGOW/buSXhmF+8jZo0ChIMii2XmKPLPUa5xvL4AM
         82TqpImNw/byrml1WXW7V7qrEcmDfavDgH7wDqnuQEUIj2V/wt7MF/Kdf/p6dn9gH0xv
         HDfPmo+uWzLF50LVIUx0cPUEehb+NkbyGQJmLIqZe+WuMyiOs+B4TZu/lTbetXYMBzpU
         1k7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=fPhPRTQvhTqz157LTAZ7B67TGOApX5jgr9r/KxX7Klk=;
        fh=v78PDdAzB4+lMOz62Z1cPUFwc8TbkqemkUTYp4R1Xwo=;
        b=CGhUJNyk5n/dgnToV/fneU8c3GLjq6XdlBE9/Kap5xL4M7rNBPzd65J4dmPdYXeYtI
         C61C6IeWSdsPOQ2gEZ9u9J5werDdxFeexmrwCW8PUihqjAuFoP6mnOmiW75Amcxu4obc
         4dStChItknX9zVZ4ocNRG+rfu6ifeWMDpgiqLUXpZOBNs/0Yyb03TQ++fBvnux4Gw6T2
         47CuJ82608uokJctwmwAF0RT7rR90jyM1yjpzW7K/eVtQqfbK4PJt+Oan2/8dZ3fdZ36
         zJMHjdzbBljzv3MalQGG3m2UNukseL2fg7xTnUfJGYNpv0DHPkF1KUMpZzKY8tb/M4e7
         EJsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780599941; x=1781204741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fPhPRTQvhTqz157LTAZ7B67TGOApX5jgr9r/KxX7Klk=;
        b=Hy1H0EXlnaObJ+zPhxLtsx2B8hXbpEIIxEgfw2HrrVf3MjC/6/kaxnPX0yug8T5tCg
         CxiUVTVYs+ycfk6vAqOsXEDitS4efL+GEGW4Fmlntz8i6GLCFNYGNad67qOMRl47zUPZ
         cXphrgkqUaTkbNqNBcRb6W+eM/RkA+yR4l2qkuu35iyD33qwhM13bU7Cg/9a1PP8TrHv
         HsXsw7bF6rwzlyEGj0tmfhT3dbrTH16HQEVH6OHFPw71eOhOnm1KzAXpRdLXT96ZQDuL
         cjGFxigwWu6m29r9NNGo4eU7OGZ0vsi68TgcnBbbaSJh13XeXoSiYt7PfiyT73yW0exk
         pCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780599941; x=1781204741;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPhPRTQvhTqz157LTAZ7B67TGOApX5jgr9r/KxX7Klk=;
        b=qZM3+5ntv168ij/v8pp0xCWM0GoG5qlHXYE+3djUCAubDA/tfAxb7tQSZf8Ic0cuhH
         Lum29jR6NKEmPIyVbqE+Ii/7LhbfddA0xR8O7z+O3VUmYtoDZTDQlRMFleGqmCgi/tqQ
         KM3BdqRva1OTM2Eat59d+REnIfDtuQmi9YPFrOvMxvvMA+qiF8dKnNFNl+DV+0HD+p2q
         vDHH5/BLbv/KblCAplD2HxY0Z4eCza1GMogw4q67rlsnUhhdB+j94D9AbA17jqzVzb7i
         ZbGPLM98CZlHjOUBJlNiuUyJixmulh1GdS2koq3fmSrzxYXCz67bmqW9TNzRE/0DMuIf
         3KbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/nLK/HHgBjWQou/1PicbhXOKCq46Z/+Tnl1++Y1rbD4X1FkuNzzXs4p8FHTWTJj6UI8QfYGSyVssI1rOQXxzx7sjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOW897mftEFnU6ewxaOVTohIFxrpn59sF2U6jHivaluiyhnwYD
	FaP9Q5uiKd1OSHhmv+w/i7JR1B72hcHjTHD3GwkOq+OdpHR02SJM+M8S+LmaWUMPdw8CuKxXi/r
	quaJe9hC1KKgsSLgcurwQYVoAf0VnXMGnIiD7j12q
X-Gm-Gg: Acq92OHmBvJdaD3uIaLT4AQKPGON6BN2apIFjDXxWb4CWTcEqmRwAr0c3pPoAU10MzY
	FULe04QvZUDHg5lbb436jQW/utheNrzX9oeJkCXAJKaBi8TyKAevb+vjTDIl3Zey24ejv3vskmh
	lrBs83w/hsZFBNZtsa93bK1qOp13kibeLWoJja9ujSGr3hJ1PzXLM2MxbAMVyPEBeG3Yo5fRYZR
	USRNHG5ZnevMUJcu3D1khCGLLx4Nf2VOkweIbgM/0MnyHvI/X5/ShdcRKwxBpvxezoz2tqtAhFl
	JvvdjuN8aBikwpKP7Q28jnpCViD+Z2dQubyyy0xumGQmH8uvGudhqiYPhGX9XK8n53x3iycyCc7
	qKPQqZqZ73oA+1w==
X-Received: by 2002:a05:7022:fd05:b0:137:64ad:a625 with SMTP id
 a92af1059eb24-1380676002emr151447c88.39.1780599940562; Thu, 04 Jun 2026
 12:05:40 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 12:05:39 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 12:05:39 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <9d15479e-e36b-4865-804c-7d93eb339e4e@arm.com>
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <20260522-gmem-inplace-conversion-v7-20-2f0fae496530@google.com> <9d15479e-e36b-4865-804c-7d93eb339e4e@arm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 4 Jun 2026 12:05:39 -0700
X-Gm-Features: AVHnY4IdCk0L71RC2xDPMs_Z7be_JnLSsAktCF5S5h3trmfsblKVtct2b38am_0
Message-ID: <CAEvNRgF43RBv77RgM67kXRRHDnQw4L5uwQTuvkJHzkHJWB1mag@mail.gmail.com>
Subject: Re: [PATCH v7 20/42] KVM: SEV: Make 'uaddr' parameter optional for KVM_SEV_SNP_LAUNCH_UPDATE
To: Suzuki K Poulose <suzuki.poulose@arm.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, ira.weiny@intel.com, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

>
> [...snip...]
>
>> +In the case where ``type`` is KVM_SEV_SNP_PAGE_TYPE_ZERO, ``uaddr`` will be
>> +ignored completely. Otherwise, ``uaddr`` is required if
>> +kvm.vm_memory_attributes=1 and optional if kvm.vm_memory_attributes=0, since
>> +in the latter case guest memory can be initialized directly from userspace
>> +prior to converting it to private and passing the GPA range on to this
>> +interface.
>
> Just to confirm, so the sev_gmem_prepare doesn't destroy the contents in
> the process of making it "private" ? i.e., the contents of a SNP shared
> page are preserved while transitioning to "SNP Private" (via RMP
> update).
>
> Suzuki
>

The following is the guest_memfd perspective, I didn't look at the SNP
spec:

Do you mean specifically for KVM_SEV_SNP_PAGE_TYPE_ZERO, or for any
type?

guest_memfd has no plans to do any special zeroing based on type.

guest_memfd decoupled zeroing from preparation a while ago (Michael had
some patches), so zeroing is supposed to be once during folio ownership
by guest_memfd, tracked by the uptodate flag, and preparation is tracked
outside of guest_memfd. So far only SNP does preparation.

>
>
>>
>> [...snip...]
>>
