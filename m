Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E7019885F;
	Thu,  5 Sep 2024 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539438; cv=none; b=bQ4cTxM2qE/6McXcodRIzie/KCV859JqlhzwFVsnByAjixjn8jnkqTRUv4eTqRDoiOY7CjZkkC8gAseL33ZydaF5O2JkbzgQLD2MviTR+zkmHLWvWndrochiIOVu8JWkRfd9eoZ2WOySaeV9zlWLEFukJiTvniMA1dqr6c540s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539438; c=relaxed/simple;
	bh=YNTpttWc8n0UZJorkNfjYHaeCNXMXouvGrD0NLNGTrI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMGUU8FbM3OTyfkg2J5ojdOscRhNGhf2QARBFCBb/8NolH1PcwzHI+2vcrZCd9WAQC/IAfCIpA1Ao0bsBjPnq1AZxGtYTXYSIvPfS3HMZSqym+htoVAR+l6KHXFoS90Kgs45ijBGyKC9v6Hm3QTC1U2S5YoFLSPPHlxPWvlb5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F547C4CEC3;
	Thu,  5 Sep 2024 12:30:37 +0000 (UTC)
Date: Thu, 5 Sep 2024 08:31:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in
 timerlat_fd_release
Message-ID: <20240905083139.34698d60@gandalf.local.home>
In-Reply-To: <CAP4=nvQPPd5nb3ao4tc9dCyd+fy30wX6=dziFEJ_AyaJOpnCmQ@mail.gmail.com>
References: <20240820130001.124768-1-tglozar@redhat.com>
	<20240823125426.404f2705@gandalf.local.home>
	<20240823145211.34ccda61@gandalf.local.home>
	<CAP4=nvQnW5vS5CQBZtKp-BdjYxNFbq26P36uRy3RhCenHEG_YA@mail.gmail.com>
	<20240826132620.1618d201@gandalf.local.home>
	<CAP4=nvTR9EuA5WhGweSaoeptEw0n0w5exr8gq6zfqGhGNt3zpg@mail.gmail.com>
	<CAP4=nvRfkZ2CEbFv+MFBXikZ_p2K-1uucgkdgp27JeTxe58qhw@mail.gmail.com>
	<20240904102104.6f2a35af@gandalf.local.home>
	<CAP4=nvQPPd5nb3ao4tc9dCyd+fy30wX6=dziFEJ_AyaJOpnCmQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Sep 2024 12:38:37 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> st 4. 9. 2024 v 16:23 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.org=
> napsal:
> >
> > When running my tests, the second one would end up deadlocking and
> > triggering lockdep. I found a way to do basically the same thing with a
> > cpumask and no added locking. I'm currently testing it and will be send=
ing
> > out a patch later today (if it passes the tests).
> >
> > -- Steve
> > =20
>=20
> Oh that's unfortunate. Your cpumask patch does protect from timerlat
> trying to stop a user workload thread via kthread_stop, but I don't
> think it prevents this race in the code from the other patch:
>=20
> static int timerlat_fd_release(struct inode *inode, struct file *file)
> {
>     ...
>     mutex_lock(&interface_lock);
>     <-- this can now run at the same time as tlat_var_reset(), since
> the latter is not done under interface_lock in the latest version
>     ...
> if (tlat_var->kthread)
>         <-- if tlat_var is zeroed here, we still panic on NULL dereference
> hrtimer_cancel(&tlat_var->timer);
>     ...
> }

Right, but my other patch was protecting the osn variable too, which I
don't think is necessary.

>=20
> Either way, the results are much better: before, the kernel panicked
> in <10 iterations of the while loop of the reproducer; with the
> cpumask patch and the tlat_var->kthread check patch, it has been
> running on my test VM for a few hours already with no panic.

I think the hrtimer change is missing this:

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 8543d941b870..8e611dcee68a 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -259,6 +259,9 @@ static inline void tlat_var_reset(void)
 {
 	struct timerlat_variables *tlat_var;
 	int cpu;
+
+	/* Synchronize with the timerlat interfaces */
+	mutex_lock(&interface_lock);
 	/*
 	 * So far, all the values are initialized as 0, so
 	 * zeroing the structure is perfect.
@@ -269,6 +272,7 @@ static inline void tlat_var_reset(void)
 			hrtimer_cancel(&tlat_var->timer);
 		memset(tlat_var, 0, sizeof(*tlat_var));
 	}
+	mutex_unlock(&interface_lock);
 }
 #else /* CONFIG_TIMERLAT_TRACER */
 #define tlat_var_reset()	do {} while (0)

I'll add it and start testing it. I haven't pushed to Linus yet.

-- Steve
