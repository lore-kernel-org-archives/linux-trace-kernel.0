Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF64388E43
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433173; cv=pass; b=DDbMq/ynadgnLV3RMY7iqDdjKIlXb2QUlbBf7MI7ej92GxVsSLhHaCnZ/fOb2uACfVh6YnNf/4MSlhWi85z9ZIrvc3hU3ChRf/caj9+B+F+//weKm7uk+eJGbsHr1ZFXFyCOSvTrIQlhOXcdFGFF65sNVMlKHL9C3dtnp1FexlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433173; c=relaxed/simple;
	bh=fn/J8d++vhy7/fERHcDXvB1WBDLFupuHbck0qB3MoMg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDTA/xAL64XN591TznDY30oORB6RCKtsYq53gPOOygXlzurivCA6uo4FsC0PLCkEC/2As/1LzCj3R6ZhGGstbfBMJWfaeOolJb6ltUAsamuBljBn6k4zEYEKwuafwwS5P0oBSU7WsTM8Rl2FKORNHz5dXpNli2sp5O/PcGkYJ9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J96zf1ao; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J96zf1ao"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-137335bc3caso10472984c88.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 13:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780433171; cv=none;
        d=google.com; s=arc-20240605;
        b=iTjbRhpFgCXj5yeVKVCUdjanohDW0Bk/sVxnPr5eAUXBx//0MseJ3XuG8Q+rlUnpBB
         c+MjTwlmME3fEgUjFTXDShByuFNJ5GaO1LJSqF/KCrUNnpDEmBkVsOPIXVD9QjzK5ntc
         qX/lA5mJz8nhkktop2t0yVXd1mBAtoWEGASyKpn1YQpmsXNAVSxAq5fNDF038VNAY8f1
         8XW0oowyTGVjEzThqGqsL86AhsQ7gqEHneZukcmvdv+cpdkH2rCcHR0ShGzab506NYox
         w4DIZptX3175veiE5BJlTHoZG1sA67l5HtcL0Pdp+rwFgwxEjXgq57QE6U1WRc7poT3a
         Y9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=fn/J8d++vhy7/fERHcDXvB1WBDLFupuHbck0qB3MoMg=;
        fh=Rao58eANhIrVxIIquqeODgM+vLlhn7yPUz9ZNXvLWiQ=;
        b=drXDUWD/SxvVj8ixnFWAWdpwQ7texicfnRe2WtVE6dDusQkGTwQ39pK4px2lWd0QRU
         JLhsEQLDF8hk3pJ6fr9veMPsAEBJbN7lNsu03Vz9jqttQUk9D8q9nJzlp/d+oFLU8tNT
         CC1FsGXgGIGDP+fx2BipaW2fHyuMSn8xPDQcWZAmUxLC9DSNHZL1x6/72f0gtislXJvY
         SGcK1fqZedc5t5VxdVicB+/lxwu0EYRn6YQhwg/1u3zQn7uOUPP2wEDaeCEwiSSWQwQz
         ZDEnhAJY4ziW4QNPHgBGqfSUxSUVgVQob5CocKZPMUR/uqkgqqmOxiZ6SA47G9j6lbvF
         9gDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780433171; x=1781037971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fn/J8d++vhy7/fERHcDXvB1WBDLFupuHbck0qB3MoMg=;
        b=J96zf1aoHutplBwfLO/64O+CNeopimd5AR+Qq0gZztktw3Mj53SEgF3ePR6KnN5fL/
         sT14QVXNxC3L6LNgESEqBwZDtkaGBb7kF6pM7YkYc2Y/BTQeaPbtxVTPz18MXW5ub2eE
         7zG5ouhBHW2QqdcMUkYkbEQwPc8XbnHCSWvKkVca2qP/pKyViikNglV6lUzyvwo3tplM
         gjPJHNesb0t6QQ9RRyldKevy+k+kNb9ww6yXVHHeHKvYETvJcd0r0RwxaBvhASDzI6NB
         l8U9CLVO/LL2PhRQsBZKy0D4tbyIAREFylXIkrW82+ajcNG/FCfQW3Vb2MEPN4QVXdMW
         /DkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433171; x=1781037971;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fn/J8d++vhy7/fERHcDXvB1WBDLFupuHbck0qB3MoMg=;
        b=XPcUrVuKh5oBTwUV3d5zofSLjmbPIiKulQNJA54pyUQGzt+DWo8Grxr/77JOGdp/rK
         OYBlbUBB382cz2K5Jx0EOW4dvwNssw0NN+No9CrtZ18lHJfW6r2TjsvDTcHRYzMXjw8d
         OWdcKKNDVAGdUpsXjCfkSPuOn3v74v199LgW7V05TkUknalC4FqmJw4ynWJIvqdG+psx
         O12K11MZ7RGL8RTZSeJeoTHFaCgHKqhKjxo6rGClSeMPLAsCB4gS7gewqYFeQTqCsol6
         6zjUc7HVwBU2FdOGRTSvn3sLe1O11E7Whc+1Id0hC5rchTFoNCe4GmE/irRBB2RHlHYY
         8FIg==
