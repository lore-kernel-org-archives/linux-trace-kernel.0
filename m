Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA6E1DE886
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Feb 2025 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925756; cv=none; b=aUOSbMvM+OfFvp9xSUbr0jhJw0pb/MDVIVYEN6SC5MG0rhJv1mc14GZu9YDZG2NEC9o9sbDUhfoZlzMouQKpCVir7X1RTVwqORP4FoUp063h9c/bwJZTVQi5NXx7WDdo6sd8vxJz1NcDo6oL17YEH3Titkx+ArwH0vAPMxiIlpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925756; c=relaxed/simple;
	bh=ehXyueAFki8jwecE85SxuxxW2eG13J2pRWWxP6G8NT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Zn2Ekizr47ZrhkUPAsniQtv60c5EwvrInKMcn7Hu0qX5hpjgBDj3JzEbqO6px7WCeoVKpPLRnrrEh8afsc1Ht7q8A+mt08OiVY5veYIL4gYAb084CzpFyWotN+Z7/8edcbu/5hZM0u04OmM6iQj4cga/KL5opfKkIgdvTzLJKuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDhvlGJ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDhvlGJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738925753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bk8HYGDotJpHAOYNSGDnghbePbc88+YfjSADOoDlOec=;
	b=aDhvlGJ+ktLOjbg9+HVloSE1Tx0YHVHGb7cE5LRuFkRyKg91IDzucPN56PjWU/bzu2g22u
	QWa0i+dKTMtaXinI6L8JcCJZ4YTyMRGAOmJQSHL1q35/vVwJYOtHRZEFTaaJenhBctWI9I
	dbNhmSnhtspWanVpCIgXkEupamXyJ6A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-Fim3gVHWPYuC1z8x4_I0TQ-1; Fri, 07 Feb 2025 05:55:49 -0500
X-MC-Unique: Fim3gVHWPYuC1z8x4_I0TQ-1
X-Mimecast-MFC-AGG-ID: Fim3gVHWPYuC1z8x4_I0TQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dc6aad9f8so482636f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Feb 2025 02:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738925748; x=1739530548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bk8HYGDotJpHAOYNSGDnghbePbc88+YfjSADOoDlOec=;
        b=DPEfyk/mSuBIrakuT1fGiP1ljqfe9sEDhMDMR1Hsvw1BhoiSpl0dH746nQLzPA7N/2
         mHVYCLATckOaTzvYRGDodxvEB6StBdmUMaINkmS/iEgiCIt7M54cVEPyzeoVE15P+mQv
         v48SyN7nHycuahzANmA1qVgEp8+Vv07Sl8QcMy9/4Zam1jFWqrqq5HJO2LJf5qI1zwmm
         LmF6fVsYntjjSi6dT5LP1LiJ25Do+sVq7e6qLrOatLcWZWiCrWYiuBVMUJuCJL5S1yLm
         MRt0rDBXd1r8KoIvwrdV2bx1ZGj6cgELrisD47GzhHd3Bof0DvYWcJ/LhRwX2iomaXqS
         RhRg==
X-Forwarded-Encrypted: i=1; AJvYcCVddKgtqtcrWB91V8OFWtmxPvIsriOUikIveriUME9hYPU5ze2NqB0ivVKfat3en/kgHZ9EVFHRWsQI7BYhweon6K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUa1HxwSBWuHsDH85aRFvraQv7RAuUj94cLCmYewYI2mo5U3Vg
	asUEK3ZQQkQFSiFXd9+jmRhnIT0W8ZqvqcRSPawkJC122DAfIVcxXfStuyHhQD/Uv45vUJjgXUg
	3Qr6Ed7tjcbaLRlEC26+WJkEtcPCu/UQoo7j2aE0066hHW7COLDCJ9V5CmFkc2zxKRGBFkQ==
X-Gm-Gg: ASbGncuYDsDZ508YehzaWfBorpT5OmdO2lEJqf+KCE0mDXpsA2BOh+AD5Bc+OsMIqZe
	KSJPnIoMzlcJaKrnRYZuTHZdeILMJ95sTntUP9mEaUuU4IQzoHSubBHUxX4d2CDT9UbMsh8w3ho
	frCiKr/ODZGV8wBsz5iP1GnnSkI1t1vKmLkJd/CO/SwfHgL+1oESuXlFYkzEZq6o590GSmF3MXw
	ZS8mC1RlqKa2RfUDy+HaaU4k5D/KZbla4igNSMqAaKHZSt32LrwlMcbERiGrS3UyJnpX1bY+1nU
	0e3FF3UzekG1uf03CzwBz/ygTof67iE+L8gd
X-Received: by 2002:a05:6000:402b:b0:38d:afc8:954e with SMTP id ffacd0b85a97d-38dbb251e08mr6092700f8f.11.1738925747991;
        Fri, 07 Feb 2025 02:55:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESzdNKp6zRUwMogCn//lKykey9oFJeFZgS6oz5DUJn7qbjka4YyR98B1rDBiQT4tA/U/OomQ==
X-Received: by 2002:a05:6000:402b:b0:38d:afc8:954e with SMTP id ffacd0b85a97d-38dbb251e08mr6092675f8f.11.1738925747580;
        Fri, 07 Feb 2025 02:55:47 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.128.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc627fecesm2469143f8f.77.2025.02.07.02.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 02:55:46 -0800 (PST)
Date: Fri, 7 Feb 2025 11:55:44 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-trace-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, 
	Clark Williams <williams@redhat.com>
Subject: Re: [RFC PATCH 00/11] rv: Add scheduler specification monitors
Message-ID: <czykavxpz46nwnelml6yorg3tvmyjvczqogeuqzji6qrfd2peu@qxr6wucv6mrj>
References: <20250206080952.98478-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250206080952.98478-1-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FQ8iU98C53p21RnqcnmWFOVaYDups7vMQH_UFkTPeJU_1738925748
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gabriele,

On 06/02/25 09:09, Gabriele Monaco wrote:
> This patchset starts including adapted scheduler specifications from
> Daniel's task model [1].

Thanks a lot for working on this. Apart from being cool stuff per-se, it
means a lot personally to see Daniel's work continuing to be developed.

> As the model is fairly complicated, it is split in several generators
> and specifications. The tool used to create the model can output a
> unified model, but that would be hardly readable (9k states).
> 
> RV allows monitors to run and react concurrently. Running the cumulative
> model is equivalent to running single components using the same
> reactors, with the advantage that it's easier to point out which
> specification failed in case of error.
> 
> We allow this by introducing nested monitors, in short, the sysfs
> monitor folder will contain a monitor named sched, which is nothing but
> an empty container for other monitors. Controlling the sched monitor
> (enable, disable, set reactors) controls all nested monitors.
> 
> The task model proposed by Daniel includes 12 generators and 33
> specifications. The generators are good for documentation but are
> usually implied in some specifications.
> Not all monitors work out of the box, mainly because of those reasons:
> * need to distinguish if preempt disable leads to schedule
> * need to distinguish if irq disable comes from an actual irq
> * assumptions not always true on SMP
> 
> The original task model was designed for PREEMPT_RT and this patchset is
> only tested on an upstream kernel with full preemption enabled.

I played with your additions a bit and I was able to enable/disable
monitors, switch reactors, etc., w/o noticing any issue.

I wonder if you also had ways to test that the monitors actually react
properly in case of erroneous conditions (so that we can see a reactor
actually react :).

Thanks,
Juri

