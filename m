Received: from mta1.migadu.com (out-166.mta1.migadu.com [95.215.58.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539913DAAAE
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Oct 2026 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341171; cv=none; b=rSxvwJlPLVXPIYa3OfJym4U8TB3Do0NNgtD9Rtk6/zlt8oHgMFTAekmLAN5fWnPTyUjjMxH4R1umN4M9utObCTczkfCw7cmM8m2EHnptk1ii6OlpEj9mWJ4lIlSa7pvqMO26JQLysWnniG7tR9mI7DPScp+gNTdMPtdC8uNVp0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341171; c=relaxed/simple;
	bh=cYFV4Zhdqv7Lx4ML754VZ5O4c2k3efDLoxAKMMwG9uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4NE0h8u/5MJ9qPxenCi7s/+srnwC2yJ/A0b+I+ZWc4IR0NSbJtHdFpvTzF/UGuGgD0/YUnG/uyPULHIrt1pETtZEV+e8JQ7PXQ8b5cT8tCSq8FlDoOlRa7/XvADNxxKejeiAyYkLwkwGAABoro5PRagH/SAE/0nBwu+rWlLxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B8XLanQP; arc=none smtp.client-ip=95.215.58.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B8XLanQP"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cYFV4Zhdqv7Lx4ML754VZ5O4c2k3efDLoxAKMMwG9uM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792341167; v=1; x=1792945967;
 b=B8XLanQPcolyiNDtb8rGaSuoh1BTjafb45ilE8yTOBEAEUu705+4Whwri5WNGiJ0qJrCNCUA
 m+3Za3jVZRQ6L1f8/jseNcr/7Q794Pkmrh3l/bSwZEdt7BUzEqOLs2V/82KzF79G9HMh0ZTbp7G
 uiacywW2Ojzx/kYgILtRoGnw=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1c9fe71dca233eac;
	Sun, 18 Oct 2026 16:32:46 +0000
X-Mizu-Trace-ID: 1c9fe71dca233eac
X-Migadu-Flow: FLOW_OUT
Message-ID: <6ea0eae1-9183-4da4-be7a-3e9436dda5b7@linux.dev>
Date: Mon, 19 Oct 2026 00:32:37 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/6] libbpf: Factor out __bpf_sys_fd helper
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, shuah@kernel.org, kuniyu@google.com,
 liuhangbin@gmail.com, mkarsten@uwaterloo.ca, masashi.honma@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20261017142649.51047-5-leon.hwang@linux.dev>
 <eb32cc32c29af7d8ad5a342bbd9a0da19c8b53d31a71754b98953a5be62638f0@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <eb32cc32c29af7d8ad5a342bbd9a0da19c8b53d31a71754b98953a5be62638f0@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/17 22:53, bot+bpf-ci@kernel.org wrote:
>> libbpf: Factor out __bpf_sys_fd helper
> 
> TL;DR: Commit message nit only: subject and body call the new helper
> __bpf_sys_fd, but the code names it __sys_bpf_fd. Should the message match?
> 
>> libbpf: Factor out __bpf_sys_fd helper
>>
>> In the next patch, it also needs to use the extended BPF syscall to
>> receive the reported log.
>>
>> So, factor out __bpf_sys_fd helper.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> 
> This isn't a bug, but the subject and body name the helper __bpf_sys_fd,
> while the function the patch adds is:
> 
> +static int __sys_bpf_fd(union bpf_attr *attr, const size_t attr_sz, enum bpf_cmd cmd,
> +			struct bpf_log_opts *log_opts)
> 
> which follows the existing sys_bpf(), sys_bpf_fd() and sys_bpf_ext_fd()
> naming.
> 
> Should the subject and body say __sys_bpf_fd instead, so that searching the
> log for the real function name finds this commit?

Will change __bpf_sys_fd to __sys_bpf_fd in the subject and body.

Thanks,
Leon

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39042048581

