Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515D1E507;
	Thu,  6 Jun 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688250; cv=none; b=pdy3dUQD72u3MCHx+GpjVSBw7kNUUwTTkBQJzfZaDLzVNPSomG2SxUOe5kW21vOdwSUrOytahlncIgg/51QmoBJDwYnIg805EqIhlcrx+zEAiCaF6aVqbu3zs7w0OjeMl78XxIkyqxF9C+ysof5pC4FT1RKZsFVIp4Hs7nhCfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688250; c=relaxed/simple;
	bh=sERLUi3uEU0Qc9/KrbcfY5lJQfKzvFrkjGp5BDt0QXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFWs/hfXiQZTFlvjodjFHNBBlQ5k9q6shZ2LnBbUOT/jyIDdHfKIrm9Kv0ZAVw+o55tfRSWDJ6R8vJunYrgX6gDkMuqpvLe/8q/6zG/8ix8HX6BBQP41/kCugF6P6xUFlqT9J+lxItjnOAItrHdA9Z1aZzAQZceei9Z8rNr/jw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=OFP0rCXe; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OFP0rCXe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1717688241;
	bh=sERLUi3uEU0Qc9/KrbcfY5lJQfKzvFrkjGp5BDt0QXI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OFP0rCXeZm7bkwYrqyCIbIaVZQEJeqlhiY+6svO8CIRGmigXQu+Rhwh1QrwidlnSQ
	 XGtlZ+KcLwx9ZA3/aNWZ68wlOdph45Z6tg/59oLXiIKsD3cluTup8zupcPs6JDXGlo
	 09hd9dfVI6w6z/FCXAVmVbDLGmmbeEHc0K+qaKPqbrGdFxleN65lUCEXemHhKNiqcg
	 iZISPQ4VZ4LAVKx4Y/W0dRHkYjgmuw72eppevBkGeWY0tl4a5ZUXPeT/8rkHJNrlQb
	 YWQQ91+QCy4C9zg6toM9zODJfPg3eXR5cSjwRb893gtF6DbD8oYxMlZpWNHjiNTKch
	 3oZIQRoj7QmZQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Vw7k917bXz12pf;
	Thu,  6 Jun 2024 11:37:21 -0400 (EDT)
Message-ID: <ef201f6d-48f1-485a-b446-42822b765c1d@efficios.com>
Date: Thu, 6 Jun 2024 11:38:10 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rust: add static_key_false
To: Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>
Cc: linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
 <20240606-tracepoint-v1-2-6551627bf51b@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240606-tracepoint-v1-2-6551627bf51b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-06 11:05, Alice Ryhl wrote:
> Add just enough support for static key so that we can use it from
> tracepoints. Tracepoints rely on `static_key_false` even though it is
> deprecated, so we add the same functionality to Rust.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>   rust/kernel/lib.rs        |  1 +
>   rust/kernel/static_key.rs | 87 +++++++++++++++++++++++++++++++++++++++++++++++
>   scripts/Makefile.build    |  2 +-
>   3 files changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index d534b1178955..22e1fedd0774 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -39,6 +39,7 @@
>   pub mod print;
>   mod static_assert;
>   pub mod static_call;
> +pub mod static_key;
>   #[doc(hidden)]
>   pub mod std_vendor;
>   pub mod str;
> diff --git a/rust/kernel/static_key.rs b/rust/kernel/static_key.rs
> new file mode 100644
> index 000000000000..6c3dbe14c98a
> --- /dev/null
> +++ b/rust/kernel/static_key.rs
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0

This static key code is something that can be generally useful
both in kernel and user-space. Is there anything that would prevent
licensing this under MIT right away instead so it could eventually be
re-used more broadly in userspace as well ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

