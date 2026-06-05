Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CA43CD8CA;
	Fri,  5 Jun 2026 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649665; cv=none; b=ia+BuTMDPBEa6/Ga9OPQrFuePWpyBy/2PO7zabFosFvmQ29rXQ1pinkEC5oSIxpWPxmaYsPPeKM94ERnKOcxOSZwqrv9rgymQljeGRTcBzcknxt/+EScB8pnvZafEC3ktV+PJN7dZbl5r9Q4xb4SS5g3fq6dwZaIbHhQPrgSXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649665; c=relaxed/simple;
	bh=za/Q5W3FetgNGBxC3/mNtBqJ6BCx8IDSiT33jjoXZNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pm8yLHMU0FSHv42HlYzliUvpAC4GQDZUuEUSNm3ar+YD/oCOhInywycxQlco664NYmq+Bcc8OJc1uibR5OindOycBu2GxOMjtN/aNpyHb1h9llJIBLPa/fxbI9cydXqsTPC9pbhNU1C6PpK5yyPTGG0o5pu01GlJgUmRyp8vcdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Gzzb9pgK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Gzzb9pgK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A3204CE7;
	Fri,  5 Jun 2026 01:54:17 -0700 (PDT)
Received: from [10.57.92.75] (unknown [10.57.92.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36C5A3F632;
	Fri,  5 Jun 2026 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780649662; bh=za/Q5W3FetgNGBxC3/mNtBqJ6BCx8IDSiT33jjoXZNw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gzzb9pgKm/VqzuNQWn4GqmeLpozOIVHEL4a7lpQ6LY9IuNt0PSiF4UMuyHA313reK
	 adqVfC75WvtPaiw9gE55+iUPvW+5IJFa0HDb8PCVsfPSAiOnAbMba7hYbKQPgjS02w
	 IVon2C90mRhBq/CB0loy54WttdKIcrw9FAQvra1o=
Message-ID: <3322698e-af49-4998-b619-34ab24094374@arm.com>
Date: Fri, 5 Jun 2026 09:54:12 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 20/42] KVM: SEV: Make 'uaddr' parameter optional for
 KVM_SEV_SNP_LAUNCH_UPDATE
Content-Language: en-GB
To: Ackerley Tng <ackerleytng@google.com>, aik@amd.com,
 andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org,
 chao.p.peng@linux.intel.com, david@kernel.org, ira.weiny@intel.com,
 jmattson@google.com, jthoughton@google.com, michael.roth@amd.com,
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com,
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com,
 steven.price@arm.com, tabba@google.com, willy@infradead.org,
 wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com,
 pratyush@kernel.org, aneesh.kumar@kernel.org, liam@infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Youngjun Park <youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <20260522-gmem-inplace-conversion-v7-20-2f0fae496530@google.com>
 <9d15479e-e36b-4865-804c-7d93eb339e4e@arm.com>
 <CAEvNRgF43RBv77RgM67kXRRHDnQw4L5uwQTuvkJHzkHJWB1mag@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAEvNRgF43RBv77RgM67kXRRHDnQw4L5uwQTuvkJHzkHJWB1mag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/06/2026 20:05, Ackerley Tng wrote:
> Suzuki K Poulose <suzuki.poulose@arm.com> writes:
> 
>>
>> [...snip...]
>>
>>> +In the case where ``type`` is KVM_SEV_SNP_PAGE_TYPE_ZERO, ``uaddr`` will be
>>> +ignored completely. Otherwise, ``uaddr`` is required if
>>> +kvm.vm_memory_attributes=1 and optional if kvm.vm_memory_attributes=0, since
>>> +in the latter case guest memory can be initialized directly from userspace
>>> +prior to converting it to private and passing the GPA range on to this
>>> +interface.
>>
>> Just to confirm, so the sev_gmem_prepare doesn't destroy the contents in
>> the process of making it "private" ? i.e., the contents of a SNP shared
>> page are preserved while transitioning to "SNP Private" (via RMP
>> update).
>>
>> Suzuki
>>
> 
> The following is the guest_memfd perspective, I didn't look at the SNP
> spec:
> 
> Do you mean specifically for KVM_SEV_SNP_PAGE_TYPE_ZERO, or for any
> type?
> 
> guest_memfd has no plans to do any special zeroing based on type.
> 
> guest_memfd decoupled zeroing from preparation a while ago (Michael had
> some patches), so zeroing is supposed to be once during folio ownership
> by guest_memfd, tracked by the uptodate flag, and preparation is tracked
> outside of guest_memfd. So far only SNP does preparation.

I am talking about the SEV SNP conversions (specifically quoted in my 
response), I will follow up on Michael's response.

Suzuki

