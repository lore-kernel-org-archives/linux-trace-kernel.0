Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF4264604;
	Mon, 10 Feb 2025 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739225078; cv=none; b=tcVD/WRS1OPYcFID/IT9vmEpT8RnLXSdEvzg9PwQcxUXrazQqSAtsJDPUfzGxJ0phAq8z9V4LFVUOS37l3nfs61jmiiB8YfOc3eEbGxrF5sj8pkCaZIWYGjY8+Dwt8XJ6pxCmpvJ2ap01o41i2u39SfUGX4Fzq1dShduVvhMbmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739225078; c=relaxed/simple;
	bh=4U2b8ZnGGxbJ5aRMeDe1RY0Z3qOwKUd/CS7+KZzK02I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUcffhzLVerKA8iLJnYNi59Dc5azz+IUHjdnb3JepEVft9cd6k1UpNUedxDO0nDeSObQEGra6/T1wi0yFHFm51gu8G3xeL18hsBG32IScm8/HTl9d/Rle3Bk8DDuW97qUf2at+/tLM1O+/KCG4bXOAyUgBGglTlV/lNgJrsxny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2aLvKGM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2aLvKGM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso7428495e9.0;
        Mon, 10 Feb 2025 14:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739225075; x=1739829875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAfxx6PPXMC3/snEXpozscQmAWqzWP+DEkEEu3/totI=;
        b=Z2aLvKGMCJTFXkg0jLJSFOlCxFsouOpRncqvXU6EMU9QDLxyYT0KSthRuEWUahld3W
         ueQfK9+FjTlT2Z27qkWrI2TZXugCN60Cz10Kkuv8Jy+BdNMKsT9DKW9RqyPnjML5GNS3
         xhniYqriI8UNiGyLGzqhhzR4IE+1QY8s2iFkFT/eyRsyU0bPWE8b0WXDI0OXn2KEgW6t
         +oE6L3ryoKkSdCBn9NKDDvtPDSiwu7DRkZSEmdKxYX7Z5uztQ4WsELqPk7utf8HxM0pH
         sdiV3jRvhWNGB8qX+rbYWBQSdJ76IOCAbMB3GgHW044XPQj1yTArj3BGxaAyzc+q4P+c
         Qj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739225075; x=1739829875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAfxx6PPXMC3/snEXpozscQmAWqzWP+DEkEEu3/totI=;
        b=IuTNMwLNz1V9k4vZhvVoR7GeokR+AKcXV7kX8G+pqbMOCb0z4g+1f+deuSpRkjT1Yg
         vdfQ7uqC9YOKkKXH2Mxph/OfavxLU6PsrngY6wlJuW7ubXdAYQxYwojgT9EJolPOTIEo
         rr60Nzrmuyae3mUAqBA2jpILPf1CQWNu5759JyVSW9aCEa5TFmAp96IFmJ8nfKmOyScb
         sMiOahtACOCa/W8SJ3V7JVRmVKZ3stTr1goxdkQoRE4BRbfBIYXg3eEipDy8dsJw+rZp
         jVwyPUTiIov9wiTfZf+pxfWWAYmeIYfnOTujbVGuG1V4fIFE3SlJLvZv8IJz1lth3+aJ
         9ULQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzZbQB+yKbO9fqIeLtKnZ2UBWfsRK5WzPJRcBSVW6cVRBpWuM9A3DHPbx2s9oJvFbkGHEBdUJq+h4r+0g0Jd96pJps@vger.kernel.org, AJvYcCWQtZXAC5WALbk9Ax0Uoh0NP+TSxqZPQZr7eMSpIi9t4OVNxNSR2GTK5rVunub7P9nxn4yElczeB+cL8lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR6H30cBVN23knXw4JqxqwjYPiIQPbtF9MOfilw5joc4eYPsz5
	fcRLuUjCYD/bbdQrcf4TFPML/NyCys0ZoO0Xz08FCnW0lAAOGk9p
