Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235F37187C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847707; cv=none; b=miMdow7b1lCsaSjYLd9Pbz6x40tsoYG9DOcoFup2UU3eJyV8pRnRQ/nqX8J0tY1SLGPcvo93PzO7/khT9TOVED043pB6OUixtlkzHJrNuxlkJWvQnAGyvkQsCL4ODEsA75wxd4YD3JsYSlVR+E1cef67iHYlP/Trd3YpDo9ncck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847707; c=relaxed/simple;
	bh=O80S3pjkeXSWObOAxYWMssL152HBOgoLeVg1gUU1MFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ll7A3H95gw9crqfxoo7Y8HXCWSoVN41sB8XjcB9LNtvHKWhWsvNStKbDRzu82BhF5QGOcCB4g2bmLubIdee80FSG5njniUQ4bxZ/Ho1tHS1jifBi36/f+GYiD3ke0xKLmRSdYq8xDynMIqSnxDkswX2Czz2Re/GimacbQFtVx3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ccQ4mwvC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ccQ4mwvC"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so15026565e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787847704; x=1788452504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xgZRRPFD/4tuccx91/eOfBZb+vhsoVmREaFx21ykfHI=;
        b=ccQ4mwvCr/2Hf0YCgNNZ0mWQ0u2yv2oNuqmGam8j5SJ9ALrzhJa1He53QqVsw0Ez9n
         /1rOwV8Act/ugNLWrsqtzjRK5avfHx61RTur5yYNQaIa7GseB+EARAr2OUjFh3Ef58RN
         5hdb23UhRGPiNzAXgMgA1eCnIKdK6gQRzPLlysT3UAyC2ZxANL7RMgjaNpb6+3MRygoU
         Ozs8jy9YmETdcgNfw+kcAZFs/TfeJTzJOVHuNS7z0/yMxgVpqiv2lINnYY7pnHiHjQ+q
         GrdDM9IDSdFvbjd7ySAoviv+gfsDZohVvuZnObPauAFDPqNSt9UjFUhGqtAXY6YEiZSO
         4Wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787847704; x=1788452504;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xgZRRPFD/4tuccx91/eOfBZb+vhsoVmREaFx21ykfHI=;
        b=NKuyg0Ig1beQEcehAgPSGvzsYC5taz9/F4cv/mXeusff8HDyNQYDKxbuGagv6RxgCR
         RCDd+s+i/KkSK8Sb6YI5xq/eQPSa35q30ohYdwgBnHVWud1qJNSE5NiFh2dcKimyNh9k
         kLg5/KteX4TFKLbF77I7Ry/a7/Bqq1vZl5YFtzcz/CLwKJFMe12ZJtFHXh3Ybho/5gNS
         E3/UrGTSEPc3Nv7wQEtdH0R5p03hyTNzOTk+TdBSpC3k7Q6LUCjyJ87Dl2aSkLwEwmzR
         vnnlPtV4Y8xSmIDvVgnQYWX+oZQ9hsTgMITHaYTYbqGacfoQwofwNoZAgBdAuIprhuih
         kg8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpJ65/MABmXrdLQMKMPiP6wrWodNzVXYE8ExY72jbl2TipKuwb/iCMfHsUZJqNsl+rIPVXE3KTDSNLqoynNRHXnAzY=@vger.kernel.org
X-Gm-Message-State: AFuF++mDgdnK0bNqpBd0N2eiAfrRofAcBKP35Dj96nEQB0KP8JbgIANa
	CWMY/ZhQH1UdH0HCU5p4cWkExIyhkarplKFNw/BKUwvg6nhq8d46Tpd4VyVXYEWOvg==
X-Gm-Gg: AR+sD12rUiNz2T67tK+0bqZQ09NwgafDgvv+EQnKmVBirqS4lL4iQqps9hVfVNN8Ssl
	TTE88BMYV8nq40REBds4doJ2C1J9JTO+z1rPKcg+wnHSuZCYzVSiZHv9yxX2532mBU8+cPauskP
	HpJgLdP1jG9uWXgrfmepR5+w+MQ0ud8rFk2DIVy2ou+xOgZSajKgs0nNXDkp3sq8S3UNguNsG3/
	phPSJ8SzRFqhB7uNhxrciFoq5AQCzLawCT9pRNuL0tzR1mAOpjP08PC2kXFpdc2ol+GOeQOKCjk
	sIOi3TrLTj9NKm2V4M0JtODi0/Yp8tET/eu0I3Rw8LBidVQ+YMsh18zbCJat+BtC0k8A3Ck7FMt
	nEkbxXlWl7vu3hzFLnogGz8ena2IOI7+nL9bHgL5UVjJpWd3ztrA8AdzNsXEYElq+CgsQNLSzeP
	zbtnC0lm+gG7IxeVsisAI0mdRhk+iL4FpKxoaRhiXNrFzpeE5Ae34epSqr9by4bXJN8JoPE+fH+
	yaUFfX+Ke3pIemCb/oXLa79nzu8h4ob
X-Received: by 2002:a05:600c:8885:b0:49b:909e:922e with SMTP id 5b1f17b1804b1-49b91c4884amr767005e9.10.1787847703719;
        Thu, 27 Aug 2026 09:21:43 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c52609sm108385e9.2.2026.08.27.09.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:21:42 -0700 (PDT)
Date: Thu, 27 Aug 2026 17:21:39 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <apBhLDTEa_3yYZP5@google.com>
References: <20260826094528.3738023-1-vdonnefort@google.com>
 <20260826094528.3738023-2-vdonnefort@google.com>
 <20260826095947.4FF8B1F000E9@smtp.kernel.org>
 <20260826103736.2b55b464@gandalf.local.home>
 <ao8TQ-SvhjYgy43-@google.com>
 <20260826143123.1b3e3854@gandalf.local.home>
 <ao_Zu0ThaWThj9YZ@google.com>
 <20260827091541.5d03e33c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827091541.5d03e33c@gandalf.local.home>

On Thu, Aug 27, 2026 at 09:15:41AM -0400, Steven Rostedt wrote:
> On Thu, 27 Aug 2026 07:31:23 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > Looking at the function again, shouldn't we add !rb_is_static(cpu_buffer) as
> > well to the full page test?
> 
> Why? 
> 
> -- Steve

So that the splice can make progress when the ring-buffer is presistent or
user-mapped. Or do we say that's expected behaviour? 

-- 
Vincent
