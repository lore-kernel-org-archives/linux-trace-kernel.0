Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD782757EA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346774; cv=pass; b=FYKnCNxac5rEe2HgGU2m9cQLSZZaCNpZxuAhvu/QD8czlQIybWLG1SWXQmcrnQc6/keb3rWAFUwRCkLHKZGiHf0p1HxGXP5/tfnHp8dBn/YJFVIG3VieAr3qUe+GIkFtn2KTBr7sOIGzv+kkXAnMFInZuGLwByuqE3N8usV2vJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346774; c=relaxed/simple;
	bh=dsN6vnyaJBkYRNoTR8AKQC63zHcXTfT03kDeM9s3ZGs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L32lPJCOecamtofPQmL38aOzoXaQhTkhewV31vKahL1QK2nYhv44IrfMDmMlzmYGQtAwilRVZqB3X4xKJ3kfk8dtCFQjsZGgVmdIPC8pcLcLEmkrlwZpdEO3oKbbnLcH5bSp1NW/4HJ4kHl7dFVzLtP2vj08ap+2qwPsVU9xbMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l6O4rAJ7; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l6O4rAJ7"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1397e093f90so4604812c88.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 17:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782346772; cv=none;
        d=google.com; s=arc-20260327;
        b=rkK7946Q92QM9xh/8NZohmq3W2KLlt57y9Ua3Y3Hi/0YcgotHcx7tVdJdnh2VYDPdR
         bxybQSCGl/jZweWZuEERGyylmBtEuWpccQYPB4VdBkZwgu/iuIVg1W2Cyp/4YqmuTpjG
         QyIgZSr0/hPMI2S+SBROFd3YNEs2wh9YrxgTpXXXYChvsjFHYTwYQ0tT3xRto8ywVOjE
         hUf5KSmhogPJy9t+l0lOtQEeUZjMaslbB/EEkxG+i0f4NsQ7HRu7L5UgQcztSrb9ABUu
         NO842Bh8/Uz/32M1bT8MJiMZtkh+Badv9DW2F904p/q/7AU7s1gVJ6k8Px/Pbe+nT9L+
         eBPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=dsN6vnyaJBkYRNoTR8AKQC63zHcXTfT03kDeM9s3ZGs=;
        fh=udb3nHMR+N1y+PIITgtwie2JhNh2NVEDzqD8Ero0W8I=;
        b=fJlf3UBUn6GRGshrkTgXVFvwkA9RauhuGJ8qKd+g3mKQYU2SPyE2v2lquJ0ZuvsPmH
         a+pNDP/y9SfGMEMtwD0Bx54+uF2/t6pvDBejNJWstJ5Y5aU4nseHeTX1UMN6FK1lRGc3
         xurytnrmR6fgDLDESCcWeDo5xH4Wg647BL14Sel5GpbyJNkSc5X4IOCiq+D403CrBz86
         3leVS0eAK3ukN9HwuId1UBu997FQT5Ss0zhizox5XMG2PvwiGjpvjSDnxsXl5Rubu/yD
         +Ig8G68FiWF67l2DFXZlJ0fjv4/2u7tfN/uwLT0OV2GkRIbHup61P6fvOVCtKoTIKKu7
         fTdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782346772; x=1782951572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dsN6vnyaJBkYRNoTR8AKQC63zHcXTfT03kDeM9s3ZGs=;
        b=l6O4rAJ7BuSElLvSVCjIBLBDcAro2phzO2UoQrwN6+H320mWttnof0i0/lcdgnC9VF
         c9y5WMcG61fE+olfR6gSw8h/vck5HyRGv9OPpvaKvk4dYSiidvvra5Rw9W4ei3WZz5cG
         UDcca5AyuQDRs00QKgdFarXvgscmMWiwFpV2z3nzvCLhch/PKdQuVbStjrT36He7sJ9P
         GhEfxTfvYFKtGxEsKC5xmX7Uv8xQVPMpOur4cPG36WuKyLxOA+L0ckKRLWa8UjYesS6B
         aVZHb21d4C76/LlYbQQRhBVZFjX4vQ965Jjr84Kc0tAN2qbTazomJ5RHU9u9L8RNh6sT
         pxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782346772; x=1782951572;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsN6vnyaJBkYRNoTR8AKQC63zHcXTfT03kDeM9s3ZGs=;
        b=UW2yW/onLzhCksDahmPG4qj0gudCiHCeULhMlSQUauKiJKWnzrYIEAc0sV/Ba3dPDa
         aNSbDhOx8gobIT3axKUrNN+QaT5APEzdQ5FGgrFVeswfGS1LYP2UoY3KwtjtM3pHq6Td
         9/P3ER43XtOgMNiLorymBQ5c5lEs329r7moazeAuHN5PBG69NenUJtme1qjfcFIB24uB
         4Iu+AHXUz9m0z3uMxXYP/qfQU1tIGS156Jk5KUcr6lQgqTUSqsEk7/QWTH2s7qwwLXWJ
         rln3VVcNWsJ+jTvUnF/pKndsBBv4b6UVIivbxE/77qCfDUE6S+KYlusMsarZrOFevaFq
         fsKg==
