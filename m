Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2939B379EF0
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 May 2026 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778275301; cv=pass; b=olVEh4UbKz6oF5tyDvuSW8TFhJjroO165dUO5tUq0bYLB6S9Hd0nYHZCaCJI75Mvz5oy6W3JE4iuthHmemG7znCizfK498GsIhXpj/CM69/qPABpt0ml9I/GAqvOjp/w84/GzhOAEiI4ZF9IhbxALZShUNjO47NhWD9uMTZSats=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778275301; c=relaxed/simple;
	bh=DwVpQtg2nQbOTA132JfDdSVfFAB6KCJ3Mceieu5x3bI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2YluDpAIz3UapcVWrYMahsCcuLAAjjMfSMrEuu8yrLdEiS8eFfMu/7DEcekdMxVoNDfciUzSrJ1WY4ofc/DKYcWkvTsWyLy5qlSt1QV0rumAWCs9ErRFLJIXzvPZ+z7F+rXnSMHL0/OVz7zD5O3FEGHL1D/X1nmUELRSLMSIzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBSIVYV+; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBSIVYV+"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-6314287380bso595143137.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 May 2026 14:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778275299; cv=none;
        d=google.com; s=arc-20240605;
        b=N5zUoQJEzj7zQYZ5BtDaK2vx/q8suHapis7aUSCV+2yTx5BsAClGDD65wN9v85w7T0
         bRtj8DToPZkfS1Mg9WaaIHRWlMSVzlZdWi97GVSOCwp3+fe/SgTNjl/Dx/znmbXDl3Lv
         jZtk0hcAay2lS8/hsswk2GBYV49phG2U5juOtOkGvXjqAAp4WVte8zoQaDCuSR9RWK+B
         OLgLBUHxYvBjo36r++T/eiQ2UmfhRlI/aGZD7G7rts/9dpJ+wcarvcoYUcu3nEuQIsxN
         c+IUCMa+wGZ3CbpnKd+Z5u1+KGqYee5F6OULI7pLr+7gknlPUARop/StkU+ZFtAf6MhF
         +WVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=DwVpQtg2nQbOTA132JfDdSVfFAB6KCJ3Mceieu5x3bI=;
        fh=vT7CrFTEcc15SCbVkji+21vhat5SMu9xaEarDy5RKc4=;
        b=inA+LdPha1vjVGTA91SY51Y4LSOuRGw8bYqqlMZ0kCY1TtLbdwzt6NafN4Okj4fTep
         GS9K2+xVyBtD5wjpsC8RUzGTG/VdQu2ECqxQiPiwYMYsx/czsRXoZWKsj7Rb4WVAAGqg
         4Wq7dId16eAoKGNBof7nIOwqSMpV1HA1tnIV4s93lfSM6Dsp6bmCLc9yLHQ4JwDSrE8i
         Jkd81x5swu4bfUpVNOcmdeDQ7C/annCyuirEVTC9T31hWONx1mHVi0rRd19dzfjgAzEK
         RbQUejJmmVaiftREOS4Btw0gy1ne+2OV4yujo4zcVmvqQA2Xx40TYxxmzvYuvt8wnVYr
         OPtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778275299; x=1778880099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DwVpQtg2nQbOTA132JfDdSVfFAB6KCJ3Mceieu5x3bI=;
        b=UBSIVYV+DWGpniUTgfToZNAWd5wYknlbdg+jHa8ib8fuBYefruu53HdoscKhtUpTfF
         +FIyWQKOigzjLNooN8kmf4/QhFvDUVDYc1DUcEwGtTp4qHY19snvIawBSOEjY9rjxDAW
         E3hergxglpxvyoFLcNuUevBTJBOMui9j01AzYJ291EqYmksQtJmn1/DabVkI+CKc0zCu
         Z4YpJuyo1aHi8DACkQxc9lzxhTI2w3n2lp2v8tpBUyXyKIdRR4r/MKldOCN8M50cUoMS
         4iWjyCjMuorgsaXskKpwTX/0DXt6udn4RiGrk6SX/h/fYRWj7lxKdYbiKdgQcX9bbXJT
         ZGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778275299; x=1778880099;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwVpQtg2nQbOTA132JfDdSVfFAB6KCJ3Mceieu5x3bI=;
        b=ry0Yhb25DRjSbpkME0k7lQrIODwfrg98sfW1D6YsK8BoEyvYgITdvJKKblouEU9aW9
         UEznx8aOe8KcYVCTuvwpwUfGEfj5ecwZVZ3PHd2glWHOa3cgI9ImV7QPh9kdjpfRoIAK
         kVnEjZM12hR/YZIWOQ5bHMiPKUw9Zct8STPCyfAPkrvzivQea52NmNCMUFogMqWKnnxl
         N21MDTE3DYQNFnELTXqDKl8lWpgsGPjS35qU6B24DduZ3LyhIAuCbuyg6DJbOgq4OwK9
         cwmrKyK+o2FLsvKMiedpKLUC6wA/u2KSnK3ArUfH5M2QYA7mXEa+l0OcRmcFhQyq2wnX
         6ouQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mCifwiJR60aafilMlhr7CS4vKWPE9WlF6FiN4FNgiMSNK3eBp9+t0GqG2W4gweZDm95RJPNI1nhn6gixGeAo2r7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV+nO0W4Z16MlGqJNBWObJqshuD7CXSTnk0Wxy2HunmTQF8jcA
	305++LdANpgD5SqoXa16/BZcvMcxaCJQvowttWuyny9jwYfaBaeEPx34tpfx19aLiujaWP/XOsA
	gQ5YUxdDmGi27z4bh9H3MDO+qIcohtbM2zCHXjOQU
