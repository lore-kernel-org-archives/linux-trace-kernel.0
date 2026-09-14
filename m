Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA063BBFBE
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789412983; cv=pass; b=tDu1cQMCqT0VstwrOu7ehT/xsh62h9ZyrCixUUiteVXwNBoSFZgG7mRicHFuA78I8IJKDC3vkX9Qn198UX2tvTSCz37OLEEEgX7H62KzGa8qfuqj78uRV4zzitFY1PYCbSoCtTiTtkvP8K1uBkJth0XcC9aQgDhmwi2eOrbVZ+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789412983; c=relaxed/simple;
	bh=xk1YgFzBk6elfDd8JjJVnAZesHkNakF18ab0MQu8l/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0drPNvZvm+3eofc2XZ9ryATu5FSSsZN2VjMHDMKmHj+Pej0Ocb4VmqR6KneLkh5jjtIzvqosikxW3ZvmAdKEEvEh4e8zIN+kz1PTBSVvru/9Qn8xChJm5tqcOT0p2q/KlfxTK0NuSmgXIDFaBVy81xyIFUOhC47IkEtFW8//yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdA41Cqt; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdA41Cqt"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccde2b71so1713279fac.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 12:09:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789412976; cv=none;
        d=google.com; s=arc-20260327;
        b=jS0qoKW8hu5j0N56rKNRM4OP4mhPFALkwnkUBkdk91W5ddGoBzdtMPnkSqmVE0GgML
         yTsy/sHzs3lnJsJMsHHncarhJ5opkQNVaOspQ1JBSWZ0m1J+9jlpWwPA4k4p8iLfLA3/
         f98cGT636DKMs2XRRo6yT81KgxFzCa48GJZaTQrYfkwO4ebJ74LtjflWIabgKBeDhfjh
         r/9AFmBjYujjqXUH1X3h46Gd4kv7Xt8fDjWh8VoDOWDX6nD16Xrn7U2nJk9RvCNJhjq3
         K4Ks/KSJPO+5chjSlbE0l2NRJsMOHF6pahjsK+rLEjt+MOgufISG5rziMD6Ayvis1r+q
         i9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Z4qmyS2vqfHj91Rn4XVyGVsQU3bnE9E4yE+vz/mcM9E=;
        fh=DBccqF+fFSlF9SMLD86k0w5z9LEKl2+zMemq6g/TBR4=;
        b=q0lua2OjpdQALOHiqRJES3LQWB8+jb6ZdG6Dhhm1+L1F7BSiaEKSw4vyWsvCy9r+Az
         6uH/ge15pPv4E3JoHBk4VMS93Xhe+vbt8dIrzlcIDYW5IirSjJ/Om7fvfKlcnHZFWtMJ
         9XzsXiU+ZH7kcEclGqVvns96LIyonavKOqTOxbfaKZqiFodpIdhuJkgiJeW43Bt9iGMA
         v0HjndBRDkErD9KNXQoYhwrKgUBWW5/nqLWZyTIRaZExxxXaqm3P2M63Xceo9oD3cy6s
         7o+nLozdXuzLBPPQPXXFaEnXebIxaA3lRdi2kRKxPYLTuznz3AuVibDFyoYpXsciwtow
         YPVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789412976; x=1790017776; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z4qmyS2vqfHj91Rn4XVyGVsQU3bnE9E4yE+vz/mcM9E=;
        b=YdA41CqtM0PJru/Pa135R2Pfy2llWQ69KThYyiqzGxBZQI8WrxL1HDos/mtOifBz2W
         7pc5HkxuV4jDAHfWhEVzMoEMI3dj7Dur+h4xuXUE01gqxXS2ZbkGoDR9bvh3D8OI4CS8
         qEAYnBS/3kx//ZA4zg15X3V2dAJKf5JbHECdMUEjrzTqbzuq5CGCigPheCkl1nLPAN9q
         ifyrEho/pgbXUSGCYzCL/+0gwcEODyINll8pbcOFHkHKxVpmFONCq/EcoG0jwsCICM16
         +9SFSGNrtqSFJHYfhHPqEmFgZFb0HYnBRm7WI0MNZ1HXBxnMw+VrcpyO/mcsVM1XDNeZ
         BkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789412976; x=1790017776;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z4qmyS2vqfHj91Rn4XVyGVsQU3bnE9E4yE+vz/mcM9E=;
        b=ALYLUeDGDyitVCzUF+ibW7f7meagP06J8oSxg4CCrHOnBJbusJXI4IrntMm5Jnrk4m
         JyLf69QMDwviJehA/XCVzE2fR3wngZFaiHU9n+3WqEsxUbLnptLNguoCQ/8Vak/w2Czg
         ex2LisvyrnFOEQYV1VM7KBA++mP7URilEj6AtROECTmDz5pnsBlmvHa8Y8jZymHOzytN
         QcjVR0ZIMwsSyRdswTTujd0rBeq7WwT3EBiTKDRV38qiWFZKF+Ks0iCu3ZxAkfNlAQad
         HCEKzv7do3qZzArsNZfhH+gel/eaNbBgAfipvpJl1AnlXI4bEkHYrFqUBlPpbqQzlP+P
         /W0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzr2DErgGOXgFgFtDOK6zZTh2XvEqrkOzxOWBhygSYDPPXYEkvHRrcSUvESQPTXxVTSaUNT1y1R8ZXAFXIrKePJOS8=@vger.kernel.org
