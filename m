Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194B23A9AC
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531741; cv=none; b=CsgKY5x+VAIskgosSOdJY6MHs+qhC4fVrGk5HXJg2QAXSUlDVtWqW9AjYhVAUeRRFw7yV5XUx7Ur7llj49/BNsW/GBtLJy5cN468PM727yEnfF0TT5GEaaXjZjdNMfiOm/15grdQ2cfinYOvDS+PnI6FDo1RxJGgOHDQMJwRU/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531741; c=relaxed/simple;
	bh=PUc3QdosbHPXkAkyz/Yvw31TFP4gs9runVGAjzZ7t80=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kto+sgp9ouVdsGdtVWQWMEMfI3YzO3tpiqLLu9X5o9IBBCOq5KxvTJciuQxOUEe5eRrJ3h2dxs2XOd2nv4Xp13ahUiq5Ecg5dGmQLgMD04w5OhFHqFkafJGfwf2GMO63NHgUSohHrL//mtIQ2UHTOMjHxxA82cPda05BF/Th08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYR2ZwGs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYR2ZwGs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739531738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PUc3QdosbHPXkAkyz/Yvw31TFP4gs9runVGAjzZ7t80=;
	b=FYR2ZwGsIHJ1nHyCdhKHNmpY7FVR6cHV5kjR+lgv++eQbX+yUf87W3TH4KqVRe7+NKTnH4
	G4DcCTJ1OWo02BtKc5be5X9l+rlw2DeiFb5jy3lebVXiKBrfHhYW6AXHWLgNfp06AD10Er
	ewm4V8UCEOhd934kA2iDme7MiyM8wVE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-z9puO_l8N12hx3WwXxw62Q-1; Fri, 14 Feb 2025 06:15:37 -0500
X-MC-Unique: z9puO_l8N12hx3WwXxw62Q-1
X-Mimecast-MFC-AGG-ID: z9puO_l8N12hx3WwXxw62Q_1739531736
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394c0a58e7so14549315e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739531736; x=1740136536;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1iQIbvDhgSHZ4WT/gbEt1daMYEMQVwHES/A7FJ/qNY=;
        b=XxUFNj2Xq/qKkYAWoCY1Vfrr1xM4wVybZjb98rmmOZvB3OWmho+biS+wBn/omtz/3d
         O8TEYVz8vDDq4r2S4CeK1WQK5/WamgM6vrx2kOEtOlILMz4aN+YjLkCrAQwFByyUqHoB
         oRgXSEdGe5ZztfBpNQfDxbKOdATsB+W4TT7/9Qne/Fc4rhQkm/EUeb966d20PMuaxxo9
         lC9l/kok0ymAaWiBZySegD+tGXFAHPFgmX3HUC9Un4ZmvnW6ey+tw7OYWCIAzpMaCYJQ
         fSTOFT0hB32GwpPoiw0GjrPuF5F0FQR9s5krGXQ08f7Mk1eQAyolZVPpUS14vfIB3slw
         JiSw==
X-Forwarded-Encrypted: i=1; AJvYcCVK20j2OxdoFCXHau4Z/uuO3AAbVlDo+5urszxr2oZQLQ3JAA2rGfMCqJwLdb8Sc+s/p/SloTpuRiK0FjyZvoRThb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN5Mot7JXBAQP4Q/877hj+tRONpUaLmnQftSEtTGBG672Pe0yM
	DJl14nQfvs1+aI0cHAeoW6LnIyverXV7pfW3TUrhknajC76cUrSsu9iT8VnnRd4IuNesMyc26hT
	HSLm+029VbzwbhiG3QYnmq+mkqtamiQrQqamLT5eHIVrTYxySIeLhaakiDztxCzLq2Z65Gw==
X-Gm-Gg: ASbGncvpBxe0oiFKeOLFqHLP76sFd12gcciN9n5UFV2IxS9RAs+6slNdpDW56mgNWiK
	34UExg0CWkZyIcvBUpHL3NIdoFx9N/jIY+9Da3qJinq7XppWE71mCbj/S+3zrTU+Wk30ie/OCKI
	kowBvwN9z0ufNSPDe6XVxljwSGUuyJZw3Qa5CfcEkvLWF3IJ0kVrbGvAaQty9yJ0n31yh3xJyNN
	+94M85D0MFJVYRRrtaJoBhiOT6Hnk/YXxtInV2WAUgexwydQvMw+d2Fq7GTCFQKqE+7OyuhogV1
	GPhyvQ6k/eUPYoNJ4/7wkPMK52omZSXbrQ==
