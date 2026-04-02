Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905FE3EF658
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Apr 2026 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146833; cv=pass; b=uOw58i24fcOjFfxel6KNe3qjau/zX1y+ZTNa0KZ1doJ6Pb23j7FPiEBoYWJZRSTy/lQcw9OUpbLtK4QueLdXmkLoXZUn3+A5Dbp3osGmDHEVR+xY37Zu0w/S6dFFHNRnIamsDnV1EFi+tirh3G/6kR6lAnJ2ZDqIbReUiLriGlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146833; c=relaxed/simple;
	bh=j18XohxzMi25YcB7luu3u4i4Qqa/vIrjWdtPngyhd4w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nB0+nQ8Tp68ZR+O1JXVv09Yvqwa3QOeUqmz7t6a6TjlIR9cI2maNyUWYmHREkYI6w+neJjtHCeMTkGzN/jZ+RZt8yOBuWyTskyWtISVoRK+ZQM/WnuXTjCdP+oW9f5O1JHpzkU7Yc4yAXlv2fzftU7pxoTeYPLVQCL5VaMbLQ6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MUf//50h; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MUf//50h"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-604f834349cso378785137.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Apr 2026 09:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775146831; cv=none;
        d=google.com; s=arc-20240605;
        b=PWvenhX8LsXuWyoVZdsRGeai5Rb4HCboKnEue/t2P+V566j3g/g8x4aeIoHlqWFG8d
         o5EDDy8Qzoea/Uk6pB+VZ/9RGDh4eLPMgSZSXg/STcyApbmGLoJHwsEnyzO+BF3x58UG
         ZxSMjjwcjwyRahF0Ec0MKcI8ZjmIh8xMLHfRFgSvg8W/DHXwM/eb6KQeLdWkdvFWw+nQ
         Lfzj5ioKq1aw+qa6IogSBwWCmsoXwYRX5Mxrc/Hgkjiiy/+tOV2TkDATXlNbynmmVGbm
         tIbw3h50maHVRhMt9JmvBJDxzkgPA3oNn6P8mgYDITlSyNnQ5yY+QArbGbOlCx3HKXRR
         fRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=XABnzafTexu8r9STfdSEhkFwL2mOaywT8y1TwNRcZwM=;
        fh=MH29nKmWSTMHoGlj6qi1RH8kpOXDKqYLnIJus266h/U=;
        b=b+tKnSl04F89ZUlsZabkQdwSgDJeGzv8xDlNZIWWVcRWbYftjvK8ts0x81KOqpCBDy
         +9Gmt4W6rgBlEQnyyIFz+Nw2jPeeBbzYwmd1ky0+KejmoGnK/X9nWC5BRicGZ/86upsM
         45Eh+wILbvPfCVSm4qdlWnCwYvoXSfYHq4JsZDh0N+36vsHoqgeEaQEzm2fbQHh6cHUM
         HMQ0XcIa/GccBPR0eJUUt1tO09E6c+Kh1OyWn8vTUuJUhURytyxm3Ah8x9ShCIIIl8Xs
         rWEMbV8FQHIpbHsDGfTv8ksjoKb8bqAAJps1Du7lxr7Gm72BquV0hJzgFP6g1w5xNC42
         YEmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775146831; x=1775751631; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XABnzafTexu8r9STfdSEhkFwL2mOaywT8y1TwNRcZwM=;
        b=MUf//50hege10NWZS7vB28cKBNOTHzeZ88qsBTYxrg+1d6hord4uRba8qOtgYCQU0b
         4Ypj3TL3kPBFrvS46bEuoV+TF9i/ScpSyz8buRCn49iRsLFtENRgcgicAKONa1fHWtqZ
         3poH5y9iBmtZazGCNdcy5/Owh+xikXxAYO4OqbFV77Bl2jZuDYRGgLok6+hy4limIu0R
         FaJGoJIyAFI06vyuT0M5mgiBLvWbrN7lEEDJ7+hpyd8SLEluf0M5s7KeH7UkvnhuSYpZ
         mKjdimt359S9hYxLrKLaTqQq+hDurAcE82bzHV3YmQODxpRz6BkzBQIqoqIuKcSJVfFY
         ti1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775146831; x=1775751631;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XABnzafTexu8r9STfdSEhkFwL2mOaywT8y1TwNRcZwM=;
        b=beikOIb0wBfUEvwR5d00Csradi7leWqQq08FcvpA8dPHQhBk1FH1fYmNflPS1Cwj5H
         AAb7VhomPfzt1Sgj7xDEZSoZrOU97yOmeh4V6Ty5wTAquY/ljUqZMhtYajioaXXMOSxj
         4Fwknp9Bb4q2cBvNumN9Lo7bJfs24X2AMNQ4AVbSIryeuUTNDEqIgIEAe9LIbH8CcvV2
         hTur6TBm8sERypO2OMfRGqQpUoGtyt8TzUd7ESrMJaJPk9RwAOJ+Zmb+dERjxmcyZito
         cfkUVwjiCnCzPltYoPl6UoQTpw3W4ZCTnGKXw6E/FnuWkmkv4mXBeNv8EWbNOr6phGMY
         tFhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0pPw3AgtqsjhOOoVzW8kPYm7nCWNNLB2zAmdu+ypgC5GVzNvobzHNBhDdLBz7N4JJik1yNjdisjAlCaRk8IIa1lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9CkBquINg30xqt8fJIsQqpTgZu0EDUrGgK3liBdbrIPfE4gCD
	yvWTRTt+gidv746zHdGrniZVjFWbEJzJRNHNj8FUUzzZiDVowKYtOiJWR6su9AaBFHSKImNlT99
	Iakv8AKCX2NHND6mpcC2Ihl2b9yjm8cJIZeKPB6gl
