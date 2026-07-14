Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98348417BD2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051394; cv=none; b=ZCAIPr+r0u7WZyfl7fD9VtGzbMs6kTD+4aKUcZK3C3yY1A60ckror7G6NAyf1FehociEcAwtc6+F/dDXqDp/Sj0X3MiiFYdlcySbF6hj0aVKNYPVslztPMRBtzvnbrurN4u5boaqnG27nPinAo8XqWiD1Hepfsyvo+dSqx3JnTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051394; c=relaxed/simple;
	bh=dhiartyi4jjUPUKbUIYMUWv9chN/dk1gwaVdhyWapa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TESPJidQJCQ+Pta6Ldb2XlBXODZQfcXxfEqga97KgDyAnQDbbRMEJbIt/XfZpsLhrFFJ/OV2twB97UBIJufXXo/C/t8Mj8j4pZbRi4Slb7x6lLPugIaXjnbRXLgh25nEpwhJvcygJSEx7brNBUVqgxnc1MaWtspcgWD8pZiepUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GPkBNuWp; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GPkBNuWp"
Message-ID: <a20ddbab-aebe-4f2c-9d07-ec8dee588eab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784051381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YC6eiO1UxMSR2iYHGC4h/1tyJG0eQ/3PFoemsdGWpc=;
	b=GPkBNuWp+FxWcWQokytMFcLiwFcH5DF6vviCQ7vTXZA7d3BiCJzuD5aRHTsSfBTXoYExdU
	R77Ze9F6Ljol/kFciTAyuyZpdHs5Ws438QCkabFRSvZoDD5hSO2HFVDfN7wSc8NZC6G2n8
	L6S+MTBwJh8uv2J6iRoN4Ni4jbjszP8=
Date: Wed, 15 Jul 2026 01:49:27 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 14/17] verification/rvgen: Add selftests for rvgen
 kunit
To: Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-15-gmonaco@redhat.com>
 <53f2d13c-cc1d-48fd-95f0-2c1ff1edfc88@linux.dev>
 <ed538f5f3a0976ea8a0be66b20a446442f7260c1.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <ed538f5f3a0976ea8a0be66b20a446442f7260c1.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/29/26 15:04, Gabriele Monaco wrote:
> On Mon, 2026-06-29 at 01:06 +0800, Wen Yang wrote:
>> On 6/25/26 20:14, Gabriele Monaco wrote:
>>> +static void handle_example_event(void *data, /* XXX: fill header */)
>>> +{
>>> +	ltl_atom_update(task, LTL_EVENT_A, true/false);
>>> +}
>>> +
>>> +static int enable_test_ltl_kunit(void)
>>> +{
>>> +	int retval;
>>> +
>>> +	retval = ltl_monitor_init();
>>> +	if (retval)
>>> +		return retval;
>>> +
>>> +	rv_attach_trace_probe("test_ltl_kunit", /* XXX: tracepoint */,
>>> handle_example_event);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void disable_test_ltl_kunit(void)
>>> +{
>>> +	rv_detach_trace_probe("test_ltl_kunit", /* XXX: tracepoint */,
>>> handle_sample_event);
>>> +
>>
>> one typo:
>>          handle_sample_event should be handle_example_event.
> 
> Keep in mind that those files are not ready to build, users need to
> touch them anyway after generation from rvgen. Nevertheless, this has
> been inconsistent for a while and I should fix it.
> 

Note that the same typo (handle_sample_event) appears in the other two
LTL golden files added in patch 05/17 as well: ltl_pertask.c and
test_ltl.c. The root is likely in the rvgen LTL template itself, so
the fix there would regenerate all three consistently.


>>> +	ltl_monitor_destroy();
>>> +}
> ...
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_AUTHOR(/* TODO */);
>>
>> Please use a valid string here.
> 
> Likewise, this is not supposed to build, we are just validating what
> rvgen produces and that's the expected output, the user will need to
> fill it with an appropriate string.
> 
> LTL uses a different approach compared to DA/HA in this template, I'm not
> sure it's worth aligning the two..
> 

Understood on the intent. One small concern:  MODULE_AUTHOR(/* TODO */)
is subtly different from an XXX comment — a C preprocessor strips the
comment before macro expansion, leaving  MODULE_AUTHOR() with an empty
argument. When the user does go to compile, they get a cryptic error
rather than a clear "fill this in" hint.

--
Best wishes,
Wen


