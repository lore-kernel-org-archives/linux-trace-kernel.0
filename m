Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE93634F27F
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Sep 2026 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521021; cv=none; b=rpHXNeHSwWdmGBVZE+Q1Ds/44ddxc+bS9nFHOsLVI1xfKcxjY2BVTAouM0kPTn8SjHrCD96sKy3x2cKj5HAN1XJdNSUlLZ8JXHtuCfwvoHa1YQ9CdV7rcHS6CoEGCD4N4UP1czo0LpRrdC7jMdL/1qw+m8ggviv7Wx/7sI5n+rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521021; c=relaxed/simple;
	bh=2lecvDZ/BSD8c+InIe90+zaCIL0CBuMX3DDlyXPCoFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulaLMA3aXG/i4VuPhCb07/8b+LKDlBKxtFy2lmJ8W87duXP7Ii9DagE+I0HymKX9EJt7sxOUNxmw8mrYHq6egBnC5RkjHyWRWHpQ8nkJ3ef8W/4Z59z5g1Q4ivijcefbegvW6sRkrQ2LEiZ6A4F1c37FyUQE8KmtdzeiAkJ1OAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhVeyV3o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhVeyV3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788521018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2lecvDZ/BSD8c+InIe90+zaCIL0CBuMX3DDlyXPCoFw=;
	b=DhVeyV3onUCEiGKZpO6UvGL72Xe1UoA2WNVtYBrpot/5jyTwQawN5Y6bQ0ofosdY/xoPeN
	ta0KHILXWQZ0DZWapsIPiK9L72mg/tcECEgdH2Fb6o2p0KVYIylcvPz8PMo+JozOuphh0G
	05XWS8YXYVZUliYBXiSVajgM8y09vFY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-1jkKcyjbO_iIiqPRTUm1Vw-1; Fri, 04 Sep 2026 07:23:35 -0400
X-MC-Unique: 1jkKcyjbO_iIiqPRTUm1Vw-1
X-Mimecast-MFC-AGG-ID: 1jkKcyjbO_iIiqPRTUm1Vw_1788521014
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c1c232fa136so126164766b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 04 Sep 2026 04:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788521014; x=1789125814;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2lecvDZ/BSD8c+InIe90+zaCIL0CBuMX3DDlyXPCoFw=;
        b=FGu6SRq+e2Niamun53jRyxnKE5e/FDKQ/iekQnWZm6uiKXf4vKn8FUm/81UuNxZrzd
         cmOGqKgZMQ5ciZc/KTubv/NMX70C/vTjY4K4hb7rGgGODM7JYK6jRnQBaQFDERFL8wdb
         98TNVavMWSiQojK8+fgZho4P7j2e1j7pWPRRiCGy2VwToKUIruZOXPaP+Ds3arBtaphn
         1RLmrWaRtfSxb+cdkwoWEpX3gNGrpNZfe1A9FeQChr5j0z68l2yKMiimumcaK8F0eyaH
         eupEy6/Q9CH1EG/7jpES6rBTmT9EqeO52XYfnwxYMkekszyWDDGBIdI1tTFvtZpWB0b2
         5tmw==
X-Forwarded-Encrypted: i=1; AKwUvBy5oNPV05o/XZc51BAE0yg0IPqrghQlugi0inpwS0W0UFIXPePAUOeLPxORMwUd+H6mEUQfviKiDjdYNXFnHOtNjao=@vger.kernel.org
X-Gm-Message-State: AFuF++nygQQ23ahIU92MD9uatt0uEH1eXC28wunmPfGtQ+Ggz20gWczz
	7dalkRTUTUMntQ3uQR2g4jGnJBx+9Qv8wdE+SDkB3CCfKaFutrTEySQChBUHGT5hiW+n7gsrRjy
	UeVvwKVYE8JYslqXF3zjs0hfwdU1cILyCjfeRwAoeyyUf5lfKFiI2QrytCh0mz3l7l52Mf0YFdt
	gghw/vBLeZaHH6Tlboeg2Ikos3byQaHr3C4KlRWKgLkaB1OULJcFw8RT0lzXw=
X-Gm-Gg: AYBFou0eMwASLSRsmo+owS9Ye95KXdhGeJ4ZeuWPfTZVr5bEjRxJ8/heHYYVmLilUxG
	kezFIYoe45cS2v5A/Bh3ezGw2QI+H2U7U+VJDmrLCExZUntUQi8WMpCkMlqqcpC33AIfjtens2j
	ksaMgPb7nLhZaHN+J9sLdGHO37DfbzP+8q0Dllt2NygRhbOK8rmedtIa/XkRVTLQvPWOmChxdH
X-Received: by 2002:a17:907:c50a:b0:c25:8b1e:3750 with SMTP id a640c23a62f3a-c2610474a62mr161182666b.12.1788521014272;
        Fri, 04 Sep 2026 04:23:34 -0700 (PDT)
X-Received: by 2002:a17:907:c50a:b0:c25:8b1e:3750 with SMTP id
 a640c23a62f3a-c2610474a62mr161180766b.12.1788521013862; Fri, 04 Sep 2026
 04:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831090524.106845-1-gmonaco@redhat.com> <87se3sakgi.fsf@yellow.woof>
 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com> <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
In-Reply-To: <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 4 Sep 2026 13:23:21 +0200
X-Gm-Features: AcwNN1VYWiS12e-wX0_oY-0KV9RCS33pApbGhM3jUchKS91T2uscR3QBMlp3mw4
Message-ID: <CAP4=nvSCxbFTLBSvXVFnv-smMyFd9fNFXjodJGEqah=_GEuXkA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Wen Yang <wen.yang@linux.dev>, 
	Tobias Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ta9eRmwJ_-iG-J74TDr4QTS_nSdm5sUXXir__aZX7Kg_1788521014
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 4:03=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> I don't think bpf fits here. I haven't seen active use of RV and even les=
s
> so of any request from people who want this kind of programmability.
>
> So Nack for now. Sorry.
>

A major application of RV is monitoring the combined behavior of the
kernel and an external application, see [1] [2]. Adopting RV for these
use cases is difficult because the monitors are currently built into
the kernel. Blocking BPF adoption because it is not widely used risks
a deadlock: RV not getting enough users, because it cannot use BPF,
and BPF rejecting RV because it lacks sufficient use.

Of course, I might be entirely wrong: RV may not end up being
interesting enough to users even with the BPF hooks in place, or it
might grow enough with only in-kernel monitors for you to take it
seriously. However, we cannot predict that in advance.

(Note also that the idea to use BPF in RV dates back to 2022 [3].)

[1] https://lore.kernel.org/linux-trace-kernel/20260827072400.45734-1-tobia=
s.schaffner@siemens.com/T/#e8a8b21136a60ad7c8f67b07c66f71de0ec0c1075
[2] https://docs.kernel.org/trace/rv/monitor_rtapp.html
[3] https://gitlab.com/linux-rv-tools/dot2bpf

Tomas