X-Gm-Gg: ATEYQzyVlEnAdqhDKkb6q+ynbnRe1jvwo8LW56ySTUhI+dApY/6bwc2SxEG1liYOp0p
	+U23Xld5U3UaEvQioJVPFSTB+UNpbeT05gKkLmW1N2oIh9SGe3cAvk1IcernO9H6TKB/N+aveRm
	8AHY2G8x6LQyN5jXsZW47XK1NFjTPJFhYW1COLPikO+EG3XZlO54oYWt+9m+J2eVN73E6A3d/vF
	I4DeyNCRsoiZRTJUrSBNXXF9vOT+EkaM4slwyHyFj3QQ3XRr7sJgJ6RfTSMKJSB6PvQV+06CaWj
	9kvjNN3vmr4prMmbu6kN5tn2uNrYILx1vsMgxvd23mF0r+62g79qcl3u+tauAqYpv0MvH+GV01f
	OU7Y=
X-Received: by 2002:a05:6102:3912:b0:5ff:9d74:967b with SMTP id
 ada2fe7eead31-60567f98c75mr3137498137.20.1775146830774; Thu, 02 Apr 2026
 09:20:30 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Apr 2026 09:20:30 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Apr 2026 09:20:29 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com>
 <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3> <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 2 Apr 2026 09:20:29 -0700
X-Gm-Features: AQROBzDMmtxznwwWBs0nZ4oqZut-IIYidHQDWkMKzAfittGrfvUDuSGnGYqXsAk
Message-ID: <CAEvNRgGm9icDK8sK5ZfqHEOEqSbvjwtihE4p9d3vpBq-NfVjmw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: Michael Roth <michael.roth@amd.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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

Ackerley Tng <ackerleytng@google.com> writes:

>
> [...snip...]
>

>> In the case of SNP, there is a
>> documentation/parameter check in snp_launch_update() that needs to be
>> relaxed in order for userspace to be able to pass in a NULL 'src'
>> parameter (since, for in-place conversion, it would be initialized in place
>> as shared memory prior to the call, since by the time kvm_gmem_poulate()
>> it will have been set to private and therefore cannot be faulted in via
>> GUP (and if it could, we'd be unecessarily copying the src back on top
>> of itself since src/dst are the same).
>
>
> [...snip...]
>
>
> Btw, if snp_launch_update() is going to accept a NULL src parameter and
> launch-update the src in-place:
>
> + Will userspace have to set that memory to private before calling launch
>   update?
>     + If yes, then would we need some other mode of conversion that is
>       not ZERO and not quite PRESERVE (since PRESERVE is defined as that
>       the guest will see what the host wrote post-encryption, but it
>       sounds like launch update is doing the encryption)
> + Or should launch update be called when that memory is shared? Will
>   launch update then also set that memory to private in guest_memfd?
>

Update after today's guest_memfd biweekly:

guest_memfd's populate will first check that the memory is shared, then
also set the memory to private after the populate.

KVM must not make assumptions about any memory that is private, so it
should actually only be operating on memory that is shared. This is
aligned with pre-in-place-conversion, since before this series, there
was no way to populate from private memory anyway.

>>
>> [...snip...]
>>
