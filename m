Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C2E3CF02E
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 Oct 2026 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970027; cv=none; b=ALhQTSKVSaDQJAfaw38nthTpGcCxX0pkcpmzxTmkyepisg2kvWEDUC3C/6dfH6YM49QSYckP1eYqxMFJgP//1HnENf6qLmb2drr07Ya7wnC3Oz/FRv3mw6xzWcHU4hc0u2p3KG0IMELSA6dxqxzQM2UllByMGHmxZn4EH6uPACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970027; c=relaxed/simple;
	bh=q9Jv8futSZP0CucxpVKuCHrxO8DXoSYDrcdU23E7Ji0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=CveGtpGQFl0oL0qtJwsoKoBJKLdZ7mj/g4xMl+b0MOge5/URJGvuj6vm73DJ9md5Q3KRkABrkbPnIAAEpS4TbOP/2OmTJ6hlN4arTztNvZtIjNZPm+du54YR0fTeO6HbV3iKJxQHJeqe+6wglJSSnCSC2wrqsQeuYDwrhCw40P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyCFCTFs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyCFCTFs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790970024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9Jv8futSZP0CucxpVKuCHrxO8DXoSYDrcdU23E7Ji0=;
	b=eyCFCTFsDedJpd9SLwjUVJyYdI+/EHFBQiZP3fiv2a1/xp51tG/qB/qIZkuoycO4bfFzHg
	wz35fAdCivfbvHHbd4hwn4oTMxUfar8pHWHCfLPN32clMttPhc2sMkPevVQU+dUY7744aT
	hTC6WpAt3e8ROLjKgyGarJHKJM8E6EY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-gufzOGZpPz-ilNyXrdQLgQ-1; Fri, 02 Oct 2026 15:40:23 -0400
X-MC-Unique: gufzOGZpPz-ilNyXrdQLgQ-1
X-Mimecast-MFC-AGG-ID: gufzOGZpPz-ilNyXrdQLgQ_1790970022
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a166295f1aso1874615e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 02 Oct 2026 12:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970022; x=1791574822;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XdBqw55dqknzAzVoQjTguu9ow2UwUNSdoczNlNrWgao=;
        b=UxIm2pkr5VWkdVDtLp68y1801a0Iymrz1HKoLx/0yztLpdocDSCVq9bBsDTwJ/9kKC
         j2tDsz7wUGcdTBukIad3KQbgF1Wd3s/AMLAhms0L3Ha9edbqSAWsO/YQj+COxdmm8Tj8
         6Xb3jAgLljXsddzcUrZ5ScSBBztOfWg5lYxmsIXPDh7iL1242+cbLBbvsXO8JPZ/hA3p
         Z315X+TcrHpmu+9NDy+nvSgr9qONHVsUdcW2z2ecgmTHJm83A6cqrupobmxKeqFyYBmp
         QgDHG3kS7QpcEKKLCH0qIbTmuFutZMtsRtI4H53fBgLKwmoXg+P72F0EFI0LK4cIYFfM
         cBHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxHIpNnxA9erpR1t37b03Hqj4gpyfnYtTy+LAB78I5xLShtqsm9TqW9GnmkAxMd9exze3Z1fjCGoDTT6XXCu1MqY4=@vger.kernel.org
X-Gm-Message-State: AFuF++nWgYlzjQYuzVISQR4kTpYFjzaB2hfnesu2FYahC6wLfC9dY7sZ
	gCm6jf9suH3PwM/dg4z/CEIDDydP94xT698lDYsewfA6ht7hOlv2de31cmJZuyBpCbAFImBs/9b
	VkiiiuAI7WJml+lWN+4GXAOFcypxLjhPkzCTqX9qHVNOJC4pbQArerGJ0t43HYnNRqthAu+S3Ug
	==
X-Gm-Gg: AYBFou1bABwxTo1xlRl2naMFIvo6x6b/6/Wly7UbnrAorAj3hH6MEP7SL/18Fu4/ghW
	nMTNgQ5h4xUTfe2opR+o3nXYoS4tpcbOMQI54qpImRRr8fBE7GwQcChJy5SjzjDr7uDqpjHgt3T
	U4jbrX+lmakoeYUhLQaNF6U9GHFKeSL6OgqPz1DQi+D2C7FHo3Y5G79Y65YprojKUkic475rSGT
	msd5OygDFznQiO7WcEoIzrsXuKgQ5r5OxtVg2IB8OvyCFn7hfTkvlR9daABy0x0s3CrRwCHw9CC
	HJ6A1KgS2qnN2I0cR3tPhUT9G/8WfESYhdaHw4aCuYy2URoGO7r/pXyBulmeey6I8V1WsNPLcQl
	2HEYF48ofg+qzYFxF7Rr8eMWhOMkGHrb67w==
