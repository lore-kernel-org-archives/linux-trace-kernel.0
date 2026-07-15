Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810EC314D1F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100322; cv=none; b=CGCVhZ8xblN+DO6KiRDfVbA4/IUEx5McrJq6q/iLUJ/clpkGN6EdsSQ/AHDKkFansBz5Yk0/4CpNjw397xni/i7ZqOHLHVVt2TcqR7vXfilOpByNfl5VwIe0CCvt+e5azPl+MBSs1dioW/XRuStEmM/L9XyWLL0uG5qeELxvurg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100322; c=relaxed/simple;
	bh=0/NrRgQLae/sGOXX5eF5T6xFe7lZBN4UE0b7ErzwRWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkCNTLJTzLHCeu/bXb6IKUyChawm400BSGFuSlDrg37nyreXcjLQ4iVyghXnVtqfqqyTY1jg46nb5A21gbb5E9pxCBU6IEwynxuVo58ClWF54Pu6PVKtx4VOfJC4V3cCfe6q2vBbYm27j0QQ6yBWDQtnhe3mhIF8LuMimsV+RpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=csomNDJI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="csomNDJI"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47de0093c42so1477050f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 00:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784100314; x=1784705114; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wEbhajY+iY9yR6MAnRQemzqJBfEbcuLIo8ozaPUEae4=;
        b=csomNDJIodVKgi4zeErHwXh6g0/RWr07iJdIyg+Z1QMojmn7TeWPSZT2Dg6kPHFhCc
         uQiFO0Bk84zXnNtXXYDY8dFvNlLcUtP2KPs6DbvpD11gTPpMUMTtRhPmobCuUAjTckXY
         C+t+ymyZwkG/SeBC9OlqbRma1YG2e2wUbD5oWgpZIi3KUrelI6Qk82i3MedAqtqf57t4
         WCHyVezB2+Slp1q8NbE8oeG/zcq5x+7LtIsfWzsyHmpBeWD95pJGT6Rx2MHZYTNUGMiJ
         DRSBCGr3MnmL+Bt3n4pULhzLO1ZL8BF2i9u3NUC8WXFxYtE/CiKqgyyE+Qaj67WZ9Ejw
         27eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784100314; x=1784705114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wEbhajY+iY9yR6MAnRQemzqJBfEbcuLIo8ozaPUEae4=;
        b=W6UqqTx6g17EDMEwaaWwx7NCq8OLJoEtqcmifqVThKat6mk3w/v2dZd/W+qIsGF+5q
         Pi+fPOd1siARQSMqdsK5RU/qwgoHdLFEmngzYxKYiG4ZLnCNJM6bDDv/LgyUNvohslg5
         AK2ipUkLMblkL5PJ9sV+DKW5ASLS8s7WNsn35Hiv0m+AChuwWeAYy/1nVHcJhnQX/fsM
         gUkAJE7d5INleWkzd5+1OpmtAar5Q91IodLg6ti/OgkmAk9W46oDQntJ2KY8DK+kbOqY
         174raHnpBz/RieST24562vn9KZP1b1glXSD35s4HTf2J48qJiJkJc0RbLfYqV7D8BKPW
         mTnw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/X+QLymIC9iVkBRHiMYkao4l2yuQSOaIXWAw5z+HHWwMT+mJrjZR0nS4p18oDAxJ4cfqA+ljbMudv2WQpAaFZK4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMzBDuVDtW7bPhO31E1DzEv0//qZBKy+Iv8li0EnLB7cRtKzWy
	BRzspji+xC+rvA1eq1uDeBCczdJgn2V67e8BRy9NRK3hTihiFItS/3MWx3yYLhQ5wg==
X-Gm-Gg: AfdE7clTR+qMOr97etDcWPuwALH7Fv2M75mZISBJ8ptqNDGF04uXiXucAxxeVP457XP
	4McYU/maThRBJORrEZAu7ZyjsEzpIWZ7DWtKvdcnEyoLo1PpTu6bArK7d+QCxyOPUG9pD8pYL+s
	e1mo8SjWc+NJM49zuu97yhJhu4g7W4aG+i8gq+Pt5qDR+PAiNCTvrfURA+KgTSBrTKDJeqMdEG8
	adsNHSMOESpNZWANihuz+M/e60Djl36UjSTZwvWuHIJ6nyhQYdr33GmhRvD22NLJyn9PFQ24twm
	7+RanRS89FLIGBiPy/1wbfBstvRCCsp3w5R53EI5SbHkJFRhdbkPUieT5gjpvA3aNS+MSjHMZ5X
	GU+7z3Mqa0miMi8qUDMPoJ5kGqCj28+HPtICybbZXgGqgJ44Eh42FS1imJF9mVsh0lGrk7serIi
	l/5CYUp5t+18lYzslS6JU1Dx2PLRht7nKQgWUVmB0kTomfrlYd0JA=
