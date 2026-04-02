Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66433F0A8A;
	Thu,  2 Apr 2026 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147136; cv=none; b=LeUi6CoTCrPkoZaXr547hI7Yju7RTxvsFF3ha0TQ1NSVGpTZoXR9qHBx9Lu28A5x0DbFbkg7Rg1ScWPauD57iLDNjCVI5xuohsagAHyLzzjOWiC0I3s84Ybvzv2chpUF5g+OHflktREojuxDsqsymbYSJ00o6zjRy2fb8EgcAoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147136; c=relaxed/simple;
	bh=Plr/y0nnpxw7vLad8d4uVhj0JZF0gyuIGhMlhCurMJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHCziDUVX8dIzuQ6zKH3BpLlHh0XvaL3z4LINLxD+0y7Zjf9r+dkzAHri0FUQbTcAXlPe1tn/lP75vr8Fmmk+1PGbweSaZz66RzpdvFLwhP47QOZnSlX0SG817TDdmO8dle3/fhfQxBqkYv9Cm4dFA9J6BpRMCngMmKgy8mySls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id C6AD916050F;
	Thu,  2 Apr 2026 16:25:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 05ABE2002D;
	Thu,  2 Apr 2026 16:25:31 +0000 (UTC)
Date: Thu, 2 Apr 2026 12:26:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Wander Lairson Costa
 <wander@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RTLA changes for v7.1
Message-ID: <20260402122634.4d750f2c@gandalf.local.home>
In-Reply-To: <CAP4=nvRZ2iEVxSgwHwumgonrhdvkYiG9KsCh0S2kwBwnemMi6A@mail.gmail.com>
References: <20260327150237.405973-1-tglozar@redhat.com>
	<20260329122202.65a8b575@robin>
	<CAP4=nvRZ2iEVxSgwHwumgonrhdvkYiG9KsCh0S2kwBwnemMi6A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ob54mx698tc818piszoqac7o5nmp9cgp
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 05ABE2002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Mw2kxWZ0Wu53ynRSQzmGDlD54d0xHUkE=
X-HE-Tag: 1775147131-662878
X-HE-Meta: U2FsdGVkX19Tzt/aIYw444m9KeJI0gBH8qoB43aibR7SXo4+Katt6VeDdXYJoMazO/hQsZprtHRg3DY9f8CWc1dXaks4O9NBwVoM9SzaoFEUcuyw9WgQgAKIF5Qe03pvm0/8eiUs5wLAZACb6mkOLnC+W355phWljHcoTWUOI02K/pd//uYxB5tPz9SRC/vblkeaHvS9FJjCnfZK46LpiYUjfXy41vHbJw3zmB3QN/IIoeMippnfL0RScrj42mv+QkrB5n+1nDnjwT1IEU65/ciyPJk2FT89atd/8h6oFuKvbFC/gYu3L1vxPOxhdcOx4/Ojiy8I3zaVzkiusfdNY3t8UwUk1kme

On Thu, 2 Apr 2026 17:08:36 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> After merging the fix for 7.0 [1], there's now a context difference
> caused by commit ea06305ff9920 (tools/rtla: Remove unneeded nr_cpus
> arguments) on merging rtla-v7.1 onto the current master. The context
> difference merges cleanly via three-way merge:
> 
> $ git merge rtla-v7.1
> Auto-merging tools/tracing/rtla/src/timerlat_bpf.h
> Merge made by the 'ort' strategy.
> ...
> 
> Do you prefer me to rebase this PR on top of 7.0-rc6 once it's tagged
> or to leave the pull request as is and perhaps add a note to your PR
> to Linus the merge difference is expected?

This is fine as is. Linus is used to this. He's even OK with minor merge
conflicts. The only time you really need to tell Linus about something is
if the merge conflicts or a merge causes something to break but merges
cleanly (like removing an extra #endif)

-- Steve