X-Received: by 2002:a05:600c:c10f:b0:4a0:1fe2:d4c8 with SMTP id 5b1f17b1804b1-4a1680dd3f4mr4347095e9.5.1790970022154;
        Fri, 02 Oct 2026 12:40:22 -0700 (PDT)
X-Received: by 2002:a05:600c:c10f:b0:4a0:1fe2:d4c8 with SMTP id 5b1f17b1804b1-4a1680dd3f4mr4346845e9.5.1790970021765;
        Fri, 02 Oct 2026 12:40:21 -0700 (PDT)
Received: from ehlo.thunderbird.net (mob-5-90-98-35.net.vodafone.it. [5.90.98.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380f0613sm8640050f8f.13.2026.10.02.12.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 12:40:21 -0700 (PDT)
Date: Fri, 02 Oct 2026 19:40:19 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Nam Cao <namcao@linutronix.de>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Wen Yang <wen.yang@linux.dev>,
 Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 01/15] sched: Add task enqueue/dequeue trace points
In-Reply-To: <20261002191842.GA1259248@noisy.programming.kicks-ass.net>
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-2-gmonaco@redhat.com> <20261001154934.GT88198@noisy.programming.kicks-ass.net> <d75888885e2c94c1bc717faa864f609c43db874f.camel@redhat.com> <20261002102939.GB2823843@noisy.programming.kicks-ass.net> <56972260b9221128d7aaf5bb60f90611ec9d7235.camel@redhat.com> <20261002191842.GA1259248@noisy.programming.kicks-ass.net>
Message-ID: <6BEABF91-8CA6-4859-A426-D65F3CC6E13B@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8pNLToDbZt851U_AO4Mw3zwHAsFdSp_OGLOwVFh-ZoQ_1790970022
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 2 ottobre 2026 19:18:42 UTC, Peter Zijlstra <peterz@infradead.org> ha sc=
ritto:
>On Fri, Oct 02, 2026 at 01:55:48PM +0200, Gabriele Monaco wrote:
>> On Fri, 2026-10-02 at 12:29 +0200, Peter Zijlstra wrote:
>> > So mostly I flat out out ignore partial series. It means I have to go
>> > dig around to figure out the whole picture, and anything that requires
>> > extra effort goes on the 'later' pile, and you know where that lives.
>>=20
>> Alright, I guess I'm going to have to fix my to_cmd script.
>>=20
>> > Now, as to 3,4; I'm confused. If I search 'enqueue' I see there is a
>> > tracepoint attach thingy in the .c file, but I don't see the
>> > corresponding bits in the .dot file. And per my understanding the .c
>> > thing is an artifact of the .dot file.
>>=20
>> Yes but only partially. There isn't always a 1-1 mapping with model even=
ts and
>> tracepoints.
>
>So the .c files are no longer an artifact? That seems unfortunate. I
>thought the .dot file was fully descriptive and the .c file was fully
>generated by dot2c.
>
>If we cannot fully express the automaton in .dot, we should look at
>extending the 'format' and teach dot2c new tricks.

The linking between events and tracepoint has always been manual, but yeah,=
 it would be nice to describe the whole thing in the specification.

Though that would require quite a bit of work, deadline and LTL monitors ha=
ve some more complicated mapping.

>
>> Throttle uses handle_sched_enqueue() for one case of dl_defer_arm, repre=
senting
>> a fair task running not boosted, in the enqueue case, because it was run=
ning
>> with another scheduler.
>> Boost uses handle_sched_dequeue() in a similar fashion to describe fair =
tasks
>> that stop running on the fair runqueue (but may continue on another runq=
ueue).
>>=20
>> In both cases I'm reusing an event that can be triggered from other trac=
epoints
>> too, ideally to keep the model simpler.
>>=20
>> Then it uses handle_sched_enqueue() for dl_server_resume[_throttled]. Th=
ey are
>> both plain enqueues, in fact, so I could rename them to show what they a=
re.
>
>I'm not sure I'm following. Will you be in Prague next week?
>

Yes I'll be there. We can definitely discuss this better.

Thanks,
Gabriele



>> > Also, IMO it would be *much* preferred if the .rst file would not exis=
t.
>> > Just have the graph-easy and the description as a comment in the .dot
>> > file. Then you have the whole thing in one *readable* place.
>>=20
>> Well, you make a fair point, I like to have it appear in the html docs, =
but
>> obviously no one is going to build the docs to review a patch.
>> I may look into ways to get both birds with a stone.
>
>So personally I have 0 interest or use for html. Mail is text, code is
>text, we use a text editor (neovim is my current poison of choice).
>Nowhere is there html. So then having to look at rst is just crap. rst
>gets in the way of actually reading the thing. All down-sides, no
>up-sides.
>

