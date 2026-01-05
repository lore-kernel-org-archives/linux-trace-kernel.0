Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D843A1E97;
	Mon,  5 Jan 2026 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767637299; cv=none; b=S6EO0ZHNhrA6bfVvIXCGVzcOpNAGH2FLS/FaFoWgUnuwR3KTs5bYMa3DXOTTL57PDfVSFS2WKRa8pe+XU6I3n+T6eXiqTrbpuwDBXV6NBIbhWM3fdus51VIzfBPOEmh8nkj1gZXl4pXMvD2JmwOTLugAk602J9XvmaNn31EP82I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767637299; c=relaxed/simple;
	bh=LzC/4MIXgJ+/fSz8j0wORC98LSPXcdunvtYupg9ResM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tC24T5AY5vvrQu+L2NKHGxmQaCUn10SRIQMO267NdZ11fsUhKHfzs9uPKgoUhxX/lrNUtCZnv0SdhG3HMoLpoB2RdooP6h742bvDnQbufhgn/P9Lw4Oov1dJGAfPswyxMxXilpDxy4efew15emw7C+hLbTTX+e6vs3FU916QqZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWD8g/Eu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWD8g/Eu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2910C116D0;
	Mon,  5 Jan 2026 18:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767637299;
	bh=LzC/4MIXgJ+/fSz8j0wORC98LSPXcdunvtYupg9ResM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oWD8g/EuogOjyE6K9wMAs+2YaZk/nPnAE2no167iPpVDel6JtYbBymaAozb/3WqA7
	 NyifLWoHmuGsDo1m2wGDnSQhTUFCaXXyPzL1569ljXqANGUhAXEzY1oF6SoaFPyjG1
	 kuvt+IIMdGagh3HPqhnau2MglK/TmYfeH0O9X8xrESGlpsJG24nZ28L8q6Od6jrobB
	 mCyrOFphX4TM9rBV6a8MNHcP+V4V8VBeY6cw1Agv44qB+cVMzlEYFmL/1lOeC4GHa6
	 4ZqTOprmtXSS+KSQgsxmX3vDf3qs8U4LUI2zoYC395JOxAwruOi+261/rMzZoXGAxu
	 lbyrfQW/XulQw==
Message-ID: <63a00906-a5c6-43de-82ce-328c8eaa7d3f@kernel.org>
Date: Mon, 5 Jan 2026 19:21:20 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
To: Joel Fernandes <joelagnelf@nvidia.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Yury Norov <yury.norov@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 David Laight <david.laight@runbox.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Andi Shyti <andi.shyti@kernel.org>, Vivi Rodrigo <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Daniel Gomez <da.gomez@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
 <20251225170930.1151781-8-yury.norov@gmail.com>
 <20251226115848.298465d4@gandalf.local.home>
 <20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
 <20251229111748.3ba66311@gandalf.local.home>
 <20260103005059.GA11015@joelbox2> <aVkSVk2L6VH9MYGz@smile.fi.intel.com>
 <937926D0-00DC-499B-9FD8-D921C903882D@nvidia.com>
 <aVmyZ0iXzTkNU86y@smile.fi.intel.com>
 <20260105113902.6bdfcfa8@gandalf.local.home>
 <d642ef4c-145c-4b16-818d-153c8f2e3485@nvidia.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <d642ef4c-145c-4b16-818d-153c8f2e3485@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/01/2026 à 18:11, Joel Fernandes a écrit :
> 
> 
> On 1/5/2026 11:39 AM, Steven Rostedt wrote:
>> On Sun, 4 Jan 2026 02:20:55 +0200
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>
>>>>
>>>> I do not think it is necessary to move it.
>>>
>>> I'm not talking about move, I'm talking about the C 101 thingy. Any custom API
>>> should be included before use, otherwise compiler won't see it. Which header do
>>> you want to include to have this API being provided? Note, it's really bad
>>> situation right now with the header to be included implicitly via non-obvious
>>> or obscure path. The discussion moved as far as I see it towards the finding a
>>> good place for the trace_printk.h.
>>
>> It's not a normal API. It's for debugging the kernel. Thus it should be
>> available everywhere without having to add a header. Hence, the best place
>> to include trace_printk.h, is in kernel.h.
>>
>> I'm thinking that my proposed config option is the best solution now. For
>> those that do not care about debugging the kernel, you enable the
>> "HIDE_TRACE_PRINTK" config so that your builds will be "quicker". But for
>> everyone else, it will not slow down their workflow when they need to debug
>> code.
> 
> 100% agree. We do have people running custom configs for faster builds, so this
> hide thing could be enabled there assuming those don't care about debug.
> 
> In other words, "If it aint broke, don't fix it".

But if I understand correctly, it would save 2% build time. That means 
12 secondes on a 10 minutes build. Is it really worth it ?

Christophe
