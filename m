Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECE939CD00
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786352221; cv=none; b=kMstP4ff/iXNpdrRnZybI087ykNaMJ9vFseCzcuF37xQ+lQVcKXzJS/tKx6CqYpIQqOpEo7QfZKE+bTkC+bkFRwiv3nq+WH6UqaTE2iVvRTDSezeOhD+UMybNYMKOLegKCpVV0dKXsnHK8qnnjuMh9nU8TejKXwomcwNWtHl6FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786352221; c=relaxed/simple;
	bh=5/gkFicYCFNm08wStaFyDnxveOGdlNN9HSPjklNAjD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuRWELvgZLY5gab6OEvlSRLFeGBvzCfHSl5TfVZXd8DxeuZD35V2pMhWXSn907yhCZtXk4+8t7M4pMLqzJVVmyy01J4DgmCNkerbtAHE9923VniShMobnYD66N2Y82TuYjjtRJnZgCrf2mMWTUDLYbKbSSWkvNEYJNiem4uqtnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I5X7vK4G; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5X7vK4G"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so8010695e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 01:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786352218; x=1786957018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U+rPV33AMnvtkEqxeh/BseMoX/0mIzyj/40D38ELqQQ=;
        b=I5X7vK4GAmTQffnLyopYA1xURbgnxNuRK25bDUHv2kYqlur8Jz58618a/Op7nIoZJh
         noz6zkkW2Pu4DrXPUNWBuVipSmN+ZZnBzhw/RWR1yoGww+v7FmRE0/bstweSmUYdOxsr
         b8+QmmcByfKHMgTNYmn0i1VhqQYMIq7J48S6rPSNaTaip9vFGhDBusj879XoG5Pur2eG
         Q+0o5yIcq3+mPvMTWO4hJEqDkwKXzQCHuEdClSPngbAeMjZBFBSnihJel4OrfSKOU73r
         iyFjRUOka0cjKuDxT5a8el15Su58DtTnoqQ3Gbxd+RHre9dSHdMUUZopHopZzmB0SA9h
         yKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786352218; x=1786957018;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+rPV33AMnvtkEqxeh/BseMoX/0mIzyj/40D38ELqQQ=;
        b=UgJgXiNeIb3aESj2EwbBIzVeVlecnm70KVPXuUezpXAZikt8ZDg/G2Vc/TdrNYLQNP
         1K3fg1drD/U9+yxN0kYW9EYYLmQQnnhH/WsLCmlMzeeX074Z0x1S5emy0MIdj4A7h6vJ
         3HDHNxzJHa6qZivL6/7YrCJJSgCfTdcbpR9RAE8uboIlahYXNpbZlKRwzjEWLuW+IJYU
         AaRo1+azhpLbFhtlQPNzUOp5Zlw9cFROv3cmInkhXWf3BtU7PGjSiGtCkf2ekoMc9dR3
         vV9R3bVctLWbJJRodrY+sYZ/tB4w8RF1topVp717ZbXBHIJz/POzUpiQJQZE3sjHALZY
         fTnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJHxB89Z7E9SF3UxcEaC1SkaspP4b0BBY8aoIXSg7ysad0V2MjqCkHE7AuYymjs34PPhBDbKagT15hD9HdqPLVp/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCbNIBRDZ47kqdiUlBgWvryq305utU5m/0OkAHX+spqcRBDoew
	IqrqIZyRLiAMh2R74ik0u1BRE9kTuxCL81WYVYhjSqz1keFF2NpKzcWeyZIY5Jd+wo+WFPmKQQf
	z18J+DA==
