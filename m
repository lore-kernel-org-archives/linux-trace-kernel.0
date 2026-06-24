Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A653B3BF4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340311; cv=pass; b=i1LOSEOnpOJ9H0lXuCqKbOWHNuVCbEwkeqecxrZsX+TQSAJhPR+R9QOCyNDFmo4S9BDbbsJ0cTlytO5fbO1sJLQNNv/ni2FoMw1M2XZMdRtOlPiAjYd4b/yR70rXGvGw2Mb6fRLcUoYjVIeDYkTYrLPPbdN8xpeUqwUdl2n4dSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340311; c=relaxed/simple;
	bh=Ac4SnsNXN8rEQTk23iatkBhfXxnOeNd/KNnr5r577/A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHGIU/eNfPqDLnoRvIzjjrjWg84BLAedr03wdjPBDE39oeCkgYl3JBBsV4gWqULiyUh/bpFby7iizYTMIUL0hXozy+UZZTKFiIhwnc2CnrhqHEiryajBbv8qMZUqebBcARFmw6csD55MBSlQIPMpDFMp/sxlV3jIgyEEZek5QMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kXObEAmO; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kXObEAmO"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-139aff562e1so2225297c88.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 15:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782340309; cv=none;
        d=google.com; s=arc-20240605;
        b=l3exXIG3sFmWPZwOHWJgrAHaRrWs3/irJ8nlrc0Kd6uimMb+i6GIDLwp1E+vDoe+Qi
         FX56QfPVQALGGCzkuQIdIIqIjfZvUVIU7dxH6WuRLdrUlvtcHGXLzRTdHbJZuJszMZmv
         pw78gJBEJsofJRKHr8L6XIA42qYxpq5lA8y2/M9AEwoFFTd1ubMQ9ms15CA9Isv4kWhX
         XNz2cgBF8iJo26wjNQJEGalefgl0bgfLhQDaub5o3joN812MAfZW2MnU1gkssQY+jqFk
         5aU6z/sFK+JvAkDqQTzHujYYobQrDwiMpWgTTw+jyJhgD0+0nAzazvHXDGLofY6uMoKj
         feOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=N6i/SOXitQvG69KsKOuqXfKe3MaqkPv8vgabs7K/yu4=;
        fh=tvvrKSEona0Yg3yGu4evgkj8nWkYANtWWQ1N4qPeAAc=;
        b=lGjfDCW4TMDIn4OHPdYIcpxoV9qaOd7r7Qg3qt9WJXlGs4+yO2j4meYUuDTZzl+iSJ
         Mi+nMs66NR3fC+A3KmS6RJ4DuAO4ZTUuxlr0T5FtARuwgPkmHJ328hdBOItLlTkkpZV2
         bWwHA7iO8mWs6TtRnW+4YYoHg5AFHeeIG4XV3VK2BsLJNc/T/Gk4QHQqVMdd8H9asKq+
         w0wlRtMuezMvlx5JeCIzY6yuIBhHyJu9T45nWy2shcGkCzPyVyAC57ekR18S7iW2wLCL
         WCFW3v9Ehkj8mELBFBNarHHzMf4s1ukQQ+zZ4BhagOwnmOQW+pbHJHB9yBToG9Jbo76i
         +Dow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782340309; x=1782945109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6i/SOXitQvG69KsKOuqXfKe3MaqkPv8vgabs7K/yu4=;
        b=kXObEAmOeWU3iGzGqynePW9vunurhr4tXDrm3kJ2Cz9dCW8c0pi4ePkiJhdBbB0r2h
         w2/+t/hVRBLgpq0dTtIQvLqCJTmnZ16KNtEGT3BG8nimWzD7EBPiMzIYkIrQ0jsf3cbH
         LqCrTgOTl+1z4VqvDpsuuODCr33rr3qU+phQFm5bVgbQMlqnrTmNVDjU7+JqzSw+vOMc
         ggWC08/3T+MlomMQSP2Eeb7JXdSZK2ox02iFGX6yqQanH03l9+ftp8gaFMwFSmIDKEaK
         ybqAQ3aBIj4bBlXeIN1nGnVP+fb4On6GNfk4+S9EYul2hXXeZBoE12ny+sl//VsX8LrI
         PiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782340309; x=1782945109;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6i/SOXitQvG69KsKOuqXfKe3MaqkPv8vgabs7K/yu4=;
        b=PTWTPQFn5aoHST4Ya/2JFmuzK+LuCL5i9V26zLmMQSmlJsF0aLvknrgFEKGqL4I8PV
         DwBuZIuRlev2l9paNPtFCZWS2WCC0JD5rYKCnf8m1Xh+brfy/1tpsGdSxTX/5mBConG6
         Iw2vUN7CgT9TmlWphsNpiSFu0olAHbgc2TPrFj4w2Zu9024YEk5M65eDUJJHUpfnFYQM
         OVRLwqu3Dr02l2r2vw05eD5bBUEH+UZLbGMk/Qp5MiRFlGbMIVdbCkSxj0c7ErsW+FGK
         ywqW/VdM+v8soNwWSmv+LOeyiVzakwntyE40WXXyjPQK+3WiJdxjYWPpMw3nS2f7xU3E
         u4XA==
