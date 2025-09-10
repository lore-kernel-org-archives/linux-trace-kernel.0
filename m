Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CEB314A6A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497513; cv=none; b=RVoDVYuLceYhXg4rH47/Q61VjHJMJ4eErPv8XpQeo5v63VcFsz0JzL5SkeMfGqmReEblXPAa7cEe8eIo5LIvnAnG76bs/cPo1C4eaVFEFxNZDSGCuPwrLAE8QzsyrB34qY5Y9z/Rp6X6KEDYcayPKXpYKYZ2MrxWyW5f+JiNOyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497513; c=relaxed/simple;
	bh=GCwe8Dko3jDOXji8AdD72nwYCErq8l4yfDoJj7Gnt6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFUV8k0tLALtn5FQ3vzutNfQF3tRvkyvKv8kZlwkjNGhFO9UsHtNcwwTt8blJiMVJDXdX/bkjURuNatv1z9mFyxyVpfPDuuFemP4QcbFZY/vQK4RBoVjmVddNgHNhMBa4MjGGlCdCCrpfLHS+kLWc3LNIutEpc/sFFQhMYBxSlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=19cAUI34; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="19cAUI34"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45cb6180b60so41925295e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757497509; x=1758102309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1kBDy0sA3BYfIdWlr+hjUo0vDal9CsK0/fCdjzti6o=;
        b=19cAUI34sfYJbTjYGCPpJRZggcSidg2jKJyAfwr7F+ZoZW/Lw3KwWQ0bY09/mVtQ9w
         J62kIZ/tuB0k8gbnxeAUWphBf+O2khUq2WHWetIzKOaF/9yicq0NhPMngCcaLfjo5d2e
         P7BqpS6+509izV/NWbg8SSs2RpRrKkxKH20uCUGrvjI/NzxtjAeURVbL1r82lNJuuGzC
         6vuzcLe6q2NMkrOGjl52VML6yp+hbrAJrjfAHp9v07KPPSgL77T8dqg1e7U3Dpn5HRav
         gvMfgOueFK6H1mTGPTyQiSJqK6uyaWsjh7lzV9lHmOrI4Md825RoxNegkr2smqhdTTbI
         qPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497509; x=1758102309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1kBDy0sA3BYfIdWlr+hjUo0vDal9CsK0/fCdjzti6o=;
        b=kcXbNeGbFAriiQCpcgIjaRcRTPCfyV0mtUQ+ryqTSBLfN7U2x0ku5M1yHpgkUdNksJ
         RboIQ3O09e9oOZwbIxcRQzITDYslmAIS9xMEUjgXO59SHgCdHyyCZTypb5kA1X05rfSy
         58nLYhoZvCNjqzGL7aEAENKGOGMbggQKP/oWs057S/uIrmBBSaFK7DoBuLUJJEHTI6fj
         CRZvRADYPrZWpceXvUCm/6BRVE3TPDCrkMwaGwB+CWbAGZq87pOOSNnDUev/AJ+6gFRB
         QBSPaZskHuVWH9IsGEPXNQSlnGWryvKrhpUf71Vt/3jTY9cg8Ha/1hvSQo6NeOW8k07i
         1SZw==
X-Forwarded-Encrypted: i=1; AJvYcCUH3IVfnxz4iPWpdQcyBDt7iJ5z1+O2fQzqTAlREyzJyeZ3ZxxFt9koD0c49H/Cst/inrVs1V5i9NZ8m71NY1Vdsik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9SHDkeAOThGz59nMKLw4fYYUqss7GW5tgkIvFVDWUadfShRcG
	CxLO4MjkUPhFPKQEdVQLpkWk22d8DRZEu+a7pUHnB8UYYtAAq2OgQAyeNsnW8ygA5A==
