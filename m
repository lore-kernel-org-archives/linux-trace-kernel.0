Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7215E3161A1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630894; cv=none; b=n2VJ0r46LNMLtFo1Ntvx8kTqrWc+weUfVQbCyGxJFHZ5/15vvn1z8Gg7Ah4nj63952vQODZ7OR6iuXUCoRSWT9yxpBVSiPDDKAXmbS09712GN0bq61EGIMxGwCjeoTgo9ioW4Ngxgc0dAD/q57baXyryIygx/k1tD7NgSIxLvVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630894; c=relaxed/simple;
	bh=1BngQDqStPy4IbAN/A8pfaIz1nplmIope5AI7+UIB48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4uaQsAOWZxnYtQCGz7iApn66qz5mjMs36Xbrw/tYZs4f9Cm1MJaj4f1pH/nH+7myoIL8Nzw6espfmsoqJm6DXKMz40UdyGFnyklYWU9hlxmYTSk+y936bgnxBbfanLE8A/42ihapEem4m+4Nx/lhgSPmw5eKFhS9pKH9tFsBBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXEdlLiK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXEdlLiK"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f904e80eeso1750957f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 07:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786630892; x=1787235692; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JcHbtPHDcFE5fkEu2tD+QxgHH1BZ1IzYrTBReRRcNS8=;
        b=tXEdlLiKVOTqmEaY8k0SIV/4c66NCcW8HP3O8V92QLVeryvl2j6booO9kGdmER21qX
         8qiVYNPRs+D5U1hRyM7wURprUdCAaocYJFdhmKOThlFzleIdS8FPqfQVPTVMcgdX6C+K
         R91L0GACGNz+JMdyRt2odFM3gfTtiZwd8ssxvDgoui7FM0g87La+SOiMjvCoAsl2WZ/p
         soAiil+L48HLscK4758ZBYai7y9cCMNBWpjXMw/h3PAzQXN+PQ6z+CpA3EJ9YQqToInh
         OPwr/0/rhgYChHSlAF+RcpN6muqBOMWg2IiCf8xCntS1jZSI6sFa0RjbI9WmTx4PbMjz
         +X+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786630892; x=1787235692;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JcHbtPHDcFE5fkEu2tD+QxgHH1BZ1IzYrTBReRRcNS8=;
        b=TJjHA87+PwC/ZekOk8pp2yKWPepfCOl4K5evbcQ1lb9F28V8Gol2WPz4xMzs03C5Mv
         9qQaaBiw5UqQVoXwe3dFsPBwVLxH9exQPneMBGv8Fx1yKvkRE8YTUmpw2lpH0t0TCbWC
         4I3c8EicrJ7q7/vyQA6CCf7wR4CXVT6PK7LLf0o0sUKDNoNn00D1hYu6tSTL/1q1ZjaA
         F2DObMOFFXRRBh4YTbSYp08F1eEIaC6NB3YqGO8TF2kZ0hrHT4levQeiyrVctWZoY5bE
         qhm7WHnjRAeCX1bLMBRL08A7IBiJmNjKRL9CEu5zUBY3ozgo710QzpG4rwxsQ7rGFLcu
         hGFA==
X-Gm-Message-State: AOJu0YwgkNltV1tBrck3LgeFDzDHuS6cngFLGkI4SmItZ0qxmcwKdlOl
	AA+wLQ8gmCh4jvcIcaUZEy24Mi3OwVHx+OgCUEAQgwrjuP7kgK62TZDxV5Vgzbv82g==
X-Gm-Gg: AR+sD116HUV3rP3eMsxgCgk0V6l9SAERekKJxweXxwFucBfHstTAHVhobeheQWuNfFO
	L0CxC3iqTd1GsLZCDAn4+5KtJqTw+DF/bpv/kF4fJA1umb6+D96Ol20BjH1UCb/XBaC+8qDhdz6
	vSYIUIKVIixtbmA4aua108rybVu4+kGyxZTbF7G8zbgqQPP7ESbnyupRUHsN5dHujKi08M+terY
	iE08Z9pL8mm6aM5gYLxuhl4Ciy8UOwBb5QxIqxJjFYgV0NMzuSV7QnLLIKza+jrgrS5ock1R1bs
	mGcIRib9oCrChxbD9VtiFxJTjt96cXmkThDwst02LjHGsDVcDEmQOsNCAmskmPxsDlYwNem2XYq
	1RQBBR9M22mi139KwhX9wVX6NepVe752aGcPh59vRLlkZxGFr2QyD5R2Q9JWfpT5b4OE4q/MC9m
	amDGduCuVpy26AHvGIcPWwO6g+lKn4NtQnWOqH7wXi9sydMwbU0zIfSs1zFoDM21P7xawtmlqLf
	ofyZpf2EswlZb0TISpE58z1wNccv+SA
X-Received: by 2002:a5d:5986:0:b0:481:4761:45dc with SMTP id ffacd0b85a97d-48159ec3b8amr10253257f8f.13.1786630891044;
        Thu, 13 Aug 2026 07:21:31 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5b6f94sm6645063f8f.32.2026.08.13.07.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:21:30 -0700 (PDT)
Date: Thu, 13 Aug 2026 15:21:26 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 16/18] tracing/remotes: Add trace_remote cmdline
 options
Message-ID: <an3S5rK5dLZkADSU@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-17-vdonnefort@google.com>
 <20260812171148.D9E9F1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812171148.D9E9F1F00A3E@smtp.kernel.org>

On Wed, Aug 12, 2026 at 05:11:48PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] User-controllable command-line arguments inappropriately trigger a WARN_ON().
> --
> 
> --- Patch [16]: [PATCH v5 16/18] tracing/remotes: Add trace_remote cmdline options ---
> commit 473129b2ec6ced6d4d23093ce86b83497f7202d2
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> tracing/remotes: Add trace_remote cmdline options
> 
> This commit adds a trace_remote= boot command-line option to configure a
> trace remote upon registration. It enables configuring various options like
> buffer size, polling interval, and activating specific tracing events.
> 
> > diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> > index b1c75666ab638..8764d0ed39097 100644
> > --- a/kernel/trace/trace_remote.c
> > +++ b/kernel/trace/trace_remote.c
> 
> [ ... ]
> 
> > @@ -1169,6 +1171,124 @@ static int poll_ms_show(struct seq_file *s, void *unused)
> 
> [ ... ]
> 
> > +static void trace_remote_apply_cmdline_opts(struct trace_remote *remote, char *cmdline)
> > +{
> 
> [ ... ]
> 
> > +		} else if (!strncmp(opt, "buf_size=", 9)) {
> > +			/* buf_size can only be applied if the buffer is unloaded */
> > +			if (!WARN_ON(trace_remote_loaded(remote)))
> > +				remote->trace_buffer_size = memparse(opt + 9, NULL);
> 
> [Severity: Medium]
> Should this be a pr_warn() instead of a WARN_ON()?
> 
> If the bootloader passes multiple trace_remote= parameters, and an earlier
> parameter enables events (which loads the buffer) before a later parameter
> tries to set buf_size= for the same remote, this check will fail and emit a
> warning.
> 
> Because WARN_ON() is used here, a simple typo or misordered boot command line 
> will trigger a splat and cause a kernel panic during boot on any system 
> configured with panic_on_warn.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260812161340.2417322-1-vdonnefort@google.com?part=16

pr_warn() sounds good

-- 
Vincent
