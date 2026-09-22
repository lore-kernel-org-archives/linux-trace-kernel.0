Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62AF4FE2E2;
	Tue, 22 Sep 2026 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061528; cv=none; b=N7zA3H35PF+Sh/MzN+LS/Tw8JBWBszkyUl/gMXQcl3Tw25Iz4jiEXCxpo/3dkeKgppLokfS1xCmgdQq1iEyaZ/+2yt2Lvo43SwZtmKMsM+O+krQVZaRm7io0oDIbCXFA98RVCFpRG8JiMQngj6MGT4l1sss3+o1JKvxexFU7H+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061528; c=relaxed/simple;
	bh=uV7pocMRh8zCF3luyhdWrrGrT1YqzbHFJOU09h4L8+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGt6J6/IPPPE/6Vyw4iuhGCVtqcYvD3m+ylxJZIq38VCpubJ7pvzSDaQDPCQobj2bDftZBeLIrKn7F13KMeW4bsLpE17Y6mYp+FmSN3rhNOYC0EsStmb2OC+m9Y805NbTLmCu9LFEIXuNd919GwiocafOmixmWyXmvtSgFM1ytI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgDnDhi+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgDnDhi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECB71F000FF;
	Tue, 22 Sep 2026 07:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790061522;
	bh=pTlsg96OYWHuA+B9t5BZYqZhHGwqt3xddf8KM6DyEe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SgDnDhi+n4gPVBmx54ns+OIrziXlJrCBKgmr6rjUz3yVfElw8VjBd/yEJdN6Y4sqr
	 ol5PCqJkS/gpUlFghFigeC6+y/Je1JWIRDSC4z7TzVZXIlVnFyreX5sF0DQ0vpfk6n
	 Cyyf7IfwEHFldY6xSYoqk/pJWBOwya9zzMyIfGYF82Vu2mv9g/yF887NfGGX2MX58K
	 FecMi41qzp02o5Nm61q/9qc1gKUnyjglfcmoIF3CRi4jXUbrRmsbIrnY7JpL/kx0oH
	 LhevY1ArNZU2WmsZ3hFMA/eAUbby2ndV5s9jY0AsOOXM48Rv3h0lyAwhPNvsr1+Hzy
	 +ekTNN56EbgyQ==
Date: Tue, 22 Sep 2026 09:18:39 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Johannes Berg <johannes.berg@intel.com>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, dev@openvswitch.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Adrian Moreno <amorenoz@redhat.com>
Subject: Re: [PATCH v6 3/4] net: dropreason: use new __print_sym() in tracing
Message-ID: <arIrrr5Kk-XqnqDz@kwain>
References: <20260921101538.97286-6-johannes@sipsolutions.net>
 <20260921101538.97286-9-johannes@sipsolutions.net>
 <98b93c98-21ae-4248-a60a-9625a20508ad@kernel.org>
 <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org>

On Tue, Sep 22, 2026 at 12:23:55AM +0200, Ilya Maximets wrote:
> On 9/22/26 12:03 AM, Matthieu Baerts wrote:
> > Hi Johannes,
> > 
> > (+Cc openvswitch devs)
> > 
> > On 21/09/2026 12:06, Johannes Berg wrote:
> >> From: Johannes Berg <johannes.berg@intel.com>
> >>
> >> The __print_symbolic() could only ever print the core
> >> drop reasons, since that's the way the infrastructure
> >> works. Now that we have __print_sym() with all the
> >> advantages mentioned in that commit, convert to that
> >> and get all the drop reasons from all subsystems. As
> >> we already have a list of them, that's really easy.
> >>
> >> This is a little bit of .text (~100 bytes in my build)
> >> and saves a lot of .data (~17k).
> > Thank you for working on that! But it looks like it breaks the
> > openvswitch test:
> > 
> > https://netdev-ctrl.bots.linux.dev/logview.html?f=%2Flogs%2Fvmksft%2Fnet%2Fresults%2F833743%2F9-openvswitch-sh%2Fstdout#L168
> > 
> > Maybe the test needs to be adapted to get the same info differently?
> > (and adding CONFIG_TRACEPOINTS to the selftest config file)
> The parsing in the test will definitely need to be updated, i.e.,
> the numbers swapped with the names of the drop reasons.
> 
> IIUC, this change only affects the printing and doesn't affect debugging
> tools like retis that attempt to surface the drop reasons.  But, maybe
> Adrian and Antoine (CCed) may want to have a glance as well.

Yes, that's fine.
