Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F02233942
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Jun 2026 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796955; cv=none; b=kc5Vpq57Ay2506bHTlnWxiB5u4anE8tJAz4b4RZK21mEFGf4/DAlfpXHddR+Z5mvy3tst1s/7AGnKkabQVcuJuTF2X91VMMpnJl3FnU2dKKLhIPeUzGRo/ydEaUQOTdIT3tZq2dzqUoHon//zkCjRcyAqWvwQFqvw33/92zKVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796955; c=relaxed/simple;
	bh=qSbMDih9JJZvd9c7ADvSHoRnQJR+oU6Ws3qa5k8v/NM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0KEb2ed3BaaoXOmtLt7uM4K1DVaJiljz9eAKJml14Uq2Suhqu8+MtPYcxtJXQ8UEdSbVROXxqP3ON4+LSMTyNFOcBMer4IOgtuH9wT5tCgEs6SWemdlraxhP2pWLyG8iF2xpRq3aeBFDUWfqrTrP7TAxWhf/hXOrEPneZJfj1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNJ2Agk1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNJ2Agk1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781796953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSbMDih9JJZvd9c7ADvSHoRnQJR+oU6Ws3qa5k8v/NM=;
	b=KNJ2Agk1YZo3FW7n0ceuN4EUMnhvMDv0ipXntt0wppBz6AXcaaBDCD8vZSi9SKxRKTzAsF
	iJaVeNAruHdp0jGeyamb23dNztAXYAHRBxjxuiqjFAF7vjde6rYru9RnPbCXM9pyM6hRBk
	/md1jA5ixBlrXlTJ2ootGgFKxONO5R0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-VTjuizmPOm2-h2ven5fIug-1; Thu, 18 Jun 2026 11:35:52 -0400
X-MC-Unique: VTjuizmPOm2-h2ven5fIug-1
X-Mimecast-MFC-AGG-ID: VTjuizmPOm2-h2ven5fIug_1781796951
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b37e1f47so7433535e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Jun 2026 08:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781796951; x=1782401751;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qSbMDih9JJZvd9c7ADvSHoRnQJR+oU6Ws3qa5k8v/NM=;
        b=k0GRyNQdvbaI7v96V5Rl47CK00XDryGyFy3INw8MJyWCv9A7LKTdqtyfurlzPcbBPG
         x032Lo2SjHj2nbx7t6tq0AiS/pAeeK4FA9rFRiFZpnOTVkrtQGTQKhG5lc5TXYyIjymd
         LS+OMpGnKdRvDTv61/27PekMcc+U/EBQ8qP/vqXxezgk0lyGAcCW5Tx0W4FMOEMhuDJV
         ehwa73mC/sSxSqn7fjLeYz6bYYKXLbexuBuepcnjp0slbisFcwciITUhHw8PJkuJMTA2
         4K2Ixn3+IS7s4h5fA6WCPmmpefvVpvUbna1G0mivsIgaPwx7UcehaR8ACkPbgGOKovHI
         BAsA==
X-Forwarded-Encrypted: i=1; AFNElJ8VdaZKFYiuuhbymB6wtfZF3YcGLW/pxMOsr6Agi+Mp9Mw6EkcH6PET4SEPzVRaieVSu4Fx5s6YiwY2MUl/8Y81QdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrpy4ruYkAp1z+B23UJMc5GnEjThO7qp27COiOKRJuhwplKNcx
	TlOMUVGQftPC1wuOLcLnAqNEgGqAejeYhXIfXmdrCqKRjviU+NxgMJevvCr25a00OmwkKGtTwOt
	qk3IytzunBC6c+ZODAvqtOhOXhizMaBZmpiml1hhmaQun17+VYV2tvrZsp1bpHjJUJQvGGtWC3P
	0Gom19Rg==
X-Gm-Gg: AfdE7cmPgCIVeMLT8jTqUd2q4UsqLTKixHaqGjr3PU7QlpRECIR7sv12VGW4w5nArdR
	wDJCs+AvE+8R73xcL6X0W2jAvcCi5OHHx72SJUYKr3XNTwZboRIPRvPIQIuwIAUTQ24Rj5nSu7s
	3EQ5xrh/3ZpTnN8Pq0gCH3Y77QZju3Z9r/LZBCpmtbo3d6RgUEjnD+dQPRZVb7zFXMg594lcm9G
	+pHL2Xw19/5X3rbyORTemwaaCGWL6zByDnXStgXUaMOMq3O7oDjkk3ZYtq0hMoJr2TYJCdiAXgH
	0FjAhlmUZKSNwH1CtMWopngZsyp45Y70kkbjROTYSj4H5zbOelWNhfO3FeDiLhedXdVAdh2stTB
	nmC/Ybvb35EmfWQQ=
X-Received: by 2002:a05:600c:154a:b0:491:7325:39c4 with SMTP id 5b1f17b1804b1-4923f594ca9mr1205245e9.34.1781796951178;
        Thu, 18 Jun 2026 08:35:51 -0700 (PDT)
X-Received: by 2002:a05:600c:154a:b0:491:7325:39c4 with SMTP id 5b1f17b1804b1-4923f594ca9mr1204615e9.34.1781796950737;
        Thu, 18 Jun 2026 08:35:50 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2e6a8fsm65687963f8f.37.2026.06.18.08.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:35:50 -0700 (PDT)
Message-ID: <2de882a2dcf09613580bcb2495e3b2495c58f661.camel@redhat.com>
Subject: Re: [PATCH 0/3] rv/reactors: fix lockdep warning and add KUnit tests
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 18 Jun 2026 17:35:49 +0200
In-Reply-To: <4053c9bb-6229-438c-8c14-917909c1618f@linux.dev>
References: <cover.1781541556.git.wen.yang@linux.dev>
	 <2bcfa0bda551c0e1ba137b728dbe7886ff5c2579.camel@redhat.com>
	 <4053c9bb-6229-438c-8c14-917909c1618f@linux.dev>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GEqVF-ntfkK7hx-5FhF_irZhJWevP-Hf5TJ3C3fMIXo_1781796951
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-06-18 at 01:11 +0800, Wen Yang wrote:
> Thank you for your feedback.
> I am using a WSL dev environment with 12 cores and 16GB. The config
> of the tested kernel code is as follows:

Uhm that's a strange one, I cannot get a machine like that..
The closest is a 16 CPUs where I can limit the resources in vng.

> And then, using vng to build and run kselftests (since kunit is
> already=20
> built-in) can reproduce this issue:
>=20
> $ vng --build
>=20
> $ vng -v --run arch/x86/boot/bzImage --user root --=20
> tools/testing/selftests/verification/verificationtest-ktap

Well whenever I pass some argument to vng (instead of just vng -v that brin=
gs
up an interactive shell), I see an unrelated lockdep splat in
timekeeping_init(), but all clear when the KUnit runs..

I'm going to try and understand better what's going on, I don't think I can
reproduce it easily.

Thanks,
Gabriele