X-Received: by 2002:a05:600c:19cf:b0:439:5573:9348 with SMTP id 5b1f17b1804b1-439581b88ccmr119294185e9.22.1739531736303;
        Fri, 14 Feb 2025 03:15:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkfOw2bzXtZt2kXV8bZhrLtsOBgcZjNkpTqtdBEsmjzhSmT9IDyjozv2rFlJKM3Au+7OdF3w==
X-Received: by 2002:a05:600c:19cf:b0:439:5573:9348 with SMTP id 5b1f17b1804b1-439581b88ccmr119293675e9.22.1739531735938;
        Fri, 14 Feb 2025 03:15:35 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961645422sm27024865e9.2.2025.02.14.03.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:15:35 -0800 (PST)
Message-ID: <789b56973c0e6419a6a44210a18d1b31d0daf8e6.camel@redhat.com>
Subject: Re: [PATCH v2 03/11] sched: Add sched tracepoints for RV task model
From: Gabriele Monaco <gmonaco@redhat.com>
To: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Juri Lelli <juri.lelli@redhat.com>
Date: Fri, 14 Feb 2025 12:15:31 +0100
In-Reply-To: <202502141516.OkUInaxw-lkp@intel.com>
References: <20250213090819.419470-4-gmonaco@redhat.com>
	 <202502141516.OkUInaxw-lkp@intel.com>
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
X-Mimecast-MFC-PROC-ID: yDC6AmS7pOciEGD3kovejZh4_TQ41QcpEqYZGvfPIo0_1739531736
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=20
On Fri, 2025-02-14 at 16:00 +0800, kernel test robot wrote:=20
=20
> =C2=A0> =C2=A0=C2=A0 kernel/sched/core.c: In function
> '__do_trace_set_current_state':=20
> =C2=A0
=20
> =C2=A0
> > =C2=A0
> > > =C2=A0> > > kernel/sched/core.c:503:9: error: implicit declaration of=
=20
> > > > > > function '__do_trace_sched_set_state_tp'; did you mean=20
> > > > > > 'trace_sched_set_state_tp'?=20
> > > > > > [-Werror=3Dimplicit-function-declaration]=20
> > > =C2=A0
> > =C2=A0
> =C2=A0
=20
> =C2=A0> =C2=A0=C2=A0=C2=A0=C2=A0 503 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 __do_trace_sched_set_state_tp(current,=20
> > current->__state, state_value);=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_sched_set_state_tp=20
> > =C2=A0=C2=A0 cc1: some warnings being treated as errors=20
> >=20
> >=20
> > vim +503 kernel/sched/core.c=20
> >=20
> > =C2=A0=C2=A0 496=20
> > =C2=A0=C2=A0 497 /*=20
> > =C2=A0=C2=A0 498 * Do not call this function directly since it won't ch=
eck if
> > the tp is enabled.=20
> > =C2=A0=C2=A0 499 * Call the helper macro trace_set_current_state instea=
d.=20
> > =C2=A0=C2=A0 500 */=20
> > =C2=A0=C2=A0 501 void __do_trace_set_current_state(int state_value)=20
> > =C2=A0=C2=A0 502 {=20
> > =C2=A0> 503 __do_trace_sched_set_state_tp(current, current->__state,=20
> > state_value);=20
> > =C2=A0=C2=A0 504 }=20
> > =C2=A0=C2=A0 505 EXPORT_SYMBOL(__do_trace_set_current_state);=20
> > =C2=A0=C2=A0 506=20
> =C2=A0
=20
I honestly don't get why this build failed. The function __do_trace_
exists since cff6d93eab00ba ("tracepoint: Reduce duplication of
__DO_TRACE_CALL"), a while before that it was just a macro and not an
inline function, reason why no one so far used it directly.

Both failed builds are based on 4dc1d1bec898 (where my patchset is
based) and there __do_trace_ does exist.

Unless there's a strong opinion not to use it although the compiler
allows it, I'd consider the two kernel robot results false negatives.

Or am I missing something?

