Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B763322C71
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419832; cv=none; b=DEeqsa/ybC0nkz81PCZmtGfaWE96XUY3+5zCo8AyFi0BP7dmBMTNe6PQrKh8liklRow5XMI+XcCDwgTNi7acioLSeqM0CDsWzk+3kWkTO/STyDg37QUZcGx2mLpcMUBzVIEV+nyqqegeeP6L23ZYLlc5tAfsoq0AsIiYXlVyGYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419832; c=relaxed/simple;
	bh=POQ+KrDMZzWUCA/637U0YCLhbicOSpe5n5QI1q7mb84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLTUPAak61rqiOE2pJGtqEl8Xj3heuBn9AIBiwTRuG83LWkfht7TrNyZI3rISp/Nd7Wt42aDCoT3F2Nrz9yeAuhnmVxpZMM1Y4IPBx6UrXFCK00r1KHqmHH+jYHOG6MqK9OgiKjR9zbAv82UEOFiRo391XJ7oeMl3vFAlBKovPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVrefgRv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVrefgRv"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45debcea3aeso9806845e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Sep 2025 05:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757419829; x=1758024629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6WMhFn1C+Yx6W2wpeHv5vlp4fLrLgkTAzBM0vbXLgCo=;
        b=wVrefgRvUT8rRksfSnZreHt72dTzRAG1hwOmA/voNnx3pQRdIyTucOh8F3JgnBEnQR
         FXuob5wOyqr1ePi37m3pC93uH4FcGa6TfSfXV3AIek0PO+7ocy9KKjuyEVWa883/ouYm
         uWff02aV5psLyt7EH+k+ka6bP1bUqmzpmIiw6YXuyNO5khxA43k2RnzLHzblNad1k3tq
         bWoTBwT8Wyyl3he6/Y5MNq+7m+/qjI/N350lgZpDe4uAHD6HELALy/WIAtmWX4K+uqRr
         dAZy9jT0baNPYftmSq3NqUij6L/OvOVnaQjre8crBwcM2hjrpNZhyAAuwB/M8c8k0/uB
         uKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757419829; x=1758024629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WMhFn1C+Yx6W2wpeHv5vlp4fLrLgkTAzBM0vbXLgCo=;
        b=tY361myr4EijoewRmD7cpijVOZfWpFPAcQOptyFq5/SAqYXn3oI1pJCQUIIbI1aN54
         sAqBgX8liWbfLdmlur30YJBHWnKsoHkJi8vYkbEbtvgtVF4I8TvEIaQpIR3mRnfMfwiW
         DUcCFv+Qy0WMwB6edgeRYmvAauIQfOyis+T18BRqHuPqeI23TrrH3wi1MFd5bRvScteX
         R/CkLVzgZLLkFZcMBZDy9wU8r4ylt4V0I8dh6tSpmo0492uYYcZJ6wVn0o1xuS2G+yJP
         ruimMq+TBxBMcp9B64CVknIM9DUbsznwBKBzqUlizywTnA5V5JAIsCLRnG3x1ZrN2DCH
         3Y+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPxu/6BSLh29o82KwxctSHOdzhzNy/vpEqAwdAA2IIe2UQtVIb9aNnOuBNeS2s6+aOl7ErK9qmIR2Hs+wm0Ot+Hfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr8I2/zNCJPZC+tyeQeBPUkhhtpFXhx5SYt4ZLIrRXYO/798F5
	Q6JY2z94bc+5nc2j7ofvLY1XOb9P3mwiOUHBrkL5HVBtHqLj+J79KiRRMOyGWFCamg==
X-Gm-Gg: ASbGncu2YCitJ3daInTB2kLCumaiEpuiQ+HlK8vz9czbPX4mN+8el0htZTqTcmOxbzK
	shQhAvJj3qI8+vti98NNINivLODdSUv2mdtpa5V28G0zNtWlXEtBlXY150212FOAbaVXACOnPb9
	3P3PSQ2g8SFwaE3Rg1IdAz9BkaIbSnaoRmGGRz6Za47pZFti10m/ds1Uaqu21l9NLik1kgStkC1
	urE/ldXfmHben3RzktkS0B6CXg4OMR/FaWILvVmfnGKEiqg2MvODU/9VM5+zsMmhrjTnHX4YXiW
	+agSUnq9fvz79V7MBb1oCAsPv6EV6RGzhek2cXwPn+7Th2i0MJ6S/zERo7Tpon3sRaCKNiLcNtw
	iCU0BDyiAXrnbPew5VLn4CC3PrMy5cztqaLaDsUbvU/gwoofN7xF0X0ffKluvEItKT+OpWA==
X-Google-Smtp-Source: AGHT+IEC0Y6r4tWAAX1HWCsbBwXYE/aB19u5wg0kytabUISZq9YPIfqob+aeZg0wKmLtsUPhiNDWVA==
X-Received: by 2002:a5d:61c5:0:b0:3e7:17d4:38ad with SMTP id ffacd0b85a97d-3e717d43c09mr7390502f8f.55.1757419828720;
        Tue, 09 Sep 2025 05:10:28 -0700 (PDT)
Received: from google.com (211.29.195.35.bc.googleusercontent.com. [35.195.29.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd2304e16sm234800165e9.7.2025.09.09.05.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:10:28 -0700 (PDT)
Date: Tue, 9 Sep 2025 13:10:25 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/24] tracing: Add reset to trace remotes
Message-ID: <aMAZMaZJ1_Eny5Ku@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
 <20250821081412.1008261-5-vdonnefort@google.com>
 <20250908193757.079aae76@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908193757.079aae76@gandalf.local.home>

On Mon, Sep 08, 2025 at 07:37:57PM -0400, Steven Rostedt wrote:
> On Thu, 21 Aug 2025 09:13:52 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > @@ -400,7 +436,9 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
> >  	    !trace_create_file("buffer_size_kb", TRACEFS_MODE_WRITE, remote_d, remote,
> >  			       &buffer_size_kb_fops) ||
> >  	    !trace_create_file("trace_pipe", TRACEFS_MODE_READ, remote_d, remote,
> > -			       &trace_pipe_fops))
> > +			       &trace_pipe_fops) ||
> > +	    !trace_create_file("trace", 0200, remote_d, remote,
> > +			       &trace_fops))
> >  		goto err;
> >  
> >  	percpu_d = tracefs_create_dir("per_cpu", remote_d);
> > @@ -422,7 +460,9 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
> >  		}
> >  
> >  		if (!trace_create_cpu_file("trace_pipe", TRACEFS_MODE_READ, cpu_d, remote, cpu,
> > -					   &trace_pipe_fops))
> > +					   &trace_pipe_fops) ||
> > +		    !trace_create_cpu_file("trace", 0200, cpu_d, remote, cpu,
> > +					   &trace_fops))
> >  			goto err;
> >  	}
> 
> I wonder if we should name the file "reset" to not be confusing to users
> when they cat the file and it doesn't produce any output.

My idea was to keep the exact same interface as the rest of the tracing. I could
keep that /trace file for compatibility and add /reset?

"cat trace" could also just returns a text like *** not supported *** ?

> 
> -- Steve
