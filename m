Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB734388E
	for <linux-trace-kernel@vger.kernel.org>; Sun,  2 Aug 2026 05:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785648435; cv=none; b=Qg9uGw2y6xDzY5WjJFOnlSDK8LtaEbCyFLpoppEOq8FvDWxiLYbU+9gR1ihsILqIkgCZR6EncevvKSrNOizEtFvg4lgFuwfzxzUtbU0wrLn1cGi4m80XmPCTfV6jYPai1kstwtfmoSgoFAmfb7XMLK4QRIQu518lQjEP8dxkYLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785648435; c=relaxed/simple;
	bh=otXx18xebCjx9LxgbTCOCNlUzer3Kdl6QKzWuM0jh28=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b0UzWOpLl/XN3Z5vSRpvonzkJXFVyrMsRip8CkpnjT5gbvTClEtkzxuldSB8Yal3k/TL3WBcZArDB62We609gDO7WcUpOFnX7ltt4SEvV/Wkh/88i1R1uV8QVwY6EtAQq7hEYgXGNWwi9ovtUmqqbx25b8Q9GT94pWWF5/XlRMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cTvIC1pY; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cTvIC1pY"
Message-ID: <9f60caf3-54f9-4dad-807c-4db33b38a028@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785648421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2sX8MhubVMSwe/8XJCt9hRhnl4wCpSobdphRzH2KXk=;
	b=cTvIC1pYWlORFkK5gpFmkv2hxUlccPWVCTF9PK0v3liEO9BxwHIDIa1Tw02OdbQ3M3SVEB
	rSvMpNs7GiE/7xK+3HDIqFDs0OH8GKVTyZsgWs9fEC+VVZyAf6yBbYpfq3AbeRtQauot8c
	J/7b05Q63Cngnw4gaCmU9mwiTBsqowI=
Date: Sun, 2 Aug 2026 13:26:06 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 13/17] rv: Add KUnit mock for current
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
References: <20260723074534.43521-1-gmonaco@redhat.com>
 <20260723074534.43521-14-gmonaco@redhat.com>
 <38a2480b-b420-4b14-9793-5ab3d7cfb2b9@linux.dev>
 <0CC2C4B0-6E6A-4199-A7FA-EEDEB28866B6@redhat.com>
 <e0fe1e85-c885-4ce6-b250-1b2028112f26@linux.dev>
Content-Language: en-US
In-Reply-To: <e0fe1e85-c885-4ce6-b250-1b2028112f26@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/2/26 12:55, Wen Yang wrote:
> 
> 
> On 7/30/26 13:13, Gabriele Monaco wrote:
>>
>>
>> Il 29 luglio 2026 18:17:31 UTC, Wen Yang <wen.yang@linux.dev> ha scritto:
>>
>>>> +#define rv_get_current() (unlikely(kunit_get_current_test()) ? 
>>>> rv_get_mock_current() : current)
>> ...
>>
>>>> +/*
>>>> + * rv_get_mock_current() is called only if we are running from a 
>>>> KUnit test.
>>>> + * This can occur from a legitimate RV test or any unrelated test 
>>>> running when
>>>> + * a real RV monitor is active and triggering events.
>>>> + * We assume the former case is the only one where mock_current is 
>>>> not NULL and
>>>> + * can occur only sequentially (KUnit doesn't run tests in parallel).
>>>> + * We cannot rely on the test's context because there is no way to 
>>>> safely
>>>> + * understand from which test we are running and KUnit utilities 
>>>> require
>>>> + * locking, which is unsafe from NMI or scheduling context.
>>>> + * Note that it is not possible for a real RV monitor to run when 
>>>> the RV KUnit
>>>> + * tests are running (see rv_set_testing()).
>>>> + */
>>>> +static struct task_struct *mock_current;
>>>> +
>>>> +void rv_mock_current(struct task_struct *tsk)
>>>> +{
>>>> +    mock_current = tsk;
>>>> +}
>>>> +EXPORT_SYMBOL_IF_KUNIT(rv_mock_current);
>>>> +
>>>> +struct task_struct *rv_get_mock_current(void)
>>>> +{
>>>> +    return mock_current ?: current;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(rv_get_mock_current);
>>>>    #endif
>>>
>>> rv_mock_current() uses EXPORT_SYMBOL_IF_KUNIT, but 
>>> rv_get_mock_current() uses EXPORT_SYMBOL_GPL. Both are defined inside 
>>> the same CONFIG_RV_MONITORS_KUNIT_TEST block, so rv_get_mock_current 
>>> should use EXPORT_SYMBOL_IF_KUNIT as well, otherwise it leaks a 
>>> test-only symbol into production builds.
>>>
>>> With that fixed:
>>> Reviewed-by: Wen Yang <wen.yang@linux.dev>
>>
>> Thanks for the review.
>> This was intentional however: rv_get_current() can be called by any 
>> monitor, those don't have to be KUnit.
>> Since rv_get_current() is a macro also calling rv_get_mock_current() 
>> we need to be able to link that too.
>>
>> The idea is that a "real" (non-kunit) monitor handler could be run 
>> when interrupting a KUnit test (not an RV one, we make sure of that). 
>> In that case we do call rv_get_mock_current() and return current after 
>> the function call.
>>
>> rv_mock_current() CANNOT be called outside of the RV KUnit test cases, 
>> it uses a global variable (for problems I tried to explain in the 
>> comment), so should be exported only to KUnit and called directly from 
>> the test case.
>>
>> Does it make sense to you?
>>
> 
> Thanks for the explanation.
> That does make sense.
> 
> One small thought though -- the kernel already provides 
> KUNIT_STATIC_STUB_REDIRECT as the idiomatic way to handle this kind of 
> pattern. It allows a production function to be transparently redirected 
> to a stub during KUnit tests, with zero overhead when no test is running 
> (since it uses the same static_branch_unlikely(&kunit_running) path as 
> kunit_get_current_test()).
> 
> This might be a cleaner fit here, since it avoids exporting 
> rv_mock_current() beyond KUnit and keeps the redirection logic internal 
> to the test harness.
> 
> Just wanted to throw that out there -- what do you think?
> 

I apologize for the noise.  After reading the V5 commit notes more 
carefully:

   * Drop static stub from current to avoid issues with unrelated KUnit 
tests

it is clear that KUNIT_STATIC_STUB_REDIRECT was already considered and 
deliberately dropped.  Kunit_find_resource() may acquires 
spin_lock_irqsave, which does not mask NMIs; using the static stub in an 
NMI-reachable path would risk deadlock.

This patch is the correct choice, and the comment in rv.c explains 
exactly why.


Reviewed-by: Wen Yang <wen.yang@linux.dev>


--
Best wishes,
Wen


> 
> 
> -- 
> Best wishes,
> Wen
> 
> 
> 
> 
> 
