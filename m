Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F78139A070
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878004; cv=none; b=E+vf3R9JSaXvdzqkilU5agTAwMBEmquXLNSPZ97uHd5k12iVpxb9qySmw8qfi+bG1bcdR50EEaS7afP6k/FYGPheGia7OdDFwJlmOvR+7fDz4zo5Xf1WKYJ5tiCJbidX7WPhcfxBfjpAliNXv2oqCPem270ZwtaRHZIRD02SqGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878004; c=relaxed/simple;
	bh=rw/8h1D+63nkFtZwWqlY2Q2ISZQHu8o4oIa0YyClyFg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EH5gW8vXOn+x0oo9RrY2wJHG8745WM5RB1M2bcsCZdZ5/lB1ACyuxCMWwh6M0EF0B5SM1XthJcFDjHs//0kn7xVb3zntod1in7igm2YcD64whIu/UTuI0vgGi+KiW6P4S1UOZHGMCQrkzIK7XdDv8bjw4zZnNkryYI2A7GEH22M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AdTbrDwi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdTbrDwi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791878002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rw/8h1D+63nkFtZwWqlY2Q2ISZQHu8o4oIa0YyClyFg=;
	b=AdTbrDwiY1bD+9dcdgg+iV5uuhPsykSHNvwvwO4zVt22ydaCnarTzcSkyiROODbBQH4sca
	zsX7iZ/AExdT5rcW9YiOO1JTy9cJkd4GQ3W90VOJQZMSgw4IQi78vTFZfu9zJPh9VN7GtQ
	zDFGVG5UzejSAvI5/V0YiPRZL15geOA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-qhKNwm4NO4mffzutYL0iQQ-1; Tue, 13 Oct 2026 07:53:21 +0000
X-MC-Unique: qhKNwm4NO4mffzutYL0iQQ-1
X-Mimecast-MFC-AGG-ID: qhKNwm4NO4mffzutYL0iQQ_1791878000
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-487038bc9b8so2092429f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 00:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791878000; x=1792482800;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rw/8h1D+63nkFtZwWqlY2Q2ISZQHu8o4oIa0YyClyFg=;
        b=QHNZTNE7wdtbQR5TElPV1cPn0Hhfy3L0p4M0cZXoc1rS5YRhtSzwDr3X2J2hC/p/I9
         ewmhEOGdmleMtz47pYiz7eNcsuO8qYII3pdMtv4aOkXSQ1Hyjao97WYjEV5hNJIdzCy4
         iv4+/I1dEHzGkKBEGExU91MjfuFgu81iwneQ9uOfJoqBEpgB1xJE3Wf3g/u8p8xWCmkW
         EBp2HBiDAnf560iDSRTZxakt4oxi0arGoJSR5F6zm//FNBe1kuKkbV4wSO8oeU0rRfDJ
         0CD7ZFZdbv+TVJq622ZfFXr1cxd8IIVNGlKbb0kCo0fzlq+Sm6lpwp+Dkj8UFt0EPPgh
         r+rA==
X-Forwarded-Encrypted: i=1; AKwUvBzsGlXTF+JcoXIqgU1iElkpVc/eTVNrs9WFT/h3MA4CzYFpB/8wx69Gcj3eLKY9GmqULsfX7M6ejuvrsnk964Msvf8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKd6B1sVCsijWaJtFNFNBHQdP0f0HlZBENyx6BtndsKEtOOu/Jy
	iIh3a+7ImupJIFrhp30c2Ng3NVjm8wZh27YoQIPNFHtHH8hrbHDkjBi4ZwcXM6ZYX0vrL2nv+3w
	LBZh8IIY1HV4LoMMLAZtCxlfGjQiqzq4KubuibeR4x/j38LX8/h81a8TOdsHyES2UWFve/mENAQ
	==