X-Gm-Gg: ASbGnctUlS74AQB0VOVuITtsfj1sEviMllKB1gvVVgGgfu9ibF3h4gqOjT37bbKOKIn
	mDvl2iBLLEeaTL9PuYQFulEgF41Nos8RLucRlh8kQ9ni2M6QhZJ6bzntekYT9DZmx+Jk2kdDg6r
	wO/YfKr+v4vAsMIl/H5iJBKVJL15ltQ9WiOgSi5z58UgQ1DghWz8wqnrn9+7QtewkTrXLeVq7wz
	h3Sem9Ks7VzcsyBhvoz6BxQPq4PYX6Y6smsX9kX82nIdyZUmp8PUPvk29CaJU/+SxY/KYIHqhzq
	RzYl0Tj8TYrcxzWsBTX90HBHdEokRAqu1MKvvtK+R9GyXE9etGbdrQ==
X-Google-Smtp-Source: AGHT+IGIxZWWfbB/W2U9oMQGCnWyHAdx3AL9TPAWqX4BAdcbLH6Yt0taRdTOtqkzyIRBU8CrF7YTew==
X-Received: by 2002:a05:600c:1e0e:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-439249889a8mr119888105e9.8.1739225074683;
        Mon, 10 Feb 2025 14:04:34 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394376118esm48084765e9.40.2025.02.10.14.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:04:34 -0800 (PST)
Date: Mon, 10 Feb 2025 22:04:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Prakash Sangappa <prakash.sangappa@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ankur Arora <ankur.a.arora@oracle.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-mm@kvack.org, x86@kernel.org, Andrew
 Morton <akpm@linux-foundation.org>, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Konrad Wilk <konrad.wilk@oracle.com>,
 jgross@suse.com, Andrew.Cooper3@citrix.com, Vineeth Pillai
 <vineethrp@google.com>, Suleiman Souhlal <suleiman@google.com>, Ingo Molnar
 <mingo@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Clark Williams <clark.williams@gmail.com>, daniel.wagner@suse.com, Joseph
 Salisbury <joseph.salisbury@oracle.com>, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250210220433.24f6c6c7@pumpkin>
In-Reply-To: <20250210144321.1f5974a6@gandalf.local.home>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
	<9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
	<20250204220418.35949317@gandalf.local.home>
	<CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
	<20250205081635.397eacb0@gandalf.local.home>
	<CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
	<20250206083039.0916ad24@gandalf.local.home>
	<20250206134408.lD_POjuG@linutronix.de>
	<20250210144321.1f5974a6@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 14:43:21 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 6 Feb 2025 14:44:08 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > I did add a scheduling point in rt_spin_unlock() if LAZY was set and
> > based on few tests it was something between noise and worse. It seems
> > that "run to completion" is better than interrupt the kernel in the
> > middle whatever it is doing. "Don't preempt the lock owner" is already
> > handled by LAZY with the scheduling point on return to userland.  
> 
> Does that mean that PREEMPT_RT requires a non preempt method for
> SCHED_OTHER for SCHED_OTHER to not hit the issues that we were originally
> hitting? That is, with being able to preempt spin_locks in PREEMPT_RT,
> running a system with PREEMPT_RT in full preemption mode will still suffer
> performance issues against a non PREEMPT_RT running in full preemption mode?

My 'gut feel' is that all the context switches with PREEMPT_RT add a significant
overhead.
It might not matter if your system is lightly loaded (overspecified),
but if you need to run at 95%+ cpu then they will hit you hard.

Maybe you can afford to drop softint and napi code to a high(ish) priority
thread, but I'd have thought that most interrupts should stay that way and
most spinlocks stay as spinlocks - and probably all disable interrupts!
Any interrupts that take 'a long time' or spinlocks that are held for 'a long time'
really need changing anyway.

But there are some really dreadful bits of code in the kernel.
One of the Intel ethernet drivers spins for ages whenever the bios is accessing
the hardware - you can't run RTP audio tests on that system.

Perhaps interrupt disable and pre-emption times should (optionally) be monitored
and a warning output every time they go up significantly.
A 'name and shame' policy might improve matters.

	David

> 
> -- Steve
> 

