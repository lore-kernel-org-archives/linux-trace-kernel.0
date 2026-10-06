Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A124C466B03;
	Tue,  6 Oct 2026 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294164; cv=none; b=NO5ndyg2ZIjrDnyhkMFSBGnKkSUCUDtJXE+ystsj89/SExMKOnjyFCEDwXJwXgwcdfowewCct5DXknSBSb3X741zgejJMAyOCZrbtorq5vbQVH4caRaDl/J+7tMNkK4vobI+ntIuBKebLxiNpAsV0GHfIoqI1RtGtNxXopkJiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294164; c=relaxed/simple;
	bh=NhrerJh+FIvyRhVhYK2RZ3+zs0tCPgHwWAK9TnlDqNQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Disposition; b=HKhOTovgd6B18u8YxyBugqePBwuf1Npl497oW42P91kiZR8jfOroW989ovDo77bVOMqhmqw6TlnYa/Dk7wKCpF8DhMVVTUZNX8OoxfjkVmng36n+unT8VBG8yGI6qT7tuVJNxjG1Dm2CXMahxebezZg3U0V/9SC4nHKjZVm4278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RuMjPgCm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RuMjPgCm"
Received: from [100.96.208.29] (unknown [52.167.115.14])
	by linux.microsoft.com (Postfix) with ESMTPSA id 32D2F20B7166;
	Tue,  6 Oct 2026 06:41:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 32D2F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791294106;
	bh=ymMYpd6/ibtw57JvGJoXuuopAlt6a2U5TBrWdbZiyQA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RuMjPgCmBvwWFqM+/GDz624NyLfl8MGbycwDBi/dO36j4yzCvNGbd42i29eU67ko9
	 bZ/gwTZVNgJfYGSAzXf+jqQVR1ctGwg35Gh+faD+Fu865MgYWyzGt4suetKMUJ5lPM
	 I1Gfd1BZYCNE436+NhDi1pXE0y/Xdz8lWpKcmo14=
Date: Tue, 6 Oct 2026 09:42:39 -0400
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, 
 "=?utf-8?Q?linux-trace-kernel=40vger.kernel.org?="
 <linux-trace-kernel@vger.kernel.org>, 
 "=?utf-8?Q?mhiramat=40kernel.org?=" <mhiramat@kernel.org>, 
 "=?utf-8?Q?mathieu.desnoyers=40efficios.com?="
 <mathieu.desnoyers@efficios.com>, 
 "=?utf-8?Q?linux-kernel=40vger.kernel.org?="
 <linux-kernel@vger.kernel.org>, 
 "=?utf-8?Q?akpm=40linux-foundation.org?=" <akpm@linux-foundation.org>, 
 "=?utf-8?Q?kees=40kernel.org?=" <kees@kernel.org>
Message-ID: <0499A842-AA79-49A7-AAB5-47003DD799BE@getmailspring.com>
In-Reply-To: <20261006083825.2bbeaef2@fedora>
References: <20261006083825.2bbeaef2@fedora>
Subject: Re: [PATCH] tracing/user_events: Fail fork when event state
 duplication fails
X-Mailer: Mailspring
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



On Oct 6 2026, at 8:38 am, Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 6 Oct 2026 08:01:14 -0400
> Jeff Barnes <jeffbarnes@linux.microsoft.com> wrote:
> 
>> Yes, that was intentional. My concern with allowing fork() to succeed
>> after removing the child's user_events state is that the allocation
>> failure then becomes a silent loss of inherited tracing state.
>> 
>> The enable word is the userspace-visible indication that an event is
>> enabled. If the child loses its inherited enablers, later enable and
>> disable changes will no longer be reflected in that child. Removing the
>> state fixes the stale-value inconsistency, but userspace has no
>> indication from fork() that the child is no longer following the
>> inherited tracing state.
>> 
>> I also think there is a potential security implication here. If
>> user_events are being used for tracing or auditing, an allocation
>> failure could result in a successfully created child silently no longer
>> following subsequent enablement changes. I don't want to characterize
>> that as a security vulnerability without a demonstrated security
>> boundary, but silently losing that state seems undesirable for auditing
>> in particular.
>> 
>> That is why I favored returning -ENOMEM: either the child is created
>> with the inherited user_events state intact, or the failure is visible
>> to userspace and the fork is unwound.
>> 
>> I agree that uprobes provides a useful comparison. If you think
>> user_events should likewise be best-effort across fork, then removing
>> the state on duplication failure would address the inconsistency without
>> introducing the new fork() failure path.
> 
> Question, to use user events the application needs to be involved,
> correct? That is, there's code in the application specific for
> user_events, as supposed to uprobes that can attach to any application.
> 
> Thus, it makes sense for uprobes to only warn on failure. Why should a
> task fail to fork if something attaches a uprobe on it and it causes
> issues.
> 
> Now if user_events is driven by the application that has them, then
> yes, it makes sense for fork() to fail if the user_event it created
> fails processing inside the fork(). If the user application is
> expecting something, then if it fails it should know about it.
> 
> But this is only if user_events is driven by the application doing the
> fork().
> 
> -- Steve
> 
Yes, that's correct. user_events registration is initiated by the
application through the user_events interface, rather than being
attached externally to an arbitrary application like an uprobe.

So in this case the state being duplicated during fork() is state that
the application itself established. That's why I think propagating the
allocation failure back through fork() is preferable to silently
allowing the child to lose that state.

Thanks, Jeff
