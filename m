Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C53B30216D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311922; cv=pass; b=CreFk2C35EPZg66KN7zJ/SL97EGCTSIW5At3dXWhd4iKmLsMu8DJ9e9NkOJ7k5kk6Kl4C/q/37GbOhvTdBQzt9H0ZuGbvuyb9gT4lK7fX7n1ZLvXad9FYdo944TFhlMaEiHMZCc0moTURT1cXinRILQlGS2Hs/uuSC0+/67Y7uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311922; c=relaxed/simple;
	bh=+a1qMWWmOM6Y8/o1eN1lz2qoObcQIVgbkHxFmUvd4Kc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiD/9Llv4ePg+5AHwwtaU8DLTSuogMH2qpl+9nLmGWWJEZBHa6muHHXTMvmjIJCwLilNHLm0C8nDiShfZ+SYtzbutKAoWn+WEA/eUGPMTRijpH6Wepc7CJkiTjOpLzZHQK1UpBn9Ns8CPUhAmjnIswyjYbm0CmHKLPstsfKI7oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mNSNe9wb; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNSNe9wb"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137335bc3caso1833266c88.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 07:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782311920; cv=none;
        d=google.com; s=arc-20240605;
        b=gFZ9E0kJezL6/acohH5GzMV3e8/v5A14JZgmvvG3r7hO55W0TT5IFhDJaD13qRkN7F
         vxMxgpAXz9adY1yMpbedbZemCy6BEJW1jNKS+M368BdNbbK56qHhbxDWuuDsEW4/19yG
         zTadX135Vlydb060jp5ZMKDALAkdAPUOQhZp3qUKtKJPsOfJr6QbDkrq3shjkk8OYyGH
         YHFcXWnWgwlL4Bkeua/bDUXobDCsdgZYgkfL3Pbm2QAOXE3JVvI9psS4x9fZv74Y1sG1
         qyikuQQMJLbq4NfJNj1uQTgfcN4nDtaTd+YXvN+rFRD2SOH4uWAmGJmYQcGqenKgJ7Rt
         jRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=HpVAzGtumZJ9rywOtX3ITBDfHQ1Vjgs3+apnvgsrs7k=;
        fh=D6B+iXdVWnoT41scxPudUx64c5XsciOHwgCkGNG5luM=;
        b=RbF3WrlnldUFQrHFUxYk9d45AnFIw8yO6t2HQ533FyEwHm5jd95moKn9Haqble4bCE
         T9BabUPhvTPCt5hNgy6xkGH+ry7tOFOfgs7bVhlHGZY+Mnq5kzWkNcmPUNePa34EI/sn
         7KTeH7itMwENiP8e7opTAb2a5nztL2L+sZN2pFNKj0kNKVwJPH+rlUSavmFVIvljZt2M
         x8qHQjT7XwwtixmUVke2/5yuyiPjRoUMXCXmKC63eS+2E1w0YWZi+cz685y/HYuw3Wrl
         +w1rTVgjByGTy+CIwOZ2GiSOaI18EwtJye7QRSsr/Q4/z6SHzHmf3iImslSpgk64N3HI
         AZhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782311920; x=1782916720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HpVAzGtumZJ9rywOtX3ITBDfHQ1Vjgs3+apnvgsrs7k=;
        b=mNSNe9wbTP9Ngof4VtQoFcV2uv52SUPaZgY+Tbi660cx+xZqhgJ2b3iYt44xjlEr6I
         ELCjjQ9gLffplXOTXMTE3aF0bPXSlYL7CEDv/m8Y61oFNVZwQPaSVRLm9AqiUWupNXz9
         IlLVsV72n9CO/cCbMEXwfXIzvGB7GvrX/TAQHIGJiBfQ4PUfK9rT4oDvczZ9ytL4FU0u
         OidJ8kWId23VDBoEkkY6a6NZZJ2SKgenW7G4SsyXAhUq9Zi2A+OJoDsFdVZDw2Pv5lr/
         pl3c+NsUeE8KQ0GZFGCbtsNJItUDelIt2UCx2XniStgj4PvZGXLbswTlT90kbvWoN4y4
         pdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311920; x=1782916720;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpVAzGtumZJ9rywOtX3ITBDfHQ1Vjgs3+apnvgsrs7k=;
        b=KtXZ7bBGuw9LoCnfh5wZloEgrHGC0OLNc3OCAAypddekKwyKfevGxmu/QBSCwmf8qa
         UxCMVpo2MJoxuw46dTxMEYdKeLVb06i/VcQs2PoiM0pv7ncFz4VbEqvvn1Kyz2ez7x/x
         AS5B0ukNaSjaxHIHJyDYBuMSd35ZAKEsD6iGlltuWTe+G/jTCdryoJFrn1hnZSLIR73a
         30hFMPBLZ4LDxYdPTL+kD8bpZU2yBz+cfdYorxIU8mG2qaRmM2uZD5RXhpY/zbYnSLt/
         QLrxn2mWBmWhEDDjSNQDTYk0muOZes7IhCTW+SEbntWG2OeDeIzy8xSNVx8MQDX5j/Oy
         tx+g==
