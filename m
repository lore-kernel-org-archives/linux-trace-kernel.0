Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABDB2417ED
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Feb 2025 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928192; cv=none; b=XbNZllPVf3eSERKwfC/XPbD7ltjtHieXMpjx2Adwn6vzKnKG1abFll2Y8ld9gb9lKjG6HQfphc0NrEFfagZqKEOYidSlYwYYj4n80Du2iP+xso9qBDKLVDDuiKtL7b4wpUBVlgHZArzKjDxSrxYv3lM/ISbdP5IOj1nBa8vmR44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928192; c=relaxed/simple;
	bh=S0jXGXJYq667zMKFys7Ylp7YNrGipcdb91sgnACR210=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONVh4a8lbVMtu0enRlLKGuFz1Ar30HvKFh8fTfvrN3mF0EVLV+9r7AOrBSjzkXTOr5BZpBmxCADHt82ynNSMgkF5I2Ho2HH0lSymhsvSSRYVXEIG5ky4GYFKwqeBMVEBhhA1GxVOkhbIUAND4eSlo6EzXoVTL91Jp85EVgZqUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SEMGHoEh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEMGHoEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738928189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S0jXGXJYq667zMKFys7Ylp7YNrGipcdb91sgnACR210=;
	b=SEMGHoEhplx2SOQtVUWM3k54CjzBjDYEjkBKVfBIoQkZR3pFlNKXSoOKF9ueRivOkiodm9
	oBPwdMu2XUYavhCAzovpwiID64/B1ww9ikBwjqLSrYXH90O9ITDRCMEOwrH4YJqfuJSnPb
	q+Nu/Ufxp+tkArS85GNnPTdcVMFT2aA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-9W4S5ZWGOlG46qNZroToSQ-1; Fri, 07 Feb 2025 06:36:28 -0500
X-MC-Unique: 9W4S5ZWGOlG46qNZroToSQ-1
X-Mimecast-MFC-AGG-ID: 9W4S5ZWGOlG46qNZroToSQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38da6aa2363so862583f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Feb 2025 03:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928187; x=1739532987;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0jXGXJYq667zMKFys7Ylp7YNrGipcdb91sgnACR210=;
        b=N7X+62pg/MyqbsWb2aDDrC2XZNniWvwBLUpmzIjglzYUM4/MzRDYQsEi/6z0yg3x/e
         XtxLe4OuUJZiaqCxUSezyxhKcZNVZPK77AeII/dGqPtwJWhYxPTV2xSbHIh6PRwXIPBR
         PW/vuUZqeOgUlF/2QHQSw2rydmPe9iFH50MoyxsjOl5+93D5wfxRTsONN3PQmNlVO44t
         l0AC/udbNSWAL/6QVgMBW+wTpx6RwxSYV1qfNm+j7CCLiY1eG+doiGBzsIL5mIjhGowp
         5t4Eln9JsjeygoZmNGdl/LoFsDjdQ0nOPy5mKtkRWm9ekAYzB4+hf10+AkTaMIQD3X8k
         ssKw==
X-Forwarded-Encrypted: i=1; AJvYcCXSkWoec1BH60fvgVAx+s27LdJfD6TslJd3PKhnfEQnCXUAYuTHRCHbNV8ZjhS0r+bF2aDAwxf2vBUtrR/NAnOiSI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycFExSF2Cxlaqv4LS5ktkwauBSMsoAc+3o4snPSVh/QQ4U4pTo
	W6hbRMIaHof9zl8a5K53DhSHIsCXPwlTnzx2yNkSUmBwiHP4NyEqPBFsCyLlH62O4DAmPwNSWL0
	fq3RxKY7ghvpriNjHp10sQzpa2WZFTT63LFZOj+OiPOEDfOnAl5aQ9s2CACrqJmvhbm0JcQ==
X-Gm-Gg: ASbGncsMrnT99HADh4iGNV+Qt100cfkhbS7NkcKcjYCVqgqRkRGQT3CSEy/t0fGsVAq
	lKUGiEvDdmD3pJo7rpX4faf2rXb40lexAtHkClAmuEZ/PEXSp2DujHFlggzT8m4GWQoZj5H+dYs
	53OjhM1qrXOObQM2CXEj4HqG6Y55ChV4mtT3uxIRAeviuLmfqKTBO+s5o+1fOQNizJV6Cvhob8l
	xjwF+wo9gkaScKhDqC0zs4+2sKoGlx8XM8y8aPNYtf4G/rfFBU0si6yTxvdPnYSY3rCciBqfm5P
	FGKMxXkfsJrbGUmEaKuIK2PuSHgmlaQ=
