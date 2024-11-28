Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F153232;
	Thu, 28 Nov 2024 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809755; cv=none; b=XzJxQ0Z8Yi9coDIIpvFhzjrRncBy87pci+1SJeHzwtN3dmwcNYYxUj+Vl1KzUJOVXyooWlA7id+d6iuyKC9TYjLxOMuv6Cdjaw7wQAtWWA46gcLiJY9y/3geYAq4opHpBqdwbuFxML5Uynlx/pftZ3nwx2yOXpSqi0NfbrzhhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809755; c=relaxed/simple;
	bh=uzgU4YVVYxzE6NQbwjvNbfIBTA3s/xWzLl1dj6lPkS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJlx9lzNuW5/pULHuC8iNzvN7rbYhN8PK+ew46SGztZCN3jIqXK/HptrYtTfu+Lp+ys2a34jKobgyzxTsNISjLu0oKC4QcbIPCh4lOXLh3TzHr3T8TWXBbf3XePECLQIqqO0cTnJhQoNJjoPkN55ueVOyjqkWRFEH0kc7ze5QU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=OLB+vq8o; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OLB+vq8o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1732809751;
	bh=uzgU4YVVYxzE6NQbwjvNbfIBTA3s/xWzLl1dj6lPkS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OLB+vq8oo2L6MUxfD72JdtT091Vr7Nta2+chT8Dy6Ce8Kl7F7Sz1czKxzk9650wYb
	 l4SuQdfUnYzCKtjdLElmlbjkqjIiBlVJC6kWh4fjdFMWlba2Bc+H5uitg33yPPVPnF
	 3enK9HnEc4QeYjGfB6aJD9krVPwUwum5Waoro/B/t3dyI44tGrUFMJHf4hgfYmeAtt
	 r1p+aAc+7SiPoJ7VnXC2vFnQfvMTsUG30kUcDSHUwv014i5MbPE/t0LFiUJ0fXeabH
	 UfNSL6PPe8vnviSSK48GZbh8amyMHXIAHA+73wzgcR98uhpDmVAeAaShHOS6kzXW6B
	 e92BKVlkMzs5Q==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Xzh0R63rpzkFK;
	Thu, 28 Nov 2024 11:02:31 -0500 (EST)
Message-ID: <67b5a0d7-95a2-46d2-bb4a-69a4368abe3d@efficios.com>
Date: Thu, 28 Nov 2024 11:02:31 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Add WARN_ON_ONCE for syscall_nr check
To: Steven Rostedt <rostedt@goodmis.org>, Tao Chen <chen.dylane@gmail.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20241128115319.305523-1-chen.dylane@gmail.com>
 <20241128074623.063bf253@rorschach.local.home>
 <8d4796dc-ef5b-43d8-8ec0-3891b7994428@gmail.com>
 <20241128100324.05bc4c32@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241128100324.05bc4c32@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-28 10:03, Steven Rostedt wrote:
> On Thu, 28 Nov 2024 21:15:31 +0800
> Tao Chen <chen.dylane@gmail.com> wrote:
> 
>> Hi, Steve, thank you for your reply, as you say, so what about
>> pr_warn_once api just to print something ?
> 
> A better solution is for there to be a return code or something where the
> tracers (perf or ftrace) can record in the trace that the system call is
> not supported.

Just be careful not to spam the traces uselessly. E.g. if only the
openat syscall is enabled, you'd only want to be made aware of the
ia32 openat, not all ia32 syscalls.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

