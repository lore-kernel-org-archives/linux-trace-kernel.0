Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F7478E52
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637045; cv=none; b=qAHK8Ia30yyAW7b5lLKqspvBy+xNxz9AwZpod64NRBKaik21c5WGmrPr2ddebFwfx1OKaRfq7JLdaJEF6Y6DLUp5V1RMhHa26I82ctNMdQuWsB0ocSn6OHgXgNfz0GnRarpsAkYm62NtqbImC0W5rX1EmtepEd7c8ieBTlooh3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637045; c=relaxed/simple;
	bh=jQAxa+4NKPp2tyImWEswhNJEafeGChFMbHTtA9nfCPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQXDpIqcjxatecfYFpwT1WnEtserYPQ8y4V+wUQWKSt0HrnuCYbyrnSc7ou2fhNvgqlgzXZlhbFq2KXy1ztW+QAVCKNQcR7yfkIIuKKuhcd8QyWYQHCsBrEycfk3QMivPzFevAXxR8HgVUK+tTG9iHK4ZJh5xxTuHe6Nzzc4++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qehr3iMZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qehr3iMZ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-480001972b8so931178f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786637041; x=1787241841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uLFM0Ir0MaFZ+RpPPQi6/Ybfv67iG9IZASR0E277M9M=;
        b=Qehr3iMZ1PiCZ/JXGzrxTLxZUfPGvvhWYc10Yhb5btBLXa2cwHdZJSwlIXKB9k0U93
         xEK0OlH4Qg/dSNLk6NGfcXoaIPiBXfcxooIXcaMTLqULUyVGJr+rHETna0m0FgGmzLE1
         /hHrqtK6lkdaOi95TYI8/Hu7/pzhewevNL/KYJK3VaE3HpCtkeuFlrYiQ0049zA/Z5RN
         zgFbXypYbkSCc/WiqIjZKVmjhB2cpMpJzwvLaM7npBvrrOQu+DXqxYqk8YOKZQRPMFzG
         0InHPBvjnzAp9crAD0S5YHsy8Mcnv2Tevo4aQ5SFkwTD4LK6Lr91K7/EKY2/2ehUp6DM
         rjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786637041; x=1787241841;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uLFM0Ir0MaFZ+RpPPQi6/Ybfv67iG9IZASR0E277M9M=;
        b=bmVtt6IEGHdb8/AUQ6o6zyj+aYRwSwBE5A7DrpWELeNzMJIdN7WKQcPBvk8d8WsOSe
         Iem+6x4cW7VcPzc101J11rjzRj6GM1YjVzfmS+TRLxFoXn2v0DMhYGf4tipIybsgugaS
         JqvxrRBDQsZYxSmZK2Uh/9dYBt22teG8XDM7zVjSxC8gcIT+925+6Gz6C2Ym91RwVzPL
         23BW8CZExgG1jEdLJyYW9xFEj4BNHMlEPai5eOHxVtdN4Xw2zEzqjyCqzSo4hEybiUSU
         v2hNVCAVdLySNPPm+Zuini8izYRr+ejm/1a0mS4NLT5eO+zHKvy0RTUJPQVEYHcfvlp/
         AAmQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjLwyOOO8z32UHA0VODNNQ0w+G/xVWu1jjfEkWhTdons0kE5LPyVggIcyjKaZZtEWSRszxqaHiC44BJEbGmLIhM3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66ipQD8TQwPsbe9sjrnBvr9cqEkkXNfykWZYpsRDU37tNgJP3
	GhmCfA2GeB1Im4lYkdRRYcrn/l1R6tWaf2etDW/m8FTN8hJINa+/6CBbeMdVasbfNQ==