X-Gm-Gg: ASbGncsk0qKnssf/AkJd2XvtRmBhkTIbFSRi6nNSzOtJtu248RYIc5FOITqQHIFW2Kg
	ZKbW5wAZhTbY31FE5ke4FuGYkNa5tjEf4L2AcAbU4JxFAo5fW5tBFEvn4lHDo+9hkD9bERBqwJG
	B1bBLJwf/OK6v0EtjZcP3JimyVuZEd36TL+tSxtcM0HRCFiAF+RSTECYMvIRdnRpA5H/rTIAZpM
	FnE99N/2RpreJblgByxGXxIpGOd8GaRJY+xYnkCcvFM/Xf5lyz0MREhwSk2KygDI62UXvndApZe
	9s1mwkItOCJPuwSL35jxDY/lU6KFiKKdLgaSlfH9iu+VWM0u+YJL5oDJ2qnSfGgmCwuVo5lwqCA
	B1mKemFAqLWUOVUYbKU6AgQsDoIL6eZsTEziFkBz19n4JJtDBpnjKBcioLpCNvGpGVOZkKItupW
	NrAKaz
X-Google-Smtp-Source: AGHT+IENXjSZ9eYxIcTPb1KA8MslU7Gkmmzo6eN91GvxyARG/yRPq8gJbKV+SVFiPMHX+dA+S+OktA==
X-Received: by 2002:a05:600c:3b1d:b0:45d:84ca:8a7 with SMTP id 5b1f17b1804b1-45dddeba3e5mr124414255e9.14.1757497509275;
        Wed, 10 Sep 2025 02:45:09 -0700 (PDT)
Received: from google.com (211.29.195.35.bc.googleusercontent.com. [35.195.29.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7532f90e6sm5750475f8f.6.2025.09.10.02.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:45:08 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:45:05 +0100
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
Message-ID: <aMFIoY5yfQa2Mzgk@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
 <20250821081412.1008261-5-vdonnefort@google.com>
 <20250908193757.079aae76@gandalf.local.home>
 <aMAZMaZJ1_Eny5Ku@google.com>
 <20250909094028.3265b751@gandalf.local.home>
 <aMBSa29ev0BNgr5R@google.com>
 <20250909143948.420bfb1c@gandalf.local.home>
 <20250909145236.69192cd0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909145236.69192cd0@gandalf.local.home>

On Tue, Sep 09, 2025 at 02:52:36PM -0400, Steven Rostedt wrote:
> On Tue, 9 Sep 2025 14:39:48 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > But anyway, I think it should work for the remote buffers too. Let me go
> > and fix the current iterator.
> 
> I thought it was broken but it isn't ;-) I did it properly, I just didn't
> look deep enough.
> 
> So yeah, look at the rb_iter_head_event() code. The ring buffer iterator
> has a copy of the event. It has:
> 
> 	if ((iter->head + length) > commit || length > iter->event_size)
> 		/* Writer corrupted the read? */
> 		goto reset;
> 
> 	memcpy(iter->event, event, length);
> 	/*
> 	 * If the page stamp is still the same after this rmb() then the
> 	 * event was safely copied without the writer entering the page.
> 	 */
> 	smp_rmb();
> 
> 	/* Make sure the page didn't change since we read this */
> 	if (iter->page_stamp != iter_head_page->page->time_stamp ||
> 	    commit > rb_page_commit(iter_head_page))
> 		goto reset;
> 
> It first checks before copying that the data it's about to copy hasn't been
> touched by the writer.
> 
> It then copies the event into the iter->event temp buffer.
> 
> Then it checks again that the data hasn't been touched. If it has, then
> consider the data corrupt and end the iteration. This is how the "trace"
> file works. I believe you could do the same for the remote code.
> 
> If we are gonna keep the "trace" file, let's make sure it's fully
> implemented.

I was more worry about the ring-buffer page order that can be reshuffled on each
swap_reader_page(), making the page links useless in the kernel. Ideally, the
meta-page would keep the page ID order somewhere.

Alternatively, we could walk all the buffer pages to read the timestamp and
re-create the order but that sounds quite cumbersome.

> 
> -- Steve