X-Forwarded-Encrypted: i=1; AFNElJ+XeABtDAuSn45ZpwFrhm+3RmJX+GM6KUzQvzxHJfi60fOO29jGO6ZSEG8XceybGXbaKPbXgoXIRZDDEguSfR7E3YI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5eE7qKLybRTomRz/t8SJ9Evkvn/hEG3kdBPNuWhXyp42lpNlS
	3+UgbDgihHSKPVh5CJnzmTyRjh0nW6eNySutuZhfBcHlGlAgSuUsvPumlPqNc67fsabddNSWtKZ
	LVtlUcxyfDuGyxST162HhPOLF0sVjmMnIUl4/VVWW
X-Gm-Gg: AfdE7cmdh9yDy8EmXYN95Y3oregQZsi/Nkoh3BK4rMVghtTUPIIhLSTp2dzZuI7jlI1
	uE0MQtY0mXHpU7kibs6+dqK8mpCnTgljLShdLn9ezKiBSzjX5HILIwCzNcCKxPpZ5sez23nZxcR
	KLaaJoRlbXtRi8QCL5X8BkUdzQwgefL8+eZvvgbZU2PkwdOAVqFn6+wU7IM4nx7CxXj2Q+lED4m
	nr6qFofeu/4dMFh+EJ62LNmrcQUv/uliEhP2k0QHcjrCLiEJ/Hg/4o32yhxg5DUY8MjGe7mQ2nk
	vIlEB35iVAVltgI6gXBmcfYUtO3i
X-Received: by 2002:a05:7022:6612:b0:133:3bb1:8d40 with SMTP id
 a92af1059eb24-139d0c24496mr2539007c88.15.1782311919284; Wed, 24 Jun 2026
 07:38:39 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 07:38:38 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 07:38:38 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <1b59fec2-a464-4429-8532-880394912af5@linux.intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-9-9d2959357853@google.com> <1b59fec2-a464-4429-8532-880394912af5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 07:38:38 -0700
X-Gm-Features: AVVi8CeozOwjsDHz095RESzI1L73Y_-_c-08wJAGuPOXvsS0FIpnjscm-5zrczA
Message-ID: <CAEvNRgG-WDzHp-15Mig4hiU5Dag0pFCu70-R-9b=PkD69W=ZMg@mail.gmail.com>
Subject: Re: [PATCH v8 09/46] KVM: guest_memfd: Introduce function to check
 GFN private/shared status
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
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

Binbin Wu <binbin.wu@linux.intel.com> writes:

>
> [...snip...]
>
>> +bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn)
>> +{
>> +	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
>> +	struct inode *inode;
>> +
>> +	/*
>> +	 * If this gfn has no associated memslot, there's no chance of the gfn
>> +	 * being backed by private memory, since guest_memfd must be used for
>> +	 * private memory,
>
> "guest_memfd must be used for private memory" is a bit confusing to me.
>

Hmm good point. Is the source of confusion that guest_memfd can be used
for both shared and private memory?

Perhaps this can be rephrased as:

guest_memfd is the only provider of private memory and guest_memfd must
be used with a memslot, hence if there's no associated memslot, there's
no chance of this gfn being private.

>> and guest_memfd must be associated with some memslot.
>> +	 */
>> +	if (!slot)
>> +		return 0;
>> +
>>
>> [...snip...]
>>
