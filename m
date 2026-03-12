Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC5A23BCED
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320856; cv=none; b=Ag0ph3nSxbSaDXcsckUUq/LuV0h0HbbGNs+MrssFA4NeIIZBuzWCWsXqBZfK0lP42BOAc9F0iE+Jp9GliFa0wOFOR+hgayxHrZZd2Qx/dMkOQyyVAAqcB1vu2cRyyfLPfjngZPos8oxLCd1EvXhU/5tQZNMsxe40IOWZu1l0IM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320856; c=relaxed/simple;
	bh=GY5qGnINeDE7iRujzG5/erVJjPfRWP14BKwl2X5DNIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JB46I6lT/R6wp3/oFGwd/h3gxrm5ArH5H1aoVdTP0BFvnZkMyB7L/eSHq1x7iGVll1c9b2xU0RWFqaqd/W1TZgfGOw6Wk3fVKEeOYcT1Pb6Of1E96gYZuEUtjKDqswNL6sqv0cpR0RJz9v5Zu0GKrSniH6sr8pkkGPw72a2vQ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agqF23CS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agqF23CS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773320853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FStPFYH7sj7j7kmuKgyeO/ScaxttHGBKN1EeuB6hyOY=;
	b=agqF23CSfpYojOuzfCceqpJ3sLgFNA7rb+M9PZ1fa3Dq+4jic6PRPGJ8tDAE69qbMeV3o4
	uLacuHsuj1/bhp0XwWQZUCpeZ1x4edPKLHCyDQvPi02Nr6+LbN3/CsZilcDxDfQRscKM5G
	JnweCt2tRfbObQp9iwbj0PomM3G7Krc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-A5dTyu4WO0CHaS96urTm4w-1; Thu, 12 Mar 2026 09:07:32 -0400
X-MC-Unique: A5dTyu4WO0CHaS96urTm4w-1
X-Mimecast-MFC-AGG-ID: A5dTyu4WO0CHaS96urTm4w_1773320851
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439da07c5bfso712140f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 06:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773320851; x=1773925651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FStPFYH7sj7j7kmuKgyeO/ScaxttHGBKN1EeuB6hyOY=;
        b=lBS2l7w6qLRua/rbsTkYUqwP4R6Pocd0hZHNormy0BwADlRbk9j/fpK0qsLI0DkPPq
         jtlmrRv3okgHIe2t9/Kds4Pd0EhuJmcGm9RehyziA6xK/+mb882FOUSuWslYlneNiwSj
         wCxsXiDg+EIrOGKp69UrV5Y71NL3PIilyAMc4YsS4WJpWwK3QWRUKwoCcCMG418ZcTcL
         /k7GyFps0mxV63PFAScru53hLSavcX9JHZ20n2/LGGgDgn9hluACazpJSkQQB/eSk2zu
         G1id4/IUf6goRSf6bP/69IGbzxq5A9nqjYzn02Opz/LSs82UfrSBBsvrG3eEzSjCw0N2
         FJTg==
X-Forwarded-Encrypted: i=1; AJvYcCUL5DfuVhLoateXnKSoHsw/tjPbbsyBKn/fFSCUQbX9ITEhsm1mHK31plMBgHNHHst3wTjw5RWgjW9IkkMlIAd12TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwewJtTOfVsnvhNlgCiLvbTkamMv+LRR5xuZcpTFWEP/NhLLBTd
	gBxkxe+CH6MGkoChDV8wluT7jhRD3AsB/RC0SotNU9oxwnJpWnCgdgwcPBwTx3G0Gu0gc3oZoH1
	3kiWeHvmF+yLLqLEUM4hPGQhBW/+gNzSOdo+GRaVijcHZiBdeH9SOgpYDJYbBni+pbbtUMJP3kw
	==
X-Gm-Gg: ATEYQzwsrRHFDCwSRXTx+0nKGDuvIsLYXRkuKM9yyXjTUFzpw0SYCG1IS+W6aC3DnUJ
	l8wtoNsNX7n685RIXq5nlYW7NW+H8uSOEazWGdFcSu7Hd+jxejF6DPS92i4nRCgkbQjyndogh/3
	Z9/b2LMg7Rpc9pW/awVvMuxj3PBbNxErBASM6FBGORp//QVReFMgnPRR83w1yjzsYIKhheYQjdr
	bt+l377QZF5mRzXUAtJvtooMggVJ6RpitpfKmoh3uadBbmmUHY71alnAxaTCctmAvpoUXboxHhC
	rAMYqI+ucw9lmAbmk9HYQLR2pfDqqR2jytMNHCumqWTOzO+XYVs3L+Zxc/wSmxVjv/Rsb/w07hU
	JJ6O8bDyCsITWH9xARZRujbG/6upvK+RZCnhUwniEZff2HOGQmZE=
X-Received: by 2002:a05:6000:2884:b0:439:cee7:7174 with SMTP id ffacd0b85a97d-439f84151a7mr11879708f8f.52.1773320850715;
        Thu, 12 Mar 2026 06:07:30 -0700 (PDT)
X-Received: by 2002:a05:6000:2884:b0:439:cee7:7174 with SMTP id ffacd0b85a97d-439f84151a7mr11879622f8f.52.1773320850188;
        Thu, 12 Mar 2026 06:07:30 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.82.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2187aasm7448982f8f.30.2026.03.12.06.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:07:29 -0700 (PDT)
Date: Thu, 12 Mar 2026 14:07:26 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v7 12/15] sched: Add deadline tracepoints
Message-ID: <abK6jlVbeNtvG6n7@jlelli-thinkpadt14gen4.remote.csb>
References: <20260310105627.332044-1-gmonaco@redhat.com>
 <20260310105627.332044-13-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260310105627.332044-13-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9BzPBAp9XUkrj3lwcXRnka8B8tSafxL1zojPr8QMpEQ_1773320851
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 10/03/26 11:56, Gabriele Monaco wrote:
> Add the following tracepoints:
> 
> * sched_dl_throttle(dl_se, cpu, type):
>     Called when a deadline entity is throttled
> * sched_dl_replenish(dl_se, cpu, type):
>     Called when a deadline entity's runtime is replenished
> * sched_dl_update(dl_se, cpu, type):
>     Called when a deadline entity updates without throttle or replenish
> * sched_dl_server_start(dl_se, cpu, type):
>     Called when a deadline server is started
> * sched_dl_server_stop(dl_se, cpu, type):
>     Called when a deadline server is stopped
> 
> Those tracepoints can be useful to validate the deadline scheduler with
> RV and are not exported to tracefs.
> 
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Looks good to me.

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

