Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0805170A11
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Sep 2024 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726266548; cv=none; b=KVScJN+8fGWmVm8kytnYw7Flk7QUM9ST6V703n1eyqoxVEUKIro2d+1DzK74fqTdXdO3v8J0CvjeNikIiOih4b5cupnEaxWuPwHIc/YW0N3QLRE/8lGXym784/4MsGxr9S+qaEvVT7a14JGNojp0AfEIwHgbkOEW4xdy1xEqBkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726266548; c=relaxed/simple;
	bh=IvzabYSh+pHeeHd+hD1FOErHkOCPfysKNWasduDGcwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yf+ULfpcQnZMtjnmyyKnpX3SR1/kvnlPB4UYsd7mAqUsk5hPHCC9hRJN/WDCz+adaqf1EsokdjAVRG/1ZzsKPIL4mRbY+FgY/PXeLqV56X6sWNNGAaUWoYYJRROr9yqEb9ToYi8Y90JO4O5auFIxKaFFsaN+5+nG8yOLsohyyYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fT+wurmc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fT+wurmc"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so161234866b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726266545; x=1726871345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvzabYSh+pHeeHd+hD1FOErHkOCPfysKNWasduDGcwU=;
        b=fT+wurmcxfAuJL3JFVqksvipHULlUHiaSdAwWeQUm5Acr8M2Vqed+mCp2Dvat8vV/C
         iByEJV/EHqOMKn0w9+zxU3AEdxOMrmwNfiSUEb7nLMH1msXRrjcM5b/iQMG6Mb7YRU5N
         j+0tZz098AmE+pDNU2nL9HY9xb7LKoXbIOTi1+Plxd8Vw8siD+Ungm1snDX6hfiXT8jF
         dQuhhVDHkVXQRtwdr14gVJ8rjZHIeVZrs55KWn3XUl5uKgZL8Fch0c5H2LmdieT/ZMSP
         HoU5AR8xMlPN1zaizbmuFxwahnNm5q9Xcgq83kTTxKqpyL47tugtQpc66WErjnKBkwaV
         g28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726266545; x=1726871345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvzabYSh+pHeeHd+hD1FOErHkOCPfysKNWasduDGcwU=;
        b=XaIhZad40TAJhzzegiqQqlwuzYh80oJSBld+j3ryuaxumQm3hzHP5YK3W0frmfUNyk
         P01WPUssBp0XzKTlxA0aVPWVvdQZrn6GyXbR4BW3AK5Hl1v8AzKwH4O56HIohwNXG5uE
         Wf2+mEeJGfdXcub1xBTxZmf+CeIkVBaVppkdRBKf2nDt1a7BqlLHH6QxsvPufI5ifq0X
         aa2RyXnfBoIX32dnhwrRJkgh2sJ8E/KAIETMcwKaWfxjtXo5Bfz3ZRKMUQKTfI6sSYVX
         HZN0aGaVXGvJzLWOME8LdaAS9nnL+or8qeWRLOJh9hFDuyHR3zCwR0fknQd2uTW0J1a/
         4IlA==
X-Forwarded-Encrypted: i=1; AJvYcCWyyOJ2+7ce8TGQEIDPdCrTUMIbn/cC8lyfie9Cx81DABNyydevBqK3yKBCjKGHMJ2hRqa55w7Hw+Ir97SoMXetTO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKCTsh9nD9n7IWWfFnABXlu798UToteCGB6V0STJ8NyuCPzxk
	k93DAOARCRExXZiHqYnpcNKToUFH5fjg8kDuGl5yo6QA7qnmbysdqFDqPnkaszKDBNRTS79ZmPl
	zEwDYPpyxU8EpOQ3GpcajHwsxmF2UaSfLfPw=
X-Google-Smtp-Source: AGHT+IGz4HrZgTUzfTrywk01MKDCVDNjEpFYnYsoSdttd9K4GG6wqFFHYTex9HUp/m1OnssmyakcUkoL+HyjINOHmus=
X-Received: by 2002:a17:907:f154:b0:a8a:8dd1:b2d1 with SMTP id
 a640c23a62f3a-a90480c79ddmr413023366b.55.1726266543519; Fri, 13 Sep 2024
 15:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911093029.3279154-1-vdonnefort@google.com> <20240911093029.3279154-5-vdonnefort@google.com>
In-Reply-To: <20240911093029.3279154-5-vdonnefort@google.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 13 Sep 2024 15:28:51 -0700
Message-ID: <CANDhNCr_cCeLdqMTwNwgCCeiPifSsew_-hwOC-WY_-PvaNiC9Q@mail.gmail.com>
Subject: Re: [PATCH 04/13] timekeeping: Add the boot clock to system time snapshot
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	kvmarm@lists.linux.dev, will@kernel.org, qperret@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	"Christopher S. Hall" <christopher.s.hall@intel.com>, Richard Cochran <richardcochran@gmail.com>, 
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 2:30=E2=80=AFAM Vincent Donnefort <vdonnefort@googl=
e.com> wrote:
>
> For tracing purpose, the boot clock is interesting as it doesn't stop on
> suspend. Export it as part of the time snapshot. This will later allow
> the hypervisor to add boot clock timestamps to its events.
>
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Christopher S. Hall <christopher.s.hall@intel.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Acked-by: John Stultz <jstultz@google.com>
