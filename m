Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876F356446
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jan 2025 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736286412; cv=none; b=cU9ZRGasKs4cXTjFl91AKqgDLyK3FGsEBMKpltpQqFrCMuW9L9kA3hkd3Z0UXqUNuIdAkJO0Ez5sPLXXjyK/eNrE5YFWJNnb3AIAvoWtpOXgoSZ/ZxySvzeK+J8ul17Zqm9/G2yW1Fr+cLUVYBoOAouYB+/cRyeuvICDu0QTFbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736286412; c=relaxed/simple;
	bh=XwudySMYgDFkEiNkXy9QyJPVs4ozERHAt/1oE7xfK+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiwwpCcz1HxjcTc/LkAUJX+9vVwcBt1wpio9yrvMQxaJSbT7sAd8AmJBJIuSh9BF16C8wtFY2fvJfIvUyHhRozuO3HHMucN1mTkhF73ONN/3HxWM6DGiyNkAjf/Umszt7epnS11/rhB64zxvvolxW4wKHLpiFCZ1N9sslx4ag3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wJfoQGpg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJfoQGpg"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso110887215e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jan 2025 13:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736286409; x=1736891209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=45zDSr1nHXxJjlC8/IZ2CFZWXTQx1GFlSPewYhMnWhw=;
        b=wJfoQGpgAP+zvQ1tHLuLJ6gkJCFVV5U1bUWYdaP9ZOuxtkBpeklhGnOzZKC1cC/R52
         H6aCa8KyCrXckr2cFtiR1dZuAwPY0jeb9CaRUMV2COBtUa7UcnnddIrll6TQde2rjdMf
         MKs+XxseNzTE88Aa7PHi59ZsjVsO+943sEhIJWw0/sp3yEGWDrbKYWYn0upSjy5nTHhS
         dvAdbr6STVh6RuuyKwX+ge312BIbv3hvAEWpA9egj+JU/Bht5ZG6pYumjolVmdW2UMef
         KgsudTijMVfU74A7X+yBXKt40qg+dimtTDoejGW96H0gsp4UMHSGxsjcQdH6Ov5hHAJD
         WHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736286409; x=1736891209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45zDSr1nHXxJjlC8/IZ2CFZWXTQx1GFlSPewYhMnWhw=;
        b=piNKu1swGynb73Fzh9jTk9U0N8BLg7ZTyLOInaCgtAcP59WR0lNmZceuHxy4771ywG
         fR726ft/Q28W4u+7YEFuAOHXEi+LOLaJhz+tosUOGLuHOyU1XDirUzjDVfLxUFOG1zzT
         jYWZrDn+6yMwfBWjhAIGeQMolOQeVjmPq+kuxsgSe1CFjJQ/jxsbd26BkRrf1jv11Lpf
         or9JBtJax1BpqADeFYH06Dm6TU08V32hxGiDQpV5vfIzkVj5TBXLrPCj0+C5l5XrwoMH
         Ye4SPzhOlOAKiqPn+MY6muXVehWGb/Km0CXyEK7fLAaA6gVA2Rm3trJwOSAvp0cWn91B
         ECew==
X-Forwarded-Encrypted: i=1; AJvYcCWqM7dUHZMJC1LvykQWpS5r8POgGEcI9jBRNPGIp87aSD32TDeLfGUjytgGbNM3w+v89v28sf5X7h8oUesSOtGtANs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7CNPNqpIBvAZsUIc9uBgwZJh5lRw/SGYo3yHSjXeRxUhQtnvM
	IDeED6E7eHgBcBtaYvVCnTp7XR9GhLg24wyPKgihqlK74C1Rp2JzG1kTmwJm3w==
X-Gm-Gg: ASbGncu11h8hl27mgLHq+pdnkTztxe5pAZ8EhV4ARvWuY81D8wzSs8X5+89JCQIzfhv
	+Sna8F12TTP3ja4zoQI4KRFDioWAZ2oaYAbWJZjDUsB/NwXRGJK0a8o43JcbmTM0tM7RDcpXAPl
	GqnuXtrdK2cDA1ETitdzbO4J64CibBYKRFHqvonP+iGEr2ptdPAq8sVAxKpjffv+7VOhiKQYbAl
	MW7IwgzP9ww0RjPpiAhKYUXBefc/xR99ZeAxjRSPGoF8+81t/qaASGI4av5KAwHmOTt1n3t3YzE
	dI8jQR9Vhvbiaq4g
X-Google-Smtp-Source: AGHT+IE4xCpmNumMlx3DxfP6Vn9CkrrdyNZOyrwzPq8saTfgefufXF6XhwqYSJh/q7tze+l1CkakwQ==
X-Received: by 2002:a05:600c:1d14:b0:436:5fc9:309d with SMTP id 5b1f17b1804b1-436e26f6d80mr1746725e9.30.1736286408741;
        Tue, 07 Jan 2025 13:46:48 -0800 (PST)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0bb7sm11425e9.16.2025.01.07.13.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 13:46:48 -0800 (PST)
Date: Tue, 7 Jan 2025 21:46:44 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, kvmarm@lists.linux.dev, will@kernel.org,
	qperret@google.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] Tracefs support for pKVM
Message-ID: <Z32gxHCt363ye1Vv@google.com>
References: <20240911093029.3279154-1-vdonnefort@google.com>
 <20250107145439.5bd66362@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107145439.5bd66362@gandalf.local.home>

On Tue, Jan 07, 2025 at 02:54:39PM -0500, Steven Rostedt wrote:
> 
> Hi Vincent,
> 
> Are you still working on this series? I was expecting an update.

Yes I am! I had actually a new version ready just before christmas but I thought
I'd better wait for the new year before sending it so it does not get lost in
your mailbox :)

Hopefully I'll send it this week!

> 
> -- Steve
> 
> 
> On Wed, 11 Sep 2024 10:30:16 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > The growing set of features supported by the hypervisor in protected
> > mode necessitates debugging and profiling tools. Tracefs is the
> > ideal candidate for this task:
> > 
> >   * It is simple to use and to script.
> > 
> >   * It is supported by various tools, from the trace-cmd CLI to the
> >     Android web-based perfetto.
> > 
> >   * The ring-buffer, where are stored trace events consists of linked
> >     pages, making it an ideal structure for sharing between kernel and
> >     hypervisor.
> > 
> > This series introduces a method to create events and to generate them
> > from the hypervisor (hyp_enter/hyp_exit given as an example) as well as
> > a Tracefs user-space interface to read them.
> > 
> > A presentation was given on this matter during the tracing summit in
> > 2022. [1]
