Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411234;
	b=RF4hxeGTq+z9KDBp/MLxR/Jzh4ACpZud2rPtcnSQapgEcU0eQhyBvGl+AoQSE6QdG6av
	 l5lUp7ZgGDaNJ9BnWi8qOGIIe9PQTBfLfYB5AzkiLwy5Hc3AdsNvdlaFJM248D8pO3pZj
	 UoMD9263plw/Zhol8pZJJPkxtZPBG3m5Z3yDi7tB1r4pIotaBEoKsfOVVPHmr/yNX7lMr
	 JIsogx8lsy4SuJOPOCz7Plf9bzVVKGbyLmq0d3TAXyb6WUpSCXavYlM00bEVbAFqnJrT8
	 af1jKojWC2REMOnEDDb/Ejd1vf2j/JUT9Otu/YefEnX1CxpSDVnKmbnwXZeQC5y2zgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411234;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=BwTjyGbtFLiEfqJNojU1wBEH3l3XXwkDvqFxjFfKBuI=;
	b=bhcM3PyEwbMibVjd8yRGU2dmGIAUntFGJOflnw8fQ3erxbSwh+xSUoV44PfGKOurMds+
	 BVwl1j906ZF4/9wl8sN66eIUHwlzK3NODVP0BUmV52gnJMXlN/yryXmEMeHZtTi9KYT4P
	 Fk7ZWtmLTQW7Vs1ek9eFeGvBb1kY6jP6K+Vwnd0cg26HaUlX7RWK29sHc7EDG35it8pH/
	 QT44UHqy0+ZTxiGhOjDRLaPkTbnLi1JgL0Qqmn+TeIIa035kI6ebZ0CnyWdOW0bS7K1DF
	 oANjzP2mvOpjMNjvDX7aCiteAbKr5SAy1rTRfsrfyNv5y5VVcFlD8DgKC2TFaQXTr7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rfwfWMDS;
	arc=none smtp.remote-ip=91.218.175.64
Received: from mta0.migadu.com (out-64.mta0.migadu.com [91.218.175.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C46C606A324
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 15:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C46C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rfwfWMDS
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gboru3Ec6G1jPwlPZvGIx8shx83LrPwzmsUnld/c0C0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794411232; v=1; x=1795016032;
 b=rfwfWMDS0ETzicI9TdsQtx5vCj6KU4f2QcLmX1BPodx+vlUwXUhtDletliHH5GErvxgGysOJ
 a/S0Lw5TWyzv3OAVGEGFsIv06BbWXEQ+Nxya0BohUSl7nWcapBGxW0AygrurSKzIZfn8AtX9bk5
 sjec4ssQourGBdOWobCHMRfI=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 17a7bba5a94a6255;
	Wed, 11 Nov 2026 15:32:36 +0000
X-Mizu-Trace-ID: 17a7bba5a94a6255
X-Migadu-Flow: FLOW_OUT
Message-ID: <9f9f10e5-d9f2-4cac-9376-a5802424de04@linux.dev>
Date: Wed, 11 Nov 2026 23:32:25 +0800
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/9] bpf: Add log support for cgroup prog
 link_create
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 kpsingh@kernel.org, matt@bobrowski.net, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20261109140816.5196-5-leon.hwang@linux.dev>
 <8a2b570a4d824e7a7acb46464af3318cc99a87ac6b620dc5cb76d9966101fd1d@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <8a2b570a4d824e7a7acb46464af3318cc99a87ac6b620dc5cb76d9966101fd1d@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/9 22:47, bot+bpf-ci@kernel.org wrote:
>> bpf: Add log support for cgroup prog link_create
> 
> TL;DR: Nit only: the new <linux/bpf_verifier.h> include in bpf-cgroup.h may be
> unnecessary, since a forward declaration would likely suffice and avoid
> pulling it into tcp.h users.
> 
>> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
>> --- a/include/linux/bpf-cgroup.h
>> +++ b/include/linux/bpf-cgroup.h
>> @@ -4,6 +4,7 @@
>>  
>>  #include <linux/bpf.h>
>>  #include <linux/bpf-cgroup-defs.h>
>> +#include <linux/bpf_verifier.h>
>>  #include <linux/errno.h>
>>  #include <linux/jump_label.h>
>>  #include <linux/percpu.h>
> 
> this isn't a bug, but is the <linux/bpf_verifier.h> include needed here?
> 
> bpf.h already forward-declares struct bpf_verifier_log, which is all the
> new cgroup_bpf_link_attach() prototype and its stub need, and cgroup.c
> already includes bpf_verifier.h for bpf_log().
> 
> Since bpf-cgroup.h is included from include/net/tcp.h, would a plain
> forward declaration (as done for trace_events.h earlier in this series)
> keep the verifier header out of those translation units?
> 
Good catch.

Will drop this include.

Thanks,
Leon

