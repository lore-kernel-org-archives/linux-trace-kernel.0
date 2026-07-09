Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F992D73B5
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615589; cv=none; b=tvE4B2juIRIaN+wW05YYme8kavJjTjSfziIdvfBv1CTBGYTV8eua2dBkFViIPHEJWiQH1BuQ/Z7G4jhY2Ydl282mQOH/Z8a0H3q2WkvypEPxa12+TwmU5jv+vriMl/+xH/AX+Lr1MsEruxUHPQ3XDX/EIpRrdTXrA9WiHE+j1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615589; c=relaxed/simple;
	bh=Jqh8boUlzbmfLuuleo/Re4DuxLjXSreI+1ySrUxBw/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNMPVLzbjEFtsHseL3CjeIULBMWb7iVJJS/j9sXXr+kdjgGXwsLony3O3KpHClLxWKNn2oqbxj9uJp4dn02v9Omehdc8NuDKxA5213Sk82+GDKL7fUfSOKxDu4fkIWHDZI/p2cC8TdqAomQmTWzy0bz2WFVrvHI452oa/xehdyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NUjqCZfk; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NUjqCZfk"
Message-ID: <18dcc24d-329e-43f4-bc69-e368c1f1d066@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783615584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmIPOonx0AO+yiGPpMqjrlY4Qd2B540z+A04IHRqn30=;
	b=NUjqCZfk4XnGb8yQDVFZ9tshLWNnvcU6TVu7zwI+dTdfjO8tk4VrNXUghh5nIOWPkgavOf
	0cllLl6hyqLj7ErKIZqgCFnQ6wpnuh+lff5Cv9clHPSGQLyDB0eqvhNTDP+noi4ZxtWcrK
	qsU0t+uW0VSS90BsokTdouNp/1iHJrQ=
Date: Fri, 10 Jul 2026 00:46:17 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] rv/reactors: add KUnit tests for reactor_panic
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1781541556.git.wen.yang@linux.dev>
 <810f587d63c84b64067f990299be02b88f5d8106.1781541556.git.wen.yang@linux.dev>
 <c8c7568dd9293b0a718584c1aa193692c128d77d.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <c8c7568dd9293b0a718584c1aa193692c128d77d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/6/26 23:00, Gabriele Monaco wrote:
> On Tue, 2026-06-16 at 00:44 +0800, wen.yang@linux.dev wrote:
>> +/*
>> + * Test 2: panic notifier chain is reachable.
>> + *
>> + * vpanic() calls atomic_notifier_call_chain(&panic_notifier_list, ...).
>> + * Drive the chain directly to verify panic notifiers receive the
>> notification —
>> + * the observable side-effect of reactor_panic without halting the system.
>> + */
>> +static void test_panic_notifier_called(struct kunit *test)
>> +{
>> +	atomic_notifier_chain_register(&panic_notifier_list, &mock_panic_nb);
>> +	atomic_notifier_call_chain(&panic_notifier_list, 0,
>> +				   "panic violation message");
>> +	atomic_notifier_chain_unregister(&panic_notifier_list,
>> &mock_panic_nb);
> 
> I just realised this isn't even testing the reactor, it's testing the
> notifier_chain thing, I don't think we really need this here or am I missing
> something?
> 

Thanks,

Since rv_panic_reaction calls vpanic() which is __noreturn, direct 
testing is not feasible in KUnit.

A preparatory v2 drops reactor_printk_kunit.c and reactor_panic_kunit.c
entirely, replacing them with a single rv_reactors_kunit.c containing
two suites:

   rv_reactor_registration: register/unregister lifecycle, duplicate
     rejection (-EINVAL), name-too-long rejection, and safe unregister
     of a never-registered reactor.

   rv_react_dispatch: null-callback guard, callback invocation check,
     and the mdelay lockdep stress test.


v2 also adds EXPORT_SYMBOL_GPL for rv_react(), rv_register_reactor(), 
and rv_unregister_reactor(), and the Kconfig entry is tristate.

Additional fix: rv_unregister_reactor()

Testing exposed a real bug: rv_unregister_reactor() called list_del()
unconditionally.  On a never-registered reactor the list_head is
zero-initialised, so list_del() dereferences NULL->prev and crashes.
v2 adds a patch that iterates rv_reactors_list first and only calls
list_del() when the reactor is found.  test_unregister_nonexistent
documents and guards this behaviour.


--
Best wishes,
Wen




