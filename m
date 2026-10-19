Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FE74DEC05
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415132; cv=none; b=nSf7pcYfYR3z3x9+EbjHCg8CucDd08R8mE2DlGrVA8pyk9hIX//fPlr8hz4FTnWshn2kNQ6KvlbLNLFhia5iyvMH7vPbX0/2x/bZz3cYGyO+7k7pKW2RhJAPQFjxnvp9elOOuXPelKO0ArcKG+6tQI1iZF7oTA+dhfkxWky33Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415132; c=relaxed/simple;
	bh=PA8IT0mW8qyJLl9udMwhuGJy547uTDcbwByYbnkz5eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeGE13UaX5ZYEak4rqVRvVYSLXFuXyFPq6qISCRlCBOkXQor7p37AtvrhsLjPTwqFn/pWq1IZ5diPCK3ezfkyQdVZBLHM7kr716toe5FV+lTuQuHOMULEhH5ruW3sFaDx9VisagN2VAVrqkZveNvdjZ+/zGJd3wEfaCTCeHRgw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMpfyA8K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMpfyA8K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792415129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUPbdohuI5rYwK6fOugHmkfgJHBc1I0kpq40ADeEBNQ=;
	b=JMpfyA8KhiNKd4ujEIyXJMFkEGla0el34XzCnZuJXI9ZmCrYB0Q8RePm/bJId7Nme8wm2n
	Kg15iHahIz3zXgAORUy7vMX6hsel3q9PwNTQrQdqb5AlpifjnQAZ4Tx1DEIdepQ+vUxDr7
	3sfr3jOr4r0LXTnOgsB8F+XeWGuEehI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-FN_JuI72OseL0oXGrL2bhA-1; Mon, 19 Oct 2026 13:05:28 +0000
X-MC-Unique: FN_JuI72OseL0oXGrL2bhA-1
X-Mimecast-MFC-AGG-ID: FN_JuI72OseL0oXGrL2bhA_1792415127
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c42888c50c4so124871066b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 06:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792415127; x=1793019927;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vUPbdohuI5rYwK6fOugHmkfgJHBc1I0kpq40ADeEBNQ=;
        b=vsdF0DhTOhoUoxhM/iu+3Wch02a0cMtVoZEGkAe9g2By0aHPMZck2WH9Z7i4CnbGBN
         JmZEUlQl/jPdDrVPvxZjvMHali4J7l5nkmC40t9BQcp5bsKYysGrQNtoeLWf3CctTSi8
         Je5R3CiSYAv2YqMzK7WvZk7UlPPY1WGqthI96WE9IaWCxGdlc7Nf5MzkHe5p22EwAY5j
         KLnyNU0e8rOCtEXCUOpVF2lTjSSKTSloA57rSiteW4EtFTZJYR90YSIKEnNLEL/Mg0Qw
         p9CXDe+MXdOScEevHUE0Uv7Qe5sPp6M6dEEpoIdsD1qLx3+rfbUzWGRdyChvpalunJwt
         CRYw==
X-Forwarded-Encrypted: i=1; AKwUvBwbv3lvHOcZ6w8ErFICMbPGVqYZ5OIbjIRjLHBB9jk1yOALjcjC4/dZmVn8hOR4NTzvWKI4f/8E2n0qaATUuWG8Pu0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIW2b3lc8QGuUVZBI0S7K+1+MalCP+tHi+OY8sYbTkScBMVuy8
	BwInAmdWsp4MRmtKSILDrfGEtz+WJfpmdBjSmGqBFH4aAIaMW+0dcn55eGu94ADzyEhUAPPUpx4
	ZF1vI8b/zn78WQXOGjl9SWQSoCKcIpH/dZu2Pibd0LTpXrZJ1fapIZIVrn6Jj9nTeOw27JSUIA7
	XL4Gd6LDGybiUhXazijfK6180nlIVfQXkSKsBkQPd+R2P0vKLB
X-Gm-Gg: AYBFou0EzljfJ2kpsrjNyS4U56edmP+gRB14A3FXZqdj1eNbTdHVfDgeZ9nYq1rK0N3
	EuEkG7ZDpM5RZq+6hsljNxZulaMW0CzBbWrUozC04kJaYPCyq6a4xxjcRMYTyY9r9MBHhmyhCN6
	L/kmcMF25NMhAekRb2hlgoZekw1R8LObi3rlt5y6WufIAS2jxtomql1Uv6tgwpmjSDEb1Wt306A
	srx9CntSmqfTjE=
X-Received: by 2002:a17:907:c008:b0:c40:f89f:d91d with SMTP id a640c23a62f3a-c419fafad52mr566086866b.28.1792415126904;
        Mon, 19 Oct 2026 06:05:26 -0700 (PDT)
X-Received: by 2002:a17:907:c008:b0:c40:f89f:d91d with SMTP id
 a640c23a62f3a-c419fafad52mr566081966b.28.1792415126452; Mon, 19 Oct 2026
 06:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com>
 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com> <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com> <878q3xtptq.fsf@jogness.linutronix.de>
 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com> <87bj8s8ih9.fsf@jogness.linutronix.de>
 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com> <87v770uuyr.fsf@jogness.linutronix.de>
 <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com> <87ik2zryzo.fsf@jogness.linutronix.de>
 <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
 <CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com>
 <8580176d216258e9008c344e0529509117dcc18b.camel@redhat.com>
 <CAP4=nvTc297yQHz8aumZFAQ3+JK=5Z_=416WdosT0S6nHEeNfQ@mail.gmail.com> <d2622f5c375ab26514d059b5949dee28f3f9998d.camel@redhat.com>
In-Reply-To: <d2622f5c375ab26514d059b5949dee28f3f9998d.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 19 Oct 2026 15:05:10 +0200
X-Gm-Features: AclHuK-qu9FGzZ1wQlrHPYBUAdZYSh4UcmqBXa3GV9mICyDiafDBWh4-NKWR3no
Message-ID: <CAP4=nvRhd1d+o8O045LB=dcYa2UudH7ZbG388wcwEX+JNBWY=Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	Wen Yang <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
	Viktor Malik <vmalik@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LnbI-Ebd2t5nxhXL92M4JYuLbzDp98_bVX1uK0wK0vI_1792415127
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:48=E2=80=AFPM Gabriele Monaco <gmonaco@redhat.com=
> wrote:
> >
> > Do I understand it correctly that the idea is to modify existing
> > tracefs instances when enabling an RV monitor to filter our RV-related
> > bpf_trace_printk events?
>
> Not quite. The initial issue is that the current iteration of RV BPF moni=
tor
> don't cooperate well with trace-cmd/perf. Alexei suggested we use bpf_pri=
ntk and
> filter out the desired events with plain ftrace glob filters (from trace-
> cmd/perf).
>
> I believe this would be usually equivalent to having a dedicated tracepoi=
nt for
> RV BPF monitors.
>
> E.g. you'd do (roughly):
>
>   trace-cmd -e bpf_prink --filter 'bpf_string ~ "rv: sleep: * violation"
>
> instead of (with a new kfunc)
>
>   trace-cmd -e rv:error_bpf --filter 'monitor =3D "sleep"'
>

I was talking about preventing other (non-RV) consumers of
bpf_trace_printk from seeing the RV prints. Eg. if I create a tracefs
instance and enable bpf_trace_printk, intending to see my own debug
prints, I will also see debug prints for RV, unless I explicitly
filter them out. I get that on the RV side, these are mostly
equivalent.

Tomas