X-Received: by 2002:a05:6000:29cc:b0:47f:4d11:3476 with SMTP id ffacd0b85a97d-47f4d113b44mr2724184f8f.5.1784100313667;
        Wed, 15 Jul 2026 00:25:13 -0700 (PDT)
Received: from google.com (137.69.77.34.bc.googleusercontent.com. [34.77.69.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e029sm14809862f8f.3.2026.07.15.00.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 00:25:13 -0700 (PDT)
Date: Wed, 15 Jul 2026 08:25:09 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Jackie Liu <liu.yun@linux.dev>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Propagate errors from remote event bulk updates
Message-ID: <alc11bkkDvpaqYrh@google.com>
References: <20260715060448.17674-1-liu.yun@linux.dev>
 <alcsNLVLhWOH3KbJ@google.com>
 <f9050a5ba183da3c9071c5be5172c4e814972836@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9050a5ba183da3c9071c5be5172c4e814972836@linux.dev>

On Wed, Jul 15, 2026 at 07:02:01AM +0000, Jackie Liu wrote:
> 2026年7月15日 14:44, "Vincent Donnefort" <vdonnefort@google.com mailto:vdonnefort@google.com?to=%22Vincent%20Donnefort%22%20%3Cvdonnefort%40google.com%3E > 写到:
> 
> 
> > 
> > On Wed, Jul 15, 2026 at 02:04:48PM +0800, Jackie Liu wrote:
> > 
> > > 
> > > From: Jackie Liu <liuyun01@kylinos.cn>
> > >  
> > >  remote_events_dir_enable_write() ignores the return value from
> > >  trace_remote_enable_event(). If a remote rejects an event state change,
> > >  the write therefore reports success even though the affected event remains
> > >  in its previous state.
> > >  
> > >  Keep trying all events, but retain and return the first error. This matches
> > >  __ftrace_set_clr_event_nolock(), which permits partial updates while
> > >  notifying userspace when an operation fails.
> > >  
> > >  Fixes: 775cb093bc50 ("tracing: Add events/ root files to trace remotes")
> > >  Assisted-by: Codex:gpt-5.6-sol
> > >  Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> > > 
> > I have sent a related improvement for that here [1]
> > 
> > [1] https://lore.kernel.org/all/20260605163825.1762953-3-vdonnefort@google.com/
> 
> Thanks for the pointer.
> 
> I checked the v2 series. Patch 02/18 handles registration failure cleanup,
> and patch 03/18 changes the boolean parsing in
> remote_events_dir_enable_write(), but the loop still ignores errors from
> trace_remote_enable_event().
> 
> Would you prefer this fix to be folded into your series, or should I resend
> a v2 rebased on top of it?

Ha yes my bad. Then no, no need to send it separately. 

> 
> -- 
> Jackie Liu
> 
> > 
> > > 
> > > ---
> > >  kernel/trace/trace_remote.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >  
> > >  diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> > >  index 0f6ef5c36d84..5212e685f0a3 100644
> > >  --- a/kernel/trace/trace_remote.c
> > >  +++ b/kernel/trace/trace_remote.c
> > >  @@ -1149,11 +1149,22 @@ static ssize_t remote_events_dir_enable_write(struct file *filp, const char __us
> > >  guard(mutex)(&remote->lock);
> > >  
> > >  for (i = 0; i < remote->nr_events; i++) {
> > >  + int eret;
> > >  struct remote_event *evt = &remote->events[i];

Could you declare ert after? I have tried to use the reverse christmas tree
everywhere in the trace remote code.

> > >  
> > >  - trace_remote_enable_event(remote, evt, enable);
> > >  + eret = trace_remote_enable_event(remote, evt, enable);
> > >  + /*
> > >  + * Save the first error and return that. Some events
> > >  + * may still have been enabled, but let the user
> > >  + * know that something went wrong.
> > >  + */
> > >  + if (!ret && eret)
> > >  + ret = eret;
> > >  }
> > >  
> > >  + if (ret)
> > >  + return ret;
> > >  +
> > >  return count;
> > >  }
> > >  
> > >  -- 
> > >  2.54.0
> > >
> >