X-Forwarded-Encrypted: i=1; AFNElJ+ppIx57ZIfhvEKqtwkw2tZNL9SQK17TnVbuhPu0aWQAes8gW5oPuEVFNRpXFitHvIsRIQf8lG5s0m0PAPgCK/zTng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1pNaQqHZyDyOQ63uTzwC1E0pLe1CCcyplIkr125fs6aTRYkN
	mFtykpLmYceqGZC8L5gZ6uzs+cTFqQOmb03dlpQBWGZiHk/1kf7uekeHWQtAJs3YwIPM4Fh9M1d
	XRYblsDHrpRt3QcbhzVR9REOlyJwE0AKhTcsbpO7S
X-Gm-Gg: Acq92OFVPJIFmhPOGT+zaCwkAPk8mSWEpRgladFXs4XjsfzZJm/f5LiNdyD1zv5O50L
	XRf7ofAWG9FaZQqmBnw9750O44DW6ANDJK/q83dB0lJTtuex/BTaJxrNo19xriG4fPaVUr+VwLW
	iqpXmm/jSdr3YRDCapSMppJJDjnA4WHbU6JomzY8CUzRU7CuW0pldhZEYvzLtkkb5YI2IIUnkyw
	QrybUiR7u/IRDIvmitfvvK4Vp3lN9OlX15ugdtrEz1ap76I99GHl8bcwQZZZZlyoIZtFACl+8A3
	Y4qlWrBZkXkVQmIoJiu2RJWg5wXCEZ1qj6xBvXsFrNrTHNrmi52eoyQ+ef/vU342oVCXP4L7EFh
	EcJ9uayUCtHDd+Ek=
X-Received: by 2002:a05:7022:ec86:b0:128:d7a7:5271 with SMTP id
 a92af1059eb24-137f6bf3cd0mr110847c88.28.1780433170429; Tue, 02 Jun 2026
 13:46:10 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 13:46:09 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 13:46:09 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <d01cf1ec-b85d-4af6-9810-8107c0e2a4ec@arm.com>
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <20260522-gmem-inplace-conversion-v7-7-2f0fae496530@google.com> <d01cf1ec-b85d-4af6-9810-8107c0e2a4ec@arm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Jun 2026 13:46:09 -0700
X-Gm-Features: AVHnY4LuAokUCPsMDhhGv1NZjrPxAfRb9eFwDvC0vBskqE74-aUqfHm3K8vBqpY
Message-ID: <CAEvNRgGzOnA34WyOHtkOx5MZDZhOHaXAe+nD75AiJsZ-PsTSFQ@mail.gmail.com>
Subject: Re: [PATCH v7 07/42] KVM: guest_memfd: Only prepare folios for
 private pages
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

> On 23/05/2026 01:17, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> All-shared guest_memfd used to be only supported for non-CoCo VMs where
>> preparation doesn't apply. INIT_SHARED is about to be supported for
>> non-CoCo VMs in a later patch in this series.
>
> nit: s/non-CoCo/CoCo ?
>

Yes, thanks!

>>
>> In addition, KVM_SET_MEMORY_ATTRIBUTES2 is about to be supported in
>> guest_memfd in a later patch in this series.
>>
>> This means that the kvm fault handler may now call kvm_gmem_get_pfn() on a
>> shared folio for a CoCo VM where preparation applies.
>>
>> Add a check to make sure that preparation is only performed for private
>> folios.
>>
>> Preparation will be undone on freeing (see kvm_gmem_free_folio()) and on
>> conversion to shared.
>>
>> Signed-off-by: Michael Roth <michael.roth@amd.com>
>
> nit: Missing Co-Developed-by: ?
>

IIRC this should have been

Suggested-by: Michael Roth <michael.roth@amd.com>

IIRC Michael suggested this on one of the guest_memfd calls, Michael
please let me know if you remember otherwise!

>>
>> [...snip...]
>>
