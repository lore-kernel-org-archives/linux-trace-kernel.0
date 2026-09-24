Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E6847C0E2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252788; cv=none; b=Ga9Bo7m1JcqvseSd8dlKIAO9ZtjK9wwhN98vKKeDfj5g5OcOd2yALbacRB5wzUcH3vAWRAHiDwQXp1J4dx3+rwvX5H5ct84709odpwSjBR3SE/U1yz0eYIA853KGsRheJjRzGb+tQvrjCVhw4HtI+EA6c3C61l9pqCcnj8sQNXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252788; c=relaxed/simple;
	bh=hYEF9jVGBYNSAPyKRF0WoUj5Wb6jNmc+eEi2HQ3zXIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNcNEhDqB7GBdfFwcV4meosPNweP5zeoIS8aII8idfoGRFyplWBWh6bzr6pmGj5t7DAKS0f3QWFFSCZAbrAvnAse4ElK8iN/e+R/w6M5RsMBRdqize1ZGNkVj4lfeMSXZ1+I+vjzJQtpqvgvjooaGvdHo6HSvloUpjb564akXbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvGeXFoj; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvGeXFoj"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b91369d18so13813365e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790252784; x=1790857584; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sTttv4o9hZeXqnTlw64U0gcVaLM+J7dfrd7tSslnvX8=;
        b=cvGeXFojBkuaWIdjjLgxKhDtboIN8k3mB7lZLQw5rATeEEU+UoZO1NtNVlHh574EnN
         HzUoyF6sEbWSCfFScAmfQczZjUWR7WavVCLdhLw+JCp+T+BXeyk41FuvDYSK8XG1L0u+
         n+FkhVvXqbu43+BDVLs9YA3afwsa2lloDDsTQxLN4u2iSqxAh26eZaHkrERB5k3rb3+n
         fPk7L7HipTeZrFOFlUzblKon9PisEmpnyGTFpaiNDSX3yT9ww+hb506REV2+kF4GFoFJ
         fP4GFsfbGX/tpLvGS08tGCNYOPq2AqhAw+SaeCQblRxZ9JRa94hS3/EMUS2lO6EIY7GF
         kZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790252784; x=1790857584;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sTttv4o9hZeXqnTlw64U0gcVaLM+J7dfrd7tSslnvX8=;
        b=eT/DZfTedxUJjnUsAS3LCyD9kOHVgHtNLoGfvusE3y8wuEwYJ1PjBZkYI1lL9rdQTl
         XHGK8OnYbhssLIj1P+xIorUnIOMPKU486gTkynfJBLFC96uTkUsix/13wTdcvdIkJMiK
         Z6ayiY+CruQV+Nr8lBp2TSVg6NynKP58k5IstbbMi4wgPDZuq65meKh3x/HuKPqqN3fX
         RE60DaApdBvy1IwxK5U+/jCdmJcRQqM/714m2r2InkW+GsFIIuDLwqt1od2C9je7g3Kz
         5uSGHSIHf1w7XPg/62fN7knrJb4yhdy2lIdZn+vpfP4CZysFc87/ff1j5lufp4hMVHqE
         8mTQ==
X-Gm-Message-State: AFuF++mAEijiRGpZmuQrTKudOsYAMOwg7GrZD1JRjKxspWPqXDuEfLCx
	Ni3hu+bnpFUJoueKn14athmgfv3MKBUWtuu0xSAMe2lYeg4VEtbz2cHJuvBpcnZJDw==
X-Gm-Gg: AYBFou1Zsj31Quv0G2E4/Te62W2F2t5PZTOica3hDmbTyRXvdLSbD5+/KaqTWM1Mv3U
	60ct4T9qHJEMam6P+Sf5ffSmMKcUR5R2hU8o8MjTTWqqUG9PygTRzZvmPuF2ZNuJikg56qnY4OA
	76v8KxJAZJtu4efx09c8426wRIrK3Aqaoy76QH+mdKYhzRj1NG1sZvdEqYzC3HyMtPvchwSGb54
	Ufmne7io/fOz+Sa230Lt/73JMRLKaIRjiTca0HCNXbBfAjm0VgwG/tM67UujF+Klw+1lFb1H4Py
	6CdNC5qHuzBn9iHk33rAfKQ+TCiEnz0MhLjH/Z6Ri/czxC3TZJQ2ACQMKYa9IKrcMYhzybA1Ocg
	agbJcTwj1fotQrUo1l4EuFDLGD7/IEI44jtRa25Bw6yV4jZ4Y2lc3sxYH3km+DC6Pdzma26SZT2
	geiRZ5o3O/kwmiPRJsVkGiydZe0JwqlVpufMSqFGn7pnrDAvDg1nn1lpFVHv8KxPeKpAuOrf709
	zMLpG6UxByawvOIyTCRBP+ZboAfXGdhsWtvZ+amZBQ=
X-Received: by 2002:a05:600c:8411:b0:49c:fc6e:a3da with SMTP id 5b1f17b1804b1-49fe66ef334mr37543295e9.25.1790252783277;
        Thu, 24 Sep 2026 05:26:23 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b9c59dsm60308195e9.1.2026.09.24.05.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:26:22 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:26:18 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/18] tracing/remotes: Gate tracefs files opening on
 trace remote registration
Message-ID: <arUW6hC3vn1EJLYI@google.com>
References: <20260817135517.3919534-1-vdonnefort@google.com>
 <20260817135517.3919534-2-vdonnefort@google.com>
 <20260817140902.EA76D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260817140902.EA76D1F00A3A@smtp.kernel.org>

On Mon, Aug 17, 2026 at 02:09:02PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] Error paths in `trace_remote_register()` leak the dynamically allocated `trace_remote` object and tracefs directories when initialization fails.
> --
> 
> --- Patch [1]: [PATCH v6 01/18] tracing/remotes: Gate tracefs files opening on trace remote registration ---
> commit cea65090c9ee422e607003e731a26fe505c23e56
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> tracing/remotes: Gate tracefs files opening on trace remote registration
> 
> This patch adds a global list to track registered trace remotes, preventing
> users from accessing tracefs files for remotes that are about to be
> destroyed. Tracefs open operations are now gated based on whether the
> remote is present in this list.
> 
> > diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> > --- a/kernel/trace/trace_remote.c
> > +++ b/kernel/trace/trace_remote.c
> [ ... ]
> > @@ -932,8 +999,12 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
> >  	}
> >  
> >  	ret = cbs->init ? cbs->init(remote->dentry, priv) : 0;
> > -	if (ret)
> > +	if (ret) {
> >  		pr_err("Init failed for trace remote '%s' (%d)\n", name, ret);
> 
> [Severity: Medium]
> This is a pre-existing issue, but does this error path leak the dynamically
> allocated trace_remote object and its tracefs directories?
> 
> If cbs->init() or an earlier step like trace_remote_register_events() fails,
> the function returns an error code without cleaning up the remote pointer or
> calling tracefs_remove(remote->dentry). Will this prevent the remote from
> being re-registered later due to tracefs naming collisions?

This is fixed in the following commit.

> 
> > +	} else {
> > +		guard(mutex)(&trace_remotes_lock);
> > +		list_add(&remote->node, &trace_remotes);
> > +	}
> >  
> >  	return ret;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260817135517.3919534-1-vdonnefort@google.com?part=1

-- 
Vincent
