Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0D319E7F9;
	Fri,  4 Apr 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775044; cv=none; b=AOX0uq+qmLq2khkDymfuu//Fr3nky7VTVl8sGuAQNpAw7vDdE5fKX96Na8j8QtxXrO8B+1nmSuXhGA/MABPkuqbL79xgnzqOx12cS3DScu9IE5cIzMNSjuCZzBgp/PConl88g+qe4PMlw+QYj3mkPnhczEhWiiQoAlDZSrckAHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775044; c=relaxed/simple;
	bh=BS7LwVsvcEvds4fCDGwH2Q9oRA8LVtJ3ewWZlMLWeDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwApuqe2QvwJ6V12iF2BQq65y3PSyyIEtfxYkcMX+STc44vwBwY+U7cUQTmBQM1gATPKK6VHkrDZnYGQXw0T3yqFABs7v2SfQCOjSUOT3BxPnW1qR5pvJJBRUlJ45p+0Ji00uP+OlLQ8LOZmUr/Gk350jSXHfwL78bLy/Euy/nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDt4T99E; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDt4T99E"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so24849526d6.3;
        Fri, 04 Apr 2025 06:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743775041; x=1744379841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BS7LwVsvcEvds4fCDGwH2Q9oRA8LVtJ3ewWZlMLWeDc=;
        b=CDt4T99EhVOgVlK+YalNv/MCsewZmvn5cvzCFv/RPyQAxZWb2xU4OQeLJ+09Bed6r/
         cFAPreEPpZit7PesmyQSK+m19k4DFI+ibof6sa27hhGBFm710y7veASmj5rGbpbUI9Ly
         kp6VuF961lrAzd1R5nnmg3bWki6ss8vTzP7NLfJvCd6YcQb4YGNciNrkX5x8rmeo80sW
         Jd2rgPRss4/GA+saIB1u1STGge/YOeimYudHqbt4CnAAtWAtXmS5U0GuzIiFx2hgWG/L
         o4RTWDIhU6RD3cDViAW+mb3iCxUQra8LKnVH4VjlQaVOSQil73gI35OWemJTkcJOXn8i
         x+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743775041; x=1744379841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BS7LwVsvcEvds4fCDGwH2Q9oRA8LVtJ3ewWZlMLWeDc=;
        b=Kd+Lq/orrqBLUDsa18exx/GPJHzUVPCsKH2SwglCqulMfHgjxd81L35UcXLzZ6I9KU
         xkUOgLQ9kP7u3cB9cf3olz/H1EQgYUQz3hz+6MkHOE8rMeYuiqbIeyngi7Fmk64qD2Iy
         IwCM0xdg8MzEougXTSMSFHHO9l9xYA7WPkhIr3BFqlqMvAEEHZ9Tx5xGB5aZLK3czI/a
         j9lOShJm5hzSA6O/H93yI9Noa8uPJSB8IgZqsK9rgdBJr2i9uLP6bUZRSUFBbGOJViKS
         c/o386rZirq1NdqcvveamLvkXF3ak1pnd/uzSiHwT5feJuMMkChpfJxyXfeqgyBDhNjJ
         ZMpg==
X-Forwarded-Encrypted: i=1; AJvYcCUAU0j3ISVWwS65xrFBWILSPrAm1VeBDPLBw+f2h7vVgAhzPdc9HEavtpIc7tX/5KiQZNVPovmAV6mKEvnIqBt6Xj6P@vger.kernel.org, AJvYcCUN3xUrOyj0rAtKElZDVV2iTyx44uINtjSxfoHzVHet82XRFnOEJyemlhxIpKW1uJwLV7y0e3Oyw2/O3LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVRtkQr5VrGfvfN4uDh0kPsfrmiAa3vRZbh2h3gdOW/NKcfmmU
	LkQOChFZAny31cJp6TjAbECbpnHeV4L1VPTUcolWjZPq/5mtYk2XQW8U2ztw0+AVV+MdBOTjc6Q
	9IL0qjxDfqGPVXz0elNvN6IN9YIU=
X-Gm-Gg: ASbGncu3sOpf/SgxbkTaL7JFsTY802qq9esFDwzM/wpGs1hH1cjLtlryK1Nrhi5BqU/
	0gjzAmFcdSqny/Woe69Z8oKC2c8w+K0CQaJsrOQrIGU3Y82LkTnKB8GGD2SW7WgVd9R6s0CbD20
	2qz2ygYYMVnYQxCMeO1Uj0qtVkArze1cAIO8OSKagT6uRS
X-Google-Smtp-Source: AGHT+IGHn2FxotW2K74/AfRMWLHzCd2kOAhDB0UVSAw7TQFTim+PGN0TdfATtJXR6MwUUceFgiKPYsxXJcHWwvcRNz8=
X-Received: by 2002:a05:6214:2466:b0:6e8:9d00:3d67 with SMTP id
 6a1803df08f44-6f00deee4b2mr43322626d6.15.1743775041513; Fri, 04 Apr 2025
 06:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404133105.2660762-1-devaanshk840@gmail.com> <20250404094632.26f5b7c0@gandalf.local.home>
In-Reply-To: <20250404094632.26f5b7c0@gandalf.local.home>
From: Devaansh Kumar <devaanshk840@gmail.com>
Date: Fri, 4 Apr 2025 19:27:09 +0530
X-Gm-Features: ATxdqUGcnbjHC-G8z4L3wv_hPbaBN5fQCbL76tCeeJ2o_WE1xtoUrcMXyu3g0Sc
Message-ID: <CA+RTe_h_rUpKaLpvZG=49BevKmCudiqOPSyWL3-a+ceH9Z+kPw@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: Replace deprecated strncpy() with strscpy()
 for stack_trace_filter_buf
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Apr 2025 at 19:15, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Is string.h really needed here? And if so, please keep the upside-down
> x-mas tree format:

My bad. It was auto added by my IDE. It is not needed.
