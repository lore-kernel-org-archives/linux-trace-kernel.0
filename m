Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378869;
	b=qGuBhkJA6kT3MWAMRTUgbwk/Paof78XWQN27/nIui3lJrKc5XQSovTyMMIpSflDTqlfW
	 O5OY4LHJn/nrojV5yXn7yTlUj6R1kDwSxvBOEVFgA/s4o1yYBEUl7EKAqdcFirsun+IuP
	 TdYwZgA2a+lvx61sSNOz/7EqPE63kERqdop1udO6rZJ25cXbNM7qYqoqZLKqLq2EESOg+
	 7REF366NVhrjgUAbn2oD/yGu4/ESGIhe6OTCKSMcjlLbmGmHyqqXhiKcBXtzrs4P9ObkS
	 WxqEZQ9ta0eC9KSIdjIEke4RW9BjsVfQ1qVjfFJPMUC8UafDvywXla9vb83w6IkKmHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KoXhXnM3oUjZYemCskQWf/r+E20vle0w0i0hVE/eaXs=;
	b=DDeqqS2kfFNZYC6Bdc+nFLindiNezDa0u4368QJZ+T8wPN787iodU/YveIGx2V4Eayv2
	 DWqCmp24J4aG+BgUkm6EcX97sMdp/dZ3kd9EVTQOW1Me1cuDJU2/1X+GKfP2HFHXV+Lrh
	 oJcOt/Eqj0+qiYEtt5WUDwOYb6yflcDW8NZGRJ9vJsCi9q0sgMB32ToslEzp+2OcbKCkx
	 DAcjARKWTNftLoUjhSHZDEfjyhL3iCsS/1v50tD6QOSwF0lQivmKESOOEc+S2E2V87Zuk
	 ojxcDESs68Ka3YaCBvHXq1L1VwleQx/DUD9AN2zESUj53IHGgNebQSXqT2WB1tAvMUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Aiko/QHp";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C8606A31D
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Nov 2026 20:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E54C8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aiko/QHp
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso26035845e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Nov 2026 12:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795378867; x=1795983667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KoXhXnM3oUjZYemCskQWf/r+E20vle0w0i0hVE/eaXs=;
        b=Aiko/QHpxS4m+8HRxXBSv5+ixx06RuTCPhMu4FgAhsd94YdYr+nyapSE+UdjBEyQDX
         aFhMRUB6psPuLOJcrI6+rwr7lOWuSVpFW3qDdkr/dzfmJ9imzuedEJ398ConmVuXFwVA
         Z6WsFP2ooogDcTrARJ6/mGNpR746L/52C2OD8qmO7H8dW1fbp8oV6AdSmVXV3BYsomDU
         vad0Lv8VSl9s6j1c8CLaJFyW7TC55nAIzu4wZphZhEsFL4YkzOh3EWywDQ1NaJUuIGEm
         68MFJujoTgXIXv3zPKYfyqdgLaE+WnSn+G0+s2qnVFHHt92q34NMz3/nLB86jorPq5LC
         32VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378867; x=1795983667;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoXhXnM3oUjZYemCskQWf/r+E20vle0w0i0hVE/eaXs=;
        b=eR9qKzPlXPdjPLDEZWV8eM04pOYxOmPUnifLi/jahm5ULjhm4zIdp7OKODIlXLRZxu
         MnQ9BpUTY3xGWXosJ2VQ/Afh4O9CKLmDmmDc0LdKahxz8tDfuVNHrtGy2S0uCYGnrkV2
         WdpGXYY49NNEXNe8LdCxo19sYnHoBuboBcaMwzmkAEZe3NrwY+Yt18px5zWqu2s+n5v9
         YPoR3VZ6h5j5jB6UXmq+cEwYq01triRMtbJ2R1gvCTg79dSqXKtvBtMPzve18mQXAe0O
         YDWTLSFhk9khzffWj/h72iOX32nvE+RBNjhmObQI0f5W3zfEklS7juX3PheHfWjhMWL6
         SUBw==
X-Forwarded-Encrypted: i=1; AL+hErEeYP4yQXVlxKq2YX4R3JwA+e9fWY1saCoXy5Ce0cou/rfjvJrZd2MQvpGDp1lB3ecy3UfGE55jbLJjTBY/+j/MuE4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8R8FwdM1rCNi0+X7RulAKflYIZjbJfQaWz4Tye1lJpuK6Bs+n6
	OqDIrro6V7DKVHLzzDWfbmp3/4BDrXPKFWwqAfEsqsSmrBOQCt7LQ5mh
