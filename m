Received: from mta0.migadu.com (out-116.mta0.migadu.com [91.218.175.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B29361976
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789317222; cv=none; b=BkbJZhcY4IG7KpTehLzWqOtPF6Q2osbzfTlm0afos15B/T+Y1wA5pA3O5ISbSQwszMRaFMdNwUb/DXvAIwH/SR2VBSlbRBvLQBOJ9083qgE/lhtw0xVa5zgEPFjOOZNgDc+GzimKaFkQkQqrLlhn4HpGgII0LDK/znJcUj+wC4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789317222; c=relaxed/simple;
	bh=XW9xQV5lA+mLCt7Yhep3pssELWN2b4I7bYx4XskK3w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GT7Sg8Czc0CZNW9IqS4+qIxCc0yhmVUOzETN07aDOLzMP+sA7XOfRpzfXtj13Kx3TAJ4d4ajt0b7IxCfx1capcpKY7G70HyJXGgl6t5PegMo0PKRxrFddYS17+/fy248aoS5kf/uIovg2Wc5Tq+mFGzNhyA6s0opJYK3cBZKKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pq+whU6w; arc=none smtp.client-ip=91.218.175.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pq+whU6w"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XW9xQV5lA+mLCt7Yhep3pssELWN2b4I7bYx4XskK3w0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789317217; v=1; x=1789922017;
 b=pq+whU6wkV82N8dpF4Ok4g3KOJoKGe54isZgStKTbUegd9I1S0aX8uG8QF9ocvPNjbNIPzU3
 1OjdOJ7CnY0RtYY7684pL98U5NUAPh2p0IF57AsJmLB8c0qu5DQy9UZBD+/eve4q/c0S2zjx+vA
 2a62Xb9ufWiXh/PAD6cj0Pr0=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 976b2f49cafd9a0d;
	Sun, 13 Sep 2026 16:33:27 +0000
X-Mizu-Trace-ID: 976b2f49cafd9a0d
X-Migadu-Flow: FLOW_OUT
Message-ID: <2c408ff5-9a13-438e-9068-21b3f1516fbd@linux.dev>
Date: Mon, 14 Sep 2026 00:33:17 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] rv/reactors: export rv_register_reactor() and
 rv_unregister_reactor()
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1788705281.git.wen.yang@linux.dev>
 <7c931773dacd7c3da35a22629c3d7dc286b5a0fe.1788705281.git.wen.yang@linux.dev>
 <b5ec9da630968a5f801623c8d6e2aaeb0bb509d8.camel@redhat.com>
Content-Language: en-US
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <b5ec9da630968a5f801623c8d6e2aaeb0bb509d8.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/11/26 14:53, Gabriele Monaco wrote:
> On Mon, 2026-09-07 at 01:10 +0800, wen.yang@linux.dev wrote:
>> From: Wen Yang <wen.yang@linux.dev>
>>
>> rv_react() is exported to modules, but the reactor registration helpers
>> are not.  Export them with EXPORT_SYMBOL_GPL() so reactor modules and
>> the tristate KUnit test module can register and unregister reactors
>> without hitting undefined symbol errors at link time(modpost).
>>
>> Commit 3d3800b4f7f4 ("rv: Remove reactor's reference counter") noted
>> that if module-based reactors are supported, try_module_get()/module_put()
>> should be used. Add struct module *owner to struct rv_reactor so a module
>> cat set owner = THIS_MODULE; pin the module in monitor_swap_reactors_gingle()
>> and release it when a monitor detaches or is unregistered.
> 
> You needed these symbols in KUnit and we are exporting them for /potential/
> future support of reactors as modules. I don't see any technical reason why we
> shouldn't support this, but they are currently /not/ supported.
> 
> I know sashiko and other LLMs complain about this, and they have a point, but
> you can ignore them. At most state in this commit message that this does NOT add
> support for reactors as modules.
> 
> Let's focus this series on its original intent (fix a lockdep warning and add
> some KUnit tests that expose a reproducer), then if adding support for reactors
> as modules is so simple, you can do it in another series.
> 
> If you really want to /also/ add support for reactors as modules in this series,
> you need to make that very explicit (not just a vague line in the changelog, but
> rather rewrite the entire cover letter and commit message).
> And mind that this would mean your series needs to go through another round of
> review and serious testing: you are adding a new feature.
> 
Thanks for the review, Gabriele, I agree with your points and will 
follow them.

Just to clarify the background : the struct module * field and the 
try_module_get()/module_put() logic were added to address the point 
raised by sashiko. After this change sashiko no longer complains about it.

The module-based reactor support, together with its kselftest, will be 
send as a separate series in a few days.

As a side note, we are looking into using the rv framework for 
functional safety in autonomous driving.  Depending on how internal 
validation progress, there will likely be further changes to the rv 
subsystem in the near future. I'll be glad to discuss them as they come.


--
Best wishes,
Wen





