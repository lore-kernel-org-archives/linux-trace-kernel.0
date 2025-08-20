Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3400021CC4F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755667214; cv=none; b=DEhC6xtKj1fdwHdS8VzpSWU+EN/cuGyOhsa+S5ckBw57GgRBdR5016g4INEWAXOal62sGGCC5K/IGV+oWAWbdytnAwLWtwTFbkhFI2exKEH6C0yFdh644fqm45fuOtWeJqUkIMCSogHpctuci2UAzOe4S9cDFR0vgrr9mBm/uq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755667214; c=relaxed/simple;
	bh=8L6xU9g5KoJQAjxkNUL9KSZwhdgL58+kV/17rMqhyes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HPd+qyckIBKEQt4qFAYC4zoml0XgGp4KxH666Fmt0wtXJBUICNmgm2GeL59+VkLT64RuHssA9Z18vwlVCRUez2SBdqwul9LZF2GJxFZJiNKonEIxgFLEUYvu+v1BqUekApcBc78bylJufzAN/msJI2Nhf/krDqGqz578cSkM/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSr3zKHE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSr3zKHE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755667210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Ah9GxSMPJfdjLyXj5m0xcjCzjb8lydcS1ejzqq61Uk=;
	b=aSr3zKHESDPs44jMb1rVOtsDb1SIlIGyqGW509aBQSCWAtERUKVJkIs4JPiiyZiQ9VIy6e
	nrj9t6sW3aI9jsyIlb1dD6OvLlFuNKhsPM1xBT28RMk7dAwz2EZgPQcPq5v5o/OXozJK5I
	sm75/SiAP6bbITrZext4rITXEGUhuEc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-q0NRqZcONuC78ON2k9euEA-1; Wed, 20 Aug 2025 01:20:08 -0400
X-MC-Unique: q0NRqZcONuC78ON2k9euEA-1
X-Mimecast-MFC-AGG-ID: q0NRqZcONuC78ON2k9euEA_1755667208
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7ea00b65addso25929885a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755667208; x=1756272008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ah9GxSMPJfdjLyXj5m0xcjCzjb8lydcS1ejzqq61Uk=;
        b=LUe5r9Z4tT0j0Px0D6TrpfoC69xvNkMZ3f3W4hK9ZFhkz5MQhwOoNEFzMcdgU7dcsl
         702qQiwP3+nWJKaJidnfxHr4UqpM3lPw0ZXXI7eeD9aJMpQ0ZSjytgKgIRZKHU3dC6gr
         zeRflWyz6ojq6Ob0JWvoBKHdke+9adnMzr/99/kao3pWn+qQ086TdFHx24vNFbEwzyd3
         gKhY99qFrXDTkRD+2v5yQ0GaeFnCH+vzzLP/Wr7XjrVHY2pPZT8XUEsswBX/7hDOM1oT
         Z1qPSSH7YtwkqUg5Q42WFnzHOsvHQZaMBVEaNmv3bxDUB2YikxK2MUFH7At9rAGXaAxX
         4RpA==
X-Forwarded-Encrypted: i=1; AJvYcCVp4aPX4Q7i+oA36zl+6ade1jwlhAQ4fUHHZbdZ9dkaAdxxTd2FFmuktQwqi6s+SVxEAEkP3CqeB08sdpKXpy07HuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySXf9blpy8+AKxzYR5iSiBcDUMh1reRSR6tO9L6yXL9PCUBLL7
	Tz6zFj5wBQ1iMcAd8nZPO2ymIFOkDTiWmeV9A+IvhdfPerpLKOUjy62Y4dS7hm2fVxbOZSbdOMp
	/Mp3vjiRpj04mJrJU0h7p98wDgIPPxr4pNG4+ygLVnYZq6cO7u92w6ogtCOkEz8Iil3cRZxqO/g
	==
X-Gm-Gg: ASbGnctD1fOmRwXysNWT6Qq3zMKj3oyc5PIeVb6CUM80dfu0lO6Xo6tp/8YK2ssXrb5
	BTrv2Nbv8o3Nb/IMNMN69luUAgHKGvQUwbL7AUy7R/0yaynStSUSmJBwnMsc/xwU7623Zizei/B
	eqF8J6a25D4W6Ho4zEJg/NO61gcuUT1jqWQ3/T//Tan6oiEY0t3rTC9zC9kQWgDRk8b0JIXkOHj
	yJC8N6YJEGQqS3BzptEKHAksKK4xV4lSoZwCuO0HiZvQljZmB53FNDraNoh9RUqKKFIpA631RXr
	DbTSUexle2g+jtwgsFxhJ4Gv9s9c6fp6WNGoZBHb4np5NQjspfDA1/poSB4ujA9KdPtr
X-Received: by 2002:a05:620a:4410:b0:7e8:2998:51e9 with SMTP id af79cd13be357-7e9fcaaa54dmr177400585a.32.1755667208008;
        Tue, 19 Aug 2025 22:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHENpttOb5Oa0vbXSaecXzwbSoqFX74Eh9EpBV66q/UJJaR/79Mf7XF8zMF+IdE6uYsCj3gJw==
X-Received: by 2002:a05:620a:4410:b0:7e8:2998:51e9 with SMTP id af79cd13be357-7e9fcaaa54dmr177399385a.32.1755667207630;
        Tue, 19 Aug 2025 22:20:07 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.50.80])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e0224c1sm900340285a.6.2025.08.19.22.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 22:20:06 -0700 (PDT)
Date: Wed, 20 Aug 2025 07:20:02 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Phil Auld <pauld@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, linux-trace-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [RFC PATCH 14/17] sched: Add deadline tracepoints
Message-ID: <aKVbAnkKnvQ2OyUA@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
 <20250814150809.140739-15-gmonaco@redhat.com>
 <aKRKaTJBxD3kdt_G@jlelli-thinkpadt14gen4.remote.csb>
 <20250819101244.GF4067720@noisy.programming.kicks-ass.net>
 <711ff45f008bb4943418c40eba604e83858767ff.camel@redhat.com>
 <aKSD3Pm_9qqmEaNv@jlelli-thinkpadt14gen4.remote.csb>
 <20250819143823.GB282929@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250819143823.GB282929@pauld.westford.csb>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Pzci2agvr_qoYSHuQZ6xb8VfixHEGtIIwWAIk7o9Qps_1755667208
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 19/08/25 10:38, Phil Auld wrote:

...

> A few of us use: https://github.com/qais-yousef/sched_tp.git
> 
> This has all the current scheduler raw tps exposed, I believe, but would
> need updates for these new ones, of course. 
> 
> I have a gitlab fork with our perf team uses to get at the ones they use
> (mostly the nr_running ones to make their heat maps).

Ah, cool. Didn't know about this, thanks for sharing! I'll take a look.

Best,
Juri

