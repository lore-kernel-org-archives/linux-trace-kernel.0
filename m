Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634645;
	b=OeKlftGYRAvJ6S2LbeGYXtcjaRuYdYAqGVlxV3uxTviRjUJSZZRj51/iW126lPvTyiiv
	 MSfiw+0L+EcY7lhnaJUGSsgNaUWmgNfcnOr3Ezeavn85/ivRHxUwuhINVr6yycsy2aCkA
	 +0qnpqDXqV+B4r+vKdEUGKnMnBmiPeXHgKLnmEEsJxt/feYmCPU5HoNx3hK+I57mmY2PC
	 BzF6alCxLnUkW0psGcCjeF6qFbkf/QaslyPdZcSGa7lyWiISb2XsaNAoJEKwL5ETElm+d
	 gTtvsFlkTHoEJ0Oi3qWEhzLLtXfKlGSnS/HMOtL7WCsLpA8YnFQpjvaKRPzh8eVuwJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=3W56owSBc9jDVBiGRn0n4U9fWiaOv59zmbpdMIKAQa0=;
	b=3mFItgpgeVILUYneX3Mb/CHzxNEvtFSi4sfGsBUEv9qwqRgmo83gSf5Slk9wlXMOy/rI
	 QVFIebtSXIY7Kr350iKRFI8XZsms1h0QRKDi0QyLGn8+QDlV+9EPz+MPhGYIzMdRPAGl5
	 h0EdbVBB/fSnEo9AFYW44CjLkhMY7NY/GeYuEqof3CyBS5iLoQlEP2ymWXoGR2x1PHBfm
	 BXAY8QGyJGX+d+reXpfHD1JL0004BqAIYtfEkJtHfY3jIp+XqHEmA6cru9tGVOuw+mbmR
	 KdjbY3ue6YWk9gxkmB8SYChE82iWW4Ag9pefmtNBuKWos6C+MyXbjMGyvYZEv1QsaGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sz+yewe6;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C14F606A329
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 19:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C14F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sz+yewe6
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so79953405e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 11:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795634643; x=1796239443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3W56owSBc9jDVBiGRn0n4U9fWiaOv59zmbpdMIKAQa0=;
        b=Sz+yewe6SyziGzAEKzOt5nMHv1H1Lj+Z0HDc2vJdMO+FHM4t3rSpipfVL8UM/QdD1x
         kBqA6Sdceo9aY62Jz/SuRl/Sttghu54EXFh8TNr6KSOQUVZTh2wpfqmAHftQV5qzyz3c
         ng9iz9IiznD9HXqDB/XigbFclvpxfzMmANNPRPBx5HL50hiAQY9hLcZXA4ZSjDhUDWpm
         sW8W6jVnTTMruYiVqumEG6i4Qok05GVUWo4qF0BzASRNS//sy5CeJj/3OcErjwTsza3s
         HzmUq+ancqiboahacBkg6mvsCPqhwXY1muu1KxXEGCSsID6NvMmcVVaenkS2TPTxc9ju
         TWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795634643; x=1796239443;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3W56owSBc9jDVBiGRn0n4U9fWiaOv59zmbpdMIKAQa0=;
        b=ajk5fRr3FEDHh5qb0jt0van7bxFxavbZZZ0Yg0Bomz30EHvrhhFbygjBIcs2PZPZWn
         RYN1/umcjp5RKS+pC63UXunAlOQbtSAPvhznKIrInDreOj7LiVPKJD+841GT9MGPJGUi
         3nKf9wU4WTZPYfr82r2/+NDd7c16QBks8gpv5AxwnzPjsSNHTQjwLAElv8dAPrTl50az
         dFVfa4H+3bxi84xmD+rcO6MXJ8bkj8ZM0pUyOfNlkXzVaCxuUt61hBFLxTnw4EBPdWg0
         +neTuhCkv5i1SYnzM+Jew4X9F1/gWSB48kM1uDVxIYG1K+sd0LHne6+K2R3M1C4BmQk+
         q7JA==
X-Forwarded-Encrypted: i=1; AL+hErGWvguXaltWs+kGbrrccTt7NfcIwGsYbPgFNU31wUVFJzOT0BT8h9egl37fLB/aqqgu1Z3nQn3b0pUd6gLfDftIafA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8A3vGPjhNpzcpUcSbLnrUUJtbfI14f4z1vCEhj7hDjHl6fJwb0
	h5TszjvaL7QWST5So7YH2B80f+pgJOK2YUD8gRT+1AeC249jBD/2HTHm
