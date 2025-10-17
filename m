Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4132ED20;
	Fri, 17 Oct 2025 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692313; cv=none; b=pFbrMR+HkgDSMhXotaXOYsh9yowYJAr7PFWu1xQdSE+QUfGXKY28M/wqGCOY2TOvwYjeiyDUj3CnWrC2D/fIs4u+otaufSYGyulUCF4gOF4SvIlgJKCRUAfVbc3WcsgtWp55jizOEVu+3OA9JX4n1Pcd8Yha3BR6mub+thhCJbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692313; c=relaxed/simple;
	bh=uYC2wxwAVvGgTVDNiX1Ux3FSlpVHASHy/4GGzQUT5Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRt4PRDIhv227OyTaQKvD6goSXXjQTcVd85KBnC596zgWsjbKVkUbUiaKJzp7SDVDbXVA93AePSlDRj0bPRhFFuGssttrxWnhdMw7I87P0Tes1s7HzX8wXR8fQN99ZJjLGXIstAEeIygc0vZp6QG+krK6LBG34JWa8W0mLOouyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 1922DACBCB;
	Fri, 17 Oct 2025 09:11:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 266B220026;
	Fri, 17 Oct 2025 09:11:47 +0000 (UTC)
Date: Fri, 17 Oct 2025 05:11:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Crystal Wood <crwood@redhat.com>, Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH v2 1/3] tools/rtla: Fix --on-threshold always triggering
Message-ID: <20251017051146.5f6a8901@batman.local.home>
In-Reply-To: <CAP4=nvSmJOdoO8q125sdzvR7ix1oVsNobSRtWb7ADUADdzEPiw@mail.gmail.com>
References: <20251007095341.186923-1-tglozar@redhat.com>
	<CAP4=nvSmJOdoO8q125sdzvR7ix1oVsNobSRtWb7ADUADdzEPiw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 266B220026
X-Stat-Signature: 5zu4637dqwbigrce7tz44t9zi7po7orh
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18JqUHJ7tYvqNpnB7K/4WNZqdbys4aWpzc=
X-HE-Tag: 1760692307-524040
X-HE-Meta: U2FsdGVkX19UZ1LNtvfFurFTE7TZxISoxjyIuoNA6zajS1JWop0iJKFqJeH8IJWnxlrT1wMI9fqLNTZls8I5RitgDAK7vpSetWeaq0Mw/6xmj0TAbu8+c3yvCpCxyHz2aNI7SnESjFjude2+whM1F+x2OXLzNdxK+eMYQQqNf6um/52eoDVXxHIv2OetnSu93qvKAzNeGKglyX/Xiy3RTslJjer7tFRsqI/qaVmN82L4HP1NY/24tUk8LByZ7+hSlVYeZmDDTxkzsUK8P1wXl4XDp1p6eZiuRqR9cEOkf46u2cTDDzmZPsKkK24U2/8mhmsyy2Pj3EvaDGmMybMuqrHxD1biSzYnkodpgTIXwPK5qybDkcHJdw==

On Fri, 17 Oct 2025 09:38:04 +0200
Tomas Glozar <tglozar@redhat.com> wrote:
> 
> It seems that this patchset containing fixes for recently merged RTLA
> code consolidation [1] has no further comments. Could you take it?
> (Unless you have any comments, of course.)
> 
> [1] https://lore.kernel.org/linux-trace-kernel/20250907022325.243930-1-crwood@redhat.com/T/

I'll take a look at it next week. I added it to my "delegate" in Patchwork:

  https://patchwork.kernel.org/project/linux-trace-kernel/list/?series=1008975

So hopefully, I don't forget.

We need to start making you the maintainer too ;-)

-- Steve
