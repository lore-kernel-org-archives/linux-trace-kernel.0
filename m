Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401C92D0628
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204446; cv=none; b=V+rHFC83drcZtlH4EeD5n2njROkYs8XxoFGn5eom0E5aT5qHyH/LhriEFntg3CSg2/n6e/MDP93MRRjHovWWP1JdVfdH241kAAO/P2d8k5ktWs3lLF/1fD7GIPT8bKNd1f+OZyj41iPB9w22bAkbK9ZXJEai2ZHlbSfuMYn7RKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204446; c=relaxed/simple;
	bh=8/5K9eAYciCjEruM5Zibg8pGJ3jERfSSQATfRjIM+9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ab5KHG5IxGUJFCYwvOA2B+oWIoEpMK6MJRlnqprDF32i7G9t9FY9UT1/vF2gNq98BZZGyHFLIokXp+syuD7FEv0WwbTJEmJ3+J6vL79kzxhthoewJMAChhQVgX57V5D1Z2mQq+xPrF/8TWYPpgjmcX7sroROJSPVs9lp++uRLRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AP2ETYMi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AP2ETYMi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761204442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DG8PNGqN9vkrYVCbE8yOrVABvVSKGUm+P1uN2AY5Umo=;
	b=AP2ETYMi6RIDYMQQdOWd9eeueBb80CgVSzmdOLRDCoSvbowqcemJ1BBFEzP9lu4W2lCLAW
	V8veTukddsNkI3Z5JLQDiUYoLAe+yAiooTdoVSVrP8TGbePSua5swLcDQ+PQJA1TPyYIIY
	yiRsRCPiYwSp9CtSS6U9Db38P0CgSC8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-5FTlNuUPPbqKen9DqGbxuA-1; Thu, 23 Oct 2025 03:27:21 -0400
X-MC-Unique: 5FTlNuUPPbqKen9DqGbxuA-1
X-Mimecast-MFC-AGG-ID: 5FTlNuUPPbqKen9DqGbxuA_1761204440
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b6d546f68a0so27512766b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761204439; x=1761809239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DG8PNGqN9vkrYVCbE8yOrVABvVSKGUm+P1uN2AY5Umo=;
        b=TavUPlG/uFFCeCunJjbtG2172bcAEBtuqQLTTSNddtwkvCh2Ce6cXeX3jBpYX6roCa
         ORpO6Sgw/AwExP4kCk2+dxDAioINWnpauJKq/ezVQTR8+Z/hzwn3Lfjz/jtdNNsKvGfe
         Pm8zkRfL6f7cJecptVHeFL6xMiO5ssbtd7DGjGU+U8BblQSP38bMN6n0ZshGqTs1EQ2I
         KHBCoQHhYGN/shpqcDGRRt/FR7vRWGvqVJGGu993yu6sfqOvpIRauLCkiJKvDo32WqH7
         THG5mUZ8KGHsYd4nlVzsq5BGorrSZBI6eCXKunS9iukU2IBklFRf8cfnJPVIpfaCAZrD
         N3Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWeyBSx2Pb2SRWcqyU9JhBVAD9XVtSOmHBEGiwHdLBaujI86iAlJIDHGQCjTh+Mqd+sn5cP0y5ednrMB7GSIDS7Wsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLDFUWkLoJZkp0jmrZXJ/BKGTl7g1gTOCfeMMu8WyHA3aXApD+
	0oYm43UUA8jotPuLoeo6BWVZc4j8lHjH0KK+d47N1o8YsZJ57wOtEnh9n9mNXjqPQupQZMoXGLp
	g/e3j7ftmekJBAtTGpQ3T5T/b/B9iVFleeKnv/sB0TOQs5f7XbshWKJXiMZWIISrqYj4dIDAj1c
	JmfEYfq+qz0rV5q6TPNdr0UAM6wN8SQr4TJoZNbKJLhIMGyMSy
X-Gm-Gg: ASbGncvRJeBmsi4sw5FjbZMecVF7nMxnwD7DrKsoFaBl8gZRncF4JPGyYtbiCDPbJfk
	u3l40ITkjqqZmQeR20udr6C1ftX+QTjWQ7WnZL39Tozyspq5OEiPYPoCbdmlHCdV2fdOF1c6xM7
	sEhJOrtM/0Q5IrdbfnUoaUDlj5SRkHJea97zRP01JKT6ArBK0TOisXxw==
X-Received: by 2002:a17:907:7fa5:b0:b2d:a873:3a4 with SMTP id a640c23a62f3a-b647254f787mr2878736366b.2.1761204439607;
        Thu, 23 Oct 2025 00:27:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ27BIVOiIIKoESU6vX18AGL0kiF+RteeOVJzjmhHSY4SfVh7aoV66uq3hLQBa2bdzRqLQNgC+AzIxCnDqx8g=
X-Received: by 2002:a17:907:7fa5:b0:b2d:a873:3a4 with SMTP id
 a640c23a62f3a-b647254f787mr2878733066b.2.1761204439185; Thu, 23 Oct 2025
 00:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017144650.663238-1-tglozar@redhat.com> <20251017144650.663238-4-tglozar@redhat.com>
 <c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
 <CAP4=nvT8VGpYrqQDztmB1WJPEb6JXvUuL201ksWq6eSV7kn-oA@mail.gmail.com>
 <aa0bbfeec78bc90966e660af91eb39acccb77d73.camel@redhat.com>
 <20251021130232.2ca75863@gandalf.local.home> <321181e1e5060f0c68e0430d69e0e89688b08235.camel@redhat.com>
In-Reply-To: <321181e1e5060f0c68e0430d69e0e89688b08235.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 23 Oct 2025 09:27:08 +0200
X-Gm-Features: AS18NWDdem8rxzJpkw1zU1ZUIDezEHdLWHqSYOhrxty7K73bR0FqOQHxEIBAHfk
Message-ID: <CAP4=nvQGM_L3dpVpb36umrwZiCT+S4kGQOfENHBXRRNcy0MA8g@mail.gmail.com>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dUfjDJFBizdaEChT4byDSZmVcalPIuGvTwuESUGqubE_1761204440
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 21. 10. 2025 v 19:32 odes=C3=ADlatel Crystal Wood <crwood@redhat.co=
m> napsal:
>
> On Tue, 2025-10-21 at 13:02 -0400, Steven Rostedt wrote:
> >
> > Note, trace_array_printk() (which trace_array_init_printk()) only works=
 for
> > instances and does not print into the top level trace buffer.
>
> Yes, it's for instances, such as the ones rtla creates.
>
> -Crystal
>

Right, it actually works with the trace instance, when set up properly:

[root@cs9 rtla]# ./rtla timerlat hist -T 1 -c 0 -e
bpf_trace:bpf_trace_printk --on-end trace --on-end shell,command=3D'grep
bpf_trace_printk timerlat_trace.txt' --bpf-action
example/timerlat_bpf_action.o
# RTLA timerlat histogram
# Time unit is microseconds (us)
# Duration:   0 00:00:01
Index   IRQ-000   Thr-000   Usr-000
6             1         0         0
21            0         1         0
over:         0         0         0
count:        1         1         0
min:          6        21         -
avg:          6        21         -
max:          6        21         -
ALL:        IRQ       Thr       Usr
count:        1         1         0
min:          6        21         -
avg:          6        21         -
max:          6        21         -
 Saving trace to timerlat_trace.txt
    timerlatu/0-47791   [000] ...22 863353.286497: bpf_trace_printk:
Latency: 21282

Tomas