X-Gm-Gg: AZFdTZfjnFgQFq4kjubm54df7Ow7S14HiJdXg1AsYBtPy0wGpG0ckJdk6+E0Zg81cw6
	PjkUh4ORcq0yg7SqocXwpR3PgeqjeLiiHJsvho32xf503aPJonG7MIe67klaCZpnEZE+hwOKtag
	aGs1ODGDCCVBpYzEkMWsGmb0n44DrTqtZWRxiNry2Utv52f1uOqTIwRTYiZTwNXwCEzmSej1DOP
	qPNnMex7MoXb0yMO5BYKh8HT0ACOlXLZ3RsxosrY1XsbhPKhGhSI/BMgVKOvzxqgUCQY5BwLc+e
	AODwX9FQPBTqHp0FiMPGbb8fmdMmoNZ5pzclC28s7vatx7WlmPqwl6I9EtvP2FbkHoQzBcWopib
	ERWeLxpo4FnKO/gQIbhwIFr/ZTfxDm5s0D5Vq0Cuw31OSWucn8SF6baLx00RfYfANmmPaOMuFvD
	FNbTyBMM3NTCQ+EMTMkqGyMcA8mURJu7PdDHg9mEQk+DS82nWuAmmlvNrMa05au+zpe3TicgaGy
	X2NImiISSO/l+QLXcV6wYpeIG+PthCTbyetoiGfxMk5gsCK1aLrtxqcLqjQJY8ifVG91HJ6MQs3
	0Cn+S1G+B7IAQWyyrOZ/z47CjGYTUi/rXzyX0mT/WDULVRJXJDCcIQ7auCtiLT3uyfRKFtOI4P5
	/YggVhdbromvt1qE+EWKFsF0fqBHMzE3b2qCehuZwBnTeIl1Br+YwOPoWWoqkHeVsqQH0zC7UJm
	89wkYgQg==
X-Received: by 2002:a05:600c:5901:b0:4bb:5e8a:7c9c with SMTP id 5b1f17b1804b1-4bb861467c8mr329102905e9.7.1795634643163;
        Wed, 25 Nov 2026 11:24:03 -0800 (PST)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-095-114-079-170.95.114.pool.telefonica.de. [95.114.79.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4abbd84e661sm34180072f8f.18.2026.11.25.11.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:24:02 -0800 (PST)
Date: Wed, 25 Nov 2026 20:23:30 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Hongyan Xia <hongyan.xia@transsion.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] sched/preempt: Check preempt counts in notrace
 helpers
Message-ID: <awcwI1imHpWk8QFE@gmail.com>
References: <cover.1794814699.git.kmehltretter@gmail.com>
 <446e2bd042ce071da52ea80f577fe43c1b3dc031.1794814699.git.kmehltretter@gmail.com>
 <c9b1e3a8-bb25-4808-bcf0-f2d5ba72a58f@transsion.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9b1e3a8-bb25-4808-bcf0-f2d5ba72a58f@transsion.com>

On Wed, Nov 25, 2026 at 01:26:28PM +0100, Hongyan Xia wrote:
> > CONFIG_DEBUG_PREEMPT enabled. They therefore skip the bounds checks
> > which ordinary preemption operations provide.
> 
> Nit: Somehow my brain cannot parse 'bounds checks' before reading the 
> whole patch. Hopefully it's just me.

I'll reword that to 'underflow and near-overflow checks'.

> >   #define preempt_check_resched() do { } while (0)
> 
> No need for this hunk as you are in !CONFIG_PREEMPTION without any 
> checks anyway, but for symmetry I guess it doesn't hurt.
> 
> But if you decide to keep this change, then we can always use your new 
> macros and remove __preempt_count_{inc/dec}(). They no longer have any 
> users anyway?

Agreed, I'll remove those two macros.

> > +CFLAGS_core.o += -DDISABLE_BRANCH_PROFILING
> > +endif
> >   CFLAGS_build_policy.o += -DDISABLE_BRANCH_PROFILING
> >   CFLAGS_build_utility.o += -DDISABLE_BRANCH_PROFILING
> >   endif
> 
> This exclusion looks massive for a whole core.c file. When someone 
> profiles branches, does he or she really care about branch statistics in 
> DEBUG_LOCKS_WARN_ON()? Can we just switch to unlikely_notrace() in that 
> macro globally?

unlikely_notrace() does not solve the PROFILE_ALL_BRANCHES case, which
instruments if statements directly, including those in the notrace
helpers.

I will follow Steven's suggestion and make the Branch Profiling choice
depend on !DEBUG_PREEMPT instead.

Thanks,
Karl
