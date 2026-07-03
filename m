Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C050D3DB314
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Jul 2026 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087894; cv=none; b=a9aw1+he34e1D9V4w1NglTM7/9Xi1gocgEp5dRGNNgm9+bxnoRy3lzJqpnbDnb/fnWK0YhXrae/9FhdZ9D0TBqsdjXgxq8+lcur+lgVkKLzQUUYb2SlRbjb/aBdRHIdsVbJ0DSmzpcFkG21pUEIzcpOLyKGOKdi1SqAk4o+j69s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087894; c=relaxed/simple;
	bh=rIV9RsnsSZDUK1q1Nd3LKY8epaIDzY11eLnwBM/DcUw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTFtstOjylQzEraMg0j7RSkPfUibu2Qjsh9Q35wU+J75mlb7Fux4dOT2wEl4AaCtDKcIDX9MI8Htpl/Gqs/W7/dy9VUzI/C3eST5wyFjn3VcZ9KfDOHRJJCFb8tiVt0SnQ/6YNoEz3nVyCD7w+pYWDbYn7djzHH0X81kgpq7emY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VafHTFi4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VafHTFi4"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b966dd74so2433795e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Jul 2026 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783087891; x=1783692691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QPgd2/au/1j1zvelBc/TbSy2FLXI5cvkqsoiJq1KpPY=;
        b=VafHTFi4KbMh7Afv9tT4M7SYkyQreMoN09GQqNbtex1LJNt7EUpEwYNe4qm4WKIohF
         sHQt1SlDf8dC+fpdDA5mHkPscZUMdtRWiNAmGa5xOlv9fIvy1teITtKBnFto+2a5jFA9
         idWBiaTmBS0wGqBKHEtPy2ndBRmGHASgxl5c1vxqPIH8OnHfBOvL0dZEVFHrfJ/DZv5C
         1831XNSnxEU81yri+hSd6NdEV5qsW3UPSn7QipViwl6VOu+T7gG8WLOuY2bU2Zlz4woq
         UIY1bEgajbUhYJ3i+gCWtgWwZ6NqF5UJg0dQY1wZgzRpLCalcSHSJQTxzNYN+1mZFCg1
         cCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783087891; x=1783692691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPgd2/au/1j1zvelBc/TbSy2FLXI5cvkqsoiJq1KpPY=;
        b=E5konqTcRmFY+yRPMR+IFVI6Gj5tE1/OtMkIbmPzeBNKmJ13JTg/ScS3ieYrDRgvUQ
         Ne/vCWssYzR795b93UZ6bHYQfi01c+0591KDzIObZIJzVe/npSWtM3bc6N+1F5unBa7N
         0J2zagPBqNXfK46CaT0H/3lbRYi943H/T4JLGWIm2Bvqk0MQbiUgAYtv7ysVwBmykb+T
         QJc6m56aZSGyr++T3y4L2ciRH6lbv/L/Ff4ybpZHvsjfshbqcmwaNgqhxJjWwiMquXNi
         4+WMtbThjPqLN0ROjGV5CShiwvtus/RgVc8s/s/nb7CAf2BJm4+rHCSN7K3+C+q/7whq
         9Zkg==
X-Forwarded-Encrypted: i=1; AFNElJ/ci0yjN6BpZCO4ERnF5pCocxPhzMpzDuZiWZ/tObqpb9zuQxVBO18lYWOM8uJiBvJhsHsZ0eF62LIVsyiM9yPbbgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG4yMNSPxICMTRdFW1IpWWZM7Tbl5yPwlZvgsFh26Vwhpo0G5F
	iNaUwsaMAd2GtIPpgrl0rzUFXXBVXFWga5lty0Hk7q5tuVdL3+n65i++
X-Gm-Gg: AfdE7ckdTuwssSqrT1DXbuNeKkxKrSWRhVlWq2+jyD+pILJ55IWSVA/oP0+v7LeB3gn
	HTajRaERsFadISMGRuvxGxEsNf1tLXcgWtqp9gDZQrMZrMg/o9ppY5z1FYEJxW7mFv5iZdSrCOD
	rcplZucKczsvW//JMbUiLolvLCR1Grs3D58dY4agX8E8sMM8lV8gVQdp8ZnMZ0IxVpIgPC8GBcK
	nnl19WXaobevHnyo1I90jySQ6r3x0Q+crTkUTeyirzFweYo3v5oaCFy3mVvPnK4nYWsBuCVzxl7
	62hEcmHrdfiAMqUUE7+0NfzhtMwlxyOBfBeXpUQl7lgu6zfbykb82OcRSHh/3ElVYtQDOImM+bZ
	kqOJN6fDKEw/2/WodolkySlPtjNRUuVIAkmHlStldKycOi5bjmZ6cBWWXWhAHhbdm/bQKApzPO4
	p8FzhShCoD1eZp+t+5+WC6GC4B3o17lf7xCXk=
X-Received: by 2002:a05:600c:8716:b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-493d0de258amr1138135e9.0.1783087890966;
        Fri, 03 Jul 2026 07:11:30 -0700 (PDT)
Received: from krava (37-188-223-191.red.o2.cz. [37.188.223.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6381e4fsm157919945e9.8.2026.07.03.07.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 07:11:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 3 Jul 2026 16:11:26 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv6 03/13] uprobes/x86: Do not leak trampoline vma mapping
 on optimization failure
Message-ID: <akfDDundFgxkIt9j@krava>
References: <20260703114917.238144-1-jolsa@kernel.org>
 <20260703114917.238144-4-jolsa@kernel.org>
 <20260703124503.GP751831@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703124503.GP751831@noisy.programming.kicks-ass.net>

On Fri, Jul 03, 2026 at 02:45:03PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 03, 2026 at 01:49:07PM +0200, Jiri Olsa wrote:
> > In case the optimization fails, we leak new-ly created trampoline
> > vma mapping (in case we just created it), let's unmap it.
> > 
> > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> What is the intention here? That is, Patch 1 has a Fixes and is already
> in tip/perf/urgent (from v5), patch 2 does not have Fixes, this patch
> (3) has Fixes and appears to rely on patch 2.
> 
> So should I stick both 2,3 into perf/urgent or what?

patch 3 fixes the vma mapping leak, and it is done on top
of bigger change in patch 2

I think we are ok without patch 3 in perf/urgent, but if we
want to have it there, it needs patch 2

jirka
