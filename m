Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF8123D7F0;
	Fri, 31 Jul 2026 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516906; cv=none; b=sxtIw3Wx1iVuaOpQeiMiDqZf28PHx0FDNqy03JorNKte0xZe/2BO00RKa1CIaRZouAegw0sV79a/bR5ekl3gFlES2Ix0iFunpYE1IcM07yXdxW+scoinwqD+SWl1JQ+6JQUu7ikplzPgCgw77IbcOd/ud/rIm1671jcszmt+IfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516906; c=relaxed/simple;
	bh=fW5vyH5VZc2vNkc8f/E6adWxcff2ZzKtX/KZ8GxQo/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NfCkGd32oWa1QhiYdJvmbfllyCEopxMiPLRS7PrqVqre7wXrRbfD6q4FPjgI1CSaZzLmtf+APgW/bwmcwtfESBpR4TOwb8HQOZrIC5nA9abpIigLklKZ0/z05R1gTGgDTsa7kra4t2y9OV4tsS44YJCkgLQfc8NlNxNfthWUupY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 0543E1C0CEF;
	Fri, 31 Jul 2026 16:54:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 7C7F42002C;
	Fri, 31 Jul 2026 16:54:55 +0000 (UTC)
Date: Fri, 31 Jul 2026 12:55:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RTLA fixes for v7.2-rc5
Message-ID: <20260731125535.01a80453@gandalf.local.home>
In-Reply-To: <CAP4=nvTtdtAU75Uj_N9mgmSLzA+LE2dES_29Ma_XVWytbOeyeA@mail.gmail.com>
References: <20260722110116.1387495-1-tglozar@redhat.com>
	<CAP4=nvTtdtAU75Uj_N9mgmSLzA+LE2dES_29Ma_XVWytbOeyeA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 7C7F42002C
X-Stat-Signature: 37w7p5tamb1ijzmff76ttcwu9u4yetby
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/dLroi4gHU0AjB4XqgXgxHWsGsS5vrdzM=
X-HE-Tag: 1785516895-813862
X-HE-Meta: U2FsdGVkX1/lOG5BWeT+MNGqyBNW4AS835+1MAH0OUOCOnghf39dW6lSUpKHFKMAoxZdfDcJztM/WC9AsuopRMXe+WkXHm5x20c+V5e4try5cJEFA0xw3ErkoUZgQIvZLUUpnEbthy9boJI3rtcwvQ5B5fnS3vDdrUOn3W+6bio7hplEqlConvN9qn/RYqO932qjw0f9zt2JHYk+YWOOgEV0QeHXVb7nR6eHAJeYGHyE0JK0/Ldaam7uqS7MpUVRvx+AJ9t2jIAdxDiB/1SV7/tnJ8VPNdBCngaoYi5UmAXpXzxKX/Ihz4M5coUZW+LVTYILXWsHGOOCcb+AlMfSdflTSkkeLGh9

On Fri, 31 Jul 2026 15:58:46 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> > RTLA fixes for v7.2-rc5
> >
> > - Fix timerlat top actions triggering on signal
> >  
> 
> Do you have any concerns about this fix, or did you just not get to it yet?

Oops, no, I thought I sent this out already. Let me do that now.

-- Steve
