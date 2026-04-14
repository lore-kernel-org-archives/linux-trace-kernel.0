Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525DE16A956
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Apr 2026 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776192718; cv=none; b=OskEUdOhGo3Na3T7vFXzJ0sxRJAaHm5r/PwsHTxVPbplvm/nfNpb7gsFJMh2n+LIdj5cOOHwHuMBRx+ANV5/ERgwZxey6xqre8X/MaHHaLZxG5Q3jp4LFgWFIIKImKYFFPhSj0wnkOV4dzbycYJR0NjK/BxB2tncZZ3+FlCDIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776192718; c=relaxed/simple;
	bh=saTNeITbhj1vAusEqOlKGEVedXElpmy0b5RXq2wxvh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2cZxD3n9k53VQgF81OZeVydKvh3pyvzi+hBr+k/n4/f0gQWHu1YQ5r7DJSasgxZH/QZZ1zAK0b2aYYnKrNgx9FxYTmFMQ0AMMrKF4GQglZ4R2rm6+OwAvzAlqEc1wSVWpQ2aVrM1jSCHkK5qs9ZHSpfsB1T5DKHRjxG9hDsqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NnQfCdXU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnQfCdXU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776192716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=saTNeITbhj1vAusEqOlKGEVedXElpmy0b5RXq2wxvh4=;
	b=NnQfCdXUBLgYkE8woNCDEHOmihPDwEOU98YYeCasbUS8ye6J5jLvB7QYPiqXnomhdcCRNz
	IGiJEN6JuAT8Uwmdanw0tcbN2ZMRshfX6eh0XsEB+1IT+Qn7k/rJRkXLpWe03v6ARDhAm+
	gxJuAcA0Ila096c6ddMyqz6F4Ekeb7I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-W0UOhYylOpendllm7az_0w-1; Tue, 14 Apr 2026 14:51:55 -0400
X-MC-Unique: W0UOhYylOpendllm7az_0w-1
X-Mimecast-MFC-AGG-ID: W0UOhYylOpendllm7az_0w_1776192714
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-66e6f1b315dso1565989a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Apr 2026 11:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776192714; x=1776797514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saTNeITbhj1vAusEqOlKGEVedXElpmy0b5RXq2wxvh4=;
        b=Fn4REhZ+ufzhuccP79CSpbA2g7i1v+FUQ4a3XkIKtRxS4GcVCQLpo/Jbadz6PyDeMz
         RBgxSzW1Yy1tKw18ORUkDqLHrsvD73E8/n0slAGTXIoyK0Y/wWPeAR1bQ4i95xcuq6JV
         OJpLwiJWC8WJ6g2Kjfbp5+Sygk0irxMRLIMQfVFNaRxOnA2xp8yIyjSjydzi1oYYMVrq
         NzeF1hCEZT6B+lw6xJBkFfIFlyVIUzc+1GhPe8HmAkNMZBuaUYDOe1eL6V91TiZrZylM
         U8DLKY90OQ0BB/A3FT2+wBm46cN3ts2srPAviiXfOeECuzPiHriH+yAgLTycSuP2t/1r
         nfog==
X-Forwarded-Encrypted: i=1; AFNElJ/iHL8OnnYuP0qsUgDC3a6lp53ObQRf6JfsWIqvKHz+eMAwjCk0CvNWD4E74MGZt10DUgM16fNdq52V+8KDK+P3lkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyICDSJ6PmoQHL7CWrLScVyP1Q2PfAxFliiADDlRW2lbBwJSbF5
	r/Dnmq187AV3BPD1Zq3aLYgmJF+jVdhFrfCvDozJmysTwc7g9kfGNsJi3gbNREzhdV/FTNQhidN
	UQLNLIiPUhEKRg9BZ4xMAllJEiQUs12r1BS+tpz1YIgEL1r3OMFwbJOd4OHLIu1wH9XeJpAUqMw
	uN9FySCCeL+79ouqAjXReb+mhvxm2a4RRNuODiJ7WWiHvOIZjd
X-Gm-Gg: AeBDievyCrYM5qBsIVK098vWWQA5C/pQ+AmlvRGO1xjG/wop3BlOCYMEq46rXoMdIGf
	6/yv+LQ3351veVrgqM5gofwo3LCP++uHz3/Owm8+JTiLVa00yqlvtk9ZIaV2feUZ5yP3+gmCHtj
	NIccGBCGPjP5+170DRHtUfTt7MispVV+/6QNal5pw7WPma+RIcyKRem7EyjuuPMxRrp3fb01vJi
	cCVfeOF3fPIvFQKABMFY4s6w1e5x/MfZL9TmUA7SCEak21juw==
X-Received: by 2002:a05:6402:a0d4:b0:670:2ca5:bcff with SMTP id 4fb4d7f45d1cf-6707a46fd38mr8036664a12.13.1776192713841;
        Tue, 14 Apr 2026 11:51:53 -0700 (PDT)
X-Received: by 2002:a05:6402:a0d4:b0:670:2ca5:bcff with SMTP id
 4fb4d7f45d1cf-6707a46fd38mr8036646a12.13.1776192713340; Tue, 14 Apr 2026
 11:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414140621.28027-1-costa.shul@redhat.com> <e5d69985fbdcacbcb47a1643dee0036ec93c3a06.camel@redhat.com>
In-Reply-To: <e5d69985fbdcacbcb47a1643dee0036ec93c3a06.camel@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Tue, 14 Apr 2026 21:51:17 +0300
X-Gm-Features: AQROBzCI47v-Ht3fWmgplTJlGQAsVi8MCJPDCfbgL2esadDyWNYJowTHOo9411Q
Message-ID: <CADDUTFwTuw0HP1QRd=7=Whe1aFskA0qwgUKZuG2Ax133Z4pPxw@mail.gmail.com>
Subject: Re: [PATCH v1] tools/rtla: Fix --dump-task option name to --dump-tasks
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2LfToGvBQZxlUCHrIaZhdtEL9MDze5_t2sbiqVMvKE8_1776192714
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

> How is the getopt_long table not the "actual implementation"?
You are right. My bad.

Costa