X-Gm-Gg: AR+sD10RFDJL0/4xJoJjIL/KIVvbTPBLLHfmIeCtb6JVlQu+iq/5c5dFyy5D+3jFvZd
	gY2Otbj759MhmtYtR23i+KQ3bUCo62X6nG9P05AZ65O1vBc3zjoREuPirT66FXNdMzjoZ/xS+aQ
	JyS9XX7RN4caqas0j0ejSjvOcyic59BoWSjqHoHcq3sIvXJCZ9aMxdfrTo4+JRKNukIEHGCwxkY
	SC+RYRZM7z3BnN+LupTwLdvK69PnsS75F/rg1pil5aIdQ01VZq0dFyQbqI3tqcUSVuavcvU5Udl
	udSNGrSQ5PFUeDVkp3hte+ZOrVTk9DU8jyECV5rqgLXg83+SWFEfjCFm0Haq757NSTDjZw0XKMR
	GYJzGEuywoaVACyN/JA+e+xSBYu9aQWtqiq9sXsPkqE6mqTNv5x69ayCYn9vx+VepJL6JrIxULY
	ddW665BeAQEC7615cWNzTyVopjqhOluTdv6kGuCMLnfPDikbY1+4b5IK5Yzhsb8Na5jAahnYfxN
	H0wg0dEmCr3AFqibWNYFKRn3ijCf9rVcRqySZUUdXug
X-Received: by 2002:a05:600c:8b4b:b0:495:5fdf:2075 with SMTP id 5b1f17b1804b1-4995e0254cemr273341505e9.0.1786352217550;
        Mon, 10 Aug 2026 01:56:57 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995bdc433bsm294053105e9.1.2026.08.10.01.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 01:56:56 -0700 (PDT)
Date: Mon, 10 Aug 2026 09:56:53 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ring-buffer: Prevent resizing of persistent ring
 buffer
Message-ID: <anmSVUVPVQLPzcaa@google.com>
References: <20260806211306.3704194-1-vdonnefort@google.com>
 <20260806211306.3704194-2-vdonnefort@google.com>
 <20260807111808.d5dc1a48b080d241100f4a57@kernel.org>
 <anWT4heM5Z--A1Mo@google.com>
 <anWosNi-U8lVqBZP@google.com>
 <20260807104526.38430aa2@gandalf.local.home>
 <anX47awNHC9caDN_@google.com>
 <anX9k8x67m4Cdw5n@google.com>
 <20260807152641.4b9deff0@gandalf.local.home>
 <20260810173137.e8c5337fef0f989faed995e4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810173137.e8c5337fef0f989faed995e4@kernel.org>

On Mon, Aug 10, 2026 at 05:31:37PM +0900, Masami Hiramatsu wrote:
> On Fri, 7 Aug 2026 15:26:41 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 7 Aug 2026 16:45:23 +0100
> > Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > > free_reserved_page() would do actually. But then it is definitive. 
> > 
> > It's not always a reserved page.
> > 
> > > 
> > > Happy to implement something like that. That also means that the instance can be
> > > actually freed?
> > 
> > They can be freed now. Try a rmdir on one.

I meant free_buffer_page() skips the memory for the persistent buffer.

> > 
> > Note implementing this is not straight forward. What I would suggest is

Yeah, I started looking at it and quickly understood :)

> > that because the persistent ring buffers are contiguous, to resize, you
> > basically need to remap to the new size. That means each of the buffers
> > will still be attached to each other.
> > 
> > What would need to be done is:
> > 
> >   1. calculate the new size needed to accommodate all the CPU buffers.
> >   2. Split them up within the new size region.
> >   3. Then free the remaining pages.
> > 
> > Obviously, access to the buffer from readers and writers will need to be
> > prohibited while this is happening.

That would mean losing all the data on the buffer? Actually the trace_remote
needs to teardown the whole buffer before the size is modified. Perhaps if
something similar is done for the persistent buffer, trace_remote could benefit.

> 
> Hmm, I think we also need to record the size of persistent ring buffer at
> initialization. The buffer size (number of pages are calculated by the
> size of reserved memory, which is defined in the kernel cmdline.

Could we store in ring_buffer_cpu_meta::buffers that the page is gone and must
be skipped to re-create the ring-buffer?

> 
> So if we have `reserve_mem=12M:4096:trace trace_instance=boot_map@trace` on
> the kernel cmdline, and we write the buffer_size = 1024(KB) on 2CPU machine,
> it can be shrinked down to ~2MB on the reserved memory. However, when we
> reboot the machine, the kernel calculates the size as 12MB again, and may
> get a validation failure.
> 
> So we also need to add nr_pages and nr_cpus (maybe) on ring_buffer_meta and
> calculate the ring buffer size from it, instead of using the reserved memory
> size (we also need to check the calculated size is smaller than that.)
> 
> Thank you,
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

-- 
Vincent