X-Gm-Gg: AR+sD12kRhzpyLboYFPM2d6Y7QalmprLGkWeWjTnSZmPWJAjeRF9IcqQ/q7vKjBTBqQ
	rLEifiutEDD1otvRQokqq/WtoR95GrRZDKclgAYYfIPtQ6cEA2sztOc0E1j9MH5ZKCJV4mIj4/Y
	FkKTaSwh6PHBF9aseuTbd/Pv5QzvHoCM/tJWYe+FEFuZ/2U9Z3ghoVtXkuGB+bXjDv2dPszbytT
	iSbm8nVkOq9nYmtzCZDA1l5R3BnAulGvM2fR5+2lUPsujdJ72kG495Ckn1NGujef8iE2LF97dEf
	wFXgPqdXv1QqYgRa/U7oEnBwxeQpsPXzcEiJ6as0nSSmQbdQ5lHiVc686O5dUdFq2AEDPDYpyf4
	nfYOuZDG9u74nJMmZM++7MOWzfdR4xKMeFV3MktrbkAjHAX2/+VsRGUaKf0//Kx4dpydooFxUj7
	Mzji/OL5NtbLgoSR+A0Z+7noKzipLNAGcroARrj5aQVT53gtwbm1+fw5+mjYUaAmzVifOWbRYfM
	aqtqo+7wWwNz6DpInKMzI2BJUcnJL8S
X-Received: by 2002:a05:6000:4802:b0:47f:fb57:8c7f with SMTP id ffacd0b85a97d-4815a008815mr10740971f8f.29.1786637040228;
        Thu, 13 Aug 2026 09:04:00 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f200752sm403643f8f.1.2026.08.13.09.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 09:03:59 -0700 (PDT)
Date: Thu, 13 Aug 2026 17:03:55 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/10] ring-buffer: Free cpu_buffer::free_page with
 subbuf_order
Message-ID: <an3q66cnL91nm5Hf@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-2-vdonnefort@google.com>
 <20260813135439.E42E01F000E9@smtp.kernel.org>
 <20260814004932.4bf99af3fd65e8132142d335@kernel.org>
 <an3qrsYnQJ7ovwhQ@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an3qrsYnQJ7ovwhQ@google.com>

On Thu, Aug 13, 2026 at 05:02:54PM +0100, Vincent Donnefort wrote:
> On Fri, Aug 14, 2026 at 12:49:32AM +0900, Masami Hiramatsu wrote:
> > On Thu, 13 Aug 2026 13:54:39 +0000
> > sashiko-bot@kernel.org wrote:
> > 
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > 
> > > Pre-existing issues:
> > > - [Critical] A data race and locking mismatch between `ring_buffer_subbuf_order_set()`, `ring_buffer_alloc_read_page()`, and `ring_buffer_free_read_page()` allows `cpu_buffer->free_page` to cache a page of an old order while `buffer->subbuf_order` reflects a new larger order. This leads to heap buffer overflow and buddy allocator corruption.
> > > --
> > > 
> > > --- Patch [1]: [PATCH v5 01/10] ring-buffer: Free cpu_buffer::free_page with subbuf_order ---
> > > commit f550c0bfeadcc22eca47316e1820b4d91f6ef261
> > > Author: Vincent Donnefort <vdonnefort@google.com>
> > > 
> > > ring-buffer: Free cpu_buffer::free_page with subbuf_order
> > >     
> > > When sub-buffers use an order greater than 0, cpu_buffer->free_page is
> > > allocated with subbuf_order. Use the correct order for
> > > cpu_buffer->free_page.
> > > 
> > > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > > index 2667992f0aa29..a3d28b2e2c94a 100644
> > > > --- a/kernel/trace/ring_buffer.c
> > > > +++ b/kernel/trace/ring_buffer.c
> > > > @@ -2631,7 +2631,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
> > > >  		free_buffer_page(bpage);
> > > >  	}
> > > >  
> > > > -	free_page((unsigned long)cpu_buffer->free_page);
> > > > +	free_pages((unsigned long)cpu_buffer->free_page, cpu_buffer->buffer->subbuf_order);
> > > 
> > > [Severity: Critical]
> > > This is a pre-existing issue, but does this change expose a buddy allocator
> > > corruption if cpu_buffer->free_page contains a page of a smaller order than
> > > buffer->subbuf_order?
> > 
> > Hmm, I think you have to fix cpu_buffer->{free_page,subbuf_order} race issue at first.
> > Let me try another series to fix it.
> > 
> > Thank you,
> 
> You mean this one?
> 
> https://lore.kernel.org/all/20260813131152.3589632-4-vdonnefort@google.com/
> 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> -- 
> Vincent

I believe I have covered most of it now... but Sashiko reviewing patches one by
one doesn't see all the fixes in one go.

-- 
Vincent
