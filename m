Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723883;
	b=S1eYnnCP3l/JLTBpT0OUBJORZ9C9unCaBXAkX+FZg7j7wAG//pWLvjUje2HBydZtWPHh
	 bQkkZfxAERTgKw8jDtwoO1FynGjrrHeigtTi8KXXaKxU5tzglN1yNKaN5OBMIxnrULTOH
	 FPGrfHDsP1ED0nvGra58zfvRON2ly1iqPu44RXG50PgLWYG+70Ipeb6LzEl9c0CoAbw53
	 ODY7mFY64dBRcfgVTSQbQLr0HjYeCmxwm5vDQp35D3Utn15bqxnwODhJBGJp0Rk/+sIyF
	 +z0GudRd0T7s7KOpiHbNMbhh+9DMH/6SXkU/mStCj5kmbr79fDKGIGuiJ8JsfPy1pVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Nj/WNmNbH2CCgoWWWQhTKahPha5+ME+4yoPGAZbSie0=;
	b=CTbJHgAhUCybQHGtABMyWQI6IG8yKOwL8E9TsaWpxl0X+wqBQpAVVnaAPxwWtA5QFedq
	 WLMyD4TNNItKavQIC9xZjf95nazrCGTjCSRwI0VNB7QCvLdJEaavLVTSbg3GiVYej6pwY
	 lEKDiuydWo3jFoQPiw78BPUbnuEOjasyVpqvEUTq6q66HKdt9rSrru/5P1dcDeDTWEuft
	 M608Gha8KVVeVw32V/1lxqsJzDjCwagKptMcSQEqexCRZux76NagVxFCCNq8pyS1GPUHz
	 Jdb3Hbv/WKI7EJbG5falZbyF/5eUWCjgi+n989PL4Jq2ucExApl7siwB1+9a8OurzLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n5wLgfHB;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039F9606A32C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 20:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 039F9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n5wLgfHB
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso39975555e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 12:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795723881; x=1796328681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nj/WNmNbH2CCgoWWWQhTKahPha5+ME+4yoPGAZbSie0=;
        b=n5wLgfHB651Ue69O8vuJNdc3m9TPZ3NV736Bukjoncr14J6JE6ZlPSDZf7cla6cn2V
         ORIDrgd2fLu04O14u8BfyVeJIx/nMFXCAfZYs1bDJyr1l/pY5LDq4+l08uv5RxnwOYUn
         jpnsmkJdjsLEsI/NL/VH2wmaRpWXyzCs/GitGAGbHX/URfwmgNr0eDFACsg9gnwuiMZ3
         nTti0NiKz/zCW0Mz8EpKZEjCzFXKxGtV4wl0hX0zNn2Ym0v55YcaJhyqzVh4oUAYQzK3
         6XRiJH+piIcKnoulAcULwF6A3YlxwLFe0eG7SwiIq0o/LifXE064nF2hWbx6hdCBsUcx
         Y6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795723881; x=1796328681;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nj/WNmNbH2CCgoWWWQhTKahPha5+ME+4yoPGAZbSie0=;
        b=fN4RJKStsTxfg+vzcJ3gcvEXDdI3WqNMSiza+wGBWupjEuljkWELOJOugJKIr/S4wE
         7yLGH/1Q7vM6B/oly38kftrNGDz/JtEn7m6EBnnfS3iqUYWifjGnTdrqfkHV5I0zglXG
         nlWVgQzgcBrTQ4d2XYbh0vFut5I0Ms5bx3Shl/1kClW/MhLOW0s7tHuE5BOmo669beCU
         X0tYtxzMlk3ct54RzxuaYLt05E355XwlSv6BfDvquvUY7AXLeJcXIq5UQIIoCEyRCJ5O
         VdaxI4pK8UjNNnF2HVDvxxep0zbFpnP0Spx9bLZ0t05eCs/RaldFOtRh3X1qsQ0jVdty
         P6dA==
