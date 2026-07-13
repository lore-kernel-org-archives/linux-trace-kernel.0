Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F043E42DFF5;
	Mon, 13 Jul 2026 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783952983; cv=none; b=iErLL7jdA468bFCUpGYUGl4XJudmf7V3CODdHjTNtB8DvjxRxcUs+7qWSPKA4npnBP+ulScTRy/6FqTqgV39ac/NHsNGBO+gN5/PKe32cVgkYMY+7veIdrNqZpChZW+Uk515IWIvafrLSl5pIF9cjZsACaoI9QCYbnVQVgQE2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783952983; c=relaxed/simple;
	bh=Zc0pb295FxTx+p+5rA2U6FezXMgvUCpI5IcbT+Quidk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xv/+Ejv3tUSLwqy7nSforEZSTmnVKHzjyTr6JpyPNf8KES7o+hdiVW2klIbDRc8cqfz0zUOo4n9o/7BHs9spqt7pVGud8rFKGv6hEy9t+fuYymHjutbEqcGy9ZhCMk1E5ZsfSp+6O9TMK/q5MfW1ARhawj99Z1WUr5VTjbQH1WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 585F1140182;
	Mon, 13 Jul 2026 14:23:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 6A16F2E;
	Mon, 13 Jul 2026 14:23:42 +0000 (UTC)
Date: Mon, 13 Jul 2026 10:23:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jeongho Choi <jh1012.choi@samsung.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ji2yoon.jo@samsung.com, minki.jang@samsung.com, hajun.sung@samsung.com
Subject: Re: [BUG] tracing: Too many tries to read user space
Message-ID: <20260713102343.74baba5b@gandalf.local.home>
In-Reply-To: <20260713121659.6c8549331474337511c4f442@kernel.org>
References: <CGME20260708123754epcas2p1f15cc305ddb09f97164491d750769ef7@epcas2p1.samsung.com>
	<20260708123753.GB1386@KORCO121415.samsungds.net>
	<20260710122231.9bc9fae3dcfc72215f4a2dcd@kernel.org>
	<20260710083357.49e05ff6@gandalf.local.home>
	<20260713121659.6c8549331474337511c4f442@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8ihbmxdwerw519jd1br4ux6kfttdcjqy
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 6A16F2E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19j+2viTIVFKuXNv0kXF4pjH1Fr2n/lfHE=
X-HE-Tag: 1783952622-739595
X-HE-Meta: U2FsdGVkX1/+vBPI06538byEyAnTzfCbJEEY71yFOlN8Copwm8FRZk7SLm1/E/3v56f7vMHo+5gGgtziu5YNhFCGWAiEf1SssRzJkKPlcBeV/Oo3752O0LLrE+m0Ox9YqMqpzIL6NTyLnnS9eaNM/W+ozKAtGvCd6AFQXYVdTISRBJPquMQwyjALAayb+PybThBsgX66eMyiALB9LWynXubHm6CNXlYv/Pa6rF17MhfxBbcss29yu+3EJdynnE2jWT/Qm+CacyIjNFoKNN8WotGKvxya5sfVb1CxXX2n9Sn25L9bO+vAowQkzSeO1f/u8gtGGa2p8XX6EPsa11UsWgV0aIkZqj8BgcUjdKDEsgIhFjwNrUzdFw==

On Mon, 13 Jul 2026 12:16:59 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > I also kept this around in case it was needed. Looks like it may be needed.  
> 
> Hmm, it's not clear whether this is the result of a scheduling storm
> caused by kernel threads. But maybe worth to try.

I don't see what else it could be.

> 
> Jeongho, can you try this patch? Or/and you maybe also try using
> mlock the LMKD process memory which is passed to trace_marker.

Yes, Jeongho, can you please test this patch and also see if mlocking the
memory used by trace_marker would help too?

-- Steve
