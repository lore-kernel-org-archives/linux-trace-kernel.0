Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569F91EE010
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Feb 2025 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266701; cv=none; b=kGc9/UA3y4yXl2hVp9UrE1UywE2JluUGwSFxxEUqNNq9mOkYmgbNYZYpTm7QnS8NpqQY8DKJiwQGQNnLdYDfWihS1ATSDk27k8df/UiQHeJb5TZf08exqupnt+44ekFpwFBuioASZAvRxJgDSj1x6d5CJW9XubRT2u0r4nVLO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266701; c=relaxed/simple;
	bh=UMEmLFxSzGCX0x4TAPfHL2GDmSKTHafVFyL78eN5EOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mUiGEli1RegT7sBNWBXinchdu5XtcelirKld37FHNv8CYLmWhPrHP/hI8yElv3ZrbDs6Y0uqlKVK585PU3+SXOmajQp/nu4KqtuIb8BTx4OsoLLXi+bLHL6H8sttPiub7iJ0kUSrqhjrn6smpWk170aoRjLi64EjDQCrDM+bfqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZaGP4up+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaGP4up+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739266698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JEBn5BDD0bivGeX0sWRFJtyk8zRNMnBY8R9geVV2WJw=;
	b=ZaGP4up+qJ1LMK3LDCKJhLvYrhnq4r4TAP3SeRLBAm7XyaooLKOAUXIeWa5GIP2ITFLLcI
	n6UTNA7OxLK0+gX2rK1Iz4/W6Q+F+avwbC7ozlLfBtz2Ku/e8U0Lpd7D8QsYMXLveD9ksm
	gKPje7i/FwligONLtPtf35dyLgDxvkg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-9xAFp1IzO1KH8hrdUSY_5g-1; Tue, 11 Feb 2025 04:38:17 -0500
X-MC-Unique: 9xAFp1IzO1KH8hrdUSY_5g-1
X-Mimecast-MFC-AGG-ID: 9xAFp1IzO1KH8hrdUSY_5g
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dc88ed9c0so1547999f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Feb 2025 01:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739266695; x=1739871495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEBn5BDD0bivGeX0sWRFJtyk8zRNMnBY8R9geVV2WJw=;
        b=tluONs/Q18elqXcexRFtL6U8P8lr0XGdhc6C6bh5YUOtlmCFHatlilfPyekDXRpKeO
         7zwuX8fGt0rAxXxLYMEhWq4jd7LT5ZRWrgLQ6qbtdP0b18woSRN23mjPogzQUB3k8FbD
         pIRitrRqP2tNfqGUs6v5cCC22TMIUW9JxjtBOGZta13U2jrl3+8NP/we2A76hvGsfQ1J
         1QefBiLX8jpsaToKmqMbzla+lj6TixmYAmTn70ubambJC1/pIj3hY8df0950GxYteMa+
         stvACcDVOkwmthwc6oKqnNYwvytIrzT6MbyYYVeeEhTlAnnJuH3nwaXBakevH5K5u+yJ
         TDdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Th4DscOn7aebpw8uld7WD+wI6KntPXeYK1vZEwCtGZcoWT93h/qG2MArGiO43D+bpw45B5pyCHdF59TQuz+VAHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeoJHkYLtYIde+QhTnFEE4lhnCRsHbJQy3WQtSjIJer33rLk9d
	iegpnOPVUDk9bie1lrF2M+DqP0OWq/JeeuTQaYSTKqx474ALzXDBIwwMBykG8HmQARtUHc5hwh3
	GwBRCJWJRJ76wSiwXH+eWjeSGoLKucmrGcOJ/jxzmpe8LHZqGthMj10LLqQKg6L/O2TqcVUt87l
	B4nhpL
X-Gm-Gg: ASbGncuHxqmJVmuWtuGi/JfokAJ95PDXEyxszMjW84HY6+z4HWFGZGyV/j1SGzh5n6j
	d5YxlKmgq17AXsTO143nk6T4qwuxX9akJTAQe5JYyhBBndnFk86ltkY2rlI5LuIzOXYvAT68gfO
	TY9EQVQk1gK1G+bAOI/ZCVpJGh3o8oElfrRx5scAshc6oZ0oVOzyGXWOYsLFK0pYQtrFyE+5U5l
	vOmyOhsuUyBsQiPwUjXNDL0BXDDMgc1U6geW+TNOQRUQlbnEk/yYfNfsy39S2cOMlK3iFtRlOuH
	Kg8br9h++yjZigjxWaN3EGEiwAAwjNHoQg==
X-Received: by 2002:a5d:648c:0:b0:38d:d221:701d with SMTP id ffacd0b85a97d-38de41be949mr2385523f8f.42.1739266695212;
        Tue, 11 Feb 2025 01:38:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi1zF8zGCXf3u5BZowhS/tIHfp/myPqRuYfehgLlAWbaD5VlSQIEDbgi0akDT9Mtd2ryGMOQ==
X-Received: by 2002:a5d:648c:0:b0:38d:d221:701d with SMTP id ffacd0b85a97d-38de41be949mr2385504f8f.42.1739266694894;
        Tue, 11 Feb 2025 01:38:14 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc53ae9c0sm12923656f8f.101.2025.02.11.01.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 01:38:14 -0800 (PST)
Date: Tue, 11 Feb 2025 10:38:12 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: Re: [RFC PATCH 00/11] rv: Add scheduler specification monitors
Message-ID: <Z6sahFdh9uVhrRhA@jlelli-thinkpadt14gen4.remote.csb>
References: <20250206080952.98478-1-gmonaco@redhat.com>
 <czykavxpz46nwnelml6yorg3tvmyjvczqogeuqzji6qrfd2peu@qxr6wucv6mrj>
 <847c962745ef5bce757b9ae257ae279913ac711c.camel@redhat.com>
 <Z6YYPAiM0itlIVAH@jlelli-thinkpadt14gen4.remote.csb>
 <59ad26ac442aef340f819ed080684d72b50e1c57.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <59ad26ac442aef340f819ed080684d72b50e1c57.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4iIS1BsWfHYiNg9ak_iOrkgWQZPAGsZcs75V8qxZLck_1739266696
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 10/02/25 13:56, Gabriele Monaco wrote:
> On Fri, 2025-02-07 at 15:27 +0100, Juri Lelli wrote:
> > 
> > Right. I guess I wonder if we can find a way to inject kernel
> > problems
> > somehow, so that model(s) can be further tested explicitly thus
> > making
> > us confident that they will be able to identify real problems when
> > they
> > occur.
> > 
> 
> I sketched it quickly and I wouldn't include it in this series not to
> make it heavier, but if you want to play with it I wrote a patch
> exporting a function to inject events and building a kernel module
> calling the function periodically.

Ah, this is cool. Thanks for working on it!

Yeah, agree, we can leave it for later.

Thanks!

