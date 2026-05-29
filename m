Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B131405F7;
	Fri, 29 May 2026 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064674; cv=none; b=H03xVrikM3p1U97IqqswUad98hJd8uPrkAz6cnOdn+w+ermzhgSEqgS96wEQuFkql8rHhQG8HLHuJnasRHDnSb9mjOoqG6AdbmlxKm0LoqZI1+1Sc1HD++s+pFfPmTAdogeJG6EYA9t96wGzzSKTmK/zTCTluA5tPNWvmNATWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064674; c=relaxed/simple;
	bh=hqQ5NSJon3qGEmy6u57pOpDKo2UkXlyMcl+d6yZ4QEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3ammHjjQ2Xh6nZzbWwBV/Ru4U6Kveq0rBD83c/hGKU4WPEcy9Vc/4Hk21ZVez0aTdgUdoddkw57D3U42+cFOOM0zlf2tH4XYrJyLk+pA4Tjrcu8MWR4V4KAnL+xX+t2r3L/+1OOevViREjDvY0pTDhatXh54Naob3bq0KqTj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id C3B6DA0170;
	Fri, 29 May 2026 14:24:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id AB06E8000E;
	Fri, 29 May 2026 14:24:23 +0000 (UTC)
Date: Fri, 29 May 2026 10:24:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: CaoRuichuang <create0818@163.com>, Shuah Khan
 <skhan@linuxfoundation.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Drop invalid top-level local in
 test_ownership
Message-ID: <20260529102422.6ae29ab6@fedora>
In-Reply-To: <20260513110208.3c14878b@gandalf.local.home>
References: <20260407102613.81419-1-create0818@163.com>
	<20260407203727.442b583c@gandalf.local.home>
	<20260513110208.3c14878b@gandalf.local.home>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AB06E8000E
X-Stat-Signature: h5edgcquxw648jzpfk84tm1b367w9a7e
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/2DKC1J7X5I69+HQZYBowIeeF1Tln6Wlk=
X-HE-Tag: 1780064663-384254
X-HE-Meta: U2FsdGVkX1+ExW2iCgtS8Scm8fAW7przZLqt31hNTneQ1HN3M0k5CfzRHFUhT/3+Wa3Jzs8Pnhc+nilo7GEbaRuIVrf0JQDGJeu9PQ9dm6eN28D3Rqc4MC8BMIrBFpcZeUcliMp21PHpv+4Z9J32GLfmVL8hD2xMv5Kcrza5vfxxKtHCts041IJk4ha1WziH0sdaWXuQLB03amVMRJD6UezEgeg/CfLgPo05odsD+dHT2X0ix9AavfjmXfJIOCYMcErpW0Na2r8UgSh/+KZhubOP2womWngKbajq+fLzczz2JcRPODNVNRpeVd1cX21QG3JSLlizjY6tRj4N49GMYH6lEo6frda3rP/x7wcbxe9YPJbmncoQ2OYRP0gYerPrz1HaMsRSaWICr4XqX3pJWitSwZGsY4dO8Ak7vXfs7Xo=


Shuah,

Ping?

-- Steve


On Wed, 13 May 2026 11:02:08 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Shuah,
> 
> Can you pull this into your urgent branch?
> 
> Thanks,
> 
> -- Steve
> 
> 
> On Tue, 7 Apr 2026 20:37:27 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Shuah,
> > 
> > Care to take this through your tree. Probably could even add:
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 8b55572e51805 ("tracing/selftests: Add tracefs mount options test")
> > 
> > As well as:
> > 
> > Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > 
> > -- Steve
> > 
> > 
> > On Tue,  7 Apr 2026 18:26:13 +0800
> > CaoRuichuang <create0818@163.com> wrote:
> >   
> > > From: Cao Ruichuang <create0818@163.com>
> > > 
> > > test_ownership.tc is sourced by ftracetest under /bin/sh.
> > > 
> > > The script currently declares mount_point with local at file scope,
> > > which makes /bin/sh abort with "local: not in a function" before the
> > > test can reach the eventfs ownership checks.
> > > 
> > > Replace the top-level local declaration with a normal shell variable so
> > > kernels that support the gid= tracefs mount option can run the test at
> > > all.
> > > 
> > > Signed-off-by: Cao Ruichuang <create0818@163.com>
> > > ---
> > >  tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > > index e71cc3ad0..6d00d3c0f 100644
> > > --- a/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > > +++ b/tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc
> > > @@ -6,7 +6,7 @@
> > >  original_group=`stat -c "%g" .`
> > >  original_owner=`stat -c "%u" .`
> > >  
> > > -local mount_point=$(get_mount_point)
> > > +mount_point=$(get_mount_point)
> > >  
> > >  mount_options=$(get_mnt_options "$mount_point")
> > >      
> >   
> 

