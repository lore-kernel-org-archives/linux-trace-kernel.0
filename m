Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4E439EF37
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618060; cv=none; b=VDzjMXUrg2tibSzmZCnzDqYWv0M3vyAds6p1jQm25GMWzTGTmabPJLkHrokgslsvx2RfFSmLHfVTDYQgF0WHXA8KfDApkKHoVwqrrXyf9TrvQv8tENCvo0LxfgX+dy0+hsVrzcVoi7GF9vchjZcdy1XZMcQwFOsgfT0P+rQ+eMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618060; c=relaxed/simple;
	bh=eTa78WHUoVEvfYrnL1ZrbRTeOyVh9VMa4jG2UuaS4SI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWNd/Rz+vPpDC2xmewm109PMRytTZjk5QiFnHoF0CCq9A4hc0tLZ8F81igP/cnZwwQNrbIRZIQIKuBzG2EFcTj2X2FSk9K/s6Y4gbsiQrus9vXf462RqW48Blm69orZnJa5JHw2sFhQjwh9AQsavSlUEW8VY0Je1jhPIfT8Jk0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZF5A+nkN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF5A+nkN"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483abed83b6so55582205e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 01:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772618057; x=1773222857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04TQwyjav+Mkle+Jlhsg1YPsdYQI6BcfeeGyJ/oU2Wk=;
        b=ZF5A+nkN4Wcm2GQfTfzasFYPtzOGaM/vnwrBrdwOHvMRjyvx5cL5oO9Sp61/l9DUwV
         G6bB8r8ffMHAPCtV9nj/Hto696l6ZtoYRDeqQ4Ds6wW/8pCPYtHRWCGpBCYg9Vc2zink
         IDgfXFWIz66OyXC7A8OPb0g16zqtBIQ+htDd37Z0zODKNswgoSIHHPvRB9SZvF7YET/U
         k6Adb5pFTLVi5tBPvQd32cRvnPg5sMJB8GydQfx2rU9QqKDMOS/fiCw3eUsEqy/9ewAa
         bbw+QteujQd3wVApvB4P/kF5A8MCaqZuQqk2h+HgvOYcP+0dYnf5NwEg9Erk+zZJhF2f
         540w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772618057; x=1773222857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=04TQwyjav+Mkle+Jlhsg1YPsdYQI6BcfeeGyJ/oU2Wk=;
        b=H9aAmc39ZkMfGbejKkgCMIC0O0+BEcUvkyHZ8HGilYtXlw/SRLvN2TZLxdXnloDlqZ
         rHRZ0D8EWUDnt0ZAcpnM8bKygysevI6n/0QV0ja1j3XdiVf5ntYXa+ZeoKDQS6UwVk/6
         TmhYVoUvcHz5zYRKnsejT7k77qv2XauTsKENS8sMGK/EKH67pHuMBi4Bj5wwV1/ix4Xu
         lKQwjq/ce+DxeuOaZvsMtsBFSOvPzBiSby4hN0dC0drA0tOujKKuBU/K38S+MoGgwK3X
         04A1Jvp2wtj8erWK887QHkMqXCRv4LM6U85ArOt1ulkzl1pSpYBE0xAR2orEsPSNQlWh
         MO9w==
X-Forwarded-Encrypted: i=1; AJvYcCVy7NamLXaQjSse5Mg9pVWvYYAfO/aScujjzRno1EpEZ8hp+rZ77heWB45RIVx5h0zmv6Jp+S+g2Kt+vYYk05j0fFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp/7F6x/tuoKPp/sqjBJUxqHovflIiTkXSRctHwCLXGc2rlbJF
	4wI98PbqaEi2i0aMwwxG61YErhDUdSVDPPWxBEVzM5ymkfvj/mjwkSay
X-Gm-Gg: ATEYQzx0a8kxeIea2PC4T/BpwxY+vvxul5KM4xwDAjD9ngcJ/HFLHLBS+pYYEQbQQi0
	UMgBK7griDCcw6WRn4ukaEclzobs5LyCp0KsIEx1Zd6umIwciGnTwcmRUbw/Khx4I2keFiL7Mzv
	Is7ErS/UUGEfIvTwoLV3NBoCRb65ux4bCBTjMIsnKGiY2/kMTOAPCREkdvQFoY7AoufPnHbD+FS
	lqVDamsOJ5FblSg5mvX1CkBCl5WdOnYZXonaPpXHL2kK9MDQotbNomqMfsE1rBW0uNoNIA0qB/c
	9IVW6/hjqIs8ngLx5ja7/jI+a50yAhf705zeElsu+u65Z5giwpAbTn3jEvrLt84yaKnF/Agcs7q
	330U904nW4BlI2uNlCwioXong21gWUPXhkAWltE9SpliQIJwoGHm98WbpJZnJ0KqnHEDHW3/5Hv
	vmBjWgZKmtS82BxVceSW62RvTkq1c/nPBYkezJW+4OVFCbPWg10SAJwNOJw7HE57Cj6D3eLS6CN
	1M=
X-Received: by 2002:a05:600c:6389:b0:483:75f1:54f with SMTP id 5b1f17b1804b1-485198a10e7mr21116425e9.31.1772618057285;
        Wed, 04 Mar 2026 01:54:17 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485188923c2sm40345475e9.14.2026.03.04.01.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:54:17 -0800 (PST)
Date: Wed, 4 Mar 2026 09:54:15 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, longman@redhat.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
Message-ID: <20260304095415.4d5f2528@pumpkin>
In-Reply-To: <20260304090249.GN606826@noisy.programming.kicks-ass.net>
References: <20260304074650.58165-1-laoar.shao@gmail.com>
	<20260304074650.58165-2-laoar.shao@gmail.com>
	<20260304090249.GN606826@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Mar 2026 10:02:49 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Mar 04, 2026 at 03:46:49PM +0800, Yafang Shao wrote:
> > Introduce mutex_lock_nospin(), a helper that disables optimistic spinning
> > on the owner for specific heavy locks. This prevents long spinning times
> > that can lead to latency spikes for other tasks on the same runqueue.  
> 
> This makes no sense; spinning stops on need_resched().
> 

That might still be an issue if a high priority process is spinning.
But a %sys spike doesn't imply a latency spike.

Is this using the osq_lock.c code?
That will have problems on overprovisioned VMs, it tries to find out
whether the hypervisor has switched out - but ISTR that is flawed.

In reality a spin lock shouldn't be held for long enough to cause
any kind latency issue.
So something in the code that reads the list of filter functions
needs to be done differently so that the lock isn't held for as long.

	David
