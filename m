Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582781;
	b=bjm5Nd5TGe0AgNhq9E+SmwnMGrxFUpzhS/UeKWIoRZaTGglcoAzCXNvqFIQ4iC3ghxrx
	 1YBFbWMyH/kTPFVaapLCLdk2JgZ+HZrEdAKLOeKxig6P6G/0A6VcdyLU3EpOFbFg+YJeF
	 Mffk+rxtYUQiwxbUXs37893jJvRlzrReI3AjuKcLoxiZ8AHsMnweAB6c255N4sF6hDCEf
	 P6taBubLpk3Vdi8S6YyAKDwR/bcXag587Gf1A+PsKlBpZ18ElD1ssGM2gBMji9UZZzZs+
	 8LfHOXSxOLenBtfDqhrgLuvTEbLUPmnXrwsGpewJXExVxbxt12xAVFzaxPv96js2v/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582781;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=WDUSqIzvagAi6A91Fak+66DHMKH7R3y/uiOt+fyuEM8=;
	b=NPYLkNbHHVqPwUI/s2mO2UTtxnpq/Duh6kWqkUfVYCd7bj9/3YNXwrCtIICjiLhWuzhL
	 RssI4U3TaTi82rhrnhPwIpt9OOTGGznUX8Vi6/t0PtoLiNzvyc+HtLYVItEkUKP73W6ey
	 Yu1C6OK0I264fcnWv6ch5z2WII8AiBb+JzAQMCGW7+xWzSzkYTSFe2qVheQ3ws625Qr+3
	 md+0KgrBakFIafIMCS+TeszMM2n+gMw+FQg8YudmpGam0DgG2iwvmqtFQq6jX+gzsClgp
	 1hITo0CMCkNbfOrkG9hQkZyw0SRaB0xz1d40wTsJp934+CqZ/b/Y2nIFUgoQi62kkYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WMlaUr5A;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F8A606A327
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 15:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1F8A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WMlaUr5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794582779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDUSqIzvagAi6A91Fak+66DHMKH7R3y/uiOt+fyuEM8=;
	b=WMlaUr5AJeIhzBDZgT0vCZ37Iudmd4ixkltoFZom+X0xcoziIZSrPeaihP/lTzJh8L2qYL
	5r98Rrbvha1w4pS/No1ITpkod4+U0dnjTfOdPeeBdUnyoWFMXmDASrICeYxwVqnmNGbcv+
	ND2BSvXtfDdkddyZBN0VGsS6+XjcVGM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-Z2YOPezeOAmueAhZ9viqNw-1; Fri, 13 Nov 2026 10:12:58 -0500
X-MC-Unique: Z2YOPezeOAmueAhZ9viqNw-1
X-Mimecast-MFC-AGG-ID: Z2YOPezeOAmueAhZ9viqNw_1794582777
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd3b9e70f88so1265889a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 07:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582777; x=1795187577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WDUSqIzvagAi6A91Fak+66DHMKH7R3y/uiOt+fyuEM8=;
        b=fFrs2QYOwFMpA0BP9MCceLuax8sVOvoymXDEW7YY2aGP80LN4xUzyMFtr5RUTiNu19
         3pVRGkGzhkzBW6HBuq3QWNbDjHZU5CWVjhbh0HGU+O8i10FRuDHnfqIAaoDMsXRgGFRM
         kk4ivIJYC0Pr0fAdCDymVuhQ7M4fWsHd/yG0Kf57/r4qy2mUiNzJWw+HjEXeYJtAf+Vx
         7BFGnh7TUMao/Ti8Rw6Jvk3K3EqrUa5zw2+5BPHDn0WYuf2ldYx1OH4XxZTRcxpvRhhH
         JT2Cy1p0vfK06BO4qylBWBf5B2yHg1VgcVlutg8niaTksrrp8Qpbf4NCju7d2RWxOy+U
         IrbQ==
X-Forwarded-Encrypted: i=1; AL+hErEkhLWWn/LQc85R+mVmATcncmZrapsRmvOEbQq/GcNXVsBflj5bpmM+Nte/enJtThKec6F897CSZ/q76H6d3Ij4KNY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8d/zNt20eID8OL2j7np31OJ/fAqj7TMXX+a/kqJyMONukpDE3u
	RwYJxaDpswGu6SuTQUv9h+d1hm0mv+CO/ONTFvD5thY//JUtKj6pVS2qGA6V2+5wmQEC5J6WbzU
	SErNbxe4K3AdPXf6EXp5dwIrZoxTOayNzrGaHZvR46TPUAtM3uXO4tqgt1Mic6B+qU5CzpIvkg/
	KG5wepOdlfMvXZKLq8nZyVQ0wTwg6xZdfn4Hr/YiH4Uu7S8EoY6D48Umt0XhU=
X-Gm-Gg: AYBFou0m0tpg8vrckTvtWfCWlnDFqQmi+MuhkDYzeYO37mrI5ehgmTqYyS7/DhtOg02
	CbQd1284XPj11652H/T8W7jta70jnzb1U5vdCVpjksw43Of3daIqKL5sllojsdRpLuiOOnWD12N
	57qT2AiGUHiDBK5MT/iiS70WnclkkrwiLEZDlbJBaFN5twckT/Q8Vz643m6A+5caU5nNfJqmZMP
	C0cVC+o2zMo8MI=
X-Received: by 2002:a05:6a20:e68c:b0:3e2:a849:64c0 with SMTP id adf61e73a8af0-3f7a85d9479mr2660414637.51.1794582777344;
        Fri, 13 Nov 2026 07:12:57 -0800 (PST)
X-Received: by 2002:a05:6a20:e68c:b0:3e2:a849:64c0 with SMTP id
 adf61e73a8af0-3f7a85d9479mr2660388637.51.1794582776845; Fri, 13 Nov 2026
 07:12:56 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-rtla-mlock-v2-1-14382f140da0@monom.org> <87o6bswzj9.fsf@jogness.linutronix.de>
In-Reply-To: <87o6bswzj9.fsf@jogness.linutronix.de>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 13 Nov 2026 16:12:42 +0100
X-Gm-Features: AclHuK_feLH1S3_TxeYU0u90CBSg25p2KMxJp7qcgxlk7RF6fKY5CRJ6z7vGJXQ
Message-ID: <CAP4=nvTswKUTSJiFRJK7KXAvc3JMLDCgXW=mSV6BO3mMucyWnA@mail.gmail.com>
Subject: Re: [PATCH v2] rtla/timerlat: Lock the memory of the user-space threads
To: John Ogness <john.ogness@linutronix.de>
Cc: Daniel Wagner <wagi@monom.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ofCy44UrQRMcWeGzVgkxxPYYda7RDfSSkG7-8nKctQ8_1794582777
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 3:56=E2=80=AFPM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> It isn't because the page faults show up as latencies. It is because
> doing non-real-time work with a real-time priority is stealing the CPU
> away from other real-time tasks that presumably have actual real-time
> work to do.
>
> This program peforms severeal non-real-time activities with the
> real-time priority, which is not setting a good example. But I am only
> reviewing your patch, not the full source.
>
> John
>

The only other activities the user thread performs with RT priority on
before entering the timerlat interface read loop are setting the
cgroup and opening the timerlat interface file descriptor. I agree
that ideally, setting the priority should be done just before the
loop.

However, I don't think either activity takes too long, so the
difference is probably negligible in practice. Unlike mlockall, which
(if I understand your point correctly) might pre-fault from disk

Tomas