X-Gm-Gg: AZFdTZeo4SKPp1zGeS6gwZu9vvheNBLGSz93xbZ1r2utY1ZFJZ0/TeFJCp7h7u+VC95
	slmZb8J0f69W2OLLHv4E/IhE7QhmTUi6EDfxxdNl9FRMu1PMv2Rd4kw2icULKjoeAdGIuQ9xt5O
	3m9S2yWy8VOeJKR2AjYHE2O+MOc71o0PVfL21Dup5gUiwQae80iFlaOzebL4k4lbj8AodS91wHc
	6QXCiH9NII43joah75+gOEIxSIH/ze3q00B/OXFSIeHeQrAIwiGgZjyeOCgzIqIu+lf6vdSs9VJ
	7cFvEqjy/coHm0lGONMKzCwrhTh+KQ56zYa+atZpZZ2r4dvg2GAM80wWCsG8zsXsAaPBXqKmX5v
	bSB9QKLHxdBj7mVo4dL8cGzK10RDsQofZk0Lyd2ESs2QcFC9TLLpJNEekzG9Dh912/n/FWWwnmg
	H+qZdghk23m9jJWVa8/sxSkKp+7sPa4dbKnkEOLi6WCSofYgs2bB/QGtihZL+PnpJCVc9xsrE2I
	QgDB7zFV+rDd5QNLWG3w3wATezCNMsGDuvnWmIXIvxvGeRfSA15wII6G9x6emgH0Ckxiolp3KbW
	5PqFNU/EaC89S0hGpEpCW86yCCDwPI+9AQeX5wu0pLj1YDXpvQQhOH28GkDxMvL3fQl+Ffnndyv
	uh/FpEy3W3KUS5ybtkKlgQvfOid7RWciZqdS+WTVUddleDjun+V47vOQLnUI00kpOspM/BgxhEw
	Zv0ZCBJH8AiqiGGQjnEoIaG3gqQhxQ+w==
X-Received: by 2002:a05:600c:4f07:b0:4bb:5dbf:af06 with SMTP id 5b1f17b1804b1-4bb88804d58mr235773315e9.9.1795378867083;
        Sun, 22 Nov 2026 12:21:07 -0800 (PST)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a14a-2801-2d6d-9df0-1f3c-62cb.310.pool.telefonica.de. [2a02:3100:a14a:2801:2d6d:9df0:1f3c:62cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm381533945e9.0.2026.11.22.12.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:21:06 -0800 (PST)
Date: Sun, 22 Nov 2026 21:21:03 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Thomas Gleixner <tglx@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Wen Yang <wen.yang@linux.dev>, 
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 9/9] rv: Test IRQ-exit softirq provenance and
 handoff
Message-ID: <awNNrVvXCFVPhgk_@gmail.com>
References: <20261107171252.25090-1-kmehltretter@gmail.com>
 <20261107171252.25090-10-kmehltretter@gmail.com>
 <e8b9a9afb9587ed1f41c0fafd486ec9be82928db.camel@redhat.com>
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
In-Reply-To: <e8b9a9afb9587ed1f41c0fafd486ec9be82928db.camel@redhat.com>

On Sat, Nov 21, 2026 at 03:01:13PM +0100, Gabriele Monaco wrote:
> On Sat, 2026-11-07 at 18:12 +0100, Karl Mehltretter wrote:
> > On PREEMPT_RT, verify that worker events do not report hardirq provenance.
> > Do not run the synthetic inline IRQ-exit cases there. IRQ exit defers
> > softirqs to workers, and serving-softirq state is task-local rather than
> > encoded solely in preempt_count().
> > 
> > Snapshot reaction counts inside synthetic IRQ-disabled and hardirq
> > intervals, then evaluate the KUnit expectations after restoring normal task
> > context.
> > 
> > Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> 
> I still couldn't read the KUnit tests, but from what I get quickly scanning
> these, it's massive. A total of almost 3k lines of KUnit tests for 2 simple
> models is probably a bit much.

Agreed. I'll cut the KUnit tests down to a much smaller set focused on
the monitor transitions.

> 
> Keep in mind you are testing your unit, which is an RV monitor, so you may want
> to stress transitions, mess around with the environment as little as you can
> (e.g. disable interrupts) and use mocks/stubs where you can. It isn't always
> easy, but the fact you're touching softirq.c doesn't look right. Your
> unit isn't the softirq machinery, you should interact with it as least as
> possible.

Makes sense. I'll drop the test hooks from softirq.c and simulate the
events instead.

I'll address your comments on the other patches as well.

Thanks,  
Karl
