Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80393523A;
	Thu,  6 Jun 2024 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690814; cv=none; b=P4JqAVrL9cJ9lTUBnCGH0SBEQXsPhiLNodYlTZ+we24KNCVRaPm04uXEYJzFrt9QscXyBgiIciDcYCUN7D29+UuIMx4JdyGkhAD8BP99ZHpBwgsw/w7XML9zOSgzB3Of1RB+C4T3sOPwUXBuv/1zYcAOqIwYwwxDFRf1OSJjcaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690814; c=relaxed/simple;
	bh=P7Ny5PrOSz7RwWYIn9JAfdYiQC4v04agvSg8RSRxxEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PY6H0fNagUvW2o2m6ey9DgRMqhlXY0YgNhJjcJfsuFZ1zmFrAd/KkZeCYaGs5pNXT9/ZdZ2efwS9BoHlsl91gmRRe1eJCpdoiogzj3MZMemxVbwYGSXfGmLdI80hH4Lh1nEHRR8LgbooWqlO+JeCt0Zr9alVaRmIQpGdpr563BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=B03Q9VBM; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="B03Q9VBM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1717690811;
	bh=P7Ny5PrOSz7RwWYIn9JAfdYiQC4v04agvSg8RSRxxEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B03Q9VBMpbwi37mDHg7/SWpsM3bIe0b0n1mHSl92Ui6Iy3iIdbygD1UYHeohq1feT
	 w26vM1dghT8pgM8RyJzOx/QxIW6NL+sn/SfVVU1PPgpHBx4nkjItlCnsx5MMFj0Sdh
	 BFAi98bPdl0Kbfj2kG4VhlPtCN1CTKVjzu6o5jXs49cul5lHgUH6HwD4tFZpemm+7g
	 WlKra8G33KOV8BcM8+XUmxUUwLrrysoWrzz/fM060V4ZZmQ+q36nasawUHI/q6kgg7
	 tlNnq3yBmf2ENjrrw8pz+DwKa6mkrLWsUXOQH868waIJym94bFA1sl6g+x8FVXfoA+
	 JYfe4JdZhx3Yw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Vw8gb21czz1345;
	Thu,  6 Jun 2024 12:20:11 -0400 (EDT)
Message-ID: <b36d92c8-6ce8-494f-951c-a6c24928f78d@efficios.com>
Date: Thu, 6 Jun 2024 12:21:00 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rust: add tracepoint support
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
 <20240606-tracepoint-v1-3-6551627bf51b@google.com>
 <389a8c55-a169-47ef-99c0-48f58003b40c@efficios.com>
 <CAH5fLghG8VpUnHbigO28k9nE9ZFS3EHGT2SE-0mZG1NtHF0qKg@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAH5fLghG8VpUnHbigO28k9nE9ZFS3EHGT2SE-0mZG1NtHF0qKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-06-06 12:16, Alice Ryhl wrote:
> On Thu, Jun 6, 2024 at 5:29 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
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
>>>
>>> +void rust_helper_preempt_enable_notrace(void)
>>> +{
>>> +     preempt_enable_notrace();
>>> +}
>>> +EXPORT_SYMBOL_GPL(rust_helper_preempt_enable_notrace);
>>> +
>>> +void rust_helper_preempt_disable_notrace(void)
>>> +{
>>> +     preempt_disable_notrace();
>>> +}
>>> +EXPORT_SYMBOL_GPL(rust_helper_preempt_disable_notrace);
>>> +
>>> +bool rust_helper_current_cpu_online(void)
>>> +{
>>> +     return cpu_online(raw_smp_processor_id());
>>> +}
>>> +EXPORT_SYMBOL_GPL(rust_helper_current_cpu_online);
>>> +
>>> +void *rust_helper___rcu_dereference_raw(void **p)
>>> +{
>>> +     return rcu_dereference_raw(p);
>>> +}
>>> +EXPORT_SYMBOL_GPL(rust_helper___rcu_dereference_raw);
>>
>> Ouch. Doing a function call for each of those small operations will
>> have a rather large performance impact when tracing is active. If it is
>> not possible to inline those in Rust, then implementing __DO_TRACE in
>> a C function would at least allow Rust to only do a single call to C
>> rather than go back and forth between Rust and C.
>>
>> What prevents inlining those helpers in Rust ?
> 
> There's nothing fundamental that prevents it. But they contain a large
> amount of architecture specific code, which makes them a significant
> amount of work to reimplement in Rust.
> 
> For example, rcu_dereference_raw calls into READ_ONCE. READ_ONCE is
> usually a volatile load, but under arm64+LTO, you get a bunch of
> inline assembly that relies on ALTERNATIVE for feature detection:
> https://elixir.bootlin.com/linux/v6.9/source/arch/arm64/include/asm/rwonce.h#L36
> 
> And preempt_enable_notrace has a similar story.
> 
> The solution that Boqun mentions is nice, but it relies on rustc and
> clang using the same version of LLVM. You are unlikely to have
> compilers with matching LLVMs unless you intentionally take steps to
> make that happen.
> 
> But yes, perhaps these helpers are an argument to have a single call
> for __DO_TRACE instead.

If those helpers end up being inlined into Rust with the solution
pointed to by Boqun, then it makes sense to implement __DO_TRACE
in Rust. Otherwise doing a single call to C would be more efficient
than calling each of the helpers individually.

Thanks,

Mathieu

> 
> Alice

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

