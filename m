Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5473E4772AF;
	Thu, 13 Aug 2026 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636183; cv=none; b=Z7tsH1ZwNPAFLvYGQZBhyI3LMdb1EAGOrCJS8L+ujkheOtHeEz11jM5UfLhu2xpvxTvl0PHLcZ38JZ2tDo6Htgx/yDNTpIHHENGrCEED+cLKHZlaKstN/TUx8e/y6q1OI0h3Zt8DepcUszu2X43jNAwQ+i/r5l06VCVDGy8CyLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636183; c=relaxed/simple;
	bh=b7g/nGx9QaPi3D+NzTTkfq1npgN0O/R5d5eXoU9HTEM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hzCiIZBT7ekfaKSb8SJfzBd5BHwh7gLraqyQKq3RYVSaD3dv4iKj05RocshWDqENf5dr0AeDhbeE786lhoX7S39TkvZhRVF51mNkH7msl5xPgvcEvkQ8ru8rNVIMgdO2DtRuqFxb5lY5pESurCPIOLGaq4P/zEDS9mYqni1HgjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2dSkxM4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2dSkxM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85981F000E9;
	Thu, 13 Aug 2026 15:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786636176;
	bh=qBpM+zslrERzM13uBqYPgW67zLdzAh3VMjuTMMHTKLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O2dSkxM4K43EET6twJ+spqDi+fecM7Pm5YmkfiBzlafpy9DJ6/iVcK61f+y0Kv76s
	 tPrkrVVVAC5rx4+heoUgrvElWohN3rsf4R3OGGN47RWonJjyA/BGX960Ej7yUxS9vn
	 r2KXO3vMk0avyhNp4mv9oRcIF2zfAyH/POZ6ZaGZwzu7V0SXF2CnnbJgyRzdK/bgdK
	 1svds2aqYfrZ4mNwUmLEuHFGOwUkB5nMH9Yp9WweFkFDsLrXKYzdCKQ32keBUyokhI
	 fJrmqMdVtzW44UEjytsCVXgA3WhSgRa/BFUGx/wuNk8uHnn4/shOaBi7huOFUBMpWT
	 78uYwp7SbvmEA==
Date: Fri, 14 Aug 2026 00:49:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, "Vincent Donnefort" <vdonnefort@google.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/10] ring-buffer: Free cpu_buffer::free_page with
 subbuf_order
Message-Id: <20260814004932.4bf99af3fd65e8132142d335@kernel.org>
In-Reply-To: <20260813135439.E42E01F000E9@smtp.kernel.org>
References: <20260813131152.3589632-1-vdonnefort@google.com>
	<20260813131152.3589632-2-vdonnefort@google.com>
	<20260813135439.E42E01F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 13:54:39 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] A data race and locking mismatch between `ring_buffer_subbuf_order_set()`, `ring_buffer_alloc_read_page()`, and `ring_buffer_free_read_page()` allows `cpu_buffer->free_page` to cache a page of an old order while `buffer->subbuf_order` reflects a new larger order. This leads to heap buffer overflow and buddy allocator corruption.
> --
> 
> --- Patch [1]: [PATCH v5 01/10] ring-buffer: Free cpu_buffer::free_page with subbuf_order ---
> commit f550c0bfeadcc22eca47316e1820b4d91f6ef261
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> ring-buffer: Free cpu_buffer::free_page with subbuf_order
>     
> When sub-buffers use an order greater than 0, cpu_buffer->free_page is
> allocated with subbuf_order. Use the correct order for
> cpu_buffer->free_page.
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 2667992f0aa29..a3d28b2e2c94a 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -2631,7 +2631,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
> >  		free_buffer_page(bpage);
> >  	}
> >  
> > -	free_page((unsigned long)cpu_buffer->free_page);
> > +	free_pages((unsigned long)cpu_buffer->free_page, cpu_buffer->buffer->subbuf_order);
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this change expose a buddy allocator
> corruption if cpu_buffer->free_page contains a page of a smaller order than
> buffer->subbuf_order?

Hmm, I think you have to fix cpu_buffer->{free_page,subbuf_order} race issue at first.
Let me try another series to fix it.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