X-Received: by 2002:a5d:6d88:0:b0:38c:1281:260d with SMTP id ffacd0b85a97d-38dc90f0f98mr1895385f8f.31.1738928186960;
        Fri, 07 Feb 2025 03:36:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4yT975z2O3wFjbb3NJP9lf8J4Kp/aHd+bgRUK1tWpGp2eSjf2AnV/W9eW0s1bLI33jydtYA==
X-Received: by 2002:a5d:6d88:0:b0:38c:1281:260d with SMTP id ffacd0b85a97d-38dc90f0f98mr1895365f8f.31.1738928186554;
        Fri, 07 Feb 2025 03:36:26 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d96530fsm85449585e9.19.2025.02.07.03.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 03:36:26 -0800 (PST)
Message-ID: <847c962745ef5bce757b9ae257ae279913ac711c.camel@redhat.com>
Subject: Re: [RFC PATCH 00/11] rv: Add scheduler specification monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-trace-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, Clark
 Williams <williams@redhat.com>
Date: Fri, 07 Feb 2025 12:36:24 +0100
In-Reply-To: <czykavxpz46nwnelml6yorg3tvmyjvczqogeuqzji6qrfd2peu@qxr6wucv6mrj>
References: <20250206080952.98478-1-gmonaco@redhat.com>
	 <czykavxpz46nwnelml6yorg3tvmyjvczqogeuqzji6qrfd2peu@qxr6wucv6mrj>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oUrjECl85nw3uaTsqrHGoVb0yVEPtyQ03XzN1_wHWRY_1738928187
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Fri, 2025-02-07 at 11:55 +0100, Juri Lelli wrote:
> Hi Gabriele,
>=20
> On 06/02/25 09:09, Gabriele Monaco wrote:
> > This patchset starts including adapted scheduler specifications
> > from
> > Daniel's task model [1].
>=20
> Thanks a lot for working on this. Apart from being cool stuff per-se,
> it
> means a lot personally to see Daniel's work continuing to be
> developed.
>=20
> > As the model is fairly complicated, it is split in several
> > generators
> > and specifications. The tool used to create the model can output a
> > unified model, but that would be hardly readable (9k states).
> >=20
> > RV allows monitors to run and react concurrently. Running the
> > cumulative
> > model is equivalent to running single components using the same
> > reactors, with the advantage that it's easier to point out which
> > specification failed in case of error.
> >=20
> > We allow this by introducing nested monitors, in short, the sysfs
> > monitor folder will contain a monitor named sched, which is nothing
> > but
> > an empty container for other monitors. Controlling the sched
> > monitor
> > (enable, disable, set reactors) controls all nested monitors.
> >=20
> > The task model proposed by Daniel includes 12 generators and 33
> > specifications. The generators are good for documentation but are
> > usually implied in some specifications.
> > Not all monitors work out of the box, mainly because of those
> > reasons:
> > * need to distinguish if preempt disable leads to schedule
> > * need to distinguish if irq disable comes from an actual irq
> > * assumptions not always true on SMP
> >=20
> > The original task model was designed for PREEMPT_RT and this
> > patchset is
> > only tested on an upstream kernel with full preemption enabled.
>=20
> I played with your additions a bit and I was able to enable/disable
> monitors, switch reactors, etc., w/o noticing any issue.
>=20

Thanks for trying it out!

> I wonder if you also had ways to test that the monitors actually
> react
> properly in case of erroneous conditions (so that we can see a
> reactor
> actually react :).
>=20

Well, in my understanding, reactors should fire if there is a problem
either in the kernel or in the model logic.
While trying things out, I had more than a few models failing and I
excluded them from this patch because they are not stable.

Ideally you shouldn't be seeing errors using those monitors, unless you
(un)intentionally break something in the kernel.

That said, the monitor task switch while scheduling (tss) imposes
context switches whenever we reach the scheduler.
Daniel modified the sched_switch tracepoint to fire also if prev=3D=3Dnext
(in fact no switch is happening), I'm assuming the tss specification is
partly why that was necessary.
During my tests, I didn't apply that change, yet I've never seen the
monitor failing.

If you manage to call __schedule while the next picked task is the same
as the currently running one, you should see an error and a reactor
firing.

Since I couldn't reproduce the above case, I ignored it for the current
RFC, however if that's possible in practice, we should perhaps add
another event describing this fake switch to prevent the monitor from
failing.

Thanks,
Gabriele

