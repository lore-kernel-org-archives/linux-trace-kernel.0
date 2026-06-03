Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4B384CFA
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jun 2026 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497570; cv=pass; b=IPU3rFwXTkUebkvyNHT7tz/eiLJ/4BCAnzn8E9OvKKa80bSAnCxfmQ0ga/3HwMFxeJxOrOqRDtwffGteGVUhTdSWSIvXn/40ENQGYC/GbKmzSoRcf9ml6+abi5eb8WfHQK1qiBkk1JRRLPOAEzRb7CmyZGPiucvoL5t9q6ZjMSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497570; c=relaxed/simple;
	bh=IGO3PuvDPm+gsi6Lka7LaUI6qTd54dbBVyczsiILhXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmkmuR5dM4ymt8+N2NgLWzIX8QexLISG1OI9hiZdqwlYhHMkTXIsKezL7KrchJHqm1fLQpLzl3bqIXPeK71fMR4Xoz5VntHqin+nHWK62hVdhXIF+pNm+cCIRHLIyd3GKtFqoL7zPdZI7C4B7Lt1Q6FuDLfUEgFHyFLlwqDTsqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBXv+/2r; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBXv+/2r"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so10268518a12.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jun 2026 07:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780497567; cv=none;
        d=google.com; s=arc-20240605;
        b=YPCZpl3PJg68sqNUa60is9dmfGX0NyS/al0hzhaL9EmrrSrzYWVu4zmIjFLEFGWyEC
         bSIT0Jq3W92HI+sNRUVfCV2qd9uQEbonk17szGhNd2/muglkmy2H0FGiGqPa+f6XVt9O
         iaWjru6Bc3mOKnD2i6HCD7SQ2MIBKNqnlrzUe0qS+GdpcYnGV6UrbFlkxxlZMO2Zb1DK
         kPeRb+4I3K7YIQLGXItUUcdXeJQ6e9SlIf+eZKwTmqQ3SMSuzWl3ifOqtJMH1hL36qS3
         xvNJ7th9MXH08M48nXbZjkPr71VwGK236t+7mqan75+LECc79y7mb/QinxT8UNady9mE
         Qe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IGO3PuvDPm+gsi6Lka7LaUI6qTd54dbBVyczsiILhXU=;
        fh=xM533bgWVHLdHiS1rR6crHJKCCCsce//J46/dQqCEKo=;
        b=V4JspyoiJBGIm+ucj4wMHmcMuOe31qn849CAr3YLEFR1osOD9uRxECAN+cAzXHFW08
         M41wL8gDfUMQge2EvjZqGby8vsc3l9pISMXgGlGDc9SJ68XvZP1BlKvRzWfOpdyPzERB
         vcRXh0urVQsFPnIaLCqYV0XspqM4XyGqGFrsZgqa1kX5CNoguWnYGIcVXFKWJXGJ0pWl
         uGMNBSoVVtHbRyuwne3kY6MFGScr8AE8ZOm9u83sR3AF0BLeCZyQ5P0IxHNQsRFrZFrV
         VL2azt52AueVyoAlGrrtVhAzUb+rjxav4coGZ2hSSOEE7wYzGLE6iJlJ35o+5sQWgf2n
         amsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780497567; x=1781102367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGO3PuvDPm+gsi6Lka7LaUI6qTd54dbBVyczsiILhXU=;
        b=mBXv+/2rrQJ/8E65tGladFfucL3ST48yuRmvBJifMeXU/Wenwq19Wee+/Cck8vgDsL
         1F9Spi439MxhlsO6OTw/VvqIRg7Vz+WDN+smIN8d4ZT2H4A7V46ZmBRvpSmNNvdfGZPA
         gN13FGFtn2eUZ5elpyXZMjiallTYQ8035c1tKHJwwGM1KHRENkIFKop3uQdRp2f1P4q8
         6Y9+jVmPMdpMGbdJuckX/f+HHbksBBBGU8CfEN5soyuinEo6qzUSYZXLGLohT9XKOPz1
         FwZo42XOmctNaM4n0nO+Zq0aDeVdVV71RM0ybl1rwZlt85HrNEXHHwjNMeiYYcUZmT9e
         6bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780497567; x=1781102367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IGO3PuvDPm+gsi6Lka7LaUI6qTd54dbBVyczsiILhXU=;
        b=IqxP+H75tF1Wb8m2MwdKHEo6dn2meMsmKmXuVkiu54XxZjbgaixGI6z7OVGU7Mc2N8
         vRM+m6z02JZfaC9BC+EX1b8E76P/fUuzF/Df0emH7Gq+FkuQNbS9Cayv8UqHOkvjuXoG
         vG10p1uLLvcYNC3gtQH0AGJdHSAhsW3jI7zRF1Wp/DiXH1hY9mI61xOpg82EQst+3kLD
         iMU3Y3vnZnvMEYurtXMJGw7LX6H6oOuwA7h2D99MLLhRPjwQP8tr/yXCafyr26sDJ+tr
         lmBOt3DMHQ+ALJwACCjgulg6YZp7DQh0OQU8Et9/lBtjJCKz+tV0le0M6qZ04/rcdmiD
         C+Uw==