X-Gm-Gg: Acq92OEzzuW9N8lyeeJgWZJ3Jq9qoS94GDOGbgUFObnktzjcn4QQfr0YWhxKqM5itLm
	2oTwMbWbWP4+nHzRqiA+CyeehmYiQhnB71SASQBRjueOYSso3+YSqo+hwIaPZXSyJMVfHhwsc/W
	FWOG4cAb+/JJftOWByIDz22sMEDM9kXhW7klzh3p+Gkb3wFoFbpzCvx0DoTSqp45cORtxxw3A2/
	LRAXf+Nny+p7T2+VTgK6GtP3kOANY8ziO0Gwv4YFTWMsYU2BPoR5TuvoZ+Fj2BlbfiJbXCevalp
	mxCEph6i2t3w2foUzoUsf4JLgkEiIhGoVAtIC4EznUw7neTbX/QxoTudVTR0LyxgVRQ5Kcrj+8t
	1K2oRxXQ7PL31Vn4=
X-Received: by 2002:a05:6102:2ac7:b0:631:8bae:f74d with SMTP id
 ada2fe7eead31-6318baf205amr901736137.28.1778275298534; Fri, 08 May 2026
 14:21:38 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 May 2026 14:21:37 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 May 2026 14:21:37 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <af4gJ6xZ3e7UXOuO@google.com>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com>
 <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
 <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
 <eiiecl7jvywvqb4drq7cchmcabcrdka25wxr77uavxqineeedm@rfcnhdz6xoxf>
 <3blpenhpvysb2ig7efegedx4v3flppl5ftnz6vhpqlatfk3ycn@vmmhs7mvjieg>
 <CAEvNRgGbMhkX310CkFY_M5x-zod=BDTiuznrZ0XvFPUK7weL1A@mail.gmail.com>
 <foi2zvv5qrfdcspnx4fstrvzl74m6xp6zrsw5omlbprxh4jrhx@vxnwk7fr46gu> <af4gJ6xZ3e7UXOuO@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 8 May 2026 14:21:37 -0700
X-Gm-Features: AVHnY4KoLAXwUd272WSq8KkXYOzbLX3Fym78BjF7-ccyQZ1fkjgts947Mu_AiDo
Message-ID: <CAEvNRgGOCUL-MzBmXZNZHYEiFdVmeL_K0itPrSRex2f+FazGGQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: Sean Christopherson <seanjc@google.com>, Michael Roth <michael.roth@amd.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
>
> Summarizing this week's PUCK call[*]:
>
> Scrap PRESERVE and ZERO, and simply rely on vendor specific semantics.
>
>
> [...snip...]
>

Thanks for the summary! Please see v6 here:

https://lore.kernel.org/all/20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com/T/