X-Gm-Message-State: AFuF++nm2QXmrSrb2IPGiELALdEj4cwlnb0Qzl1QY+MyKtpYTpokRyA9
	6nqhWecUaTIhRZkO0sHobPm2yh+gfSMdQ7r7pXd2OI6IZX4nUiUaVo9nDleUjU1dq3HhBTa5VXR
	5vrWu9rpcstLFssJMEiG4djNh5m6PBG0=
X-Gm-Gg: AYBFou2De5AWVi1RRI7I/Q4qjrNAQ6HulcV4OKq1+oqERRpUlZeVF7c1XdWh2vLiZnM
	CHVWrtwzEyAzq1H5OVNx1yXUDGstWiiPunfrHyUtDtGllOB9FyWjBeuUIxKROlp9dpeBBUgn4EG
	yxjwpJNpvk1gVAWjNxeFsOgreXCMkuX7gJw5zrZbrTtS6oIkKydQCCAn0EY+2e7owF1GOpbR3Ll
	KY/5PH/ylHSDSWKgOENn2bB0gqeBvid2BlgB5NkejjgI4km/KHqRP45a22Ftd3WWZJ4ZCItumfr
	xZyYl0to225Ntbz/2FV7JnZ2kuIZeqfKKvcOWZa/dn/YIqDki0AgF2MYvXXo3hcPSPPWz3CUFXg
	bIFSYqCs3NA==
X-Received: by 2002:a05:6870:458b:b0:45e:4deb:92e7 with SMTP id
 586e51a60fabf-481f97f14c8mr3645365fac.10.1789412975663; Mon, 14 Sep 2026
 12:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914175907.1027349-1-vdonnefort@google.com>
In-Reply-To: <20260914175907.1027349-1-vdonnefort@google.com>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 14 Sep 2026 20:09:24 +0100
X-Gm-Features: AcwNN1XfrufVB7vfooH8sB3z7NEf9B9zed3nYyuX5q2EMKLSurNaKFGzXUBsno8
Message-ID: <CA+XhMqxp2XOB9PnfHJwBvK0up8Oej4hGcnsM0a=fdoRDyVoEyQ@mail.gmail.com>
Subject: Re: [PATCH v1] ring-buffer: Clean up resize_disabled checks
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vincent.

> +   if (rb_resize_disabled(buffer, cpu_id)) {
> +           err = -EBUSY;
> +           goto out_err_unlock;
> +   }

For a single CPU, this now happens before the nr_pages == cpu_buffer->nr_pages
early exit, so writing the same size to per_cpu/cpuN/buffer_size_kb on a
mapped or persistent instance CPU fails with EBUSY instead of succeeding.
Intended ?

> Additionally, remove the unnecessary cpumask_test_cpu in
> ring_buffer_subbuf_order_set().

The install loop still has one.

Otherwise removing the second check is fine, the hotplug window is
covered by the cpus_read_lock() patch I sent separately.

Cheers.