X-Forwarded-Encrypted: i=1; AFNElJ/9B2cIkhM0vHugubVe3TbR7Dfu0zzxzvp4Jg3+h56Q5v/xu+aqrSpir7TV7ccQJgk6nzaCO2MwDPxggqgXenEEMFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbGgGriyMJ1IWSHGryZlfNSeP5GuSfZWip5MCSl+OQZT8jivlu
	YBpHW7Kj67z0EKYd7q6w7F/8SBmhd4V3euLHaE9df2xeLQwES+Uy4JkGx1sKt9ah/4+49b9AGCO
	rRgEPGln7Dta9T41Op0UkKzwl1p1bX6o=
X-Gm-Gg: Acq92OHEp4pVone71hwUkJNv4C/u01vlJes3rxZIC5DPCbpNxhC3IsvRsecCezEaYuk
	JYaumUH7iTbomZ6hiG7otFBh67GbsSZ2sRU7KZeFNTf+hC9892KQT91+o/zH3dhrqH/Ba1Qeiev
	nAVgqekGTupLbToW9x1TeE+aVn3Huq1HuaEr9NTkP8j6DwayqY0Q1YsX5RiI+nVhgb8FEmVOXsR
	iR5WCMPkrHDC435MZ2iHD5ga4m+mjiS16Z0G+GaNfCVtb5SbHx7lqx9XfueK+NdJmEhGnikVYDY
	5crVjNZ/dAtV1lE3dLXTF9EqiuEDz5y6CI1lW/IODq2V
X-Received: by 2002:a05:6402:28ce:b0:68d:92cf:52f4 with SMTP id
 4fb4d7f45d1cf-68e6f7935a1mr1958834a12.5.1780497567206; Wed, 03 Jun 2026
 07:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417231203.785172-1-puranjay@kernel.org> <ahgxkIbBLkTJyUVt@localhost.localdomain>
In-Reply-To: <ahgxkIbBLkTJyUVt@localhost.localdomain>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 3 Jun 2026 15:39:13 +0100
X-Gm-Features: AVHnY4I2ofbFOw3-botyHDbqPzrG7jRG5CNyqRLx4va3_j8bkKgXxI12wfISC8Y
Message-ID: <CANk7y0htB0VZUhXQavAjZJ4+BSZyup8uVnLaFTHbg_ixEge1-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] RCU: Enable callbacks to benefit from expedited
 grace periods
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

Thanks a lot for the detailed feedback on all patches, I will send the
next version soon with requested changes.


On Thu, May 28, 2026 at 1:14=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Hi,
>
> Le Fri, Apr 17, 2026 at 04:11:48PM -0700, Puranjay Mohan a =C3=A9crit :
> > RCU callbacks only track normal grace period sequence numbers. This
> > means callbacks must wait for normal GPs even when expedited GPs have
> > already elapsed.
> >
> > This series tracks both normal and expedited GP sequences in the
> > callback infrastructure using struct rcu_gp_oldstate, so callbacks
> > advance when either GP type completes.
>
> What is the motivation behind this? When most callbacks don't have much l=
atency
> requirements between queue and invocation?

Right now there's an asymmetry: synchronize_rcu_expedited() callers
get fast object freeing, but call_rcu() callers never benefit from
those same grace periods even though they prove the exact same thing.
This series closes that gap, the callback infrastructure treats a
grace period as a grace period regardless of how it was driven. The
practical effect is faster memory reclaim: objects that could already
be safely freed stop sitting around waiting for the next normal GP.
I'll make this motivation clearer in the next version.

Thanks,
Puranjay