X-Forwarded-Encrypted: i=1; AFNElJ9jPYhJJAGt3wSYK2dpG4ow7lRjLZFLA6Zvv3dhnNCZZ/kIqBpawgBR0AwBYT/K56SZxn5zT4G+xni4yImX6M248cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmsZVEApe7ao79v71128c75BNPQtiBdkgNNQ8uM2MCdI1+S7K/
	o0FQk7FdMJalsIer64L9EvU/1IFuo7uXp7JT+vfmpl0YAXPqn8W1dn24cPqDuLj+L5fvZ04plnP
	UOVbWaKQ1kJ7kdsVJnynNg2KvD322BsmR94OvI6Vp
X-Gm-Gg: AfdE7cl+Hyhgzkb1VQ7P7qoB5RU94+vQQmsZKZDfgNRUBbAKmM7M2vt6QpHvWBrIHjF
	P6DWZaWpkGiqYfTS7jwSxh29XyBJBj5QgVcenHx7J9Jsb6NnS8y1ADS5DchSua8LjF1dyvG9Abx
	nv7rNtzPjssljXRSF5RA+3Vi6ZuvINxQHv90LFr4nES/YF/ERgfp/m72TD6xtVi2m1Vx/nZJ60Q
	Eo9y5o5Ti5FVspaG/d4v6XsZZRmeB1mgUftDNliP9dhC3IT5nYQC/467p9wd4RUH0eVgo7Efoi/
	rvgvexpd9WFtDRLvWrbuPSEw/TcIqj5m1pUqX9uAHtbYcqppXjANkNHM2UL+Qt4YqzcHZw==
X-Received: by 2002:a05:7022:f687:b0:136:e639:9c05 with SMTP id
 a92af1059eb24-139d0c976b8mr3775881c88.31.1782340307804; Wed, 24 Jun 2026
 15:31:47 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 15:31:46 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 15:31:46 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CA+EHjTz3SW50EzxgXm8VysoaM21RReUVG2px_WUYU7zUwjXnpQ@mail.gmail.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-22-9d2959357853@google.com> <CA+EHjTz3SW50EzxgXm8VysoaM21RReUVG2px_WUYU7zUwjXnpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 15:31:46 -0700
X-Gm-Features: AVVi8CdGjNdamkK1obuu8yqfMxgZ_h-GaO78YorUefDXnXrkakD9WS-D2oU1DQk
Message-ID: <CAEvNRgGnSgYBwsgTh34uTTBvah12SE55LW=7Dm7RQX2U4sA7Jw@mail.gmail.com>
Subject: Re: [PATCH v8 22/46] KVM: SEV: Make 'uaddr' parameter optional for KVM_SEV_SNP_LAUNCH_UPDATE
To: Fuad Tabba <tabba@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fuad Tabba <tabba@google.com> writes:

>
> [...snip...]
>
>> diff --git a/Documentation/virt/kvm/x86/amd-memory-encryption.rst b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
>> index bd04a908a8dbd..29409297f1ef0 100644
>> --- a/Documentation/virt/kvm/x86/amd-memory-encryption.rst
>> +++ b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
>> @@ -503,7 +503,8 @@ secrets.
>>
>>  It is required that the GPA ranges initialized by this command have had the
>>  KVM_MEMORY_ATTRIBUTE_PRIVATE attribute set in advance. See the documentation
>> -for KVM_SET_MEMORY_ATTRIBUTES for more details on this aspect.
>> +for KVM_SET_MEMORY_ATTRIBUTES/KVM_SET_MEMORY_ATTRIBUTES2 for more details on
>> +this aspect.
>>
>>  Upon success, this command is not guaranteed to have processed the entire
>>  range requested. Instead, the ``gfn_start``, ``uaddr``, and ``len`` fields of
>> @@ -511,9 +512,13 @@ range requested. Instead, the ``gfn_start``, ``uaddr``, and ``len`` fields of
>>  remaining range that has yet to be processed. The caller should continue
>>  calling this command until those fields indicate the entire range has been
>>  processed, e.g. ``len`` is 0, ``gfn_start`` is equal to the last GFN in the
>> -range plus 1, and ``uaddr`` is the last byte of the userspace-provided source
>> -buffer address plus 1. In the case where ``type`` is KVM_SEV_SNP_PAGE_TYPE_ZERO,
>> -``uaddr`` will be ignored completely.
>> +range plus 1, and ``uaddr`` (if specified) is the last byte of the
>> +userspace-provided source buffer address plus 1.
>> +
>> +In the case where ``type`` is KVM_SEV_SNP_PAGE_TYPE_ZERO, ``uaddr`` will be
>> +ignored completely. For all other page types, ``uaddr`` is optional if in-place
>> +conversion is enable, i.e. when the destination can also be the source, and is
>
> Typo: "is enable" -> "is enabled".
>
> "when the destination can also be the source" is hard to parse without
> context. Maybe: "i.e. when the data has been written directly to
> guest_memfd while the range was in the shared state".
>
> Also, how does userspace discover whether in-place conversion is
> enabled? A cross-reference to KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES
> would help here.
>

Will fix in the next revision. Thanks!

> Cheers,
> /fuad
>
>>
>> [...snip...]
>>
