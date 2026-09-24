Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F722472AF
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256593; cv=none; b=G2MRt6rg9MwW/mhVf8OK2yi8rtuo1y5w35+gknEyBW5TTKs2eQJ9NSwcdawEPjbKygYChkIithvlkLFDI2vP/ZoB9HsvgXVjSUrKbHKv9XUMUJQ0qBDO6J59y90ZJ6QedlkQUcaNCsyqde3BSYQ0Gbfbrmi5zaPoWZDaAKVS9O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256593; c=relaxed/simple;
	bh=b6+s+j2E+PamgZmztaZFx+a2tmmlK+zV8zH9cUia+64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwOcTceYPLdBjHDIo/N48E3ZoVSc5HXBtCG4fCb7BTduZ05h753CpbFjJN+aW/erZzRl76xDCkFv3gM1Ic4vbfAnko9vxAXKYFwcyeKnrOruQsOkqmC7s2fPKlqETMLiNFLc2MWEHMGFRjt0ia9bYRjhrGpLL+At0J4P298X4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O6syckze; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6syckze"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485b1d2874aso1645534f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790256581; x=1790861381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LQQKLzXJaAQsQHa2KS7tADnjrxkQ8I/GwCwJ8DG8zts=;
        b=O6syckzeVma0xn144n0MetLfiFVCI8TLtxyXWVX4piEm8uwe4l7DFkNxQbeoYHBvVJ
         HaLxw3V2+RvrQg3CqZ6VCBl4aC5hHKmWKINuSjX6ZepK7Ioin8uz5Ugpzw+EClWSpMxj
         tGF+VNhzKzDbGi7FLB56xiKXwr6s1m6nBzePWU1ZBhsTHGvYhLX92FIJfAoqX/YkA0K8
         bHM55bJscetO74rJ1AqPt6A+4KLaK/7Xc1xcopjSk031ZlDfAp0I1ku4FaVF5KzAefir
         asYmNoTwkRlA/R/nJTDAtWdAz7SKaeDsGf0MRbZQMudI0pyxYEfQruYhVOAgS+s7jfiU
         mJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790256581; x=1790861381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LQQKLzXJaAQsQHa2KS7tADnjrxkQ8I/GwCwJ8DG8zts=;
        b=PX8xzgijp6Adct9SI7mdLGcAaVw1Pnmcar65z5NruNaYb9mNC1EokeJW6Z3imvP/Xz
         Bme7bc33ETU4jBuXCNLhZhn5ynEvW86rVDHO5yJkOriszharkK5tSY1VAKm2Empfyegl
         AsQxz3vZ+VHFhcrCP3EgwKTh4GKnYXP6PvqGNnRo8XkmXCRLQKTya0i/rhfNx7xqFc12
         NGdt/7ZYUTolg4QuSMgbeQOSrnY9z+QqtUoL9K7EtsxonU43ZukqDJg8HqSvEQwnFGIH
         Tr9t2KjIaGJIU+M+mhtbGq8yG4siGvgN8mOUjCYNH5r0dVjvA2pIki5OS20pmoPN9Fxg
         cCLw==
X-Gm-Message-State: AFuF++mCIcBneCn7SrhXG0EPZfDRNio//T1N2n0oda5GfLxz+jEHByWN
	4rdWHyIG0pjuD6afjStOYBi2K0oWvy7LM+GRzMNpZ/wVrM8h98Fgyl+VnZjPtTCCSg==
