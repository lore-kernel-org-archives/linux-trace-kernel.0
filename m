Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FFB14F65
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="reALlG5T"
Received: from out-197.mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4386F94
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Oct 2023 01:14:09 -0700 (PDT)
Message-ID: <508b33f7-3dc0-4536-21f6-4a5e7ade2b5c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1696839245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+Qv4mm4LfFHvIi8wP7qIt9+6u91CDBoXpMXVpFXU9E=;
	b=reALlG5TnFKsumjcpqldLudAXAQgvY+Wrj9WQqyM/WC5hwXbSczKE0OnKNCpzd7x9qltXi
	XuhawL1h2RzrmHgPEFeArKJUMFD8DeJnj8qCDpEeialpgVCmY8GIVI7yYTDGbf6JpuJsjB
	R42q6s1hVFZ2uQMxL2EwAdno4501v6Y=
Date: Mon, 9 Oct 2023 16:13:54 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v7] net/core: Introduce netdev_core_stats_inc()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, dennis@kernel.org,
 tj@kernel.org, cl@linux.com, mark.rutland@arm.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231007050621.1706331-1-yajun.deng@linux.dev>
 <CANn89iL-zUw1FqjYRSC7BGB0hfQ5uKpJzUba3YFd--c=GdOoGg@mail.gmail.com>
 <917708b5-cb86-f233-e878-9233c4e6c707@linux.dev>
 <CANn89i+navyRe8-AV=ehM3qFce2hmnOEKBqvK5Xnev7KTaS5Lg@mail.gmail.com>
 <a53a3ff6-8c66-07c4-0163-e582d88843dd@linux.dev>
 <CANn89i+u5dXdYm_0_LwhXg5Nw+gHXx+nPUmbYhvT=k9P4+9JRQ@mail.gmail.com>
 <9f4fb613-d63f-9b86-fe92-11bf4dfb7275@linux.dev>
 <CANn89iK7bvQtGD=p+fHaWiiaNn=u8vWrt0YQ26pGQY=kZTdfJw@mail.gmail.com>
 <4a747fda-2bb9-4231-66d6-31306184eec2@linux.dev>
 <814b5598-5284-9558-8f56-12a6f7a67187@linux.dev>
 <CANn89iJCTgWTu0mzwj-8_-HiWm4uErY=VASDHoYaod9Nq-ayPA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <CANn89iJCTgWTu0mzwj-8_-HiWm4uErY=VASDHoYaod9Nq-ayPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 2023/10/9 15:53, Eric Dumazet wrote:
> On Mon, Oct 9, 2023 at 5:07 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>
>> 'this_cpu_read + this_cpu_write' and 'pr_info + this_cpu_inc' will make
>> the trace work well.
>>
>> They all have 'pop' instructions in them. This may be the key to making
>> the trace work well.
>>
>> Hi all,
>>
>> I need your help on percpu and ftrace.
>>
> I do not think you made sure netdev_core_stats_inc() was never inlined.
>
> Adding more code in it is simply changing how the compiler decides to
> inline or not.


Yes, you are right. It needs to add the 'noinline' prefix. The 
disassembly code will have 'pop'

instruction.

Thanks.

