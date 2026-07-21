Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362153101A6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638117; cv=none; b=kstXF0AQnSpVE3nZkAzZvm4r1vANKY8GsbdfKxkPUhLgWlruuk0lfm0bfYYAzy2cl71m6pdauB9g8+f54CFD6IkGjn51uhA8g/uUxSjFPKkkUQuNzZ1aauNx74mLS0k+urjXV0k59AvN+eihdsa69JN8SzrSxFQ6tq5n/HJdmHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638117; c=relaxed/simple;
	bh=+3pPPzkN5vSN5uc06d/jwUE+LQ23KJmEngSIHcTZfSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IXd7yBiSudyEuzzwADz6zHY+K0aIfW6tJp5gHdr0JEi2SjJOvCPBB9yqsuFBH9SWPnZvm58Ipl2JZ/ouNU904veJubqSYOZEdVNdsQEgsHXzF0r63kT4A0l9xpd1Vv5jPayOBKJX4eNQ9Tue3R9r4OTGHJPqUmRkmMCf2NdHlPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyyZpskx; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyyZpskx"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7ec1e9d3359so273416a34.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 05:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638115; x=1785242915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f9BdUyGIX1sBYdd4LfNbX4BHjyUWmMKKhhuvfWpGKTI=;
        b=kyyZpskxRIMFVzDhGWhVTDRIY3ucz1uBiZD5JhdQEBmfQtbVUuZfcpLhDbCnyAKW7r
         xgXNiSB1WFi3ZYQsbrh+SP/P+H4dS6YnluZ+vS3KqOeJcC0msl1TYlMbvZH4W8C20DBg
         ATMnMfrXr/+WBR8YpJ/chFVDDlBSE3Wfnf6hooPPflJ0zXYTOGvQmSdljeYvYYYw0t00
         96SlYwx6DDckhfFKkP8M3wVdu8rT+x+cbnnzud2LQ/QcEf9rxB9YhwEKj5xs/MT8ftmH
         isWba7m8yk68idBUVVFN0IP4Q0/Xtfers/POhHJclHVznig4yLcd/s1yVCbT/Jj46y/W
         LUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638115; x=1785242915;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f9BdUyGIX1sBYdd4LfNbX4BHjyUWmMKKhhuvfWpGKTI=;
        b=G7tYZKi2QnWIA226vvQ/Le5mY0n5/mh1X1ZwwBDmvgd4wMXw0coRO+W+vazO6QEetM
         t3Li/ssowY4F5MSPsLTUK0S4SP2g1JjiIARu9cgb/ddZWPWQ+hsmAvs0pKQHJdPPPpK0
         q1GVTjX7x4+4MOQlbylT4iOWaHzg09v1GGl/mWJNVghbA9+jm8QKASwMRA0Ky495WbQR
         pud5F9alQnsPUOXyJEMSWaBIApTfxzEjlz+ORZXAitWXd6E4lZKfXomRSIGd04wUGhly
         b+sOE5d+0HAxed89f9JLexWxaV6fFfan6OTfbkCAx+sgo6Wb0fNv1RFwMGAkwI/f9lzH
         kC3g==
X-Forwarded-Encrypted: i=1; AHgh+Rpb75iWjlIb+1AhWLChMqXqTWQS1CuRN6DMLpoIiW49YCbdef83eR7eYh9V4NnKySLXV3k3J6Yl8q56h1XywkmkvZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLmEx9KL5uOlQQ3U0GAjuwOoZVE0RyGsqzoNp3Qc6ASs7Gu6e2
	fQWzf44319NPCRx7iuloYXav2VOJUjxQCO3b8P7r1k6oHWZq5KpcvWpm
X-Gm-Gg: AfdE7ckXIFD+PDTlmbPzkLCbbdWSvlKtcjpVJAxOyk+1XnKpcPJFf2RnYgkc1/lX8kW
	mpaT05MTDS0Ld4IykX/0+3whZ9aZG0lYGIjbplCwjiANMoGVtofHuivG49QZ93CJ/QAtljyICFH
	7SK0obu83APzJqQxgNzRlmInDLjaRlRyrqPV0QJIgUT7vkLqcAZDTSICgDryZ/ZJdlyzRbwl8UQ
	1X6vSBxRGsY/AGLKttZdAaVPzRmGXAnDiNSyr3JFrb0f0xdu7GzFeMDZ6YnLGyjUYdnqnG8lCRf
	IkGOzgiYDS4s+NdO6m3+vED9RXPF4dwrzzemNML5RbvP67GkairxK1tMrTmaUuR2IbIQfy6lrFx
	/qGn1gbvM8wpQ5/VcMYDJekR0rF1WfZk6x7i9MkXNjKv4y2hZVnI0GJ/xvOvYi0XUp3Uhyb9McI
	5/KlxTgw==
X-Received: by 2002:a05:6820:f02f:b0:6a1:8cd5:c9d8 with SMTP id 006d021491bc7-6a536ada646mr9327016eaf.68.1784638114876;
        Tue, 21 Jul 2026 05:48:34 -0700 (PDT)
Received: from [198.18.0.1] ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4568e0bddefsm11251568fac.4.2026.07.21.05.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 05:48:34 -0700 (PDT)
Message-ID: <f23b0cf4-840f-4fb0-aab5-750dee42a7b2@gmail.com>
Date: Tue, 21 Jul 2026 08:48:22 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/13] mm/kwatch: dynamic hardware watchpoints for
 hunting memory corruption
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Matthew Wilcox <willy@infradead.org>, Alan Stern
 <stern@rowland.harvard.edu>, Randy Dunlap <rdunlap@infradead.org>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
 <91f3486b-3b85-4b43-b099-0a5325643352@intel.com>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <91f3486b-3b85-4b43-b099-0a5325643352@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/2026 9:41 AM, Dave Hansen wrote:
> On 7/17/26 05:50, Jinchao Wang wrote:
>>  24 files changed, 2115 insertions(+), 63 deletions(-)
> Reading this, I wonder how many kernel debugging features we need. I
> don't even think we have a centralized list of them. They all just live
> in their own silos.
> 
> This one really seems like a super specialized tool. It has to be
> enabled at compile time and specifically aimed at a specific function.
> 
> Maybe this should live off on the side for a while. If folks end up
> actually needing it, they can point their friendly LLM over to its tree.

Thanks, Dave.

I agree that adding another standalone in-kernel debugging facility of
this size is not the right direction.

The motivation was practical. I have encountered several silent memory
corruption bugs for which I wrote similar one-off instrumentation to
identify the writer. KWatch was an attempt to make that technique
reusable instead of rebuilding it for each bug, and to reduce the same
setup cost for other developers facing similar problems.

This approach proved useful for localizing the dummy_hcd corruption:

https://lore.kernel.org/all/20260714064829.172098-1-wangjinchao600@gmail.com/

It identified the copy that overwrote req->complete and recorded the
writer's call stack. So I believe the debugging use case is valid, but
it does not require a separate KWatch implementation.

As discussed in my reply to Masami and Boris, I will stop pursuing the
standalone KWatch series and work with Masami on implementing the
necessary scoped watchpoint features in wprobe/tracing instead.

Thanks,
Jinchao
