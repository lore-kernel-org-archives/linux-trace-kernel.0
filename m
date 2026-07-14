Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC03C98B7;
	Tue, 14 Jul 2026 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052117; cv=none; b=GMQ4xuGBbR45fH6o+Io626z97eFwy8DeXRoyMzPnOMUn+8L8y5ImuQY7mk+SltlCU6xG+B6IlgVAFlJR2/UZ25l+61rR5eoGV/RdQnESXJe7Fo2ygj2GFHOsIw+Aon3iEheT0roMPnjLWtmhazbV1ysQRZg7FbjimyN+jPr9Vt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052117; c=relaxed/simple;
	bh=xkjX8qo3E9of5WLit1IeJc8651oVXI7xm236sCwR/g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsMe8hHqC2eCNzI3p0BrEawugX+STftkSM86w1IEXO775+7Q1HivKQvhsauhENvCD450+LEXPbTCD7ZFzJ0dqf6FjC58f5/mNl09tYzWx7dDpudsl/8RPTj66fNT0jMCB9TdreRnUSrX8YjmQBWpf2mFr031hLmQAhTktENfYYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a1g4VmqO; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a1g4VmqO"
Message-ID: <6b232d66-703b-4fe6-bf0c-4f0eeff4b4a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784052113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EeaIaxPumDCLqlokMHPP5/8qPRTIhK0Gm9K17Gxt+7s=;
	b=a1g4VmqOy5OrdyTEwgLoRcnsEj+f+8dGazDoZGksGILFitwYcRpxJO19NL5FV3TYFNt/Uj
	DI/rmh4BXkqvMeMdI1J04DO+yfXp4VftvClsXgpGTmZNFQyO7Ackzw6dHV2GenvrHCSHq1
	GicU9E17PAtA7YouDvhG/HH/IatUjc4=
Date: Wed, 15 Jul 2026 02:01:43 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 04/17] tools/rv: Add selftests
To: Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-5-gmonaco@redhat.com>
 <0c230c01-77c8-4c9e-9f49-ecb9555402cf@linux.dev>
 <01b025c43dda6efe97646162e61002fdf5fff0e3.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <01b025c43dda6efe97646162e61002fdf5fff0e3.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/29/26 14:51, Gabriele Monaco wrote:
> Please cut down the context a bit more next time, it makes it much
> easier to find your review.
> 
> On Mon, 2026-06-29 at 01:10 +0800, Wen Yang wrote:
>> On 6/25/26 20:14, Gabriele Monaco wrote:
>>> +	eval "$TIMEOUT" "$command" &> check_output.$$ &
>>> +	bgpid=$!
>>> +	pid=$(pgrep -f "${command%%[|;&>]*}" | tail -n1)
>>
>> The pgrep runs may immediately after the background fork, before the
>> child process has had time to exec.
> 
> Yeah I'm aware of this but kind of ignored it for now and never seen it
> making troubles in practice..
> 
> I could add some delay waiting for the task like:
> 
>    while [ -z "$pid" ]; do
>      sleep .5
>      pid=$(pgrep -f "${command%%[|;&>]*}" | tail -n1)
>    done
> 
> With probably a maximum of some N retrials in case the task never
> started or we messed up the pattern.
> That may still race in case the command exits before we pgrep it, but in
> practice that shouldn't be a problem in our tests.
> 
> Any better idea? We cannot really rely on the shell's $! because command
> is using a combination of eval+timer and we'd get the wrong pid.
> 

- Since $bgpid is the timeout process, its direct child is exactly the
    command we want. Using pgrep -P $bgpid avoids the fragile pattern
    matching of pgrep -f and won't accidentally match unrelated
    processes with a similar command string, eg:

      for i in $(seq 10); do
          pid=$(pgrep -P "$bgpid" | head -1)
          [ -n "$pid" ] && break
          sleep 0.5
      done

    Note: a bounded retry loop may be necessary; without an upper limit 
the loop hangs indefinitely if the command fails to exec.

- For the verbose test specifically ("my pid is $pid"), the pid already
    appears in rv's own output. An alternative is to match it with a
    numeric pattern instead:

      "my pid is [0-9]\+"

    This sidesteps the race entirely for that test case.

--
Best wishes,
Wen



