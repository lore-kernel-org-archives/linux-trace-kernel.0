Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF22D42DFE8
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205418; cv=none; b=MEF4tuvSoDv2AQh6g+ThuTLYjwDZk361FNpt5cpFpdxrsSY9HM+5+l7gt2Zp9aNFU4iFuui9DfAhhBlRj3pm1t3D12Ix4GubotBV9C3VveefCDIc8hvvUBNOLadXZAtjemygqY2MlnJqQO7YXAYt6p6CS0C1lkENQY/ms5yJfg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205418; c=relaxed/simple;
	bh=3RD4LUZ80aze8TAeEIchYKqFPnCkLoGuWO2eUU4OyFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeTpEZWWBjQiVq+TSigHug6a9OChv4jMkW671pEDPoIoCjX/N4I0y/z1rfVg9zHz1Q9n1cmke1m5bdcipaHMbi0xg5VdVhdDbSooMpjBjvHrpmIWRUqcPxEgWuUsiumzLIV7opgs/xWsoVFeViecYm2KeM+4Ts54fx3tQWrIwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bau98NVl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bau98NVl"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso18801785e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 07:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772205415; x=1772810215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2HZLCVSoL8uPOb5uIS0KrR8+8oqmL6ZBVdtWORIX0g0=;
        b=Bau98NVlLJYE5qOo8CpYhHhGvR4sfAo8+iDXuFQGam+5h4PAIOvI8ZHtZA5yHHdPGB
         JYRN+JMXkFIRfno2KyC/KstsFKsrMRfSZme65f9SqR7nbVk0SXubioMNdFp7r+odYXb4
         FVpToTG8CV08sIEl7zBdMKjId6o0QDHMjFYOdcrV5hAYF/Ksfyz5/Jniw4u1gEJCpL6k
         0lmZg+pmWFAL6y2/ew6oW/jwk0uQNkZxN6oKvBXBYnctOe5pzd1eHWXyCW9C4Kezzd5z
         wuWXn9/we1Rf9b1LDg7wVAWUxiMQJERGrzkMcHkTo8+KRNuzdl7v/1smzaqHcMpf0hbX
         7IBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772205415; x=1772810215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HZLCVSoL8uPOb5uIS0KrR8+8oqmL6ZBVdtWORIX0g0=;
        b=V+xGdQ800wRCyzGn8UtmYwztjcXtORoyBbxBcE/3zHxW+uoNMOeKpNLz5Tu43xnQUJ
         lbYvOWAfHMvCFi6vyQdxZAA76rja6pDTp+zB9FEWEE6kdMxO7wOgBa1dX0GEBs5jDODJ
         cqzDeSVqaUKYPdN0OhFQ7qTJ8j7QBLiGJE6UeDO1jVyrcFnVJLg43BrZ2xXwzBGL4o6z
         EQ5ghQXAuWnIBEIV7GqNofGbIfjmmYa3d0cv2QRWltW4FwIfazPi5q1ckcJOV8ZC29wN
         Kcy9h1gBfody9WvsqIJ1oEvlgz5xN0+HuhvtznBO0R+M0wqAUybUpqLtWZFmQOx6f9jR
         ucMw==
X-Forwarded-Encrypted: i=1; AJvYcCUaTu4sLftRGkTPPNzHPGQk/JwcY/K2O+/SfH149sVycedBVxD6QiBXyyFi9Fxa88K5fym9KTvY2jcg5ONoIqApjZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXeKydwu+crWqDa0cZj5AsWj5ZyWVYVJquPq86rDC2PZltTZ15
	erWckyjCh1Zax2WXFeWVGnjIuMI4+/s5dN1T2ddK2Q/Up1JQqGcKR9Mm3JR/HPD43A==
X-Gm-Gg: ATEYQzwRPBRpJGrOSIKimxHYzZUo0hFvXhSbwbVFp2Uwi3MF3GcbTwnctiRgYwzwhWd
	b1SAAedS5/lGjVxbtBV98zPjSOHF8hpMJWudhmLQ8pNZXIAx0RB0B0aO7ly6OghwYb17e83PV+R
	UbwGGfjD/lYwH9GDPqKxkKJPnrEU2wvon+8makeu6PD3JI1R6XJ+WfVXr/WuyOxTeBT+76wbhfs
	Re1Um48qj5sZiYe5Azqds6Vmsr5cR4XurTSWQWpDWxU5YDRABNTvvbSBEPA/+JQRmwJPt/PV66q
	zouMYZWTmXxkdH3RiqvCw+UsHXR2+yKkqWF9cDXydlqnxbE3MrvsBJ6dZMTzO9MY/6jQTGzzxQF
	uz46SZmtNNvBK5aqI4y2qMOgWh1qr1QlZRZ8vBvCo1dfO0xaRAJrqwwe/XfybOrlMozU7XCIcMJ
	SpZ2aZVKaMI8gi6B9dfQKT5NhiW82vGX9+1nQhSsusHup/zO05QFZHhheVbUmJ/vH4eXU=
X-Received: by 2002:a05:600c:b90:b0:483:abeb:7a5c with SMTP id 5b1f17b1804b1-483c9bdb600mr53847895e9.12.1772205414739;
        Fri, 27 Feb 2026 07:16:54 -0800 (PST)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfba9a5esm144533085e9.4.2026.02.27.07.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:16:54 -0800 (PST)
Date: Fri, 27 Feb 2026 15:16:50 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Qing Wang <wangqing7171@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
Subject: Re: [PATCH] tracing: Fix WARN_ON in tracing_buffers_mmap_close
Message-ID: <aaG1Yl-HbPG3Buil@google.com>
References: <20260227025842.1085206-1-wangqing7171@gmail.com>
 <aaFrmHzIAkEe7ufy@google.com>
 <aaF0zS3xh5KgM_yy@google.com>
 <20260227101002.614add75@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227101002.614add75@gandalf.local.home>

On Fri, Feb 27, 2026 at 10:10:02AM -0500, Steven Rostedt wrote:
> On Fri, 27 Feb 2026 10:41:17 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > Hum, not sure this is entirely correct. We do set VM_DONTCOPY when creating the
> > > mapping (see __rb_map_vma). So AFAICT ->open() is not called in this situation (see
> > > dup_mmap())  
> > 
> > Ah right, Syzkaller is using madvise(MADVISE_DOFORK) which resets VM_DONTCOPY.
> 
> Hmm,
> 
> So this means user space can override the DONTCOPY? Can this cause bugs
> elsewhere that DONTCOPY is used?

Indeed, user space can clear DONTCOPY... unless we also set VM_IO. 

> 
> -- Steve