X-Gm-Gg: AYBFou17B494c4MLUcDDByEl7QRziZnI12DP3GzZItiL8fyJF8FtXSARgzqG54U1q1b
	MbTS+t28kjI2NmtKIVew8cuYe07VrnamaX0hyeScCWnIoSAO0+dacwbHhUHb+yVOf1x8JxqC2TA
	JTqs4EPpQPVfMhX5Riom0l1GUbX/uwjuia1B1V+YWjTCtSsG0LHCqbM05yPtRDRs0cHmBuKV48F
	FDtjNhE3O9GSNlUfUdEXGS4sNupjJNDj4/Yh7MUjlUc10PtAmVIWFMjeQNJ2A8NEkbPXvBXi7jw
	9KkQ9bhvHhnVdagGVP4JugWNyK2qNM8jLSvCM8X2eszI3Uh37aGB5xKDhjx70TIWnWrC2Q3AP/j
	YQWC6xClSwTy7WObtuMWivUK0708nkBc3dSbGCy1pgvNjZmKsGzx/CEHC+nZUaDMYtZsrvDCgRX
	Xzhtw9S3UjYAlV2Y8yKwsrKB1F9/bAXVSLKQJo87wArlR1NcLw0uz1cjCfEOTIJRD65aOS++Wx7
	2299glVLYgqDZ/b5+zHognP4BfrxMuDoTE/2wkA7xQ=
X-Received: by 2002:a05:6000:2512:b0:487:da0:df33 with SMTP id ffacd0b85a97d-488716b7498mr3963942f8f.3.1790256580199;
        Thu, 24 Sep 2026 06:29:40 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488684862a3sm13572566f8f.7.2026.09.24.06.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:29:39 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:29:36 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 16/18] tracing/remotes: Add trace_remote cmdline
 options
Message-ID: <arUlwHtTyvlMDxUP@google.com>
References: <20260817135517.3919534-1-vdonnefort@google.com>
 <20260817135517.3919534-17-vdonnefort@google.com>
 <20260817141252.4FD471F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260817141252.4FD471F00A3A@smtp.kernel.org>

On Mon, Aug 17, 2026 at 02:12:51PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The `dump_on_panic` command-line option sets `remote->panic_on = true` but fails to dynamically register the panic handler if the trace buffer is already loaded.
> --
> 
> --- Patch [16]: [PATCH v6 16/18] tracing/remotes: Add trace_remote cmdline options ---
> commit 16551de261e3bdeffe51c1a5227c6a115ddbe725
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> tracing/remotes: Add trace_remote cmdline options
>     
> This commit introduces command-line options for trace remotes, allowing
> configuration of features like dump_on_panic, dmesg, buf_size, and poll,
> as well as enabling specific trace events automatically on boot.
> 
> > diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> > index 204d5bef7a8c4..34847463d9e43 100644
> > --- a/kernel/trace/trace_remote.c
> > +++ b/kernel/trace/trace_remote.c
> 
> [ ... ]
> 
> > @@ -1170,6 +1172,126 @@ static int poll_ms_show(struct seq_file *s, void *unused)
> > +static void trace_remote_apply_cmdline_opts(struct trace_remote *remote, char *cmdline)
> > +{
> > +	bool dmesg_on = false;
> > +	char *opt;
> > +	int ret;
> > +
> > +	while ((opt = strsep(&cmdline, "^"))) {
> > +		if (!*opt)
> > +			continue;
> > +
> > +		if (!strcmp(opt, "dump_on_panic")) {
> > +			remote->panic_on = true;
> 
> [Severity: Medium]
> If the trace remote was configured across multiple command line arguments, and
> an earlier argument already enabled events (which loads the trace buffer via
> trace_remote_enable_tracing()), will setting remote->panic_on = true here
> fail to register the panic notifier?
> 
> Since this doesn't call trace_remote_panic_load() if the buffer is already
> loaded, it appears the panic handler might never be registered under this
> configuration pattern.

Interesting. I will fix that

> 
> > +		} else if (!strcmp(opt, "dmesg")) {
> > +			dmesg_on = true;
> > +		} else if (!strncmp(opt, "buf_size=", 9)) {
> > +			/* buf_size can only be applied if the buffer is unloaded */
> > +			if (trace_remote_loaded(remote))
> > +				pr_warn("Cannot apply buf_size after events are enabled\n");
> > +			else
> > +				remote->trace_buffer_size = memparse(opt + 9, NULL);
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260817135517.3919534-1-vdonnefort@google.com?part=16

-- 
Vincent