X-Forwarded-Encrypted: i=1; AFNElJ/u0WmhZ0OfCIdRQQbW+aB6ks66RKVQwnEDtxnUV+ygCyLPOFAHK3iE2bAVNw8O5ZrhkfYqvRM0R7BaBOCjPHPrQjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf3QaBZCBuhIt2Ja9KsWBGCrfZzpuKK7AMU5QYUx5iyAN8gL99
	w9rRGQ6rOXD3VLZfUe2xlPAKwFdWWI57i6fFBPu+ZHJJe92ndS4Bdl4J1qbxc89+RRBdoVm7La9
	N9Ovz0ULRiPP7KFGKbiuKvtuEHvZfJJfiIMDx6kXb
X-Gm-Gg: AfdE7clIO1NBZKUZivMiQtub0XGVFHn70kCeaTa8BWrCeJhW7WV9MeYdpi8lwuU9J2d
	Cr16HR1dsLYxeathXSS8m39qE/32cTIanZMIBaQRhJ0Dmtj+Cs8ckSF0gLKe8PKrL+5tqEeoM0F
	vHX6G1AkOlT+ju+mrdglZX58J4BoDXFmjOZUXq5kghqHXKQ3dcsRoDemCjXTrPoz09sTXBcrgY8
	PLDkJ5nnJfrnOamlJBMd0jQtV0PFjD1reukr3lXz5Q6MizJBsze1UJxe70nVNVyfElhXhh67Te1
	YKWp2YBijAdgeGJ69LY+ClcLhfmSP0x5kWaR0NKsZEk/U6GEOJMyEW6B35Y=
X-Received: by 2002:a05:7022:fd05:b0:12a:b39a:339f with SMTP id
 a92af1059eb24-139dbab1be2mr235748c88.21.1782346771178; Wed, 24 Jun 2026
 17:19:31 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 17:19:29 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 17:19:29 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <a6373206-60b6-454c-9aa9-9d52f9d84de3@amd.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <a6373206-60b6-454c-9aa9-9d52f9d84de3@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 17:19:29 -0700
X-Gm-Features: AVVi8CeipeAcfAxYa6j2yQPCcdB9pyHrAKYmhFznoyz3FS_QiklRPL3N5ubFoHk
Message-ID: <CAEvNRgFUru5GEM7g6Z7nuaqQK2iFmW3w2dPYEKPuehkdGvP2yg@mail.gmail.com>
Subject: Re: [PATCH v8 00/46] guest_memfd: In-place conversion support
To: "Garg, Shivank" <shivankg@amd.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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

"Garg, Shivank" <shivankg@amd.com> writes:

>
> [...snip...]
>
>
> Hi,
>
> Thanks for this series.
>
> [...snip...]
>
>
> Tested-by: Shivank Garg <shivankg@amd.com>

Thanks for testing!

>
> Best regards,
> Shivank
