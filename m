Received: from mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721663DDAFB
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Oct 2026 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341198; cv=none; b=LmVv5SCBu5aFD6DLAIS+8u3wMim/yLqfzgBde1dzWwoRyU32LDPZF6cvMrXymnJ3rfGLC44ifbq635d/ItHL4SBW3IJ8cHLYegiL026VQNKQySEYsqw3qNFO64Ht3sId5357nJJBxBp/hFko3DGG55POP2KkO2UNdayjDGpQHpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341198; c=relaxed/simple;
	bh=ojksHLeipKPRkqBzkwdonsEV9b1jH0qB2Zw+8QFvt2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hv9rup2mA9jk5YACbzXrRzhRWxC/QOMXpIbm6P7KP6ugqeRAU71XZKIwv9y13cKAEcyeHPaj2t1iV7xInCVqkaH17o5Im77xnxTAcO4q5Gdir5Fpl+NBkwtwPW9Vi/XHRtYQB8m2tzmVvKEUj39ihj5GuY2dTJvpChXea14FPAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MU6Tq3F2; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MU6Tq3F2"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ojksHLeipKPRkqBzkwdonsEV9b1jH0qB2Zw+8QFvt2w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792341192; v=1; x=1792945992;
 b=MU6Tq3F2JtlJvHtQqgd3/5uLKQSfx1QSgtMX5c8jzBCoWO9VmO9IyIdHwmYF5ekZqJbDiK9N
 ViKhXvxC9x/wi3ko2ehWvlg/SdnvRcuKZkyFg+wM/eLgLDTSV8WAKEFY1f44Abo+XyFHCAbK/qS
 wpIGlmxD+XySAK7mFLfZQQ2M=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4a67c33501ed153d;
	Sun, 18 Oct 2026 16:33:11 +0000
X-Mizu-Trace-ID: 4a67c33501ed153d
X-Migadu-Flow: FLOW_OUT
Message-ID: <4600eb22-3075-454b-8d6f-d8e01f092e5e@linux.dev>
Date: Mon, 19 Oct 2026 00:33:00 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 5/6] libbpf: Add bpf_link_create_log API
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
References: <20261017142649.51047-6-leon.hwang@linux.dev>
 <d8f51a15d54c296421230d26a3c7b1bb535c9bd98e15eb52dd36344c3690c053@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <d8f51a15d54c296421230d26a3c7b1bb535c9bd98e15eb52dd36344c3690c053@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/17 23:03, bot+bpf-ci@kernel.org wrote:
>> libbpf: Add bpf_link_create_log API
> 
> TL;DR: Commit message only: the rationale for adding bpf_link_create_log()
> instead of extending bpf_link_create_opts is vague ("it seems not proper") and
> one sentence is self-contradictory; no code issues raised.
> 
>> libbpf: Add bpf_link_create_log API
>>
>> Add a new API to accept the log opts, instead of extending the existing
>> struct bpf_link_create_opts.
>>
>> In the struct bpf_link_create_opts, it seems not proper to append a
>> tailing common log field prior to those variant length fields.
>>
>> Add a new API to avoid breaking the struct bpf_link_create_opts.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> 
> This isn't a bug, but could the changelog say more concretely why a log
> field cannot be added to struct bpf_link_create_opts (for example, the
> trailing union growing for future link types), rather than "it seems not
> proper"?
> 
> The sentence "append a tailing common log field prior to those variant
> length fields" also reads as self-contradictory, since "append" and "prior
> to" point in opposite directions.

Will describe my justification with a concrete case in the next revision.

Thanks,
Leon

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39042048581

