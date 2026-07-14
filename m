Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C7417BCB;
	Tue, 14 Jul 2026 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051005; cv=none; b=W6kGPqQSlT81jW0/glIu7x7Gupo7+8crZUIx6D4HqQLjiIgmMPUWN1odOenAiojnKZULihRb9v3RyNtTBaZCtOL3/idxSg2/AfBBivJgXUcRvQZ+4EGGxCb5uzWmERx8Qs8PRbqHj9JZoiMX55aAKjepErgnLO3vXO72ZphnJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051005; c=relaxed/simple;
	bh=3z1Of4Vww4qbRgfSbC912oJOYQ5zODKROo1MsJiPaXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0XsPkF9K8P/FnW53P2j4SXXrZ5NXkhpgkRvKum3jsKaGNdTDFKpaAwhoX87A85fUc+HaY8UWcQjbN3FxS0kg/bJQlgAfOyTWKL5tyjhJ7R7Q1F7bPoCVWgR4loM1r75lPq0l4RcPyGF+XLxshxPX3xQokLZdCB4uY7gMC2uFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QlJCLoaZ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QlJCLoaZ"
Message-ID: <73295218-eb3f-437d-be5a-fcb5012bf31b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784050995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHSQYTrU46qwkPBwEFEKw5EcFju6vQUCImnwwCayrhc=;
	b=QlJCLoaZDtSUqQF9ngLa/Xju8dOJPOyiz9C9q1LVl4sDprPGcH11R7kAoTjcsTTPHt7qJp
	fz07ZdNEkSGANyqxyaCURUobK8si7FwJI4AiZmA+8m8kokf+FdV30JoiBIt98xhlB+FoFF
	bEXQ1FHDrsXK0/jsWMC+9deSYnOvMww=
Date: Wed, 15 Jul 2026 01:42:58 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 16/17] selftests/verification: Rearrange the
 wwnr_printk test
To: Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-17-gmonaco@redhat.com>
 <cd0a678b-1eec-42d8-b027-0d27b9c804a3@linux.dev>
 <b971748dea21a7a6eec3be8b95f4c18aec2d0552.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <b971748dea21a7a6eec3be8b95f4c18aec2d0552.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/10/26 16:31, Gabriele Monaco wrote:
> On Fri, 2026-07-10 at 01:08 +0800, Wen Yang wrote:
>>>    load() { # returns true if there was a reaction
>>> -	local lines_before num
>>> +	local lines_before num load_pid ret
>>>    	num=$((($(nproc) + 1) / 2))
>>>    	lines_before=$(dmesg | wc -l)
>>> -	stress-ng --cpu-sched "$num" --timer "$num" -t 5 -q
>>> -	dmesg | tail -n $((lines_before + 1)) | grep -q "rv: monitor wwnr
>>> does not allow event"
>>> +	stress-ng --cpu-sched "$num" --timer "$num" -t 5 -q &
>>> +	load_pid=$!
>>> +	timeout 5 dmesg -w | tail -n +$((lines_before + 1)) | grep -m 1 -q
>>> "rv: monitor wwnr does not allow event"
>>
>>
>> Minor nit: could we add a small delay (e.g., sleep 0.1) before dmesg?
> 
> I don't get what the benefit would be.
> 
> The intent of that line is to run a continuous dmesg (-w) for up to 5s (timeout)
> but stopping if an occurrence is found (grep -m 1 would close the pipe).
> 
> Do you see a case in which this wouldn't happen?
> 

You're right, the sleep is not needed. My concern was that a reaction
message generated in the brief window between starting stress-ng and the
dmesg pipeline being fully set up might be missed. But that can't
happen: dmesg -w always starts by flushing all currently buffered
messages before entering watch mode, so any reaction already in the ring
buffer will be included in its initial output. The  tail -n +N  offset
then correctly filters to only those messages beyond our pre-test
baseline.

Withdraw the nit. The Reviewed-by stands.

--
Best wishes,
Wen

>>
>> Reviewed-by: Wen Yang <wen.yang@linux.dev>
>>