X-Gm-Gg: AYBFou2/pgZ73AYURpPa9G69eRAYsNR9V03TN0nNkOBaiA8ZUtWoM4qqYl6zKPGm+0v
	aqwA1lfv3SjRiYIk1+RbosalHDTDuPDVd1y1/iHQxIXR931mAhcliKWqazI35mp5J5R8tZvKame
	JokHv89OMV0RnkU0ewqi2e8WErv9Dc09glDPe3J4HLJYRVl2UMj15DWHnpZXm59obwdCHavq99w
	eza6lJeJ7GpxctRazhHylNzeg9RbCWc9hzRdQvjAP2k7NjAAXa8v8FLLTnU+72H5k+CWs9c7isv
	UDB6riiVVr0DIWjucBtM9DFZvWzaca6GniQZ1/l8dHSCL6qWrzsUP6mABTqVySxRsyglz0wQ1pw
	Baw0fTeP2BDBq32oqYhgBmHojC6Lh
X-Received: by 2002:a05:6000:41cc:b0:48d:bae6:d7ba with SMTP id ffacd0b85a97d-48dbae6d911mr20398648f8f.26.1791877999763;
        Tue, 13 Oct 2026 00:53:19 -0700 (PDT)
X-Received: by 2002:a05:6000:41cc:b0:48d:bae6:d7ba with SMTP id ffacd0b85a97d-48dbae6d911mr20398627f8f.26.1791877999400;
        Tue, 13 Oct 2026 00:53:19 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac37acsm3531102f8f.34.2026.10.13.00.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 00:53:16 -0700 (PDT)
Message-ID: <8ba6ca530f6f35c04ce7147ad601eee6bca2d792.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] rv: per-edge dwell-time statistics for per-cpu
 monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, Tobias Schaffner
	 <tobias.schaffner@siemens.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 rpm@xenomai.org, 	jan.kiszka@siemens.com
Date: Tue, 13 Oct 2026 09:53:14 +0200
In-Reply-To: <20261012152129.4c57786c@gandalf.local.home>
References: <20260911123439.463052-1-tobias.schaffner@siemens.com>
		<4759c9b0dacdf1f9c0cf47158895860dbd0ec401.camel@redhat.com>
		<cfd7123a-e83d-490d-918b-154d45aad92d@siemens.com>
	 <20261012152129.4c57786c@gandalf.local.home>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mDAu1inNZCwV3YkN9AEgINfIyJtFyuIdt6F-iMMP2wM_1791878000
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-12 at 15:21 -0400, Steven Rostedt wrote:
> This brings back memories of conversations I had with Daniel. When asked
> about how this is being used in formal verification of safety critical
> systems, he told me that only the RV verifier itself needed to be verifie=
d
> and to show what it is verifying can be verified via it. For example,
> running Linux in autonomous vehicles handling critical systems the watchd=
og
> had to be verified that it could catch lockups. As the watchdog would
> trigger fail-safe mode if something went wrong. RV would be monitoring th=
e
> watchdog and if RV detected something it would panic the machine, which
> would immediately force the vehicle into fail-safe mode (stop lots of
> features and only keep those that can stop the vehicle safely).

Yeah I talked to the same people working on that project, eventually there =
were
more problems like verifying RV can't be affected by the code it's verifyin=
g.
This is still an open problem though.

> Can using BPF as the RV verifier be formally verified? As verification fo=
r
> RV monitors did look at the binary. Is BPF optimized to machine language
> before it enters the kernel? If not, can we formally verify the BPF
> verifier created the correct binary? Maybe, I don't know.

As far as I understand, verifying the BPF verifier would take an insane amo=
unt
of work, the go-to approach is manually validating only the code you know y=
ou
are running. Let's say up to a point where you can realistically say it beh=
aves
like you want it to.
In short, having a verifier doesn't add much value here, at least until som=
eone
verifies that too.

Then there are the levels of indirection, BPF C code gets compiled to BPF
bytecode and that gets JIT compiled inside the kernel. Now it's machine cod=
e.

If people are normally not validating clang/gcc produce machine code consis=
tent
to the verified source code, this case should be equivalent, but I'm just
speculating here.

Gabriele

