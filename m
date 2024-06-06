Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE99199E93;
	Thu,  6 Jun 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690685; cv=none; b=V4bhvn2XxX6HAsVureNKFANY3CQ1NmNzrryK1Au7eVUBERX2Qw74XWW0dyXn5ut1uGECLzMahuv+xncY3GleAzGY4PdPUfdj+a+cf8V/MGkyV/caXgfDAaxjhcDhCJz0W8ocsvBB2+PEmHm5/gREAaOoMIoWMou1utlXLihTjOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690685; c=relaxed/simple;
	bh=U270xwfQBOa8rfD5dC8oMKQewXsEPRNRTMtEy2i3IjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWGsq5BmAafj003bVGDN9xm8wKvNpTtRTRryQAkYvipYRlU5iupxieMJL8v2i0ep5M6wRIr++D8i1UG/0fpMJ83Gtj1lFuM+fsHWvxiWXVkbb71K4nOHg9Tkzc3FTztgcseV4m8uk0GdH+gceNL9KlSd3PPBjy4TOxNPRkJvlMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=pX4M0HmK; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pX4M0HmK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1717690682;
	bh=U270xwfQBOa8rfD5dC8oMKQewXsEPRNRTMtEy2i3IjY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pX4M0HmKzr0UKZX1rLf3mSRWDLrb8555tuTQQSiqmT7ARgeLs9b2Mk7gVXzMtxGOF
	 a8zrbTv0a6/LZfXaYCRUpwozK175er3RaoZNIeHBDZ9m1hyMct7JVKAIN5lSQMJZTR
	 mBtcWcHb+zE6Zv7Ah2XhT49nRZDA0dPuDr2uR2wewskwaTDwPPMkHJrRf99oTmPYeG
	 sdiMHwzVt6N2UiGFy5Nr7IguLh2kFBx896zCF9vkOM4yareTHVxOQOu2wcnjtVcQ4c
	 P3ugiwnV1yFQVNjW1uDzAjBy2I9xUTtFz6+rTPmeyiArg2EcsgSHyDzegUNUIDd9Ij
	 79G/x/4PkLdfQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Vw8d61MYFz13Gx;
	Thu,  6 Jun 2024 12:18:02 -0400 (EDT)
Message-ID: <ac8a9b80-a209-4fb4-bd6b-1dc41e0fc757@efficios.com>
Date: Thu, 6 Jun 2024 12:18:51 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rust: add tracepoint support
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
 <20240606-tracepoint-v1-3-6551627bf51b@google.com>
 <389a8c55-a169-47ef-99c0-48f58003b40c@efficios.com>
 <ZmHacqvRwBj7OvWm@boqun-archlinux>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZmHacqvRwBj7OvWm@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-06 11:49, Boqun Feng wrote:
> On Thu, Jun 06, 2024 at 11:30:03AM -0400, Mathieu Desnoyers wrote:
>> On 2024-06-06 11:05, Alice Ryhl wrote:
>>> Make it possible to have Rust code call into tracepoints defined by C
>>> code. It is still required that the tracepoint is declared in a C
>>> header, and that this header is included in the input to bindgen.
>>>
>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>
>> [...]
>>
>>> diff --git a/rust/helpers.c b/rust/helpers.c
>>> index 2c37a0f5d7a8..0560cc2a512a 100644
>>> --- a/rust/helpers.c
>>> +++ b/rust/helpers.c
>>> @@ -165,6 +165,30 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
>>>    }
>>>    EXPORT_SYMBOL_GPL(rust_helper_krealloc);
>>> +void rust_helper_preempt_enable_notrace(void)
>>> +{
>>> +	preempt_enable_notrace();
>>> +}
>>> +EXPORT_SYMBOL_GPL(rust_helper_preempt_enable_notrace);
>>> +
>>> +void rust_helper_preempt_disable_notrace(void)
>>> +{
>>> +	preempt_disable_notrace();
>>> +}
>>> +EXPORT_SYMBOL_GPL(rust_helper_preempt_disable_notrace);
>>> +
>>> +bool rust_helper_current_cpu_online(void)
>>> +{
>>> +	return cpu_online(raw_smp_processor_id());
>>> +}
>>> +EXPORT_SYMBOL_GPL(rust_helper_current_cpu_online);
>>> +
>>> +void *rust_helper___rcu_dereference_raw(void **p)
>>> +{
>>> +	return rcu_dereference_raw(p);
>>> +}
>>> +EXPORT_SYMBOL_GPL(rust_helper___rcu_dereference_raw);
>>
>> Ouch. Doing a function call for each of those small operations will
>> have a rather large performance impact when tracing is active. If it is
> 
> Long-term plan is to 1) compile the C helpers in some IR and 2) inline
> the helpers with Rust in IR-level, as what Gary has:
> 
> 	https://lore.kernel.org/rust-for-linux/20240529202817.3641974-1-gary@garyguo.net/
> 
> and I use it for the upcoming atomic API support:
> 
> 	https://github.com/fbq/linux/tree/dev/rust/atomic-rfc
> 
> and it works very well.

Thanks for the pointers, it makes sense.

Thanks,

Mathieu

> 	
> Regards,
> Boqun
> 
>> not possible to inline those in Rust, then implementing __DO_TRACE in
>> a C function would at least allow Rust to only do a single call to C
>> rather than go back and forth between Rust and C.
>>
>> What prevents inlining those helpers in Rust ?
>>
>> Thanks,
>>
>> Mathieu
>>
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