X-Forwarded-Encrypted: i=1; AL+hErGVxxj8MyO/VPiNJpk8tqTKdAwUJK13EqdiqLYVGkzERak2KmVOVodC8OTxki3yKrTnDI7e0MxSf5NRuQ/eIQU4k6E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+GD5H1eMRh3IBx/fXajC45OCqeoAHK8Xg79H2iPK6RdZ4gh+I
	bWPzpl3YgK5BDc3BRLf+bfLPf3GJsZRvlSqvLib7YqXnMWzQA7UrNP27ZLrpPa1sYw==
X-Gm-Gg: AZFdTZdgPITZ+YHRjlgHqNp0kl+gDsCUN7QAskNNXk8DtMVNI5mWNWM2z4VkXsTdvQD
	v9KefOXb2xiWqYSQsNERQ7NZo0og8Q60cXov8pQ1HtMCMKI3IBiL3LB6gTQZDACzYQSaG+T1l/6
	EfqlMWgUqyiDVyqngECSBRWMiHcAxLVaZkq6kgQC/1zSd3g6OPm2aIzjZR3xGDe9zGDcpAA9EfO
	aE7KvlqhLuUfsQM+GF+9Gg1dtmEY/Xlgivy+9Z7bd1OVThwYr+0Zen4Qg1i6CLnF1dz6u1YGWhc
	H6i199UiQ3AcHBUogYnpr+1hZb8aHcbh2+yUaSqOqOvUp2cvuxfDHnO3tSMCbjGdx+qy9/EqXEV
	Y8j7Vln/vYSGP+FjHVAyoEDa4gL+KF3ZFg4KLN3Wp4jTTcSp5B+1l/kNCLUf4Jv+f0idERF+6IO
	oLvADP7DWcA5il0JCbzSR+DcprtzemenB9Cb3t0P6Ces0LDsrkcNxzymTglZAk+3z2iGcO6IWlc
	QK281oe0wm56uEwThPS58c7C9/H1wD8akqAkO7xAL8ulgkxevzyUsQ2Yhgb0f1N8yg5OY4eQoRk
	Znym7//FmT6VhEHbcSij0QTKcKYSA+lQakcQaNf+bheymMTW4LpohVOOStGudqwQNdM4ghYtzSa
	DWERQOJ5FbJQE3EE5/z1L7Q4=
X-Received: by 2002:a05:600d:8402:b0:4a3:5a91:5f61 with SMTP id 5b1f17b1804b1-4bb88806287mr356853825e9.14.1795723881055;
        Thu, 26 Nov 2026 12:11:21 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm618620195e9.5.2026.11.26.12.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 12:11:20 -0800 (PST)
Date: Thu, 26 Nov 2026 20:11:17 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ring-buffer: Remove unused absolute timestamp mode
Message-ID: <awiSZeJM642t3ScT@google.com>
References: <20261105202814.1350312-1-vdonnefort@google.com>
 <20261105202814.1350312-2-vdonnefort@google.com>
 <20261124210350.718adb37@robin>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124210350.718adb37@robin>

On Tue, Nov 24, 2026 at 09:03:50PM -0500, Steven Rostedt wrote:
> On Thu,  5 Nov 2026 20:28:13 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > Since commit b94bc80df648 ("tracing: Use a no_filter_buffering_ref to
> > stop using the filter buffer") dropped the last user of
> > ring_buffer_set_time_stamp_abs(), there's been no one enabling absolute
> > timestamps on the ring buffer.
> > 
> > Drop the support to simplify the ring buffer code. Keep the read-only
> > tracefs timestamp_mode file to preserve the ABI.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > ---
> >  Documentation/trace/ftrace.rst | 19 ++-------
> >  include/linux/ring_buffer.h    |  2 -
> >  kernel/trace/ring_buffer.c     | 77 ++++++++++------------------------
> >  kernel/trace/trace.c           | 10 +----
> >  4 files changed, 26 insertions(+), 82 deletions(-)
> > 
> > diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> > index 9423722848c6..88c0de3619be 100644
> > --- a/Documentation/trace/ftrace.rst
> > +++ b/Documentation/trace/ftrace.rst
> > @@ -712,27 +712,16 @@ of ftrace. Here is a list of some of the key files:
> >  
> >    timestamp_mode:
> 
> I think we should just delete this file too. And every mention of it.
> 
> -- Steve

ack, I'll clean that up too.

-- 
Vincent
