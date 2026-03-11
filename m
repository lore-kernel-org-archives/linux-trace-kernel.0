Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AED3DFC98
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242614; cv=none; b=Y9llHRrY3q0adIN6lpC7VqKfQ4LqRvE/cHFtsXl9mc+weDv8Jv35/jwhoaiNb3rSUhvCeqlH59BWPFJGNpFhv3IigGmgWNf8USBeQMx0ZEHaiVRXP6/eDht+Ak6qTdj6gTg6hpcemBV7X/kslY0d3sgPETLYRK7wy6mr6TcyoAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242614; c=relaxed/simple;
	bh=Z+GkvsxIGO1i8VGlHtLFZtvWWVWC8f8GiQAoIj6Szb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pl91xKgIsZoqcqeSVY+pQTy6QDFwtMCIVfKDANUdj6akq2OFklorJbqJSzLZmenVE5PK9J81uLoJYkm6JskpqPwIBQszOiYsekY3r7hZ7/j+uPT/Y/qOQQqhaQ4fqeWypnj/B3t56FmOIX/HKEjc9DzqLWrwrGQm5/79F4Jjaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6jzTegW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6jzTegW"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439bcec8613so8120255f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 08:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773242610; x=1773847410; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M1n477ll3uIr3ftc1SUKSWN3qMH5BQQpUlgTcrO/W9I=;
        b=m6jzTegWhceMJ3V5H4UNQjzhgheyNTfnmPjE0vkyA++OA8tVzuM10bvq/bXlosQfJC
         X3aL1a1C5RybjxYTpsIgt+CqMgOfWzaPJr37cO2SUjRWgfIdizhuBzrqYOdW4+34ojIm
         sCo4B2oJTD7DV+/fXzRPksKTwTguPfKh4L5OyWIwp2LjpZvpMwQSquZxYhDruDTpSadU
         DxN+vGlAfzdn6j3BaXBF4uXXhMivyf4rX0o3yFzj49RWamQvfi5T8SWBT1QXA/wIIcYP
         zpaHBfDH1QeWutUFmNs6zQ+gsiIdhb/WJI2pNGifw7r74LSFL71EADuAlAa6lwRwZzXB
         lQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773242610; x=1773847410;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1n477ll3uIr3ftc1SUKSWN3qMH5BQQpUlgTcrO/W9I=;
        b=cA6X3GKij0NKe+RXjzjSFZ4O/t1+8kWPuj22Y/ps9tnoWVZrIXvH9RI0hPNIf+uiI0
         Vo5lfAZSiWU4wtYZ4uhQzEQEIGimW3O+2Ou/p4C1LwOFD+P8CCGzUJKGvaUMl9xjiLxg
         qt/n88qoIX1v+nPsnFfkm9cjQ5HszdYT/VaqisFM85voG3Rpf5rI8qF1bXesBwVkbfUh
         TySUX9mHgdBlJsk2A9DcY6uKw1D3iktLvvR0NLoqwJbreHs+mKsX021zUH2GkcrH49EW
         3CvrqdUqL0LQ/qAM43IXcfxeWH61Ral1uyBorVnJAU+gMAvoHSsOe/yfbZH5UUh+3/bJ
         7NiA==
X-Gm-Message-State: AOJu0YxmWvghKOXdoap9O1a5Y62Rt/uD6qtUupbPn5tMoBilv28SaIPw
	7j53uVn1wZvxwxRUa2DkA/kidGxYnbgpbiwGpgeJXlzqEFCnqJ3zXKVcc2xiqkxDug==
X-Gm-Gg: ATEYQzyGDwxFY1VRyXgZKAsBZMyWfjCvXAJCA2G8Hp6fXibR7vHCIaLtsugZY3S76HW
	jTnYxJpPiXaQzD7+303kQPeRD30Jwi8+ngDNd5Xi7GfEVUWJkV08VP5iZFM1E25RJwoPOJwG+Ty
	Qd+cVkKUrQqMMskbk/bCGnHgWDC7Xy8JBnHgNfldqHhPBFIqNg4/eCaIMJDjDdUGFP8ye7orrIS
	4EHzEAVGMlvUvtdKLOwJF+/+33BPVj55zAJ8XTHlxBIE+GVClkiG08N9Gh7Q6nDjg+Gpkgabnhr
	lM/3Da4V9Egm795fbk0OZF0q7/xhvqz1PIt4YkdOlQYcwdL+eoqpBll0LX068sK8RPepB1149eH
	oBvPYa/l5NFnlknMAM58oP5GtBr0+VHjAVoGYMnMiCwyeC9fj7tTanJ1s8ZJU+kNk6vZQlYX7Wn
	z5G/qcacFT3YykdSLpoOE0GydcSGbuReGRCIuZZo80bpjD3QQzUJtNj3dDyX4iUpojnh8=
X-Received: by 2002:a5d:5d85:0:b0:439:b715:6f49 with SMTP id ffacd0b85a97d-439f8415ffdmr5618431f8f.59.1773242610090;
        Wed, 11 Mar 2026 08:23:30 -0700 (PDT)
Received: from google.com (198.115.140.34.bc.googleusercontent.com. [34.140.115.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f82078a1sm9543853f8f.29.2026.03.11.08.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 08:23:29 -0700 (PDT)
Date: Wed, 11 Mar 2026 15:23:26 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-trace-kernel@vger.kernel.org, kernel-team@android.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suzuki Poulouse <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	John Stultz <jstultz@google.com>,
	Quentin Perret <qperret@google.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v13 03/32] ring-buffer: Introduce ring-buffer remotes
Message-ID: <abGI7kzhTHl-MyHv@google.com>
References: <20260306143536.339777-4-vdonnefort@google.com>
 <677c7ad6-6e67-4011-b2d0-03d0d58547ce@web.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <677c7ad6-6e67-4011-b2d0-03d0d58547ce@web.de>

On Fri, Mar 06, 2026 at 05:37:35PM +0100, Markus Elfring wrote:
> …
> > It is expected from the remote to keep the meta-page updated.
> 
> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.0-rc2#n94
> 
> 
> …
> > +++ b/kernel/trace/ring_buffer.c
> …
> > +int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
> > +{
> …
> > +	cpus_read_lock();
> > +
> > +	/*
> > +	 * Make sure all the ring buffers are up to date before we start reading
> > +	 * them.
> > +	 */
> > +	for_each_buffer_cpu(buffer, cpu) {
> …
> > +	}
> > +
> > +	cpus_read_unlock();
> > +
> > +	return 0;
> > +}
> …
> 
> How do you think about to use another lock guard here?
> https://elixir.bootlin.com/linux/v7.0-rc1/source/include/linux/cpuhplock.h#L48

Sorry, I forgot to reply to you. I had to respin a new version so I have made
the changes you've suggested.

Thanks,
Vincent

> 
> Regards,
> Markus
